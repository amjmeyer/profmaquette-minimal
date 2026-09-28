// Seyes dans une cellule de tableau et dans une grille à deux colonnes.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice[
    #table(columns: (1fr, 1fr), [Question a.], seyes(2), [Question b.], seyes(2))
    #grid(columns: (1fr, 1fr), column-gutter: 1em, seyes(3), seyes(3))
  ]
  #corrige[a)] #corrige[b)] #corrige[grille gauche] #corrige[grille droite]
]
