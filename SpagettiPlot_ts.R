library(MASS)
library(nlme)
library(ggplot2)

### set number of individuals
n <- 200

### average intercept and slope
beta0 <- 1.0
beta1 <- 6.0

### true autocorrelation
ar.val <- .4

### true error SD, intercept SD, slope SD, and intercept-slope cor
sigma <- 1.5
tau0  <- 2.5
tau1  <- 2.0
tau01 <- 0.3

### maximum number of possible observations
m <- 10

### simulate number of observations for each individual
p <- round(runif(n,4,m))

### simulate observation moments (assume everybody has 1st obs)
obs <- unlist(sapply(p, function(x) c(1, sort(sample(2:m, x-1, replace=FALSE)))))

### set up data frame
dat <- data.frame(id=rep(1:n, times=p), obs=obs)

### simulate (correlated) random effects for intercepts and slopes
mu  <- c(0,0)
S   <- matrix(c(1, tau01, tau01, 1), nrow=2)
tau <- c(tau0, tau1)
S   <- diag(tau) %*% S %*% diag(tau)
U   <- mvrnorm(n, mu=mu, Sigma=S)

### simulate AR(1) errors and then the actual outcomes
dat$eij <- unlist(sapply(p, function(x) arima.sim(model=list(ar=ar.val), n=x) * sqrt(1-ar.val^2) * sigma))
dat$yij <- (beta0 + rep(U[,1], times=p)) + (beta1 + rep(U[,2], times=p)) * log(dat$obs) + dat$eij
plot(dat$id, pch='.')


library(plyr)
dat = ddply(dat, .(id), function(x){
  x$alpha = ifelse(runif(n = 1) > 0.9, 1, 0.1)
  x$grouper = factor(rbinom(n=1, size =3 ,prob=0.5), levels=0:3)
  x
})


#This is the spaghetti plot
tspag = ggplot(dat, aes(x=obs, y=yij)) + 
  geom_line() + guides(colour=FALSE) + xlab("Observation Time Point") +
  ylab("Y")
spag = tspag + aes(colour = factor(id))
spag