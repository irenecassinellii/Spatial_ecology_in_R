# to install the vegetation analysis package
install.packages ("vegan")
library (vegan)

# to load a specific dataset
data (dune)
dune

# to see only the initial part of the dataset
head (dune)

# to see the final parte of the dataset
tail (dune)

# detrented correspondence analysis (DCA): to find the main factors in huge data matrices, and to assign it to an object
ord <- decorana (dune)
ord

# to find the total axis lenght
ldc1 = 3.7004   
ldc2 = 3.1166
ldc3 = 1.30055
ldc4 = 1.47888
total = ldc1 + ldc2 + ldc3 + ldc4
total

# to find the percentage 
pldc1 = ldc1 * 100 / total
pldc2 = ldc2 * 100 / total
pldc3 = ldc3 * 100 / total
pldc4 = ldc4 * 100 / total
plcd1
plcd2
plc3
plcd4

#to visualize data in a graph
plot (ord)

install.package ("overlap")
library (overlap)

data (kerinci)
head (kerinci)
summary (kerinci) #general information about the dataset

# [] to select items inside the dataset and $ to link elements, in this case to select only the data on tiger individuals
tiger <- kerinci [kerinci$Sps=="tiger",] # !! important: close the query with ,
tiger

head (kerinci)

kerinci$Time * 2 * pi

# to add another column to the tiger dataset
kerinci$timeRad <- kerinci$Time * 2 * pi
tiger
head (tiger)

timetig <- tiger$timeRad

# densityPlot: to plot the amount of time in which you have seen a certain species, to see the picks of time
densityPlot (timetig, rug = TRUE)

# to select only the data on macaque individuals from kerinci
macaque <- kerinci [kerinci$Sps=="macaque",]
macaque

timemac <- macaque$timeRad

densityPlot (timemac, tug = TRUE)

# to overlap the two distributions
overlapPlot (timetig, timemac)
