// Thématiques en bandeau : fond gris par défaut, puis fond foncé (texte blanc
// automatique) ; les coches de la feuille de route suivent comme en "titre".
#import "../../src/lib.typ": *
#maquette(style-thematique: "bandeau")[
  #align(center, afficher-fdr)
  #thematique[Ensembles de définition et monotonie]
  #exercice[Énoncé.]
  #exercice(route: false)[Énoncé.]
  #thematique(alignement: center)[Un peu d'équiprobabilité sous toutes ses formes]
  #exercice[Énoncé.]
]
#maquette(style-thematique: "bandeau", couleur-thematique: rgb("#1f6fb2"))[
  #align(center, afficher-fdr)
  #thematique[Suites]
  #exercice[Énoncé.]
  #thematique[Fonctions]
  #exercice[Énoncé.]
]
#maquette(couleur-thematique: purple)[
  #thematique[Titre seul, en violet]
  #exercice[Énoncé.]
]
