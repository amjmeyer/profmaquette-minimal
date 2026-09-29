#import "SETUP.typ": *
#set document(title: [profmaquette-minimal])
#show: toot-page

#title()

_Fiches d'exercices à la manière de ProfMaquette._

profmaquette-minimal sert  à composer des fiches d'exercices avec Typst et de factoriser le travail (écriture des exercices et des corrigés) en un seul endroit. On écrit les énoncés et leurs corrigés au même endroit dans l'éditeur de texte, et le paquet (à l'aide des options) se charge de tout le reste. En résumé :

- les exercices sont *numérotés automatiquement* ;

- on peut créer un mode *feuille de route* (abrégé en FdR) ;

- on peut créer un *entraînement* qui s'ouvre d'un clic sur l'exercice, ou alors se scanne via son QR code
  placé en fin de fiche ;

- les *corrigés* s'affichent sous chaque énoncé, en fin de fiche, ou pas du
  tout ; 
  
- on peut choisir en un clic quels corrigés afficher, pratique pour mettre à jour son document sur PRONOTE ; 

- etc. 

Le paquet s'adresse particulièrement aux enseignants, mais pas que de mathématiques !  \
Je mets ici un exemple détaillé, afin de voir ce qu'il est possible de faire.
#example(columns: 1, ```typ
// SETUP-COTE-A-COTE
// START
// Un exemple qui regroupe beaucoup de fonctionnalités d'un seul coup.
#show: maquette.with(
  liste-corriges: ("1-2", 4),
  couleur-interne: green,
  couleur-externe: orange,
  couleur-fdr: rgb("#85144b"),
)
#align(center, afficher-fdr)
#thematique[Fractions]

// exercice 1
#exercice(
  titre: "Addition de fractions (numériques)",
  calculatrice: false
)[
  Mettre sous forme d'une fraction irréductible l'expression $display(1/5 + 4/7)$
]
#corrige[On a $1/5 + 4/7 = 5/12$ (patatra...).]

// exercice 2
#exercice(
  titre: "Addition de fractions (littéral)",
  calculatrice: false,
  route: false,
)[
  Mettre sous la forme d'une seule fraction l'expression $display(2/(x-2) + 1/x).$
]
#corrige[On a $display(2/(x-2) + 1/x = (3x -2)/(x(x-2)))$.]

#thematique[Factoriser]

#exercice(
  titre: [Identités remarquables standards],  
  entrainement: "https://CTAN.org"
)[
  Factoriser $9x^2 - 64$.\
  _Indication : Remplir les pointillés dans $9x^2 = (dots dots)^2$_
]
#corrige[On a $9x^2 - 64 = (3x-8)(3x+8)$.]

#exercice(
  titre: [Identités remarquables "à l'envers"],  
  entrainement: "https://typst.app"
)[
  Factoriser $4x^2 + 12x + 9$.

  _Indication : Utiliser la première identité remarquable._
]
#corrige[On a $4x^2 + 12x + 9 = (2x+3)^2$.]

```)

#warning(title: "Evolutions")[
  profmaquette-minimal s'inspire directement du package LaTeX
  #link("https://ctan.org/pkg/profmaquette")[ProfMaquette] de *Christophe
  Poulain*, dont il ne reprend qu'une petite partie. \
  Il a d'abord été écrit pour un usage personnel et pourra évoluer *de façon incompatible* entre deux versions `0.x`. \
  Lorsque la version `1.x.` sera publiée, le paquet évoluera de manière strictement compatible entre ses versions.
]

Pour commencer, rendez-vous à la partie #i-link("1-demarrer.typ")[I. Démarrer].
