// Deux fiches indépendantes dans un même document : chaque `maquette` repart de
// l'exercice 1, avec sa propre feuille de route, ses propres QR codes et ses
// propres corrigés.

#import "@preview/profmaquette-minimal:0.1.0": maquette, exercice, solution, afficher-fdr, thematique

#set page(paper: "a4", margin: 1.5cm)
#set text(lang: "fr", size: 11pt)

// ─── Fiche 1 : corrigés regroupés en fin de fiche ────────────────────────────

#align(center, text(size: 16pt, weight: "bold")[Fiche 1 : second degré])

#maquette(localisation-correction: "fin")[
  #align(center, afficher-fdr)

  #thematique[Factoriser]

  #exercice(titre: "Identités remarquables", entrainement: "https://typst.app/universe")[
    Factoriser $x^2 - 9$.
  ]
  #solution[$x^2 - 9 = (x - 3)(x + 3)$.]

  #exercice(titre: "Pour aller plus loin", route: false)[
    Factoriser $4x^2 - 12x + 9$.
  ]
  #solution[$4x^2 - 12x + 9 = (2x - 3)^2$.]

  #thematique[Résoudre]

  #exercice(titre: "Équation produit")[
    Résoudre $(x - 3)(x + 3) = 0$.
  ]
  #solution[Les solutions sont $-3$ et $3$.]
]

#pagebreak()

// ─── Fiche 2 : corrigé sous chaque énoncé ────────────────────────────────────

#align(center, text(size: 16pt, weight: "bold")[Fiche 2 : suites])

#maquette(localisation-correction: "apres")[
  #align(center, afficher-fdr)

  #exercice(titre: "Premiers termes", entrainement: "https://typst.app/docs")[
    Soit $u_n = 2n + 1$. Calculer $u_0$ et $u_1$.
  ]
  #solution[$u_0 = 1$ et $u_1 = 3$.]

  #exercice(titre: "Sens de variation", route: false)[
    La suite $(u_n)$ est-elle croissante ?
  ]
  #solution[$u_(n+1) - u_n = 2 > 0$ : elle est croissante.]
]
