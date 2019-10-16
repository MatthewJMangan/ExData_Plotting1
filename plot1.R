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

# Make plot
par(mfrow=c(1,1))
png("plot1.png", width = 480, height = 480)
hist(DFsub$GAP, main='Global Active Power', col='red', 
        xlab='Global Active Power (kilowatts)')
dev.off()
