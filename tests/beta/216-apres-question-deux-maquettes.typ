// Deux interros corrigées dans un même document, couleur interne changée dans
// la seconde, en anglais : les corrigés ne se mélangent pas d'une fiche à
// l'autre, l'étiquette est traduite.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice[Fiche 1. #seyes(2)]
  #corrige[Réponse fiche 1.]
]
#pagebreak()
#maquette(mode-maquette: "interro", position-corriges: "apres-question", couleur-interne: rgb("#B00020"), langue: "en")[
  #exercice[Sheet 2. #seyes(2) #seyes(2)]
  #corrige[Answer sheet 2, a).]
  #corrige[Answer sheet 2, b).]
]
