// Chaque maquette repart des couleurs par défaut : la seconde ne doit PAS
// hériter du vert, du violet ni du navy de la première (clé rouge, haltère
// bleue, exercice noir attendus).
#import "../../src/lib.typ": *
#set page(height: auto)
#maquette(couleur-externe: green, couleur-interne: purple, couleur-route: navy, position-corriges: "apres")[
  #exercice(entrainement: "https://a.b")[Première maquette : vert, violet, navy.] #corrige[a]
]
#maquette(position-corriges: "apres")[
  #exercice(entrainement: "https://a.b")[Seconde maquette : couleurs par défaut.] #corrige[b]
]
