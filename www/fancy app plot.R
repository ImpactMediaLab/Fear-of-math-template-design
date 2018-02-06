require(png)
img<-readPNG("~/Desktop/Spectrum_background-01.png")
#now open a plot window with coordinates
plot(1:10,ty="n", bty='n', xaxt="n", yaxt="n", xlab="", ylab="", ylim=c(0,10))
#specify the position of the image through bottom-left and top-right coords
rasterImage(img,1,1,10,10)

n_points <- 47
point_seq <- matrix(NA,  n_points, 3, byrow=TRUE)
point_seq[,1] <- seq(1, n_points, 1)
point_seq[,2] <- seq(2,9, length.out= n_points)
point_seq[,3] <- seq(2,9, length.out= n_points)

dat <- read.csv("~/Desktop/Default Dataset.csv", as.is=TRUE)
point_seq[,2] <- dat[,1]
point_seq[,3] <- dat[,2]

points(point_seq[,2], point_seq[,3]+3, col="white", pch=20, cex=2)
points(2,5,col="white", pch=10)