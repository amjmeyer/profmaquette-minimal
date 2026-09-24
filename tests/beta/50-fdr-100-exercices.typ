#import "../../src/lib.typ": *
#maquette(localisation-correction: none)[
  #afficher-fdr
  #for i in range(100) { if calc.rem(i, 12) == 0 { thematique[Thème #i] }; exercice(route: calc.rem(i, 3) != 0)[Exo] }
]
