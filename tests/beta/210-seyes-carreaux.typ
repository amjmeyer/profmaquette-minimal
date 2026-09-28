// Zone seyes seule : hauteur en carreaux (entier ou décimal) ou en longueur,
// trois styles, sans lignes verticales, carreau plus petit, hors maquette.
#import "../../src/lib.typ": *
#set page(height: auto)

Hors maquette, 2 carreaux :
#seyes(2)

#maquette[
  #exercice(titre: "Carreaux")[
    4 carreaux (4 × 8 mm) :
    #seyes(4)
    2,5 carreaux :
    #seyes(2.5)
    3 cm :
    #seyes(3cm)
  ]
  #exercice(titre: "Styles")[
    Sobre : #seyes(2, style: "sobre")
    Bleu : #seyes(2, style: "bleu")
    Seyes pur (sans verticales) : #seyes(2, vertical: false)
    Carreau de 5 mm : #seyes(4, carreau: 5mm)
  ]
]
