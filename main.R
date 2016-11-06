
library(ggplot2)


source("Multi_Plot_Func.R")

con <- file("best-n10-d3-c3.txt", "r")
data <- readLines(con)
close(con)

NodeLoc <- data.table(id = 0 : 10,
                      xcoord = as.numeric(unlist(strsplit(data[1], " "))),
                      ycoord = as.numeric(unlist(strsplit(data[2], " "))))
setkey(NodeLoc, "id")

Routes <- list(d1 = as.integer(unlist(strsplit(data[3], " "))),
                     d2 = as.integer(unlist(strsplit(data[4], " "))),
                     d3 = as.integer(unlist(strsplit(data[5], " "))))

PlotRoute(NodeLoc, Routes)
