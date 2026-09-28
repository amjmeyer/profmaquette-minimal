// Seyes en mode "apres" et "fin" : grilles vierges, corrigés à leur place
// habituelle.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres")[
  #exercice[Question. #seyes(2)]
  #corrige[Corrigé sous l'exercice.]
]
#maquette(mode-maquette: "interro", position-corriges: "fin", nouvelle-page-corriges: false)[
  #exercice[Question. #seyes(2)]
  #corrige[Corrigé en fin de fiche.]
]
