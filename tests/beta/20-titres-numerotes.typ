#import "../../src/lib.typ": *
#set heading(numbering: "I.1.a")
#show heading.where(level: 3): it => block(fill: yellow, inset: 4pt)[#counter(heading).display() -- #it.body]
= Chapitre
== Section
=== Sous-section avant la fiche
#maquette(localisation-correction: "fin")[
  #align(center, afficher-fdr)
  #thematique[Première thématique]
  #exercice(titre: "Un titre", entrainement: "https://typst.app", source: "Calculs 1.1")[
    Énoncé de l'exercice 1 avec du texte assez long pour faire au moins une ligne complète, voire deux lignes.
    + question $x^2 - 9 = 0$
    + question
  ]
  #solution[Corrigé 1.]
  #exercice(titre: "Facultatif", route: false)[Énoncé 2.]
  #solution[Corrigé 2.]
  #thematique[Deuxième thématique]
  #exercice(entrainement: "https://typst.app/docs")[Énoncé 3, sans titre.]
  #solution[Corrigé 3.]
]

=== Titre ordinaire après
#outline()
