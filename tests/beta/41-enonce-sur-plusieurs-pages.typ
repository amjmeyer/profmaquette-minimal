#import "../../src/lib.typ": *
#maquette[
  #exercice(titre: "Très long", entrainement: "https://typst.app")[
    #for i in range(90) [Ligne numéro #i de l'énoncé. \ ]
  ]
  #exercice[Après.]
]
