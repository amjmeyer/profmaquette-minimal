// Test visuel (pas un beta-test d'erreur) : le style de cartouche de titre
// "onglet", en mode "exercices" puis "interro" (zone Nom/Prénom/Classe à
// droite, même hauteur que le cartouche), avec couleur personnalisée
// (couleur-titre) et cas limites.
#import "../../src/lib.typ": *
#set page(paper: "a4", margin: 1.5cm)
#set text(lang: "fr", size: 11pt)

#let titre = (gauche: "CH 02", centre: "Suites numériques", droite: "1 C")

= Mode exercices
#maquette(titre-maquette: titre)[
  #exercice(titre: "Premiers termes")[Calculer $u_1$ et $u_2$.]
]

#pagebreak(weak: true)
= Mode exercices sans titre-maquette (rien ne s'affiche)
#maquette[
  #exercice(titre: "Premiers termes")[Calculer $u_1$ et $u_2$.]
]

#pagebreak(weak: true)
= Mode interro
#maquette(mode-maquette: "interro", titre-maquette: titre)[
  #exercice(titre: "Premiers termes")[Calculer $u_1$ et $u_2$.]
]

#pagebreak(weak: true)
= Couleur personnalisée (couleur-titre: navy)
#maquette(mode-maquette: "interro", titre-maquette: titre, couleur-titre: rgb("#1B3A6B"))[
  #exercice(titre: "Premiers termes")[Calculer $u_1$ et $u_2$.]
]

#pagebreak(weak: true)
= Mode interro sans titre-maquette (zone pleine largeur)
#maquette(mode-maquette: "interro")[
  #exercice(titre: "Premiers termes")[Calculer $u_1$ et $u_2$.]
]

#pagebreak(weak: true)
= Titre incomplet (centre et droite seuls), interro
#maquette(mode-maquette: "interro", titre-maquette: (centre: "Suites numériques", droite: "1 C"))[
  #exercice(titre: "Premiers termes")[Calculer $u_1$ et $u_2$.]
]

#pagebreak(weak: true)
= Titre incomplet (gauche seul)
#maquette(titre-maquette: (gauche: "CH 02"))[
  #exercice(titre: "Premiers termes")[Calculer $u_1$ et $u_2$.]
]
