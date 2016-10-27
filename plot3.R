# Load required packages
library(dplyr)
library(data.table)


# Download compressed data file for project and unzip file
FileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(FileUrl,destfile = "household_power_consumption.zip" )
unzip("household_power_consumption.zip",exdir = ".")

# Read data from the dates 2007-02-01 and 2007-02-02
hpc <- fread("household_power_consumption.txt",sep=";",na.strings = "?") %>%
  filter(Date == '1/2/2007' | Date == '2/2/2007')

# Convert the Date and Time variables to Date/Time class
hpc$DateTime <- with(hpc,strptime(paste(Date,Time,sep=" "),"%d/%m/%Y %H:%M:%S"))

# Set device 
png(file = "plot3.png")

# Plot
plot(hpc$DateTime,hpc$Sub_metering_1,xlab = "",ylab = "Energy sub metering",type = "l",lwd = 1 )
lines(hpc$DateTime,hpc$Sub_metering_2,col="red")
lines(hpc$DateTime,hpc$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lwd=1)

# Reset device to default
dev.off()
