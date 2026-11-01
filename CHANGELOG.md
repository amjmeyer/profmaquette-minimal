# Historique des versions

## Non publié

- `style-maquette` (paramètre de `maquette`) remplace `style-cartouche` : il
  règle ensemble le cartouche de titre et les `#thematique`, et le cartouche
  ne se choisit plus séparément.
  `"arrondi-1"` (défaut) : cartouche à onglet, thématiques en onglet posé sur
  un trait ; `"arrondi-2"` : même cartouche, thématiques en étiquette arrondie
  suivie d'un trait ; `"carre"` : cartouche en en-tête de chapitre de leçon
  (numéro en gris, trait vertical, titre, niveau en italique), thématiques en
  filet à barre noire (la présentation de la 0.3.0).
- `couleur-titre` colore tout le style (noir par défaut) ; `couleur-thematique`
  est supprimé. Sur un onglet ou une étiquette de couleur claire, le texte
  s'écrit en noir.
- Le bandeau « Corrigé (rempli en classe) » (`seyes(…, afficher: true)` hors
  `maquette`) prend les espacements du corrigé d'une interro : moins de marge
  intérieure, moins d'espace sous le titre et en dessous du bandeau.

## 0.3.0

- `#thematique` est présentée comme un filet : petite barre noire, titre en
  gras à la taille du texte, trait gris jusqu'à la marge (auparavant, titre
  seul en 14 pt). `couleur-thematique` (paramètre de `maquette`) règle la
  couleur du trait ; `alignement` fait glisser le titre le long du trait.
- `position-qr: "thematique"` (paramètre de `maquette`) : les QR-Codes
  s'affichent à la fin de chaque `#thematique`, dans un bloc « Automatismes —
  <thématique> », au lieu d'un seul bloc en fin de fiche (`"fin"`, défaut).
- Les numéros des disques de la FdR sont plus lisibles (9 pt au lieu de 7 pt).
- Par défaut, les titres des exercices optionnels sont écrits en noir pour
  ressortir, quelle que soit `couleur-route` (seul le filet prend la couleur).

## 0.2.0

- `seyes(hauteur)[réponse]` et la clé `afficher` (`false` par défaut) : avec
  `afficher: true`, la réponse prend la place de la grille (version
  « rattrapable » d'une fiche remplie en classe) : dans une `maquette`, dans
  le cadre d'un corrigé (en mode interro, la zone garde son rang pour
  l'association avec les `#corrige`) ; hors `maquette`, dans un bandeau vert
  d'eau « Corrigé (rempli en classe) » (terme traduit dans les 5 langues,
  icône crayon de Font Awesome Free).

## 0.1.0 — version de départ

Ajouts avant la première publication :

- Nouvelle fonction `seyes(hauteur)` : zone de réponse sur papier Seyes
  (`seyes(4)` = 4 carreaux de 8 mm, ou une longueur ; styles `"seyes"`,
  `"sobre"`, `"bleu"`).
- `position-corriges: "apres-question"` (mode interro) : chaque `#corrige`
  remplace, dans l'ordre, un `seyes` de l'exercice qui précède, en rouge
  (`couleur-interne`). Hors interro, aucun corrigé n'est affiché.
- `largeur-cartouche` (65 % par défaut, au lieu de la moitié) : part du
  cartouche de titre à côté de la zone Nom / Prénom / Classe, en mode interro.
- Cartouche de titre et zone Nom / Prénom / Classe protégés des
  `set block(…)` / `set box(…)` de l'utilisateur.
- Barème des interros : `maquette(afficher-brm: "partiel" | "complet")` (mode
  interro seulement) et `exercice(brm: …)`, un nombre ou un tableau qui suit
  les questions numérotées, imbriqué pour les sous-questions. Total de
  l'exercice sur son filet en haut à droite (« 7,5 points ») ; en
  `"complet"`, note grisée de chaque question à sa droite (« (1,5 pt) »).
- Exercice plus haut qu'une page : à chaque changement de page, le cadre
  n'est plus refermé par un filet plein mais par un filet pâle (et le filet
  sous le titre du style « bandeau » n'est plus répété).
