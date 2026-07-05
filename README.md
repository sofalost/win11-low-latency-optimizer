# Windows 11 Low-Latency Optimizer (all-in-one)

**Current version: v3.4** — see `changelog.txt` for the full history.

> **Francophones** : ce script fonctionne aussi en français — la langue est détectée automatiquement d'après celle de ton Windows (affichage ou région).

A bilingual (EN / FR) batch project that applies a **curated, reversible** set of latency and responsiveness tweaks for competitive gaming on Windows 11. No third-party software — everything runs through native registry keys, services and scheduled tasks.

The main file is **`win11-low-latency-optimizer_v3.4.bat`** — a single self-contained all-in-one (the filename carries the version). It is self-elevating and hardware-aware: it detects your GPU vendor, RAM size, whether your CPU is an AMD X3D part and whether the machine is a desktop or laptop, then adapts. Before applying, it asks whether you need your kernel anticheat (Vanguard / FACEIT), then offers two profiles — **soft** and **lowest**.

## The all-in-one menu

Everything lives behind one start menu:

**Optimize**
- **[1]** Apply optimizations — full (tweaks + cleanup + updates)
- **[2]** Apply optimizations — fast (tweaks only)

**Standalone tweaks**
- **[3]** 0.5 ms timer + NVIDIA tweak (restores the old sharpening method) + phantom-device cleanup
- **[4]** QWERTY keyboard layout (shown only on a French system)

**System**
- **[5]** Restore all Windows defaults
- **[6]** Restore Spectre/Meltdown mitigations
- **[7]** Restore Defender real-time protection

**Tools**
- **[8]** Verification / debug
- **[0]** Quit

When you pick **[1]** or **[2]**, the script first asks whether you need your kernel anticheat (Vanguard / FACEIT), then asks for the Soft or Lowest profile.

## What it does

- **CPU / RAM** — SvcHost split threshold sized to your RAM, priority separation
- **Scheduling** — MMCSS / `SystemResponsiveness`
- **Per-game priority** — IFEO high priority for common competitive titles
- **GPU** — NVIDIA `EnableGR535=0` (restores the old sharpening method) or AMD ULPS off, MSI mode, TdrDelay
- **Input** — mouse (pointer precision off) and keyboard responsiveness
- **Network** — latency-oriented interface tweaks
- **Hosts blocklist** — ads **and** Microsoft telemetry, with a Defender exclusion so the file isn't silently reverted
- **Defender (performance)** — game folders/processes excluded, scheduled scan disabled, scans throttled
- **Security warnings** — SmartScreen and the "Open File" attachment warning suppressed for downloaded files
- **Debloat / privacy** — services trim, telemetry, camera, Xbox, OneDrive, Edge, WhatsApp, and more
- **0.5 ms timer** — persistent SYSTEM task (`NtSetTimerResolution`), re-armed at every startup; power-aware (0.5 ms on desktop / laptop-on-AC, released on laptop battery)
- **Auto-reapply** — key settings are re-applied after a Windows feature update

## Profiles and modes

- **Soft** — strong latency gains while every safety feature stays on. Safe pick if unsure.
- **Lowest** — everything Soft does, plus per-game priority, an 8 s GPU timeout and a constant timer. It **additionally** turns off Windows Defender real-time protection (only if you disabled Tamper Protection yourself first) and the Spectre/Meltdown CPU mitigations — Vanguard and FACEIT keep working without them.

**Do you need your anticheat?** — asked once, before the Soft/Lowest choice and independent of it. Answer **No** only if you don't play kernel-anticheat games: the script then turns off Virtualization-Based Security, Memory Integrity (HVCI) and the hypervisor for extra performance. They stay **on** when you answer **Yes**, because Vanguard and FACEIT rely on them. Answering No is the fastest option and the one most likely to stop those anticheats from launching.

The two choices combine freely (Soft or Lowest × anticheat Yes or No), and the apply is **idempotent**: switching modes and re-running resets anything the new mode no longer applies (Defender real-time, Spectre/Meltdown, VBS/HVCI/hypervisor), so no setting from a previous run lingers.

Everything is reversible from the menu: **[7]** re-enables Defender real-time, **[6]** restores the Spectre/Meltdown mitigations, and **[5]** restores all Windows defaults (VBS / HVCI / hypervisor included). After answering No to the anticheat question, reboot and confirm the anticheats you use still launch; if one refuses, run the matching restore.

## What it deliberately does NOT touch

Secure Boot and TPM are firmware settings the script never changes. Core Isolation / Memory Integrity / VBS / HVCI and Fast Startup stay **on** in the Soft and Lowest profiles — the kernel-level anticheats rely on them. Only answering **No** to the anticheat question turns VBS / HVCI / the hypervisor off, and a full restore puts them back.

## Counter-Strike 2 — recommended settings

The in-game and driver settings that matter most for CS2 input latency.

**Launch option** — `+r_show_build_info false` hides the build-number overlay in the bottom-left corner (nice on OLED). You can also run `r_show_build_info false` from the CS2 console.

### NVIDIA

**Without G-SYNC** (default)
- In the **NVIDIA app**, set **Low Latency Mode** to **Off**.
- In **CS2 -> Settings -> Video**, set **NVIDIA Reflex Low Latency** to **On** (not `On + Boost`).
- In **CS2 -> Settings -> Video**, set **V-Sync** to **Off**.
- If you'd rather run **uncapped**, leave the NVIDIA app frame cap off and set `fps_max 0` in CS2.

**With G-SYNC**
- In the **NVIDIA app**: **Low Latency Mode Off**, and **cap the frame rate to your monitor's refresh rate** (e.g. 240 fps on a 240 Hz panel).
- In **CS2 -> Settings -> Video**: **NVIDIA Reflex Low Latency** = **On + Boost**.
- **V-Sync**: test it **with and without** the in-game option and keep whichever feels best.

### AMD
- Install **AMD Adrenalin 25.9.1** — https://www.amd.com/en/resources/support-articles/release-notes/RN-RAD-WIN-25-9-1.html. Once on 25.9.1, this optimizer locks GPU driver updates so Windows Update won't silently replace it.
- Add one Steam launch option (CS2 -> Properties -> Launch Options): `+engine_low_latency_sleep_after_client_tick true` — not needed on NVIDIA.
- Turn **Anti-Lag 2.0** off in the AMD in-game overlay.

## Files in this repo

- **`win11-low-latency-optimizer_v3.4.bat`** — the all-in-one; **the only file you run**. It embeds the optimizer, the 0.5 ms timer + NVIDIA tweak (with phantom-device cleanup), the QWERTY tool and the read-only debug checker (menu **[8]**), and the whole UI (menus, questions, every action screen) is fully bilingual EN/FR, auto-detected.
- `DOCUMENTATION_SCRIPT_EN.txt` / `DOCUMENTATION_SCRIPT_FR.txt` — a section-by-section, honest explanation of every tweak (placebo-adjacent ones clearly flagged)
- `changelog.txt` — the full version history: every version with its detailed changes
- *(optional)* **`BLACK_W11_CURSOR.zip`** — a black Windows pointer pack. Unzip -> right-click `install.inf` -> **Install** -> apply it in Mouse settings.

## How to use

1. Save the `.bat` as **ANSI / Windows-1252** (not UTF-8) — accented characters depend on it.
2. Put it in a dedicated folder (not your Downloads folder: a full run wipes Downloads).
3. Right-click -> **Run as administrator**.
4. Pick a profile, then **reboot** (full restart, not shutdown).

Built and reviewed with [Claude.ai](https://claude.ai).
