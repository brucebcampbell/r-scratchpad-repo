install.packages("igraph")
require(igraph)
setwd("~/Desktop/")

# Generate example data
M <- matrix(sample(0:1, 1450, replace=TRUE, prob=c(0.9,0.1)), nc=29)

# Transform matrices
adj=M%*%t(M)

# Make a simple plot
g<-graph.adjacency(adj,mode="undirected", weighted=TRUE,diag=FALSE)

summary(g)

plot(g, main="The bare minimum")

# Add more information
name<-sample(c(LETTERS, letters, 1:99), 29, replace=TRUE)

number<-diag(adj)*5+5

width<-(E(g)$weight/2)+1

plot(g, main="A little more information", vertex.size=number,vertex.label=name,edge.width=width)

# Adjust some plotting parameters
plot(g, main="Spice it up a notch", vertex.size=number, vertex.label=name, edge.width=width, layout=layout.lgl, vertex.color="red", edge.color="darkgrey", vertex.label.family ="sans", vertex.label.color="black")

