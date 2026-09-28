// Interro type, barème complet, seyes et sous-questions : le texte des
// questions notées s'arrête avant leur note, les zones de réponse (et les
// corrigés qui les remplacent) gardent toute la largeur du cadre.
#import "../../src/lib.typ": *
#set page(height: auto, margin: (x: 2.5cm, y: 1cm))
#show: maquette.with(mode-maquette: "interro", afficher-brm: "complet", position-corriges: "apres-question", liste-corriges: auto,
  titre-maquette: (gauche: "IE 03", centre: "Suites"))
#exercice(titre: "Suites arithmétiques", brm: (1.5, (1, 2), 1.5))[
  On considère la suite $(u_n)$ définie par $u_n = 3n - 2$.
  + Calculer $u_0$, $u_1$ et $u_(10)$.
    #seyes(3)
  + Étude de la suite.
    + Montrer que $(u_n)$ est arithmétique, en précisant soigneusement sa raison et son premier terme.
      #seyes(4)
    + En déduire le sens de variation de la suite.
      #seyes(2)
  + Déterminer le plus petit entier $n$ tel que $u_n > 100$.
    #seyes(3)
]
#corrige[$u_0 = -2$, $u_1 = 1$ et $u_(10) = 28$.]
#corrige[$u_(n+1) - u_n = 3$ : la suite est arithmétique de raison 3 et de premier terme $u_0 = -2$.]
#corrige[La raison est positive : la suite est croissante.]
#corrige[$3n - 2 > 100 <=> n > 34$ : c'est $n = 35$.]
