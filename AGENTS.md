# profmaquette-minimal — repères pour les agents de code

Paquet Typst de fiches d'exercices, portage minimaliste du paquet LaTeX
ProfMaquette (Christophe Poulain). Tout est en français (noms, clés,
commentaires, doc).

## Où est quoi

- `src/lib.typ` : point d'entrée. Son en-tête décrit l'organisation de `src/`
  et les règles de convergence : **le lire en premier**.
- API publique : 6 fonctions, une par fichier de `src/` (`maquette`,
  `exercice`, `corrige`, `thematique`, `afficher-fdr`, `seyes`). Tout le
  reste (`src/interne/`) est interne.
- Les paramètres de `maquette` sont documentés en commentaire avant sa
  définition (`src/maquette.typ`) : c'est la source de vérité, avant `toot/`.
- `toot/` : la doc utilisateur (site toot, une page par partie dans
  `toot/src/`, menu `OUTLINE.typ`). Aperçu : `toot-builder serve` depuis `toot/`.
- `tests/beta/` : un cas par fichier, compilés par `tests/lancer.sh` (absence
  d'erreur et d'avertissement seulement ; le rendu, dans `tests/sortie/`, se
  contrôle à l'œil).
- `docs/exemple-*.png` : images du README, produites par
  `docs/generer-exemples.sh` à partir du « Démarrage rapide » du README. Le
  relancer après toute modification de ce code ou du rendu.

## Règles à ne pas casser

- **Convergence** (cause la plus probable d'une régression incompréhensible) :
  `state.update(…)` toujours hors `context`, avec des valeurs fixes ; la mise
  en page ne dépend jamais du résultat d'une `query` ; boîtes mesurées à la
  volée (`layout`, `measure`), jamais à compteur ou état.
- Tout ce qui est partagé passe par un `state`, tous dans
  `src/interne/etats.typ`.
- `protege(…)` neutralise `block`/`box` pour le rendu interne sans toucher aux
  `set block`/`set box` de l'utilisateur.
- Imports : `etats.typ` et `utils.typ` avec `*`, les autres modules en
  nommant ce qu'on utilise.
- Licence LPPL : même en-tête dans chaque `.typ` de `src/` (« all the .typ
  files in the src/ directory »), recopié tel quel dans tout nouveau fichier.

## Pièges connus

- Renommer un paramètre public de `maquette` touche `src/maquette.typ`
  (déclaration, usage, commentaire), `toot/src/`, le README et des tests :
  chercher le nom dans tout le dépôt avant de considérer le renommage fini.
- `seyes` ne lit `etat-profondeur` que pour une réponse affichée
  (`afficher: true`) : cet état change en fin de maquette, et le lire dans
  chaque `seyes` empêche la convergence d'un exercice plus haut qu'une page
  (test 226). Même effet pour tout état lu par `seyes` et modifié en fin de
  maquette (essayé avec `etat-reglages-corriges`).
