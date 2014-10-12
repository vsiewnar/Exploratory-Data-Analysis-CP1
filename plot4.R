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
#The fourth graph

#global info
x <- seq(from = 1, to = 2880, by = 1)

#Info for first graph
global <- reqDataset[,3]
global <- as.numeric(paste(global))

#Info for second graph
voltage <- as.numeric(paste(reqDataset[,5]))

#Info for third graph
#extract the three columns needed i.e. the sub-metering ones
sub1 <- reqDataset[,7]
sub2 <- reqDataset[,8]
sub3 <- reqDataset[,9]

# convert the factors into numeric values
sub1 <- as.numeric(paste(sub1))
sub2 <- as.numeric(paste(sub2))
sub3 <- as.numeric(paste(sub3))

#Info for fourth graph
globreact <- reqDataset[,4]
globreact <- as.numeric(paste(globreact))



#Write graph
png(filename = "plot4.png")
par(mfrow=c(2,2))

#top-left graph
plot(global ~ x, type = "l", axes = F, xlab = "", ylab = "Global Active Power (kilowatts)", main = "")
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
axis(side = 2, at = c(0,2,4,6,8))
box()

#top-right graph
plot(voltage ~ x, type = "l", ylab = "Voltage", xlab = "datetime", axes = F)
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
axis(side = 2, at = c(234,236,238,240,242,244,246), labels = c("234","","238","","242","","246"))
box()

#bottom-left graph
plot(sub1 ~ x, type = "l", col ="black", axes = F, ylab = "Energy sub metering", xlab = "", ylim = c(0,40))
par(new=T)
plot(sub2 ~ x, type = "l", col ="red", axes = F, ylab = "Energy sub metering", xlab = "", ylim = c(0,40))
par(new=T)
plot(sub3 ~ x, type = "l", col ="blue", axes = F, ylab = "Energy sub metering", xlab = "", ylim = c(0,40))
axis(side=2, at= c(0,10,20,30))
axis(side =1, at = c(0,1440,2880), labels = c("Thu", "Fri", "Sat"))
box()
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty =1, col = c("black", "red","blue"))

#bottom-right graph
plot(globreact ~ x, type = "l", ylab = "Global_reactive_power", xlab = "datetime", axes = F)
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
axis(side = 2, at = c(0.0,0.1,0.2,0.3,0.4,0.5))
box()

dev.off()
