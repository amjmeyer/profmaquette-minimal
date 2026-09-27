// Erreur voulue : un corrigé par page dans des colonnes.
#import "../../src/lib.typ": *
#columns(2)[#maquette(
  position-corriges: "apres",
  nouvelle-page-corriges: false,
  page-par-corrige: true,
)[
  #exercice[A]
  #corrige[a]
  #exercice[B]
  #corrige[b]
]]
