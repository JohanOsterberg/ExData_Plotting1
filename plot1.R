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

# Set device 
png(file = "plot1.png")

# Plot
with(hpc,hist(Global_active_power,col="red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power" ))  

# Reset device to default
dev.off()
