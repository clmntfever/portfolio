#!/usr/bin/env bash
# =============================================================
# patch-html.sh
# Replaces all Figma CDN URLs in HTML files with local paths.
# Run AFTER download-assets.sh has completed successfully.
# =============================================================

set -e
DIR="$(dirname "$0")"
BASE="https://www.figma.com/api/mcp/asset"

patch() {
  local uuid="$1"
  local filename="$2"
  local ext="${3:-png}"
  local local_path="./assets/${filename}.${ext}"
  local cdn_url="${BASE}/${uuid}"

  for f in index.html remediation.html bmi.html; do
    if grep -q "$cdn_url" "$DIR/$f" 2>/dev/null; then
      sed -i '' "s|${cdn_url}|${local_path}|g" "$DIR/$f"
      echo "  ✓ patched $f → ${local_path}"
    fi
  done
}

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║  Clément Blindron Portfolio — HTML Patcher       ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "Replacing CDN URLs with local ./assets/ paths…"
echo ""

# Homepage — card thumbnails (v2 updated May 2026)
patch "55f8c813-c554-4f3d-aaa3-1ee090f569f8" "thumbnail-remediation"
patch "200bf68e-ff08-412f-a48c-15d228889119" "thumbnail-bmi"
patch "4f5f1fe9-c419-4048-90dc-d6d87eeb9d45" "thumbnail-ds"

# Remediation
patch "2bef38aa-8cf0-44ad-ad74-0510d0861ecb" "user-journey-1"
patch "b5c615e1-3c04-4347-b39b-0eda64f60328" "user-journey-2"
patch "ba223855-5f5f-49f4-864d-228763b913a7" "data-model"
patch "c0914d9b-5791-4419-81e0-3e548c09d800" "crazy8s-spritesheet"
patch "e1bac48c-3b85-4080-8dcb-46b2c049f5e8" "wireframes-1"
patch "47244d9c-1f37-4b2c-9fc6-ec15f11efc68" "wireframes-2"
patch "461560aa-95e8-451a-9102-4a72dde9b6c5" "wireframes-3"

# BMI
patch "c40d0103-2899-4922-89bf-602dde8b8c94" "bmi-hero-thumb"
patch "7d21991e-9c11-4819-ae35-9b5311752619" "raw-materials"
patch "2813f69c-4e81-42d8-bc97-bb162dc3da18" "battery-recycling"
patch "649f8ad5-4d1d-47aa-b08c-8b18219d7ec5" "new-technology"
patch "bb8c55bd-a64a-46b5-9f96-4ad24aa7f61f" "demand"
patch "66d475c1-4541-45ec-ba5e-b7974069fc1b" "mega-menu-before"
patch "4832dab0-c5af-45f2-9211-8d2e391d599e" "mega-menu-after" "gif"
patch "a3d08379-6f7c-419c-b5b4-aef05e125037" "app-launch-bg"
patch "696c4ef1-8fab-4c90-be8d-10e1fc16d87d" "iphone-mockup"
patch "26610af1-ed8b-47c1-b2d4-f86a98eb6da5" "app-store-badge"
patch "4895648a-b34e-4dc2-bc88-e5bf10b630c3" "google-play-badge"
patch "e5758205-ec26-4db7-b3fe-3a2c0627d29b" "photo-workplace"
patch "2130bce7-ef0e-42ec-8700-42658894bfef" "photo-penwell"
patch "0449a967-e2c1-4ee6-b1f1-0cc49bee813f" "photo-conference"
patch "0ae6640b-bebc-4274-ba34-39e72cc57383" "photo-event"
patch "499418c5-37e3-42fb-a1bf-1356b50f9002" "feature-prices"
patch "86a99dc8-e63f-4cc4-9ac6-eaf8649e71cd" "feature-news"
patch "1a9e941e-9915-45f7-954f-6c01dd51d7ee" "feature-events"
patch "318fe2b7-94ff-41c4-944c-0bff6627b92a" "feature-menu"
patch "df3debb9-533f-4768-9a7a-329f65d0f38c" "bmi-website-screenshot"
patch "a01ae993-acf7-4cb6-9bab-2e53c5847f6c" "julius-thumbnails"
patch "00bd4e9f-c032-4e75-a940-5d6e56f4adb2" "julius-documentation"
patch "830ee195-4d05-41eb-9493-e8cd6675b856" "julius-statistics"
patch "a95e029a-bef0-4704-9d91-11755fab2a8d" "market-compass" "gif"

echo ""
echo "──────────────────────────────────────────────────"
echo "  HTML files updated. The site is now self-contained."
echo "  You can safely push to GitHub Pages."
echo "──────────────────────────────────────────────────"
echo ""
