# To plot all 4 plots of Global Active Power consumed by hOusehold on daily
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
#setting global plotting system
par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))
#plot1
with(reqdData, plot(Global_active_power~date_time, type="l", xlab=" ", ylab="Global Active Power(kilowatts)"))
#plot2
plot(reqdData$Voltage~date_time,type="l", xlab="datetime ", ylab="Voltage")
#plot3
plot(reqdDta$Sub_metering_1~date_time, type="l", xlab=" ", ylab="Energy sub metering")
lines(reqdDta$Sub_metering_2~date_time,col="red")
lines(reqdDta$Sub_metering_3~date_time,col="blue")
legend("topright",col=c("black","red","blue"),lty=1,lwd=2,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#plot4
plot(GlobalReactivePower~date_time,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.copy(png,width=480,height=480,file="plot4.png")# Copying plot to file
dev.off()