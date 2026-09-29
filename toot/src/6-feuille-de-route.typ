#import "SETUP.typ": *
#set document(title: [La feuille de route])
#show: toot-page

#title[VI. La feuille de route]

La feuille de route montre à l'élève le classement des exercices de la fiche d'exercices en deux catégories distinctes.  

= Afficher le schéma

`#afficher-fdr` dessine le schéma de tous les exercices de la maquette. \
On le place en général avant le premier exercice, centré avec
`#align(center, afficher-fdr)`.

Les exercices sont alors distingués en deux genres : il y a ceux du haut et ceux du bas. 

- Les exercices sur la route (`route: true`) forment la *route du bas* ;

- Les exercices hors route (`route: false`) sont sur la *ligne du haut* ;

- Les disques blancs rejoignent la coche avec les disques noirs.

#example(```typ
// SETUP
// START
#maquette[
  #align(center, afficher-fdr)
  #exercice[Énoncé 1.]
  #exercice(route: false)[
    Énoncé 2.
  ]
  #exercice[Énoncé 3.]
]
```)

La couleur du schéma se règle avec `maquette(couleur-fdr: …)`, voir (#i-link("8-couleurs.typ")[partie VIII]). Si la route est
plus large que la page, elle passe à la ligne entre deux thématiques.

#idea(title: "Usages")[
  Me concernant, j'utilise ces FdR pour regrouper les exercices par thématiques, puis en désignant la liste des exercices que l'on va corriger en classe comme étant ceux qui sont sur la route, et ceux qu'on ne corrigera pas en blanc, hors route. \
  Ce fonctionnement avec le schéma laisse la liberté à l'enseignant de l'utiliser (ou pas) comme bon lui semble !
]

= Thématiques et coches

Une fiche se découpe souvent en thématiques : « Factoriser », « Résoudre »…
`#thematique[…]` écrit le titre d'une thématique, et *ferme la thématique
précédente* : sur la feuille de route, une coche suit son dernier exercice.\ 
Une coche finale termine toujours la route.

#example(```typ
// SETUP
// START
#show: maquette.with()

#align(center, afficher-fdr)

#thematique[Factoriser]
#exercice[Factoriser $9x -12$.]
#exercice(route: false)[
  Factoriser $4x^2 + 6x$.
]
#thematique[Résoudre]
#exercice[Résoudre $3x^2 - 4x + 6$.]
```)


#info(title: "Indépendances avec les titres")[
  `#thematique[…]` n'est pas un `heading` : les réglages de titres du document ne la modifient pas.\
  Les différentes thématiques n'apparaîssent donc pas dans
  une table des matières, et les titres ordinaires (`=`, `==`…) n'ont aucun
  effet sur la feuille de route.
]

= Calcul des coches

Les coches découpent la route en *tronçons*. Dans chaque tronçon :

- les exercices sont numérotés dans l'ordre de la branche à laquelle ils appartiennent ;

- la ligne du haut redescend sur la route à la coche du tronçon.

Un exemple se schéma un peu plus grand que juste deux ou trois exercices.

#example(```typ
// SETUP
#show: c => box(width: 100%, height: 1.6cm, clip: true, block(width: 100%, height: 25cm, c))
// START
#let obl = exercice[…]
#let fac = exercice(route: false)[…]
#maquette[
  #align(center, afficher-fdr)
  #thematique[Première thématique]
  #obl #obl #fac #fac #obl #obl #fac #obl   // exercices 1 à 8
  #thematique[Seconde thématique]
  #obl #obl #fac #fac #fac #fac             // exercices 9 à 14
]
```)

#tip(title: "Une coche à la main")[
  Si vous ne souhaitez pas utiliser ces thématiques, vous pouvez utiliser `stop` (voir #i-link("4-exercices.typ")[partie IV]) : `exercice(stop: true)[…]` ajoute une coche juste après cet exercice, sans
  thématique.
]
