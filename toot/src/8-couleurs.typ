#import "SETUP.typ": *
#set document(title: [Les couleurs])
#show: toot-page

#title[VIII. Les couleurs]

Tous les réglages de la fiche se donnent à `maquette`, en un seul endroit. Nous en avons déjà vu une bonne partie. \
Il y a deux possibilités pour définir les réglages de la maquette. Soit :

```typ
#maquette(position-corriges: "fin", liste-corriges: "1-6,9,12")[
  … la fiche …
]
```

ou, sans crochets autour de toute la fiche, en tête du fichier :

```typ
#show: maquette.with(position-corriges: "fin", liste-corriges: "1-6,9,12")
```

Si vous n'utilisez qu'une seule maquette dans votre document .typ, je conseille d'utiliser la méthode avec `#show:` qui permettra une indentation de moins tout le long du document.

Le paquet utilise quatre couleurs, chacune avec un rôle, modifiables
indépendamment les unes des autres.

#signature("maquette(
  …
  couleur-externe: color | auto,
  couleur-interne: color | auto,
  couleur-route: color | auto,
  couleur-fdr: color,
  …
) -> content")

#parametre("couleur-externe", ("color", "auto"), `auto`)[
  Couleur de ce qui mène *hors* du document : haltère, QR codes, source.
  `auto` : `rgb("#0090C8")` (cyan foncé).
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  couleur-externe: green.darken(20%)
)
#exercice(
  entrainement: "https://typst.app",
  source: "p. 12",
)[Énoncé.]
```)

#parametre("couleur-interne", ("color", "auto"), `auto`)[
  Ce paramètre détermine la couleur des éléments cliquables qui permettent de *naviguer* dans le document : la clé, et les titres « Corrigé de l'exercice N ». La valeur de `auto` est `rgb("#DC143C")`
  (Crimson, comme dans ProfMaquette).
]

#example(columns: 2, ```typ
// SETUP-COTE-A-COTE
// START
#show: maquette.with(
  position-corriges: "fin",
  vers-corrige: false,
  couleur-interne: purple
)

#exercice[Énoncé.]
#corrige[Corrigé.]
```)

#example(```typ
// SETUP
// START
#show: maquette.with(
  position-corriges: "apres",
  couleur-interne: yellow
)
#exercice[Énoncé.]
#corrige[Corrigé.]
```)

#parametre("couleur-route", ("color", "auto"), `auto`)[
  Ce paramètre gère la couleur des exercices sur la route (filet et titre). La valeur de `auto` est noire. Les
  exercices hors route, eux, restent toujours gris.
]

#example(```typ
// SETUP
// START
#show: maquette.with(couleur-route: green)
#exercice[Sur la route.]
```)

#parametre("couleur-fdr", ("color",), `black`)[
  Ce paramètre gère la couleur du schéma de la feuille de route (#i-link("6-feuille-de-route.typ")[partie VI]).
]

#example(```typ
// SETUP
// START
#show: maquette.with(couleur-fdr: orange)
#align(center, afficher-fdr)
#exercice[Énoncé 1.]
#exercice(route: false)[Hors route.]
```)

Toute couleur Typst convient : `blue`, `rgb("#1E90FF")`, `luma(40%)`,
`green.darken(20%)`… Une valeur qui n'est pas une couleur arrête la
compilation avec un message clair.
