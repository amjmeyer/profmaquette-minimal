#import "../../src/lib.typ": *
#maquette(localisation-correction: "fin")[
  #afficher-fdr
  #for i in range(300) { if calc.rem(i, 20) == 0 { thematique[T#i] }; exercice(obligatoire: calc.rem(i, 4) != 0, entrainement: if calc.rem(i, 25) == 0 { "https://a.b/" + str(i) })[Exo #i]; solution[Sol #i] }
]
