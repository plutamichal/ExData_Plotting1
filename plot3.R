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

## Plot 3

png(file = "plot3.png")
with(temp_df,  
    plot(Sub_metering_1, type="l", col="black"
        , ylab = "Energy sub metering"
        , xlab = ''
        , xaxt = 'n')
     )

with(temp_df,  
     lines(Sub_metering_2, type="l"
          , col = "red")
)
with(temp_df,  
     lines(Sub_metering_3, type="l"
           , col = "blue")
)
len <- length(temp_df$Global_active_power)

# add x-axis
axis(side = 1, at = c(1, len/2, len), labels = c('Thu', 'Fri', 'Sat'))

legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col = c('black', 'red', 'blue'), lty = c(1,1,1))

dev.off()


