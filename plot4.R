## libraries
library(sqldf)

## download and unzip data from assignment
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp)

## read txt file
temp_df <- read.csv.sql("household_power_consumption.txt",
                        sql="select * from file where Date in ('1/2/2007', '2/2/2007')"
                        , header=TRUE, sep=";"
                        )

temp_df[ temp_df == "?" ] = NA

time <- strptime(paste(temp_df$Date, temp_df$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

## Plot 4

png(file = "plot4.png")
par(mfrow=c(2,2))
with(temp_df,  
    plot(time, Global_active_power, type="l", col="black"
        , ylab = "Global Active Power"
        , xlab = ''
        , xaxt = 'n')
     )
len <- length(temp_df$Global_active_power)

# add x-axis
axis(side = 1, at = c(1, len/2, len), labels = c('Thu', 'Fri', 'Sat'))

with(temp_df,  
     plot(time, Voltage, type="l", col="black"
          , ylab = "Voltage"
          , xlab = 'datetime'
          , xaxt = 'n')
)
len <- length(temp_df$Voltage)

# add x-axis
axis(side = 1, at = c(1, len/2, len), labels = c('Thu', 'Fri', 'Sat'))


with(temp_df,  
     plot(time, Sub_metering_1, type="l", col="black"
          , ylab = "Energy sub metering"
          , xlab = ''
          , xaxt = 'n')
)

with(temp_df,  
     lines(time, Sub_metering_2, type="l"
           , col = "red")
)
with(temp_df,  
     lines(time, Sub_metering_3, type="l"
           , col = "blue")
)
len <- length(temp_df$Global_active_power)

# add x-axis
axis(side = 1, at = c(1, len/2, len), labels = c('Thu', 'Fri', 'Sat'))

legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'), lty = c(1,1,1))

with(temp_df,  
     plot(Global_reactive_power, type="l", col="black"
          , ylab = "Global_reactive_power"
          , xlab = 'datetime'
          , xaxt = 'n')
)
len <- length(temp_df$Global_reactive_power)

# add x-axis
axis(side = 1, at = c(1, len/2, len), labels = c('Thu', 'Fri', 'Sat'))

dev.off()



