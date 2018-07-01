library(dplyr)
x <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
data <- x[x$Date %in% "2/2/2007" | x$Date %in% "1/2/2007",]
data[,3:9] <- sapply(data[,3:9], function(f) as.numeric(as.character(f)))
data$datetime <- apply(data[,1:2], 1, paste, collapse=" ") %>% strptime(format = "%d/%m/%Y %H:%M:%S")
data <- data[,3:10]

                     
par(mfrow = c(2,2))

with(data, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

with(data, plot(datetime, Voltage, type = "l"))

with(data, plot(datetime, Sub_metering_1, type = "l", lty = 1, col = "black", xlab = "", ylab = "Energy sub metering"))
with(data, lines(datetime, Sub_metering_2, col = "red", lty = 1))
with(data, lines(datetime, Sub_metering_3, col = "blue", lty = 1))
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_m_1","Sub_m_2","Sub_m_3"))

with(data, plot(datetime, Global_reactive_power, type = "l"))


dev.copy(png, file = "plot4.png")
dev.off()
