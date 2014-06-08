#Downloads the file and unzips it

download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./files.zip")
unzip("./files.zip")

#Reads Table and filters the subset data

data <- read.table("./household_power_consumption.txt", sep=";", header=TRUE,na.strings="?")
data$Date = as.Date(data$"Date", "%d/%m/%Y")
subdata <- subset(data,data$"Date" %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))
Timestamp <- strptime(paste(subdata$"Date", subdata$"Time"), "%Y-%m-%d %H:%M:%S") 
subdata <- (data.frame(subdata,Timestamp))

#Plot 3

png(filename="./plot3.png")
plot(subdata$"Timestamp",subdata$"Sub_metering_1",col="black", type="l",xlab="",ylab="Energy sub metering")
lines(subdata$"Timestamp",subdata$"Sub_metering_2",col="red",type="l")
lines(subdata$"Timestamp",subdata$"Sub_metering_3",col="blue",type="l")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1))
dev.off()
