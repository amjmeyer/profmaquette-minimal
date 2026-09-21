// Manuel du paquet template-exercices.
//
// Compilation (depuis la racine du paquet) : ./tester.sh, ou
//   typst compile --root . docs/manuel.typ docs/manuel.pdf
//
// Le manuel importe le paquet par son fichier source (`../src/lib.typ`) : il
// documente donc toujours le code actuel, même avant publication. Il n'importe
// rien d'autre que gentle-clues (encadrés Info, Astuce, Attention).

#import "../src/lib.typ" as paquet
#import "@preview/gentle-clues:1.3.1": info, tip, warning

#let manifeste = toml("../typst.toml").package


// ══════════════════════════════════════════════════════════════════════════════
// OUTILS DU MANUEL
// ══════════════════════════════════════════════════════════════════════════════

// Un exemple : le code (à gauche) et son rendu (à droite), ou l'un sous l'autre
// avec `dessous: true` pour les exemples larges. Le code est écrit une seule
// fois : le rendu ne peut pas se désynchroniser de ce qu'on montre.
//
// Chaque exemple a sa propre `maquette` (numérotation, corrigés et feuille de
// route indépendants). Les sauts de page sont neutralisés : ils sont interdits
// dans un cadre (le bloc « Correction » en demande un).
#let exemple(dessous: false, code) = {
  let source = block(
    width: 100%,
    fill: luma(96%),
    radius: 4pt,
    inset: 8pt,
    text(size: 8.5pt, raw(code.text, lang: "typ", block: true)),
  )
  let rendu = block(width: 100%, stroke: .5pt + luma(75%), radius: 4pt, inset: 10pt, {
    show pagebreak: none
    set text(size: 9pt)
    eval(code.text, mode: "markup", scope: dictionary(paquet))
  })
  block(breakable: false, above: 1.2em, below: 1.2em, if dessous {
    stack(spacing: 6pt, source, rendu)
  } else {
    grid(columns: (1fr, 1fr), column-gutter: 10pt, source, rendu)
  })
}

// Fiche d'un paramètre : nom, type(s) et valeur par défaut, puis description.
//   #parametre("afficher-corrige", ("none", "str"), `"fin"`)[…]
#let parametre(nom, types, defaut, description) = block(
  width: 100%,
  inset: (left: 10pt, y: 4pt),
  stroke: (left: 2pt + luma(80%)),
  breakable: false,
  {
    raw(nom)
    h(6pt)
    for t in types { box(fill: luma(92%), inset: (x: 3pt, y: 1pt), radius: 2pt, text(size: 8pt, raw(t))) + h(3pt) }
    h(1fr)
    text(size: 8.5pt, fill: luma(40%))[défaut : #defaut]
    linebreak()
    description
  },
)

// Paragraphe encore à rédiger (à supprimer au fur et à mesure).
#let a-ecrire(texte) = block(
  width: 100%,
  inset: 8pt,
  radius: 4pt,
  stroke: (paint: luma(70%), dash: "dashed"),
  text(fill: luma(45%), style: "italic")[À écrire — #texte],
)

// ─── Historique des versions, lu dans CHANGELOG.md ───────────────────────────
// Convertit le petit sous-ensemble de Markdown utilisé dans CHANGELOG.md (titres
// `##`, listes `-` imbriquées de deux espaces, lignes de suite, `code`, **gras**)
// sans paquet supplémentaire. Le texte n'est jamais interprété comme du Typst :
// un `#`, un `$` ou un `_` du CHANGELOG s'affiche tel quel.

// Texte d'une ligne : `code` et **gras**.
#let md-en-ligne(texte) = {
  for (i, morceau) in texte.split("`").enumerate() {
    if calc.odd(i) { raw(morceau) } else {
      for (j, bout) in morceau.split("**").enumerate() {
        if calc.odd(j) { strong(bout) } else { bout }
      }
    }
  }
}

// Liste imbriquée à partir d'éléments (niveau, texte) consécutifs.
#let md-liste(elements) = {
  let base = elements.first().niveau
  let groupes = ()
  for el in elements {
    if el.niveau <= base or groupes.len() == 0 { groupes.push((texte: el.texte, enfants: ())) }
    else { groupes.at(-1).enfants.push(el) }
  }
  list(..groupes.map(g => {
    md-en-ligne(g.texte)
    if g.enfants.len() > 0 { md-liste(g.enfants) }
  }))
}

// Tout le fichier. Le titre `#` du fichier est ignoré (le manuel a le sien) ;
// chaque `## version` devient un titre de niveau `niveau`.
#let historique(source, niveau: 2) = {
  let elements = ()
  for ligne in source.split("\n") {
    let item = ligne.match(regex("^( *)[-*] (.*)$"))
    if ligne.trim() == "" { elements.push((type: "vide")) }
    else if ligne.starts-with("# ") { }
    else if ligne.starts-with("## ") { elements.push((type: "titre", texte: ligne.slice(3).trim())) }
    else if item != none {
      elements.push((type: "item", niveau: calc.quo(item.captures.at(0).len(), 2), texte: item.captures.at(1)))
    } else if elements.len() > 0 and elements.last().type in ("item", "texte") {
      elements.at(-1).texte += " " + ligne.trim()
    } else { elements.push((type: "texte", texte: ligne.trim())) }
  }
  let tampon = ()
  for el in elements + ((type: "vide"),) {
    if el.type == "item" { tampon.push(el); continue }
    if tampon.len() > 0 { md-liste(tampon); tampon = () }
    if el.type == "titre" { heading(level: niveau, numbering: none, md-en-ligne(el.texte)) }
    else if el.type == "texte" { par(md-en-ligne(el.texte)) }
  }
}


// ══════════════════════════════════════════════════════════════════════════════
// MISE EN PAGE
// ══════════════════════════════════════════════════════════════════════════════

#set document(title: "Manuel de " + manifeste.name, author: manifeste.authors)
#set page(paper: "a4", margin: (x: 2cm, y: 2.2cm), numbering: "1 / 1")
#set text(lang: "fr", size: 10.5pt)
#set par(justify: true)
#set heading(numbering: "1.1", supplement: [partie])
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(1em)
  it
  v(.5em)
}
#show raw.where(block: false): box.with(fill: luma(94%), inset: (x: 2pt), outset: (y: 2pt), radius: 2pt)


// ══════════════════════════════════════════════════════════════════════════════
// PAGE DE TITRE
// ══════════════════════════════════════════════════════════════════════════════

#align(center)[
  #v(3cm)
  #text(size: 26pt, weight: "bold", manifeste.name)
  #v(.3em)
  #text(size: 12pt)[version #manifeste.version]
  #v(1em)
  #text(size: 13pt)[Fiches d'exercices à la manière de ProfMaquette]
  #v(.5em)
  #manifeste.authors.join(", ")
  #v(2cm)
]

#block(inset: (x: 1.5cm))[
  #manifeste.name sert à composer des fiches d'exercices avec Typst. On écrit
  les énoncés et leurs corrigés à la suite, et le paquet se charge du reste :

  - les exercices sont encadrés et numérotés automatiquement ;
  - chaque exercice est *obligatoire* ou *facultatif* (en gris) ;
  - une *feuille de route* montre à l'élève le parcours de la fiche : les
    exercices obligatoires, les facultatifs et les étapes à faire valider ;
  - un *entraînement en ligne* s'ouvre d'un clic sur l'exercice, et son QR code
    est regroupé en fin de fiche ;
  - les *corrigés* s'affichent sous chaque énoncé, en fin de fiche ou pas du
    tout, et l'on choisit lesquels, d'un seul réglage.

  Le même fichier donne ainsi la fiche élève et la fiche corrigée. Le paquet
  s'adresse d'abord aux enseignants, en particulier de mathématiques.
]

#v(1fr)
#info(title: "Un portage partiel de ProfMaquette")[
  #manifeste.name s'inspire directement du package LaTeX
  #link("https://ctan.org/pkg/profmaquette")[ProfMaquette] de *Christophe
  Poulain*, dont il ne reprend qu'une petite partie. Il a d'abord été écrit pour
  un usage personnel et pourra évoluer, y compris de façon incompatible entre
  deux versions `0.x`.
]

#pagebreak()
#outline(depth: 2)


// ══════════════════════════════════════════════════════════════════════════════
// 1. DÉMARRER
// ══════════════════════════════════════════════════════════════════════════════

= Démarrer

== Importer le paquet

#raw(block: true, lang: "typ", "#import \"@preview/" + manifeste.name + ":" + manifeste.version + "\": *")

Dans la suite du manuel, cette ligne est sous-entendue au début de chaque
exemple.

#warning(title: "Polices Font Awesome")[
  La clé et l'haltère sont des icônes Font Awesome : il faut installer sur
  l'ordinateur les polices « Font Awesome Free » (version _desktop_, fichiers
  `.otf`). Sur la web app Typst, déposer ces fichiers dans le projet.
]

== Une première fiche

Toute la fiche se place dans une `maquette`. Elle règle la fiche en un seul
endroit, et ajoute à la fin les blocs de fin : les entraînements en ligne, puis
les corrigés. Chaque exercice est suivi de son corrigé, écrit avec `solution`.

#exemple(```typ
#maquette[
  #exercice(titre: "Factoriser")[
    Factoriser $x^2 - 9$.
  ]
  #solution[$(x - 3)(x + 3)$]
]
```)

Par défaut, les corrigés sont regroupés dans un bloc « Correction », en fin de
fiche et sur une nouvelle page. La clé sur le filet droit de l'exercice est un
lien vers son corrigé ; le titre du corrigé ramène à l'exercice.

#tip(title: "Sans crochets autour de la fiche")[
  `#show: maquette.with(…)` en tête de fichier a le même effet que
  `#maquette(…)[…]` autour de toute la fiche.
]

== Les fonctions du paquet

#table(
  columns: (auto, 1fr),
  stroke: none,
  inset: (x: 6pt, y: 4pt),
  table.hline(stroke: .6pt),
  table.header[*Fonction*][*Rôle*],
  table.hline(stroke: .4pt),
  `maquette`, [englobe la fiche et regroupe tous les réglages (@maquette)],
  `exercice`, [un énoncé numéroté (@exercices)],
  `solution`, [le corrigé de l'exercice qui précède (@corriges)],
  `afficher-fdr`, [le schéma de la feuille de route (@fdr)],
  `thematique`, [le titre d'une thématique, qui place une coche sur la feuille de route (@fdr)],
  table.hline(stroke: .6pt),
)

Les autres fonctions (`reglages-couleurs`, `liste-corriges`…) servent seulement
à se passer de `maquette` (@avance).


// ══════════════════════════════════════════════════════════════════════════════
// 2. EXERCICES
// ══════════════════════════════════════════════════════════════════════════════

= Les exercices <exercices>

Un exercice s'écrit `#exercice[…]`, l'énoncé entre crochets. Il est encadré et
numéroté automatiquement, à partir de 1 dans chaque maquette. L'énoncé peut
contenir n'importe quel contenu Typst : formules, listes, figures, tableaux.

== Obligatoires et facultatifs

Un exercice est obligatoire par défaut. Avec `obligatoire: false`, il devient
facultatif : son cadre et son titre passent en gris. Sur la feuille de route,
les exercices facultatifs sont placés sur une ligne à part (@fdr).

#exemple(```typ
#maquette[
  #exercice[Calculer $2 + 3$.]
  #exercice(obligatoire: false)[
    Calculer $2^10$.
  ]
]
```)

La couleur des exercices obligatoires (noir par défaut) se règle pour toute la
fiche avec `maquette(couleur-obligatoire: …)`.

== Titre et source

Le `titre` s'affiche après « Exercice N : », dans l'étiquette du cadre. La
`source` est un petit texte posé sur le filet bas, à droite : par exemple les
numéros des exercices à faire dans un manuel ou une ressource en ligne.

#exemple(```typ
#maquette[
  #exercice(
    titre: "Fractions",
    source: "Manuel p. 42, n° 3 et 5",
  )[
    Calculer $1/2 + 1/3$.
  ]
]
```)

Un titre trop long passe à la ligne dans son étiquette, et une source longue
passe à la ligne sur le filet.

== Entraînement en ligne

Avec `entrainement: "https://…"`, une haltère cliquable apparaît sur le filet
droit de l'exercice. Le QR code de la même adresse est ajouté au bloc
« Automatismes », en fin de fiche : l'élève qui travaille sur papier y accède
avec son téléphone.

#exemple(```typ
#maquette[
  #exercice(
    titre: "Tables",
    entrainement: "https://typst.app",
  )[
    Réciter la table de 7.
  ]
]
```)

Le bloc Automatismes et ses réglages (nombre de QR codes par ligne, taille) sont
détaillés à la @entrainements.

== Un exercice long

Un exercice ne se coupe jamais entre deux pages : s'il ne tient pas en bas de
la page, il passe entièrement à la page suivante. Seul un exercice plus haut
qu'une page entière se coupe, pour ne rien perdre de l'énoncé.

== Paramètres de `exercice`

#parametre("titre", ("content", "none"), `none`)[
  Affiché après « Exercice N : ».
]
#parametre("obligatoire", ("bool",), `true`)[
  `false` : exercice facultatif, en gris, sur la ligne du haut de la feuille de
  route.
]
#parametre("source", ("content", "none"), `none`)[
  Petit texte sur le filet bas, à droite.
]
#parametre("entrainement", ("str", "none"), `none`)[
  Adresse d'un entraînement en ligne : haltère cliquable sur le filet droit, QR
  code dans le bloc Automatismes.
]
#parametre("pas-corrige", ("bool",), `false`)[
  `true` : aucun corrigé pour cet exercice, même si un `solution` le suit
  (@corriges).
]
#parametre("titre-solution", ("content", "none"), `none`)[
  Complément du titre du corrigé : « Corrigé de l'exercice 3 : méthode ».
]
#parametre("stop", ("bool",), `false`)[
  `true` : coche supplémentaire après cet exercice, sur la feuille de route.
  Rarement utile : `thematique` place déjà les coches (@fdr).
]


// ══════════════════════════════════════════════════════════════════════════════
// 3. CORRIGÉS
// ══════════════════════════════════════════════════════════════════════════════

= Les corrigés <corriges>

Le corrigé d'un exercice s'écrit juste après lui, avec `#solution[…]`. On écrit
donc toujours tous les corrigés : ce sont les réglages de la `maquette` qui
décident où ils s'affichent, et lesquels.

== Où les afficher

Le paramètre `afficher-corrige` de la maquette prend trois valeurs :

- `"fin"` (par défaut) : tous les corrigés sont regroupés dans le bloc
  « Correction », en fin de fiche, sur une nouvelle page ;
- `"apres"` : chaque corrigé s'affiche sous son énoncé ;
- `none` : aucun corrigé. C'est la fiche élève.

`true` et `false` sont aussi acceptés : ils valent `"fin"` et `none`.

#exemple(```typ
#maquette(afficher-corrige: "apres")[
  #exercice[Calculer $2 + 3$.]
  #solution[$2 + 3 = 5$.]
  #exercice[Calculer $4 times 5$.]
  #solution[$4 times 5 = 20$.]
]
```)

#tip(title: "Une fiche élève et une fiche corrigée")[
  Il suffit de changer `afficher-corrige` : `none` pour la fiche distribuée,
  `"fin"` ou `"apres"` pour la version corrigée. Les énoncés restent identiques.
]

== Choisir les corrigés affichés

Le paramètre `corriges` choisit les corrigés à afficher. Les énoncés, eux, sont
toujours tous affichés.

#table(
  columns: (auto, 1fr),
  stroke: none,
  inset: (x: 6pt, y: 4pt),
  table.hline(stroke: .6pt),
  table.header[*Valeur*][*Corrigés affichés*],
  table.hline(stroke: .4pt),
  `auto`, [tous (par défaut)],
  `4`, [celui de l'exercice 4],
  `"1-6,9,12"`, [ceux des exercices 1 à 6, 9 et 12],
  `(1, "3-5")`, [ceux des exercices 1, 3, 4 et 5],
  `"obligatoires"`, [ceux des exercices obligatoires],
  `"facultatifs"`, [ceux des exercices facultatifs],
  `()`, [aucun],
  table.hline(stroke: .6pt),
)

#exemple(```typ
#maquette(
  afficher-corrige: "apres",
  corriges: "1,3",
)[
  #exercice[Énoncé 1.]
  #solution[Corrigé 1.]
  #exercice[Énoncé 2.]
  #solution[Corrigé 2.]
  #exercice[Énoncé 3.]
  #solution[Corrigé 3.]
]
```)

Une sélection mal écrite, comme `"1-a"`, arrête la compilation avec un message
qui rappelle les formes acceptées.

== Masquer un corrigé, compléter son titre

`exercice(pas-corrige: true)` retire le corrigé d'un exercice, quelle que soit
la sélection : pratique pour un exercice à rendre, dont on garde le corrigé dans
le fichier. `titre-solution` complète le titre du corrigé.

#exemple(```typ
#maquette(afficher-corrige: "apres")[
  #exercice(titre-solution: "méthode")[
    Résoudre $2x = 6$.
  ]
  #solution[On divise par 2 : $x = 3$.]
  #exercice(pas-corrige: true)[
    Résoudre $3x = 12$.
  ]
  #solution[$x = 4$.]
]
```)

== La clé vers le corrigé

Quand le corrigé d'un exercice est affiché, une clé apparaît sur le filet droit
de l'exercice : un clic mène au corrigé, et un clic sur le titre du corrigé
ramène à l'exercice. Pour s'en passer : `maquette(vers-solution: false)`. La
clé n'apparaît pas pour un exercice dont le corrigé n'est pas affiché.

== Présentation du bloc Correction

Quatre réglages de la maquette modifient le bloc « Correction » :

#parametre("colonnes-corriges", ("int",), `1`)[
  Nombre de colonnes du bloc.
]
#parametre("correction-nouvelle-page", ("bool",), `true`)[
  `false` : le bloc suit la fiche, sans saut de page. Indispensable pour une
  maquette placée dans `columns(…)` ou dans un cadre (@avance).
]
#parametre("titre-corrige", ("content", "auto"), `auto`)[
  Début du titre de chaque corrigé ; `auto` : « Corrigé de l'exercice », ou sa
  traduction (@avance).
]
#parametre("couleur-sol", ("color", "auto"), `auto`)[
  Couleur des titres « Correction » et « Corrigé de l'exercice N » ; `auto` :
  la couleur de navigation `rouge-perso` (@maquette).
]

== Corrigés dans des fichiers séparés

Le corrigé est un contenu comme un autre : il peut venir d'un autre fichier.
Par exemple, le fichier `corriges/exo-01.typ` contient :

```typ
#let corrige = [
  $x^2 - 9 = (x - 3)(x + 3)$.
]
```

et la fiche l'importe :

```typ
#import "corriges/exo-01.typ" as exo01
#exercice[Factoriser $x^2 - 9$.]
#solution(exo01.corrige)
```


// ══════════════════════════════════════════════════════════════════════════════
// 4. FEUILLE DE ROUTE
// ══════════════════════════════════════════════════════════════════════════════

= La feuille de route <fdr>

== Afficher le schéma

#a-ecrire[`#afficher-fdr` (sans parenthèses) ; route du bas = obligatoires
(disques noirs), ligne du haut = facultatifs (disques blancs), disques
cliquables. Exemple : trois exercices dont un facultatif.]

== Thématiques et coches

#a-ecrire[`#thematique[…]` : titre en gras 14 pt (plus grand au-delà d'un texte
de 11 pt), non numéroté, aligné avec `alignement`, qui ferme la thématique
précédente et place une coche. Exemple : deux thématiques.]

#info(title: "Pourquoi pas les titres Typst ?")[
  `thematique` n'est pas un `heading` : les réglages de titres du document
  (numérotation, `show heading`) ne la modifient pas, et les titres ordinaires
  n'ont aucun effet sur la feuille de route.
]

== Comment se calculent les coches

#a-ecrire[découpage en tronçons, une coche par tronçon, obligatoires en bas,
facultatifs en haut, lignes complétées par des vides ; `stop: true` pour une
coche à la main ; passage à la ligne entre deux tronçons si la route est trop
large. Illustrer avec l'exemple de la documentation de ProfMaquette.]


// ══════════════════════════════════════════════════════════════════════════════
// 5. ENTRAÎNEMENTS
// ══════════════════════════════════════════════════════════════════════════════

= Les entraînements en ligne <entrainements>

#a-ecrire[bloc Automatismes : flottant en bas de la dernière page, ou à la suite
de la fiche s'il est trop haut ; `colonnes-automatismes`, `taille-qr` (agrandi
automatiquement si l'adresse est trop longue) ; QR codes et haltère dans la
couleur `bleu-perso`.]


// ══════════════════════════════════════════════════════════════════════════════
// 6. RÉGLAGES DE LA MAQUETTE
// ══════════════════════════════════════════════════════════════════════════════

= Les réglages de la maquette <maquette>

== Couleurs

#a-ecrire[`bleu-perso` (liens extérieurs), `rouge-perso` (navigation),
`couleur-sol`, `couleur-obligatoire`, `couleur-fdr`. Exemple : mêmes exercices
avec d'autres couleurs.]

== Tous les paramètres

#a-ecrire[une fiche `#parametre` par paramètre de `maquette`.]


// ══════════════════════════════════════════════════════════════════════════════
// 7. USAGES AVANCÉS
// ══════════════════════════════════════════════════════════════════════════════

= Usages avancés <avance>

== Langue

#a-ecrire[`langue` : mots du paquet en français, anglais, allemand, espagnol ou
italien ; piège de `lang: "en"`, langue par défaut de Typst.]

== Maquette dans des colonnes ou un cadre

#a-ecrire[`correction-nouvelle-page: false`, sinon erreur « pagebreaks are not
allowed inside of containers ».]

== Plusieurs fiches dans un même document

#a-ecrire[chaque `maquette` repart de l'exercice 1 ; une maquette ne peut pas en
contenir une autre.]

== Sans `maquette`

#a-ecrire[`reglages-couleurs`, `reglages-corriges`,
`couleur-exercices-obligatoires`, puis `liste-entrainements` et
`liste-corriges` en fin de fiche ; `reinitialiser-compteur-exercice`.]


// ══════════════════════════════════════════════════════════════════════════════
// 8. ANNEXES
// ══════════════════════════════════════════════════════════════════════════════

= Annexes

== Correspondance avec ProfMaquette

#a-ecrire[tableau des clés ProfMaquette et de leur équivalent.]

== Remerciements

#a-ecrire[Christophe Poulain (ProfMaquette), paquets tiaoma,
fontawesome, gentle-clues (ce manuel).]


// ══════════════════════════════════════════════════════════════════════════════
// 9. HISTORIQUE DES VERSIONS
// ══════════════════════════════════════════════════════════════════════════════

= Historique des versions

Cette section reprend le fichier `CHANGELOG.md` du paquet : elle est mise à
jour à chaque compilation du manuel.

#historique(read("../CHANGELOG.md"))
