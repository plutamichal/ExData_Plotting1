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

## Plot 2

png(file = "plot2.png")
with(temp_df,  
    plot(time,Global_active_power, type="l"
        , ylab = "Global Active Power (kilowatts)"
        , xlab = ''
        , xaxt = 'n')
     )

len <- length(temp_df$Global_active_power)

# add x-axis
axis(side = 1, at = c(1, len/2, len), labels = c('Thu', 'Fri', 'Sat'))

dev.off()

