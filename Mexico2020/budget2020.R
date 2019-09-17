

# Libraries

library(networkD3)
library(dplyr)



budget <- read.csv("budget2020.csv", header = TRUE ) # load data
budget <- budget[, colSums(is.na(budget)) != nrow(budget)] #remove  NA cols


# From these flows we need to create a node data frame: it lists every entities involved in the flow
nodes <- data.frame(
  name=c(as.character(budget$ï..Fuente),
         as.character(budget$Objetivo)) %>% unique()
)


# With networkD3, connection must be provided using id, not using real name like in the links dataframe.. So we need to reformat it.
budget$IDsource <- match(budget$ï..Fuente, nodes$name)-1
budget$IDtarget <- match(budget$Objetivo, nodes$name)-1



# Make the Network
p <- sankeyNetwork(Links = budget, Nodes = nodes,
                   Source = "IDsource", Target = "IDtarget",
                   Value = "Valor", NodeID = "name",
                   sinksRight=F,fontSize = 12)

p


