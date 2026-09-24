#import "../../src/lib.typ": *
// Erreur attendue : page-par-corrige a la même limite que correction-nouvelle-page
// (voir tests 45 et 46) : saut de page interdit dans columns().
#columns(2)[#maquette(
  localisation-correction: "apres",
  correction-nouvelle-page: false,
  page-par-corrige: true,
)[
  #exercice[A]
  #solution[a]
  #exercice[B]
  #solution[b]
]]
