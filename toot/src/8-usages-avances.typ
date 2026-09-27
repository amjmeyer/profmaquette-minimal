#import "SETUP.typ": *
#set document(title: [Usages avancés])
#show: toot-page

#title[VIII. Usages avancés]

= Langue

Les mots écrits par le paquet existent en cinq langues. Avec `langue: auto`, le
paquet suit la langue du document (`#set text(lang: …)`).

#table(
  columns: 6,
  table.header[][`"fr"`][`"en"`][`"de"`][`"es"`][`"it"`],
  [Exercice], [Exercice], [Exercise], [Aufgabe], [Ejercicio], [Esercizio],
  [Correction], [Correction], [Solutions], [Lösungen], [Soluciones], [Soluzioni],
  [Automatismes], [Automatismes], [Practice], [Übungen], [Práctica], [Allenamento],
  [QR code], [Exo], [Ex.], [Aufg.], [Ej.], [Es.],
)

#example(```typ
// SETUP
// START
#set text(lang: "de")
#maquette(position-corriges: "apres")[
  #exercice(titre: "Brüche")[
    Berechne $1/2 + 1/3$.
  ]
  #corrige[$5/6$]
]
```)

= Plusieurs fiches dans un même document

Il suffit de placer les maquettes l'une après l'autre. Chaque maquette est
indépendante : elle repart de l'exercice 1, avec sa propre feuille de route, ses
propres QR codes, ses propres corrigés et ses propres couleurs. Ici, la seconde
fiche retrouve les couleurs par défaut.

#example(```typ
// SETUP
// START
#maquette(
  position-corriges: "apres",
  couleur-interne: purple,
)[
  #exercice(titre: "Fiche A")[…]
  #corrige[Corrigé A.]
]
#maquette(position-corriges: "apres")[
  #exercice(titre: "Fiche B")[…]
  #corrige[Corrigé B.]
]
```)

#tip(title: "Les réglages vont dans la maquette")[
  Une maquette part toujours de ses propres réglages, indépendamment de ce qui
  l'entoure : ses couleurs se donnent avec ses propres paramètres
  (`#maquette(couleur-interne: …)`), jamais à part. Pour cette raison, lorsqu'on veut plusieurs maquettes, on n'utilisera pas `show: maquette.with(..)`
]
