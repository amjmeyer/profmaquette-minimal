# profmaquette-minimal — repères pour Claude

Paquet **Typst** (pas LaTeX) qui génère des fiches d'exercices : portage minimaliste
du paquet LaTeX [ProfMaquette](https://ctan.org/pkg/profmaquette) de Christophe
Poulain. Tout le code est dans deux fichiers `.typ`, pas de build system.

## Où est quoi

- [src/lib.typ](src/lib.typ) — point d'entrée du paquet (déclaré dans `typst.toml`).
  Ne fait qu'exporter les 5 fonctions publiques depuis `exercices.typ`.
- [src/exercices.typ](src/exercices.typ) — **tout le code** (~1200 lignes), organisé
  en sections numérotées (chercher `// ══` pour naviguer) :
  1. Couleurs, 2. États internes, 3. Outils internes, 4. Éléments graphiques,
  5. API publique et fonctions internes.
  Le long commentaire en tête de fichier (avant la section 1) est la doc de
  référence de l'architecture : la lire en premier en cas de doute.
- [src/icones/](src/icones/) — SVG Font Awesome Free (haltère, clé, coche, calculatrice).
- [docs/manuel.typ](docs/manuel.typ) → compilé en `docs/manuel.pdf`, LE manuel
  utilisateur complet (tous les réglages + exemple/rendu pour chacun). Long
  (~1300 lignes) : préférer ce fichier-ci pour une vue d'ensemble rapide.
- [README.md](README.md) — présentation courte + lien vers le manuel PDF.
- [examples/exemple.typ](examples/exemple.typ) — exemple minimal complet.
- [tests/beta/](tests/beta/) — ~100 fichiers de non-régression, un cas par fichier
  (noms explicites : `62-selection-hors-limites.typ`…). Compilés par
  `tests/lancer.sh` (option : préfixes de noms à filtrer), sortie dans
  `tests/sortie/*.pdf` (ignoré par git).
- `tester.sh` — compile `examples/*.typ` et `docs/manuel.typ` comme si le paquet
  était publié (simule `@preview/profmaquette-minimal` via `--package-path`).
- `PUBLIER.md` — procédure de publication sur Typst Universe (usage ponctuel).
- `CHANGELOG.md` — historique des versions.

## API publique (exportée par `lib.typ`)

5 fonctions seulement, tout le reste de `exercices.typ` est interne :

- `maquette(...)[body]` — englobe toute la fiche, un seul appel règle tout
  (couleurs, corrigés, style des cadres, langue, cartouche de titre…). Ajoute
  automatiquement en fin de fiche le bloc « Automatismes » (QR codes) puis
  « Correction ». Chaque `maquette` repart de zéro (pas d'héritage entre deux
  maquettes d'un même document) et ne peut pas en contenir une autre.
- `exercice(...)[body]` — un énoncé, numéroté automatiquement.
- `corrige[body]` — le corrigé de l'exercice qui précède immédiatement.
- `thematique[titre]` — titre de thématique (contenu, pas une fonction sur `body`) ;
  ferme le tronçon courant de la feuille de route.
- `afficher-fdr` — contenu (pas une fonction, s'utilise sans parenthèses) qui
  dessine le schéma de la feuille de route.

Tous les paramètres de `maquette` sont documentés en commentaire juste avant sa
définition dans `exercices.typ` (autour de la ligne 1040) — c'est la source de
vérité la plus à jour, à préférer à `docs/manuel.typ` en cas de divergence
pendant un développement.

## Concepts internes à connaître avant de modifier le code

- **États (`state(...)`)** : tout ce qui doit être partagé entre les fonctions
  (couleurs, historique des exercices, réglages des corrigés…) passe par des
  `state`, jamais par des variables globales. Voir section 2 de `exercices.typ`.
- **Convergence** : Typst recompile au plus 5 fois pour stabiliser les requêtes
  (`query`). La chaîne « clé d'exercice → corrigé → mesure de boîte » est longue :
  les `state.update(...)` se font toujours **hors** `context`, avec des valeurs
  fixes ; la mise en page ne doit jamais dépendre du résultat d'une requête.
  Casser cette règle fait diverger la compilation (boucle qui ne se stabilise
  jamais) — piège le plus probable en cas de régression difficile à comprendre.
- **`protege(...)`** : neutralise `block`/`box` pour le rendu interne du paquet
  (cadres, icônes) sans affecter le contenu de l'utilisateur, qui garde ses
  propres réglages `set block(...)`/`set box(...)`.
- **Boîtes mesurées à la volée** (`layout`, `measure`) plutôt que des boîtes à
  compteur/état (comme l'ancien `showybox`), qui empêchaient la convergence dès
  qu'un document contenait plusieurs maquettes.
- **Échelle** (`echelle()`) : les éléments de taille fixe (icônes, feuille de
  route, titres) grossissent avec la taille du texte au-delà de 11 pt, jamais
  ne rapetissent.

## Workflow de dev

```bash
./tester.sh              # compile examples/*.typ + docs/manuel.typ (comme publié)
./tester.sh --images     # + régénère docs/exemple-*.png (captures du README)
tests/lancer.sh           # tous les tests de non-régression (tests/beta/*.typ)
tests/lancer.sh 62 65     # seulement les tests dont le nom commence par 62 ou 65
```

Pas de suite de tests avec assertions automatiques : `tests/lancer.sh` vérifie
juste l'absence d'erreur/avertissement à la compilation ; le contrôle visuel du
rendu (PDF dans `tests/sortie/`) reste manuel.

## Pièges connus

- Changer un paramètre public de `maquette` (nom, valeurs acceptées) impacte
  potentiellement : `src/exercices.typ` (déclaration + usage + commentaire),
  `docs/manuel.typ`, `examples/exemple.typ`, et plusieurs fichiers de
  `tests/beta/`. Chercher le nom dans tout le dépôt avant de considérer un
  renommage terminé.
- Le fichier consiste en une seule licence LPPL commune à `lib.typ` et
  `exercices.typ` (voir l'en-tête des deux fichiers) : ne pas la dupliquer/diverger.
