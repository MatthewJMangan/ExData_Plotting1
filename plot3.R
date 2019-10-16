library(data.table)
library(dplyr)
library(lubridate)

# Read in data from .txt file
df<-fread("household_power_consumption.txt", stringsAsFactors = FALSE, header=TRUE)
df<-tbl_df(df)

# Subset data for desired dates
DFsub <- tbl_df(rbind(subset(df, Date == "1/2/2007"), subset(df, Date == "2/2/2007")))

# Clean up data
DFsub<-mutate(DFsub, GAP = as.numeric(Global_active_power))
DFsub<-mutate(DFsub, DateTime=dmy_hms(paste(Date,Time)))

# Make Plot
png("plot3.png", width = 480, height = 480)
plot(DFsub$DateTime, DFsub$Sub_metering_1, type = 'l', ylab="Energy sub metering",
     xlab="")
points(DFsub$DateTime, DFsub$Sub_metering_2, type = 'l', col='red')
points(DFsub$DateTime, DFsub$Sub_metering_3, type = 'l', col='blue')
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c('black', 'red', 'blue'), lty = "solid")
dev.off()