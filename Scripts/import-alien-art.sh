#!/usr/bin/env bash
# Import alien artwork into the app's asset catalog.
#
# Usage:  Scripts/import-alien-art.sh <folder-of-images>
#
# Name each image after the alien: lowercase, letters/digits only, e.g.
#   heatblast.png  wildmutt.png  diamondhead.png  xlr8.png  greymatter.png
#   fourarms.png   stinkfly.png  ripjaws.png      upgrade.png ghostfreak.png
#   cannonbolt.png wildvine.png  blitzwolfer.png  snareoh.png frankenstrike.png
#   upchuck.png    ditto.png     eyeguy.png       waybig.png
# PNG (transparent background looks best), JPG or WEBP all work.
# Images are resized to max 400px on the long edge and converted to PNG.
# Any alien without an image keeps its SF Symbol.
set -euo pipefail

SRC="${1:?Usage: $0 <folder-of-images>}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/Omnitrix/Assets.xcassets/AlienArt"

SLUGS=(heatblast wildmutt diamondhead xlr8 greymatter fourarms stinkfly ripjaws
       upgrade ghostfreak cannonbolt wildvine blitzwolfer snareoh frankenstrike
       upchuck ditto eyeguy waybig)

mkdir -p "$DEST"
printf '{\n  "info" : { "author" : "xcode", "version" : 1 }\n}\n' > "$DEST/Contents.json"

imported=0; missing=()
for slug in "${SLUGS[@]}"; do
  src=""
  for ext in png PNG jpg jpeg JPG JPEG webp WEBP; do
    [[ -f "$SRC/$slug.$ext" ]] && { src="$SRC/$slug.$ext"; break; }
  done
  if [[ -z "$src" ]]; then missing+=("$slug"); continue; fi

  set="$DEST/$slug.imageset"
  rm -rf "$set"; mkdir -p "$set"
  sips -s format png -Z 400 "$src" --out "$set/$slug.png" >/dev/null
  cat > "$set/Contents.json" <<EOF
{
  "images" : [ { "filename" : "$slug.png", "idiom" : "universal" } ],
  "info" : { "author" : "xcode", "version" : 1 }
}
EOF
  imported=$((imported + 1))
done

echo "Imported $imported / ${#SLUGS[@]} images into Assets.xcassets/AlienArt"
if (( ${#missing[@]} )); then
  echo "No image found for (will use SF Symbol): ${missing[*]}"
fi
