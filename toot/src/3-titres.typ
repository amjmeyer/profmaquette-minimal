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

#signature("maquette(
  …
  titre-maquette: dictionary,
  style-maquette: str,
  couleur-titre: color,
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

#parametre("style-maquette", ("str",), `"arrondi-1"`)[
  Ce paramètre choisit le style de la fiche : il règle ensemble le cartouche de
  titre et les thématiques (#i-link("6-feuille-de-route.typ")[partie VI]),
  pour qu'ils aillent ensemble.
  - `"arrondi-1"` (par défaut) : `gauche` dans un onglet posé sur un cadre
    arrondi, `centre` au milieu du cadre, `droite` à droite (d'après le thème
    « pretty » du paquet Typst bookly, fonction `#pretty-part`). Chaque
    thématique est un petit onglet posé sur un trait.
  - `"arrondi-2"` : le même cartouche ; chaque thématique est une étiquette
    arrondie suivie d'un trait fin.
  - `"carre"` : la présentation d'un en-tête de chapitre de leçon, pour que
    fiches d'exercices et leçons se ressemblent. `gauche` est un numéro, en
    gris, séparé du titre (`centre`) par un trait vertical ; `droite` (le
    niveau) s'écrit en italique, à droite, sous le titre. Chaque thématique
    est un filet : petite barre noire, titre en gras, trait gris.
]

#info(title: "Le style de la fiche décide du cartouche")[
  Le cartouche se choisit uniquement par `style-maquette` : `"arrondi-1"` et
  `"arrondi-2"` donnent le cartouche à onglet, `"carre"` l'en-tête de
  chapitre. Aucun paramètre ne permet de prendre le cartouche d'un style et
  les thématiques d'un autre : fiche, titre et thématiques restent assortis.
  (L'ancien paramètre `style-cartouche` n'existe plus.)
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

#parametre("couleur-titre", ("color",), `black`)[
  Ce paramètre donne sa couleur au style de la fiche. En `"arrondi-1"` et
  `"arrondi-2"`, il colore l'onglet, le cadre et les thématiques ; le texte
  posé sur la couleur s'écrit en blanc, ou en noir si elle est claire. En
  `"carre"`, il colore le titre et le niveau ; les filets des thématiques
  restent noirs et gris.
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
