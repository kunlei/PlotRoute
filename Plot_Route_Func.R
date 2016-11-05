library(data.table)
library(ggplot2)
library(grid)

# PlotRoute <- function(NodeLoc, Routes) {
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

NodeLoc <- data.table(id = 1 : nrow(mtcars),
                      xcoord = mtcars$wt,
                      ycoord = mtcars$mpg)
setkey(NodeLoc, "id")


Routes <- list(d1 = c(11, 21, 13, 14), d2 = c(2,3,4,5, 6, 7, 8))

# create 

p <- ggplot(NodeLoc, aes(x = xcoord, y = ycoord)) + geom_point();
print(p)

# }