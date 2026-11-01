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

// Styles de la fiche, réglés par `maquette(style-maquette: …)` : chacun dessine
// le cartouche de titre et les `thematique`, pour qu'ils aillent ensemble. Le
// cartouche n'a pas de réglage propre : il découle toujours du style.
// Tout est à appeler dans un `context`.

#import "utils.typ": *

// Texte posé sur un fond plein : blanc sur un fond foncé, noir sur un fond clair.
#let encre(fond) = if type(fond) == color and luma(fond).components().first() >= 55% { black } else { white }

// Cartouches : (gauche, centre, droite, couleur, hauteur) → contenu.
// `hauteur` : auto, ou la hauteur à atteindre pour égaler la zone Nom / Prénom
// / Classe posée à droite (mode "interro").

// Onglet coloré posé sur un cadre arrondi (d'après `pretty-part`, thème
// « pretty » du paquet bookly).
#let cartouche-onglet(gauche, centre, droite, couleur, hauteur) = layout(taille => {
  let onglet = if gauche != none {
    bloc-neutre(fill: couleur, inset: (x: .9em, y: .45em), radius: (top: 8pt), text(
      fill: encre(couleur),
      weight: "bold",
      size: 12pt * echelle(),
      gauche,
    ))
  } else { none }
  let hauteur-onglet = if onglet != none { measure(onglet).height } else { 0pt }
  let corps = grid(
    columns: (1fr, auto),
    column-gutter: .8em,
    align: (center + horizon, right + horizon),
    text(weight: "bold", size: 17pt * echelle(), if centre != none { centre } else { " " }),
    if droite != none { text(size: 10pt * echelle(), weight: "bold", droite) } else { [] },
  )
  let hauteur-cadre = if hauteur == auto {
    measure(corps, width: taille.width - 2.4em).height + 1.8em
  } else { hauteur - hauteur-onglet }
  stack(
    dir: ttb,
    spacing: 0pt,
    if onglet != none { pad(left: 1.2em, onglet) } else { [] },
    bloc-neutre(
      width: 100%,
      height: hauteur-cadre,
      stroke: 1.5pt + couleur,
      radius: 10pt,
      inset: (x: 1.2em, y: .9em),
      align(horizon, corps),
    ),
  )
})

// En-tête de chapitre des leçons (`chapitre` du préambule de l'auteur) :
// numéro en gris, trait vertical, titre, puis niveau en italique à droite. Le
// bloc porte lui-même l'espace qui le suit.
#let cartouche-chapitre(gauche, centre, droite, couleur, hauteur) = {
  let e = echelle()
  let ligne = (
    if gauche != none { (text(size: 26pt * e, fill: luma(130), weight: "bold", gauche),) },
    if gauche != none { (line(angle: 90deg, length: 3em, stroke: 1.2pt + luma(150)),) },
    if centre != none { (text(size: 22pt * e, fill: couleur, weight: "bold", centre),) },
  ).filter(c => c != none).flatten()
  let contenu = {
    if ligne != () {
      grid(columns: (auto,) * (ligne.len() - 1) + (1fr,), column-gutter: .9em, align: horizon, ..ligne)
    }
    if droite != none {
      if ligne != () { v(.4em) }
      align(right, text(size: 10pt * e, fill: couleur, style: "italic", droite))
    }
  }
  if hauteur == auto {
    bloc-neutre(width: 100%, above: 1.2em, below: 2em, contenu)
  } else {
    bloc-neutre(width: 100%, height: hauteur, align(horizon, contenu))
  }
}

// Thématiques : (titre, alignement, couleur) → contenu, `titre` déjà rendu avec
// les réglages de l'utilisateur. `alignement` place le titre le long du trait.

// Petit onglet plein posé sur un trait jusqu'aux marges (écho de l'onglet du
// cartouche).
#let thematique-onglet(titre, alignement, couleur) = {
  let onglet = bloc-neutre(fill: couleur, inset: (x: .8em, y: .35em), radius: (top: 6pt * echelle()), text(
    fill: encre(couleur),
    weight: "bold",
    titre,
  ))
  bloc-neutre(width: 100%, above: 1.4em, below: .9em, sticky: true, stack(
    dir: ttb,
    spacing: 0pt,
    pad(x: 1.2em, align(alignement, onglet)),
    line(length: 100%, stroke: 1.5pt + couleur),
  ))
}

// Étiquette pleine arrondie, puis trait fin jusqu'à la marge.
#let thematique-etiquette(titre, alignement, couleur) = {
  let etiquette = boite-neutre(fill: couleur, inset: (x: .7em, y: .35em), radius: 6pt * echelle(), text(
    fill: encre(couleur),
    weight: "bold",
    titre,
  ))
  let trait = boite-neutre(width: 1fr, baseline: -.3em, line(length: 100%, stroke: .8pt + couleur))
  bloc-neutre(width: 100%, above: 1.4em, below: .9em, sticky: true, if alignement == left {
    [#etiquette #trait]
  } else if alignement == center {
    [#trait #etiquette #trait]
  } else {
    [#trait #etiquette]
  })
}

// Filet des cours (`filet-horizontal` du préambule de l'auteur) : petite barre
// de la couleur du style, titre en gras, trait jusqu'à la marge, de la couleur
// du style aussi, sauf en noir où il reste gris comme dans les cours. La barre
// reste à gauche, le titre glisse le long du trait.
#let thematique-filet(titre, alignement, couleur) = {
  let couleur-trait = if couleur == black { rgb("#8a8a8a") } else { couleur }
  let trait = boite-neutre(width: 1fr, baseline: -.3em, line(length: 100%, stroke: .8pt + couleur-trait))
  let texte = strong(titre)
  let barre = boite-neutre(width: .45cm, height: 1em, baseline: .2em, fill: couleur)
  // Espaces comprises autour des `h`, comme dans le balisage du filet.
  bloc-neutre(width: 100%, above: 2.2em, below: 1.1em, sticky: true, if alignement == left {
    [#barre #h(.4em) #texte #h(.4em) #trait]
  } else if alignement == center {
    [#barre #h(.4em) #trait #h(.4em) #texte #h(.4em) #trait]
  } else {
    [#barre #h(.4em) #trait #h(.4em) #texte]
  })
}

// Les styles : un cartouche et une thématique chacun. `espace-propre` : le
// cartouche porte déjà l'espace qui le suit (en mode "exercices").
#let styles-maquette = (
  "arrondi-1": (cartouche: cartouche-onglet, thematique: thematique-onglet, espace-propre: false),
  "arrondi-2": (cartouche: cartouche-onglet, thematique: thematique-etiquette, espace-propre: false),
  carre: (cartouche: cartouche-chapitre, thematique: thematique-filet, espace-propre: true),
)
