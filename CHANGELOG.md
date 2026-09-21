# Historique des versions

## 0.1.0 — non publiée

Première version, sous licence LPPL 1.3c (celle de ProfMaquette).

- `maquette` : réglages de toute la fiche en un seul appel, blocs de fin automatiques.
- `exercice` : exercices numérotés, obligatoires / facultatifs, entraînement en ligne
  (haltère + QR code), étiquette Source.
- `solution` : corrigés sous l'énoncé ou en fin de fiche, clé cliquable exercice ↔ corrigé.
- Sélection des corrigés affichés : `"1-6,9,12"`, `"obligatoires"`, `"facultatifs"`…
- Feuille de route : `#afficher-fdr`, en noir et blanc ; `#thematique[…]`
  titre les thématiques et y place les coches ; `stop: true` en ajoute à la main.
- Exercices obligatoires en noir par défaut.
- Cadres dessinés par le paquet (plus de dépendance à showybox).
- Icônes (haltère, clé, coche) fournies avec le paquet, en SVG (Font Awesome Free,
  CC BY 4.0) : plus de polices Font Awesome à installer, plus de dépendance à fontawesome.
- Robustesse (beta-tests, `tests/lancer.sh`) :
  - un énoncé plus haut qu'une page se coupe au lieu d'être tronqué ;
  - un titre d'exercice trop long passe à la ligne dans son étiquette ;
  - la feuille de route passe à la ligne entre deux thématiques si elle est trop large ;
  - les QR codes ne débordent plus de leur colonne ;
  - sur une page colorée, étiquettes et icônes prennent la couleur de la page ;
  - les réglages globaux du document (`set block`, `set box`, `set grid`…) ne
    déforment plus les cadres ni la feuille de route ;
  - message d'erreur clair pour une sélection de corrigés invalide ;
  - marges nulles : les icônes du filet droit restent dans le cadre ;
  - icônes, feuille de route, titres de thématique et de correction grandissent
    avec un texte de plus de 11 pt ;
  - bloc Automatismes trop haut pour flotter : il suit la fiche et se coupe entre
    deux pages ;
  - QR code agrandi si l'URL est trop longue pour rester lisible ;
  - message clair pour une maquette dans une autre maquette.
  - messages clairs pour les réglages invalides (couleur, nombre de colonnes,
    taille des QR codes) ; `corriges: ()` n'affiche aucun corrigé ;
  - une source longue passe à la ligne ;
  - la feuille de route reste de gauche à droite dans un texte écrit de droite à gauche ;
  - les blocs Automatismes et Correction ne s'affichent qu'une fois par fiche,
    même appelés à la main dans une maquette.
- `maquette(langue: …)` : mots du paquet en français, anglais, allemand, espagnol, italien.
- `maquette(correction-nouvelle-page: false)` : maquette utilisable dans `columns(…)` ou un cadre.
- Chaque `maquette` repart de l'exercice 1 (plusieurs fiches dans un même document).
- Couleurs `bleu-perso` et `rouge-perso` modifiables.
- `maquette(style-exercice: …)` : quatre styles de cadre, `"fond-blanc"` (défaut),
  `"etiquette-encadree"`, `"bandeau"` et `"etiquette-pleine"` ; `style-exercices(…)` sans maquette.
