#!/usr/bin/env bash
# =============================================================
# download-assets.sh
# Downloads all Figma image assets to ./assets/ and patches
# the HTML files to use local paths.
#
# HOW TO USE:
#   1. Open Terminal
#   2. cd to this folder  (cd "path/to/IMPLEMENTATION PORTOLIO CLEMENT")
#   3. chmod +x download-assets.sh
#   4. ./download-assets.sh
#
# Requirements: curl (pre-installed on macOS)
# =============================================================

set -e

ASSETS_DIR="$(dirname "$0")/assets"
mkdir -p "$ASSETS_DIR"

BASE_URL="https://www.figma.com/api/mcp/asset"

download_asset() {
  local uuid="$1"
  local filename="$2"
  local ext="${3:-png}"
  local dest="$ASSETS_DIR/${filename}.${ext}"

  if [ -f "$dest" ]; then
    echo "  ✓ already exists: ${filename}.${ext}"
    return 0
  fi

  echo "  ↓ downloading: ${filename}.${ext}"
  if curl -fsSL --retry 2 \
    -H "User-Agent: Mozilla/5.0" \
    "${BASE_URL}/${uuid}" \
    -o "$dest" 2>/dev/null; then
    echo "  ✓ saved: ${filename}.${ext}"
  else
    echo "  ✗ failed (URL may have expired): ${filename}.${ext}" >&2
    echo "    → Upload the image manually to assets/ as: ${filename}.${ext}"
  fi
}

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║  Clément Blindron Portfolio — Asset Downloader   ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "Saving images to: ./assets/"
echo ""

# ── Homepage ─────────────────────────────────────────────────
echo "[ 1/3 ] Homepage assets…"
download_asset "f5043cd3-c1c8-40c6-93dc-9c2692e54631" "thumbnail-remediation"
download_asset "edc3e084-aee2-4391-a581-8a0b065525d0" "thumbnail-bmi"
download_asset "eabf5924-048b-4278-9b07-fc60e433d39b" "thumbnail-ds"

# ── Remediation page ─────────────────────────────────────────
echo "[ 2/3 ] Remediation page assets…"
download_asset "2bef38aa-8cf0-44ad-ad74-0510d0861ecb" "user-journey-1"
download_asset "b5c615e1-3c04-4347-b39b-0eda64f60328" "user-journey-2"
download_asset "ba223855-5f5f-49f4-864d-228763b913a7" "data-model"
download_asset "c0914d9b-5791-4419-81e0-3e548c09d800" "crazy8s-spritesheet"
download_asset "e1bac48c-3b85-4080-8dcb-46b2c049f5e8" "wireframes-1"
download_asset "47244d9c-1f37-4b2c-9fc6-ec15f11efc68" "wireframes-2"
download_asset "461560aa-95e8-451a-9102-4a72dde9b6c5" "wireframes-3"

# ── BMI page ─────────────────────────────────────────────────
echo "[ 3/3 ] BMI page assets…"
download_asset "c40d0103-2899-4922-89bf-602dde8b8c94" "bmi-hero-thumb"
download_asset "7d21991e-9c11-4819-ae35-9b5311752619" "raw-materials"
download_asset "2813f69c-4e81-42d8-bc97-bb162dc3da18" "battery-recycling"
download_asset "649f8ad5-4d1d-47aa-b08c-8b18219d7ec5" "new-technology"
download_asset "bb8c55bd-a64a-46b5-9f96-4ad24aa7f61f" "demand"
download_asset "66d475c1-4541-45ec-ba5e-b7974069fc1b" "mega-menu-before"
download_asset "4832dab0-c5af-45f2-9211-8d2e391d599e" "mega-menu-after" "gif"
download_asset "a3d08379-6f7c-419c-b5b4-aef05e125037" "app-launch-bg"
download_asset "696c4ef1-8fab-4c90-be8d-10e1fc16d87d" "iphone-mockup"
download_asset "26610af1-ed8b-47c1-b2d4-f86a98eb6da5" "app-store-badge"
download_asset "4895648a-b34e-4dc2-bc88-e5bf10b630c3" "google-play-badge"
download_asset "e5758205-ec26-4db7-b3fe-3a2c0627d29b" "photo-workplace"
download_asset "2130bce7-ef0e-42ec-8700-42658894bfef" "photo-penwell"
download_asset "0449a967-e2c1-4ee6-b1f1-0cc49bee813f" "photo-conference"
download_asset "0ae6640b-bebc-4274-ba34-39e72cc57383" "photo-event"
download_asset "499418c5-37e3-42fb-a1bf-1356b50f9002" "feature-prices"
download_asset "86a99dc8-e63f-4cc4-9ac6-eaf8649e71cd" "feature-news"
download_asset "1a9e941e-9915-45f7-954f-6c01dd51d7ee" "feature-events"
download_asset "318fe2b7-94ff-41c4-944c-0bff6627b92a" "feature-menu"
download_asset "df3debb9-533f-4768-9a7a-329f65d0f38c" "bmi-website-screenshot"
download_asset "a01ae993-acf7-4cb6-9bab-2e53c5847f6c" "julius-thumbnails"
download_asset "00bd4e9f-c032-4e75-a940-5d6e56f4adb2" "julius-documentation"
download_asset "830ee195-4d05-41eb-9493-e8cd6675b856" "julius-statistics"
download_asset "a95e029a-bef0-4704-9d91-11755fab2a8d" "market-compass" "gif"

echo ""
echo "──────────────────────────────────────────────────"
echo "  Done! Check ./assets/ for all downloaded files."
echo ""
echo "  Next step: run patch-html.sh to update HTML files"
echo "  to reference local ./assets/ paths instead of CDN URLs."
echo "──────────────────────────────────────────────────"
echo ""
