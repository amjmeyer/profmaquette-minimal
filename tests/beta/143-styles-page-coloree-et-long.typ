// Étiquette pleine et fond blanc sur une page colorée, et exercice plus haut
// qu'une page (la boîte se coupe) avec le style bandeau.
#import "../../src/lib.typ": *
#set page(fill: rgb("#fff4d6"), height: 12cm)
#maquette(style-exercice: "etiquette-pleine")[
  #exercice(titre: "Pleine", source: "S")[A]
  #exercice(route: false)[B]
]
#maquette(style-exercice: "fond-blanc")[
  #exercice(titre: "Fond blanc", entrainement: "https://a.b")[A]
]
#maquette(style-exercice: "bandeau")[
  #exercice(titre: "Long", entrainement: "https://a.b")[#for i in range(40) [Ligne #i. \ ]]
]
