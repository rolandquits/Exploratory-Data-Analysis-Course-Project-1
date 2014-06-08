#Downloads the file and unzips it

download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./files.zip")
unzip("./files.zip")

#Reads Table and filters the subset data

data <- read.table("./household_power_consumption.txt", sep=";", header=TRUE,na.strings="?")
data$Date = as.Date(data$"Date", "%d/%m/%Y")
subdata <- subset(data,data$"Date" %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))
Timestamp <- strptime(paste(subdata$"Date", subdata$"Time"), "%Y-%m-%d %H:%M:%S") 
subdata <- (data.frame(subdata,Timestamp))

#Plot 2

png(filename="./plot2.png")
plot(y=subdata$"Global_active_power", x=subdata$"Timestamp", type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
