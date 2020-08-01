MAIN=cv

all: $(MAIN).pdf

$(MAIN).pdf: rev.tex
	pdflatex $(MAIN).tex
	bibtex conf.aux
	bibtex journal.aux
	bibtex patent.aux
	pdflatex $(MAIN).tex
	pdflatex --synctex=1 $(MAIN).tex

rev.tex: FORCE
	@printf '\\gdef\\therev{%s}\n\\gdef\\thedate{%s}\n' \
	   "$(shell git rev-parse --short HEAD)"            \
	   "$(shell git log -1 --format='%ci' HEAD)" > $@

upload:
	scp $(MAIN).pdf soyeon@allspark.gtisc.gatech.edu:~/www/assets

clean:
	rm -f *.out *.log *.aux *.pdf *.bbl *.blg *.*~

.PHONY: clean FORCE

