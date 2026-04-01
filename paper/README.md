# LaTeX Project Template (Paper)

This repository provides a LaTeX template for creating Tx_x000 papers at DHBW Ravensburg, Campus Friedrichshafen. It is specifically tailored to the formal and structural requirements of these papers and is intended to support a consistent and submission-ready document setup.

This folder contains the complete thesis/project-paper source files.
The document entry point is `main.tex`.

## Structure

```text
paper/
  00_Project_Data.tex      # Project metadata (title, author, company, dates, ...)
  01_New_Commands.tex      # Custom LaTeX commands
  02_Listingstyle.tex      # Listing/code style configuration
  03_pages.tex             # Includes files from pages/
  04_chapters.tex          # Includes files from chapter/
  05_appendix.tex          # Includes files from appendix/
  packages.tex             # Package imports
  main.tex                 # Main document file

  pages/                   # Front matter and generated lists
  chapter/                 # Main content chapters
  appendix/                # Appendix content
  literature/              # Bibliography database (.bib)
  pictures/                # Image assets and references
```

## Build

Preferred: build via the helper script from the workspace root:

```bash
./helper_scripts/latexmk_build_clean paper/main.tex
```

The script compiles the document with `latexmk` and then removes generated auxiliary files.



## Typical Workflow

1. Update metadata in `00_Project_Data.tex`.
2. Add or adjust commands in `01_New_Commands.tex`.
3. Edit front matter in `pages/`.
4. Write content in `chapter/`.
5. Add appendix content in `appendix/`.
6. Manage references in `literature/literature.bib`.
7. Build using `./helper_scripts/latexmk_build_clean paper/main.tex`.

## Notes

- Keep include files (`03_pages.tex`, `04_chapters.tex`, `05_appendix.tex`) in sync with actual files.
- Use relative paths for images in `pictures/`.
- `main.pdf` is a build artifact and can be regenerated at any time.
