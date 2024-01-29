# Indices derived from RS imagery

library(imageRy) # beloved package developed at unibo
library(terra)
library(ggplot2)
library(viridis)

im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

sunc <- im.classify(sun)

plotRGB(sun, 1, 2, 3)
plot(sunc)

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# layer 1: NIR
# layer 2: red
# layer 3: green

im.plotRGB(m1992, 2, 3, 1) # to visualize the blue parts
im.plotRGB(m1992, 1, 2, 3) # to visualize the red parts
im.plotRGB(m1992, 2, 1, 3) # to visualize the green parts

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, 2, 3, 1)

# to create a multiframe
par(mfrow=c(1, 2))
im.plotRGB(m1992, 2, 3, 1)
im.plotRGB(m2006, 2, 3, 1)

plot(m1992[[1]])

dvi1992 = m1992[[1]] - m1992[[2]]
plot (dvi1992)

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot (dvi1992, col=cl)

dvi2006 = m2006[[1]] - m2006[[2]]
plot (dvi2006)

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot (dvi2006, col=cl)

par(mfrow=c(1, 2))
plot (dvi1992, col=cl)
plot (dvi2006, col=cl)

ndvi1992 =  (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
plot (ndvi1992, col=cl)

ndvi2006 = (m2006[[1]] - m2006[[2]]) / (m2006[[1]] + m2006[[2]])
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
plot (ndvi2006, col=cl)

dev.off()
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

dev.off()
clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme that anyone can see
plot(ndvi2006, col=clvir)
plot(ndvi1992, col=clvir)

dev.off()
par(mfrow=c(1,2))
plot(ndvi1992, col=clvir)

# Classifying satellite images and estimate the amount of change

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

im.list()

# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6
# additional images: https://webbtelescope.org/contents/media/videos/1102-Video?Tag=Nebulas&page=1

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

sunc <- im.classify(sun, num_clusters=3)

# classify satellite data

im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
  
m1992c <- im.classify(m1992, num_clusters=2)                    
plot(m1992c)
# classes: forest=1; human=2

m2006c <- im.classify(m2006, num_clusters=2)
plot(m2006c)
# classes: forest=1; human=2

par(mfrow=c(1,2))
plot(m1992c[[1]])
plot(m2006c[[1]])

f1992 <- freq(m1992c)
f1992
tot1992 <- ncell(m1992c)
# percentage
p1992 <- f1992 * 100 / tot1992 
p1992
# forest: 83%; human: 17%

# percentage of 2006
f2006 <- freq(m2006c)
f2006
tot2006 <- ncell(m2006c)
# percentage
p2006 <- f2006 * 100 / tot2006 
p2006
# forest: 45%; human: 55%

# building the final table
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55) 

tabout <- data.frame(class, y1992, y2006)
tabout

# final output
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

# final output, rescaled
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=y2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
