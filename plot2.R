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
# The second graph

# Global Active Power
global <- reqDataset[,3]
global <- as.numeric(paste(global))
voltage <- as.numeric(paste(reqDataset[,5]))

#x-axis
x <- seq(from = 1, to = 2880, by = 1)

#Write to PNG
png(filename = "plot2.png")
plot(global ~ x, type = "l", axes = F, xlab = "", ylab = "Global Active Power (kilowatts)", main = "")
axis(side = 1, at = c(0,1440,2880), labels = c("Thu","Fri","Sat"))
axis(side = 2, at = c(0,2,4,6,8))
box()

dev.off()





