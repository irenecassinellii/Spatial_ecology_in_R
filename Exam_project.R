## Exam project: Amazon deforestation

## Temporal analysis of the Amazon vegetation cover as a result of deforestation.
## This project aims to study the decrease in vegetation cover in the Amazon rainforest 
## caused by deforestation between 2000 and 2012

## The images used for the analysis are taken from MODIS (Moderate Resolution Imaging Spectroradiometer) 
## on NASA’s Terra satellite (https://earthobservatory.nasa.gov/world-of-change/Deforestation).

# Download the packages needed for the study
install.packages("raster")
install.packages("RStoolbox")
install.packages("ggplot2")
install.packages("patchwork")
install.packages("viridis")

# and recall them
library(raster) #
library(RStoolbox) #
library(ggplot2) #
library(patchwork) #
library(viridis) #

# Set the work directory to import the images needed
setwd("C:/Users/irene/Desktop")

# Use the brick() function of the raster package to display the images
amazon2000 <- brick("Amazon2000.jpg")
amazon2012 <- brick("Amazon2012.jpg")

# Use the function par() to arrange the two graphs in a 2x1 grid (i.e., one below the other)
# and create a multi-frame with 2000 and 2012 Amazon images with plotRGB() function
par(mfrow=c(2,1))
plotRGB(amazon2000, r=1, g=2, b=3)
plotRGB(amazon2012, r=1, g=2, b=3)

## Bands: 1 = Near-InfraRed (NIR), 2 = Red (R), 3 = Green (G)

# Clean the graphic visualization with the dev.off() function
dev.off()

# Calculate the Amazon Difference Vegetation Index (DVI) of 2000
dvi2000 = amazon2000[[1]] - amazon2000[[2]]
plot(dvi2000)

## DVI = NIR - R 

# To effectively visualize raster data use the colourRampPalette() function to define new image colours
cl <- colorRampPalette(c("darkblue", "white", "red", "black"))(100)
plot (dvi2000, col=cl)

# Calculate the DVI of 2012 
dvi2012 = amazon2012[[1]] - amazon2012[[2]]
plot(dvi2012)

## DVI is defined as the difference between the reflectance value in two bands of
## the electromagnetic spectrum (typically, near-infrared (NIR) and red (R) bands).
## The DVI index can be useful for detecting the presence and density of vegetation.

cl <- colorRampPalette(c("darkblue", "white", "red", "black"))(100)
plot (dvi2012, col=cl)

# Visualize the two graphs in a 2x1 grid and compare them
par(mfrow=c(1, 2))
plot (dvi2000, col=cl)
plot (dvi2012, col=cl)

# Clean the current graphic visualization
dev.off()

# Calculate the Normalized Difference Vegetation Index (NDVI) of 2000
ndvi2000 =  (amazon2000[[1]] - amazon2000[[2]]) / (amazon2000[[1]] + amazon2000[[2]])
ndvi2000 = dvi2000 / (amazon2000[[1]] + amazon2000[[2]])
plot (ndvi2000, col=cl)

# Calculate the NDVI of 2012
ndvi2012 = (amazon2012[[1]] - amazon2012[[2]]) / (amazon2012[[1]] + amazon2012[[2]])
ndvi2012 = dvi2012 / (amazon2012[[1]] + amazon2012[[2]])
plot (ndvi2012, col=cl)

## NDVI is a normalized index that provides standardized values that can be
## more easily interpreted and compared between different images or areas.

# Now plot and compare the two graphs
par(mfrow=c(1,2))
plot(ndvi2000, col=cl)
plot(ndvi2012, col=cl)

dev.off()

# Make it colorblind approved
viridis <- colorRampPalette(viridis(7))(255)
plot(ndvi2000, col=viridis)
plot(ndvi2012, col=viridis)

# and plot the two graphs together, creating a multi-frame
par(mfrow=c(1,2))
plot(ndvi2000, col=viridis)
plot(ndvi2012, col=viridis)

dev.off()

# Calculate the multi-temporal change detection in vegetation cover between 2000 and 2012
amazondif = amazon2000[[1]] - amazon2012[[1]]

## Multi-temporal change detection involves the analysis of raster images acquired at different time periods
## to identify and quantify changes in land use, vegetation cover, or other environmental phenomena over time.

# Specify a color scheme and plot the resulting image 
cl2 <- colorRampPalette(c("brown", "white", "orange")) (100)
plot(amazondif, col=cl2)

dev.off()

## Calculate vegetation indices from remote sensing (RS) data

# Recall the Rstoolbox package 
library(RStoolbox)

# Use the unsuperClass() function for the unsupervised classification of 2000 data
# and specify the number of classes (class 1 = forest, class 2 = human impact)
d1c <- unsuperClass(amazon2000, nClasses=2)
plot(d1c$map)

# To analyze the distribution of values within the raster image use the freq() function
freq(d1c$map)

#  layer value   count
# 1     1     1  468953
# 2     1     2 1771047

## Class 1: human impact = 468953
## Class 2: forest = 1771047

# Forest component of 2000
f2000 <- 1771047 / (1771047 + 468953) # or f2000 <- d1c$map[[2]] / (d1c$map[[2]] + d1c$map[[1]]) 
f2000
p2000 <- f200 * 100

## f2000 = 0,790646 = 79,06%

# Human component of 2000
h2000 <- 468953 / (1771047 + 468953) # or f2000 <- d1c$map[[1]] / (d1c$map[[2]] + d1c$map[[1]]) 
h2000
p2012 <- h2000 * 100

## h2000 = 0,209354 = 20,94%

# Now compute the same classification for 2012 data
d2c <- unsuperClass(amazon2012, nClasses=2)
plot(d2c$map)

freq(d2c$map)

#  layer value   count
# 1     1     1  636865
# 2     1     2 1603135

## Class 1: forest = 636865
## Class 2: human impact = 1603135

# Forest component of 2012
f2012 <- 636865 / (1603135 + 636865) # or f2012 <- d2c$map[[1]] / (d2c$map[[2]] + d2c$map[[1]]) 
f2012

## f2012 =  0,2843147 = 28,43%

# Human component of 2012
h2012 <- 1603135 / (1603135 + 636865)
h2012

## h2012 = 0,7156853 = 71,57%

# Create the final table to assess the changes in land use and cover with the data.frame() function
landcover <- c("Forest", "Humans")
percent_2000 <- c(79.06, 20.94)
percent_2012 <- c(28.43, 71.57)

percentage <- data.frame(landcover, percent_2000, percent_2012)
percentage

#     landcover percent_2000 percent_2012
# 1    Forest        79.06        28.43
# 2    Humans        20.94        71.57

# Recall the ggplot2 package 
library(ggplot2)

# and plot data within a histogram 
ggplot(percentage, aes(x=landcover, y=percent_2000, color=landcover)) + geom_bar(stat="identity", fill="white")
ggplot(percentage, aes(x=landcover, y=percent_2012, color=landcover)) + geom_bar(stat="identity", fill="white")

# Recall the package called patchwork
library(patchwork)

# Assign the two plots to an object 
p1 <- ggplot(percentage, aes(x=landcover, y=percent_2000, color=landcover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentage, aes(x=landcover, y=percent_2012, color=landcover)) + geom_bar(stat="identity", fill="white")

# Plot the two histograms and compare them 
p1 + p2

dev.off()

####################################################################################################################

plotRGB(amazon2000, r=1, g=2, b=3)
nir <- amazon2000[[1]]
plot(nir)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

viridisc <- colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)

sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)

plotRGB(amazon2012, r=1, g=2, b=3)
nir <- amazon2012[[1]]
plot(nir)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

viridisc <- colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)

sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
