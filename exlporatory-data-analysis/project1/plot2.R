#read data from file
dataset <- read.csv('./data/household_power_consumption.txt', header=TRUE, sep=';')

#convert date
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")

#select data between "2007-02-01" and "2007-02-02"
data <- subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

#add datetime column
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

#plot data
png(filename = "plot2.png", width = 480, height = 480, units = "px")

par(cex=0.8)
plot(data$Datetime, as.numeric(as.character(data$Global_active_power)), type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

dev.off()