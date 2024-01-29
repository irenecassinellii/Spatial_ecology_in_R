# Code reated to population ecology

# a package is needed for point pattern analyses 
install.packages ("spatstat") # to install packages external from R, "" are needed when typing something external from R
library (spatstat) # to check if the package has been installed and to use it

# let's use bei data
# data description:
# HTTP://CRAN.R-project.org

bei

# to plot bei data
plot (bei)

# to change character dimensions
plot (bei, cex=0.5)

# to change symbol 
plot (bei, cex = 0.4, pch = 19)

# additional dataset
bei.extra
plot (bei.extra)

# let's use only a part of the dataset: elevation
plot (bei.extra$elev)

# to assign bei.extra$elev to a new object
elevation <- bei.extra$elev
plot (elevation)

# second method to select elements
elevation2 <- bei.extra[[1]]
plot (elevation2)

# passing from points to a continuous surface
densitymap <- density(bei)
densitymap
plot (densitymap)

# to put points on the image
points (bei, cex=0.2)

# to change the color palette 
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot (densitymap, col=cl)

# to visualize only 4 colors
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(4)
plot (densitymap, col=cl)

# multiframe
plot (bei.extra)
elevation <- bei.extra[[1]]
plot (elevation)
par(mfrow=c(1,2))
plot(densitymap)
plot(elevation)
