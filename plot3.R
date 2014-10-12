##
## Coding for: Exploring Data Project_1 
## 12 Oct 2014
## 
## README.md has details of the data & instructions for this project
## 
## plot3.R should be located together with the necessary data file
##         household_power_consumption.txt
##         Open this file (plot3.R) in R or RStudio & 
##         source("plot3.R")
##         run the function plot3()
##         to create graph plot3.png

plot3 <- function() {
  
  ##
  ## make sure all necessary graphics libraries are open
  ##
      library("data.table")
      library("date")
      library("graphics")
      library("grDevices")
      library("lattice")
      library("grid")
  
  ##
  ## read in first line of the data file to create vector of column names
  ##
     ##
     ## colheads is a data frame with 9 variables V1 to V9
     ##
        colheads<-read.table("household_power_consumption.txt", 
                              header = FALSE, nrows= 1, na.strings="?", 
                              sep = ";")
     ##
     ## initialize column heading vector
     ## & populate from column heading data frame
     ##
        covector<- rep(c(" "), each = length(colheads))
        
        for(i in 1:length(colheads)){ covector[i]<-as.vector(colheads[,i])}

     ##
     ## read in required household power usage records in file 
     ## assuming roughly 0.14GB memory available for 32 bit R/RStudio
     ##
  
       ##
       ## read entire file
       ##
          EData<-read.table("household_power_consumption.txt", 
                             header = FALSE, skip = 1, 
                             na.strings="?", sep = ";", 
                             col.names = covector)
       ##
       ## subset to required dates
       ## & format date & time as required for graph
       ##
          EData <- EData[(EData$Date=="1/2/2007" | EData$Date =="2/2/2007"),]
  
          EData$DateTime <- strptime(paste(EData$Date, EData$Time, sep=","), 
                                     format="%d/%m/%Y,%H:%M:%S")
          EData$Date <- as.Date(EData$Date)
          
       ##
       ## plot histogram & save a copy to plot1.png
       ##  
  
          ##hist(EData$Global_active_power, col = "red", 
          ##     main = "", xlab = "Global Active Power (kilowatts)")
    
          plot(EData$DateTime, EData$Sub_metering_1, type = "l", xlab = "", 
               ylab = "Energy sub metering")
          lines(EData$DateTime, EData$Sub_metering_2, col = "red")
          lines(EData$DateTime, EData$Sub_metering_3, col = "blue")
  
          legtxt <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
          legend( 'topright', legend = legtxt, lty=1, 
                  col=c('black', 'red', 'blue'), bty='o', cex=.75)
  
          dev.copy(png, file = "plot3.png") ## Copy histogram to a PNG file
          dev.off()                         ## Close the PNG device

  return()
  
}
