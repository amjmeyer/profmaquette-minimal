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
// This work consists of the files src/lib.typ and src/exercices.typ.

// ╔══════════════════════════════════════════════════════════════════════════════╗
// ║  template-exercices — fiches d'exercices à la manière de ProfMaquette        ║
// ╚══════════════════════════════════════════════════════════════════════════════╝
//
// Portage minimaliste, en Typst, de quelques fonctionnalités du package LaTeX
// ProfMaquette (Christophe Poulain) :
//
//   • Exercices encadrés, numérotés automatiquement, obligatoires (couleur) ou
//     facultatifs (gris) — équivalent des clés Route / Stop.
//   • Entraînement en ligne (clé AEntretenir) : une haltère cliquable sur le filet
//     droit de l'exercice ; les QR codes sont regroupés en fin de fiche, dans un
//     bloc « Automatismes ».
//   • Source (clé Source) : petite étiquette sur le filet bas de l'exercice.
//   • Corrigés (environnement Solution, §3.10 de la doc ProfMaquette) : affichés
//     sous l'énoncé (CorrigeApres), en fin de fiche (CorrigeFin) ou pas du tout,
//     avec une clé cliquable exercice ↔ corrigé (VersSolution).
//   • Feuille de route (clé FdR, commande \AfficheFdR) : `#afficher-fdr` dessine
//     le schéma des exercices de la maquette — obligatoires sur la route du bas,
//     facultatifs sur la ligne du haut, coche de validation à la fin de chaque
//     thématique de la fiche (`#thematique[…]` délimite les thématiques).
//   • maquette : un seul appel qui règle toute la fiche, dont la sélection des
//     corrigés à afficher (ex. "1-6,9,12", "obligatoires") et les deux couleurs
//     du paquet (bleu-perso, rouge-perso).
//
// Non porté : types de documents, en-tête de la feuille de route, Reponse / Indice…
//
// ──────────────────────────────────────────────────────────────────────────────
// UTILISATION
// ──────────────────────────────────────────────────────────────────────────────
//
//   #import "@preview/template-exercices:0.1.0": maquette, exercice, solution, afficher-fdr
//
//   #maquette(afficher-corrige: "fin", corriges: "1-6,9,12")[
//     #afficher-fdr
//     #exercice(titre: "Factoriser", entrainement: "https://…", source: "Calculs 30.1")[
//       Énoncé…
//     ]
//     #solution[
//       Corrigé…
//     ]
//     #exercice(titre: "Pour aller plus loin", obligatoire: false)[ … ]
//   ]
//
// Fonctions publiques (détaillées dans la section « API publique »), les seules
// exportées par `lib.typ` — tout le reste du fichier est interne au paquet :
//   maquette                        réglages de la fiche + blocs de fin automatiques
//   exercice / solution             un énoncé / son corrigé
//   reglages-couleurs               bleu-perso / rouge-perso, sans maquette
//   reglages-corriges               réglages des corrigés, sans maquette
//   couleur-exercices-obligatoires  couleur des exercices obligatoires, sans maquette
//   style-exercices                 style des cadres d'exercice, sans maquette
//   liste-entrainements             bloc « Automatismes » (QR codes), sans maquette
//   liste-corriges                  bloc « Correction », sans maquette
//   reinitialiser-compteur-exercice repart de l'exercice 1
//   thematique                      titre d'une thématique (coche sur la feuille de route)
//   afficher-fdr                    schéma de la feuille de route (contenu, sans parenthèses)
//
// ──────────────────────────────────────────────────────────────────────────────
// NOTES TECHNIQUES
// ──────────────────────────────────────────────────────────────────────────────
//
//   • Boîtes : dessinées par le paquet (`boite-etiquette`), sans compteur ni
//     état. Une boîte qui en utiliserait (comme showybox, employé auparavant)
//     empêche le document de converger dès qu'il contient plusieurs maquettes :
//     les boîtes d'exercice sont mesurées, et le bloc « Automatismes » flotte.
//   • Icônes du filet droit : la boîte est mesurée à la largeur réellement
//     disponible (`layout`, donc quels que soient le papier, les marges ou les
//     colonnes), puis les icônes sont placées par `place()` dans une `box` de même
//     hauteur. Elles ne débordent dans la marge que de leur demi-largeur.
//   • Couleurs : les deux couleurs du paquet sont gardées dans un `state`, et
//     jamais exportées sous un nom de couleur (pas de conflit avec un `cyan` ou un
//     `red` défini ailleurs).
//   • Convergence : Typst recompile au plus 5 fois pour stabiliser les requêtes.
//     La chaîne « clé de l'exercice → corrigé → mesure de la boîte » est longue ;
//     pour qu'elle converge, les états sont toujours mis à jour HORS `context`
//     avec des valeurs fixes, et la mise en page ne dépend jamais du résultat
//     d'une requête (cf. `exercice`).
//   • Icônes (haltère, clé, coche) : dessins SVG de Font Awesome Free (licence
//     CC BY 4.0), fournis avec le paquet dans `icones/`. Aucune police à
//     installer : un paquet Typst ne peut pas fournir de police.

#import "@preview/tiaoma:0.3.0": qrcode


// ══════════════════════════════════════════════════════════════════════════════
// 1. COULEURS
// ══════════════════════════════════════════════════════════════════════════════

// Les deux couleurs du paquet, modifiables par `maquette` ou `reglages-couleurs`
// (n'importe quelle couleur Typst : blue, rgb("#1E90FF"), luma(30%)…) :
//   bleu-perso  = lien vers l'extérieur (haltère, QR codes, source) ;
//   rouge-perso = navigation dans le document (clé, titres des corrigés).
// Valeurs par défaut :
//   bleu-perso  : cyan foncé, gris foncé bien contrasté une fois imprimé en noir
//                 et blanc ;
//   rouge-perso : Crimson, couleur « CouleurSol=Crimson » de ProfMaquette.
#let etat-couleurs = state("etat-couleurs-perso", (
  bleu: rgb("#0090C8"),
  rouge: rgb("#DC143C"),
))

// Accès aux couleurs courantes (à appeler dans un `context`).
#let bleu-perso() = etat-couleurs.get().bleu
#let rouge-perso() = etat-couleurs.get().rouge


// ══════════════════════════════════════════════════════════════════════════════
// 2. ÉTATS INTERNES
// ══════════════════════════════════════════════════════════════════════════════

// Historique des exercices rencontrés : un dictionnaire par exercice
// (obligatoire, pas-corrige, titre-solution, titre, entrainement). Sa longueur donne le numéro de
// l'exercice courant.
#let etat-historique = state("etat-historique-exercices", ())

// Numéro de la série d'exercices en cours, augmenté par chaque `maquette` et
// chaque `reinitialiser-compteur-exercice`. Il distingue les « exercice 1 » de
// deux fiches d'un même document dans les liens exercice ↔ corrigé.
#let etat-serie = state("etat-serie-exercices", 0)

// Réglages des corrigés (cf. `reglages-corriges`). Par défaut : aucun corrigé.
// couleur-sol : auto = rouge-perso.
#let etat-reglages-corriges = state("etat-reglages-corriges", (
  mode: none,
  vers-solution: false,
  couleur-sol: auto,
  titre-corrige: auto,
  colonnes: 1,
  nouvelle-page: true,
))

// Corrigés à afficher (auto = tous), sous la forme rendue par `parser-plage`.
#let etat-selection = state("etat-selection", (corriges: auto))

// Couleur des exercices obligatoires (étiquette + filet).
#let etat-couleur-obligatoire = state("etat-couleur-obligatoire", black)

// Style des cadres (exercices et bloc « Automatismes ») : cf. `boite-etiquette`.
#let styles-exercice = ("fond-blanc", "etiquette-encadree", "bandeau", "etiquette-pleine")
#let etat-style = state("etat-style-exercice", "fond-blanc")

// Réglages du schéma de la feuille de route (cf. `afficher-fdr`) :
//   couleur : couleur du schéma (disques pleins, contours, route) ;
#let etat-fdr = state("etat-fdr", (couleur: black))

// Étiquettes des repères posés dans le document pour `afficher-fdr` :
//   - un par exercice (numero, obligatoire, stop) ;
//   - un par `thematique`, qui termine le tronçon en cours ;
//   - une borne au début et à la fin de chaque maquette, et à chaque
//     `reinitialiser-compteur-exercice` : le schéma ne montre que les exercices
//     compris entre les deux bornes qui l'entourent.
#let repere-exercice = <template-exercices-fdr-exercice>
#let repere-borne = <template-exercices-fdr-borne>
#let repere-thematique = <template-exercices-fdr-thematique>

// Corrigés en mode "fin" (numero, id, titre, body), restitués par
// `liste-corriges`. Les entraînements, eux, sont lus dans `etat-historique`.
#let etat-solutions = state("etat-solutions", ())

// Nombre de maquettes ouvertes à cet endroit du document (1 dans une maquette).
#let etat-profondeur = state("etat-profondeur-maquette", 0)

// Blocs de fin déjà affichés pour la fiche en cours : un second appel (par
// exemple `liste-corriges()` écrit à la main dans une maquette, qui l'appelle
// déjà) n'affiche rien.
#let etat-blocs-fin = state("etat-blocs-fin", (entrainements: false, corriges: false))


// ══════════════════════════════════════════════════════════════════════════════
// 3. OUTILS INTERNES
// ══════════════════════════════════════════════════════════════════════════════

// Convertit une sélection de corrigés en tableau trié d'entiers, en `auto` (tous)
// ou en mot-clé. Formes acceptées :
//   auto · 4 · "1-6,9,12" · (1, 2, "5-8") · "obligatoires" · "facultatifs"
#let parser-plage(sel) = {
  if sel == auto { return auto }
  if type(sel) == str and sel.trim() in ("obligatoires", "facultatifs") { return sel.trim() }
  if type(sel) == int { return (sel,) }
  if sel == () { return () } // aucun corrigé
  if type(sel) == array { sel = sel.map(str).join(",") }
  assert(
    type(sel) == str,
    message: "Sélection de corrigés invalide : auto, un entier, \"1-6,9,12\" ou un tableau.",
  )
  let res = ()
  let entier(t) = {
    assert(
      t.trim().match(regex("^\\d+$")) != none,
      message: "Sélection de corrigés invalide : « " + sel + " ». Formes acceptées : auto, 4, \"1-6,9,12\", \"obligatoires\", \"facultatifs\".",
    )
    int(t.trim())
  }
  for morceau in sel.split(",") {
    let m = morceau.trim()
    if m == "" { continue }
    if m.contains("-") {
      let bornes = m.split("-").map(entier)
      assert(bornes.len() == 2 and bornes.at(0) <= bornes.at(1), message: "Plage invalide : " + m)
      res += range(bornes.at(0), bornes.at(1) + 1)
    } else {
      res.push(entier(m))
    }
  }
  res.dedup().sorted()
}

// L'exercice n° `numero` fait-il partie de la sélection `sel` ?
#let est-selectionne(numero, obligatoire, sel) = {
  if sel == auto { true }
  else if sel == "obligatoires" { obligatoire }
  else if sel == "facultatifs" { not obligatoire }
  else { numero in sel }
}

// Couleur des titres de corrigés (à appeler dans un `context`).
#let couleur-sol(reglages) = if reglages.couleur-sol == auto { rouge-perso() } else { reglages.couleur-sol }

// Infos de l'exercice courant (le dernier de l'historique). À appeler dans un
// `context`. Renvoie : numero, id (identifiant unique dans le document, pour les
// liens), corrige (son corrigé doit-il apparaître ?), titre-solution.
#let infos-exercice() = {
  let hist = etat-historique.get()
  let numero = hist.len()
  let ex = hist.last()
  (
    numero: numero,
    id: str(etat-serie.get()) + "-" + str(numero),
    corrige: not ex.pas-corrige and est-selectionne(numero, ex.obligatoire, etat-selection.get().corriges),
    titre-solution: ex.titre-solution,
  )
}


// ══════════════════════════════════════════════════════════════════════════════
// 4. ÉLÉMENTS GRAPHIQUES
// ══════════════════════════════════════════════════════════════════════════════

// Mots affichés par le paquet (« Exercice », « Correction »…), en français par
// défaut. `maquette(langue: …)` choisit une autre langue ; avec `auto`, la langue
// du document (`set text(lang: …)`) est suivie, sauf l'anglais : c'est la langue
// par défaut de Typst, qu'on ne distingue pas d'un document où rien n'est réglé.
// Langue inconnue : français.
#let etat-langue = state("etat-langue-exercices", auto)
#let termes = (
  fr: (exercice: "Exercice", correction: "Correction", automatismes: "Automatismes", exo: "Exo", titre-corrige: "Corrigé de l'exercice"),
  en: (exercice: "Exercise", correction: "Solutions", automatismes: "Practice", exo: "Ex.", titre-corrige: "Solution to exercise"),
  de: (exercice: "Aufgabe", correction: "Lösungen", automatismes: "Übungen", exo: "Aufg.", titre-corrige: "Lösung zu Aufgabe"),
  es: (exercice: "Ejercicio", correction: "Soluciones", automatismes: "Práctica", exo: "Ej.", titre-corrige: "Solución del ejercicio"),
  it: (exercice: "Esercizio", correction: "Soluzioni", automatismes: "Allenamento", exo: "Es.", titre-corrige: "Soluzione dell'esercizio"),
)
// À appeler dans un `context`.
#let terme(cle) = {
  let langue = etat-langue.get()
  if langue == auto { langue = if text.lang == "en" { "fr" } else { text.lang } }
  termes.at(langue, default: termes.fr).at(cle)
}

// Facteur d'agrandissement des éléments de taille fixe (icônes, feuille de route,
// titres de thématique et de correction) : 1 jusqu'à un texte de 11 pt, puis
// proportionnel à la taille du texte. Ils ne rapetissent jamais.
// À appeler dans un `context`.
#let echelle() = calc.max(1, text.size / 11pt)

// Blocs et boîtes du paquet, protégés des réglages globaux du document : un
// `#set block(stroke: …, inset: …)` ou `#set box(…)` de l'utilisateur ne doit pas
// modifier les cadres, les icônes ni la feuille de route. Chaque propriété est
// donc donnée explicitement (une valeur explicite l'emporte sur un `set`). Le
// contenu de l'utilisateur (énoncés, corrigés), lui, garde ses propres réglages.
#let bloc-neutre = block.with(stroke: none, inset: 0pt, outset: 0pt, fill: none, radius: 0pt, clip: false)
#let boite-neutre = box.with(stroke: none, inset: 0pt, outset: 0pt, fill: none, radius: 0pt, clip: false)

// Certains blocs sont créés par Typst lui-même (`layout`, contenu d'un cercle…) et
// ne peuvent pas recevoir de valeurs explicites. `protege` neutralise donc
// `block` et `box` pour tout ce que construit le paquet, puis fournit
// `rendre(contenu)`, qui rend au contenu de l'utilisateur ses propres réglages.
//   protege(rendre => … rendre(body) …)
#let protege(construire) = context {
  let du-bloc = (
    stroke: block.stroke, inset: block.inset, outset: block.outset,
    fill: block.fill, radius: block.radius, clip: block.clip,
  )
  let de-la-boite = (
    stroke: box.stroke, inset: box.inset, outset: box.outset,
    fill: box.fill, radius: box.radius, clip: box.clip,
  )
  let rendre(contenu) = {
    set block(..du-bloc)
    set box(..de-la-boite)
    contenu
  }
  set block(stroke: none, inset: 0pt, outset: 0pt, fill: none, radius: 0pt, clip: false)
  set box(stroke: none, inset: 0pt, outset: 0pt, fill: none, radius: 0pt, clip: false)
  construire(rendre)
}

// Couleur du fond de la page (blanc par défaut), pour que les étiquettes et les
// icônes posées sur un filet le masquent sans faire de tache sur une page colorée.
// À appeler dans un `context`.
#let fond() = if type(page.fill) == color { page.fill } else { white }

// Icône du dossier `icones/` (dessin SVG recadré au plus près), dans la couleur
// `couleur`, à l'échelle d'un texte de taille `taille` : comme un caractère de
// police Font Awesome, dont 1 em vaut 512 unités du dessin.
// Un dégradé donne sa couleur du milieu, un motif donne du noir (un SVG coloré
// n'accepte qu'une couleur unie).
#let icone(nom, taille, couleur) = {
  let svg = read("icones/" + nom + ".svg")
  let hauteur = float(svg.match(regex("viewBox=\"[^\"]* ([\d.]+)\"")).captures.first())
  let teinte = if type(couleur) == color { couleur } else if type(couleur) == gradient { couleur.sample(50%) } else { black }
  image(bytes(svg.replace("currentColor", teinte.to-hex())), format: "svg", height: taille * hauteur / 512)
}

// Les éléments colorés ci-dessous sont à appeler dans un `context` (couleurs).

// Haltère cliquable (ouvre l'entraînement), inclinée à 45° comme dans
// ProfMaquette, sur le fond de la page pour se détacher du filet.
#let icone-entrainement(url) = link(url)[
  #boite-neutre(fill: fond(), inset: 3pt, radius: 2pt)[
    #rotate(45deg, reflow: true, icone("dumbbell", 14pt * echelle(), bleu-perso()))
  ]
]

// Clé menant au corrigé (VersSolution), sur le fond de la page.
#let icone-corrige() = boite-neutre(fill: fond(), inset: 2pt, radius: 2pt)[
  #icone("key", 12pt * echelle(), rouge-perso())
]

// Étiquette « Source » : petit texte bleu-perso, posé sur le filet bas.
#let etiquette-source(texte) = boite-neutre(fill: fond(), inset: 2pt, radius: 2pt)[
  #text(size: 7pt * echelle(), fill: bleu-perso())[#texte]
]

// Boîte à titre (exercices, bloc « Automatismes »), dans le style choisi par
// `maquette(style-exercice: …)` :
//   "etiquette-encadree" : titre en couleur dans un petit cadre, à cheval sur le
//                          filet haut, à 1em du bord gauche ;
//   "fond-blanc"         : titre en couleur sans cadre, sur le fond de la page,
//                          qui coupe le filet haut (défaut) ;
//   "bandeau"            : titre dans le cadre, en haut, séparé de l'énoncé par
//                          un filet ;
//   "etiquette-pleine"   : titre sur le fond de la page, dans une étiquette
//                          remplie de la couleur du titre, à cheval sur le filet.
// Un titre trop long passe à la ligne sans sortir du cadre.
// La boîte ne se coupe pas entre deux pages, sauf si elle est plus haute qu'une
// page : elle se coupe alors plutôt que de déborder (et de perdre du texte).
// `couleur-titre` : couleur du titre (auto = celle du filet).
#let boite-etiquette(couleur, titre, couleur-titre: auto, body) = layout(taille => {
  let style = etat-style.get()
  let filet = .05em + couleur
  let teinte = if couleur-titre == auto { couleur } else { couleur-titre }
  let contenu = if style == "bandeau" {
    bloc-neutre(width: 100%, spacing: 0pt, stroke: filet, radius: 5pt, {
      bloc-neutre(width: 100%, spacing: 0pt, inset: (x: 1em, y: .6em), text(fill: teinte, weight: "bold", titre))
      bloc-neutre(
        width: 100%,
        spacing: 0pt,
        stroke: (top: filet, x: none, bottom: none),
        inset: (x: 1.2em, top: .9em, bottom: 1.2em),
        body,
      )
    })
  } else {
    let etiquette = if style == "fond-blanc" {
      bloc-neutre(spacing: 0pt, fill: fond(), inset: (x: .4em, y: .5em), text(fill: teinte, weight: "bold", titre))
    } else if style == "etiquette-pleine" {
      bloc-neutre(spacing: 0pt, fill: teinte, radius: 3pt, inset: (x: .8em, y: .5em), text(fill: fond(), weight: "bold", titre))
    } else {
      bloc-neutre(spacing: 0pt, fill: fond(), stroke: filet, radius: 3pt, inset: (x: .8em, y: .5em), text(fill: teinte, weight: "bold", titre))
    }
    let largeur-etiquette = taille.width - 2em
    // Demi-hauteur de l'étiquette : place réservée au-dessus et au-dessous du filet.
    let demi = measure(etiquette, width: largeur-etiquette).height / 2
    {
      v(demi)
      bloc-neutre(width: 100%, spacing: 0pt, stroke: filet, radius: 5pt, {
        v(demi)
        place(top + left, dx: 1em, dy: -demi, bloc-neutre(width: largeur-etiquette, etiquette))
        bloc-neutre(width: 100%, spacing: 0pt, inset: (x: 1.2em, top: 1.1em, bottom: 1.2em), body)
      })
    }
  }
  let trop-haute = measure(contenu, width: taille.width).height > taille.height
  bloc-neutre(width: 100%, breakable: trop-haute, contenu)
})

// Boîte d'un exercice. Obligatoire : filet et titre dans la couleur des
// obligatoires. Facultatif : filet gris très clair, titre gris foncé (lisible) ;
// avec une étiquette pleine, gris moyen, pour que l'étiquette ne ressorte pas
// plus que celle d'un obligatoire.
// À appeler dans un `context`.
#let boite-exercice(numero: none, titre: none, obligatoire: true, body) = {
  let couleur = etat-couleur-obligatoire.get()
  let gris-titre = if etat-style.get() == "etiquette-pleine" { luma(60%) } else { luma(35%) }
  boite-etiquette(
    if obligatoire { couleur } else { luma(82%) },
    couleur-titre: if obligatoire { couleur } else { gris-titre },
    [#terme("exercice") #numero#if titre != none [ : #titre]],
    body,
  )
}

// Rendu d'un corrigé (dans un `context`). Le `metadata` sert de cible à la clé de l'exercice ; le
// titre (en couleur, le texte restant en noir) ramène à l'exercice.
#let rendu-corrige(item, reglages, rendre: c => c) = bloc-neutre(width: 100%, above: 1.4em, below: 1em)[
  #metadata("corrige-" + item.id)
  #let titre = text(weight: "bold", fill: couleur-sol(reglages))[
    #if reglages.titre-corrige == auto { terme("titre-corrige") } else { reglages.titre-corrige } #item.numero#if item.titre != none [ : #item.titre]
  ]
  // Titre dans son propre bloc : le corrigé commence à la ligne suivante, et le
  // titre n'est jamais laissé seul en bas de page (sticky).
  #bloc-neutre(width: 100%, below: .8em, sticky: true, context {
    let cible = query(metadata.where(value: "exercice-" + item.id))
    if reglages.vers-solution and cible.len() > 0 { link(cible.first().location(), titre) } else { titre }
  })
  #rendre(item.body)
]


// ══════════════════════════════════════════════════════════════════════════════
// 5. API PUBLIQUE
// ══════════════════════════════════════════════════════════════════════════════

// ─── Réglages (à appeler avant le premier exercice) ──────────────────────────
// Inutiles avec `maquette`, qui les appelle elle-même.

// Couleurs du paquet (cf. section 1) ; auto = inchangée.
#let reglages-couleurs(bleu-perso: auto, rouge-perso: auto) = etat-couleurs.update(c => (
  bleu: if bleu-perso == auto { c.bleu } else { bleu-perso },
  rouge: if rouge-perso == auto { c.rouge } else { rouge-perso },
))

// Réglages des corrigés (équivalent des clés de l'environnement Maquette).
//   mode          : none (aucun corrigé) | "apres" (CorrigeApres) | "fin" (CorrigeFin)
//   vers-solution : clé cliquable exercice ↔ corrigé (VersSolution)
//   couleur-sol   : couleur des titres « Correction » et « Corrigé de l'exercice N »
//                   (auto = rouge-perso)
//   titre-corrige : début du titre de chaque corrigé (TitreCorrige ; auto =
//                   « Corrigé de l'exercice », ou sa traduction)
//   colonnes      : nombre de colonnes de la Correction en fin de fiche (Colonnes)
//   nouvelle-page : la Correction commence sur une nouvelle page (false : elle
//                   suit la fiche, indispensable dans `columns(…)` ou un cadre)
#let reglages-corriges(
  mode: "fin",
  vers-solution: true,
  couleur-sol: auto,
  titre-corrige: auto,
  colonnes: 1,
  nouvelle-page: true,
) = {
  assert(
    mode in (none, "apres", "fin"),
    message: "reglages-corriges : mode doit valoir none, \"apres\" ou \"fin\".",
  )
  assert(
    type(colonnes) == int and colonnes >= 1,
    message: "Correction : le nombre de colonnes doit être un entier supérieur ou égal à 1.",
  )
  etat-reglages-corriges.update((
    mode: mode,
    vers-solution: vers-solution,
    couleur-sol: couleur-sol,
    titre-corrige: titre-corrige,
    colonnes: colonnes,
    nouvelle-page: nouvelle-page,
  ))
}

// Couleur des exercices obligatoires pour toute la fiche (noir par défaut).
#let couleur-exercices-obligatoires(couleur) = etat-couleur-obligatoire.update(couleur)

// Style des cadres d'exercice et du bloc « Automatismes » pour toute la fiche
// (cf. `boite-etiquette`) : "fond-blanc" (défaut), "etiquette-encadree",
// "bandeau" ou "etiquette-pleine".
#let style-exercices(style) = {
  assert(
    style in styles-exercice,
    message: "style-exercice doit valoir " + styles-exercice.map(s => "\"" + s + "\"").join(", ", last: " ou ") + ", pas " + repr(style) + ".",
  )
  etat-style.update(style)
}

// ─── Exercices et corrigés ───────────────────────────────────────────────────

// Un exercice, numéroté automatiquement.
//   titre          : titre affiché après « Exercice N : » (none : pas de titre)
//   entrainement   : URL d'un entraînement en ligne → haltère sur le filet droit
//                    et QR code dans le bloc « Automatismes » (clé AEntretenir)
//   source         : texte libre sur le filet bas, ex. les exercices à faire dans
//                    la ressource du QR code (clé Source)
//   obligatoire    : true = couleur des obligatoires (clés Route / Stop) ;
//                    false = gris (exercice facultatif)
//   pas-corrige    : true = jamais de corrigé, même si un `#solution` suit
//                    (clé PasCorrige)
//   titre-solution : complément du titre du corrigé (clé TitreSolution)
//   stop           : true = coche de validation après cet exercice sur la feuille
//                    de route (clé Stop). Rarement utile : `thematique` place
//                    déjà une coche (cf. `afficher-fdr`).
#let exercice(
  titre: none,
  entrainement: none,
  source: none,
  obligatoire: true,
  pas-corrige: false,
  titre-solution: none,
  stop: false,
  body,
) = {
  // Mise à jour hors `context`, avec des valeurs fixes (cf. Notes techniques).
  etat-historique.update(h => h + ((
    obligatoire: obligatoire,
    pas-corrige: pas-corrige,
    titre-solution: titre-solution,
    titre: titre,
    entrainement: entrainement,
  ),))
  protege(rendre => bloc-neutre(width: 100%)[
    #context {
      let infos = infos-exercice()
      let numero = infos.numero
      let boite = boite-exercice(numero: numero, titre: titre, obligatoire: obligatoire, rendre(body))

      // Clé vers le corrigé : seulement si un corrigé est réellement affiché.
      // Le choix de la mise en page (boîte mesurée ou non) dépend de `cle-possible`
      // et PAS du résultat de la requête, sinon le document ne converge pas.
      let reglages = etat-reglages-corriges.get()
      let cle-possible = reglages.vers-solution and reglages.mode != none and infos.corrige
      let cible = query(metadata.where(value: "corrige-" + infos.id))
      let avec-cle = cle-possible and cible.len() > 0
      [#metadata("exercice-" + infos.id)]
      [#metadata((numero: numero, obligatoire: obligatoire, stop: stop)) #repere-exercice]

      // Place à droite du cadre (marge ou entre-colonne) : si elle ne suffit pas à
      // la moitié d'une icône, les icônes sont posées à l'intérieur du filet au
      // lieu d'être à cheval dessus (sinon la page les couperait).
      let x-gauche = here().position().x
      if entrainement != none or source != none or cle-possible { layout(dispo => {
        let marge-droite = if type(page.width) == length { page.width - x-gauche - dispo.width } else { 1cm }
        let decalage(icone) = {
          let largeur = measure(icone).width
          if marge-droite >= largeur / 2 + 1pt { largeur / 2 } else { -3pt }
        }
        let hauteur-boite = measure(bloc-neutre(width: dispo.width)[#boite]).height
        // Exercice plus haut qu'une page : la boîte se coupe entre les pages (cf.
        // `boite-etiquette`) et ne peut plus être mesurée d'un seul tenant ; les
        // icônes vont en haut du filet droit, la source à la fin de l'énoncé.
        if hauteur-boite > dispo.height {
          let icones = ()
          if avec-cle { icones.push(link(cible.first().location(), icone-corrige())) }
          if entrainement != none { icones.push(icone-entrainement(entrainement)) }
          let corps = rendre(body) + if source != none { align(right, etiquette-source(source)) }
          return bloc-neutre(width: 100%, {
            for (k, icone) in icones.enumerate() {
              let taille = measure(icone)
              place(top + right, dx: decalage(icone), dy: 1.5cm + k * 1cm - taille.height / 2, icone)
            }
            boite-exercice(numero: numero, titre: titre, obligatoire: obligatoire, corps)
          })
        }
        boite-neutre(height: hauteur-boite, width: 100%)[
          #boite
          // Icônes à cheval sur le filet droit : une seule icône est centrée
          // verticalement ; clé + haltère : clé à 1/3 de la hauteur, haltère à 2/3.
          #let a-droite(icone, fraction) = {
            let taille = measure(icone)
            place(top + right, dx: decalage(icone), dy: hauteur-boite * fraction - taille.height / 2, icone)
          }
          #if avec-cle {
            let fraction = if entrainement != none { 1 / 3 } else { 1 / 2 }
            a-droite(link(cible.first().location(), icone-corrige()), fraction)
          }
          #if entrainement != none {
            let fraction = if avec-cle { 2 / 3 } else { 1 / 2 }
            a-droite(icone-entrainement(entrainement), fraction)
          }
          // Source : à cheval sur le filet bas, côté droit.
          #if source != none [
            #context {
              // Une source longue passe à la ligne (60 % de la largeur au plus).
              let etiquette = etiquette-source(source)
              let largeur = calc.min(measure(etiquette).width, dispo.width * 60%)
              let etiquette = bloc-neutre(width: largeur, align(right, etiquette))
              let hauteur-etiquette = measure(etiquette).height
              place(bottom + right, dx: -10pt, dy: hauteur-etiquette / 2, etiquette)
            }
          ]
        ]
      }) } else {
        boite
      }
    }
  ])
}

// Corrigé de l'exercice qui précède (environnement Solution). Ignoré si le mode
// est none, si l'exercice porte `pas-corrige: true`, ou s'il est hors de la
// sélection `corriges`. Le contenu peut venir d'un fichier séparé :
//   #import "CH_01_EXO_01.typ" as exo01
//   #solution(exo01.corrige)
#let solution(body) = protege(rendre => context {
  let reglages = etat-reglages-corriges.get()
  if reglages.mode == none or etat-historique.get().len() == 0 { return }
  let infos = infos-exercice()
  if not infos.corrige { return }
  let item = (numero: infos.numero, id: infos.id, titre: infos.titre-solution, body: body)
  if reglages.mode == "apres" {
    rendu-corrige(item, reglages, rendre: rendre)
  } else {
    etat-solutions.update(lst => lst + (item,))
  }
})

// Titre d'une thématique de la fiche (« Calculer avec les suites », « Monotonie »…) :
// texte en gras, 14 pt, jamais numéroté. Ce n'est pas un `heading` : il ne dépend
// pas des réglages de titres du document (numérotation, `show heading`…) et
// n'apparaît pas dans la table des matières. Sur la feuille de route, chaque
// thématique termine la précédente : une coche suit son dernier exercice.
//   alignement : left (défaut), center ou right
#let thematique(alignement: left, titre) = {
  [#metadata(none) #repere-thematique]
  protege(rendre => bloc-neutre(width: 100%, above: 1.4em, below: .9em, sticky: true, align(
    alignement,
    text(size: 14pt * echelle(), weight: "bold", rendre(titre)),
  )))
}

// Repart de l'exercice 1 (plusieurs fiches indépendantes dans un même document).
#let reinitialiser-compteur-exercice() = {
  etat-historique.update(())
  etat-serie.update(n => n + 1)
  etat-blocs-fin.update((entrainements: false, corriges: false))
  [#metadata(none) #repere-borne]
}

// ─── Blocs de fin de fiche ───────────────────────────────────────────────────
// Appelés automatiquement par `maquette` ; à appeler à la main sinon, une seule
// fois, dans cet ordre (comme ProfMaquette : entraînements, puis corrections).

// Bloc « Automatismes » : tous les QR codes d'entraînement, dans une boîte bleu-perso.
// Flottant en bas de la dernière page s'il reste de la place, sinon en bas de la
// suivante (pas de saut de page forcé). S'il occuperait plus des trois quarts
// d'une page, il ne flotte pas : il suit la fiche et peut se couper entre deux pages.
//   colonnes  : nombre de QR codes par ligne
//   taille-qr : côté commun des QR codes (sinon une URL longue donne un QR code
//               plus grand). Une URL trop longue pour cette taille (plus de 150
//               caractères pour 2 cm) donne un QR code agrandi, pour rester lisible.
#let liste-entrainements(colonnes: 3, taille-qr: 2cm) = protege(_ => context {
  assert(
    type(colonnes) == int and colonnes >= 1,
    message: "Automatismes : le nombre de colonnes doit être un entier supérieur ou égal à 1.",
  )
  if etat-blocs-fin.get().entrainements { return }
  let items = etat-historique.get().enumerate()
    .filter(((i, ex)) => ex.entrainement != none)
    .map(((i, ex)) => (numero: i + 1, titre: ex.titre, url: ex.entrainement))
  // Côté minimal d'un QR code lisible une fois imprimé : 0,4 mm par module. Le
  // nombre de modules (17 + 4 × version) dépend de la longueur de l'URL
  // (capacités en octets des versions 1 à 30, correction d'erreurs M).
  let capacites = (14, 26, 42, 62, 84, 106, 122, 152, 180, 213, 251, 287, 331, 362, 412,
    450, 504, 560, 624, 666, 711, 779, 857, 911, 997, 1059, 1125, 1190, 1264, 1370)
  let cote-minimal(url) = {
    let version = capacites.position(c => c >= url.len())
    (17 + 4 * (if version == none { 30 } else { version + 1 })) * .4mm
  }
  if items.len() > 0 {
    let lignes = calc.ceil(items.len() / colonnes)
    let hauteur-estimee = lignes * (taille-qr.to-absolute() + 30pt) + 50pt
    let flottant = type(page.height) == length and hauteur-estimee < .75 * page.height
    let bloc = boite-etiquette(bleu-perso(), terme("automatismes"))[
        #grid(
          columns: (1fr,) * colonnes,
          row-gutter: 18pt,
          column-gutter: 12pt,
          stroke: none,
          fill: none,
          inset: 0pt,
          align: center + top,
          // Le QR code ne dépasse jamais sa colonne (marges larges, beaucoup de colonnes).
          // Une case ne se coupe pas : son numéro reste au-dessus de son QR code.
          ..items.map(it => bloc-neutre(breakable: false)[
            #text(weight: "bold")[#terme("exo") #it.numero]
            #v(4pt)
            #layout(case => link(it.url, qrcode(
              it.url,
              options: (fg-color: bleu-perso()),
              width: calc.min(calc.max(taille-qr.to-absolute(), cote-minimal(it.url)), case.width),
            )))
          ])
        )
      ]
    if flottant { place(bottom, float: true, clearance: 1.5em, bloc) } else { bloc }
    etat-blocs-fin.update(b => b + (entrainements: true))
  }
})

// Bloc « Correction » : tous les corrigés (mode "fin"), sur une nouvelle page
// sauf réglage `nouvelle-page: false`.
#let liste-corriges() = protege(rendre => context {
  let reglages = etat-reglages-corriges.get()
  let items = etat-solutions.get()
  if reglages.mode != "fin" or items.len() == 0 or etat-blocs-fin.get().corriges { return }
  if reglages.nouvelle-page { pagebreak(weak: true) }
  let couleur = couleur-sol(reglages)
  bloc-neutre(
    width: 100%,
    stroke: (top: none, x: none, bottom: 1.5pt + couleur),
    inset: (top: 0pt, x: 0pt, bottom: 0.6em),
    below: 1.2em,
  )[
    #text(size: 16pt * echelle(), weight: "bold", fill: couleur, terme("correction"))
  ]
  columns(reglages.colonnes, gutter: 1.5em, items.map(it => rendu-corrige(it, reglages, rendre: rendre)).join())
  etat-blocs-fin.update(b => b + (corriges: true))
})

// ─── Feuille de route ────────────────────────────────────────────────────────

// Découpe les exercices en tronçons (un tronçon se termine après chaque exercice
// dont `stop` est vrai, et à la fin) et les place en colonnes, comme \BuildRouteTikz :
// dans chaque tronçon, les obligatoires vont sur la ligne du bas, les
// facultatifs sur celle du haut ; la plus courte est complétée par des vides
// (none), puis vient une colonne « coche ». Renvoie un tronçon par élément :
//   bas, haut   : une case par colonne — un exercice, none (vide) ou "coche" ;
//   facultatifs : le tronçon a-t-il des exercices facultatifs ?
#let colonnes-fdr(exos) = {
  let troncons = ((),)
  for ex in exos {
    troncons.last().push(ex)
    if ex.stop { troncons.push(()) }
  }
  if troncons.last() == () and troncons.len() > 1 { let _ = troncons.pop() }
  troncons.map(t => {
    let obl = t.filter(ex => ex.obligatoire)
    let fac = t.filter(ex => not ex.obligatoire)
    let n = calc.max(obl.len(), fac.len())
    (
      bas: obl + (none,) * (n - obl.len()) + ("coche",),
      haut: fac + (none,) * (n - fac.len()) + ("coche",),
      facultatifs: fac.len() > 0,
    )
  })
}

// Schéma de la feuille de route (clé FdR, commande \AfficheFdR de ProfMaquette),
// à placer dans la maquette, en général avant le premier exercice :
//
//   #maquette[
//     #align(center, afficher-fdr)
//     #thematique[Factoriser]
//     #exercice[…]                            // obligatoire : route du bas
//     #exercice(obligatoire: false)[…]        // facultatif : ligne du haut
//     #thematique[Résoudre]                   // coche avant cette thématique
//     #exercice[…]
//   ]                                         // coche finale
//
// Les coches : chaque `thematique` de la maquette termine le tronçon en cours ;
// une coche est placée après le dernier exercice qui la précède. Une thématique
// située avant le premier exercice ne place pas de coche. Les titres (`=`, `==`…)
// n'ont aucun effet. `exercice(stop: true)` ajoute une coche à la main.
//
// L'élève fait les exercices de la route du bas jusqu'à la coche, puis demande
// la validation ; l'enseignant peut alors lui proposer les exercices de la ligne
// du haut (les facultatifs du même tronçon) avant qu'il poursuive la route.
// Chaque disque est un lien vers son exercice.
//
// C'est un contenu, pas une fonction : on écrit `#afficher-fdr`, sans
// parenthèses. Il est en noir et blanc (disques pleins : obligatoires ; disques
// blancs : facultatifs) ; sa couleur se règle avec `maquette(couleur-fdr: …)`.
#let afficher-fdr = protege(_ => context {
  // Exercices situés entre les deux bornes qui entourent le schéma.
  let avant = query(selector(repere-borne).before(here()))
  let apres = query(selector(repere-borne).after(here()))
  let sel = selector(repere-exercice)
  if avant.len() > 0 { sel = sel.after(avant.last().location()) }
  if apres.len() > 0 { sel = sel.before(apres.first().location()) }
  let exos = query(sel).map(m => m.value + (lieu: m.location()))
  if exos.len() == 0 { return }
  let reglages = etat-fdr.get()

  // Coches venant des thématiques : pour chaque thématique de la maquette, on
  // cherche le premier exercice qui la suit ; celui qui le précède reçoit une coche.
  let themes = selector(repere-thematique)
  if avant.len() > 0 { themes = themes.after(avant.last().location()) }
  if apres.len() > 0 { themes = themes.before(apres.first().location()) }
  for theme in query(themes) {
    let suivants = query(selector(repere-exercice).after(theme.location()))
    if suivants.len() == 0 { continue }
    let i = exos.position(ex => ex.lieu == suivants.first().location())
    if i != none and i > 0 { exos.at(i - 1).stop = true }
  }

  let couleur = reglages.couleur
  // Dimensions voisines de celles de ProfMaquette (clés Ecart, Rayon, Hauteur).
  let e = echelle()
  let ecart = 7.5mm * e
  let rayon = 2.6mm * e
  let hauteur = 1cm * e

  let troncons = colonnes-fdr(exos)
  let n = troncons.map(t => t.bas.len()).sum()
  // Colonne i de toute la route → abscisse (colonne 0 : départ, cases 1 à n).
  let x(i) = i * ecart + rayon
  let y-haut = rayon
  let y-bas = hauteur + rayon
  let trait(x1, y1, x2, y2, epaisseur: .6pt) = place(
    line(start: (x1, y1), end: (x2, y2), stroke: epaisseur + couleur),
  )
  let pastille(x0, y, contenu) = place(
    dx: x0 - rayon,
    dy: y - rayon,
    circle(radius: rayon, fill: fond(), stroke: none, inset: 0pt, outset: 0pt, align(center + horizon, contenu)),
  )
  let disque(x0, y, ex, plein) = place(
    dx: x0 - rayon,
    dy: y - rayon,
    link(ex.lieu, circle(
      radius: rayon,
      fill: if plein { couleur } else { fond() },
      stroke: .6pt + couleur,
      inset: 0pt,
      outset: 0pt,
      align(center + horizon, text(
        size: 7pt * e,
        weight: "bold",
        fill: if plein { fond() } else { couleur },
        str(ex.numero),
      )),
    )),
  )

  // Un dessin par tronçon. Mis bout à bout, ils forment la route entière ; séparés
  // par une espace de largeur nulle, ils passent à la ligne entre deux tronçons
  // quand la route est plus large que la page.
  let dessins = ()
  let debut = 0 // nombre de colonnes des tronçons précédents
  for (k, t) in troncons.enumerate() {
    let m = t.bas.len()
    let premier = k == 0
    let dernier = k == troncons.len() - 1
    let gauche = if premier { 0pt } else { x(debut + 1) - ecart / 2 }
    let droite = if dernier { x(n + 1) + rayon } else { x(debut + m) + ecart / 2 }
    let X(j) = x(debut + j) - gauche // abscisse de la j-ième case du tronçon
    dessins.push(boite-neutre(width: droite - gauche, height: y-bas + rayon, {
      // Ligne du haut : du premier facultatif jusqu'au-dessus de la coche, puis
      // descente vers la coche.
      if t.facultatifs {
        trait(X(1), y-haut, X(m), y-haut)
        trait(X(m), y-haut, X(m), y-bas)
      }
      // Route du bas, terminée par une flèche au dernier tronçon.
      let fin = if dernier { x(n + 1) - 2mm * e - gauche } else { droite - gauche }
      trait(if premier { x(0) } else { 0pt }, y-bas, fin, y-bas, epaisseur: 1.2pt)
      if dernier {
        place(dx: x(n + 1) - 2.4mm * e - gauche, dy: y-bas - 1.3mm * e, polygon(
          fill: couleur,
          stroke: none,
          (0mm, 0mm), (2.4mm * e, 1.3mm * e), (0mm, 2.6mm * e),
        ))
      }
      for (j, case) in t.bas.enumerate(start: 1) {
        if case == "coche" { pastille(X(j), y-bas, icone("check", 9pt * e, couleur)) }
        else if case != none { disque(X(j), y-bas, case, true) }
      }
      for (j, case) in t.haut.enumerate(start: 1) {
        if type(case) == dictionary { disque(X(j), y-haut, case, false) }
      }
    }))
    debut += m
  }
  {
    set par(justify: false, first-line-indent: 0pt, hanging-indent: 0pt, leading: 4mm)
    set text(dir: ltr) // la route va toujours de gauche à droite, même en arabe ou en hébreu
    bloc-neutre(dessins.join([#sym.zws]))
  }
})

// ─── maquette ────────────────────────────────────────────────────────────────

// Englobe toute la fiche et la règle en un seul endroit (environnement Maquette).
// Chaque maquette est indépendante : elle repart de l'exercice 1, sans les
// entraînements ni les corrigés d'une maquette précédente du même document.
// Ajoute à la fin les blocs « Automatismes » puis « Correction » : ne plus
// appeler `liste-entrainements` ni `liste-corriges` à la main.
//
//   #maquette(afficher-corrige: "fin", corriges: "1-6,9,12")[ … ]
//   ou, en tête de fiche : #show: maquette.with(…)
//
//   afficher-corrige      : none/false (sujet seul) | "apres" (sous chaque énoncé)
//                           | "fin"/true (en fin de fiche)
//   corriges              : corrigés affichés : auto (tous), 4, "1-6,9,12",
//                           (1, "3-5"), "obligatoires" ou "facultatifs".
//                           Les énoncés, eux, sont toujours tous affichés.
//   vers-solution         : clé cliquable exercice ↔ corrigé (VersSolution)
//   bleu-perso            : couleur des liens extérieurs (haltère, QR, source)
//   rouge-perso           : couleur de navigation (clé, corrigés)
//   couleur-sol           : couleur des titres de corrigés (CouleurSol ;
//                           auto = rouge-perso)
//   titre-corrige         : début du titre de chaque corrigé (TitreCorrige ;
//                           auto = « Corrigé de l'exercice », ou sa traduction)
//   colonnes-corriges     : colonnes de la Correction (Colonnes)
//   correction-nouvelle-page : la Correction commence sur une nouvelle page
//                           (false : elle suit la fiche ; indispensable pour une
//                           maquette placée dans `columns(…)` ou dans un cadre)
//   couleur-obligatoire   : couleur des exercices obligatoires (auto = noir)
//   style-exercice        : style des cadres : "fond-blanc" (défaut),
//                           "etiquette-encadree", "bandeau" ou "etiquette-pleine"
//   colonnes-automatismes : QR codes par ligne dans « Automatismes »
//   taille-qr             : côté des QR codes
//   couleur-fdr           : couleur du schéma `afficher-fdr` (noir par défaut)
//   langue                : langue des mots du paquet : "fr", "en", "de", "es",
//                           "it" ; auto = celle du document, sauf l'anglais (défaut
//                           de Typst) qui donne le français : écrire "en" pour
//                           l'anglais
#let maquette(
  afficher-corrige: "fin",
  corriges: auto,
  vers-solution: true,
  bleu-perso: auto,
  rouge-perso: auto,
  couleur-sol: auto,
  titre-corrige: auto,
  colonnes-corriges: 1,
  correction-nouvelle-page: true,
  couleur-obligatoire: auto,
  style-exercice: "fond-blanc",
  colonnes-automatismes: 3,
  taille-qr: 2cm,
  couleur-fdr: black,
  langue: auto,
  body,
) = {
  // Réglages invalides : message clair plutôt qu'une erreur de Typst plus loin.
  let est-couleur(c) = type(c) in (color, gradient, tiling)
  for (nom, valeur) in (
    bleu-perso: bleu-perso,
    rouge-perso: rouge-perso,
    couleur-sol: couleur-sol,
    couleur-obligatoire: couleur-obligatoire,
    couleur-fdr: couleur-fdr,
  ) {
    assert(
      valeur == auto or est-couleur(valeur),
      message: "maquette : " + nom + " doit être une couleur (blue, rgb(\"#0090C8\")…), pas " + repr(valeur) + ".",
    )
  }
  assert(type(taille-qr) == length, message: "maquette : taille-qr doit être une longueur (2cm, 15mm…).")
  reglages-couleurs(bleu-perso: bleu-perso, rouge-perso: rouge-perso)
  let mode = if afficher-corrige == false { none } else if afficher-corrige == true { "fin" } else { afficher-corrige }
  reglages-corriges(
    mode: mode,
    vers-solution: vers-solution,
    couleur-sol: couleur-sol,
    titre-corrige: titre-corrige,
    colonnes: colonnes-corriges,
    nouvelle-page: correction-nouvelle-page,
  )
  if couleur-obligatoire != auto { couleur-exercices-obligatoires(couleur-obligatoire) }
  style-exercices(style-exercice)
  etat-selection.update((corriges: parser-plage(corriges)))
  etat-fdr.update((couleur: couleur-fdr))
  etat-langue.update(langue)
  etat-historique.update(())
  etat-serie.update(n => n + 1)
  etat-solutions.update(())
  etat-blocs-fin.update((entrainements: false, corriges: false))
  etat-profondeur.update(n => n + 1)
  context assert(
    etat-profondeur.get() == 1,
    message: "maquette : une maquette ne peut pas en contenir une autre. Pour plusieurs fiches dans un même document, placer les maquettes l'une après l'autre.",
  )
  [#metadata(none) #repere-borne]
  body
  [#metadata(none) #repere-borne]
  liste-entrainements(colonnes: colonnes-automatismes, taille-qr: taille-qr)
  liste-corriges()
  etat-profondeur.update(n => n - 1)
}
