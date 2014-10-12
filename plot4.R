##
## Coding for: Exploring Data Project_1 
## 12 Oct 2014
## 
## README.md has details of the data & instructions for this project
## 
## plot4.R should be located together with the necessary data file
##         household_power_consumption.txt
##         Open this file (plot4.R) in R or RStudio & 
##         source("plot4.R")
##         run the function plot4()
##         to create graph plot4.png

plot4 <- function() {
  
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
       ## plot 4 graphs & save a copy to plot4.png
       ##  
  
  
          par(mfrow=c(2,2))  
          
          ## top left graph
          ##
          plot(EData$DateTime, EData$Global_active_power, type = "l", xlab = "", 
               ylab = "Global Active Power")
  
  
          ## top right graph
          ##
          plot(EData$DateTime, EData$Voltage, type = "l", 
               xlab = "datetime", 
               ylab = "Voltage")
  
  
          ## bottom left graph
          ##  
          plot(EData$DateTime, EData$Sub_metering_1, type = "l", 
               xlab = "", ylab = "Energy sub metering")
          lines(EData$DateTime, EData$Sub_metering_2, col = "red")
          lines(EData$DateTime, EData$Sub_metering_3, col = "blue")
  
          legtxt <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
          legend( 'topright', legend = legtxt, lty=1, 
                   col=c('black', 'red', 'blue'), bty='n', cex= .5)

      
          ## bottom right graph
          ##
          plot(EData$DateTime, EData$Global_reactive_power, type = "l", 
               xlab = "datetime", 
               ylab = "Global_reActive_power")
  
          
          dev.copy(png, file = "plot4.png") ## Copy histogram to a PNG file
          dev.off()                         ## Close the PNG device

  return()
  
}
