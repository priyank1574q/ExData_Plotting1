library(dplyr)
x <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
data <- x[x$Date %in% "2/2/2007" | x$Date %in% "1/2/2007",]
data[,3:9] <- sapply(data[,3:9], function(f) as.numeric(as.character(f)))
data$datetime <- apply(data[,1:2], 1, paste, collapse=" ") %>% strptime(format = "%d/%m/%Y %H:%M:%S")
data <- data[,3:10]

with(data, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

dev.copy(png, file = "plot1.png")
dev.off()
