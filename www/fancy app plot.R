require(png)
img<-readPNG("Spectrum_background.png")

par(mar=c(0,0,0,0))
#now open a plot window with coordinates
plot(1:10,ty="n", bty='n', xaxt="n", yaxt="n", xlab="", ylab="", ylim=c(0,10))
#specify the position of the image through bottom-left and top-right coords

#xleft, ybottom, xright, ytop
rasterImage(img,0.55,1.5,10.45,10)

dat <- read.csv("Default Dataset.csv", as.is=TRUE, header=F)
points(dat[,1], dat[,2], col="white", pch=20, cex=3)

#dev.copy(png,'fancy_plot.png')
#dev.off()
