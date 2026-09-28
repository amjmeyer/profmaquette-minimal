// largeur-cartouche : 1 %, 99 %, et titre très long à 20 %.
#import "../../src/lib.typ": *
#let titre = (gauche: [IE 01], centre: [Un titre de cartouche vraiment très long qui doit passer à la ligne], droite: [1C SPE])
#maquette(mode-maquette: "interro", titre-maquette: titre, largeur-cartouche: 1%)[#exercice[A]]
#maquette(mode-maquette: "interro", titre-maquette: titre, largeur-cartouche: 99%)[#exercice[A]]
#maquette(mode-maquette: "interro", titre-maquette: titre, largeur-cartouche: 20%)[#exercice[A]]
