##
## Coding for: Exploring Data Project_1 
## 12 Oct 2014
## 
## README.md has details of the data & instructions for this project
## 
## plot1.R should be located together with the necessary data file
##         household_power_consumption.txt
##         Open this file (plot1.R) in R or RStudio & 
##         source("plot1.R")
##         run the function plot1()
##         to create histogram plot1.png

plot1 <- function() {
  
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
  
          hist(EData$Global_active_power, col = "red", 
               main = "", xlab = "Global Active Power (kilowatts)")
    
          dev.copy(png, file = "plot1.png") ## Copy histogram to a PNG file
          dev.off()                         ## Close the PNG device

  return()
  
}
