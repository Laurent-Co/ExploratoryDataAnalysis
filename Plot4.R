#Downloading the raw data
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="ElectricPowerConsumtpion.zip")
unzip('ElectricPowerConsumption.zip',exdir="ElectricPowerConsumption")

#Reading the text file
Data<-read.table("./ElectricPowerConsumption/household_power_consumption.txt",sep=";",stringsAsFactors = FALSE, col.names=c("Date","Time","GlobalActivePower","GlobalReacivePower","Voltage","GlobalIntensity","SubMetering1","SubMetering2","SubMetering3"),skip=1)

# Setting appropriate format for each variable
Data$Date<-as.Date(Data$Date,format="%d/%m/%Y")
Data$Time<-as.POSIXct(paste(Data$Date, Data$Time), format="%Y-%m-%d %H:%M:%S")
Data$GlobalActivePower<-as.numeric(Data$GlobalActivePower)
Data$GlobalIntensity<-as.numeric(Data$GlobalIntensity)
Data$GlobalReacivePower<-as.numeric(Data$GlobalReacivePower)
Data$Voltage<-as.numeric(Data$Voltage)
Data$SubMetering1<-as.numeric(Data$SubMetering1)
Data$SubMetering2<-as.numeric(Data$SubMetering2)

# Extracting only measurements on the 01-02-2007 and 02-02-2007
Extract<-grep("2007-02-01|2007-02-02",Data$Date)
DataSelect<-Data[Extract,]

# Construct the fourth plot on screen
par(mfrow=c(2,2))

with(DataSelect,plot(Time,GlobalActivePower,ylab="Global Active Power (kilowatts)",xlab="",type="l"))

with(DataSelect,plot(Time,Voltage,ylab="Voltage",xlab="datetime",type="l"))

with(DataSelect,plot(Time,SubMetering1,ylab="Energy Sub Metering",xlab="",type="l"))
with(DataSelect,points(Time,SubMetering2,xlab="",type="l",col="red"))
with(DataSelect,points(Time,SubMetering3,xlab="",type="l",col="blue"))
legend("topright",lwd=c(2,2,2),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(DataSelect,plot(Time,GlobalReacivePower,ylab="Global_reactive_power",xlab="datetime",type="l"))

# Copy and save the plot into a png file 
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()