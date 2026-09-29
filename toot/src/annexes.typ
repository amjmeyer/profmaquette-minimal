#import "SETUP.typ": *
#set document(title: [Annexes])
#show: toot-page

#title[Annexes]

= Correspondance avec ProfMaquette

Pour qui connaît ProfMaquette, voici l'équivalent de ses clés et commandes.

#table(
  columns: 2,
  table.header[*ProfMaquette*][*profmaquette-minimal*],
  [environnement `Maquette`], [`maquette`],
  [clé `FdR`, `\AfficheFdR`], [`afficher-fdr`],
  [`Route`], [`route: true` (défaut)],
  [`Stop`], [`#thematique[…]` (ou `stop: true`)],
  [`AEntretenir`, zone Entrainement], [`entrainement:`, bloc Automatismes],
  [`Source`], [`source:`],
  [`Calculatrice`], [`calculatrice: false`],
  [environnement `Solution`], [`corrige`],
  [`CorrigeApres` / `CorrigeFin`], [`position-corriges: "apres"` / `"fin"`],
  [`VersSolution`], [`vers-corrige: true`],
  [`PasCorrige`], [`pas-corrige: true`],
  [`TitreSolution`, `TitreCorrige`], [`corrige(titre-complement: …)`, `titre-corriges:`],
)

Les types de documents de ProfMaquette,  les environnements `Reponse` ou `Indice`
n'ont pas d'équivalent.

= Ce qu'on ne peut pas faire

- *Pas de saut de page forcé dans un conteneur.* Une maquette placée dans
  `#columns(…)`, un `#block` ou une case de tableau ne peut pas laisser le
  bloc Correction (ni, avec `page-par-corrige: true`, chaque corrigé) sauter
  de page automatiquement : Typst l'interdit (« pagebreaks are not allowed
  inside of containers »). Il faut alors régler `nouvelle-page-corriges: false`
  et `page-par-corrige: false`.

- *Pas de maquette dans une maquette.* `#maquette[#maquette[…]]` arrête la
  compilation avec un message clair, de même que `#show: maquette.with()`
  utilisé deux fois dans le même document. Pour plusieurs fiches, faire un
  fichier par fiche.

- *Réglages invalides.* Une couleur qui n'en est pas une, un `style-exercice`
  ou une `position-corriges` hors des valeurs prévues, une sélection de
  corrigés mal écrite (`"3-1"`)… arrêtent la compilation avec un message
  clair plutôt que de produire un rendu silencieusement faux.

= Remerciements

Un grand merci à *Christophe Poulain*, auteur du package LaTeX
#link("https://ctan.org/pkg/profmaquette")[ProfMaquette] : profmaquette-minimal en
reprend la logique (exercices, feuille de route, entraînements, corrigés) et une
partie du vocabulaire. Les idées sont les siennes, et les limites de cette
adaptation sont les miennes. Pour un outil complet, utilisez ProfMaquette.

profmaquette-minimal utilise le paquet
#link("https://typst.app/universe/package/tiaoma")[tiaoma] pour les QR codes. Les
icônes (haltère, clé, coche, calculatrice) sont des dessins de
#link("https://fontawesome.com")[Font Awesome Free], sous licence CC BY 4.0. Cette
documentation est construite avec
#link("https://typst.app/universe/package/toot")[toot].

= Historique des versions

L'historique des versions se trouve dans le fichier
#link("https://github.com/amjmeyer/profmaquette-minimal/blob/main/CHANGELOG.md")[`CHANGELOG.md`]
du dépôt.
