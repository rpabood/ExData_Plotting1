library(plyr)
library(dplyr)
library(lubridate)

df <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")
df <- mutate(df, Date = dmy(Date))
df <- filter(df, Date >= ymd('2007-02-01') & Date <= ymd('2007-02-02'))
df <- mutate(df, Time = hms(df$Time))

df <- mutate(df, Sub_metering_1 = as.numeric(as.character(Sub_metering_1)))
df <- mutate(df, Sub_metering_2 = as.numeric(as.character(Sub_metering_2)))
df <- mutate(df, Global_active_power = as.numeric(as.character(Global_active_power)))
df <- mutate(df, Global_reactive_power = as.numeric(as.character(Global_reactive_power)))
df <- mutate(df, Voltage = as.numeric(as.character(Voltage)))
df$DateTime <- df$Date + df$Time



png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
#plot1
with(df, plot(Date + Time, Global_active_power, type ="l", xlab="", ylab="Global Active Power (kilowatts)"))
#plot2
with(df, plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage"))
#plot3
plot(df$DateTime, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")      
#plot4
with(df, plot(DateTime, Global_reactive_power, type="l", xlab="", ylab="Global_reactive_power"))

dev.off()