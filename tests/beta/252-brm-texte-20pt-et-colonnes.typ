// Texte en 20 pt, puis dans deux colonnes (place étroite).
#import "../../src/lib.typ": *
#set text(size: 20pt)
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #exercice(titre: "Grand", brm: (1.5, 2))[
    + Une question assez longue pour passer à la ligne.
    + Courte.
  ]
]
#set text(size: 11pt)
#columns(2)[
  #maquette(mode-maquette: "interro", afficher-brm: "complet", nouvelle-page-corriges: false)[
    #exercice(titre: "Étroit", brm: (1.5, 2))[
      + Une question assez longue pour passer à la ligne plusieurs fois dans la colonne.
      + Courte.
    ]
  ]
]
