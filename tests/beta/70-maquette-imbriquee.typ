#import "../../src/lib.typ": *
// Erreur attendue : message clair.
#maquette[
  #exercice[A]
  #maquette[
    #exercice[B]
  ]
  #exercice[C]
]
