// Interro corrigée : chaque #corrige remplace, dans l'ordre, un seyes de
// l'exercice qui précède (1.a) → 1er seyes, 1.b) → 2e…), quelle que soit sa
// taille. Pas de clé, pas de bloc « Correction ».
#import "../../src/lib.typ": *
#maquette(
  mode-maquette: "interro",
  position-corriges: "apres-question",
  titre-maquette: (gauche: [Interro 3], centre: [Fonctions affines], droite: [Seconde]),
)[
  #exercice(titre: "Lecture graphique")[
    1. #[
      a) Donner l'image de 2.
      #seyes(2)
      b) Résoudre $f(x) = 0$.
      #seyes(4)
    ]
    2. Dresser le tableau de variations de $f$.
    #seyes(6)
  ]
  #corrige[$f(2) = 5$.]
  #corrige[$f(x) = 0 <=> 2x + 1 = 0 <=> x = -1/2$.]
  #corrige[
    #table(columns: 2, [$x$], [$-oo$ #h(3em) $+oo$], [$f$], [croissante])
  ]

  #exercice[
    Question unique.
    #seyes(3)
  ]
  #corrige[Réponse unique, un peu plus longue que la grille ne l'était peut-être pas.]
]
