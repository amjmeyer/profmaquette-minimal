#import "SETUP.typ": *
#set document(title: [Différents modes])
#show: toot-page

#title[II. Différents modes]

Une maquette fonctionne selon l'un de deux modes, réglé par `mode-maquette`.

#signature("maquette(
  …
  mode-maquette: str,
  …
) -> content")

#parametre("mode-maquette", ("str",), `"exercices"`)[
  - `"exercices"` : une fiche d'exercices, avec feuille de route, entraînements
    et corrigés (parties #i-link("3-exercices.typ")[IV] à
    #i-link("7-couleurs.typ")[VIII]).
  - `"interro"` : une évaluation, comme celles de ProfMaquette (clé IE). Elle
    ajoute une zone Nom / Prénom / Classe, et peut recevoir des zones de réponse
    quadrillées et un barème (#i-link("mode-interro.typ")[partie IX]).
]

#example(```typ
// SETUP
// START
#show: maquette.with(mode-maquette: "interro")
#exercice(titre: "Premiers termes")[
  Calculer $u_1$ et $u_2$.
]
```)

#warning(title: "Les corrigés d'une interro peuvent s'afficher très différemment")[
  En mode `interro`, quand chaque (sous-)question a sa zone de réponse
  quadrillée (`seyes`), les corrigés peuvent venir se placer directement dans
  ces zones (`position-corriges: "apres-question"`), au lieu de s'afficher sous
  l'exercice ou en fin de fiche. Le même fichier donne alors le sujet de
  l'élève et le corrigé à mettre en ligne. Tout est détaillé en
  #i-link("mode-interro.typ")[partie IX].
]
