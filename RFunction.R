library(move2)
library(dplyr)
library(lubridate)
library(sf)
library(logger)

data <- readRDS("./data/raw/input3_move2loc_LatLon.rds")

select_unit <- function(choices = c("day","week","month"),
                        title   = "Choose a time unit") {
  utils::select.list(choices, multiple = FALSE, title = title)
}

time_unit <- select_unit()   
amount <- as.integer(readline("Number of Units (integer): "))
if (is.na(amount) || amount %% 1 != 0) logger::log_warn("Number of units is not an integer or is missing")


time_function <- function(amount, time_unit ) {

  switch(time_unit,
         day   = lubridate::days(amount),
         week  = lubridate::weeks(amount),
         month = lubridate::dmonths(amount))
}

add_time <- time_function(amount, time_unit)
add_time
# Exclude function
#rFunction = function(
ex_function = function(data, add_time) { 
  
  cut_data <- data %>%
    group_by(mt_track_id()) %>%
    mutate(new_first_time = min(mt_time(), na.rm = TRUE) + add_time) %>%
    ungroup()%>%
    filter(mt_time() >= new_first_time) %>%
    select(-new_first_time)
    
  if (is.null(cut_data) || nrow(cut_data) == 0L) {
    logger::log_warn("All data were removed")
  }
  
  
  print_table <- data %>%
    group_by( tarck_id = mt_track_id()) %>%
    summarise(old_start_time = min(mt_time(), na.rm = TRUE), .groups = "drop") %>%
    mutate(new_start_time = old_start_time + add_time) %>%
    st_drop_geometry() %>% 
    select(tarck_id, old_start_time, new_start_time)
  #print(print_table)
  
  
  return(list(data = cut_data , summary_table = print_table  ))
  
}




out_put <- ex_function(data, add_time)

print(out_put$summary_table)
#head(out_put$data, 5)

