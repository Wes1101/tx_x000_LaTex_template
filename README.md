# Tx_x000 LaTeX Template

This repository provides a structured LaTeX template for Tx_x000 papers at DHBW Ravensburg, Campus Friedrichshafen. It is designed as a practical starting point for thesis/project-paper writing and keeps document sources, supporting materials, and helper tooling clearly separated.

## Repository overview

- [paper](paper): Main LaTeX source tree for the thesis/project paper.
- [app](app): Optional area for project implementation or PoC artifacts.
- [dhbw](dhbw): Official DHBW guideline and reference PDFs.
- [helper_scripts](helper_scripts): Utility scripts for build and cleanup.
- [.gitlab-ci.yml](.gitlab-ci.yml): CI pipeline for automatic PDF build.

## Paper module

The complete document setup lives in [paper](paper). The entry point is [paper/main.tex](paper/main.tex).

```text
paper/
  main.tex                  # Main document file
  packages.tex              # Package imports
  00_Project_Data.tex       # Project metadata (title, author, company, dates, ...)
  01_New_Commands.tex       # Custom LaTeX commands
  02_Listingstyle.tex       # Listing/code style configuration
  03_pages.tex              # Includes files from pages/
  04_chapters.tex           # Includes files from chapter/
  05_appendix.tex           # Includes files from appendix/
  pages/                    # Front matter and generated lists
  chapter/                  # Main chapter content
  appendix/                 # Appendix content
  literature/
    literature.bib          # Bibliography database
  pictures/                 # Logos, images, and visual assets
```

## Build workflow

Requirements:

- A LaTeX distribution with `latexmk`
- Running commands from the repository root

Preferred build command:

```bash
./helper_scripts/latexmk_build_clean paper/main.tex
```

What this does:

- Compiles with `latexmk` (`-file-line-error -halt-on-error`)
- Writes output to `paper/`
- Cleans generated auxiliary files afterwards

Build artifact:

```text
paper/main.pdf
```

GitLab CI build step:

```yaml
latexmk -pdf paper/main.tex -outdir="paper"
```

## Writing workflow

1. Maintain metadata in [paper/00_Project_Data.tex](paper/00_Project_Data.tex).
2. Add or adjust reusable commands in [paper/01_New_Commands.tex](paper/01_New_Commands.tex).
3. Manage front matter via [paper/pages](paper/pages) and the include file [paper/03_pages.tex](paper/03_pages.tex).
4. Write chapter content in [paper/chapter](paper/chapter) and include it in [paper/04_chapters.tex](paper/04_chapters.tex).
5. Add appendix content in [paper/appendix](paper/appendix) and include it in [paper/05_appendix.tex](paper/05_appendix.tex).
6. Maintain references in [paper/literature/literature.bib](paper/literature/literature.bib).
7. Rebuild the document after changes.

## Detailed folder guidance

### `paper/pages`

This folder stores additional pages (front matter and generated directories). Files are included via [paper/03_pages.tex](paper/03_pages.tex). If a page is not needed, remove or comment out its include there.

Typical pages:

- Title page
- Declaration of originality
- Abstract
- Table of contents
- List of abbreviations
- Glossary
- List of figures
- List of tables
- List of listings
- Bibliography
- Index
- Blocking note / Sperrvermerk

### `paper/chapter`

This folder contains the main chapter files. Existing files are a possible starter structure and can be adapted or removed. Keep [paper/04_chapters.tex](paper/04_chapters.tex) aligned with the actually used chapter files (remove/comment unused includes).

### `paper/appendix`

Store appendix documents/images here that are included with:

```latex
\anhang{#1 Groesse}{#2 Dateiname}{#3 Bildunterschrift}
```

### `paper/literature`

Store bibliography entries in [paper/literature/literature.bib](paper/literature/literature.bib). External tools (for example Citavi) can be used; export BibTeX and save it as `literature.bib` in this folder.

Useful note: BibTeX generator websites can help with creating entries. Ensure the desired citation style is set before copying entries.

### `paper/pictures`

- Contains placeholder logos (e.g. DHBW / company) that should be replaced with project-specific assets.
- Contains images/documents to be included with:

```latex
\bild{#1 Groesse}{#2 Dateiname}{#3 Bildunterschrift}
```

Supported formats include e.g. `pdf`, `jpg`, `png`. For embedding single pages from PDFs, use `\includepdf[options]{pdf-file}`.

### `app`

Optional directory for implementation artifacts (PoC/software part of the project).

### `dhbw`

Contains official DHBW documents and reference PDFs. Official source:
https://www.ravensburg.dhbw.de/service-einrichtungen/dokumente-downloads#Dokumente_Technik

## Notes

- Keep include files (`03_pages.tex`, `04_chapters.tex`, `05_appendix.tex`) synchronized with existing content files.
- Use relative paths for image assets in the paper module.
- `paper/main.pdf` is generated and can be recreated at any time.
