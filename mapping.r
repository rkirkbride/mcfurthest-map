library("ggplot2")
library("maps")
library("fields")
setwd("~/Desktop")
#Load the coordinates file
coords <- read.table("coords.txt",
                     row.names=2,
                     header=TRUE,
                     sep="\t")

#Set the coordinates
lat <- seq(25,50,by=.1)
lon <- seq(-125,-65,by=.1)
overlay <- expand.grid(lat,lon)
nl.coords <- coords[coords$league=="N",3:4]
al.coords <- coords[coords$league=="A",3:4]


distmat <- NULL


for(i in row.names(coords))
{foo <-rdist.earth(overlay[,2:1],coords[i,4:3])
distmat <- cbind(distmat,foo)}
dist.nearest <- apply(distmat,1,min)
plotme <- cbind(overlay[,2:1],dist.nearest)

 
 
  


p=ggplot(overlay,aes(x=overlay$Var2,y=overlay$Var1), colour="Green")
#p + geom_tile(aes(fill=mindist)) + scale_fill_gradient(low="red",high="white")
usmap=map_data('state')

p + geom_tile(aes(fill=plotme$dist.nearest)) + scale_fill_gradient2(limits=c(0,800),midpoint=500,low="yellow",mid="red",high="blue",na.value="blue") + geom_path(data=usmap,aes(x=usmap$long,y=usmap$lat,group=usmap$group,col="2"),colour = "Grey")
