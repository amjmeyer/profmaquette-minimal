#!/bin/bash
# Compile les exemples du paquet comme s'il était déjà publié sur Typst Universe.
#
#   ./tester.sh           → examples/*.pdf
#   ./tester.sh --images  → en plus, docs/exemple-*.png (captures pour le README)
#   Dans les deux cas, compile aussi le manuel : docs/manuel.pdf
#
# Principe : on crée un dossier temporaire « preview/profmaquette-minimal/<version> » qui pointe vers
# ce dossier, et on le donne au compilateur (--package-path). Ainsi
# `#import "@preview/profmaquette-minimal:0.1.0"` trouve le paquet local au lieu de le télécharger.

set -e
cd "$(dirname "$0")"
VERSION=$(grep '^version' typst.toml | cut -d'"' -f2)

# Compilateur : `typst` s'il est installé, sinon celui de l'extension Tinymist de VSCodium.
if command -v typst > /dev/null; then
  TYPST=typst
else
  TYPST=$(ls -d ~/.var/app/com.vscodium.codium/data/codium/extensions/myriad-dreamin.tinymist-*/out/tinymist | tail -1)
  # Paquets @preview déjà téléchargés par VSCodium (tiaoma ; gentle-clues pour le manuel).
  export TYPST_PACKAGE_CACHE_PATH=~/.var/app/com.vscodium.codium/cache/typst/packages
fi

LOCAL=$(mktemp -d)
trap 'rm -rf "$LOCAL"' EXIT
mkdir -p "$LOCAL/preview/profmaquette-minimal"
ln -s "$PWD" "$LOCAL/preview/profmaquette-minimal/$VERSION"

for f in examples/*.typ; do
  echo "Compilation de $f"
  "$TYPST" compile --root . --package-path "$LOCAL" "$f" "${f%.typ}.pdf"
  if [ "$1" = "--images" ]; then
    "$TYPST" compile --root . --package-path "$LOCAL" --ppi 80 "$f" "docs/$(basename "${f%.typ}")-{p}.png"
  fi
done
echo "Compilation du manuel"
"$TYPST" compile --root . --package-path "$LOCAL" docs/manuel.typ docs/manuel.pdf
echo "OK"
