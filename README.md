# Tx_x000 LaTeX Repository

This repository provides a structured LaTeX template and supporting material for creating Tx_x000 papers at DHBW Ravensburg, Campus Friedrichshafen.
It is organized to separate the actual paper source, institutional reference material, helper scripts, and planning artifacts.

## Repository Overview

- [app](app/README.md): Optional implementation area for project-related software artifacts.
- [dhbw](dhbw): Official DHBW guideline and reference PDFs.
- [dhbw_docs](dhbw_docs): Editable DHBW-related document templates and source material.
- [helper_scripts](helper_scripts): Utility scripts for building and cleaning LaTeX projects.
	- Main build script: [helper_scripts/latexmk_build_clean](helper_scripts/latexmk_build_clean)
- [paper](paper/README.md): Main thesis/project paper workspace with all LaTeX sources.
- [roadmap](roadmap/README.md): Roadmap document source and generated PDF.
- [sources](sources): Source collection and bibliography-related notes.

## Paper Module Details

The [paper](paper) folder contains the complete document setup and is split into dedicated subfolders for front matter, chapters, appendix content, literature, and images.

- [paper/pages](paper/pages/README.md): Front matter and generated lists.
- [paper/chapter](paper/chapter/README.md): Main chapter content files.
- [paper/appendix](paper/appendix/README.md): Appendix content.
- [paper/literature](paper/literature/README.md): Bibliography data and literature assets.
- [paper/pictures](paper/pictures/README.md): Logos and image assets used in the paper.

## Build Workflow

Use the helper script from the repository root to compile and clean the paper in one step:

- ./helper_scripts/latexmk_build_clean paper/main.tex

For document-specific details, see [paper/README.md](paper/README.md).
