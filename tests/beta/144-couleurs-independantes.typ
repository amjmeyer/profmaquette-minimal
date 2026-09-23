// Chaque maquette repart des couleurs par défaut : la seconde ne doit PAS
// hériter du vert, du violet ni du navy de la première (clé rouge, haltère
// bleue, exercice noir attendus).
#import "../../src/lib.typ": *
#set page(height: auto)
#maquette(lien-externe: green, lien-interne: purple, couleur-obligatoire: navy, localisation-correction: "apres")[
  #exercice(entrainement: "https://a.b")[Première maquette : vert, violet, navy.] #solution[a]
]
#maquette(localisation-correction: "apres")[
  #exercice(entrainement: "https://a.b")[Seconde maquette : couleurs par défaut.] #solution[b]
]
