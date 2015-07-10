# Read household power consumption data, file is ~2M lines, read only half of it, as the
# required data is within the first 1M lines. Subset the data to look for data between dates
# Feb 1, 2007 (1/2/2007) and Feb 2, 2007 (2/2/2007). Add another column which is a sum of
# the date and time called datetime. 

# Plot datetime vs SUb_metering_1,2 and 3. To do this, first create a blank plot then add
# each sub_metering tp this plot and create the legend.

powerdata <- read.table("household_power_consumption.txt", 
                        na.strings = "?", 
                        stringsAsFactors = FALSE, 
                        sep=";", 
                        header = TRUE, 
                        nrows=100000)

powerdata <- powerdata[powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007" , ]

powerdata$datetime <- dmy(powerdata$Date)+hms(powerdata$Time)

with(powerdata,plot(datetime,Sub_metering_1,
                    type="n",
                    main = "Energy Sub Metering",
                    xlab="",
                    ylab="Energy Sub Metering"))

with(powerdata, lines(datetime, Sub_metering_1, col = "black"))
with(powerdata, lines(datetime, Sub_metering_2, col = "red"))
with(powerdata, lines(datetime, Sub_metering_3, col = "blue"))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       lty = c(1, 1, 1),
       cex = 0.6)

dev.copy(png, file = "plot3.png")
dev.off()
