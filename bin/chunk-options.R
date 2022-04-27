# La plupart des elements sur cette page viennent du fichier du meme nom dans le cours r-raster-vector-geospatial de Data Carpentry
# Toutes les options peuvent etre trouvees ici: http://yihui.name/knitr/options#chunk_options

library("knitr")

opts_chunk$set(tidy = FALSE, comment = NA,
               fig.align = "center",
               fig.width = 7.5, fig.height = 7.5,
               fig.retina = 2, cache = FALSE,
               class.output = "codeout")
              

# Add this
# fig.process = fix_fig_path,
# fig.path = "fig/rmd-",


#This is from : https://community.rstudio.com/t/showing-only-the-first-few-lines-of-the-results-of-a-code-chunk/6963
hook_output <- knit_hooks$get("output")
knit_hooks$set(output = function(x, options) {
  lines <- options$output.lines
  if (is.null(lines)) {
    return(hook_output(x, options))  # pass to default hook
  }
  x <- unlist(strsplit(x, "\n"))
  more <- "..."
  if (length(lines) == 1) {        # first n lines
    if (length(x) > lines) {
      # truncate the output, but add ....
      #x <- c(head(x, lines), more)
      x <- c(head(x, lines),'...', tail(x,lines))
    }
  } else x <- c(more, x[lines], more)
  # paste these lines together
  x <- paste(c(x, ""), collapse = "\n")
  hook_output(x, options)
})
