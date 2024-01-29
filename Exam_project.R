# Exam project: Amazon deforestation

# Analysis of the Amazon vegetation cover as a result of deforestation.
# This project aims to study the decrease in vegetation cover in the Amazon rainforest 
# caused by deforestation between 2000 and 2012

# The images used for this project were downloaded from the NASA website 
# (https://earthobservatory.nasa.gov/world-of-change/Deforestation)

# Recall all the packages needed for this study
library(raster)
library(ggplot2)
library(RStoolbox)
library(viridis)
library(patchwork)

# Set the work directory to import the images needed
setwd("C:/Users/irene/Desktop")

# Use the brick() function of the raster package to display the images
amazon2000 <- brick("Amazon2000.jpg")
amazon2012 <- brick("Amazon2012.jpg")

# Use the function par() to arrange the two graphs in a 2x1 grid (i.e., one below the other)
par(mfrow=c(2,1))
plotRGB(amazon2000, r=1, g=2, b=3)
plotRGB(amazon2012, r=1, g=2, b=3)

# Clean the graphic visualization with the dev.off() function
dev.off()

# Calculate the Amazon Difference Vegetation Index (DVI) of 2000
dvi2000 = amazon2000[[1]] - amazon2000[[2]]
plot(dvi2000)

# To effectively visualize raster data use the colourRampPalette() function to define new image colours
cl <- colorRampPalette(c("darkblue", "white", "red", "black"))(100)
plot (dvi2000, col=cl)

# DVI of 2012 
dvi2012 = amazon2012[[1]] - amazon2012[[2]]
plot(dvi2012)

# DVI is defined as the difference between the reflectance value in two bands of
# the electromagnetic spectrum (typically, near-infrared (NIR) and red (R) bands).
# The DVI index can be useful for detecting the presence and density of vegetation.

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

# NDVI of 2012
ndvi2012 = (amazon2012[[1]] - amazon2012[[2]]) / (amazon2012[[1]] + amazon2012[[2]])
ndvi2012 = dvi2012 / (amazon2012[[1]] + amazon2012[[2]])
plot (ndvi2012, col=cl)

# NDVI is a normalized index that provides standardized values that can be
# more easily interpreted and compared between different images or areas.

# Compare the two graphs 
par(mfrow=c(1,2))
plot(ndvi2000, col=cl)
plot(ndvi2012, col=cl)

dev.off()

# Make it colorblind approved!
viridis <- colorRampPalette(viridis(7))(255)
plot(ndvi2000, col=viridis)
plot(ndvi2012, col=viridis)

par(mfrow=c(1,2))
plot(ndvi2000, col=viridis)
plot(ndvi2012, col=viridis)

dev.off()

# Multi-temporal change detection in vegetation cover between 2000 and 2012
amazondif = amazon2000[[1]] - amazon2012[[1]]

# Multi-temporal change detection involves the analysis of raster images acquired at different time periods
# to identify and quantify changes in land use, vegetation cover, or other environmental phenomena over time.

cl <- colorRampPalette(c("brown", "white", "orange")) (100)
plot(amazondif, col=cl)

dev.off()

