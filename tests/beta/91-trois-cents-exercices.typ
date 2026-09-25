#import "../../src/lib.typ": *
#maquette(position-corriges: "fin")[
  #afficher-fdr
  #for i in range(300) { if calc.rem(i, 20) == 0 { thematique[T#i] }; exercice(route: calc.rem(i, 4) != 0, entrainement: if calc.rem(i, 25) == 0 { "https://a.b/" + str(i) })[Exo #i]; corrige[Sol #i] }
]
