// Exercice + corrigés plus hauts qu'une page : l'exercice 1 tient sur une
// page en version élève, mais pas une fois ses corrigés en place ; le corrigé
// de l'exercice 2 fait à lui seul plus d'une page. Le cadre se coupe : filets
// pâles à chaque changement de page, pleins au début et à la fin. Sans icônes
// (entraînement, source) : avec, la convergence dépasse les 5 passes de Typst.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice(titre: "Corrigés longs")[
    + Première question. #seyes(3)
    + Deuxième question. #seyes(3)
    + Troisième question. #seyes(3)
  ]
  #for q in range(1, 4) {
    corrige[
      Réponse à la question #q :
      #for i in range(1, 13) [
        $ u_#i = 2 times #i + 1 = #(2 * i + 1) $
      ]
    ]
  }

  #exercice(titre: "Un corrigé plus haut qu'une page")[
    + Question unique. #seyes(4)
  ]
  #corrige[
    #for i in range(1, 70) [Ligne #i du corrigé. \ ]
  ]
]
