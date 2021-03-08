pdf:
	Rscript --quiet "bookdown::pdf_book"

gitbook:
	Rscript -e "options(bookdown.render.file_scope = FALSE); bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

all:
	Rscript --quiet _render.R

clean:
	rm -rf _book _bookdown_files *.html
	
