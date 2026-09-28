// Exercice plus haut qu'une page (branche « boîte coupée » d'exercice),
// avec entraînement et source, seyes dedans.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice(entrainement: "https://example.org", source: "Manuel p. 12")[
    #for i in range(1, 7) [+ Question #i. #seyes(4)]
  ]
  #for i in range(1, 7) { corrige[Réponse #i.] }
]
