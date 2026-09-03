#!/usr/bin/env python3
"""Static checks for the .bat — the ones whose failure mode is SILENT.

Every rule here exists because a real bug shipped: a mangled encoding, a
PowerShell array that was one string, a label nobody could reach. cmd.exe
reports none of these; it runs the broken thing and moves on.

Usage:  python3 tools/lint.py [file.bat]      -> exit 0 = clean, 1 = errors
"""
import re
import sys
import glob

CMD_LINE_MAX = 8191


class Lint:
    def __init__(self, path):
        self.path = path
        self.errors = []
        self.warnings = []
        self.raw = open(path, "rb").read()

    def err(self, line, msg):
        self.errors.append((line, msg))

    def warn(self, line, msg):
        self.warnings.append((line, msg))

    # -- encoding -----------------------------------------------------------
    # The .bat is CP1252 + CRLF. Saved as UTF-8, every accented character
    # becomes mojibake in the console; a lone \n makes cmd mis-parse the
    # following line.
    def check_encoding(self):
        try:
            self.text = self.raw.decode("cp1252")
        except UnicodeDecodeError as e:
            self.err(0, f"not decodable as CP1252: {e}")
            self.text = self.raw.decode("cp1252", "replace")

        if self.raw.startswith(b"\xef\xbb\xbf"):
            self.err(0, "UTF-8 BOM present — cmd prints it as 'ï»¿' and the first line fails")
        if b"\xef\xbf\xbd" in self.raw:
            self.err(0, "U+FFFD replacement character — the file went through a lossy re-encode")
        if self.raw.count(b"\n") != self.raw.count(b"\r\n"):
            n = self.raw.count(b"\n") - self.raw.count(b"\r\n")
            self.err(0, f"{n} bare LF line ending(s) — the file must be CRLF throughout")

        self.lines = self.text.split("\r\n")

    # -- cmd hard limits ----------------------------------------------------
    def check_line_length(self):
        for i, l in enumerate(self.lines, 1):
            if len(l) > CMD_LINE_MAX:
                self.err(i, f"line is {len(l)} chars, cmd truncates past {CMD_LINE_MAX}")
            elif len(l) > CMD_LINE_MAX * 0.75:
                self.warn(i, f"line is {len(l)} chars, approaching the {CMD_LINE_MAX} limit")

    # -- control flow -------------------------------------------------------
    # A goto to a missing label aborts the script mid-run with a message the
    # user will not read. A label reached only by fall-through is fine.
    def check_labels(self):
        defined, dup = {}, []
        for i, l in enumerate(self.lines, 1):
            m = re.match(r"^\s*:([A-Za-z_][\w]*)\s*$", l)
            if m:
                k = m.group(1).lower()
                if k in defined:
                    dup.append((i, k, defined[k]))
                defined[k] = i
        for i, k, first in dup:
            self.err(i, f"label :{k} redefined (first at line {first}) — goto jumps to the first one")

        for i, l in enumerate(self.lines, 1):
            if re.match(r"^\s*rem\b", l, re.I):
                continue
            for m in re.finditer(r"\b(?:goto|call)\s+:?([A-Za-z_][\w]*)", l, re.I):
                t = m.group(1).lower()
                if t not in ("eof",) and t not in defined:
                    self.err(i, f"goto/call :{t} — no such label")

    # -- quoting ------------------------------------------------------------
    # An odd number of quotes on a line that invokes PowerShell means cmd
    # hands the shell a different command than the one that was written.
    def check_quotes(self):
        for i, l in enumerate(self.lines, 1):
            s = l.strip()
            if re.match(r"^\s*(rem\b|::)", s, re.I):
                continue
            if s.count('"') % 2:
                sev = self.err if "powershell" in s.lower() else self.warn
                sev(i, f"odd number of double quotes ({s.count(chr(34))})")

    # -- rem inside a parenthesised block ------------------------------------
    # `rem` is not a comment to the parser: cmd still tokenises ( ) & | < >
    # inside it, so a rem carrying one of those closes the enclosing block.
    def check_rem_in_block(self):
        depth = 0
        for i, l in enumerate(self.lines, 1):
            s = l.strip()
            if re.match(r"^rem\b", s, re.I):
                if depth > 0 and re.search(r"[()&|<>]", s):
                    self.err(i, "rem with ( ) & | < > inside a ( ) block — breaks parsing")
            else:
                q = False
                for c in l:
                    if c == '"':
                        q = not q
                    elif not q and c == "(":
                        depth += 1
                    elif not q and c == ")":
                        depth = max(0, depth - 1)
        if depth:
            self.warn(0, f"parenthesis depth ends at {depth}, expected 0")

    # -- the v3.9.1 bug, as a rule ------------------------------------------
    # In PowerShell `+` binds tighter than the `,` that separates array
    # elements, so @($env:X+'\a','b') is ONE concatenated string. Test-Path
    # then returns false for every path and the whole feature no-ops in
    # silence. Parenthesise the concatenation.
    def check_ps_array_concat(self):
        for i, l in enumerate(self.lines, 1):
            for m in re.finditer(r"@\(\s*\$env:\w+\s*\+", l):
                self.err(
                    i,
                    "@($env:X+'...','...') builds ONE string, not an array — "
                    "wrap the concatenation: @(($env:X+'...'),'...')",
                )

    # -- FR / EN string parity ----------------------------------------------
    # A string set in one language only renders as an empty span in the other:
    # the menu keeps the line and loses the words on it.
    def check_i18n_parity(self):
        blocks = self._lang_blocks()
        if blocks is None:
            self.warn(0, "could not locate the EN/FR string blocks, parity not checked")
            return
        en, fr = blocks
        for k in sorted(en - fr):
            self.err(0, f"string {k} set in EN but not in FR — blank in the French UI")
        for k in sorted(fr - en):
            self.err(0, f"string {k} set in FR but not in EN — blank in the English UI")

    def _lang_blocks(self):
        """EN runs from the `goto _strfr` branch to `goto _strdone`; FR from
        :_strfr to :_strdone. Anything before the branch is common to both."""
        find = lambda pred: next((i for i, l in enumerate(self.lines) if pred(l.strip().lower())), None)
        branch = find(lambda s: s.startswith("if") and "goto _strfr" in s)
        en_end = find(lambda s: s == "goto _strdone")
        fr_at = find(lambda s: s == ":_strfr")
        fr_end = find(lambda s: s == ":_strdone")
        if None in (branch, en_end, fr_at, fr_end):
            return None

        def names(seg):
            out = set()
            for l in seg:
                if re.match(r"^\s*rem\b", l, re.I):
                    continue
                # FR lines are guarded: if /i "!L!"=="FR" set "X=..."
                m = re.search(r'\bset\s+"([A-Za-z_][\w]*)=', l)
                if m:
                    out.add(m.group(1).upper())
            return out

        return names(self.lines[branch:en_end]), names(self.lines[fr_at:fr_end])

    # -- restore coverage ---------------------------------------------------
    # The menu promises "restore all Windows defaults". Every value the apply
    # phase writes must be handled by :RESTORE — otherwise the user is told
    # the machine is back to stock while 100+ settings are still forced.
    def check_restore_coverage(self):
        bounds = self._section_bounds()
        if bounds is None:
            self.warn(0, "could not locate the apply/:RESTORE sections, coverage not checked")
            return
        apply_seg, rest_seg = bounds

        applied = {k for k, acts in self._reg_keys(apply_seg).items() if "add" in acts}
        restored = set(self._reg_keys(rest_seg))
        # `reg delete "KEY" /f` drops the whole key, covering every value under it
        whole = [
            m.group(1).upper()
            for l in rest_seg
            for m in re.finditer(r'reg delete "([^"]+)" /f', l)
        ]

        missing = [
            (p, v)
            for p, v in sorted(applied - restored)
            # loop variables (%%E, %%V) and !VAR! are expanded at runtime, not resolvable here
            if "%%" not in p and "%%" not in v and not p.startswith("!")
            and not any(p == w or p.startswith(w + "\\") for w in whole)
        ]
        for p, v in missing:
            self.err(0, f"applied but never restored: {p} /v {v or '(default)'}")
        if missing:
            self.err(0, f"restore coverage: {len(applied) - len(missing)}/{len(applied)} values")

    # -- every apply-phase write must go through :T -------------------------
    # :T records the value the machine had before overwriting it, and :RESTORE
    # replays that journal. A raw `reg add` in the apply phase is invisible to
    # both: it is applied, and it is never given back.
    def check_journalled(self):
        bounds = self._section_bounds()
        if bounds is None:
            return
        apply_seg, rest_seg = bounds
        restored = set(self._reg_keys(rest_seg))
        for l in apply_seg:
            for m in re.finditer(r'reg add "([^"]+)"(?:\s+/v\s+("[^"]+"|\S+))?', l):
                key, val = m.group(1), (m.group(2) or "").strip('"')
                # an explicit counterpart in :RESTORE is as good as the journal
                if (key.upper(), val.upper()) in restored:
                    continue
                # the script's own state key is deleted wholesale by :RESTORE
                if key.upper().startswith("HKLM\\SOFTWARE\\LOWLATOPTIMIZER"):
                    continue
                # %%-expanded keys are loop bodies, covered by a whole-key delete
                if "%%" in key or "%%" in val:
                    continue
                self.err(
                    self.lines.index(l) + 1,
                    f"reg add outside :T — {key} /v {val or '(default)'} is applied "
                    "but not journalled, so :RESTORE cannot put it back",
                )

    def _section_bounds(self):
        find = lambda pred: next((i for i, l in enumerate(self.lines) if pred(l.strip().lower())), None)
        apply_at = find(lambda s: s.startswith("rem ===") and "[01]" in s)
        rest_at = find(lambda s: s == ":restore")
        rest_end = find(lambda s: s == ":endok")
        if None in (apply_at, rest_at, rest_end) or not (apply_at < rest_at < rest_end):
            return None
        return self.lines[apply_at:rest_at], self.lines[rest_at:rest_end]

    @staticmethod
    def _reg_keys(seg):
        """Value name per `reg add|delete "KEY" ...`. /ve and /v "" both name a
        key's default value; they must compare equal or a value written with one
        spelling and restored with the other looks unrestored."""
        out = {}
        for l in seg:
            for m in re.finditer(
                r'reg (add|delete) "([^"]+)"((?:\s+/(?:v\s+(?:"[^"]*"|\S+)|ve))*)', l
            ):
                v = re.search(r'/v\s+("[^"]*"|\S+)', m.group(3))
                name = v.group(1).strip('"').upper() if v else ""
                out.setdefault((m.group(2).upper(), name), set()).add(m.group(1))
        return out

    def run(self):
        self.check_encoding()
        for c in (
            self.check_line_length,
            self.check_labels,
            self.check_quotes,
            self.check_rem_in_block,
            self.check_ps_array_concat,
            self.check_i18n_parity,
            self.check_journalled,
            self.check_restore_coverage,
        ):
            c()
        return self.errors, self.warnings


def main():
    targets = sys.argv[1:] or sorted(glob.glob("*.bat"))
    if not targets:
        print("no .bat found")
        return 1
    rc = 0
    for path in targets:
        errors, warnings = Lint(path).run()
        print(f"\n{path}")
        for line, msg in warnings:
            print(f"  WARN  {'L%d' % line if line else '  ':>6}  {msg}")
        for line, msg in errors:
            print(f"  ERR   {'L%d' % line if line else '  ':>6}  {msg}")
        print(f"  -> {len(errors)} error(s), {len(warnings)} warning(s)")
        if errors:
            rc = 1
    return rc


if __name__ == "__main__":
    sys.exit(main())
