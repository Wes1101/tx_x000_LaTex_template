# DHBW LaTeX Paper Template

A LaTeX template for papers at the DHBW (project reports, term papers, bachelor theses). It uses `scrreprt` (KOMA-Script), biblatex/biber, a glossary, a list of abbreviations and an index, and builds with a single `latexmk` command.

**Credits:** originally created by Florian Christoph Veit (2021). Maintained and extended by David Willig.

## Repository layout

```text
paper/                      # everything that ends up in the PDF
  main.tex                  # entry point
  .latexmkrc                # build configuration (output dir, biber, error summary)
  packages.tex              # package imports
  00_Project_Data.tex       # title, author, company, university, dates, logo path
  01_New_Commands.tex       # custom commands and colors
  02_Listingstyle.tex       # source code style
  03_pages.tex              # front matter, includes pages/
  04_chapters.tex           # chapters, includes chapter/
  05_appendix.tex           # appendix, includes appendix/
  pages/                    # title page, declarations, abstract, lists, bibliography, ...
  chapter/                  # chapter files
  appendix/                 # appendix files and images
  literature/literature.bib # bibliography database
  pictures/                 # images and logos (company_logo.pdf is a placeholder)
dhbw/                       # official DHBW guidelines (PDF); check for newer versions
.vscode/, .idea/            # shared editor settings (VS Code, IntelliJ)
.gitlab-ci.yml              # CI: builds the PDF, packages releases on tags
```

## Prerequisites

You need a TeX distribution that includes `pdflatex`, `latexmk`, `biber` and `makeindex`, plus Perl (used by `latexmk`).

| OS | Installation |
|---|---|
| macOS | `brew install --cask mactex-no-gui` (full, ~5 GB) or `brew install texlive` |
| Linux (Debian/Ubuntu) | `sudo apt install texlive-full latexmk biber` (smaller: `texlive-latex-extra texlive-bibtex-extra biber latexmk`) |
| Windows | [TeX Live](https://tug.org/texlive/windows.html) (includes Perl). With MiKTeX, additionally install [Strawberry Perl](https://strawberryperl.com/). |

Verify with `latexmk -v` and `biber --version`.

## Building

All options are in [`paper/.latexmkrc`](paper/.latexmkrc): output goes to `paper/build/`, biber and the index/glossary tools run automatically, and errors and warnings are printed again at the end of the run.

```bash
cd paper
latexmk main.tex            # build paper/build/main.pdf
latexmk -quiet main.tex     # same, with less output (errors are still summarized at the end)
latexmk -pvc main.tex       # rebuild on every change
latexmk -C                  # delete build output
```

### IntelliJ IDEA / PhpStorm (TeXiFy)

1. Install the **TeXiFy IDEA** plugin.
2. Open the repository root. The shared run configuration **Build: main** appears in the run dropdown; it uses `latexmk` and writes to `paper/build`.
3. Run it. TeXiFy shows errors and warnings in the build tool window.

### VS Code

1. Install the **LaTeX Workshop** extension (recommended automatically via `.vscode/extensions.json`).
2. Open the repository root and `paper/main.tex`. The PDF is built on save and shown in a tab.
3. Errors and warnings appear in the *Problems* panel.

## Writing workflow

1. Fill in [`00_Project_Data.tex`](paper/00_Project_Data.tex) and replace [`pictures/company_logo.pdf`](paper/pictures) with your logo.
2. Edit the abstract and the AI usage note in [`pages/`](paper/pages). Remove pages you do not need in [`03_pages.tex`](paper/03_pages.tex).
3. Write chapters in [`chapter/`](paper/chapter) and list them in [`04_chapters.tex`](paper/04_chapters.tex).
4. Add appendix chapters in [`appendix/`](paper/appendix), starting with `\appsection{Title}{label}`, and list them in [`05_appendix.tex`](paper/05_appendix.tex).
5. Add references to [`literature/literature.bib`](paper/literature/literature.bib) (export from Citavi/Zotero or write by hand) and cite with `\cite{key}`.

### Custom commands

| Command | Purpose |
|---|---|
| `\figsrc{size}{file}{caption}{bibkey}[page]` | Figure from `pictures/` with a source line. Size is a fraction of the text width. |
| `\appfigure{size}{file}{caption}` | Figure from `appendix/`. |
| `\appsection{title}{label}`, `\appref{label}` | Appendix chapter and a reference to it. |
| `\abbr{abbreviation}{meaning}` | Entry in the list of abbreviations. |
| `\gls{key}` | Glossary term; define entries with `\newglossaryentry` in `01_New_Commands.tex`. |
| `\mypageref{label}` | "Figure 1.1 on page 5". |
| `\myboxquote{text}` | Quote on a gray background. |
| `\myparagraph{title}`, `\mysubparagraph{title}` | Paragraph headings with a line break. |
| `\includepdf[pages=..]{file}` | Include PDF pages (package `pdfpages`). |

## Using the template for a new paper

Do not fork or keep the template's history. Start a fresh repository instead:

- **GitHub:** open the template repository and click **Use this template → Create a new repository** (enable *Settings → Template repository* once). The new repository starts with a single clean commit.
- **Release zip:** download the latest release (`git archive` output, no history) and `git init` in the extracted folder. For GitLab, pushing a tag such as `v1.0.0` makes the CI create this zip as a job artifact.
- **Manual clone:**
  ```bash
  git clone --depth 1 <template-url> my-paper
  cd my-paper
  rm -rf .git && git init && git add -A && git commit -m "Initial commit"
  git remote add origin <your-repo-url>
  ```

## Variants

- `main`: generic template (this branch).
- `ifm`: the same template preconfigured for ifm (logo, link color, company abbreviation). Merge `main` into it to receive template updates.

## CI

[`.gitlab-ci.yml`](.gitlab-ci.yml) builds `paper/build/main.pdf` with `latexmk` and keeps the PDF and the log as artifacts (also on failure). Pin the TeX Live image tag for reproducible builds.
