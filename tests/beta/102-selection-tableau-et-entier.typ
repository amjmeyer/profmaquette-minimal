#import "../../src/lib.typ": *
#maquette(liste-corriges: (1, "3-4"))[
  #for i in range(5) [#exercice[E] #corrige[S]]
]
#maquette(liste-corriges: 2)[
  #exercice[A] #corrige[a]
  #exercice[B] #corrige[b]
]
