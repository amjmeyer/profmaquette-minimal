#import "SETUP.typ": *
#set document(title: [Les corrigés])
#show: toot-page

#title[V. Les corrigés]

Le corrigé d'un exercice s'écrit juste après lui, avec `#corrige[…]`. Cette fonction n'admet pas de paramètre, et c'est un choix voulu : les paramètres sont tous appliqués localement sur `#exercice(…)[…]` ou alors au niveau des réglages de la maquette.
Ce sont les réglages de la `maquette` qui
décident où ils s'affichent, et lesquels s'affichent.

= Paramètres des corrigés

En voici la liste, dans l'ordre alphabétique.

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

#idea(title: "Utilisation comme prof !")[
  L'intérêt de cette combinaison est la suivante : on affiche tous les corrigés lorsqu'on est en train de préparer sa fiche d'exos : on écrit en paramètre de maquette `liste-corriges: auto`. Une fois que tout semble bon, on règle `liste-corriges` sur `()` pour imprimer un sujet seul. Ensuite, au moment de rajouter les exercices, on remet `liste-corriges` sur ce que l'on veut voir apparaître (voir plus haut), en choisissant où avec `position-corriges` (`"fin"` ou `"apres"`).
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

#warning(title: "Différences fondamentales entre pas-corrige et liste-corriges")[
  `liste-corriges` s'applique à la numérotation à l'instant _i_ de l'ordre des exercices. Si vous modifiez la position de deux exercices dans la fiche, alors ce ne sont pas les mêmes exercices qui sont corrigés. En comparaison, le paramètre `pas-corrige` est un paramètre de l'exercice, donc ne dépend pas de la localisation de l'exercice dans la fiche. Les usages de ces deux paramètres sont donc très différents.

  `pas-corrige: true`  l'emporte toujours sur  `liste-corriges`.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  position-corriges: "apres",
  liste-corriges: "1-2",
)
#exercice[Hello]
#corrige[Corrigé 1.]
#exercice(pas-corrige: true)[World]
#corrige[Corrigé 2.]
```)

#parametre("nouvelle-page-corriges", ("bool",), `true`)[
  Le bloc « Correction » commence sur une nouvelle page par défaut. Si l'on règle le paramètre sur `false`, alors il suit la
  fiche, sans saut de page.
]

#parametre("page-par-corrige", ("bool",), `false`)[
  Si ce paramètre est réglé sur `true`, chaque corrigé est écrit sur une page. Chaque corrigé démarre en haut d'une page et dispose ainsi de toute la place possible. Pour une utilisation pertinente de ce paramètre, il vaut mieux que `position-corriges` soit réglée sur `fin`.
]

#parametre("position-corriges", ("str", "bool"), `"fin"`)[
  Ce paramètre décide où afficher les corrigés sélectionnés : `"fin"` (bloc
  Correction en fin de fiche, sur une nouvelle page), `"apres"` (sous chaque
  énoncé) ou `"apres-question"` (à la place des zones `seyes`, en mode
  interro seulement : voir #i-link("mode-interro.typ")[partie IX]). `true` est aussi accepté : il vaut `"fin"`. Il ne règle jamais le
  *nombre* de corrigés affichés — pour un sujet seul (aucun corrigé), utiliser
  `liste-corriges: ()` (voir plus haut) plutôt que ce paramètre.
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

#warning(title: "Attention aux subtilités !")[
  lorsqu'on écrit `"apres"` (sans accent) ou `"fin"`, il faut mettre des guillemets, mais pas pour `true`.
]

#parametre("titre-corriges", ("content", "auto"), `auto`)[
  Ce paramètre permet de modifier le texte automatisé affiché lorsqu'un exercice corrigé est affiché.
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

= Compléter un titre

#parametre("titre-complement", ("content", "none"), `none`)[
  Le paramètre `titre-complement` est un paramètre de `#exercice`, mais puisqu'il impacte le rendu du corrigé, je le mets ici.  Il permet de compléter le titre du corrigé, après le ":"
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  position-corriges: "apres"
)
#exercice(
  titre-complement: "méthode"
)[
  Résoudre $2x = 6$.
]
#corrige[On divise par 2. Il vient  $x = 3$.]
#exercice(
  pas-corrige: true
)[
  Résoudre $3x = 12$.
]
#corrige[$x = 4$.]
```)
