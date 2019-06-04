library(plyr)
library(dplyr)
library(lubridate)

df <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")
df <- mutate(df, Date = dmy(Date))
df <- filter(df, Date >= ymd('2007-02-01') & Date <= ymd('2007-02-02'))

df <- mutate(df, Time = hms(df$Time))
df <- mutate(df, Global_active_power = as.numeric(as.character(Global_active_power)))


png(file="plot2.png", width=480, height=480)
with(df, plot(Date + Time, Global_active_power, type ="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()