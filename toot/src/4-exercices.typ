#import "SETUP.typ": *
#set document(title: [Les exercices])
#show: toot-page

#title[IV. Les exercices]

Un exercice s'écrit `#exercice(…)[…]`, avec entre parenthèses les paramètres de l'exercice et entre crochets le contenu de l'exercice. \
L'énoncé est encadré et
numéroté automatiquement, à partir de 1 dans chaque maquette. L'énoncé peut
contenir n'importe quel contenu Typst : formules, listes, figures, tableaux.
 
#signature("exercice(
  calculatrice: bool,
  entrainement: str | none,
  route: bool,
  pas-corrige: bool,
  source: content | none,
  stop: bool,
  titre: content | none, 
) -> content")

#parametre("calculatrice", ("bool",), `true`)[
  Si ce paramètre est mis sur `false`, une icône de calculatrice barrée apparaît dans le titre de
  l'exercice, pour signaler qu'elle est interdite. \
  Placé sur `true` (défaut), rien
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
  Ce paramètre permet de mettre l'adresse d'un lien en ligne et génère automatiquement un QR-Code à la fin de la page d'exercices. \
  Également, cela ajoute une haltère sur le filet droit de l'exercice. \
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

#exercice(entrainement: "https://CTAN.org")[
  Réciter la table de 5.
]
```)

#info(title: "Usages")[
  J'utilise cette fonctionnalité pour travailler les automatismes.
  + je crée des activites MathALEA sur Capytale par "automatismes associés à l'exo N":
  
  + je mets le lien Capytale vers l'activité dans `entrainement:` ;
  
  + à partir de leur fiche, les élèves scannent le QR-Code et s'entraînent en autonomie.

 On peut l'utiliser pour sans doute mille et une autres choses (pour y glisser un lien menant vers un Notebook Python depuis Capytale, un lien Codabloc sur Capytale, etc.). Pour plus d'informations sur les paramètres possibles de ces QR-Code, voir #i-link("7-entrainements.typ")[partie VII]). 
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
  #exercice[Calculer $5 times 6$.]
  #corrige[Facile ! $5 times 6 = 30$.]

  #exercice(pas-corrige: true)[
    Résoudre les équations de Navier-Stokes
  ]
  #corrige[
    Facile ! (Mais vous ne verrez jamais ma preuve !)
  ]
]
```)

#warning(title: "Différence avec ProfMaquette (LaTeX)")[
  La gestion présentée ici est reprise de ProfMaquette, le paquet LaTeX. La gestion des corrigés est locale, par exercice. Ayant beaucoup utilisé cette fonctionnalité,  j'ai trouvé cela plutôt désagréable de devoir désactiver un par un les `pas-corrige: true` lorsque nos fiches sont longues.\
  En conséquence, j'ai rajouté un paramètre global (dans les paramètres de `#maquette(…)[…]`) qui permet de gérer directement l'affichage des corrigés. Voir #i-link("5-corriges.typ")[partie V].
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

#idea(title: "Usages")[
  On peut très bien utiliser ce `source:` pour sourcer la provenance d'un exercice (un type DNB, un type BAC, un examen...). \
  Mon usage est différent : lorsque je mets un automatisme, j'utilise `source:` pour ajouter des précisions aux élèves sur ce que j'attends d'eux dans l'automatisme.
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
)[hello]
#exercice[bye]
```)

#warning(title: "Différence avec ProfMaquette (LaTeX)")[
  La gestion des `stop:` peut se faire manuellement, comme dans l'exemple ci-dessus. C'est le fonctionnement de ProfMaquette. Si vous ajoutez un `#thematique[…]` (dans le but de thématiser par thème les exercices que vous donnez dans votre fiche), alors le `stop` s'appliquera à l'endroit voulu.\
  Ci-dessous, un exemple illustre cela.
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

#exercice[Déterminer l'anneau des entiers de $KK = QQ(sqrt(2))$, noté $cal(O)_(KK)$]
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

Le paramètre `style-exercice:` de la maquette choisit l'allure des cadres, pour
toute la fiche. \
Ce n'est pas un paramètre de `#exercice(…)[…]` puisqu'il agit sur la fiche entière, mais comme il impacte le rendu direct des exercices, je préfère le mettre ici.\
Par défaut, le rendu est celui de `"fond-blanc"` \
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
