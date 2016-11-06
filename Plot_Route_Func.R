library(data.table)
library(ggplot2)
library(grid)

PlotRoute <- function(NodeLoc, Routes) {
  # plot vehicle routes
  #
  # Args:
  #    NodeLoc: data table containing node locations, it must has three columns:
  #              id    xcoord    ycoord
  #               0      1.0       2.0  -this is the depot location
  #               1      2.3       3.4  -following rows are customers
  #               ...
  #    Routes: list of vectors containing vehicle routes on each day, all routes
  #            on a day are combined into a vector, it can have many columns
  #               d1    d2    d3
  #               0      0     0  -all routes must starts from depot
  #               2      1     3
  #               0      2     4
  #               1      3     0
  #               0      0     5
  #                      2     6
  #                      0     0  -all routes must end with depot
  #

  # test input
  # NodeLoc <- data.table(id = 0 : (nrow(mtcars) - 1),
  #                       xcoord = mtcars$wt,
  #                       ycoord = mtcars$mpg)
  # setkey(NodeLoc, "id")
  # Routes <- list(d1 = c(0, 2, 3, 0, 4, 5, 0), d2 = c(0, 5, 6, 7, 8, 0, 9, 0))

  # create connections
  num.days = length(Routes)
  plot.list <- list()
  for (i in 1 : num.days) {
    print(paste("i = ", i, sep = ""))
    # plot points represeing node locations
    p <- ggplot(NodeLoc, aes(x = xcoord, y = ycoord)) + geom_point() +
      geom_point(aes(x = NodeLoc[.(0)]$xcoord, y = NodeLoc[.(0)]$ycoord), colour = "red", size = 3)
    
    # get sequence of ndoes representing vehicle routes
    visit.seq <- Routes[[i]]
    num.node <- length(visit.seq)
    
    # get arc starting and ending points
    df <- data.frame(x1 = c(), x2 = c(), y1 = c(), y2 = c())
    for (j in 1 : (num.node - 1)) {
      new.row <- c(x1 = NodeLoc[.(visit.seq[j])]$xcoord, x2 = NodeLoc[.(visit.seq[j + 1])]$xcoord,
                   y1 = NodeLoc[.(visit.seq[j])]$ycoord, y2 = NodeLoc[.(visit.seq[j + 1])]$ycoord)
      df <- rbind(df, new.row)
    }
    names(df) <- c("x1", "x2", "y1", "y2")
    
    # save grpah
    p <- p + geom_segment(data = df, aes(x = x1, y = y1, xend = x2, yend = y2),
                          arrow = arrow(angle = 20, length = unit(0.10, "inches"), type = "closed")) +
      xlab(paste("Day ", i, sep = "")) + ylab("")
    
    plot.list[[i]] <- p
  }

  multiplot(plotlist = plot.list)
}