
# plot the picture for the residual life theorem

plot(x=NA,xlim=c(0,10),ylim=c(-0.50,0.50),xlab="",ylab="",axes=F)

# draw basic time line
curve(0*x,0,10,axes=F,xlab="",ylab="",ylim=c(-2,2), add=T)

# draw hash marks
segments(1,-0.1,1,0.1)  # Qlast
segments(2.5,-0.1,2.5,0.1)  # W(t)
segments(9,-0.1,9,0.1)  # Qnext
segments(6,-0.1,6,0.1)  # t

# text labels for the hash marks
text(0.9,-0.2,"Q    (t)")
text(0.9,-0.25,"last")
text(2.5,-0.2,"t")
text(6,-0.2,"W(t)")
text(9.0,-0.2,"Q    (t)")
text(9.0,-0.25,"next")

# show lengths of intervals
arrows(3,0.5,1,0.5)
arrows(7,0.5,9,0.5)
text(5,0.5,"full life, current bulb")
arrows(7,0.25,6,0.25)
arrows(8,0.25,9,0.25)
text(7.5,0.25,"w")

dev.print(device=pdf,"ResidLife.pdf")

