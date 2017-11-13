# To plot Histogram of Active Power consumed by hOusehold
#To import data and Reading in to data table
library(data.table)
path <- getwd()
elepowcons <- (file.path(path,"household_power_consumption.txt"))
powerconsdata<- read.table(elepowcons,header = TRUE, sep=";", dec=".",na.strings="?",stringsAsFactors = FALSE,comment.char = " ", quote = '\"')
# Selecting data for dates 1/2/2007 to 2/2/2007
d<-c("1/2/2007","2/2/2007")
#reqdData <-powerconsdata[powerconsdata$Date[d],]
reqdData <- subset(powerconsdata,Date %in% d)
#Given file data is all in the character, converting to numeric, except Date and Time
reqdData$Global_active_power<- as.numeric(reqdData$Global_active_power)
reqdData$Global_reactive_power<-as.numeric(reqdData$Global_reactive_power)
reqdData$Voltage <- as.numeric(reqdData$Voltage)
reqdData$Global_intensity<-as.numeric(reqdData$Global_intensity)
reqdData$Sub_metering_1<-as.numeric(reqdData$Sub_metering_1)
reqdData$Sub_metering_2<-as.numeric(reqdData$Sub_metering_2)
reqdData$Sub_metering_3<-as.numeric(reqdData$Sub_metering_3)
#Converting Date from Character to as. Date
x<-reqdData$Date
newdate <- as.Date(x, format="%d/%m/%Y")
head(newdate)#Checks
class(newdate)
#Merging date and time and converting 
date_time<-paste(newdate,reqdData$Time)
date_time<- as.POSIXct(date_time)
reqdData$Date<-newdate
reqdData$date_time <-date_time # New column added to data frame
#str(reqdData)
#plotting Histogram
hist(reqdData$Global_active_power,xlab= "Global Active Power(kilowatts)", main="Global Active Power", col="red")
dev.copy(png,width=480,height=480,file="plot1.png")# Copying histogram to file
dev.off()
