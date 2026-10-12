# Build the progress report.
#   make        -> report.pdf
#   make clean  -> remove build artefacts, keep report.pdf
#   make purge  -> remove build artefacts and report.pdf

# Every section is a prerequisite: report.tex only \input{}s them, so a rule
# naming report.tex alone reports "up to date" after a section changes.
SECTIONS := $(wildcard sections/*.tex)

report.pdf: report.tex $(SECTIONS)
	latexmk -pdf -interaction=nonstopmode -halt-on-error report.tex

clean:
	latexmk -c

purge:
	latexmk -C

.PHONY: clean purge
