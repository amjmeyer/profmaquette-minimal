#import "SETUP.typ": *
#set document(title: [profmaquette-minimal])
#show: toot-page

#title()

_Fiches d'exercices à la manière de ProfMaquette._

profmaquette-minimal sert  à composer des fiches d'exercices avec Typst et de factoriser le travail (écriture des exercices et des corrigés) en un seul endroit : on écrit les énoncés et leurs corrigés au même endroit dans l'éditeur de texte, et le paquet (à l'aide des options) se charge de tout le reste. En résumé :

- les exercices sont *numérotés automatiquement* ;

- on peut créer un mode *feuille de route* (abrégé en FdR) ;

- on peut créer un *entraînement* qui s'ouvre d'un clic sur l'exercice, ou alors se scanne via son QR code ;

- on peut contrôler finement l'affichage des corrigés ;

- on peut créer une interro et afficher son corrigé très rapidement ;

- etc.

Le paquet s'adresse particulièrement aux enseignants.  \
Je mets ici un exemple qui fait intervenir toutes les paramètres possibles, afin de voir ce qu'il est possible de faire. Cela peut également servir de repère pour le lecteur.

#example(columns: 1, ```typ
// SETUP-COTE-A-COTE
// START
// Un exemple qui regroupe presque toutes les clés d'un seul coup.
#show: maquette.with(
  // Titre de la fiche (partie III)
  titre-maquette: (
    gauche: "Chapitre 3",
    centre: "Calcul littéral",
    droite: "Seconde",
  ),
  style-maquette: "arrondi-2",
  couleur-titre: rgb("#0074D9"),
  largeur-cartouche: 80%,
  // Exercices et couleurs (parties IV et VIII)
  style-exercice: "bandeau",
  couleur-route: rgb("#0074D9"),
  couleur-interne: green,
  couleur-externe: orange,
  // Corrigés (partie V)
  position-corriges: "fin",
  liste-corriges: ("1-2", 4),
  vers-corrige: true,
  titre-corriges: [Éléments de correction],
  nouvelle-page-corriges: false,
  page-par-corrige: false,
  // Feuille de route (partie VI)
  couleur-fdr: rgb("#85144b"),
  // Entraînements (partie VII)
  nombre-qr: 2,
  taille-qr: 2.5cm,
  titre-qr: [Pour s'entraîner],
  position-qr: "fin",
  // Langue (partie X)
  langue: "fr",
)
#align(center, afficher-fdr)
#thematique[Fractions]

// exercice 1
#exercice(
  titre: "Addition de fractions (numériques)",
  calculatrice: false,
  source: "Sans calculatrice, en 3 minutes",
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
#corrige(titre-complement: "méthode")[
  On réduit au même dénominateur $x(x-2)$ :
  $display(2/(x-2) + 1/x = (3x -2)/(x(x-2)))$.
]

#thematique(alignement: center)[Factoriser]

// exercice 3
#exercice(
  titre: [Identités remarquables standards],
  entrainement: "https://CTAN.org",
)[
  Factoriser $9x^2 - 64$.\
  _Indication : Remplir les pointillés dans $9x^2 = (dots dots)^2$_
]
#corrige[On a $9x^2 - 64 = (3x-8)(3x+8)$.]

// exercice 4
#exercice(
  titre: [Identités remarquables "à l'envers"],
  entrainement: "https://typst.app",
  stop: true,
)[
  Factoriser $4x^2 + 12x + 9$.

  _Indication : Utiliser la première identité remarquable._
]
#corrige[On a $4x^2 + 12x + 9 = (2x+3)^2$.]

// exercice 5
#exercice(
  titre: [Pour aller plus loin],
  pas-corrige: true,
)[
  Factoriser $x^2 - 2$.
  #seyes(2)
]
#corrige[On a $x^2 - 2 = (x - sqrt(2))(x + sqrt(2))$.]

```)

#warning(title: "Evolutions")[
  profmaquette-minimal s'inspire directement du package LaTeX
  #link("https://ctan.org/pkg/profmaquette")[ProfMaquette] de *Christophe
  Poulain*, dont il ne reprend qu'une petite partie. \
  Il a d'abord été écrit pour un usage personnel et pourra évoluer *de façon incompatible* entre deux versions `0.x`. \
  Lorsque la version `1.x.` sera publiée, le paquet évoluera de manière strictement compatible entre ses versions.
]

Pour commencer, rendez-vous à la partie #i-link("1-demarrer.typ")[I. Démarrer].
