library (imageRy)
library (terra)

im.list ()

b2 <- im.import ("sentinel.dolomites.b2.tif")
b3 <- im.import ("sentinel.dolomites.b3.tif")
b4 <- im.import ("sentinel.dolomites.b4.tif")
b8 <- im.import ("sentinel.dolomites.b8.tif")

stacksent <- c(b2, b3, b4, b8)
plot (stacksent)

dev.off ()
im.plotRGB (stacksent, r=3, g=2, b=1)
im.plotRGB (stacksent, r=4, g=3, b=2)
im.plotRGB (stacksent, r=3, g=4, b=2)
im.plotRGB (stacksent, r=3, g=2, b=4)

pairs (stacksent) #scatterplot matrix between variables 

dev.off()

# Vegetation indices

library(imageRy)
library(terra)

im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")   
# bands: 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m1992, r=2, g=3, b=1)

# import the recent image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)

# build a multiframe with 1992 and 2006 images
par(mfrow=c(1,2))
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)

# DVI = NIR - RED
# bands: 1=NIR, 2=RED, 3=GREEN

dvi1992 = m1992[[1]] - m1992[[2]]
plot(dvi1992)

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)

# exercise: calculate dvi of 2006
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col=cl)

# NDVI
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)

# NDVI
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

# par
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme
par(mfrow=c(1,2))
plot(ndvi1992, col=clvir)
plot(ndvi2006, col=clvir)

# speediing up calculation
ndvi2006a <- im.ndvi(m2006, 1, 2)
plot(ndvi2006a, col=cl)
