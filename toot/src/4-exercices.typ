#import "SETUP.typ": *
#set document(title: [Les exercices])
#show: toot-page

#title[IV. Les exercices]

Un exercice s'écrit `#exercice(…)[…]`, avec entre parenthèses les paramètres de l'exercice et entre crochets le contenu de l'exercice. \
L'énoncé est encadré et
numéroté automatiquement, à partir de 1 dans chaque maquette. L'énoncé peut
contenir n'importe quel contenu Typst : formules, listes, figures, tableaux.

= Paramètres des exercices

Pour chaque paramètre, les types de valeurs acceptés sont indiqués à côté de son nom.

#signature("exercice(
  calculatrice: bool,
  entrainement: str | none,
  route: bool,
  pas-corrige: bool,
  source: content | none,
  stop: bool,
  titre: content | none,
  body,
) -> content")

#parametre("calculatrice", ("bool",), `true`)[
  Sur `false`, une icône de calculatrice barrée apparaît dans le titre de
  l'exercice, pour signaler qu'elle est interdite. Sur `true` (défaut), rien
  ne s'affiche.
]

#example(```typ
// SETUP
// START
#maquette[
  #exercice[Calculatrice autorisée.]
  #exercice(calculatrice: false)[Calculatrice interdite.]
]
```)

#parametre("entrainement", ("str", "none"), `none`)[
  Ce paramètre permet de mettre l'adresse d'un lien en ligne et génère automatiquement un QR-Code à la fin de la page d'exercices (non modifiable). Également, cela ajoute une haltère sur le filet droit de l'exercice. \
  Cette haltère est cliquable depuis le pdf, et amène sur ledit site. Pour en savoir plus, se rendre à la #i-link("7-entrainements.typ")[partie VII].
]

#example(```typ
// SETUP
// START
#show: maquette.with()
#exercice(entrainement: "https://typst.app")[
  Réciter la table de 7.
]

#exercice[
  Réciter la table de 9.
]

#exercice(entrainement: "https://typst.app")[
  Réciter la table de 5.
]
```)

#idea(title: "Potentiels usages en classe")[
  J'utilise cette fonctionnalité pour travailler les automatismes, principalement avec Mathalea en glissant un lien Capytale vers l'activité. On peut l'utiliser pour sans doute mille et une autres choses (et, le cas échéant, on peut modifier le titre "Automatismes" en autre chose : voir la #i-link("7-entrainements.typ")[partie VII]). Pour l'élève/étudiant qui a sa feuille en version papier, cette haltère lui signifie qu'il y a des automatismes associés à cet exercice et il peut scanner le QR-Code en fin de feuille afin d'accéder au site. Si la feuille est donnée également en ligne, cliquer sur l'haltère suffit. Cette haltère a donc un double intérêt !
]

#parametre("route", ("bool",), `true`)[
  La valeur du paramètre modifie la couleur de l'entourage de l'exercice. Par défaut (`true`), la couleur du cadre est noire. Si on le met sur `false`, la couleur du cadre devient grise. \
  Également, faire passer un exercice hors route change sa position dans la feuille de route. Voir #i-link("6-feuille-de-route.typ")[partie VI]. \
  La couleur des exercices sur toute la route peut se régler une fois pour toute avec le paramètre
  `couleur-route`. Pour plus de détails, voir #i-link("8-couleurs.typ")[partie VIII].
]

#example(```typ
// SETUP
// START
#maquette[
  #exercice[Calculer $2 + 3$.]
  #exercice(route: false)[
    Calculer $2^10$.
  ]
]
```)

#parametre("pas-corrige", ("bool",), `false`)[
  Ce paramètre, s'il est réglé sur `true`, permet de ne pas afficher le corrigé d'un exercice alors même qu'il est écrit dans un `corrige` qui le suit. Pour en savoir plus, voir la #i-link("5-corriges.typ")[partie V].
]

#example(columns: 2, ```typ
// SETUP-COTE-A-COTE
// START
#maquette[
  #exercice(pas-corrige: true)[Calculer $5 times 6$.]
  #corrige[Ce corrigé ne sera jamais affiché.]

  #exercice[
    Résoudre les équations de Navier-Stokes
  ]
  #corrige[
    Facile ! (from OpenAI)
  ]
]
```)

#warning(title: "Ajout utile par rapport à ProfMaquette")[
  La gestion présentée ici des corrigés est locale, par exercice. Ayant expérimenté beaucoup, j'ai trouvé cela plutôt désagréable lorsque nos fiches sont longues. En conséquence, j'ai rajouté un paramètre global (dans les paramètres de `#maquette`) qui permet de gérer directement l'affichage des corrigés. Voir #i-link("5-corriges.typ")[partie V].
]

#parametre("source", ("content", "none"), `none`)[
  Ce paramètre permet d'afficher un petit texte posé sur le filet bas de l'exercice, à droite, de la même couleur que celui de l'haltère.
]

#example(```typ
// SETUP
// START
#show: maquette.with()
#exercice(source: "Manuel p. 42, n° 3")[
  Calculer $1/2 + 1/3$.
]
```)

#idea(title: "Potentiels usages en classe")[
  On peut très bien utiliser ce `source` pour sourcer la provenance d'un exercice (un type DNB, un type BAC, un examen...). Mon usage est différent : lorsque je mets un automatisme, j'utilise `source` pour ajouter des précisions aux élèves sur ce que j'attends d'eux dans l'automatisme.
]

#parametre("stop", ("bool",), `false`)[
  Ce paramètre permet d'arrêter la feuille de route à un endroit donné en y ajoutant une coche, juste après cet exercice. Voir #i-link("6-feuille-de-route.typ")[partie VI] pour les détails.
]

#example(```typ
// SETUP
// START
#show: maquette.with()
#align(center, afficher-fdr)
#exercice(
  route: false,
  stop: true
)[
]
#exercice[
]
```)

#warning(title: "Ajout utile par rapport à ProfMaquette")[
  La gestion des `stop` peut se faire manuellement, comme dans l'exemple ci-dessus. C'est le fonctionnement de ProfMaquette. Si vous ajoutez un `#thematique[…]` (dans le but de thématiser par thème les exercices que vous donnez dans votre fiche), alors le `stop` s'appliquera à l'endroit voulu.
]

#example(```typ
// SETUP
// START
#show: maquette.with()
#align(center, afficher-fdr)

#thematique[Calcul mental]
#exercice[Calculer $9 times 7$.]

#exercice(route: false)[
  Calculer (en posant) $1789 times 1870$.
]

#thematique[Anneaux d'entiers]

#exercice[Calculer $cal(O)_(Q[sqrt(2)])$]
```)

#parametre("titre", ("content", "none"), `none`)[
  Ce paramètre permet d'afficher un titre à l'exercice  après « Exercice N : » dans l'étiquette du cadre.
]

#example(```typ
// SETUP
// START
#show: maquette.with()
#exercice(titre: "Addition de fractions",
  calculatrice: false
)[Calculer $1/2 + 3/5$]
```)

= Le cas des exercices longs

Un exercice ne se coupe jamais entre deux pages : s'il ne tient pas en bas de
la page, il passe entièrement à la page suivante. Seul un exercice plus haut
qu'une page entière se coupe, pour ne rien perdre de l'énoncé.

= Le style des cadres

Le réglage `style-exercice` de la maquette choisit l'allure des cadres, pour
toute la fiche. \
Ce n'est pas un paramètre de `#exercice`, mais étant donné qu'il impacte le rendu direct des exercices, je préfère le mettre ici en plus. Par défaut, le rendu est celui de `fond-blanc` \
Ce réglage s'applique aussi au bloc « Automatismes ». Quatre styles
existent pour le moment :

#example(```typ
// SETUP
// START
#maquette(style-exercice: "fond-blanc")[
  #exercice[HEYYY]
  #exercice(route: false)[HEYYY]
]

#maquette(style-exercice: "bandeau")[
  #exercice[HEYYY]
  #exercice(route: false)[HEYYY]
]

#maquette(style-exercice: "etiquette-encadree")[
  #exercice[HEYYY]
  #exercice(route: false)[HEYYY]
]
#maquette(style-exercice: "etiquette-pleine")[
  #exercice[HEYYY]
  #exercice(route: false)[HEYYY]
]
```)

Chaque maquette repart de l'exercice 1, d'où les numéros identiques.
