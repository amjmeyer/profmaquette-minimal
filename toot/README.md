# Documentation en ligne (toot)

Documentation de _profmaquette-minimal_, construite avec
[toot](https://typst.app/universe/package/toot) (_Typst Opinionated Online Tutorial_).

- `src/SETUP.typ` : réglages communs, encadrés (`info`, `tip`, `warning`,
  `idea`), fiches de paramètres (`parametre`) et raccourcis des exemples
  (import du paquet, format de page) : `// SETUP` (largeur A4) et
  `// SETUP-COTE-A-COTE` (page étroite, pour `example(columns: 2, …)`).
- `src/OUTLINE.typ` : le menu ; seules les pages qui y figurent sont construites.
- Une page `.typ` par partie de la doc.

## Construire le site

Prérequis : le binaire `typst` dans le PATH, et `toot-builder` :
```sh
julia -e 'import Pkg; Pkg.Apps.add(url="https://codeberg.org/a5s/toot")'
```

Les exemples importent `@preview/profmaquette-minimal` : tant que le paquet
n'est pas publié, Typst doit le trouver en local. Depuis la racine du dépôt :
```sh
mkdir -p ~/.local/share/typst/packages/preview/profmaquette-minimal
ln -s "$PWD" ~/.local/share/typst/packages/preview/profmaquette-minimal/0.1.0
```

Depuis ce dossier `toot/` :
```sh
toot-builder serve   # aperçu en direct
toot-builder build   # site dans build/
```

Aperçu rapide d'une page, sans les images des exemples :
```sh
typst watch --root src --features=html --format=html src/1-demarrer.typ
```
