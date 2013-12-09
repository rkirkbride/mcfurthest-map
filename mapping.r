library("ggplot2")
library("maps")
library("fields")
setwd("~/Desktop")

#Load the coordinates file
coords <- read.table("coords.txt",
                     row.names=2,
                     header=TRUE,
                     sep="\t")

#Establish the size and resolution of the  grid to be displayed.
lat <- seq(25,50,by=.1)
lon <- seq(-125,-65,by=.1)
overlay <- expand.grid(lat,lon)

#Get the coordinates for the NL and AL stadiums
nl.coords <- coords[coords$league=="N",3:4]
al.coords <- coords[coords$league=="A",3:4]


distmat <- NULL

for(i in row.names(nl.coords))
{foo <-rdist.earth(overlay[,2:1],coords[i,4:3],miles=TRUE)
distmat <- cbind(distmat,foo)}
dist.nearest <- apply(distmat,1,min)
plotme <- cbind(overlay[,2:1],dist.nearest)

 
austin <-as.data.frame(cbind(-97.73717,30.29117)) 
  

theme_set(theme_grey(base_size = 22)) 
p=ggplot(overlay,aes(x=overlay$Var2,y=overlay$Var1), colour="Green")
#p + geom_tile(aes(fill=mindist)) + scale_fill_gradient(low="red",high="white")
usmap=map_data('state')

png(file='National_Leauge.png',width = 1600, height = 1000)
p + 
  geom_tile(aes(fill=plotme$dist.nearest)) + 
  scale_fill_gradient2(limits=c(0,800),midpoint=500,low="yellow",mid="red",high="blue",na.value="blue",name="Distance from\nNational Leauge\n(miles)\n") + 
  geom_path(data=usmap,aes(x=usmap$long,y=usmap$lat,group=usmap$group,col="2"),colour = "Grey") +
  geom_point(data = austin, aes(x=austin$V1, y=austin$V2)) + 
  coord_equal() +
  xlab("Longitude") +
  ylab("Latitude")
dev.off()


distmat <- NULL
for(i in row.names(al.coords))
{foo <-rdist.earth(overlay[,2:1],coords[i,4:3],miles=TRUE)
 distmat <- cbind(distmat,foo)}
dist.nearest <- apply(distmat,1,min)
plotme <- cbind(overlay[,2:1],dist.nearest)


austin <-as.data.frame(cbind(-97.73717,30.29117)) 


theme_set(theme_grey(base_size = 22)) 
p=ggplot(overlay,aes(x=overlay$Var2,y=overlay$Var1), colour="Green")
#p + geom_tile(aes(fill=mindist)) + scale_fill_gradient(low="red",high="white")
usmap=map_data('state')

png(file='American_Leauge.png',width = 1600, height = 1000)
p + 
  geom_tile(aes(fill=plotme$dist.nearest)) + 
  scale_fill_gradient2(limits=c(0,800),midpoint=500,low="yellow",mid="red",high="blue",na.value="blue",name="Distance from\nAmerican Leauge\n(miles)\n") + 
  geom_path(data=usmap,aes(x=usmap$long,y=usmap$lat,group=usmap$group,col="2"),colour = "Grey") +
  geom_point(data = austin, aes(x=austin$V1, y=austin$V2)) + 
  coord_equal() +
  xlab("Longitude") +
  ylab("Latitude")
dev.off()












