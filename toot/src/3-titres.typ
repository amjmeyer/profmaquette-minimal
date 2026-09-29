#import "SETUP.typ": *
#set document(title: [Les titres])
#show: toot-page

#title[III. Les titres]

Une fiche peut commencer par un cartouche de titre, réglé depuis la maquette.\
Il est facultatif : sans lui, rien de plus ne s'affiche et on reste libre d'utiliser
son propre en-tête. \
Cette partie présente le paramètre `titre-maquette` en mode `"exercices"` ; en mode
`"interro"`, cela varie un peu avec la zone Nom / Prénom / Classe. Voir
(#i-link("9-mode-interro.typ")[partie IX]).

#signature("maquette(
  …
  titre-maquette: dictionary,
  style-cartouche: str,
  couleur-titre: color | auto,
  …
) -> content")

#parametre("titre-maquette", ("dictionary",), `(:)`)[
  Ce paramètre permet de régler le titre de la maquette. C'est un dictionnaire avec les clés facultatives
  `gauche`, `centre` et `droite`. Rien n'est affiché si aucune des trois n'est
  donnée, sauf en mode `interro` (#i-link("9-mode-interro.typ")[partie IX]), où la zone Nom / Prénom /
  Classe reste affichée. \
  Par défaut, rien n'est affiché et cet usage laisse la possibilité à l'utilisateur d'utiliser son propre template.
]

#example(```typ
// SETUP
// START
//Un exemple avec un titre
#show: maquette.with(
  titre-maquette: (
    gauche: "02 : Exercices",
    centre: "Suites numériques",
    droite: "coucou",
  ),
) 
#exercice[Calculer $9 times 9$.]
```)

#example(```typ
// SETUP
// START
//Un exemple sans titre
#show: maquette.with()
#exercice[Calculer $9 times 9$.]
```)

#parametre("style-cartouche", ("str",), `"onglet"`)[
  Ce paramètre influe sur la mise en forme du cartouche de titre. \
  Puisqu'il n'y a qu'un seul style pour
  l'instant, ce paramètre est inutile.  
  - Le mode `"onglet"` (celui par défaut) est inspiré du thème
    « pretty » du paquet Typst bookly (fonction `#pretty-part` de son code
    source).
]

#example(```typ
// SETUP
// START
//Exemple n'illustrant rien pour le moment !! 
#show: maquette.with(
  style-cartouche: "onglet",
  titre-maquette: ( 
    centre: "bjr",
    droite: "hello",
  ),
)  
```)



#parametre("couleur-titre", ("color", "auto"), `auto`)[
  Ce paramètre met en couleur le cartouche de titre.
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
  Montrer que $L^(p)(X, cal(T), mu)$ est réflexif sans hypothèse sur $mu$ pour $1 < p < + oo$.
]
```)

#info(title: "Un paramètre du cartouche peut manquer")[
  Les paramètres `gauche`, `centre` et `droite` sont tous facultatifs comme le montre les exemples précédents.
]
