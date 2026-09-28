#import "SETUP.typ": *
#set document(title: [profmaquette-minimal])
#show: toot-page

#title()

_Fiches d'exercices à la manière de ProfMaquette._

profmaquette-minimal sert  à composer des fiches d'exercices avec Typst. On écrit les énoncés et leurs corrigés au même endroit dans l'éditeur de texte, et le paquet (à l'aide des options) se charge de tout le reste. En résumé :

- les exercices sont numérotés automatiquement via l'ordre d'apparition dans le code ;
- on peut choisir si un exercice est *sur la route* ou non ;
- une *feuille de route* montre à l'élève le parcours de la fiche : les
  exercices sur la route, les autres et les étapes à faire valider ;
- un *entraînement* s'ouvre d'un clic sur l'exercice, et son QR code
  est regroupé en fin de fiche ;
- les *corrigés* s'affichent sous chaque énoncé, en fin de fiche ou pas du
  tout, et l'on choisit lesquels, d'un seul réglage.

Le même fichier donne ainsi la fiche élève et la fiche corrigée. Le paquet
s'adresse d'abord aux enseignants, en particulier de mathématiques.

#example(columns: 2, ```typ
// SETUP-COTE-A-COTE
// START
#show: maquette.with(liste-corriges: "1")
#align(center, afficher-fdr)
#thematique[Factoriser]
#exercice(titre: "Identité remarquable")[
  Factoriser $x^2 - 9$.
]
#corrige[$x^2 - 9 = (x - 3)(x + 3)$.]
#exercice(route: false, entrainement: "https://typst.app")[
  Factoriser $4x^2 + 12x + 9$.
]
```)

#info(title: "Un portage partiel de ProfMaquette")[
  profmaquette-minimal s'inspire directement du package LaTeX
  #link("https://ctan.org/pkg/profmaquette")[ProfMaquette] de *Christophe
  Poulain*, dont il ne reprend qu'une petite partie. Il a d'abord été écrit pour
  un usage personnel et pourra évoluer, y compris de façon incompatible entre
  deux versions `0.x`.
]

Pour commencer, rendez-vous à la partie #i-link("1-demarrer.typ")[I. Démarrer].
