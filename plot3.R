plot3 <- function(){
        library(stringr) ## for str_c()
        
        ##Read outcome data
        row_start = 66638
        row_end = 69517
        options(stringsAsFactors = FALSE)
        filename <- "household_power_consumption.txt"
        col_names = c("Date", "Time", "Global_active_power", 
                      "Global_reactive_power", "Voltage", "Global_intensity", 
                      "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        data <-read.table(filename,
                          header = FALSE, 
                          sep = ";",
                          na.strings = "?", 
                          skip = row_start - 1, 
                          nrows = row_end - row_start + 1,
                          colClasses = c(rep("character",2),rep("numeric",7)),
                          col.names = col_names
        )
        # combine column 1 & 2 to generate correct time tag
        t_string <- str_c(data$Date, " ", data$Time)
        time_stamp <- strptime(t_string, format="%d/%m/%Y %H:%M:%S")
        
        #Plot and Record
        png(filename = "plot3.png",
            width = 480, height = 480, units = "px",
            bg = "white")
        plot(time_stamp, data$Sub_metering_1, type = "l", col = "black",
             xlab = "", ylab = "Global Active Power (Kilowatts)", main = "")
        points(time_stamp, data$Sub_metering_2, type = "l", col = "red")
        points(time_stamp, data$Sub_metering_3, type = "l", col = "blue")
        legend("topright", pch = "", col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
               lwd=1, lty=c(1,1,1))
        
        dev.off()
}