# measurement of RS based variability

library(imageRy)
library(terra)
library(viridis)

im.list()

sent <- im.import("sentinel.png")

# band 1 = NIR
# band 2 = red
# band 3 = green

im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)

nir <- sent[[1]]
plot(nir)

# moving window
# focal
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

viridisc <- colorRampPalette(viridis(7))(255)
plot(sd3, col=viridisc)

# Exercise: calculate variability in a 7x7 pixels moving window
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# Exercise 2: plot via par(mfrow()) the 3x3 and the 7x7 standard deviation
par(mfrow=c(1,2))
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)

# original image plus the 7x7 sd
im.plotRGB(sent, r=2, g=1, b=3)
plot(sd7, col=viridisc)

im.list()
sent <- im.import("sentinel.png")
pairs(sent)

dev.off()

sentpc <- im.pca2 (sent)
pc1 <- sentpc$PC1

plot(pc1, col=viridisc)

pc1sd3 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd3, col=viridisc)

pc1sd7 <- focal(pc1, matrix(1/9, 3, 3), fun=sd)
plot(pc1sd7, col=viridisc)

par(mfrow=c(2, 3)) # 2 rows, 3 columns
im.plotRGB(sent, 2, 1, 3)
plot(sd3, col=viridisc)
plot(sd7, col=viridisc)
plot(pc1, col=viridisc)
plot(pc1sd3, col=viridisc)
plot(pc1sd7, col=viridisc)

sdstack <- c(sd3, sd7, pc1sd3, pc1sd7)
plot(sdstack, col=viridisc)

names(sdstack) <- c("sd3", "sd7", "pc1sd3", "pc1sd7")
plot(sdstack, col=viridisc)
# standard deviation represents the variability among the moving windows
