// La sélection s'applique : exercice 2 hors liste-corriges et exercice 3
// pas-corrige → leurs seyes restent vierges.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question", liste-corriges: "1,3")[
  #exercice[Ex 1. #seyes(2)]
  #corrige[Corrigé 1 (affiché).]
  #exercice[Ex 2. #seyes(2)]
  #corrige[Corrigé 2 : NE DOIT PAS APPARAÎTRE]
  #exercice(pas-corrige: true)[Ex 3. #seyes(2)]
  #corrige[Corrigé 3 : NE DOIT PAS APPARAÎTRE]
]
