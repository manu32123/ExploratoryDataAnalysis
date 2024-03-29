df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
df$Date <- as.Date(df$Date, "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
df <- subset(df,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
df <- df[complete.cases(df),]

## Combine Date and Time column
dateTime <- paste(df$Date, df$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
df <- df[ ,!(names(df) %in% c("Date","Time"))]

## Add DateTime column
df <- cbind(dateTime, df)

## Format dateTime Column
df$dateTime <- as.POSIXct(dateTime)


save(df,file="electric.Rda")

hist(df$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()



