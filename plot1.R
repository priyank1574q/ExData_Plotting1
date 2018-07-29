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

#The required data was subsetted again after mutating the data frame.
data <- data[,3:10]

# Histogram plot was made of 'Global_active_power' to get the required graph.
with(data, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))

# The plot was then saved.
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
