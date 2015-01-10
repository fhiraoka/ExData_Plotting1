library("data.table")

Sys.setlocale(category = "LC_TIME", locale = "C")

power_consumption <- fread(paste("grep ^[12]/2/2007", "household_power_consumption.txt"), na.strings = c("?", ""))
setnames(power_consumption, colnames(fread("household_power_consumption.txt", nrows=0)))

Dates <- as.Date(power_consumption$Date, format="%d/%m/%Y")
Times <- power_consumption$Time
DateTime <- as.POSIXct(paste(as.character(Dates),as.character(Times)))
power_consumption$Date <- DateTime
power_consumption[, Time:=NULL]

with(power_consumption, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = ""))

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()

