# To plot Global Active Power consumed by hOusehold on daily
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
GlobalActivePower<- as.numeric(reqdData$Global_active_power)
GlobalReactivePower<-as.numeric(reqdData$Global_reactive_power)
voltagelevel <- as.numeric(reqdData$Voltage)
Globalintensity<-as.numeric(reqdData$Global_intensity)
submetering1<-as.numeric(reqdData$Sub_metering_1)
submetering2<-as.numeric(reqdData$Sub_metering_2)
submetering3<-as.numeric(reqdData$Sub_metering_3)
#Converting Date from Character to as. Date
x<-reqdData$Date
newdate <- as.Date(x, format="%d/%m/%Y")
head(newdate)#Checks
class(newdate)
#Merging date and time and converting 
date_time<-paste(newdate,reqdData$Time)
date_time<- as.POSIXct(date_time)
#y <-reqdData$Time
#newtime<-strptime(y, format="%H:%M:%S")
#newtime<-as.POSIXt(newtime)
#head(newtime)
#class(newtime)
reqdData$Date<-newdate
reqdData$date_time <-date_time # New column added to data frame
#str(reqdData)
#plot 2
with(reqdData, plot(Global_active_power~date_time, type="l", xlab=" ", ylab="Global Active Power(kilowatts)"))
dev.copy(png,width=480,height=480,file="plot2.png")# Copying plot to file
dev.off()