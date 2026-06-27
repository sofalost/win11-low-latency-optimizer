# Windows 11 Low-Latency Gaming Optimizer

> **Francophones** : ce script fonctionne aussi en français — la langue est détectée automatiquement d'après celle de ton Windows (affichage ou région).

A bilingual (EN / FR) batch script that applies a **curated, reversible** set of latency and responsiveness tweaks for competitive gaming on Windows 11.

## What it does

The script is self-elevating and hardware-aware: it detects your GPU vendor, your RAM size and whether your CPU is an AMD X3D part, if your PC is a desktop/laptop then adapts. It offers two profiles — **lowest** (aggressive) and **soft**.

Main areas covered:

- **CPU / RAM** — SvcHost split threshold sized to your RAM, priority separation
- **Scheduling** — MMCSS / `SystemResponsiveness`
- **Per-game priority** — IFEO high priority for 10 common competitive titles
- **GPU** — NVIDIA `EnableGR535=0` (or AMD ULPS off), MSI mode, TdrDelay
- **Input** — mouse (pointer precision off) and keyboard responsiveness
- **Network** — latency-oriented interface tweaks
- **Hosts blocklist** — 215 domains (ads **and** Microsoft telemetry) with a Defender exclusion so the file isn't silently reverted
- **Debloat / privacy** — services trim, telemetry, camera, Xbox, OneDrive, Edge, and more
- **0.5 ms timer** — persistent SYSTEM task (`NtSetTimerResolution`)
- **Auto-reapply** — key settings are re-applied after a Windows feature update
- **Laptop support** — Autodetected

## What it deliberately does NOT touch

Secure Boot, TPM, Core Isolation / Memory Integrity / VBS / HVCI, Fast Startup and Windows Defender all stay **on**. The script is **anticheat-safe** and **fully reversible** — a RESTORE path undoes the changes.

## Counter-Strike 2 — recommended settings

In-game and driver settings that matter most for CS2 input latency.

**Common launch option** — +r_show_build_info false (remove ingame CS2 version in bottom left corner, cool for OLED screen) (or type "r_show_build_info false" in CS2 console)

### NVIDIA
- In the **NVIDIA app**, turn **Low Latency Mode** off.
- In **CS2 → Settings → Video**, set **NVIDIA Reflex Low Latency** to **On** (not `On + Boost`).

### AMD
- Install **AMD Adrenalin 25.9.1** — official download: https://www.amd.com/en/resources/support-articles/release-notes/RN-RAD-WIN-25-9-1.html
  Once you're on 25.9.1, this optimizer locks GPU driver updates so Windows Update won't silently replace it.
- With that driver, add one Steam launch option (CS2 → Properties → Launch Options): `+engine_low_latency_sleep_after_client_tick true` — not needed on NVIDIA.
- Disable **Anti-lag 2.0** from AMD **Ingame**
  
## Files in this repo

- `win11-low-latency-optimizer.bat` — the optimizer
- `DOCUMENTATION_SCRIPT_EN.txt` / `DOCUMENTATION_SCRIPT_FR.txt` — a section-by-section, honest explanation of every tweak (including the placebo-adjacent ones, clearly flagged)
- *(optional)* a **BLACK_W11_CURSOR.zip** pack to make the Windows pointer black and a bit nicer. Unzip -> Right-click its `install.inf` -> **Install** -> Apply

## How to use

1. Save the `.bat` as **ANSI / Windows-1252** (not UTF-8) — accented characters depend on it.
2. Right-click -> **Run as administrator**.
3. Pick your profile, then **reboot** (full restart, not shutdown).

## Honesty note

This is a *curated* set, not a magic FPS button. The documentation flags which tweaks are high-impact, which are situational and which are essentially placebo, so you can decide what to keep. Built and reviewed with [Claude.ai](https://claude.ai).
