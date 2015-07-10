# Read household power consumption data, file is ~2M lines, read only 100K lines of it, as the
# required data is within the first 100K lines. SUbset the data to look for data between dates
# Feb 1, 2007 (1/2/2007) and Feb 2, 2007 (2/2/2007). Create a histogram of the 
# Global Active Power and save it to a .png file

powerdata <- read.table("household_power_consumption.txt", 
                na.strings = "?", 
                stringsAsFactors = FALSE, 
                sep=";", 
                header = TRUE, 
                nrows=100000)

powerdata <- powerdata[powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007" , ]

hist(powerdata$Global_active_power,
     main = "Global Active Power", 
     xlab = "Global_active_power(kilowatts)",
     col="red")

dev.copy(png, file = "plot1.png")
dev.off()
