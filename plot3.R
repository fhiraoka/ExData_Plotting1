library("data.table")

Sys.setlocale(category = "LC_TIME", locale = "C")

power_consumption <- fread(paste("grep ^[12]/2/2007", "household_power_consumption.txt"), na.strings = c("?", ""))
setnames(power_consumption, colnames(fread("household_power_consumption.txt", nrows=0)))

Dates <- as.Date(power_consumption$Date, format="%d/%m/%Y")
Times <- power_consumption$Time
DateTime <- as.POSIXct(paste(as.character(Dates),as.character(Times)))
power_consumption$Date <- DateTime
power_consumption[, Time:=NULL]

with(power_consumption, {
    plot(Date, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(Date, Sub_metering_2, col = "Red")
    lines(Date, Sub_metering_3, col = "Blue")
    legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()

