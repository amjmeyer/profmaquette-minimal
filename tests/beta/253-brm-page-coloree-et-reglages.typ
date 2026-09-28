// Page colorée, set block/text de l'utilisateur, couleur de route.
#import "../../src/lib.typ": *
#set page(fill: rgb("#fff4d6"))
#set block(fill: yellow, stroke: green)
#set text(fill: navy)
#maquette(mode-maquette: "interro", afficher-brm: "complet", couleur-route: rgb("#1B3A6B"))[
  #exercice(titre: "Réglages", brm: (1, 2))[
    + A #block[bloc utilisateur]
    + B
  ]
]
