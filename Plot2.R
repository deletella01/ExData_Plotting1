
# First, we download the given data to a folder.
if(!file.exists("./DataDownload")){dir.create("./DataDownload")}
fileUrl<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl,destfile = './DataDownload/exdata_data_household_power_consumption.zip')

# Then the .txt file is extracted from the zip file to the folder.
unzip(zipfile = "./DataDownload/exdata_data_household_power_consumption.zip", exdir = "./DataDownload")

# The .txt file is read to R and the data is stored in a vector.
powerConsumption <- read.table("./DataDownload/household_power_consumption.txt",skip=1,sep=";")

# The names of each variable is assigned and the required data is extracted and stored in a new vector.
names(powerConsumption) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpowerCon <- subset(powerConsumption,powerConsumption$Date=="1/2/2007" | powerConsumption$Date =="2/2/2007")

# The Date and Time variable are rewritten in form of the day of the week.
subpowerCon$Date <- as.Date(subpowerCon$Date, format="%d/%m/%Y")
subpowerCon$Time <- strptime(subpowerCon$Time, format="%H:%M:%S")
subpowerCon[1:1440,"Time"] <- format(subpowerCon[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpowerCon[1441:2880,"Time"] <- format(subpowerCon[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# Calling the basic plot function of Global Active Power against day of the week.
plot(subpowerCon$Time,as.numeric(as.character(subpowerCon$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kiloWatts)") 

# the plotted graph is stored as a png file.
dev.copy(png,file='myPlot2.png')
dev.off() 

