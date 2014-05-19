# workdir <- "C:/Users/aahumada.SA/MatLab/RStudio/RepData_PeerAssessment1"
# 
# src1    <- paste(workdir,"activity.csv",sep="/")
# 
# setwd(workdir)

#------------------------------------------
#   LOAD DATA SOURCE
#------------------------------------------
# steps   : Number of steps taking in a 5-minute interval (missing values are coded as NA)
# date    : The date on which the measurement was taken in YYYY-MM-DD format
# interval: Identifier for the 5-minute interval in which measurement was taken
#------------------------------------------
# EXAMPLE
#------------------------------------------
# "steps","date","interval"
# NA,"2012-10-01",0
# NA,"2012-10-01",5
# NA,"2012-10-01",10

library(data.table)

activity  <- read.csv("activity.csv", header=TRUE)
DT        <- data.table(activity)
DT$steps  <- as.integer(DT$steps)
DT$day    <- as.Date(activity$date,"%Y-%m-%d")

### Q1

SSet <- DT[ DT$steps != 0
            ,list(
                sum    = sum(steps,na.rm=TRUE)
              , mean   = mean(steps,na.rm=TRUE) 
              , median = as.double( median(steps,na.rm=TRUE) )
            )
            ,by=day
            ]

def.par <- par(no.readonly = TRUE)

layout( matrix( c(1, 1, 2, 3), 2, 2, byrow = TRUE) )

plot( x = SSet$day , type = "h", xlab = "Day", 
      y = SSet$sum , ylab = "Sum Steps", col="red",
      main = "Number of Steps by day")

plot( x = SSet$day, type = "h", xlab = "Day", 
      y = SSet$mean , ylab = "Mean Steps" , ylim=c(0, 300), col="green",
      main = "Mean Steps by day")

plot( x = SSet$day, type = "h", xlab = "Day", 
      y = SSet$median , ylab = "Median Steps" , ylim=c(0, 300), col="blue",
      main = "Median Steps by day")

par(def.par)

### Q2
# Mean of Steps by Interval

SSet2 <- DT[ DT$steps != 0
            ,list( 
              AvgSteps = mean(steps,na.rm=TRUE) )
            ,by=interval
            ]

plot( x = SSet2$interval,  type = "h", xlab = "5-minute Interval", 
      y = SSet2$AvgSteps,  ylab = "Mean Steps", col="blue",
      main = "Mean of Steps by Interval")

print("Average Maximun Number of steps by Interval:" )
print(SSet2[SSet2$AvgSteps == max(SSet2$AvgSteps)])

### Q3

# Calculate and report the total number of missing values in the dataset (i.e. the total number of rows with NAs)

NewDT <- data.table(DT)

print( dim( NewDT[ is.na(NewDT$steps) ] )[1] )

# 
# Devise a strategy for filling in all of the missing values in the dataset. The strategy does not need to be sophisticated. For example, you could use the mean/median for that day, or the mean for that 5-minute interval, etc.
# 
# Create a new dataset that is equal to the original dataset but with the missing data filled in.
# 

# NewDT$steps <- ifelse( is.na(NewDT$steps), 
#                        SSet2$AvgSteps[ NewDT$interval ], 
#                        NewDT$steps 
#                       )

# Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day. Do these values differ from the estimates from the first part of the assignment? What is the impact of imputing missing data on the estimates 


