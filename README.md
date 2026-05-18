# Clément Blindron — Portfolio 2026

Three-page portfolio site built in pure HTML / CSS / JavaScript.  
No frameworks, no build tools — opens directly in any browser.

---

## Pages

| File | Page |
|------|------|
| `index.html` | Homepage — hero, case studies, expertise, contact |
| `remediation.html` | Case study: Remediation Objectives (Panaseer) |
| `bmi.html` | Case study: Benchmark Mineral Intelligence |

---

## Deploying to GitHub Pages

### 1. Create a new GitHub repository

Name it anything — e.g. `portfolio` or `clement-blindron`.

### 2. Push these files

```bash
git init
git add .
git commit -m "Portfolio 2026 — initial deploy"
git remote add origin https://github.com/<your-username>/<repo-name>.git
git push -u origin main
```

### 3. Enable GitHub Pages

- Go to the repo → **Settings** → **Pages**
- Source: **Deploy from a branch**
- Branch: `main` / `(root)`
- Click **Save**

Your site will be live at:  
`https://<your-username>.github.io/<repo-name>/`

---

## Making images permanent (recommended before deploying)

The image files are currently linked from the Figma CDN. Those links
may expire after a few days. To make the site fully self-contained,
run the two scripts below **once** from Terminal:

```bash
# 1. Download all images to ./assets/
chmod +x download-assets.sh
./download-assets.sh

# 2. Update HTML files to use local paths
chmod +x patch-html.sh
./patch-html.sh
```

Then commit the `assets/` folder along with the updated HTML files.

---

## File structure

```
.
├── index.html              # Homepage
├── remediation.html        # Case study 1
├── bmi.html                # Case study 2
├── style.css               # Shared stylesheet (all pages)
├── .nojekyll               # Tells GitHub Pages not to use Jekyll
├── download-assets.sh      # Downloads Figma images to ./assets/
├── patch-html.sh           # Patches HTML to use local image paths
├── assets/                 # (created by download-assets.sh)
└── README.md               # This file
```

---

## Technology

- **HTML5** — semantic markup, ARIA roles, keyboard accessible
- **CSS3** — custom properties, grid, flexbox, `grid-template-rows` animation
- **Vanilla JS** — carousel, before/after toggle, design system tabs
- **Google Fonts** — Inter (all weights) + Montserrat
- **Responsive** — 1440px desktop · 1024px tablet · 375px mobile
- **Accessibility** — WCAG 2.1 AA targeting, `prefers-reduced-motion` support
