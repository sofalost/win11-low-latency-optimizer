# Windows 11 Low-Latency Gaming Optimizer

> **Francophones** : ce script fonctionne aussi en français — la langue est détectée automatiquement d'après celle de ton Windows (affichage ou région).

A bilingual (EN / FR) batch script that applies a **curated, reversible** set of latency and responsiveness tweaks for competitive gaming on Windows 11.

## What it does

The script is self-elevating and hardware-aware: it detects your GPU vendor, your RAM size and whether your CPU is an AMD X3D part, then adapts. It offers two profiles — **lowest** (aggressive) and **soft**.

Main areas covered:

- **CPU / RAM** — SvcHost split threshold sized to your RAM, priority separation, prefetcher / superfetch
- **Scheduling** — MMCSS / `SystemResponsiveness`, network throttling index, Nagle neutralized
- **Per-game priority** — IFEO high priority for 10 common competitive titles
- **GPU** — NVIDIA `EnableGR535=0` (or AMD ULPS off), MSI mode, TdrDelay
- **Input** — mouse (pointer precision off) and keyboard responsiveness
- **Network** — latency-oriented interface tweaks
- **Hosts blocklist** — 215 domains (ads **and** Microsoft telemetry) with a Defender exclusion so the file isn't silently reverted
- **Debloat / privacy** — services trim, telemetry, camera, Xbox, OneDrive, Edge, and more
- **0.5 ms timer** — persistent SYSTEM task (`NtSetTimerResolution`)
- **Auto-reapply** — key settings are re-applied after a Windows feature update

## What it deliberately does NOT touch

Secure Boot, TPM, Core Isolation / Memory Integrity / VBS / HVCI, Fast Startup and Windows Defender all stay **on**. The script is **anticheat-safe** and **fully reversible** — a RESTORE path undoes the changes.

## Files in this repo

- `LOW_LATENCY_GAMING_SCRIPT.bat` — the optimizer
- `DOCUMENTATION_SCRIPT_EN.txt` / `DOCUMENTATION_SCRIPT_FR.txt` — a section-by-section, honest explanation of every tweak (including the placebo-adjacent ones, clearly flagged)
- *(optional)* a **black cursor pack** to make the Windows pointer black and a bit nicer. Right-click its `install.inf` -> **Install**, then pick the scheme in *Settings -> Bluetooth & devices -> Mouse -> Additional mouse settings -> Pointers*.

## How to use

1. Save the `.bat` as **ANSI / Windows-1252** (not UTF-8) — accented characters depend on it.
2. Right-click -> **Run as administrator**.
3. Pick your profile, then **reboot** (full restart, not shutdown).

## Honesty note

This is a *curated* set, not a magic FPS button. The documentation flags which tweaks are high-impact, which are situational and which are essentially placebo, so you can decide what to keep. Built and reviewed with [Claude.ai](https://claude.ai).
