# Loading the required libraries
library(dplyr)

# Reading the data after setting the directory to working directory.
x <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")

# The data required for analysis was selected.
data <- x[x$Date %in% "2/2/2007" | x$Date %in% "1/2/2007",]

# The data was of factor class, it was converted to numeric class in order to perform the analysis.
data[,3:9] <- sapply(data[,3:9], function(f) as.numeric(as.character(f)))

# A new variable 'datetime' was made which stores the data as well as time as a single value.
data$datetime <- apply(data[,1:2], 1, paste, collapse=" ") %>% strptime(format = "%d/%m/%Y %H:%M:%S")

# The required data was subsetted again after mutating the data frame.
data <- data[,3:10]

# A timeplot of 'Sub_metering_1' was plotted as line plot.
with(data, plot(datetime, Sub_metering_1, type = "l", lty = 1, col = "black", main = "", xlab = "", ylab = "Energy sub metering"))

# Timeplot of 'Sub_metering_2' was added to the same plot using 'lines()'
with(data, lines(datetime, Sub_metering_2, col = "red", lty = 1))

# Timeplot of 'Sub_metering_3' was added to the same plot using 'lines()'
with(data, lines(datetime, Sub_metering_3, col = "blue", lty = 1))

# Legend was added to give information regarding the plots.
legend("topright", lty = 1, col = c("black","red","blue"), legend = c("Sub_m_1","Sub_m_2","Sub_m_3"))

# The plot was then saved.                  
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
