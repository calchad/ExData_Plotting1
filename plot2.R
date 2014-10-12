##
## Coding for: Exploring Data Project_1 
## 12 Oct 2014
## 
## README.md has details of the data & instructions for this project
## 
## plot2.R should be located together with the necessary data file
##         household_power_consumption.txt
##         Open this file (plot2.R) in R or RStudio & 
##         source("plot2.R")
##         run the function plot2()
##         to create graph plot2.png

plot2 <- function() {
  
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
       ## plot histogram & save a copy to plot2.png
       ##  
  
          ##hist(EData$Global_active_power, col = "red", 
          ##     main = "", xlab = "Global Active Power (kilowatts)")
    
          plot(EData$DateTime, EData$Global_active_power, type = "l", xlab = "", 
               ylab = "Global Active Power (kilowatts)")
  
          dev.copy(png, file = "plot2.png") ## Copy histogram to a PNG file
          dev.off()                         ## Close the PNG device

  return()
  
}
