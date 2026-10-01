#import "SETUP.typ": *
#set document(title: [Mode interro])
#show: toot-page

#title[IX. Mode interro]

Avec `mode-maquette: "interro"`, la fiche devient une évaluation : une zone
Nom / Prénom / Classe est ajoutée en tête et les questions peuvent recevoir des
zones de réponse quadrillées (`#seyes[…]`). On peut également afficher un barème (précis ou pas).\
 Le même document permet donc de mettre en forme le sujet que l'on va distribuer à l'élève, ainsi que le corrigé à mettre en ligne. Il n'y a plus besoin de faire des allers-retours entre la version élève et la version corrigée.

#signature("maquette(
  …
  mode-maquette: \"interro\",
  largeur-cartouche: ratio,
  position-corriges: \"apres-question\",
  afficher-brm: none | str,
  …
) -> content")

= Gestion de l'affichage Nom / Prénom / Classe

Sans `titre-maquette:`, la zone s'étend sur toute la largeur :

#example(```typ
// SETUP
// START
#show: maquette.with(mode-maquette: "interro")
#exercice(titre: "Premiers termes")[
  Calculer $u_1$ et $u_2$. 
]
```)

Avec un titre (#i-link("3-titres.typ")[partie III]), le cartouche est à gauche
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
  Ce paramètre permet de modifier (en mode `"interro"` seulement !) la part de la largeur prise par le cartouche de titre ; la
  zone Nom / Prénom / Classe occupe la place restante.\
  Ce paramètre est Sans effet en mode `"exercices"`.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  mode-maquette: "interro",
  titre-maquette: (gauche: "IE 01", centre: "Suites"),
  largeur-cartouche: 35%,
)
#exercice[Calculer $u_1$.]
```)
 
= Gestion de la zone de réponse : `#seyes(…)[…]`

La fonction `#seyes(…)[…]` dessine une zone de réponse sur papier Seyes, sur toute la
largeur. L'idée est de la placer dans l'énoncé, sous chaque question.

#signature("seyes(
  hauteur: int | float | length,
  carreau: length,
  style: str,
  vertical: bool,
) -> content")


#parametre("hauteur", ("int", "float", "length"), [obligatoire])[
  Ce paramètre permet de régler la hauteur de la zone de quadrillage en donnant : 
  
    - un nombre de carreaux (`seyes(4)` donne 4 carreaux de $8$ mm de haut) ; 
    
    - une longueur (`seyes(3cm)`).
]

#example(```typ
// SETUP
// START
#show: maquette.with(mode-maquette: "interro")
#exercice[
  + Calculer $9 times 4$.
    #seyes(2)

  + Calculer $6-2$.
    #seyes(1)
]
```)

#parametre("carreau", ("length",), `8mm`)[
  Ce paramètre permet de modifier la longueur du côté d'un carreau.
]

#parametre("style", ("str",), `"seyes"`)[
  Ce paramètre permet de modifier le rendu des carreaux : 
  
  - réglé sur `"sobre"`, le résultat est noir et gris ;
  
  - réglé sur `"bleu"`, le résultat est... bleu !
]

#warning(title: "Fonctionnalité à améliorer")[
  Je crois que, pour le moment, le rendu des carreaux ne rend pas bien en impression N&B sur photocopieur. La fonctionnalité sera retravaillée dans une prochaine version du paquet.
]


#parametre("vertical", ("bool",), `true`)[
  Ce paramètre permet de retirer les lignes verticales s'il est réglé sur `false`.
]

#warning(title: "Fonctionnalité à améliorer")[
  Je n'ai jamais testé cette fonctionnalité. Je l'ai reprise d'un paquet de Cédric Pierquet, #link("https://ctan.org/pkg/writeongrid")[WriteOnGrid]
]

= Gestion de la zone de corrigé à la place de `#seyes(…)[…]`

Si l'on règle le paramètre `position-corriges:` sur `position-corriges: "apres-question"`, les
corrigés prennent la place des zones de réponse. \
En revanche, la manière de faire afficher les réponses diffèrent. Voici un exemple :  

#example(```typ
// SETUP
// START
// On peut facilement modifier l'affichage des sous-questions dans Typst
#show: maquette.with(
  mode-maquette: "interro",
  position-corriges: "apres-question",
)
#exercice[
  +  
    + Développer $(x + 1)^2$.
      #seyes(2)
    
    + Factoriser $x^2 - 9$.
      #seyes(3)
  
  + Résoudre $2x = 6$.
    #seyes(2)
]
#corrige[$x^2 + 2x + 1$]
#corrige[$(x - 3)(x + 3)$] 
```)
 
#warning(title: "Un fonctionnement très différent de #corrige")[
  Lorsque l'on a activé `position-corriges: "apres-question"`, un `#corrige[…]` ne s'affiche pas là où on l'écrit :
  il remplace un `seyes[…]` de l'exercice qui précède. L'association se fait par
  *position* : le k-ième `#corrige[…]` va remplacer le k-ième `seyes[…]`. \
  Un corrigé oublié au milieu décale donc tous les suivants d'une question.\
  Les titres de corrigés, la clé et le bloc « Correction » n'existent pas dans ce mode.
]


#info(title: "Bon à savoir")[ 
  - `liste-corriges:()` permet de cacher tous les corrigés, et donc d'imprimer le sujet pour les élèves.\
    En mettant `liste-corriges: auto`, tous les corrigés apparaîssent et le document est prêt à être partagé.

  - La couleur du corrigé suit `couleur-interne` (rouge Crimson par défaut).
]

= Gestion et affichage du barème

Le barème se donne exercice par exercice (`brm`), et la maquette décide de son
affichage (`afficher-brm`).

#parametre("afficher-brm", ("none", "str"), `none`)[
  Ce paramètre permet d'afficher le barème (valable uniquement dans le mode `"interro"`). \
  Il peut prendre la valeur `"complet"` ou la valeur `"partiel"`. Cette dernière fait en sorte de ne pas afficher le détail des points à chaque question.
]

#parametre("brm", ("int", "float", "array"), `none`)[
  `brm` est un paramètre de `#exercice(…)[…]`. Il permet de donner un certain nombre de points par question.\
  Par exemple, `brm: (2, (1, 1.5), 4)` note la question 1. sur 2, la question 2.a) sur 1, la question 2.b) sur 1,5 et la question 3. sur 4.\
  Le total (7,5) est calculé automatiquement.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  mode-maquette: "interro",
  afficher-brm: "complet",
)
#exercice(titre: "Suites", brm: (2, (1, 1.5), 3))[
  + Calculer $u_0$ et $u_1$.
  + Étude de la suite.
    + Montrer qu'elle est arithmétique.
    + En déduire sa raison.
  + Calculer $u_(10)$.
]
```)

#info(title: "Bon à savoir")[
  - Une question seule avec des sous-questions s'écrit avec une virgule finale :
    `brm: ((1, 2),)`. Sans cette virgule finale, Typst lit `((1, 2))` comme `(1, 2)`,
    c'est-à-dire deux questions notées 1 et 2 (même règle qu'en Python).

  - Seules les questions numérotées avec `+` reçoivent leur note ; des
    questions écrites à la main (« a) … ») comptent dans le total, sans note
    affichée.
  - En `"complet"`, le texte d'une question notée s'arrête avant la note,
    pour ne jamais passer dessous ; ses zones de réponse (`seyes`, ou le
    corrigé qui les remplace) gardent toute la largeur du cadre.
]
