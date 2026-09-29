#import "SETUP.typ": *
#set document(title: [Différents modes])
#show: toot-page

#title[II. Différents modes]

Une maquette fonctionne selon un mode, réglé par `mode-maquette:`. \
Pour le moment, il n'y a que deux modes : `"exercices"` et `"interro"`.

#signature("maquette(
  …
  mode-maquette: str,
  …
) -> content")

#parametre("mode-maquette", ("str",), `"exercices"`)[
  - `"exercices"` : c'est le mode de base : il permet de construire une fiche d'exercices, avec feuille de route, entraînements
    et corrigés (parties #i-link("3-exercices.typ")[IV] à
    #i-link("7-couleurs.typ")[VIII]).
  - `"interro"` : ce mode permet de créer une évaluation. \
    Elle
    ajoute (ce n'est pas réglable !) une zone 
    - Nom : $dots dots dots$
    
    - Prénom : $dots dots dots$
    
    - Classe :$dots dots dots$
    
  Ce mode est pensé pour les interrogations courtes où les élèves remplissent sur la copie directement. A ce titre, on peut y créer des zones de réponse
    quadrillées et y afficher le corrigé à la place. D'autres choses sont possibles, voir (#i-link("mode-interro.typ")[partie IX]).
]

#example(```typ
// SETUP
// START
#show: maquette.with(mode-maquette: "interro")
#exercice[
  Soit $(u_n)_(n in NN)$ définie par $u_n = - 3n + 7$. 

  Calculer $u_1$ et $u_7$.
]
```)

#warning(title: "Les corrigés d'une interro peuvent s'afficher très différemment")[
  En mode `"interro"` quand chaque (sous-)question a sa zone de réponse
  quadrillée (`#seyes(…)[…]`), les corrigés peuvent venir se placer directement dans
  ces zones au lieu de s'afficher sous
  l'exercice ou en fin de fiche. \
  Le même fichier donne alors le sujet de
  l'élève et le corrigé à mettre en ligne. \
  Je conseille tout de même de d'abord se familiariser avec le fonctionnement de `#exercice(…)[…]`, `#corrige(…)[…]` et `show: maquette.with(…)`. \
  Tout est détaillé en #i-link("mode-interro.typ")[partie IX].
]
