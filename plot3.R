#reading the selected rows

#find the column classes to make reading faster
tab5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5)
classes <- sapply(tab5rows, class)

#table of the first 130,000 rows
tabAll <- read.table("household_power_consumption.txt", sep = ";", nrows = 130000, header = TRUE, colClasses = classes)

#subsetting the two days needed
dates <- tabAll[,1]
dateschar <- as.character(dates)

day1posn <- grep("1/2/2007", dateschar)
day1posn <- day1posn[1:1440]

day2posn <- grep("2/2/2007", dateschar)
day2posn <- day2posn[1:1440]

#contains the row numbers of the days we need
days <- c(day1posn, day2posn)

#the required data set
reqDataset <- tabAll[days,]


#########################
#The third graph

#extract the three columns needed i.e. the sub-metering ones
sub1 <- reqDataset[,7]
sub2 <- reqDataset[,8]
sub3 <- reqDataset[,9]

# convert the factors into numeric values
sub1 <- as.numeric(paste(sub1))
sub2 <- as.numeric(paste(sub2))
sub3 <- as.numeric(paste(sub3))

# generate the x-axis
x <- seq(from = 1, to = 2880, by = 1)

#plot the graph
png(filename = "plot3.png")
plot(sub1 ~ x, type = "l", col ="black", axes = F, ylab = "Energy sub metering", xlab = "", ylim = c(0,40))
par(new=T)
plot(sub2 ~ x, type = "l", col ="red", axes = F, ylab = "Energy sub metering", xlab = "", ylim = c(0,40))
par(new=T)
plot(sub3 ~ x, type = "l", col ="blue", axes = F, ylab = "Energy sub metering", xlab = "", ylim = c(0,40))
axis(side=2, at= c(0,10,20,30))
axis(side =1, at = c(0,1440,2880), labels = c("Thu", "Fri", "Sat"))
box()
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty =1, col = c("black", "red","blue"))
dev.off()





