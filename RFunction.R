library(move2)
library(dplyr)
library(lubridate)

test_data <- readRDS("./data/raw/input2_move2loc_LatLon.rds")
# class(test_data)
# dim(test_data)
# names(test_data)
# str(test_data)
# head(test_data)
# mt_time(test_data)[1:10]        
# mt_track_id(test_data)[1:10] 



# Exclude function
#rFunction = function(data, amount, unit = c("days","weeks","months")) {
ex_function = function(data, amount, unit = c("days","weeks","months")) { 
  unit <- match.arg(unit)
  
  # start time
  tm <- mt_time(data) 
  head(tm)
  
  ids <- as.character(mt_track_id(data)) 
  
  valid <- !is.na(ids) & !is.na(tm)
  
  tz <- attr(tm, "tzone"); if (is.null(tz)) tz <- "UTC"
  
  starts_num <- tapply(tm[valid], ids[valid], min)
  start_day  <- as.POSIXct(starts_num, origin = "1970-01-01", tz = tz)
  start_row  <- start_day[ids]
  
  ###############just for checking:############################
  ends_num <- tapply(tm[valid], ids[valid], max)
  end_day  <- as.POSIXct(ends_num, origin = "1970-01-01", tz = tz)
  
  
  d <- data.frame(
    track_id = names(start_day),
    start    = as.POSIXct(start_day, origin = "1970-01-01", tz = tz),
    end      = as.POSIXct(end_day,   origin = "1970-01-01", tz = tz),
    span_hrs = as.numeric(difftime(end_day, start_day, units = "hours")),
    row.names = NULL
  )
  
  d[order(d$span_hrs, decreasing = TRUE), ]
  
  ####################################################
  
  
  add_time <- switch(unit,
                     "days"   = lubridate::days(amount),          
                     "weeks"  = lubridate::weeks(amount),         
                     "months" = lubridate::dmonths(amount)         
  )
  
  
  cutoff <- start_row + add_time
  keep   <- !is.na(tm) & !is.na(cutoff) & (tm >= cutoff)
  
  result <- data[keep, ]
  
  return(result)
}

r <- ex_function(data = test_data, amount = 5, unit = "days")
head(mt_time(r),20)



