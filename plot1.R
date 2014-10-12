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
# The first graph

globalactivepower <- reqDataset[,3]

# reset factor levels
globalactivepower <- factor(globalactivepower)

# convert factor to numeric values
global <- as.numeric(paste(globalactivepower))

#writes the png file
png(filename = "plot1.png")
hist(global, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()



