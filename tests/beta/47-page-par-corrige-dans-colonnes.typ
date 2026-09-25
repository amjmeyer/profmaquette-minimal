#import "../../src/lib.typ": *
// Erreur attendue : page-par-corrige a la même limite que nouvelle-page-corriges
// (voir tests 45 et 46) : saut de page interdit dans columns().
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
