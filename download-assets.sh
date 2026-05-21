#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# download-assets.sh
# Downloads all Figma CDN assets to ./assets/ and rewrites HTML/CSS references.
#
# HOW TO RUN (one-time, from your Terminal):
#   cd "/Users/clementblindron/Documents/Claude/Projects/IMPLEMENTATION PORTOLIO CLEMENT"
#   bash download-assets.sh
#
# What it does:
#   1. Creates ./assets/ directory
#   2. Downloads all 78 Figma images (auto-detects PNG/JPG/SVG extension)
#   3. Rewrites every figma.com URL in index.html, remediation.html,
#      bmi.html and style.css to a local ./assets/ path
#   4. Prints a summary — every file should show OK
# ─────────────────────────────────────────────────────────────────────────────

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ASSETS_DIR="$SCRIPT_DIR/assets"
FILES=("index.html" "remediation.html" "bmi.html" "style.css")

mkdir -p "$ASSETS_DIR"
echo "📁  Assets folder: $ASSETS_DIR"
echo ""

URLS=(
  "https://www.figma.com/api/mcp/asset/03dd8444-48c3-40b6-8a1a-6d53e53be77c"
  "https://www.figma.com/api/mcp/asset/05f1ce81-fcac-4cb6-8e0a-45b2a59bdeef"
  "https://www.figma.com/api/mcp/asset/07b7f997-11fe-4f3c-933d-04ce04399572"
  "https://www.figma.com/api/mcp/asset/081feb16-d8a0-4f1e-a1ca-ca7c1a3e20ea"
  "https://www.figma.com/api/mcp/asset/092b27c1-450c-4ce4-a078-ed7d671425c7"
  "https://www.figma.com/api/mcp/asset/09a1723a-925d-450e-86b8-7f8f4a2bc639"
  "https://www.figma.com/api/mcp/asset/09cb75fc-0529-451d-9caa-139558b177b0"
  "https://www.figma.com/api/mcp/asset/ecb0f354-bf47-48ac-97ae-45356b72cb75"
  "https://www.figma.com/api/mcp/asset/d8342c14-93df-4714-9538-75335a300a41"
  "https://www.figma.com/api/mcp/asset/0d56600b-b7a4-4276-a6a5-0773e37dad01"
  "https://www.figma.com/api/mcp/asset/13c2c70e-d862-4a20-94d3-4869305882f7"
  "https://www.figma.com/api/mcp/asset/1575ecbc-ba9d-4efa-9de6-cc967e12c5c9"
  "https://www.figma.com/api/mcp/asset/15fdb406-c1a5-4742-a904-74a353d68309"
  "https://www.figma.com/api/mcp/asset/6a2c60da-ba1c-4cf7-9708-02781a0d6a5b"
  "https://www.figma.com/api/mcp/asset/307f10b0-f35e-4ef5-95bc-2c51159143c3"
  "https://www.figma.com/api/mcp/asset/10a9c75c-9ca5-481f-9f33-811ba8115cab"
  "https://www.figma.com/api/mcp/asset/76d6742a-e248-4de6-91a5-9c4f5965e980"
  "https://www.figma.com/api/mcp/asset/ca138da4-67bb-4b37-94ac-861e6b12e1ed"
  "https://www.figma.com/api/mcp/asset/18677343-e295-4173-9036-d7886cfdec3c"
  "https://www.figma.com/api/mcp/asset/1951ace6-98a8-4c02-b890-8c3f0ef14cd8"
  "https://www.figma.com/api/mcp/asset/71ffcc8f-78ea-4a84-8927-3a6f5b27468a"
  "https://www.figma.com/api/mcp/asset/233b8eb6-badf-431a-ac12-ec3e232952a5"
  "https://www.figma.com/api/mcp/asset/247a8060-a7e7-481f-bdb4-9bffc2f4e9fc"
  "https://www.figma.com/api/mcp/asset/278e48f6-284f-4925-9388-836cf2bcaad7"
  "https://www.figma.com/api/mcp/asset/27a4c0e7-9c46-4850-934f-9ee16097f08e"
  "https://www.figma.com/api/mcp/asset/2822139e-2abc-4f2b-8b25-82783034c0d8"
  "https://www.figma.com/api/mcp/asset/80929142-b06b-4540-bff8-c1765ec1a2d7"
  "https://www.figma.com/api/mcp/asset/349dc878-f32c-4fcf-86f8-975a71416065"
  "https://www.figma.com/api/mcp/asset/35424598-3541-486d-ab0b-41ebec212a91"
  "https://www.figma.com/api/mcp/asset/9a73c78b-8d82-4ded-a1a4-00b214a1fd9d"
  "https://www.figma.com/api/mcp/asset/3bf645fa-c59b-4cec-b0b3-64c52a4e2507"
  "https://www.figma.com/api/mcp/asset/3df89e69-a8d0-4def-a3dc-31a718b4d74e"
  "https://www.figma.com/api/mcp/asset/493d08e5-074b-40d0-9a11-c0a7725b3cd3"
  "https://www.figma.com/api/mcp/asset/4e9725f4-896f-419d-b420-4db07662e819"
  "https://www.figma.com/api/mcp/asset/42e90052-a4f8-4c08-b75d-5e6f16475ea4"
  "https://www.figma.com/api/mcp/asset/6bfdaed7-d118-47e5-b7bf-ac5da9ea4c8d"
  "https://www.figma.com/api/mcp/asset/5875679c-7ee2-4ba9-aa0d-8513cb75c695"
  "https://www.figma.com/api/mcp/asset/58c1e0dd-a8ff-4e1f-aa5b-25649d4c78bd"
  "https://www.figma.com/api/mcp/asset/59c43619-e7a9-4cd8-9b20-16290967efc2"
  "https://www.figma.com/api/mcp/asset/5d29ba88-c84a-4a34-a698-27c7bcc639ff"
  "https://www.figma.com/api/mcp/asset/219b1a97-d721-4eb2-b654-ed69d3ce0d27"
  "https://www.figma.com/api/mcp/asset/614aa461-e43d-4f9b-ae0b-059620329b8f"
  "https://www.figma.com/api/mcp/asset/6528b669-811b-409a-833f-fe3cf6b766de"

  "https://www.figma.com/api/mcp/asset/6bf1812c-a056-4708-b7b4-304e70e4fd26"
  "https://www.figma.com/api/mcp/asset/6c30f940-8165-4e38-9966-205805689408"
  "https://www.figma.com/api/mcp/asset/70d9cff3-1306-4cf8-af7f-ea0b4b6aa13c"
  "https://www.figma.com/api/mcp/asset/8a56d0a6-91ff-47f1-a86c-a559fa8bdd94"
  "https://www.figma.com/api/mcp/asset/7257f3c5-ac36-4097-8be9-5fd5450710b9"
  "https://www.figma.com/api/mcp/asset/72823bb0-8c88-4475-8171-3ce66d28a187"
  "https://www.figma.com/api/mcp/asset/76fee6fc-c4ab-4e47-bc15-4c7c8a2585b1"
  "https://www.figma.com/api/mcp/asset/77a7a9f3-88d0-43b9-8573-c86f7226c9e6"
  "https://www.figma.com/api/mcp/asset/8145c8c8-4b13-45e3-bb89-27544e71450c"
  "https://www.figma.com/api/mcp/asset/8cc620ca-9e68-49d4-a1ee-81c06bcdc938"
  "https://www.figma.com/api/mcp/asset/ec6692aa-ebfd-445b-bd9d-9ee9f3448e03"
  "https://www.figma.com/api/mcp/asset/97db5d6e-801e-46ed-9263-740395476fa1"
  "https://www.figma.com/api/mcp/asset/98a0eb10-cb6c-4516-81c6-b96f3876ce5a"
  "https://www.figma.com/api/mcp/asset/991759e5-ab09-4242-892f-22576e5343a1"
  "https://www.figma.com/api/mcp/asset/9b2631ff-496e-4e57-aeed-2ba2f8c0f3b8"
  "https://www.figma.com/api/mcp/asset/9baa215f-2b94-4130-a649-b46fe2f39ef8"
  "https://www.figma.com/api/mcp/asset/9c69f078-707c-40b8-8c8d-2db224550af1"
  "https://www.figma.com/api/mcp/asset/9dd6ab78-76fa-42e7-bbcc-58adbcfb3160"
  "https://www.figma.com/api/mcp/asset/9e5bb640-5ad6-4f4d-a47f-3905211aa176"
  "https://www.figma.com/api/mcp/asset/a6102e53-837c-4018-a18f-b9595afed97d"
  "https://www.figma.com/api/mcp/asset/ab88c945-5e20-4b73-87e7-9b354d7e6c2a"
  "https://www.figma.com/api/mcp/asset/ae7f3194-5635-4bbd-9ad2-212249592d9c"
  "https://www.figma.com/api/mcp/asset/aea7b847-fcbc-4307-86e7-0f156030ebc4"
  "https://www.figma.com/api/mcp/asset/b1acbb89-bdb4-4e51-b2d1-b37ddb7d21a9"
  "https://www.figma.com/api/mcp/asset/b766bd04-c387-4930-b028-dd319dc38116"
  "https://www.figma.com/api/mcp/asset/b8654f74-0151-4a17-a57a-d421dbd640da"
  "https://www.figma.com/api/mcp/asset/bb812529-b02b-4815-a7a5-4ec8e4bef838"
  "https://www.figma.com/api/mcp/asset/c5b49ee2-8f6f-48b6-a5dd-57d1d955ec87"
  "https://www.figma.com/api/mcp/asset/c5fa608d-b82e-44ef-bd6e-19cb0fb778e2"
  "https://www.figma.com/api/mcp/asset/c705df12-a7e2-47bb-9c94-a8f64aa71239"

  "https://www.figma.com/api/mcp/asset/cdc6a61b-0eae-47b2-b4bc-5d547fcdbdaa"

  "https://www.figma.com/api/mcp/asset/cf0a638c-3806-4715-8b52-7ca49d764e43"


  "https://www.figma.com/api/mcp/asset/e85ebb6a-76ee-405e-8068-4780564c524d"
  "https://www.figma.com/api/mcp/asset/f1a6152d-1f12-4f6e-809a-6669d3e845a9"
  "https://www.figma.com/api/mcp/asset/f40cbb9e-c90f-4116-bdfe-f19a5cd727bd"
  "https://www.figma.com/api/mcp/asset/f90f3eab-f4fd-4ab2-beb9-e33bf1ca03d2"
  "https://www.figma.com/api/mcp/asset/fbce1f22-1a56-4a1b-ac99-05399791f6e7"
  "https://www.figma.com/api/mcp/asset/fdb43e0a-3831-445e-8732-5c07dc437e18"
  "https://www.figma.com/api/mcp/asset/fe7c401a-b325-4f24-afcc-e0159b4ffbd1"
)

# ── Step 1: Download each asset ───────────────────────────────────────────────
echo "⬇️   Downloading ${#URLS[@]} assets..."
echo ""

OK=0; FAIL=0

for URL in "${URLS[@]}"; do
  UUID="${URL##*/}"
  TMPFILE="$ASSETS_DIR/${UUID}.tmp"

  HTTP_CODE=$(curl -sSL -w "%{http_code}" -o "$TMPFILE" "$URL" 2>/dev/null)

  if [[ "$HTTP_CODE" != "200" ]] || [[ ! -s "$TMPFILE" ]]; then
    echo "  FAIL [$HTTP_CODE] $UUID"
    rm -f "$TMPFILE"
    (( FAIL++ )) || true
    continue
  fi

  # Detect file type from magic bytes
  MAGIC=$(xxd -p -l 4 "$TMPFILE" 2>/dev/null || true)
  case "$MAGIC" in
    89504e47) EXT=".png" ;;
    ffd8ff*)  EXT=".jpg" ;;
    47494638) EXT=".gif" ;;
    52494646) EXT=".webp" ;;
    *)
      HEAD=$(head -c 5 "$TMPFILE" 2>/dev/null || true)
      if [[ "$HEAD" == "<?xml" ]] || [[ "$HEAD" == "<svg " ]]; then
        EXT=".svg"
      else
        EXT=".png"
      fi
      ;;
  esac

  FINAL="$ASSETS_DIR/${UUID}${EXT}"
  mv "$TMPFILE" "$FINAL"
  echo "  OK  ${UUID}${EXT}"
  (( OK++ )) || true
done

echo ""
echo "✅  Downloaded: $OK  |  Failed: $FAIL"
echo ""

if [[ "$FAIL" -gt 0 ]]; then
  echo "⚠️   Some assets failed — Figma tokens may have expired."
  echo "    Start a new Cowork session to refresh URLs, then re-run this script."
  echo ""
fi

# ── Step 2: Rewrite URLs in HTML/CSS files ────────────────────────────────────
echo "🔁  Rewriting asset URLs in HTML/CSS files..."
echo ""

REPLACED=0

for FILE in "${FILES[@]}"; do
  FILEPATH="$SCRIPT_DIR/$FILE"
  [[ -f "$FILEPATH" ]] || continue

  BEFORE=$(grep -c 'figma\.com/api/mcp/asset' "$FILEPATH" 2>/dev/null; true)
  BEFORE=${BEFORE:-0}
  [[ "$BEFORE" -eq 0 ]] && continue

  for ASSET in "$ASSETS_DIR"/*; do
    [[ -f "$ASSET" ]] || continue
    BASENAME=$(basename "$ASSET")
    UUID="${BASENAME%.*}"
    FIGMA_URL="https://www.figma.com/api/mcp/asset/${UUID}"
    LOCAL_PATH="./assets/${BASENAME}"
    sed -i '' "s|${FIGMA_URL}|${LOCAL_PATH}|g" "$FILEPATH"
  done

  AFTER=$(grep -c 'figma\.com/api/mcp/asset' "$FILEPATH" 2>/dev/null; true)
  AFTER=${AFTER:-0}
  DIFF=$(( BEFORE - AFTER ))
  echo "  $FILE — $DIFF replaced, $AFTER remaining"
  REPLACED=$(( REPLACED + DIFF ))
done

echo ""
echo "🎉  Done! $REPLACED Figma URLs replaced with local paths."
echo ""
echo "Next steps:"
echo "  1. Open index.html in your browser — all images should load"
echo "  2. git add assets/ index.html remediation.html bmi.html style.css"
echo "  3. git commit -m 'chore: localise all Figma assets'"
echo "  4. git push — portfolio works forever on GitHub Pages"
