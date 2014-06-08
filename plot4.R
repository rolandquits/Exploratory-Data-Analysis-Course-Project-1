#Downloads the file and unzips it

download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./files.zip")
unzip("./files.zip")

#Reads Table and filters the subset data

data <- read.table("./household_power_consumption.txt", sep=";", header=TRUE,na.strings="?")
data$Date = as.Date(data$"Date", "%d/%m/%Y")
subdata <- subset(data,data$"Date" %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))
Timestamp <- strptime(paste(subdata$"Date", subdata$"Time"), "%Y-%m-%d %H:%M:%S") 
subdata <- (data.frame(subdata,Timestamp))

#Plot 4

png(filename="./plot4.png")
attach(mtcars)
par(mfrow=c(2,2))

#Top-Left Plot
plot(y=subdata$"Global_active_power", x=subdata$"Timestamp", type="l", xlab="", ylab="Global Active Power")

#Top-Right Plot

plot(y=subdata$"Voltage", x=subdata$"Timestamp", type="l", xlab="datetime", ylab="Voltage")

#Bottom-Left Plot

plot(subdata$"Timestamp",subdata$"Sub_metering_1",col="black", type="l",xlab="",ylab="Energy sub metering")
lines(subdata$"Timestamp",subdata$"Sub_metering_2",col="red",type="l")
lines(subdata$"Timestamp",subdata$"Sub_metering_3",col="blue",type="l")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1),bty = "n")

#Bottom-Right Plot

plot(y=subdata$"Global_reactive_power", x=subdata$"Timestamp", type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
