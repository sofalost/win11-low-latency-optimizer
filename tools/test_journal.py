#!/usr/bin/env python3
"""Runs the .bat's own :T subroutine under cmd.exe and checks what it records.

lint.py proves :T is *called* everywhere; this proves :T is *correct*. It
extracts the real subroutine from the shipped .bat — not a copy that can drift —
and exercises the cases that broke during development: a value name containing a
space (a naive `tokens=1,2,*` captured the type as the data), a value written
twice (only the first write holds the machine's true original), and data
containing the `|` the journal uses as its own separator.

Needs cmd.exe: run on Windows, or from WSL. Skips cleanly anywhere else.

Usage:  python3 tools/test_journal.py [file.bat]     -> exit 0 = pass
"""
import re
import shutil
import subprocess
import sys
import glob
import os

KEY = r"HKCU\SOFTWARE\LowLatOptimizerSelfTest"


def extract(path, label):
    """Pull one :label ... goto :eof block out of the .bat, verbatim."""
    text = open(path, "rb").read().decode("cp1252")
    lines = text.split("\r\n")
    start = next((i for i, l in enumerate(lines) if l.strip() == ":" + label), None)
    if start is None:
        sys.exit(f"FAIL: no :{label} in {path} — the journal subroutine is missing")
    end = next(i for i in range(start, len(lines)) if lines[i].strip() == "goto :eof")
    return "\r\n".join(lines[start : end + 1])


HARNESS = r"""@echo off
setlocal EnableDelayedExpansion
set "JRN=%TEMP%\llo_selftest.csv"
del /f /q "!JRN!" >nul 2>&1
type nul >"!JRN!"
set "K=""" + KEY + r""""
reg delete "%K%" /f >nul 2>&1

rem the machine's pre-existing state, which a restore must give back
reg add "%K%" /v Plain /t REG_SZ /d "ORIGINAL" /f >nul 2>&1
reg add "%K%" /v "With Space" /t REG_DWORD /d 7 /f >nul 2>&1
reg add "%K%" /v Piped /t REG_SZ /d "a|b|c" /f >nul 2>&1
reg add "%K%" /v Expand /t REG_EXPAND_SZ /d "%%SystemRoot%%\notepad.exe" /f >nul 2>&1

call :T "%K%" "Plain" REG_SZ "overwritten"
call :T "%K%" "Plain" REG_SZ "overwritten twice"
call :T "%K%" "With Space" REG_DWORD "99"
call :T "%K%" "Piped" REG_SZ "clobbered"
call :T "%K%" "Expand" REG_EXPAND_SZ "C:\elsewhere"
call :T "%K%" "Absent" REG_DWORD "1"

echo ---JOURNAL---
type "!JRN!"
echo ---END---
reg delete "%K%" /f >nul 2>&1
goto :eof

"""

# key|value|state|type|data  — what :T must have written, in order
EXPECTED = [
    (KEY, "Plain", "SET", "REG_SZ", "ORIGINAL"),
    (KEY, "With Space", "SET", "REG_DWORD", "0x7"),
    (KEY, "Piped", "SET", "REG_SZ", "a|b|c"),
    (KEY, "Expand", "SET", "REG_EXPAND_SZ", r"%SystemRoot%\notepad.exe"),
    (KEY, "Absent", "ABSENT", "", ""),
]


def win_temp():
    for p in ("/mnt/c/Windows/Temp", r"C:\Windows\Temp"):
        if os.path.isdir(p):
            return p
    return None


def main():
    # highest-versioned .bat by default, so this keeps testing the shipped
    # script after a version bump instead of pinning itself to v4
    key = lambda p: [int(n) for n in re.findall(r"\d+", p)] or [0]
    target = (sys.argv[1:] or sorted(glob.glob("*.bat"), key=key)[-1:])[0]
    cmd = shutil.which("cmd.exe")
    tmp = win_temp()
    if not cmd or not tmp:
        print("SKIP: no cmd.exe reachable — this test needs Windows or WSL")
        return 0

    script = HARNESS + extract(target, "T")
    local = os.path.join(tmp, "llo_selftest.bat")
    open(local, "wb").write(script.replace("\n", "\r\n").replace("\r\r\n", "\r\n").encode("cp1252"))

    out = subprocess.run(
        [cmd, "/c", r"C:\Windows\Temp\llo_selftest.bat"],
        capture_output=True, text=True, errors="replace",
    ).stdout
    os.remove(local)

    m = re.search(r"---JOURNAL---(.*?)---END---", out, re.S)
    if not m:
        print("FAIL: harness produced no journal\n" + out)
        return 1
    # split into exactly 5 fields: the data field is last and may itself
    # contain the '|' the journal separates on, so it must not be split
    got = [tuple((l.split("|", 4) + ["", "", "", "", ""])[:5])
           for l in (x.strip() for x in m.group(1).splitlines()) if l]

    ok = True
    # a second write of the same value must NOT add a row: the first capture is
    # the only one holding what the machine looked like before we touched it
    if len(got) != len(EXPECTED):
        print(f"FAIL: {len(got)} journal rows, expected {len(EXPECTED)} "
              "(a repeated write must not be journalled twice)")
        ok = False
    for want, have in zip(EXPECTED, got):
        if want != have:
            print(f"FAIL: expected {want}\n         got {have}")
            ok = False
    if ok:
        print("PASS: :T records the original value, once, intact")
    ok &= roundtrip(target, cmd, tmp)
    return 0 if ok else 1


REPLAY = r"""@echo off
setlocal EnableDelayedExpansion
set "JRN=%TEMP%\llo_roundtrip.csv"
del /f /q "!JRN!" >nul 2>&1
type nul >"!JRN!"
set "K=""" + KEY + r""""
reg delete "%K%" /f >nul 2>&1

rem the state a restore has to reproduce exactly
reg add "%K%" /v Words /t REG_SZ /d "three words here" /f >nul 2>&1
reg add "%K%" /v Piped /t REG_SZ /d "a|b|c" /f >nul 2>&1
reg add "%K%" /v "With Space" /t REG_DWORD /d 7 /f >nul 2>&1
reg add "%K%" /v Expand /t REG_EXPAND_SZ /d "%%SystemRoot%%\notepad.exe" /f >nul 2>&1
echo ---BEFORE---
reg query "%K%"

call :T "%K%" "Words" REG_SZ "clobbered"
call :T "%K%" "Piped" REG_SZ "clobbered"
call :T "%K%" "With Space" REG_DWORD "99"
call :T "%K%" "Expand" REG_EXPAND_SZ "C:\elsewhere"
call :T "%K%" "Added" REG_DWORD "1"

rem ---- the replay, copied verbatim from :RESTORE ----
if exist "!JRN!" (
    for /f "usebackq tokens=1-4,* delims=|" %%a in ("!JRN!") do (
        if "%%c"=="ABSENT" (
            reg delete "%%a" /v "%%b" /f >nul 2>&1
        ) else (
            reg add "%%a" /v "%%b" /t %%d /d "%%e" /f >nul 2>&1
        )
    )
)
echo ---AFTER---
reg query "%K%"
echo ---END---
reg delete "%K%" /f >nul 2>&1
goto :eof

"""


def roundtrip(target, cmd, tmp):
    """Apply then restore: the registry must come back byte-identical.

    This is the promise the menu makes ("restore Windows defaults"), so it is
    the one worth testing end to end — a journal that records perfectly but
    replays wrong would still leave the machine altered.
    """
    script = REPLAY + extract(target, "T")
    local = os.path.join(tmp, "llo_roundtrip.bat")
    open(local, "wb").write(script.replace("\n", "\r\n").replace("\r\r\n", "\r\n").encode("cp1252"))
    out = subprocess.run(
        [cmd, "/c", r"C:\Windows\Temp\llo_roundtrip.bat"],
        capture_output=True, text=True, errors="replace",
    ).stdout
    os.remove(local)

    def snap(tag):
        m = re.search(r"---%s---(.*?)---" % tag, out, re.S)
        return sorted(l.strip() for l in m.group(1).splitlines()
                      if l.strip() and "REG_" in l) if m else None

    before, after = snap("BEFORE"), snap("AFTER")
    if before is None or after is None:
        print("FAIL: round-trip harness produced no snapshot\n" + out)
        return False
    if before != after:
        print("FAIL: restore did not reproduce the original state")
        for l in before:
            if l not in after:
                print(f"  lost:  {l}")
        for l in after:
            if l not in before:
                print(f"  extra: {l}")
        return False
    print(f"PASS: apply then restore returns all {len(before)} values unchanged")
    return True


if __name__ == "__main__":
    sys.exit(main())
