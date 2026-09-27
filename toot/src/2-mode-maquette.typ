#import "SETUP.typ": *
#set document(title: [Différents modes])
#show: toot-page

#title[II. Différents modes]

Le paquet permet de définir un `mode` à la maquette, et on peut appliquer des paramètres qui influent sur ces modes.

#signature("maquette(
  …
  mode-maquette: str,
  titre-maquette: dictionary,
  style-maquette: str,
  couleur-titre: color | auto,
  …
) -> content")

#parametre("mode-maquette", ("str",), `"exercices"`)[
  Pour le moment, il n'y a que deux modes à la maquette : `exercices` et `interro`. Le mode interro ajoute juste Nom / Prénom / Classe à compléter à la main, comme les évaluations de
  ProfMaquette (clé IE).
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  mode-maquette: "interro",
  titre-maquette: (
    gauche: "CH 02",
    centre: "Suites",
    droite: "",
  ),
)
#exercice(titre: "Premiers termes")[
  Calculer $u_1$ et $u_2$.
]
```)

Sans `titre-maquette`, le mode "interro" affiche quand même la zone Nom /
Prénom / Classe, en pleine largeur :

#example(```typ
// SETUP
// START
#show: maquette.with(mode-maquette: "interro")
#exercice(titre: "Premiers termes")[
  Calculer $u_1$ et $u_2$.
]
```)

#parametre("titre-maquette", ("dictionary",), `(:)`)[
  Ce paramètre permet de régler le titre de la maquette. C'est un dictionnaire avec les clés facultatives
  `gauche`, `centre` et `droite`. Rien n'est affiché si aucune des trois n'est
  donnée, sauf en mode `interro` (ci-dessus), où la zone Nom / Prénom /
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
