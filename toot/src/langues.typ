#import "SETUP.typ": *
#set document(title: [Langues])
#show: toot-page

#title[X. Langues]

Les mots écrits par le paquet existent en cinq langues. Avec `langue: auto`, le
paquet suit la langue du document (`#set text(lang: …)`).

#table(
  columns: 6,
  table.header[][`"fr"`][`"en"`][`"de"`][`"es"`][`"it"`],
  [Exercice], [Exercice], [Exercise], [Aufgabe], [Ejercicio], [Esercizio],
  [Correction], [Correction], [Solutions], [Lösungen], [Soluciones], [Soluzioni],
  [Automatismes], [Automatismes], [Practice], [Übungen], [Práctica], [Allenamento],
  [QR code], [Exo], [Ex.], [Aufg.], [Ej.], [Es.],
  [Corrigé (interro)], [Corrigé], [Solution], [Lösung], [Solución], [Soluzione],
  [Barème], [pt / pts], [pt / pts], [P.], [pto / ptos], [pt],
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
