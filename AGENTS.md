# AGENTS.md — win11-low-latency-optimizer

Script batch (EN/FR) de tweaks de latence **réversibles** pour Windows 11.
Fichier unique : `win11-low-latency-optimizer_v4.0.bat` — le numéro de version est
dans le nom du fichier (version majeure = renommer le fichier + mettre à jour
README et changelog). Aucun logiciel tiers : registre, services, tâches planifiées
natives. Dépôt public, le script tourne sur les machines d'autres gens : au moindre
doute sur la réversibilité d'un tweak, on ne le livre pas.

## Format du .bat — non négociable

- CP1252 / ISO-8859, jamais de BOM, CRLF partout, lignes < 8191 caractères.
- Ne jamais passer par un outil qui réécrit en UTF-8 ou en LF. Éditer via Python :
  lire `rb` → `decode('cp1252')`, modifier, `'\r\n'.join(...)` → `encode('cp1252')`.
- Contrôle : `file *.bat` doit dire `ISO-8859 text, with CRLF line terminators`.
- Les docs (README, changelog, DOCUMENTATION_*, ce fichier) sont en UTF-8.

## Vérifications obligatoires avant commit

```bash
python3 tools/lint.py          # checks statiques, bloquant, tourne partout
python3 tools/test_journal.py  # round-trip :T sur vrai registre — Windows/CI uniquement
```

Ne jamais désactiver une règle du lint pour faire passer un patch : chacune
correspond à un bug réellement livré (réencodage UTF-8, LF nu, label mort, `rem`
avec parenthèses dans un bloc, concaténation de tableau PowerShell, trou i18n,
écriture registre sans journal ni restauration).

## Règles d'écriture

1. Toute écriture registre en phase apply passe par `call :T <clé> <valeur> <type> <donnée>`
   (journalise l'état avant ; `[5] Restore` rejoue le journal).
2. Tout apply a sa restauration (journal, plus les deletes explicites de `:RESTORE`).
3. Toute chaîne d'affichage EN a son pendant FR (`if /i "!L!"=="FR" set ...`), et
   réciproquement — sinon UI blanche dans une langue.
4. Entrée dans `changelog.txt`, section de la version courante :
   `[+]` ajout, `[~]` modif, `[x]` correction, `[-]` suppression, `i` note, `!` alerte.
5. Toute modification du menu ou des questions se répercute dans `README.md`,
   `DOCUMENTATION_SCRIPT_EN.txt` et `DOCUMENTATION_SCRIPT_FR.txt` — trois fichiers.

## Invariants métier

- Liste des jeux : une seule source, `GAMES` (chercher `LISTE DES JEUX`), lue par
  IFEO [03], la restauration, Defender [14] et les comptes `GAMESN`/`GAMESF` ;
  `GAMESRX` en est la version regex PowerShell (FSO [12], nettoyages). Ajouter ou
  retirer un jeu → toucher GAMES, GAMESRX, la découverte FSO [12], Defender [14]
  et les noms affichés dans `M3L` (EN + FR).
- **League of Legends est exclu du patch FSO/GPU [12]** : le flag plein écran
  exclusif rendait le client flou (résolution à rechanger manuellement). [12]
  nettoie activement les traces des versions antérieures. Ne pas l'y remettre.
- **IA Windows coupée sans condition à chaque run**, indépendante de la question
  VBS : Copilot (politiques HKLM + HKCU), bouton taskbar (`ShowCopilotButton=0`),
  appli Store Copilot (supprimée en [16b]), Copilot dans Edge
  (`HubsCopilotEnabled=0`), Recall (`DisableAIDataAnalysis` + FoD désinstallé,
  la restauration le réinstalle). La question VBS ne couvre que anticheat / VM / WSL2.
- Defender temps réel : jamais désactivé (déclenche `VirTool:Win32/DefenderTamperingRestore`).
- hosts (215 domaines) : exclusion Defender temporaire pendant l'écriture, retirée
  aussitôt après.

## Structure

Menu unique : [1] apply complet, [2] rapide (rejoue les réponses enregistrées dans
`HKLM\SOFTWARE\LowLatOptimizer`), [3] timer 0,5 ms + tweak NVIDIA + périphériques
fantômes, [4] clavier QWERTY (systèmes français seulement), [5] restauration
complète, [6] Spectre/Meltdown, [7] Defender temps réel, [8] périphériques,
[9] vérification/debug, [0] quitter. Détection matérielle en tête : GPU, RAM,
X3D, portable/fixe.

## Déploiement

`deploy.yml` = `workflow_dispatch` manuel : commit et push de l'arbre tel quel,
après `checks.yml` (lint sur Ubuntu, test journal sur `windows-latest`).
