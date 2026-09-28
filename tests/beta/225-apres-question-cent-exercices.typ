// Convergence : 60 exercices × 3 seyes × 3 corrigés.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #for i in range(1, 61) [
    #exercice(titre: [n° #i])[a) #seyes(1) b) #seyes(1) c) #seyes(1)]
    #corrige[#i a] #corrige[#i b] #corrige[#i c]
  ]
]
