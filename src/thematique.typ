// Copyright 2026 Arthur Meyer
//
// This work may be distributed and/or modified under the
// conditions of the LaTeX Project Public License, either version 1.3c
// of this license or (at your option) any later version.
// The latest version of this license is in
//   https://www.latex-project.org/lppl.txt
// and version 1.3c or later is part of all distributions of LaTeX
// version 2008 or later.
//
// This work has the LPPL maintenance status `maintained'.
// The Current Maintainer of this work is Arthur Meyer.
//
// This work consists of all the .typ files in the src/ directory
// and its subdirectories.

// Fonction thematique, titre d'une partie de la fiche.

#import "interne/etats.typ": *
#import "interne/utils.typ": *
#import "interne/blocs-fin.typ": entrainements-thematique
#import "interne/styles.typ": styles-maquette

// Titre d'une thématique de la fiche, jamais numéroté, dessiné selon le style de
// la fiche (`maquette(style-maquette: …, couleur-titre: …)`, voir
// `interne/styles.typ`). Ce n'est pas un `heading` : insensible aux réglages de
// titres du document, absent de la table des matières. Sur la feuille de route,
// il termine la thématique précédente (coche après son dernier exercice). Avec
// `maquette(position-qr: "thematique")`, les QR codes de la thématique
// précédente s'affichent juste avant ce titre.
//   alignement : left (défaut), center ou right ; place le titre le long du trait
#let thematique(
  alignement: left,
  titre,
) = {
  entrainements-thematique()
  // Hors `context`, avec une fonction fixe : sinon, pas de convergence.
  etat-qr-attente.update(q => (..q, items: (), titre: titre))
  [#metadata(none) #repere-thematique]
  protege(rendre => {
    let (style, couleur) = etat-style-maquette.get()
    (styles-maquette.at(style).thematique)(rendre(titre), alignement, couleur)
  })
}
