// Manuel du paquet template-exercices.

#import "../src/lib.typ" as paquet
#import "@preview/gentle-clues:1.3.1": info, tip, warning

#let manifeste = toml("../typst.toml").package


// ══════════════════════════════════════════════════════════════════════════════
// OUTILS DU MANUEL
// ══════════════════════════════════════════════════════════════════════════════

// Dès qu'il y aura une illustration, je ferai en sorte d'avoir le rendu à côté
// avec `dessous: true` pour les exemples larges. Le code est écrit une seule
// fois : le rendu ne peut pas se désynchroniser de ce qu'on montre.
//
// Chaque exemple a sa propre `maquette` (numérotation, corrigés et feuille de
// route indépendants). Les sauts de page sont neutralisés : ils sont interdits
// dans un cadre (le bloc « Correction » en demande un).
//
// `hauteur` : ne montre que le haut du rendu (ex. seulement la feuille de route).
#let exemple(dessous: false, hauteur: none, code) = {
  let source = block(
    width: 100%,
    fill: luma(96%),
    radius: 4pt,
    inset: 8pt,
    text(size: 8.5pt, raw(code.text, lang: "typ", block: true)),
  )
  let contenu = {
    show pagebreak: none
    set text(size: 9pt)
    eval(code.text, mode: "markup", scope: dictionary(paquet))
  }
  // Rendu partiel : l'exemple est mis en page dans une grande zone (le paquet
  // mesure la place disponible), puis seul son haut est montré.
  if hauteur != none {
    contenu = box(width: 100%, height: hauteur, clip: true, block(width: 100%, height: 25cm, contenu))
  }
  let rendu = block(width: 100%, stroke: .5pt + luma(75%), radius: 4pt, inset: 10pt, contenu)
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
// Couleurs des titres, dans le texte comme dans le sommaire : parties en
// crimson, sous-parties en navy.
#let couleur-partie = rgb("#DC143C")
#let couleur-sous-partie = navy
#show heading.where(level: 1): set text(fill: couleur-partie)
#show heading.where(level: 2): set text(fill: couleur-sous-partie)
// Renvois (« partie 7 », « partie 7.1 ») dans la couleur de la partie visée.
#show ref: it => {
  let cible = it.element
  if cible != none and cible.func() == heading {
    text(fill: if cible.level == 1 { couleur-partie } else { couleur-sous-partie }, it)
  } else { it }
}
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
  #manifeste.name sert à composer des fiches d'exercices avec Typst : on écrit les énoncés et leurs corrigés au même endroit dans l'éditeur de texte, et le paquet (à l'aide des options) se charge de tout le reste. En résumé :

  - les exercices sont numérotés automatiquement via l'ordre d'apparition dans le code ;

  - on peut choisir si un exercice est *obligatoire* ou *facultatif* ;

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
// Sommaire : chaque ligne est un lien vers sa section (comme les signets du
// PDF), dans les couleurs des titres.
#{
  show outline.entry.where(level: 1): set text(fill: couleur-partie, weight: "bold")
  show outline.entry.where(level: 2): set text(fill: couleur-sous-partie)
  outline(depth: 2)
}


// ══════════════════════════════════════════════════════════════════════════════
// 1. DÉMARRER
// ══════════════════════════════════════════════════════════════════════════════

= Démarrer

== Importer le paquet

#raw(block: true, lang: "typ", "#import \"@preview/" + manifeste.name + ":" + manifeste.version + "\": *")

Dans la suite du manuel, cette ligne est sous-entendue au début de chaque
exemple.

#info(title: "Rien à installer")[
  Les icônes du paquet (haltère, clé, coche) sont fournies avec lui : aucune
  police particulière n'est nécessaire, sur l'ordinateur comme sur la web app
  Typst.
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
à se passer de `maquette` (@sans-maquette).


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

== Le style des cadres

Le réglage `style-exercice` de la maquette choisit l'allure des cadres, pour
toute la fiche. Il s'applique aussi au bloc « Automatismes ». Quatre styles
existent :

- `"fond-blanc"` (par défaut) : le titre, sans cadre, coupe le filet haut ;
- `"etiquette-encadree"` : le titre est dans un petit cadre, à cheval sur le
  filet ;
- `"bandeau"` : le titre est en haut du cadre, séparé de l'énoncé par un filet ;
- `"etiquette-pleine"` : le titre est écrit en blanc dans une étiquette remplie
  de couleur.

#exemple(dessous: true, ```typ
#grid(
  columns: 2,
  column-gutter: 12pt,
  row-gutter: 10pt,
  ..("fond-blanc", "etiquette-encadree",
     "bandeau", "etiquette-pleine").map(style =>
    maquette(style-exercice: style)[
      #exercice(titre: style)[Énoncé.]
      #exercice(obligatoire: false)[Facultatif.]
    ]
  ),
)
```)

Chaque maquette repart de l'exercice 1, d'où les numéros identiques. Sans
`maquette`, le style se règle avec `#style-exercices("bandeau")`, avant le
premier exercice.

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
  maquette placée dans `columns(…)` ou dans un cadre (@colonnes).
]
#parametre("titre-corrige", ("content", "auto"), `auto`)[
  Début du titre de chaque corrigé ; `auto` : « Corrigé de l'exercice », ou sa
  traduction (@langue).
]
#parametre("couleur-sol", ("color", "auto"), `auto`)[
  Couleur des titres « Correction » et « Corrigé de l'exercice N » ; `auto` :
  la couleur de navigation `rouge-perso` (@couleurs).
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

La feuille de route montre à l'élève le parcours de la fiche. Elle reprend la
feuille de route de ProfMaquette (clé `FdR`, commande `\AfficheFdR`).

== Afficher le schéma <fdr-schema>

`#afficher-fdr` dessine le schéma de tous les exercices de la maquette. On le
place en général avant le premier exercice, centré avec
`#align(center, afficher-fdr)`.

- Les exercices obligatoires forment la *route du bas* : des disques pleins,
  numérotés, reliés par un trait épais qui se termine par une flèche.
- Les exercices facultatifs sont sur la *ligne du haut*, en disques blancs.
- Chaque disque est un lien vers son exercice.

#exemple(```typ
#maquette[
  #align(center, afficher-fdr)
  #exercice[Énoncé 1.]
  #exercice(obligatoire: false)[
    Énoncé 2.
  ]
  #exercice[Énoncé 3.]
]
```)

#warning(title: "Sans parenthèses")[
  `afficher-fdr` est un contenu, pas une fonction : on écrit `#afficher-fdr`, et
  non `#afficher-fdr()`.
]

Le schéma ne montre que les exercices de la maquette qui le contient. Sa
couleur se règle avec `maquette(couleur-fdr: …)` (@couleurs). Si la route est
plus large que la page, elle passe à la ligne entre deux thématiques.

== Thématiques et coches <fdr-thematiques>

Une fiche se découpe souvent en thématiques : « Factoriser », « Résoudre »…
`#thematique[…]` écrit le titre d'une thématique, et *ferme la thématique
précédente* : sur la feuille de route, une coche suit son dernier exercice. Une
coche finale termine toujours la route.

L'élève fait les exercices de la route jusqu'à la coche, puis demande la
validation. L'enseignant peut alors lui proposer les exercices facultatifs de
la thématique, sur la ligne du haut, avant qu'il poursuive la route.

#exemple(```typ
#maquette[
  #align(center, afficher-fdr)
  #thematique[Factoriser]
  #exercice[Énoncé 1.]
  #exercice(obligatoire: false)[
    Énoncé 2.
  ]
  #thematique[Résoudre]
  #exercice[Énoncé 3.]
]
```)

Le titre est en gras, en 14 pt (plus grand si le texte de la fiche dépasse
11 pt), et n'est jamais numéroté. Il est aligné à gauche, sauf avec
`#thematique(alignement: center)[…]` ou `alignement: right`. Une thématique
placée avant le premier exercice ne place pas de coche.

#info(title: "Pourquoi pas les titres Typst ?")[
  `thematique` n'est pas un `heading` : les réglages de titres du document
  (numérotation, `show heading`) ne la modifient pas, elle n'apparaît pas dans
  une table des matières, et les titres ordinaires (`=`, `==`…) n'ont aucun
  effet sur la feuille de route.
]

== Comment se calculent les coches <fdr-coches>

Les coches découpent la route en *tronçons*. Dans chaque tronçon :

+ les exercices obligatoires vont sur la route du bas, dans l'ordre de la fiche ;
+ les exercices facultatifs vont sur la ligne du haut, dans l'ordre de la fiche ;
+ la plus courte des deux lignes est complétée par des cases vides ;
+ la ligne du haut redescend sur la route à la coche du tronçon.

Voici l'exemple de la documentation de ProfMaquette : quatorze exercices, en
deux thématiques. Seul le schéma est montré.

#exemple(dessous: true, hauteur: 1.6cm, ```typ
#let obl = exercice[…]
#let fac = exercice(obligatoire: false)[…]
#maquette[
  #align(center, afficher-fdr)
  #thematique[Première thématique]
  #obl #obl #fac #fac #obl #obl #fac #obl   // exercices 1 à 8
  #thematique[Seconde thématique]
  #obl #obl #fac #obl #fac #fac             // exercices 9 à 14
]
```)

La route du bas contient 1, 2, 5, 6, 8, une coche, puis 9, 10, 12 et la coche
finale. La ligne du haut contient 3, 4 et 7 au-dessus du premier tronçon, 11, 13
et 14 au-dessus du second.

#tip(title: "Une coche à la main")[
  `exercice(stop: true)` ajoute une coche juste après cet exercice, sans
  thématique. C'est rarement utile, mais cela reproduit la clé `Stop` de
  ProfMaquette.
]


// ══════════════════════════════════════════════════════════════════════════════
// 5. ENTRAÎNEMENTS
// ══════════════════════════════════════════════════════════════════════════════

= Les entraînements en ligne <entrainements>

Un exercice avec `entrainement: "https://…"` porte une haltère cliquable sur son
filet droit (@exercices). Toutes les adresses de la fiche sont aussi regroupées
en QR codes dans le bloc « Automatismes », ajouté automatiquement par la
maquette : l'élève qui travaille sur papier y accède avec son téléphone.

#exemple(```typ
#maquette(
  colonnes-automatismes: 2,
  taille-qr: 1.5cm,
)[
  #exercice(entrainement: "https://typst.app")[
    Tables de multiplication.
  ]
  #exercice[Sans entraînement.]
  #exercice(entrainement: "https://ctan.org")[
    Fractions.
  ]
]
```)

Chaque QR code porte le numéro de son exercice, et il est lui aussi cliquable.

- *Où ?* Le bloc se place en bas de la dernière page s'il reste de la place,
  sinon en bas de la page suivante. S'il occupe plus des trois quarts d'une
  page, il suit simplement la fiche et peut se couper entre deux pages.
- *Combien par ligne ?* `colonnes-automatismes` (3 par défaut).
- *Quelle taille ?* `taille-qr` (2 cm par défaut) : tous les QR codes ont la même
  taille. Une adresse trop longue pour rester lisible à cette taille donne un
  QR code agrandi automatiquement.
- *Quelle couleur ?* Celle des liens vers l'extérieur, `bleu-perso` (@couleurs),
  comme l'haltère et la source.


// ══════════════════════════════════════════════════════════════════════════════
// 6. RÉGLAGES DE LA MAQUETTE
// ══════════════════════════════════════════════════════════════════════════════

= Les réglages de la maquette <maquette>

Tous les réglages de la fiche se donnent à `maquette`, en un seul endroit :

```typ
#maquette(afficher-corrige: "fin", corriges: "1-6,9,12")[
  … la fiche …
]
```

ou, sans crochets autour de toute la fiche, en tête du fichier :

```typ
#show: maquette.with(afficher-corrige: "fin", corriges: "1-6,9,12")
```

== Couleurs <couleurs>

Le paquet utilise deux couleurs, chacune avec un rôle :

- `bleu-perso` pour ce qui mène *hors* du document : haltère, QR codes, source ;
- `rouge-perso` pour ce qui permet de *naviguer* dans le document : clé, titres
  des corrigés.

Trois autres couleurs complètent les réglages : `couleur-sol` pour les titres des
corrigés (par défaut `rouge-perso`), `couleur-obligatoire` pour les exercices
obligatoires (par défaut noir) et `couleur-fdr` pour la feuille de route (par
défaut noir).

#exemple(```typ
#maquette(
  bleu-perso: green.darken(20%),
  rouge-perso: purple,
  couleur-obligatoire: navy,
  couleur-fdr: navy,
  afficher-corrige: "apres",
)[
  #align(center, afficher-fdr)
  #exercice(
    entrainement: "https://typst.app",
    source: "p. 12",
  )[Énoncé.]
  #solution[Corrigé.]
]
```)

Toute couleur Typst convient : `blue`, `rgb("#1E90FF")`, `luma(40%)`,
`green.darken(20%)`… Une valeur qui n'est pas une couleur arrête la
compilation avec un message clair.

== Tous les paramètres <parametres-maquette>

#parametre("afficher-corrige", ("str", "none", "bool"), `"fin"`)[
  Où afficher les corrigés : `"fin"` (bloc Correction en fin de fiche),
  `"apres"` (sous chaque énoncé) ou `none` (aucun) ; `true` vaut `"fin"`,
  `false` vaut `none` (@corriges).
]
#parametre("corriges", ("auto", "int", "str", "array"), `auto`)[
  Corrigés affichés : `auto` (tous), `4`, `"1-6,9,12"`, `(1, "3-5")`,
  `"obligatoires"`, `"facultatifs"` ou `()` (aucun).
]
#parametre("vers-solution", ("bool",), `true`)[
  Clé cliquable sur l'exercice, qui mène au corrigé (et retour).
]
#parametre("titre-corrige", ("content", "auto"), `auto`)[
  Début du titre de chaque corrigé ; `auto` : « Corrigé de l'exercice », ou sa
  traduction (@langue).
]
#parametre("colonnes-corriges", ("int",), `1`)[
  Nombre de colonnes du bloc Correction.
]
#parametre("correction-nouvelle-page", ("bool",), `true`)[
  Le bloc Correction commence sur une nouvelle page ; `false` : il suit la
  fiche (@colonnes).
]
#parametre("style-exercice", ("str",), `"fond-blanc"`)[
  Style des cadres : `"fond-blanc"`, `"etiquette-encadree"`, `"bandeau"` ou
  `"etiquette-pleine"` (@exercices).
]
#parametre("colonnes-automatismes", ("int",), `3`)[
  Nombre de QR codes par ligne dans le bloc Automatismes (@entrainements).
]
#parametre("taille-qr", ("length",), `2cm`)[
  Côté des QR codes, agrandi si l'adresse est trop longue pour rester lisible.
]
#parametre("bleu-perso", ("color", "auto"), `auto`)[
  Couleur des liens vers l'extérieur ; `auto` : `rgb("#0090C8")`.
]
#parametre("rouge-perso", ("color", "auto"), `auto`)[
  Couleur de navigation ; `auto` : `rgb("#DC143C")` (Crimson, comme dans
  ProfMaquette).
]
#parametre("couleur-sol", ("color", "auto"), `auto`)[
  Couleur des titres « Correction » et « Corrigé de l'exercice N » ; `auto` :
  `rouge-perso`.
]
#parametre("couleur-obligatoire", ("color", "auto"), `auto`)[
  Couleur des exercices obligatoires ; `auto` : noir.
]
#parametre("couleur-fdr", ("color",), `black`)[
  Couleur de la feuille de route.
]
#parametre("langue", ("str", "auto"), `auto`)[
  Langue des mots du paquet : `"fr"`, `"en"`, `"de"`, `"es"` ou `"it"`
  (@langue).
]


// ══════════════════════════════════════════════════════════════════════════════
// 7. USAGES AVANCÉS
// ══════════════════════════════════════════════════════════════════════════════

= Usages avancés <avance>

== Langue <langue>

Les mots écrits par le paquet existent en cinq langues. Avec `langue: auto`, le
paquet suit la langue du document (`#set text(lang: …)`).

#table(
  columns: 6,
  stroke: none,
  inset: (x: 5pt, y: 4pt),
  table.hline(stroke: .6pt),
  table.header[][`"fr"`][`"en"`][`"de"`][`"es"`][`"it"`],
  table.hline(stroke: .4pt),
  [Exercice], [Exercice], [Exercise], [Aufgabe], [Ejercicio], [Esercizio],
  [Correction], [Correction], [Solutions], [Lösungen], [Soluciones], [Soluzioni],
  [Automatismes], [Automatismes], [Practice], [Übungen], [Práctica], [Allenamento],
  [QR code], [Exo], [Ex.], [Aufg.], [Ej.], [Es.],
  table.hline(stroke: .6pt),
)

#exemple(```typ
#set text(lang: "de")
#maquette(afficher-corrige: "apres")[
  #exercice(titre: "Brüche")[
    Berechne $1/2 + 1/3$.
  ]
  #solution[$5/6$]
]
```)

#warning(title: "Pour l'anglais, écrire langue: \"en\"")[
  L'anglais est la langue par défaut de Typst : un document sans
  `#set text(lang: …)` est donc « en anglais » sans le savoir. Pour ne pas
  traduire ces documents par surprise, `langue: auto` donne alors le français.
  Pour une fiche en anglais, il faut écrire `maquette(langue: "en")`.
]

Une langue inconnue du paquet donne le français.

== Maquette dans des colonnes ou un cadre <colonnes>

Par défaut, le bloc Correction commence sur une nouvelle page. Or Typst
interdit les sauts de page dans un conteneur : une maquette placée dans
`#columns(…)`, dans un `#block` ou dans une case de tableau provoque l'erreur
« pagebreaks are not allowed inside of containers ». Il suffit alors de
demander que la Correction suive la fiche :

#exemple(```typ
#columns(2)[
  #maquette(
    afficher-corrige: "fin",
    correction-nouvelle-page: false,
  )[
    #exercice[Énoncé 1.]
    #solution[Corrigé 1.]
    #exercice[Énoncé 2.]
    #solution[Corrigé 2.]
  ]
]
```)

== Plusieurs fiches dans un même document <plusieurs-fiches>

Il suffit de placer les maquettes l'une après l'autre. Chaque maquette est
indépendante : elle repart de l'exercice 1, avec sa propre feuille de route, ses
propres QR codes, ses propres corrigés et ses propres couleurs. Ici, la seconde
fiche retrouve les couleurs par défaut.

#exemple(```typ
#maquette(
  afficher-corrige: "apres",
  rouge-perso: purple,
)[
  #exercice(titre: "Fiche A")[…]
  #solution[Corrigé A.]
]
#maquette(afficher-corrige: "apres")[
  #exercice(titre: "Fiche B")[…]
  #solution[Corrigé B.]
]
```)

#tip(title: "Les réglages vont dans la maquette")[
  Une maquette part toujours de ses propres réglages : un
  `#reglages-couleurs(…)` écrit avant elle n'a pas d'effet. Il faut donner les
  couleurs à la maquette elle-même.
]

Une maquette ne peut pas en contenir une autre : la compilation s'arrête alors
avec un message clair.

== Sans `maquette` <sans-maquette>

`maquette` appelle elle-même les fonctions ci-dessous. On peut s'en passer et
les appeler soi-même, avant le premier exercice :

- `reglages-corriges(mode: …, vers-solution: …, couleur-sol: …, titre-corrige: …,
  colonnes: …, nouvelle-page: …)`, où `mode` vaut `none`, `"apres"` ou `"fin"` ;
- `reglages-couleurs(bleu-perso: …, rouge-perso: …)` ;
- `couleur-exercices-obligatoires(couleur)` ;
- `style-exercices(style)`.

Il faut alors ajouter soi-même les blocs de fin, une seule fois et dans cet
ordre :

```typ
#reglages-corriges(mode: "fin")
#exercice(entrainement: "https://typst.app")[Énoncé.]
#solution[Corrigé.]
#liste-entrainements(colonnes: 3, taille-qr: 2cm)
#liste-corriges()
```

#warning(title: "Sans réglage, aucun corrigé")[
  Sans `maquette` ni `reglages-corriges`, aucun corrigé n'est affiché : c'est
  `maquette` qui choisit `afficher-corrige: "fin"` par défaut.
]

`reinitialiser-compteur-exercice()` repart de l'exercice 1, pour commencer une
nouvelle fiche dans le même document. Avec `maquette`, c'est inutile
(@plusieurs-fiches).


// ══════════════════════════════════════════════════════════════════════════════
// 8. ANNEXES
// ══════════════════════════════════════════════════════════════════════════════

= Annexes

== Correspondance avec ProfMaquette

Pour qui connaît ProfMaquette, voici l'équivalent de ses clés et commandes.

#table(
  columns: (1fr, 1fr),
  stroke: none,
  inset: (x: 6pt, y: 4pt),
  table.hline(stroke: .6pt),
  table.header[*ProfMaquette*][*#manifeste.name*],
  table.hline(stroke: .4pt),
  [environnement `Maquette`], [`maquette`],
  [clé `FdR`, `\AfficheFdR`], [`afficher-fdr`],
  [`Route`], [`obligatoire: true` (défaut)],
  [`Stop`], [`#thematique[…]` (ou `stop: true`)],
  [`AEntretenir`, zone Entrainement], [`entrainement:`, bloc Automatismes],
  [`Source`], [`source:`],
  [environnement `Solution`], [`solution`],
  [`CorrigeApres` / `CorrigeFin`], [`afficher-corrige: "apres"` / `"fin"`],
  [`VersSolution`], [`vers-solution: true`],
  [`PasCorrige`], [`pas-corrige: true`],
  [`TitreSolution`, `TitreCorrige`], [`titre-solution:`, `titre-corrige:`],
  [`CouleurSol`, `Colonnes`], [`couleur-sol:`, `colonnes-corriges:`],
  table.hline(stroke: .6pt),
)

Les types de documents de ProfMaquette, l'en-tête de la feuille de route et les
environnements `Reponse` ou `Indice` n'ont pas d'équivalent.

== Remerciements

Un grand merci à *Christophe Poulain*, auteur du package LaTeX
#link("https://ctan.org/pkg/profmaquette")[ProfMaquette] : #manifeste.name en
reprend la logique (exercices, feuille de route, entraînements, corrigés) et une
partie du vocabulaire. Les idées sont les siennes, et les limites de cette
adaptation sont les miennes. Pour un outil complet, utilisez ProfMaquette.

#manifeste.name utilise le paquet
#link("https://typst.app/universe/package/tiaoma")[tiaoma] pour les QR codes. Les
icônes (haltère, clé, coche) sont des dessins de
#link("https://fontawesome.com")[Font Awesome Free], sous licence CC BY 4.0. Ce
manuel utilise aussi le paquet
#link("https://typst.app/universe/package/gentle-clues")[gentle-clues] pour ses
encadrés.


// ══════════════════════════════════════════════════════════════════════════════
// 9. HISTORIQUE DES VERSIONS
// ══════════════════════════════════════════════════════════════════════════════

= Historique des versions

Cette section reprend le fichier `CHANGELOG.md` du paquet : elle est mise à
jour à chaque compilation du manuel.

#historique(read("../CHANGELOG.md"))
