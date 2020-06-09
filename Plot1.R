#
if(!file.exists("./DataDownload")){dir.create("./DataDownload")}
unzip(zipfile = "./exdata_data_household_power_consumption.zip", exdir = "./DataDownload")
#
powerConsumption <- read.table("./DataDownload/household_power_consumption.txt",skip=1,sep=";")
names(powerConsumption) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpowerCon <- subset(powerConsumption,powerConsumption$Date=="1/2/2007" | powerConsumption$Date =="2/2/2007")
#
hist(as.numeric(subpowerCon$Global_active_power),main = 'Global Active Power',col='red',xlab='Global Active Power (kiloWatts)',ylab='Frequency')
#
dev.copy(png,file='myPlot1.png')
dev.off()
