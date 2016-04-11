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

## Plot 1
png(file = "plot1.png")
with(temp_df, hist(Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red"))
dev.off()


