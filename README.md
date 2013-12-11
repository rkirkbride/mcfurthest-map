mcfurthest-map
==============

Generates a map in R showing geographical distance from a set of geographic points. The "McFurthest" distance.

Written in R, it will read in a tab-delimited file of coordinates and use ggplots2 to draw a colorized map of the US based on great circle distance from the nearest geographic coordinates. In this case, used to draw maps showing distances from the nearest National League (NL) or American League (AL) MLB ballpark.

Note the map projection is a basic latlong projection, and thus distorts east/west distances. The heatmap however is based on great circle distances and should be accurate.

Eventually I'd like to move to a better projection, but am unsure on how I would then draw the heatmap grid.
