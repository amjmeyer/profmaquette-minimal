// Sans maquette : après reinitialiser-compteur-exercice(), la seconde
// Correction ne doit montrer QUE le corrigé de la seconde fiche.
#import "../../src/lib.typ": *
#set page(height: auto)
#reglages-corriges(mode: "fin", nouvelle-page: false)
#exercice[Fiche 1] #solution[Corrigé de la fiche 1]
#liste-corriges()
#reinitialiser-compteur-exercice()
#exercice[Fiche 2] #solution[Corrigé de la fiche 2]
#liste-corriges()
