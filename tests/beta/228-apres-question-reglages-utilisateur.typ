// Réglages de l'utilisateur (set block/box/text, page colorée) : la grille et
// l'encadré rouge ne doivent pas les subir, le corps du corrigé si.
#import "../../src/lib.typ": *
#set page(fill: rgb("#FFF8E7"))
#set block(fill: yellow, stroke: 2pt + green, inset: 6pt)
#set text(fill: navy)
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice[a) #seyes(2) b) #seyes(2)]
  #corrige[Réponse a) avec un bloc utilisateur : #block[bloc]]
]
