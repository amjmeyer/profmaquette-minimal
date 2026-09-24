#import "../../src/lib.typ": *
#maquette[
  #exercice[Calculatrice autorisée (défaut).]
  #exercice(calculatrice: false)[Calculatrice interdite.]
  #exercice(calculatrice: false, route: false)[Facultatif, calculatrice interdite.]
  #exercice(calculatrice: false, titre: "Un titre")[Avec un titre en plus.]
]
#maquette(style-exercice: "etiquette-pleine")[
  #exercice(calculatrice: false)[Icône lisible sur fond plein.]
]
#maquette(style-exercice: "etiquette-encadree")[
  #exercice(calculatrice: false, titre: "Calculer des termes")[Icône dans l'étiquette encadrée.]
]
#maquette(style-exercice: "bandeau")[
  #exercice(calculatrice: false, titre: "Calculer des termes")[Icône dans le bandeau.]
]
