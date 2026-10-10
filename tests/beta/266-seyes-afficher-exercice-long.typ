// Réponses affichées (afficher: true) dans un exercice plus haut qu'une page,
// en interro : la lecture de etat-profondeur, limitée à ce cas, ne doit pas
// empêcher la convergence (cf. 226).
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice(entrainement: "https://example.org", source: "Manuel p. 12")[
    #for i in range(1, 7) [+ Question #i. #seyes(4, afficher: calc.even(i))[Réponse affichée #i.]]
  ]
  #for i in range(1, 7) { corrige[Corrigé #i.] }
]
