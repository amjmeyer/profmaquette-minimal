#import "SETUP.typ": *
#set document(title: [Mode interro])
#show: toot-page

#title[IX. Mode interro]

Avec `mode-maquette: "interro"`, la fiche devient une évaluation : une zone
Nom / Prénom / Classe est ajoutée en tête, les questions peuvent recevoir des
zones de réponse quadrillées (`seyes`), et un barème peut s'afficher. Le même
fichier donne le sujet de l'élève et le corrigé à mettre en ligne.

#signature("maquette(
  …
  mode-maquette: \"interro\",
  largeur-cartouche: ratio,
  position-corriges: \"apres-question\",
  brm: none | str,
  …
) -> content")

= Zone Nom / Prénom / Classe

Sans `titre-maquette`, la zone s'étend sur toute la largeur :

#example(```typ
// SETUP
// START
#show: maquette.with(mode-maquette: "interro")
#exercice(titre: "Premiers termes")[
  Calculer $u_1$ et $u_2$.
]
```)

Avec un titre (#i-link("titres.typ")[partie III]), le cartouche est à gauche
et la zone à droite :

#example(```typ
// SETUP
// START
#show: maquette.with(
  mode-maquette: "interro",
  titre-maquette: (gauche: "IE 02", centre: "Suites"),
)
#exercice(titre: "Premiers termes")[
  Calculer $u_1$ et $u_2$.
]
```)

#parametre("largeur-cartouche", ("ratio",), `65%`)[
  En mode `interro`, part de la largeur prise par le cartouche de titre ; la
  zone Nom / Prénom / Classe occupe le reste, à droite. Sans effet en mode
  `exercices`, ou en `interro` sans `titre-maquette` (la zone est alors seule,
  sur toute la largeur).
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  mode-maquette: "interro",
  titre-maquette: (gauche: "IE 01", centre: "Suites"),
  largeur-cartouche: 55%,
)
#exercice[Calculer $u_1$.]
```)

= Zones de réponse : `seyes`

#signature("seyes(
  hauteur: int | float | length,
  carreau: length,
  style: str,
  vertical: bool,
) -> content")

`#seyes(…)` dessine une zone de réponse sur papier Seyes, sur toute la
largeur. On la place dans l'énoncé, sous chaque question.

#parametre("hauteur", ("int", "float", "length"), [obligatoire])[
  Un nombre de carreaux (`seyes(4)` donne 4 × 8 mm) ou une longueur (`seyes(3cm)`).
]

#parametre("carreau", ("length",), `8mm`)[
  Côté d'un carreau.
]

#parametre("style", ("str",), `"seyes"`)[
  `"seyes"` (rose et bleu pâle, comme le vrai papier), `"sobre"` (noir et
  gris) ou `"bleu"`.
]

#parametre("vertical", ("bool",), `true`)[
  `false` retire les lignes verticales (réglure Seyes pure).
]

Avec `mode-maquette: "interro"` et `position-corriges: "apres-question"`, les
corrigés prennent la place des zones de réponse : le premier `#corrige` qui
suit un exercice remplace le premier `seyes` de cet exercice, le deuxième le
deuxième, etc. On peut ainsi distribuer l'interro vierge aux élèves, puis
mettre en ligne la version corrigée en changeant un seul réglage.

#example(```typ
// SETUP
// START
#show: maquette.with(
  mode-maquette: "interro",
  position-corriges: "apres-question",
)
#exercice[
  1. #[
    a) Développer $(x + 1)^2$.
    #seyes(2)
    b) Factoriser $x^2 - 9$.
    #seyes(3)
  ]
  2. Résoudre $2x = 6$.
  #seyes(2)
]
#corrige[$x^2 + 2x + 1$]
#corrige[$(x - 3)(x + 3)$]
#corrige[$x = 3$]
```)

#info(title: "Bon à savoir")[
  - Un `#corrige` sans `seyes` correspondant s'affiche sous l'exercice ; un
    `seyes` sans corrigé reste vierge.
  - `liste-corriges` et `pas-corrige` s'appliquent comme d'habitude : un
    exercice non corrigé garde ses zones vierges.
  - Hors mode interro, `"apres-question"` n'affiche aucun corrigé : les zones
    restent vierges et il n'y a pas de bloc « Correction ».
  - La couleur du corrigé suit `couleur-interne` (rouge Crimson par défaut).
]

#warning(title: "Un fonctionnement très différent de #corrige")[
  En mode `"apres-question"`, un `#corrige` ne s'affiche pas là où on l'écrit :
  il remplace un `seyes` de l'exercice qui précède. L'association se fait par
  *position* : le k-ième `#corrige` va au k-ième `seyes`. Un corrigé oublié au
  milieu décale donc tous les suivants d'une question. Les titres de corrigés,
  la clé et le bloc « Correction » n'existent pas dans ce mode.
]

= Barème

#parametre("brm", ("none", "str"), `none`)[
  Affiche le barème, en mode `interro` seulement (sans effet en mode
  `exercices`) : `none` (rien), `"partiel"` (le total de chaque exercice, sur
  son filet en haut à droite) ou `"complet"` (le total, et la note de chaque
  question, en gris à sa droite). Les notes viennent du paramètre `points` de
  chaque exercice.
]

#parametre("points", ("int", "float", "array"), `none`)[
  Paramètre de `#exercice`. Un nombre (l'exercice est noté d'un bloc), ou un
  tableau qui suit les questions numérotées avec `+` : un nombre par question,
  un tableau pour une question à sous-questions. Par exemple,
  `(2, (1, 1.5), 3)` note 1. sur 2, 2.a) sur 1, 2.b) sur 1,5 et 3. sur 3. Le
  total (7,5) est calculé automatiquement.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  mode-maquette: "interro",
  brm: "complet",
)
#exercice(titre: "Suites", points: (2, (1, 1.5), 3))[
  + Calculer $u_0$ et $u_1$.
  + Étude de la suite.
    + Montrer qu'elle est arithmétique.
    + En déduire sa raison.
  + Calculer $u_(10)$.
]
```)

#info(title: "Bon à savoir")[
  - Seules les questions numérotées avec `+` reçoivent leur note ; des
    questions écrites à la main (« a) … ») comptent dans le total, sans note
    affichée.
  - En `"complet"`, le texte d'une question notée (et ses zones de réponse)
    s'arrête avant la note, pour ne jamais passer dessous.
]
