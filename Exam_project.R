## Exam project: Amazon deforestation

## Temporal analysis of the Amazon vegetation cover as a result of deforestation.
## This project aims to study the decrease in vegetation cover in the Amazon rainforest 
## caused by deforestation between 2001 and 2012

## The images used for the analysis are taken from MODIS (Moderate Resolution Imaging Spectroradiometer) 
## on NASA’s Terra satellite (https://earthobservatory.nasa.gov/world-of-change/Deforestation).

# Download the packages needed for the study
install.packages("raster")
install.packages("RStoolbox")
install.packages("ggplot2")
install.packages("patchwork")
install.packages("viridis")
install.packages("magick")

# and recall them
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)
library(magick)

# Set the work directory to import the images needed
setwd("C:/Users/irene/Desktop")

# Use the brick() function of the raster package to display the images
og_amazon2001 <- brick("Amazon2001.jpg")
og_amazon2012 <- brick("Amazon2012.jpg")

# Crop the original images 
og_amazon2001 <- image_read("Amazon2001.jpg")
amazon2001_cropped <- image_crop(og_amazon2001, geometry="2500x2000+500+500")
image_write(amazon2001_cropped, path="amazon2001_cropped.jpg")

og_amazon2012 <- image_read("Amazon2012.jpg")
amazon2012_cropped <- image_crop(og_amazon2012, geometry="2500x2000+500+500")
image_write(amazon2012_cropped, path="amazon2012_cropped.jpg")

amazon2001 <- brick("amazon2001_cropped.jpg")
amazon2012 <- brick("amazon2012_cropped.jpg")

# Use the function par() to arrange the two graphs in a 2x1 grid (i.e., one below the other)
# and create a multi-frame with 2000 and 2012 Amazon images with plotRGB() function
par(mfrow=c(2,1))
plotRGB(amazon2001, r=1, g=2, b=3)
plotRGB(amazon2012, r=1, g=2, b=3)

## Bands: 1 = Near-InfraRed (NIR), 2 = Red (R), 3 = Green (G)

# Save the two images with the jpeg() function 
jpeg("amazon2001RGB.jpg")
plotRGB(amazon2001, r=1, g=2, b=3)
dev.off()

jpeg("amazon2012RGB.jpg")
plotRGB(amazon2012, r=1, g=2, b=3)
dev.off()

# Calculate the Amazon Difference Vegetation Index (DVI) of 2000
dvi2001 = amazon2001[[1]] - amazon2001[[2]]
plot(dvi2001)

## DVI = NIR - R 

# To effectively visualize raster data use the colourRampPalette() function to define new image colours
cl <- colorRampPalette(c("darkblue", "white", "red", "black"))(100)
plot (dvi2001, col=cl, zlim=c(-40, 80))

## zlim() function is used to define the scale of the graph

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
plot (dvi2001, col=cl, zlim=c(-40, 80))
plot (dvi2012, col=cl, zlim=c(-40, 80))

# Clean the current graphic visualization
dev.off()

# Calculate the Normalized Difference Vegetation Index (NDVI) of 2000
ndvi2001 =  (amazon2001[[1]] - amazon2001[[2]]) / (amazon2001[[1]] + amazon2001[[2]])
ndvi2001 = dvi2001 / (amazon2001[[1]] + amazon2001[[2]])
plot (ndvi2001, col=cl, zlim=c(-1, 1))

# Calculate the NDVI of 2012
ndvi2012 = (amazon2012[[1]] - amazon2012[[2]]) / (amazon2012[[1]] + amazon2012[[2]])
ndvi2012 = dvi2012 / (amazon2012[[1]] + amazon2012[[2]])
plot (ndvi2012, col=cl, zlim=c(-1, 1))

## NDVI is a normalized index that provides standardized values that can be
## more easily interpreted and compared between different images or areas.

# Now plot and compare the two graphs and make it colorblind approved
viridis <- colorRampPalette(viridis(7))(255)
par(mfrow=c(1,2))
plot(ndvi2001, col=viridis(2), zlim=c(-1, 1))
plot(ndvi2012, col=viridis(2), zlim=c(-1, 1))

dev.off()

# Calculate the multi-temporal change detection in vegetation cover between 2000 and 2012
amazondif = amazon2001[[1]] - amazon2012[[1]]

## Multi-temporal change detection involves the analysis of raster images acquired at different time periods
## to identify and quantify changes in land use, vegetation cover, or other environmental phenomena over time.

# Specify a color scheme and plot the resulting image 
cl2 <- colorRampPalette(c("brown", "white", "orange"))(100)
plot(amazondif, col=cl2)

dev.off()

## Calculate vegetation indices from remote sensing (RS) data

# Use the unsuperClass() function for the unsupervised classification of 2000 data
# and specify the number of classes (class 1 = forest, class 2 = human impact)
d1c <- unsuperClass(amazon2001, nClasses=2)
plot(d1c$map)

# To analyze the distribution of values within the raster image use the freq() function
val2001 <- freq(d1c$map)

#  layer value   count
# 1     1     1  468953
# 2     1     2 1771047

## Class 1: human impact = 468953
## Class 2: forest = 1771047

# Forest component of 2001
f2001 <- val2001[2,3] / (val2001[2,3] + val2001[1,3])
f2001

# Compute the forest percentage of 2001
percent_f2001 <- f2001 * 100
percent_f2001

## f2001 = 0,790646 = 79,06%

# Human component of 2001
h2001 <- val2001[1,3] / (val2001[2,3] + val2001[1,3])
h2001

# Human percentage of 2001
percent_h2001 <- h2001 * 100
percent_h2001

## h2001 = 0,209354 = 20,94%

# Now compute the same classification for 2012 data
d2c <- unsuperClass(amazon2012, nClasses=2)
plot(d2c$map)

val2012 <- freq(d2c$map)

#  layer value   count
# 1     1     1  636865
# 2     1     2 1603135

## Class 1: human impact = 636865
## Class 2: forest = 1603135

# Forest component of 2012
f2012 <- val2012[2,3] / (val2012[2,3] + val2012[1,3])
f2012

# Forest percentage of 2012
percent_f2012 <- f2012 * 100
percent_f2012

## f2012 =  0,2843147 = 28,43%

# Human component of 2012
h2012 <- val2012[1,3] / (val2012[2,3] + val2012[1,3])
h2012

# Human percentage of 2012
percent_h2012 <- h2012 * 100
percent_h2012

## h2012 = 0,7156853 = 71,57%

# Create the final table to assess land use and cover changes with the data.frame() function
landcover <- c("Forest", "Humans")
percent_2001 <- c(percent_f2001, percent_h2001)
percent_2012 <- c(percent_f2012, percent_h2012)
percentage <- data.frame(landcover, percent_2001, percent_2012)
percentage

#     landcover percent_2000 percent_2012
# 1    Forest        79.06        28.43
# 2    Humans        20.94        71.57

# Plot data within a histogram with the ggplot() function of the ggplot package
ggplot(percentage, aes(x=landcover, y=percent_2001, color=landcover)) + geom_bar(stat="identity", fill="white")
ggplot(percentage, aes(x=landcover, y=percent_2012, color=landcover)) + geom_bar(stat="identity", fill="white")

# Assign the two plots to the objects p1 and p2 
p1 <- ggplot(percentage, aes(x=landcover, y=percent_2001, color=landcover)) + geom_bar(stat="identity", fill="white") + coord_cartesian(ylim=c(0, 100))
p2 <- ggplot(percentage, aes(x=landcover, y=percent_2012, color=landcover)) + geom_bar(stat="identity", fill="white") + coord_cartesian(ylim=c(0, 100))

## I use the coord_cartesian() function to set the same scale

# Plot the two histograms and compare them 
p1 + p2

dev.off()
