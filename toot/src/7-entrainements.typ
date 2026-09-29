#import "SETUP.typ": *
#set document(title: [Les entraînements])
#show: toot-page

#title[VII. Les entraînements]

Un exercice avec `entrainement: "https://…"` porte une haltère cliquable sur son
filet droit (#i-link("4-exercices.typ")[partie IV]). Toutes les adresses de la fiche sont aussi regroupées
en QR codes dans le bloc « Automatismes », ajouté automatiquement par la
maquette : l'élève qui travaille sur papier y accède avec son téléphone. Chaque
QR code porte le numéro de son exercice, et il est lui aussi cliquable.

#info(title: "Fonctionnement interne")[
  Le bloc se place en bas de la dernière page s'il reste de la place, sinon en
  bas de la page suivante.\ 
  Sa couleur est
  celle des liens vers l'extérieur, `couleur-externe:` (#i-link("8-couleurs.typ")[partie VIII]), comme l'haltère
  et la source.
]

#signature("maquette(
  …
  nombre-qr: int,
  taille-qr: length,
  titre-qr: content | auto,
  …
) -> content")

#parametre("nombre-qr", ("int",), `3`)[
  Ce paramètre modifie le nombre de QR-Codes par ligne dans le bloc « Automatismes ».
]

#example(```typ
// SETUP
// START
#show: maquette.with(nombre-qr: 2)
#exercice(entrainement: "https://typst.app")[
  Tables de multiplication.
]
#exercice[Sans entraînement.]
#exercice(entrainement: "https://CTAN.org")[
  Fractions.
]
```)

#parametre("taille-qr", ("length",), `2cm`)[
  Ce paramètre modifie la longueur du côté commun de tous les QR codes. \
  Une adresse web trop longue pour rester lisible à cette taille donne un QR code agrandi automatiquement.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  taille-qr: 0.5cm,
  nombre-qr: 4)
#exercice(entrainement: "https://typst.app")[
  Tables de multiplication.
]
#exercice[
  Tables de multiplication.
]
#exercice(entrainement: "https://typst.app")[
  Tables de multiplication.
]
#exercice(entrainement: "https://typst.app")[
  Tables de multiplication.
]
#exercice(entrainement: "https://typst.app")[
  Tables de multiplication.
]
```)

#parametre("titre-qr", ("content", "auto"), `auto`)[
  Ce paramètre modifie le nom donné au cadre contenant les QR-Codes.
]

#example(```typ
// SETUP
// START
#show: maquette.with(
  taille-qr: 1cm,
  titre-qr: "QR-Codes à scanner"
)
#exercice(entrainement: "https://typst.app")[
  Tables de multiplication.
]
```)
