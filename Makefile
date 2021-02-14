pdf:
	Rscript --quiet _render.R "bookdown::pdf_book"

gitbook:
	Rscript --quiet _render.R "bookdown::gitbook"

all:
	Rscript --quiet _render.R

clean:
	rm -rf _book _bookdown_files *.html