# profmaquette-minimal — repères pour Claude

Paquet **Typst** (pas LaTeX) qui génère des fiches d'exercices : portage minimaliste
du paquet LaTeX [ProfMaquette](https://ctan.org/pkg/profmaquette) de Christophe
Poulain. Code dans `src/` (un fichier par fonction publique, à la manière du
paquet fletcher), pas de build system.

## Où est quoi

- [src/lib.typ](src/lib.typ) — point d'entrée du paquet (déclaré dans `typst.toml`).
  Ne fait qu'exporter les 5 fonctions publiques ; son commentaire d'en-tête
  décrit l'organisation de `src/` et les règles de convergence : le lire en
  premier en cas de doute.
- Un fichier par fonction publique : [src/maquette.typ](src/maquette.typ),
  [src/exercice.typ](src/exercice.typ), [src/corrige.typ](src/corrige.typ),
  [src/thematique.typ](src/thematique.typ), [src/afficher-fdr.typ](src/afficher-fdr.typ).
- [src/deps.typ](src/deps.typ) — dépendances externes (seul endroit qui importe
  `@preview/tiaoma`).
- [src/interne/](src/interne/) — code partagé, jamais exporté : `etats.typ`
  (tous les `state`), `utils.typ` (sélection des corrigés, langues, `protege`…),
  `dessins.typ` (icônes, cadres, rendu d'un corrigé), `cartouche.typ` (cartouche
  de titre), `blocs-fin.typ` (« Automatismes » et « Correction »).
  Convention d'import : `etats.typ` et `utils.typ` avec `*`, les autres modules
  en nommant ce qu'on utilise.
- [src/icones/](src/icones/) — SVG Font Awesome Free (haltère, clé, coche, calculatrice).
- [toot/](toot/) — LA doc utilisateur : site web construit avec toot (voir
  `toot/README.md`), une page par partie dans `toot/src/`, menu dans
  `toot/src/OUTLINE.typ`. Aperçu : `toot-builder serve` depuis `toot/`.
- [README.md](README.md) — présentation courte.
- [tests/beta/](tests/beta/) — ~100 fichiers de non-régression, un cas par fichier
  (noms explicites : `62-selection-hors-limites.typ`…). Compilés par
  `tests/lancer.sh` (option : préfixes de noms à filtrer), sortie dans
  `tests/sortie/*.pdf` (ignoré par git).
- `docs/exemple-*.png` — les deux captures affichées dans le README (figées :
  plus de script pour les régénérer).
- `PUBLIER.md` — procédure de publication sur Typst Universe (usage ponctuel).
- `CHANGELOG.md` — historique des versions.

## API publique (exportée par `lib.typ`)

5 fonctions seulement, tout le reste de `src/` est interne :

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
définition dans `src/maquette.typ` — c'est la source de
vérité la plus à jour, à préférer à la doc `toot/` en cas de divergence
pendant un développement.

## Concepts internes à connaître avant de modifier le code

- **États (`state(...)`)** : tout ce qui doit être partagé entre les fonctions
  (couleurs, historique des exercices, réglages des corrigés…) passe par des
  `state`, jamais par des variables globales. Tous dans `src/interne/etats.typ`.
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
tests/lancer.sh           # tous les tests de non-régression (tests/beta/*.typ)
tests/lancer.sh 62 65     # seulement les tests dont le nom commence par 62 ou 65
```

Pas de suite de tests avec assertions automatiques : `tests/lancer.sh` vérifie
juste l'absence d'erreur/avertissement à la compilation ; le contrôle visuel du
rendu (PDF dans `tests/sortie/`) reste manuel.

## Pièges connus

- Changer un paramètre public de `maquette` (nom, valeurs acceptées) impacte
  potentiellement : `src/maquette.typ` (déclaration + usage + commentaire),
  `toot/src/`, `README.md` (démarrage rapide), et plusieurs fichiers de
  `tests/beta/`. Chercher le nom dans tout le dépôt avant de considérer un
  renommage terminé.
- Une seule licence LPPL pour tous les `.typ` de `src/` : même en-tête dans
  chaque fichier (« all the .typ files in the src/ directory »), à recopier tel
  quel dans tout nouveau fichier, sans le faire diverger.
