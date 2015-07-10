# Read household power consumption data, file is ~2M lines, read only half of it, as the
# required data is within the first 1M lines. Subset the data to look for data between dates
# Feb 1, 2007 (1/2/2007) and Feb 2, 2007 (2/2/2007). Add another column which is a sum of
# the date and time called datetime. 

# set the mfcol attribute so that we have 4 graphs on a page, the graphs are printed
# columnwise because mfcol is set. Changethe margins to make them smaller than the default.
# Print the 4 graphs listed.

powerdata <- read.table("household_power_consumption.txt", 
                        na.strings = "?", 
                        stringsAsFactors = FALSE, 
                        sep=";", 
                        header = TRUE, 
                        nrows=100000)

powerdata <- powerdata[powerdata$Date == "1/2/2007" | powerdata$Date == "2/2/2007" , ]

powerdata$datetime <- dmy(powerdata$Date)+hms(powerdata$Time)

par(mfcol = c(2,2))
par(mar = c(3,4,6,2))

# Plot 1 datetime vs active power
with(powerdata, plot(datetime, Global_active_power,
                     type="l",
                     main = "Global Active Power \nover two days",
                     xlab = "",
                     ylab = "Global Active Power (Kilowatts)"))

# Plot 2 datetime vs Sub_metering
with(powerdata,plot(datetime,Sub_metering_1,
                    type="n",
                    main = "Energy Sub Metering \nover two days",
                    xlab="",
                    ylab="Energy Sub Metering"))

with(powerdata, lines(datetime, Sub_metering_1, col = "black"))
with(powerdata, lines(datetime, Sub_metering_2, col = "red"))
with(powerdata, lines(datetime, Sub_metering_3, col = "blue"))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       lty = c(1, 1, 1),
       cex = 0.6)

# Plot 3 datetime vs Voltage
with(powerdata, plot(datetime, Voltage,
                     type="l",
                     main = "Voltage Variation \nover two days",
                     xlab = "",
                     ylab = "Voltage"))

# Plot 4 datetime vs Reactive power
with(powerdata, plot(datetime, Global_reactive_power,
                     type="l",
                     main = "Global Rective Power \nover two days",
                     xlab = "",
                     ylab = "Global Reactive Power (Kilowatts)"))

dev.copy(png, file = "plot4.png")
dev.off()
