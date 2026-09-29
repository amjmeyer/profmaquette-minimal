#import "SETUP.typ": *
#set document(title: [Démarrer])
#show: toot-page

#title[I. Démarrer]

= Importer le paquet

```typ
#import "@preview/profmaquette-minimal:0.1.0": *
```

*Dans la suite de la documentation, cette ligne est sous-entendue au début de chaque exemple.*

= Fonctionnement d'une "maquette"

#info(title: "Le principe")[
  Toute la fiche d'exercices se place dans une `#maquette(…)[…]`. Les réglages de cette maquette déterminent entièrement le fonctionnement de la maquette tout le long du document. Nous détaillerons tous les réglages possibles le moment venu, mais voyons des exemples simples.
]

#example(columns: 2, ```typ
// SETUP-COTE-A-COTE
// START
#maquette[
  #exercice(titre: "Factoriser")[
    Factoriser $x^2 - 9$.
  ]
  #corrige[$(x - 3)(x + 3)$]
]
```)

Expliquons quand même le rendu qu'on obtient ci-dessus. \
Par défaut : 
  - les corrigés sont regroupés dans un bloc « Correction » ;
  
  - le bloc " Correction " se situe sur une page après tous les exercices ; 
  
  - la clé de couleur rouge sert d'indicateur pour signifier à l'élève que l'exercice est corrigé au sein même de la fiche.

#info(title: "Comment lire un exemple dans cette documentation ?")[
  Tout le long de la documentation, un exemple illustrant le propos aura toujours la même structure : le code au-dessus et le rendu en dessous. \
  Quand la fiche occupe plusieurs pages (par exemple avec la nouvelle page de Correction), les pages sont placées côte à côte et sont coupées (pour avoir une idée du rendu, allez sur Typst en ligne et copiez le code).
]

#warning(title: "Deux manières d'écrire une maquette")[
  `#show: maquette.with(…)` en tête de fichier a le même effet que
  `#maquette(…)[…]` autour de toute la fiche. \
  On préfèrera la quasi totalité du temps la deuxième option, car elle ne nécessite pas d'inclure toute la fiche d'exercices dans des crochets. \
  Cette équivalence est rappelée à différents endroits de la documentation.
]

#example(columns: 2, ```typ
// SETUP-COTE-A-COTE
// START
#show: maquette.with()
#exercice(titre: "Factoriser")[
  Factoriser $x^2 - 9$.
]
#corrige[$(x - 3)(x + 3)$]
```)

= Les fonctions du paquet

Quasiment tout passe par `#maquette(…)[…]` ou par `#exercice(…)[…]`.\
Les paramètres de la maquette ou des exercices  sont mis entre parenthèses. \
Les réglages de la maquette s'appliquent pour toute la fiche, alors que ceux d'`#exercice(…)[…]` s'appliquent localement (c'est-à-dire uniquement sur l'exercice en question). \
Les paramètres à régler sont regroupés dans les différentes parties. \
Le paquet n'expose que ces six fonctions.

#table(
  columns: 2,
  table.header[*Fonction*][*Rôle*],
  `maquette`, [englobe la fiche et regroupe tous les réglages],
  `exercice`, [crée un énoncé numéroté (#i-link("4-exercices.typ")[partie IV])],
  `corrige`, [crée le corrigé de l'exercice qui précède (#i-link("5-corriges.typ")[partie V])],
  `thematique`, [permet de regrouper les exercices par thématiques et place une coche sur la FdR (#i-link("6-feuille-de-route.typ")[partie VI])],
  `afficher-fdr`, [affiche le schéma de la feuille de route (#i-link("6-feuille-de-route.typ")[partie VI])],
  `seyes`, [affiche une zone de réponse quadrillée, qui peut être remplacée par le corrigé dans le mode `interro` (#i-link("9-mode-interro.typ")[partie IX])],
)
