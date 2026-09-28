// Barème complet avec seyes et corrigés à la place des questions ; plus de
// notes que de questions, et questions écrites à la main (« a) ») : total
// seulement pour ces dernières.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", brm: "complet", position-corriges: "apres-question")[
  #exercice(titre: "Avec seyes", points: (1.5, 2))[
    + Calculer $u_3$. #seyes(2)
    + Calculer $v_2$. #seyes(3)
  ]
  #corrige[$u_3 = 13$.]
  #corrige[$v_2 = 9$.]
  #exercice(titre: "Trop de notes", points: (1, 1, 5))[
    + A
    + B
  ]
  #exercice(titre: "Questions à la main", points: (1, 2))[a) A #seyes(1) b) B #seyes(1)]
]
