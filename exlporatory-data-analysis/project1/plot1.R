#read data from file
dataset <- read.csv('./data/household_power_consumption.txt', header=TRUE, sep=';')

#convert date
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")

#select data between "2007-02-01" and "2007-02-02"
data <- subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

x <- as.matrix(data$Global_active_power)
x <- as.numeric(x)

#plot data
png(filename = "plot1.png", width = 480, height = 480, units = "px")

par(cex=0.8)
hist(x,main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")

dev.off()