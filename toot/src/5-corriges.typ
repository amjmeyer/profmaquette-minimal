#import "SETUP.typ": *
#set document(title: [Les corrigés])
#show: toot-page

#title[V. Les corrigés]

Le corrigé d'un exercice s'écrit juste après lui, avec `#corrige(…)[…]`. Cette fonction admet un seul paramètre, celui de compléter le titre d'un corrigé. \
Pour le reste, ce sont les réglages de la `maquette` qui
décident où ils s'affichent, et lesquels s'affichent.


#parametre("titre-complement", ("content", "none"), `none`)[
Ce paramètre complète le titre du corrigé, après le « : ». 
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  position-corriges: "apres"
)
#exercice[
  Résoudre $2x = 6$.
]
#corrige(titre-complement: "méthode")[
  On divise par 2. Il vient  $x = 3$.
]
#exercice(
  pas-corrige: true
)[
  Résoudre $3x = 12$.
]
#corrige[$x = 4$.]
```)

 

Voici la liste des paramètres de la maquette influant les corrigés, dans l'ordre alphabétique.

#signature("maquette(
  …
  liste-corriges: auto | int | str | array,
  nouvelle-page-corriges: bool,
  page-par-corrige: bool,
  position-corriges: str | bool,
  titre-corriges: content | auto,
  vers-corrige: bool,
  …
) -> content")

#parametre("liste-corriges", ("auto", "int", "str", "array"), `auto`)[
  Le paramètre `liste-corriges` permet, depuis la maquette, d'afficher une liste des exercices corrigés. Voici ce qui est pris en compte :
  #table(
    columns: 2,
    table.header[*Valeur*][*Corrigés affichés*],
    `auto`, [tous (par défaut)],
    `4`, [celui de l'exercice 4],
    `"1-6,9,12"`, [ceux des exercices 1 à 6, 9 et 12],
    `(1, "3-5")`, [ceux des exercices 1, 3, 4 et 5],
    `"route"`, [ceux des exercices sur la route],
    `"pas-route"`, [ceux des exercices hors route],
    `()`, [aucun],
  )
]

#idea(title: "Usages")[
  L'usage que j'ai de ce paramètre est le suivant : 

  + j'affiche tous les corrigés lorsque je suis en train de préparer ma fiche d'exos (afin de vérifier les typos, la mise en page, etc.) : j'écris en paramètre de la maquette `liste-corriges: auto`.

  + une fois que tout semble bon, je règle `liste-corriges:` sur `()` pour imprimer un sujet seul ; 
  
  + enfin, au moment de rajouter les exercices (pour mettre à jour la feuille sur PRONOTE par exemple), je remets `liste-corriges:` sur ce que je veux voir apparaître, en choisissant l'endroit avec `position-corriges:` (systématiquement réglé sur `"fin"`, voir plus bas).
]

#example(columns: 2, ```typ
// SETUP-COTE-A-COTE
// START
#show: maquette.with(
  position-corriges: "fin",
  liste-corriges: "1, 3-5",
)
#exercice[Énoncé 1.]
#corrige[Corrigé 1.]
#exercice[Énoncé 2.]
#corrige[Corrigé 2.]
#exercice[Énoncé 3.]
#corrige[Corrigé 3.]
#exercice[Énoncé 4.]
#corrige[Corrigé 4.]
#exercice[Énoncé 5.]
#corrige[Corrigé 5.]
```)

#warning(title: "Différences avec ProfMaquette (LaTeX)")[
  Le paramètre `liste-corriges` s'applique à la numérotation à l'instant _i_ de l'ordre des exercices. Si vous modifiez la position de deux exercices dans la fiche, alors ce ne sont pas les mêmes exercices qui sont corrigés. En comparaison, le paramètre `pas-corrige` est un paramètre intrinsèque à l'exercice, donc ne dépend pas de la localisation de cet exercice dans la fiche. Les usages de ces deux paramètres sont donc très différents. \
  `pas-corrige: true`  l'emporte toujours sur  `liste-corriges`, comme l'illustre l'exemple ci-dessous.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  position-corriges: "apres",
  liste-corriges: auto,
)
#exercice[Traduire : "Hello"]
#corrige[Bonjour.]
#exercice(pas-corrige: true)[Traduire : "World"]
#corrige[Monde.]
```)

#parametre("nouvelle-page-corriges", ("bool",), `true`)[
  Le bloc « Correction » commence sur une nouvelle page par défaut. Si l'on règle le paramètre sur `false`, alors il suit la
  fiche, sans saut de page.
]

#parametre("page-par-corrige", ("bool",), `false`)[
  Si ce paramètre est réglé sur `true`, chaque corrigé est écrit sur une page. Chaque corrigé démarre en haut d'une page et dispose ainsi de toute la place possible. Pour une utilisation pertinente de ce paramètre, il vaut mieux que `position-corriges:` soit réglée sur `fin`.
]

#parametre("position-corriges", ("str", "bool"), `"fin"`)[
  Ce paramètre décide où afficher les corrigés sélectionnés : 
  - `"fin"` place le bloc "Correction" en fin de fiche, sur une nouvelle page ; 
  
  - `"apres"` place le bloc "Correction" juste après chaque exercice ;
  
  - `"apres-question"` fonctionne uniquement en mode `"interro"` et place le corrigé à la place des zones de quadrillage. Voir #i-link("9-mode-interro.typ")[partie IX]).  
]

#example(```typ
// SETUP
// START
#maquette(position-corriges: "apres")[
  #exercice[Calculer $2 + 3$.]
  #corrige[$2 + 3 = 5$.]
]
```)

#example(```typ
// SETUP
// START
#maquette(liste-corriges: ())[
  #exercice[Calculer $2 + 3$.]
  #corrige[$2 + 3 = 5$.]
]
```)

  

#parametre("titre-corriges", ("content", "auto"), `auto`)[
  Ce paramètre permet de modifier le texte affiché lorsqu'un exercice corrigé est affiché. Cela s'applique à *tous* les corrigés.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  position-corriges: "apres",
  titre-corriges: "Solution de l'exercice"
)
#exercice[Calculer $2 + 3$.]
#corrige[$5$.]
```)

#parametre("vers-corrige", ("bool",), `true`)[
  Ce paramètre permet de faire apparaître la clé cliquable sur l'exercice lorsque le corrigé est écrit et qu'on a décidé de l'afficher. Cette clé est cliquable et mène au corrigé dans le document. En cliquant sur *Corrigé de l'exercice ...*, on retourne à l'exercice correspondant.
]

#example(columns: 2, ```typ
// SETUP-COTE-A-COTE
// START
#show: maquette.with(
  position-corriges: "fin",
  vers-corrige: false
)

#exercice[Calculer $2 + 3$.]

#corrige[$5$.]
```)

 
