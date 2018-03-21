library(plotly)

library('plotly')
library('htmlwidgets')
library('RCurl')

image_file <- "www/Spectrum_background.png"
txt <- RCurl::base64Encode(readBin(image_file, "raw", file.info(image_file)[1, "size"]), "txt")
dat <- read.csv("www/Default Dataset.csv", as.is=TRUE, header=F)
sum_score <- dat[1:10,]


p <- plot_ly(data = dat, x = ~V1, y = ~V2, type = 'scatter', mode = 'markers',
             hoverinfo = 'text',
             text = ~V3) %>% layout(
    xaxis = list(
      range = c(2.5, 8.6), 
      title = "",
      showticklabels = FALSE,
      showgrid = FALSE
    ),
    yaxis = list(
      range = c(2, 9), 
      title = "",
      showticklabels = FALSE,
      showgrid = FALSE
    ),
    images = list(
      list(
        source =  paste('data:image/png;base64', txt, sep=','),
        xref = "x",
        yref = "y",
        x = 2.3,
        y = 9.6,
        sizex = 6.4,
        sizey = 13,
        opacity = 1,
        type="stretch",
        layer = "below"
      )
    )
  ) %>% add_trace(data= sum_score, x = ~V1, y= ~V2, mode = 'markers', color="orange") %>%
  layout(showlegend = FALSE)
p


