plot1 <- function(){

library(dplyr)
consum <- read.csv(dir(pattern="*.txt")[1], sep=";", header = TRUE, stringsAsFactors = TRUE)
consum <- tbl_df(consum)
consum<-mutate(consum, DateTime=paste(as.character(Date), as.character(Time), sep=" "))
consum <- mutate(consum, Date= as.POSIXct(strptime(as.character(Date), "%d/%m/%Y")))
consum <- filter( consum, Date == (as.POSIXct("2007-02-01")) | Date == (as.POSIXct("2007-02-02")))
if( file.exists("plot1.png")) file.remove("plot1.png")
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(as.character(consum$Global_active_power)), col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
consum
}

