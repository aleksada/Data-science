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
png(filename = "plot3.png", width = 480, height = 480, units = "px")
par(cex=0.8)
with(data, {
  plot(Datetime,as.numeric(as.character(Sub_metering_1)), type="l",
       ylab="Energy Sub metering", xlab="")
  lines(Datetime, as.numeric(as.character(Sub_metering_2)),col='Red')
  lines(Datetime, as.numeric(as.character(Sub_metering_3)),col='Blue')
})

legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,lwd=c(1,1,1), col=c("black","red","blue"))


#save to file
#dev.copy(png, file="plot3.png", height=480, width=480, units='px')
dev.off()