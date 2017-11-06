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

# Construct the first plot on screen
hist(DataSelect$GlobalActivePower,col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power")

# Copy and save the plot into a png file 
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()