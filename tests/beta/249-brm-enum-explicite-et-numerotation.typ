// Questions écrites avec #enum(…) et une numérotation « a) » réglée par
// l'utilisateur, numéros imposés, et listes à puces (« - », ignorées).
#import "../../src/lib.typ": *
#set enum(numbering: "a)")
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #exercice(titre: "enum explicite", brm: (1, 2, 3))[
    #enum([Première.], [Deuxième.], [Troisième.])
  ]
  #exercice(titre: "Numéros imposés", brm: (1, 2))[
    5. Cinquième.
    9. Neuvième.
  ]
  #exercice(titre: "Puces", brm: (1, 2))[
    - Puce A
    - Puce B
  ]
]
