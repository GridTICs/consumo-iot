library(readr)

PATH <- setwd("~/phd-repos/consumo-iot")
PATH.DATA <- "~/phd-repos/consumo-iot/data-verde/"
#' leer lista de archivos en directorio
lista.archivos <- list.files(path=PATH.DATA,pattern = ".CSV")
rejunte <- data.frame(index=0,t=0,v=0)
for(i in 1:length(lista.archivos))
{
  #leer archivo
  aux <- read_csv(paste(PATH.DATA,lista.archivos[i],sep=""), col_names = FALSE,skip = 17)
  aux <- data.frame(index=1:nrow(aux),t=aux[4],v=aux[5]) # ignorar primeras tres columnas
  colnames(aux) <- c("index", "t","v") # nombre de columnas 
  # concatenar dataset por filas (row bind)
  rejunte <- rbind(rejunte, aux)
}
#' reescribo index
rejunte$index <- seq(from=0,by=1,to=nrow(rejunte)-1)

#' Generación de gráfica interactiva 
library(plotly)
p <- plot_ly(rejunte, x = ~index, y = ~v, type = 'scatter', mode = 'lines')
htmlwidgets::saveWidget(as.widget(p), "data-verde-graph-index-v.html")
#' gráfico estático
library(ggplot2)
