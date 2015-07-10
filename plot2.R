# Read household power consumption data, file is ~2M lines, read only half of it, as the
# required data is within the first 1M lines. Subset the data to look for data between dates
# Feb 1, 2007 (1/2/2007) and Feb 2, 2007 (2/2/2007). Add another column which is a sum of
# the date and time called datetime. Plot a graph of global active power against datetime
# which is what is needed/

powerdata <- read.table("household_power_consumption.txt", 
                        na.strings = "?", 
                        stringsAsFactors = FALSE, 
                        sep=";", 
                        header = TRUE, 
                        nrows=100000)

powerdata <- powerdata[powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007" , ]

powerdata$datetime <- dmy(powerdata$Date)+hms(powerdata$Time)

with(powerdata, plot(datetime, Global_active_power,
                     type="l",
                     main = "Global Active Power over Two days",
                     xlab = "",
                     ylab = "Global Active Power (Kilowatts)"))

dev.copy(png, file = "plot2.png")
dev.off()
