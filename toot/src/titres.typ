#import "SETUP.typ": *
#set document(title: [Les titres])
#show: toot-page

#title[III. Les titres]

Une fiche peut commencer par un cartouche de titre, réglé depuis la maquette.
Il est facultatif : sans lui, rien n'est affiché, et on reste libre d'utiliser
son propre en-tête. Cette partie le présente en mode `exercices` ; en mode
`interro`, il partage la largeur avec la zone Nom / Prénom / Classe
(#i-link("mode-interro.typ")[partie IX]).

#signature("maquette(
  …
  titre-maquette: dictionary,
  style-maquette: str,
  couleur-titre: color | auto,
  …
) -> content")

#parametre("titre-maquette", ("dictionary",), `(:)`)[
  Ce paramètre permet de régler le titre de la maquette. C'est un dictionnaire avec les clés facultatives
  `gauche`, `centre` et `droite`. Rien n'est affiché si aucune des trois n'est
  donnée, sauf en mode `interro` (#i-link("mode-interro.typ")[partie IX]), où la zone Nom / Prénom /
  Classe reste affichée. Par défaut, rien n'est affiché et cet usage laisse la possibilité à l'utilisateur d'utiliser son propre template.
]

#example(```typ
// SETUP
// START
//Un exemple avec un titre
#show: maquette.with(
  titre-maquette: (
    gauche: "CH 02",
    centre: "Suites numériques",
    droite: "coucou",
  ),
)
#exercice(titre: "Premiers termes")[
  Calculer $u_1$ et $u_2$.
]
```)

#example(```typ
// SETUP
// START
//Un exemple sans titre
#show: maquette.with()
#exercice(titre: "Premiers termes")[
  Calculer $u_1$ et $u_2$.
]
```)

#parametre("style-maquette", ("str",), `"onglet"`)[
  Présentation du cartouche de titre. `onglet` est le seul style pour
  l'instant (donc la valeur par défaut). Il est inspiré du thème
  « pretty » du paquet Typst bookly (fonction `pretty-part` de son code
  source).
]

#parametre("couleur-titre", ("color", "auto"), `auto`)[
  Couleur d'accent du cartouche de titre.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  titre-maquette: (
    gauche: "CH 07",
    centre: "Espaces de Banach",
  ),
  couleur-titre: rgb("#1B3A6B"),
)
#exercice[
  Montrer que $L^(p)(X, cal(T), mu)$ est réflexif sans hypothèse pour $1 < p < + oo$.
]
```)

#info(title: "Un paramètre du cartouche peut manquer")[
  Les paramètres `gauche`, `centre` et `droite` sont toutes facultatives comme le montrent les exemples précédents.
]
