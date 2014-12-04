this.dir <- dirname(parent.frame(2)$ofile) 
setwd(this.dir) 

# location of extracted text file
dataFile <- "./household_power_consumption.txt"

# Download, extract the file if it hasn't been already
if (!file.exists(dataFile))
{
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  destUrl <- "./household_power_consumption.zip"
  download.file(url, destfile = destUrl)
  unzip(destUrl)
}

# Read in the data to a data frame
householdPowerConsumption <- read.table(dataFile, 
                                        sep = ";", 
                                        na.strings = c("?"),
                                        header = TRUE)

# concatonate the date and time columns and convert to POSIXlt
householdPowerConsumption$Time <- strptime(
  paste(householdPowerConsumption$Date, householdPowerConsumption$Time), 
  format = "%d/%m/%Y %H:%M:%S")

# define the limits
earliestSubsetDateTime = strptime("2007-02-01 00:00:00", format = "%Y-%m-%d %H:%M:%S")
latestSubsetDateTime = strptime("2007-02-03 00:00:00", format = "%Y-%m-%d %H:%M:%S")

# subset to the date/time range required 
# (note inclusive and non-inclusive comparisons)
hpc2 <- subset(householdPowerConsumption, Time >= earliestSubsetDateTime & Time < latestSubsetDateTime)

# plot 3
# 
png("plot3.png")

with (hpc2,{
plot(Time, 
     Sub_metering_1, 
     col = "black",
     xlab = "", 
     ylab = "Energy sub metering",      
     type = "l")

lines ( Time, 
        Sub_metering_2,
        col = "red")

lines ( Time, 
        Sub_metering_3, 
        col = "blue")

legend("topright", 
       lty=c(1,1,1),       
       lwd=c(2.5,2.5,2.5),
       col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

dev.off()


