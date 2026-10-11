#!/bin/bash
# Régénère les images du README (docs/exemple-<page>.png) en compilant
# EXACTEMENT le code du « Démarrage rapide » du README (premier bloc ```typ),
# avec le paquet de ce dépôt à la place de @preview : image et code ne
# peuvent pas diverger. À relancer après toute modification de ce code ou du
# rendu du paquet.
#
#   docs/generer-exemples.sh

set -e
cd "$(dirname "$0")/.."
mkdir -p tests/sortie
python3 - > tests/sortie/readme-exemple.typ <<'PY'
import re
bloc = re.search(r"```typ\n(.*?)```", open("README.md").read(), re.S).group(1)
print(re.sub(r'"@preview/profmaquette-minimal:[^"]*"', '"/src/lib.typ"', bloc), end="")
PY
rm -f docs/exemple-*.png
typst compile --root . tests/sortie/readme-exemple.typ "docs/exemple-{p}.png" --ppi 100
ls docs/exemple-*.png
