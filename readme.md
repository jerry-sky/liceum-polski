# Język polski w liceum — notatki

*Please note: this repository concerns notes written in Polish and about Polish literature so most of this repository is in Polish.*

---

Niniejsze repozytorium zawiera część notatek, które zostały sporządzone w ramach lekcji języka polskiego w [Akademickim Liceum Ogólnokształcącym Politechniki Wrocławskiej](https://liceum.pwr.edu.pl/).

## Repetytorium

1. [Starożytność + Style Wypowiedzi](repetytorium/starożytność.md)
2. [Średniowiecze](repetytorium/średniowiecze.md)
3. [Renesans, Kochanowski](repetytorium/renesans-kochanowski.md)
4. [Barok, Oświecenie, Preromantyzm](repetytorium/barok-oświecenie-preromantyzm.md)
5. [Romantyzm](repetytorium/romantyzm.md)
6. [Pozytywizm](repetytorium/pozytywizm.md)
7. [Młoda Polska](repetytorium/młoda-polska.md)
8. Międzywojnie — TBA
9. WW2 — TBA

---

*Poniżej znajdują się pewne techniczne detale odnoszące się do tego w jaki sposób niniejsza strona internetowa działa.*

---

## Website Deployment

This repository uses TypeScript and Bash scripts for rendering Markdown documents into HTML documents, and GitHub Actions for deployment.

To render the files first install necessary dependencies using
```bash
npm install
```
and then run
```bash
./main.sh
```
and the output files should appear in the `dist` directory.

To serve the website locally you can use
```bash
python3 -m http.server
```
whilst being inside the `dist` directory.

*This website is hosted using [GitHub Pages](https://pages.github.com).*

---

©Jerry Sky a.k.a. jwroczynski
