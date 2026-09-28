// Forme #show: maquette.with, dans deux colonnes, texte 20 pt.
#import "../../src/lib.typ": *
#set text(size: 20pt)
#set page(columns: 2)
#show: maquette.with(mode-maquette: "interro", position-corriges: "apres-question", nouvelle-page-corriges: false)
#exercice[a) #seyes(2) b) #seyes(3)]
#corrige[Réponse a).]
#corrige[Réponse b).]
