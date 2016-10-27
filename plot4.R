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
png(file = "plot4.png")

# Set layout to 2x2 starting with rows
par(mfrow = c(2,2))

# Plot #1
with(hpc,plot(DateTime,Global_active_power,xlab = "",ylab = "Global Active Power",type = "l" ))  

# Plot #2
with(hpc,plot(DateTime,Voltage,xlab = "datetime",type = "l" ))  

# Plot #3
plot(hpc$DateTime,hpc$Sub_metering_1,xlab = "",ylab = "Energy sub metering",type = "l",lwd = 1 )
lines(hpc$DateTime,hpc$Sub_metering_2,col="red")
lines(hpc$DateTime,hpc$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lwd=1,bty="n",cex=0.8)

# Plot #4
with(hpc,plot(DateTime,Global_reactive_power,xlab = "datetime",type = "l" ))  

# Reset device to default
dev.off()
# Reset layout
par(mfrow = c(1,1))
