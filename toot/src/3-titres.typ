#import "SETUP.typ": *
#set document(title: [Les titres])
#show: toot-page

#title[III. Les titres]

Une fiche peut commencer par un cartouche de titre, réglé depuis la maquette.\
Il est facultatif : sans lui, rien de plus ne s'affiche et on reste libre d'utiliser
son propre en-tête. \
Son contenu se donne avec `titre-maquette` ; sa présentation n'a pas de
réglage propre : elle découle du style de la fiche, `style-maquette`. \
Cette partie présente le paramètre `titre-maquette` en mode `"exercices"` ; en mode
`"interro"`, cela varie un peu avec la zone Nom / Prénom / Classe. Voir
(#i-link("9-mode-interro.typ")[partie IX]).

#signature(
  "maquette(
  …
  titre-maquette: dictionary,
  style-maquette: str,
  couleur-titre: color,
  …
) -> content",
)

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

#parametre("style-maquette", ("str",), `"arrondi-1"`)[
  Ce paramètre choisit le style de la fiche : il règle ensemble le cartouche de
  titre et les thématiques (#i-link("6-feuille-de-route.typ")[partie VI]),
  pour qu'ils aillent ensemble.
  - `"arrondi-1"` (par défaut)
  - `"arrondi-2"`
  - `"carre"`
]

#info(title: "Le style de la fiche décide du cartouche")[
  L'ancien paramètre `style-cartouche` n'existe plus.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  style-maquette: "carre",
  titre-maquette: (
    gauche: "05",
    centre: "EXERCICES : Second degré",
    droite: "1C SPE",
  ),
)
#thematique[Équations]
#exercice[Résoudre $x^2 - 5x + 6 = 0$.]
```)


#example(```typ
// SETUP
// START
#show: maquette.with(
  style-maquette: "arrondi-1",
  titre-maquette: (
    gauche: "05",
    centre: "EXERCICES : Second degré",
    droite: "1C SPE",
  ),
)
#thematique[Équations]
#exercice[Résoudre $x^2 - 5x + 6 = 0$.]
```)


#example(```typ
// SETUP
// START
#show: maquette.with(
  style-maquette: "arrondi-2",
  titre-maquette: (
    gauche: "05",
    centre: "EXERCICES : Second degré",
    droite: "1C SPE",
  ),
)
#thematique[Équations]
#exercice[Résoudre $x^2 - 5x + 6 = 0$.]
```)


#parametre("couleur-titre", ("color",), `black`)[
  Ce paramètre donne sa couleur au style de la fiche. En `"arrondi-1"` et
  `"arrondi-2"`, il colore l'onglet, le cadre et les thématiques ; le texte
  posé sur la couleur s'écrit en blanc, ou en noir si elle est claire. En
  `"carre"`, il colore le titre, le niveau, ainsi que la barre et le trait des
  thématiques ; en noir (par défaut), le trait reste gris.
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

#thematique[Structure des espaces $L_p$]

#exercice[
  Montrer que $L^(p)(X, cal(T), mu)$ est réflexif sans hypothèse sur $mu$ pour $1 < p < + oo$.
]
```)

#info(title: "Un paramètre du cartouche peut manquer")[
  Les paramètres `gauche`, `centre` et `droite` sont tous facultatifs comme le montre les exemples précédents.
]
