// position-qr: "thematique" : un bloc « Automatismes — <thématique> » à la fin
// de chaque thématique (avant le titre de la suivante), un bloc sans nom pour
// les exercices d'avant la première, rien pour une thématique sans entraînement ;
// puis une maquette "fin" (défaut) inchangée, qui ne doit rien hériter.
#import "../../src/lib.typ": *
#maquette(position-qr: "thematique", style-thematique: "bandeau", nombre-qr: 4)[
  #align(center, afficher-fdr)
  #exercice(entrainement: "https://example.org/avant")[Avant toute thématique.]
  #thematique[Suites]
  #exercice(entrainement: "https://example.org/suites-1")[Énoncé.]
  #exercice[Sans entraînement.]
  #exercice(entrainement: "https://example.org/suites-3")[Énoncé.]
  #thematique[Sans entraînement]
  #exercice[Énoncé.]
  #thematique[Fonctions]
  #exercice(entrainement: "https://example.org/fonctions")[Énoncé.]
  #corrige[Corrigé.]
]
#maquette(titre-qr: "À scanner")[
  #thematique[Suites]
  #exercice(entrainement: "https://example.org/a")[Énoncé.]
  #thematique[Fonctions]
  #exercice(entrainement: "https://example.org/b")[Énoncé.]
]
