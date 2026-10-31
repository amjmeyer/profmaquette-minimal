// Cartouche du style "carre" (comme l'en-tête des leçons) : complet, couleur
// par défaut (noire) puis navy, clés manquantes, titre long, mode interro (zone
// Nom / Prénom / Classe à droite, même hauteur), texte plus grand (échelle).
#import "../../src/lib.typ": *
#set page(paper: "a4", margin: 1.5cm)
#set text(lang: "fr", size: 10pt)

#let titre = (gauche: "05", centre: "EXERCICES : Second degré (2/2)", droite: "1C SPE")

#maquette(style-maquette: "carre", titre-maquette: titre)[
  #exercice[Énoncé.]
]
#maquette(style-maquette: "carre", titre-maquette: titre, couleur-titre: navy)[
  #exercice[Énoncé.]
]
#maquette(style-maquette: "carre", titre-maquette: (centre: "Sans numéro ni niveau"))[
  #exercice[Énoncé.]
]
#maquette(style-maquette: "carre", titre-maquette: (gauche: "07", droite: "T COMP"))[
  #exercice[Sans titre.]
]
#maquette(style-maquette: "carre", titre-maquette: (droite: "Niveau seul"))[
  #exercice[Énoncé.]
]
#maquette(
  style-maquette: "carre",
  titre-maquette: (gauche: "12", centre: "Un titre de chapitre très long qui ne tient pas sur une seule ligne", droite: "1C SPE"),
)[
  #exercice[Énoncé.]
]
#pagebreak()
#maquette(style-maquette: "carre", mode-maquette: "interro", titre-maquette: titre)[
  #exercice[Énoncé.]
]
#maquette(style-maquette: "carre", mode-maquette: "interro", titre-maquette: (centre: "Suites"), couleur-titre: rgb("#364438"))[
  #exercice[Énoncé.]
]
#set text(size: 14pt)
#maquette(style-maquette: "carre", titre-maquette: titre)[
  #exercice[Texte en 14 pt.]
]
