## Exam project: Amazon deforestation

## Spatio-temporal analysis of the Amazon land cover between 2001 and 2012.

## This project aims to assess the decrease in the Amazon forest cover
## between 2001 and 2012 caused by deforestation and other human activities.

## The images used for the analysis are taken from MODIS (Moderate Resolution Imaging Spectroradiometer) 
## on NASA’s Terra satellite (https://earthobservatory.nasa.gov/world-of-change/Deforestation).


## Let's start!

# Download the packages needed
install.packages("raster")
install.packages("RStoolbox")
install.packages("ggplot2")
install.packages("patchwork")
install.packages("viridis")
install.packages("magick")

# and then load them
library(raster)
library(RStoolbox)
library(ggplot2)
library(patchwork)
library(viridis)
library(magick)

# Set the working directory to import the images needed
setwd("C:/Users/irene/Desktop/Esame R")

# Use the brick() function to display multi-layer raster objects
og_amazon2001 <- brick("Amazon2001.jpg")
og_amazon2012 <- brick("Amazon2012.jpg")

# Crop the original images with the functions of the magick package
og_amazon2001 <- image_read("Amazon2001.jpg")
amazon2001_cropped <- image_crop(og_amazon2001, geometry="2500x2000+500+500")
image_write(amazon2001_cropped, path="amazon2001_cropped.jpg")

og_amazon2012 <- image_read("Amazon2012.jpg")
amazon2012_cropped <- image_crop(og_amazon2012, geometry="2500x2000+500+500")
image_write(amazon2012_cropped, path="amazon2012_cropped.jpg")

# and display the new cropped images with the brick() function
amazon2001 <- brick("amazon2001_cropped.jpg")
amazon2012 <- brick("amazon2012_cropped.jpg")

# Use par() to arrange the images in a 2x1 grid (i.e., one below the other)
# and create a multi-frame with the plotRGB() function of the raster package
par(mfrow=c(2, 1))
plotRGB(amazon2001, r=1, g=2, b=3) # multi-bands color images
plotRGB(amazon2012, r=1, g=2, b=3)

## Bands: 1 = Red (R), 2 = Near-infrared (NIR), 3 = Green (G)

# Save the two images with the jpeg() function 
jpeg("amazon2001RGB.jpg")
plotRGB(amazon2001, r=1, g=2, b=3)
dev.off()

jpeg("amazon2012RGB.jpg")
plotRGB(amazon2012, r=1, g=2, b=3)
dev.off()

# Clean the current graphic visualization
dev.off()


## Vegetation indices

# Calculate the Difference Vegetation Index (DVI) of 2001
dvi2001 = amazon2001[[2]] - amazon2001[[1]]
plot(dvi2001)

## DVI = NIR - R 
## DVI is defined as the difference between the reflectance value in two bands of
## the electromagnetic spectrum (typically, near-infrared (NIR) and red (R) bands).
## The DVI index can be useful for detecting the presence and density of vegetation.

# To effectively visualize raster data set a new color palette with colorRampPalette()
cl <- colorRampPalette(c("black", "red", "white", "darkblue"))(100)
plot(dvi2001, col=cl)

# Calculate the DVI of 2012 and plot it using the same color palette 
dvi2012 = amazon2012[[2]] - amazon2012[[1]]
plot(dvi2012)
plot(dvi2012, col=cl)

# Visualize the two graphs in a 2x1 grid and compare the results
# by setting the same resolution scale with the zlim() function
par(mfrow=c(1, 2))
plot(dvi2001, col=cl, zlim=c(-100, 50))
plot(dvi2012, col=cl, zlim=c(-100, 50))

# and make it colorblind approved using the viridis package (option inferno)
par(mfrow=c(1, 2))
viridis <- colorRampPalette(viridis(7))(255)
plot(dvi2001, col=viridis(255, option="inferno"), zlim=c(-100, 50))
plot(dvi2012, col=viridis(255, option="inferno"), zlim=c(-100, 50))

# Save the image with the png() function (better resolution compared to jpg)
png("amazonDVI.png")
par(mfrow=c(1, 2))
plot(dvi2001, col=viridis(255, option="inferno"), zlim=c(-100, 50))
plot(dvi2012, col=viridis(255, option="inferno"), zlim=c(-100, 50))
dev.off()

# Clean the current graphic visualization
dev.off()

# Calculate the Normalized Difference Vegetation Index (NDVI) of 2001
ndvi2001 = dvi2001 / (amazon2001[[2]] + amazon2001[[1]])
plot(ndvi2001, col=cl)

## NDVI is a normalized index that provides standardized values that can be more easily 
## interpreted and compared between different images or areas. NDVI values range 
## from -1 to +1, with higher values indicating a higher density of green vegetation.

# Calculate the NDVI of 2012
ndvi2012 = dvi2012 / (amazon2012[[2]] + amazon2012[[1]])
plot(ndvi2012, col=cl)

# Now plot and compare the two graphs by setting the same resolution scale
par(mfrow=c(1, 2))
plot(ndvi2001, col=cl, zlim=c(-1, 0.5))
plot(ndvi2012, col=cl, zlim=c(-1, 0.5))

# and make it colorblind approved with the viridis package (option inferno)
par(mfrow=c(1, 2))
plot(ndvi2001, col=viridis(255, option="inferno"), zlim=c(-1, 0.5))
plot(ndvi2012, col=viridis(255, option="inferno"), zlim=c(-1, 0.5))

# Save the image with the png() function
png("amazonNDVI.png")
par(mfrow=c(1, 2))
plot(ndvi2001, col=viridis(255, option="inferno"), zlim=c(-1, 0.5))
plot(ndvi2012, col=viridis(255, option="inferno"), zlim=c(-1, 0.5))
dev.off()

dev.off()

# Calculate the multi-temporal change detection in vegetation cover between 2001 and 2012
amazondif = amazon2001[[1]] - amazon2012[[1]]

## Spatio-temporal change detection involves the analysis of raster images acquired at different periods
## to identify and quantify changes in land use, vegetation cover, or other environmental phenomena over time.

# Specify a color scheme and plot the resulting image 
cl2 <- colorRampPalette(c("black", "brown", "white", "orange"))(100)
plot(amazondif, col=cl2)

# Save the image with the png() function
png("amazonDIF.png")
plot(amazondif, col=cl2)
dev.off()
 
## Darker areas indicate the biggest vegetation losses — usually the complete clearing 
## of the original rainforest, while lighter areas showed little or no change.

dev.off()


## Classification

# Use the unsuperClass() function for the unsupervised classification of 2001 data
# and specify the number of classes (class 1 = forest, class 2 = humans)
d1c <- unsuperClass(amazon2001, nClasses=2)
plot(d1c$map)

# To analyze the distribution of values within the raster image use the freq() function
val2001 <- freq(d1c$map)
val2001

#   layer value   count
# 1     1     1 1378305
# 2     1     2 3621695

## Class 1: humans = 1378305
## Class 2: forest = 3621695

# Forest component of 2001
f2001 <- val2001[2, 3] / (val2001[2, 3] + val2001[1, 3])
f2001

## f2001 = 0.724339

# Compute the forest percentage of 2001
percent_f2001 <- f2001 * 100
percent_f2001

## percent_f2001 = 72.43

# Human component of 2001
h2001 <- val2001[1, 3] / (val2001[2, 3] + val2001[1, 3])
h2001

## h2001 = 0.275661

# Human percentage of 2001
percent_h2001 <- h2001 * 100
percent_h2001

## percent_h2001 = 27.57

# Now compute the same classification for 2012 data
d2c <- unsuperClass(amazon2012, nClasses=2)
plot(d2c$map)

val2012 <- freq(d2c$map)
val2012

#   layer value   count
# 1     1     1 1499729
# 2     1     2 3500271

## Class 1: humans = 1499729
## Class 2: forest = 3500271

# Forest component of 2012
f2012 <- val2012[2, 3] / (val2012[2, 3] + val2012[1, 3])
f2012

## f2012 = 0.7000542

# Forest percentage of 2012
percent_f2012 <- f2012 * 100
percent_f2012

## percent_f2012 = 70.00

# Human component of 2012
h2012 <- val2012[1, 3] / (val2012[2, 3] + val2012[1, 3])
h2012

## h2012 = 0.2999458

# Human percentage of 2012
percent_h2012 <- h2012 * 100
percent_h2012

## percent_h2012 = 30.00

# Plot the two images together 
par(mfrow=c(1, 2))
plot(d1c$map)
plot(d2c$map)

# Create the final table to assess land use and cover changes with the data.frame() function
landcover <- c("Forest", "Humans")
percent_2001 <- c(percent_f2001, percent_h2001)
percent_2012 <- c(percent_f2012, percent_h2012)
percentage <- data.frame(landcover, percent_2001, percent_2012)
percentage

#   landcover percent_2001 percent_2012
# 1    Forest      72.4339     70.00542
# 2    Humans      27.5661     29.99458

# Plot data within a histogram with the ggplot() function of the ggplot2 package
ggplot(percentage, aes(x=landcover, y=percent_2001, color=landcover)) + geom_bar(stat="identity", fill="white")
ggplot(percentage, aes(x=landcover, y=percent_2012, color=landcover)) + geom_bar(stat="identity", fill="white")

# Assign the two plots to the objects p1 and p2 
p1 <- ggplot(percentage, aes(x=landcover, y=percent_2001, color=landcover)) + geom_bar(stat="identity", fill="white") + ylim(c(0, 100))
p2 <- ggplot(percentage, aes(x=landcover, y=percent_2012, color=landcover)) + geom_bar(stat="identity", fill="white") + ylim(c(0, 100))

## I use the ylim() function to set the same scale

# Plot the two histograms together and compare them 
p1 + p2

# Save the final image
png("histograms.png")
p1 + p2
dev.off()

# Finally, clean the graphic visualization
dev.off()

# The end :)
