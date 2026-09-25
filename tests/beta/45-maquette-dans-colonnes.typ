#import "../../src/lib.typ": *
// Avec nouvelle-page-corriges: false, la maquette fonctionne dans columns().
#columns(3)[#maquette(position-corriges: "fin", nouvelle-page-corriges: false)[
  #align(center, afficher-fdr)
  #thematique[Première thématique]
  #exercice(titre: "Un titre", entrainement: "https://typst.app", source: "Calculs 1.1")[
    Énoncé de l'exercice 1 avec du texte assez long pour faire au moins une ligne complète, voire deux lignes.
    + question $x^2 - 9 = 0$
    + question
  ]
  #corrige[Corrigé 1.]
  #exercice(titre: "Facultatif", route: false)[Énoncé 2.]
  #corrige[Corrigé 2.]
  #thematique[Deuxième thématique]
  #exercice(entrainement: "https://typst.app/docs")[Énoncé 3, sans titre.]
  #corrige[Corrigé 3.]
]
]
