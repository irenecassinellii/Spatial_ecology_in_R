# Exam project: Amazon deforestation

# Analysis of the Amazon vegetation cover as a result of deforestation 
# This project aims to study the decrease in vegetation cover in the Amazon rainforest caused by deforestation between 2000 and 2012

# The images used for this project were downloaded from the NASA website (https://earthobservatory.nasa.gov/world-of-change/Deforestation)

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

# Use the function par() to arrange the three graphs in a 2x1 grid (i.e., one below the other)
par(mfrow=c(2,1))
plotRGB(amazon2000, r=1, g=2, b=3)
plotRGB(amazon2012, r=1, g=2, b=3)

# Multitemporal change detection
amazondif = amazon2000[[1]] - amazon2012[[1]]

cl <- colorRampPalette(c("brown", "grey", "orange")) (100)
plot(amazondif, col=cl)
