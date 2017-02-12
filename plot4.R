plot4 <- function(){

library(dplyr)
consum <- read.csv(dir(pattern="*.txt")[1], sep=";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")
consum <- tbl_df(consum)
consum<-mutate(consum, DateTime=paste(as.character(Date), as.character(Time)))
consum <- mutate(consum, Date= as.POSIXct(strptime(as.character(Date), "%d/%m/%Y")))
consum <- filter( consum, Date == (as.POSIXct("2007-02-01")) | Date == (as.POSIXct("2007-02-02")))
consum <- mutate(consum, Global_active_power=as.numeric(as.character(consum$Global_active_power)))
consum <- mutate(consum, DateTime = as.POSIXct(as.character(strptime(DateTime, format="%d/%m/%Y %H:%M:%S"))))
#startTime <- consum[1, length(names(consum))][[1]]
#consum <- mutate(consum, Seconds = as.numeric(DateTime - startTime))

if( file.exists("plot4.png")) file.remove("plot4.png")
png(filename = "plot4.png" , width = 480, height = 480)

par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))


with(consum, {
  
              plot(DateTime, Global_active_power, type= "l", ylab = "Global active power (kilowatts)", xlab = "")  
  
              plot(DateTime, Sub_metering_1, type= "l", col="black", xlab = "", ylab="Energy sub metering")
              lines(DateTime, Sub_metering_2, type ="l", col= "red")
              lines(DateTime, Sub_metering_3, type="l", col="blue")
              legend("topright", legend=names(consum)[grep("^Sub_metering", names(consum))], col = c("black", "red", "blue"), lty = 1 , bty ="n")
              
              plot(DateTime, Voltage,  xlab = tolower("DateTime"), ylab= "Voltage", type="l")
              plot(DateTime, Global_reactive_power, xlab=tolower("DateTime"), ylab="Global_reactive_power", type="l")
            }
     )






dev.off()


consum


}

