// Thématiques dans les trois styles de fiche (arrondi-1, arrondi-2, carre) :
// alignements gauche, centre, droite, titre long sur deux lignes, couleur
// foncée (texte blanc) et claire (texte noir) ; les coches de la feuille de
// route suivent.
#import "../../src/lib.typ": *
#for style in ("arrondi-1", "arrondi-2", "carre") {
  maquette(style-maquette: style, titre-maquette: (gauche: "02", centre: style, droite: "1C SPE"))[
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
  pagebreak()
}
#for couleur in (rgb("#1f6fb2"), rgb("#f2d16b")) {
  for style in ("arrondi-1", "arrondi-2", "carre") {
    maquette(style-maquette: style, couleur-titre: couleur, titre-maquette: (gauche: "03", centre: style))[
      #thematique[Suites]
      #exercice[Énoncé.]
    ]
  }
  pagebreak()
}
// Hors maquette : style par défaut.
#thematique[Thématique hors maquette]
