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
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(cex=0.8)
par(mfrow=c(2,2))
#1st plot
plot(data$Datetime,as.numeric(as.character(data$Global_active_power)),pch=20,cex=0.1,xlab="",
     ylab="Global Active Power", type="l",lwd=1)
#2nd plot
plot(data$Datetime,as.numeric(as.character(data$Voltage)), xlab="datetime",ylab="Voltage",type="l")

#3rd plot
with(data, {
  plot(Datetime,as.numeric(as.character(Sub_metering_1)), type="l",
       ylab="Energy sub metering", xlab="")
  lines(Datetime, as.numeric(as.character(Sub_metering_2)),col='Red')
  lines(Datetime, as.numeric(as.character(Sub_metering_3)),col='Blue')
})

legend("topright", bty="n", c("Sub_metering_1","Sub_metering_2","Sub_metering_3") ,lwd=c(1,1,1), col=c("black","red","blue"))

#4th plot
plot(data$Datetime,as.numeric(as.character(data$Global_reactive_power)), ylab="Global_reactive_power", xlab="datetime",type="l")


dev.off()