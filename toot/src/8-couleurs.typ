#import "SETUP.typ": *
#set document(title: [Les couleurs])
#show: toot-page

#title[VIII. Les couleurs]


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
  Ce paramètre permet de modifier la couleur de ce qui mène *hors* du document : 
  
    - les haltères ;
    
    - les QR-Codes ;
    
    - les sources des exercices. 

  La valeur par défaut de ce paramètre est `rgb("#0090C8")` (cyan).
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
  Ce paramètre permet de modifier la couleur des éléments cliquables qui permettent de naviguer *au sein même* du document : 
  - les clés :
  
  - les titres « Corrigé de l'exercice N ». 
  
  La valeur par défaut de ce paramètre est `rgb("#DC143C")`.\
  (Cela correspond au Crimson dans ProfMaquette.)
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
  Ce paramètre permet de modifier la couleur des exercices sur la route (filet et titre). \
  La valeur par défaut est noire. Les
  exercices hors route, eux, restent toujours gris.
]

#example(```typ
// SETUP
// START
#show: maquette.with(couleur-route: green)
#exercice[Un exercice situé "sur la route".]
```)

#parametre("couleur-fdr", ("color",), `black`)[
  Ce paramètre gpermet de modifier la couleur du schéma de la feuille de route (#i-link("6-feuille-de-route.typ")[partie VI]).
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
