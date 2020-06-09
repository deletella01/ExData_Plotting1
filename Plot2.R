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
# calling the basic plot function
plot(subpowerCon$Time,as.numeric(as.character(subpowerCon$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kiloWatts)") 
#
dev.copy(png,file='myPlot2.png')
dev.off()

