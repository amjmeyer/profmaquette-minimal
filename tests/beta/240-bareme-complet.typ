// Barème complet : note de chaque (sous-)question, grisée à droite, et total
// de l'exercice sur le filet, dans les quatre styles de cadre.
#import "../../src/lib.typ": *
#for style in ("fond-blanc", "etiquette-encadree", "bandeau", "etiquette-pleine") {
  maquette(mode-maquette: "interro", afficher-brm: "complet", style-exercice: style)[
    #exercice(titre: "Suites", brm: (2, (1, 1.5), 3))[
      On considère la suite $(u_n)$ définie par $u_n = 2n + 1$.
      + Calculer $u_0$ et $u_1$.
      + Étude de la suite.
        + Montrer que $(u_n)$ est arithmétique.
        + En déduire sa raison, avec une phrase assez longue pour aller jusqu'au bout de la ligne et passer à la suivante.
      + Calculer $u_(10)$.
    ]
    #exercice(brm: 4)[Un exercice noté d'un seul bloc.]
  ]
  pagebreak(weak: true)
}
