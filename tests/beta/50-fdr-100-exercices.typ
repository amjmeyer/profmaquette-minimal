#import "../../src/lib.typ": *
#maquette(afficher-corrige: none)[
  #afficher-fdr
  #for i in range(100) { if calc.rem(i, 12) == 0 { thematique[Thème #i] }; exercice(obligatoire: calc.rem(i, 3) != 0)[Exo] }
]
