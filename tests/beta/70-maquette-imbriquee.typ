// Erreur voulue : maquette dans une maquette.
#import "../../src/lib.typ": *
#maquette[
  #exercice[A]
  #maquette[
    #exercice[B]
  ]
  #exercice[C]
]
