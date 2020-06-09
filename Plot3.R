#
if(!file.exists("./DataDownload")){dir.create("./DataDownload")}
unzip(zipfile = "./DataDownload/exdata_data_household_power_consumption.zip", exdir = "./DataDownload")
#
powerConsumption <- read.table("./DataDownload/household_power_consumption.txt",skip=1,sep=";")
names(powerConsumption) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpowerCon <- subset(powerConsumption,powerConsumption$Date=="1/2/2007" | powerConsumption$Date =="2/2/2007")
#
subpowerCon$Date <- as.Date(subpowerCon$Date, format="%d/%m/%Y")
subpowerCon$Time <- strptime(subpowerCon$Time, format="%H:%M:%S")
subpowerCon[1:1440,"Time"] <- format(subpowerCon[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpowerCon[1441:2880,"Time"] <- format(subpowerCon[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
#
plot(subpowerCon$Time,subpowerCon$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subpowerCon,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subpowerCon,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subpowerCon,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#
dev.copy(png,file='myPlot3.png')
dev.off()