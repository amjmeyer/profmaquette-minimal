// "apres-question" hors interro vaut none : seyes vierges, aucun corrigé,
// pas de clé ni de bloc « Correction ».
#import "../../src/lib.typ": *
#maquette(position-corriges: "apres-question")[
  #exercice[Question. #seyes(3)]
  #corrige[NE DOIT PAS APPARAÎTRE]
  #exercice[Sans seyes.]
  #corrige[NE DOIT PAS APPARAÎTRE NON PLUS]
]
