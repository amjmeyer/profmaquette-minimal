// Plus de corrigés que de seyes : les corrigés en trop s'affichent en rouge
// sous l'exercice. Moins de corrigés que de seyes : les seyes restants restent
// vierges. Un seyes placé entre l'exercice et le corrigé compte aussi.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice(titre: "Un seyes, deux corrigés")[a) #seyes(2)]
  #corrige[Réponse a) dans le seyes.]
  #corrige[Réponse en trop : sous l'exercice.]

  #exercice(titre: "Trois seyes, un corrigé")[
    a) #seyes(2)
    b) (reste vierge) #seyes(2)
    c) (reste vierge) #seyes(2)
  ]
  #corrige[Réponse a).]

  #exercice(titre: "Aucun seyes")[Question.]
  #corrige[Corrigé sous l'exercice.]

  #exercice(titre: "Seyes hors du cadre")[Question.]
  #seyes(3)
  #corrige[Remplace le seyes placé après l'exercice.]
]
