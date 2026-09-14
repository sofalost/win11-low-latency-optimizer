# win11-low-latency-optimizer

Script batch tout-en-un (EN/FR) qui applique un jeu de tweaks de latence **réversibles**
sur Windows 11. Aucun logiciel tiers : registre, services et tâches planifiées natifs.

Fichier unique : `win11-low-latency-optimizer_v4.0.bat` (~3100 lignes). Le numéro de
version est **dans le nom du fichier** — une nouvelle version majeure renomme le
fichier et met à jour `README.md` + `changelog.txt`.

## Contraintes de format — non négociables

Le `.bat` doit rester :

- **CP1252 / ISO-8859**, jamais UTF-8, jamais de BOM. Un BOM fait afficher `ï»¿` par
  cmd et casse la première ligne.
- **CRLF partout.** Un seul LF nu fait échouer le lint.
- Lignes < 8191 caractères (cmd tronque au-delà, silencieusement).

Les éditeurs modernes réécrivent volontiers en UTF-8/LF. Après toute édition,
vérifier : `file *.bat` doit dire `ISO-8859 text, with CRLF line terminators`.

## Vérifier avant de committer

```bash
python3 tools/lint.py          # checks statiques sur le .bat
python3 tools/test_journal.py  # round-trip journal — Windows uniquement
```

`lint.py` tourne partout ; `test_journal.py` exerce `:T` et `:RESTORE` contre un vrai
registre, donc il ne tourne qu'en CI (`windows-latest`). Les deux sont bloquants pour
`deploy.yml`.

Ce que `lint.py` attrape — **tous ces modes d'échec sont silencieux**, cmd n'en signale
aucun et le dégât n'apparaît que sur la machine de l'utilisateur :

- encodage / BOM / LF nus / caractère de remplacement U+FFFD
- longueur de ligne
- label redéfini, `goto`/`call` vers un label inexistant
- `rem` contenant `( ) & | < >` à l'intérieur d'un bloc `( )` — casse le parsing
- concaténation de tableau PowerShell qui produit une seule chaîne
- **parité i18n** : toute chaîne définie en EN doit l'être en FR, et réciproquement.
  Sinon l'UI est blanche dans une des deux langues.
- **couverture de restauration** : toute valeur appliquée doit avoir sa restauration
- **journalisation** : toute écriture doit passer par le journal

Ces règles existent parce que chacune correspond à un bug qui a été livré. N'en
désactive aucune pour faire passer un patch : corrige le patch.

## Écrire un nouveau tweak

1. Passer par la routine de journalisation (`:T`) — jamais de `reg add` direct. Sans
   journal, `[5] Restore all Windows defaults` ne peut pas défaire le changement.
2. Ajouter la restauration correspondante, sinon `check_restore_coverage` échoue.
3. Ajouter les **deux** chaînes, EN et FR.
4. Entrée dans `changelog.txt` avec la bonne pastille (`[+]` ajout, `[~]` modif,
   `[x]` correction, `[-]` suppression).
5. `python3 tools/lint.py` avant de committer.

## Structure du menu

Un seul menu d'entrée : `[1]` complet, `[2]` rapide (réutilise les réponses du dernier
run complet), `[3]` timer 0,5 ms + tweak NVIDIA + nettoyage périphériques fantômes,
`[4]` clavier QWERTY (affiché seulement en système français), `[5]` restauration
complète, `[6]` Spectre/Meltdown, `[7]` Defender temps réel, `[8]` périphériques,
`[9]` vérification/debug, `[0]` quitter.

Le script détecte GPU (vendeur, discret ou intégré), RAM, CPU X3D, portable ou fixe,
et adapte. Il demande d'abord si l'anticheat kernel (Vanguard / FACEIT) est nécessaire,
puis si la virtualisation / l'IA le sont, puis propose les profils **soft** et **lowest**.

Toute modification du menu se répercute dans `README.md`, `DOCUMENTATION_SCRIPT_EN.txt`
et `DOCUMENTATION_SCRIPT_FR.txt` — trois fichiers, pas un.

## Déploiement

`deploy.yml` est un `workflow_dispatch` manuel : il commit et pousse l'arbre tel quel,
après avoir passé `checks.yml`. Lancé depuis l'onglet Actions de GitHub, avec un
message de commit en entrée.

Ce dépôt est public et le script touche au registre d'autres machines. Une régression
n'est pas récupérable côté utilisateur : quand un doute subsiste sur la réversibilité
d'un tweak, ne pas le livrer.
