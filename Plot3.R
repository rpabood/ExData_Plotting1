library(plyr)
library(dplyr)
library(lubridate)

df <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")
df <- mutate(df, Date = dmy(Date))
df <- filter(df, Date >= ymd('2007-02-01') & Date <= ymd('2007-02-02'))
df <- mutate(df, Time = hms(df$Time))

df <- mutate(df, Sub_metering_1 = as.numeric(as.character(Sub_metering_1)))
df <- mutate(df, Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))
df$DateTime <- df$Date + df$Time

png(file="plot3.png", width=480, height=480)

plot(df$DateTime, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)      

dev.off()