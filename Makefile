# when needed to use a specific module, run something like 
# make mod mid=2 
# to specify the module selected
mid=1
render_chap=bookdown::preview_chapter('Module$(mid)/index.Rmd', 'bookdown::gitbook')
	
pdf:
	Rscript --quiet "bookdown::pdf_book"

gitbook:
	Rscript -e "options(bookdown.render.file_scope = FALSE, pandoc.stack.size = '2048m'); bookdown::render_book('index.Rmd', 'bookdown::gitbook')"

mod:
	Rscript -e "$(render_chap)"

clean:
	rm -rf _book _bookdown_files *.html
	
renv:
	Rscript -e "renv::init(bare = TRUE); renv::snapshot()"

