# profmaquette-minimal

Fiches d'exercices à la manière du package LaTeX
[ProfMaquette](https://ctan.org/pkg/profmaquette) de **Christophe Poulain** :
exercices numérotés, obligatoires ou facultatifs, feuille de route, entraînement
en ligne par QR code, et corrigés que l'on affiche — ou non — d'un seul réglage.

📖 **[Manuel complet (PDF)](docs/manuel.pdf)** : tous les réglages, un exemple et
son rendu pour chacun.

> [!NOTE]
> profmaquette-minimal reprend seulement une petite partie des idées de
> ProfMaquette, dont il s'inspire directement. Ses fonctionnalités sont **beaucoup plus limitées** que
> celles de l'original, qui reste la référence. Ce paquet a d'abord été écrit pour
> mon **usage personnel**. Il est partagé tel quel et **pourra évoluer**, y compris
> de façon incompatible entre deux versions `0.x`.

*Build exercise sheets (in French) inspired by Christophe Poulain's LaTeX package
ProfMaquette. See the [full manual (PDF)](docs/manuel.pdf) for details. It covers
only a small part of ProfMaquette's features, was first written for personal
use, and may change in future versions.*

<p align="center">
  <img src="docs/exemple-1.png" width="45%" alt="Feuille de route, puis énoncés : exercices encadrés, clé et haltère sur le filet, bloc Automatismes">
  <img src="docs/exemple-2.png" width="45%" alt="Corrigés regroupés en fin de fiche">
</p>

## Démarrage rapide

```typ
#import "@preview/profmaquette-minimal:0.1.0": maquette, exercice, solution, afficher-fdr, thematique

#show: maquette.with(
  localisation-correction: "fin",
)

#afficher-fdr

#thematique[Factoriser]
#exercice(titre: "Identités remarquables", entrainement: "https://exemple.fr")[
  Factoriser $x^2 - 9$.
]
#solution[
  $x^2 - 9 = (x - 3)(x + 3)$.
]

#thematique[Résoudre]
#exercice(titre: "Pour aller plus loin", obligatoire: false)[
  Résoudre $x^2 - 9 = 0$.
]
#solution[
  Les solutions sont $-3$ et $3$.
]
```

Un exemple complet se trouve dans [`examples/exemple.typ`](examples/exemple.typ).
Pour tous les réglages (`maquette`, `exercice`, feuille de route, styles de
cadre, langues…), voir le **[manuel (PDF)](docs/manuel.pdf)**.

## Historique des versions

Les changements de chaque version sont listés dans [CHANGELOG.md](CHANGELOG.md).

## Remerciements

Un grand merci à **Christophe Poulain**, auteur du package LaTeX
[ProfMaquette](https://ctan.org/pkg/profmaquette). profmaquette-minimal en
reprend la logique (exercices, feuille de route, entraînements, corrigés) et une
partie du vocabulaire. Les idées sont les siennes, et les limites de cette adaptation sont les miennes. Pour un outil
complet, utilisez ProfMaquette.

profmaquette-minimal utilise le paquet
[tiaoma](https://typst.app/universe/package/tiaoma) pour les QR codes. Les
icônes (haltère, clé, coche, calculatrice) sont des dessins de
[Font Awesome Free](https://fontawesome.com), fournis avec le paquet : il n'y a
aucune police à installer.

## Licence

LaTeX Project Public License (LPPL), version 1.3c ou toute version ultérieure —
voir [LICENSE](LICENSE). C'est la licence de ProfMaquette, dont ce paquet reprend
les idées.

Les icônes du dossier `src/icones/` sont des dessins de Font Awesome Free, sous
licence [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) :
*Font Awesome Free by @fontawesome — https://fontawesome.com*.

```
Copyright 2026 Arthur Meyer

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3c
of this license or (at your option) any later version.
The latest version of this license is in
  https://www.latex-project.org/lppl.txt
and version 1.3c or later is part of all distributions of LaTeX
version 2008 or later.

This work has the LPPL maintenance status `maintained'.
The Current Maintainer of this work is Arthur Meyer.

This work consists of the files src/lib.typ and src/exercices.typ.
```
