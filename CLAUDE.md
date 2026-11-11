# CLAUDE.md

LaTeX template for DHBW papers (project reports, term papers, theses). Document language is **English**; keep comments, docs and commit messages in English. See `README.md` for setup and the full command table.

## Layout

All document sources are in `paper/`; `main.tex` is the entry point and only wires things together.

| File / folder | Edit it to ... |
|---|---|
| `00_Project_Data.tex` | set title, author, company, university, logos, link colors |
| `pages/` + `03_pages.tex` | change front matter (title page, declarations, abstract, lists, bibliography, AI note) |
| `chapter/` + `04_chapters.tex` | write chapters. A new chapter needs a file **and** an `\include{chapter/<name>}` line |
| `appendix/` + `05_appendix.tex` | write appendix chapters, same rule |
| `literature/literature.bib` | add references (biblatex, cite with `\cite{key}`) |
| `pictures/` | images (referenced without extension) |
| `packages.tex` | add packages (one line each, with a short comment) |
| `01_New_Commands.tex` | custom commands, colors, glossary entries |
| `.latexmkrc` | build configuration; change only if the build itself must change |

## Build and debug

Run from `paper/`:

```bash
latexmk -quiet main.tex   # build paper/build/main.pdf, errors and warnings are summarized at the end
latexmk -C                # remove build output
```

- The block `==== Errors and warnings ====` at the end of a run is the first thing to read. Format: `./file.tex:LINE: message`.
- The full log is `paper/build/main.log`; biber messages are in `paper/build/main.blg`.
- Build output (`paper/build/`, `out/`) is git-ignored. Never commit it.
- Do not run `pdflatex` directly: bibliography, glossary, abbreviations and index need several passes, which `latexmk` handles.
- IDEs (IntelliJ/TeXiFy, VS Code) call the same `latexmk` and pass their own `-outdir`/`-auxdir`; `.latexmkrc` creates the sub-folders `\include` needs in both.

### Common problems

| Symptom | Likely cause |
|---|---|
| `I can't write on file 'pages/xx.aux'` | output sub-folder missing: build with `latexmk` from `paper/`, not a custom command |
| `Citation ... undefined` | key not in `literature.bib`, or biber has not run yet (latexmk reruns automatically) |
| `Label ... multiply defined` | `\figsrc` builds the label `fig:<file>`; the same image used twice |
| `File ... not found` for an image | path is relative to `paper/` and `\figsrc` already prepends `pictures/`; give the name without extension and folder |
| List of abbreviations / glossary empty | entries missing (`\abbr`, `\newglossaryentry` + `\gls`); the tools run via latexmk |
| `Overfull`/`Underfull \hbox` | formatting only; usually long words or URLs in a narrow column |
| Wrong appendix numbering | appendix files must use plain `\chapter{...}` (after `\appendix` in `main.tex`); `\appsection` no longer exists |

## Writing conventions

- One sentence per line is fine; keep chapters in separate files, name them `NN_topic.tex` with steps of 10 so chapters can be inserted.
- Cite with `\cite{key}` / `\cite[p.~12]{key}`. Use `~` before references and citations (`Figure~\ref{...}`); `\autoref` already adds the name.
- Labels: `fig:<file>` (set by `\figsrc`), `app:<name>` for appendix chapters, `tab:<name>` for tables, `chap:<name>` for chapters, `lst:<name>` for listings.
- Figures: `\figsrc{0.8}{file}{Caption}{bibkey}[page]` (size is a fraction of the text width, a source is mandatory). Appendix figures: `\appfigure{size}{file}{caption}`.
- Abbreviations: `\abbr{API}{Application Programming Interface}` once, anywhere in the text. Glossary terms: define with `\newglossaryentry` in `01_New_Commands.tex`, use with `\gls{key}`.
- Tables use `booktabs` (`\toprule`, `\midrule`, `\bottomrule`) and the column types `C{w}`, `L{w}`, `R{w}`, `P{w}`.
- Prefer existing commands over new ones. A new command goes into `01_New_Commands.tex` with a comment (signature and purpose) and a row in the README table.
- Do not add packages without need; check `packages.tex` first (amsmath, booktabs, longtable, multirow, float, listings, pdfpages, eurosym, ulem, contour and more are loaded already).
- The AI usage note (`pages/12_AI_usage_note.tex`) must list the tools actually used; keep it truthful when you help write text.

## Helping with a paper

1. Read `00_Project_Data.tex`, `04_chapters.tex` and the relevant chapter file before changing anything.
2. When inserting content: put it in the right chapter file, add `\include` if you created a file, build, and check the error summary.
3. When correcting text: change only what was asked; do not reflow, rename labels or reorder chapters unless requested (labels are referenced elsewhere: `grep -rn "<label>" paper --include=*.tex`).
4. When debugging: reproduce with `latexmk -quiet main.tex`, fix the **first** reported error (later ones are often follow-ups), rebuild.
5. Report what you built and any remaining warnings. Do not claim the PDF is correct without a successful build.

## Repository rules

- `main` holds the generic template; variant branches (for example `ifm`) hold company-specific data (logo, link color, address, guideline PDFs). Put generic changes on `main` and merge or rebase them into the variants; keep company data out of `main`.
- Commit or push only when asked.
- `Backlog.md` is a local scratch file (excluded via `.git/info/exclude`); never commit it.
