# Historique des versions

## Non publié

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
- Exercice plus haut qu'une page : à chaque changement de page, le cadre
  n'est plus refermé par un filet plein mais par un filet pâle (et le filet
  sous le titre du style « bandeau » n'est plus répété).

## 0.1.0 — version de départ
