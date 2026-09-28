// largeur-cartouche : défaut (65 %), 50 %, 80 % en interro ; sans effet en
// mode exercices et en interro sans titre-maquette.
#import "../../src/lib.typ": *
#let titre = (gauche: [IE 01], centre: [Fractions], droite: [1C SPE])

= Interro, défaut (65 %)
#maquette(mode-maquette: "interro", titre-maquette: titre)[#exercice[A]]
= Interro, 50 %
#maquette(mode-maquette: "interro", titre-maquette: titre, largeur-cartouche: 50%)[#exercice[A]]
= Interro, 80 %
#maquette(mode-maquette: "interro", titre-maquette: titre, largeur-cartouche: 80%)[#exercice[A]]
= Exercices, 30 % (sans effet : pleine largeur)
#maquette(titre-maquette: titre, largeur-cartouche: 30%)[#exercice[A]]
= Interro sans titre, 30 % (sans effet : zone pleine largeur)
#maquette(mode-maquette: "interro", largeur-cartouche: 30%)[#exercice[A]]
