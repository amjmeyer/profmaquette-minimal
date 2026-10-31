// Thématiques en filet (barre noire, titre en gras, trait gris) : alignements
// gauche, centre, droite, titre long sur deux lignes, trait coloré ; les coches
// de la feuille de route suivent.
#import "../../src/lib.typ": *
#maquette[
  #align(center, afficher-fdr)
  #thematique[Ensembles de définition et monotonie]
  #exercice[Énoncé.]
  #exercice(route: false)[Énoncé.]
  #thematique(alignement: center)[Un peu d'équiprobabilité sous toutes ses formes]
  #exercice[Énoncé.]
  #thematique(alignement: right)[À droite]
  #exercice[Énoncé.]
  #thematique[Un titre de thématique très long, qui ne tient pas sur une seule ligne de la page et passe donc à la ligne]
  #exercice[Énoncé.]
]
#maquette(couleur-thematique: rgb("#1f6fb2"))[
  #align(center, afficher-fdr)
  #thematique[Suites]
  #exercice[Énoncé.]
  #thematique[Fonctions]
  #exercice[Énoncé.]
]
