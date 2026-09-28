#import "SETUP.typ": *
#set document(title: [Démarrer])
#show: toot-page

#title[I. Démarrer]

= Importer le paquet

```typ
#import "@preview/profmaquette-minimal:0.1.0": *
```

Dans la suite de la documentation, cette ligne est sous-entendue au début de
chaque exemple.

= Fonctionnement d'une "maquette"

#info(title: "Le principe")[
  Toute la fiche d'exercices se place dans une `#maquette(…)[…]`. Les réglages de cette maquette déterminent entièrement le fonctionnement de la maquette tout le long du document. Nous détaillerons tous les réglages possibles le moment venu, mais voyons des exemples simples.
]

#example(columns: 2, ```typ
// SETUP
// START
#maquette[
  #exercice(titre: "Factoriser")[
    Factoriser $x^2 - 9$.
  ]
  #corrige[$(x - 3)(x + 3)$]
]
```)

Expliquons quand même le rendu qu'on obtient ci-dessus. Par défaut, les corrigés sont regroupés dans un bloc « Correction » qui se situe en fin de
fiche et sur une nouvelle page (par défaut, mais c'est modifiable). La clé de couleur rouge sert d'indicateur pour signifier à l'élève que l'exercice est corrigé au sein même de la fiche.

#info(title: "Comment lire un exemple dans cette documentation ?")[
  Tout le long de la documentation, un exemple illustrant le propos aura toujours la même structure : le code au-dessus et le rendu en dessous. Quand la fiche occupe plusieurs pages (par exemple avec la nouvelle page de Correction), les pages sont placées côte à côte et sont coupées (allez sur Typst en ligne et copiez le code afin d'avoir une idée du rendu !).
]

#idea(title: "Deux manières d'écrire une maquette")[
  `#show: maquette.with(…)` en tête de fichier a le même effet que
  `#maquette(…)[…]` autour de toute la fiche. Cette équivalence est rappelée à différents endroits de la documentation.
]

#example(columns: 2, ```typ
// SETUP
// START
#show: maquette.with()
#exercice(titre: "Factoriser")[
  Factoriser $x^2 - 9$.
]
#corrige[$(x - 3)(x + 3)$]
```)

= Les fonctions du paquet

Quasiment tout passe par `#maquette(…)[…]` ou par `#exercice(…)[…]`. Les paramètres de la maquette sont mis entre parenthèses. Les réglages de la maquette s'appliquent pour toute la fiche, alors que ceux d'`#exercice(…)[…]` s'appliquent localement (c'est-à-dire uniquement sur l'exercice en question). \
Les paramètres à régler sont regroupés dans les différentes parties. \
Le paquet n'expose que ces six fonctions.

#table(
  columns: 2,
  table.header[*Fonction*][*Rôle*],
  `maquette`, [englobe la fiche et regroupe tous les réglages],
  `exercice`, [un énoncé numéroté (#i-link("3-exercices.typ")[partie III])],
  `corrige`, [le corrigé de l'exercice qui précède (#i-link("4-corriges.typ")[partie IV])],
  `thematique`, [le titre d'une thématique, qui place une coche sur la feuille de route (#i-link("5-feuille-de-route.typ")[partie V])],
  `afficher-fdr`, [le schéma de la feuille de route (#i-link("5-feuille-de-route.typ")[partie V])],
  `seyes`, [une zone de réponse quadrillée, remplacée par le corrigé en interro (#i-link("4-corriges.typ")[partie IV])],
)
