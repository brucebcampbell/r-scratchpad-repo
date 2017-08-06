require(Matrix) ## for sparse matrices
require(igraph) ## for the function arpack

## assume you already have an igraph object, though any (sparse) matrix object should work

mygraph <- make_ring(10)
mymat <- get.adjacency(mygraph,sparse=TRUE)
func <- function(x, extra=NULL) { as.vector(mymat %*% x) } 
vals <- arpack(func, options=list(n=vcount, nev=3, ncv=8), sym=TRUE)$values


f <- function(x, extra=NULL) x
arpack(f, options=list(n=10, nev=2, ncv=4), sym=TRUE)

# Graph laplacian of a star graph (undirected), n>=2
# Note that this is a linear operation
f <- function(x, extra=NULL) {
  y <- x
  y[1] <- (length(x)-1)*x[1] - sum(x[-1])
  for (i in 2:length(x)) {
    y[i] <- x[i] - x[1]
  }
  y
}

arpack(f, options=list(n=10, nev=1, ncv=3), sym=TRUE)

# double check
eigen(laplacian_matrix(make_star(10, mode="undirected")))

## First three eigenvalues of the adjacency matrix of a graph
## We need the 'Matrix' package for this
if (require(Matrix)) {
  g <- sample_gnp(1000, 5/1000)
  M <- as_adj(g, sparse=TRUE)
  f2 <- function(x, extra=NULL) { cat("."); as.vector(M %*% x) }
  baev <- arpack(f2, sym=TRUE, options=list(n=vcount(g), nev=3, ncv=8,
                                            which="LM", maxiter=200))
}



####################RcppEigen
library(RcppEigen)
dd <- data.frame(f1 = gl(4, 6, labels = LETTERS[1:4]),
                   + f2 = gl(3, 2, labels = letters[1:3]))[-(7:8), ]
xtabs(~ f2 + f1, dd)
mm <- model.matrix(~ f1 * f2, dd)
kappa(mm)
#This yields a large condition number, indicating rank deficiency. Alternatively, the reciprocal
#condition number can be evaluated.
rcond(mm)
(c(rank = qr(mm)$rank, p = ncol(mm)))
set.seed(1)
dd$y <- mm %*% seq_len(ncol(mm)) + rnorm(nrow(mm), sd = 0.1)
fm1 <- lm(y ~ f1 * f2, dd)
writeLines(capture.output(print(summary(fm1), + signif.stars = FALSE)))

#####Timing some Blas : see http://simplystatistics.org/2016/01/21/parallel-blas-in-r/
system.time({ x <- replicate(5e3, rnorm(5e3)); tcrossprod(x) })


####################iGraph - note this is the package for Arpack interface as well


# plotting a simple ring graph, all default parameters, except the layout
g <- make_ring(10)
g$layout <- layout_in_circle
plot(g)
tkplot(g)
rglplot(g)
# plotting a random graph, set the parameters in the command arguments
g <- barabasi.game(100)
plot(g, layout=layout_with_fr, vertex.size=4,
     vertex.label.dist=0.5, vertex.color="red", edge.arrow.size=0.5)
# plot a random graph, different color for each component
g <- sample_gnp(100, 1/100)
comps <- components(g)$membership
colbar <- rainbow(max(comps)+1)
V(g)$color <- colbar[comps+1]
plot(g, layout=layout_with_fr, vertex.size=5, vertex.label=NA)
# plot communities in a graph
g <- make_full_graph(5) %du% make_full_graph(5) %du% make_full_graph(5)
g <- add_edges(g, c(1,6, 1,11, 6,11))
com <- cluster_spinglass(g, spins=5)
V(g)$color <- com$membership+1
g <- set_graph_attr(g, "layout", layout_with_kk(g))
plot(g, vertex.label.dist=1.5)
# draw a bunch of trees, fix layout
igraph_options(plot.layout=layout_as_tree)
plot(make_tree(20, 2))
plot(make_tree(50, 3), vertex.size=3, vertex.label=NA)
tkplot(make_tree(50, 2, mode="undirected"), vertex.size=10,
       vertex.color="green")



########################### Markov Chain 
library(expm)
library(markovchain)
library(diagram)
library(pracma)

stateNames <- c("Rain","Nice","Snow")
Oz <- matrix(c(.5,.25,.25,.5,0,.5,.25,.25,.5),
             nrow=3, byrow=TRUE)
row.names(Oz) <- stateNames; colnames(Oz) <- stateNames
Oz

#      Rain Nice Snow
# Rain 0.50 0.25 0.25
# Nice 0.50 0.00 0.50
# Snow 0.25 0.25 0.50

plotmat(Oz,pos = c(1,2), 
        lwd = 1, box.lwd = 2, 
        cex.txt = 0.8, 
        box.size = 0.1, 
        box.type = "circle", 
        box.prop = 0.5,
        box.col = "light yellow",
        arr.length=.1,
        arr.width=.1,
        self.cex = .4,
        self.shifty = -.01,
        self.shiftx = .13,
        main = "")

Oz3 <- Oz %^% 3
round(Oz3,3)