

SRC_FILES=$(wildcard *.tex)
HTML_FILES=$(patsubst %.tex,%.html,$(SRC_FILES))
MD_FILES=$(patsubst %.tex,%.md,$(SRC_FILES))
PDF_FILES=$(patsubst %.tex,%.pdf,$(SRC_FILES))



all: $(HTML_FILES) $(MD_FILES) $(PDF_FILES)

%.md: %.tex
	pandoc -s -f latex -w markdown init.tex.md $< | sed 's/\\maketitle//' | sed 's/\\tableofcontents//' > $@
%.html: %.tex
	pandoc -s --mathml -f latex -w html5 -o $@ init.tex.html $<
%.pdf: %.tex
	latexmk -pdf $<

.PHONY: install-deps install-deps-debian
install-deps: install-deps-debian
install-deps-debian: 
	apt install pandoc

.PHONY: clean distclean
distclean: clean
	rm -f $(HTML_FILES) $(MD_FILES) $(PDF_FILES)
clean:
	rm -f *.aux *.fls *.log *.toc *.fdb_latexmk *.out

