library("data.table")

Sys.setlocale(category = "LC_TIME", locale = "C")

power_consumption <- fread(paste("grep ^[12]/2/2007", "household_power_consumption.txt"), na.strings = c("?", ""))
setnames(power_consumption, colnames(fread("household_power_consumption.txt", nrows=0)))

Dates <- as.Date(power_consumption$Date, format="%d/%m/%Y")
Times <- power_consumption$Time
DateTime <- as.POSIXct(paste(as.character(Dates),as.character(Times)))
power_consumption$Date <- DateTime
power_consumption[, Time:=NULL]

par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(power_consumption, {
    plot(Date, Global_active_power, type = "l", ylab = "Global Active Power", xlab ="")

    plot(Date, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
    
    plot(Date, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(Date, Sub_metering_2, col = "Red")
    lines(Date, Sub_metering_3, col = "Blue")
    legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(Date, Global_reactive_power, type = "l", ylab = "Global Rective Power (kilowatts)", xlab = "datetime")
})

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()

