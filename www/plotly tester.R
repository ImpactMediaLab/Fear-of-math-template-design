library(plotly)

library('plotly')
library('htmlwidgets')
library('RCurl')

image_file <- "www/survey_output_figure.png"
txt <- RCurl::base64Encode(readBin(image_file, "raw", file.info(image_file)[1, "size"]), "txt")


p <- plot_ly(x = c(1, 2, 3), y = c(1, 2, 3), type = 'scatter', mode = 'markers') %>%
  layout(
    images = list(
      list(
        source =  paste('data:image/png;base64', txt, sep=','),
        xref = "x",
        yref = "y",
        x = 1,
        y = 3,
        sizex = 2,
        sizey = 2,
        sizing = "stretch",
        opacity = 0.4,
        layer = "below"
      )
    )
  )
p

