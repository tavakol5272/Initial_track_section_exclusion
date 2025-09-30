library(move2)
library(dplyr)
library(lubridate)
library(sf)



rFunction <-  function(data, amount, time_unit=c("day","week","month")) {
  
  time_function <- function(amount, time_unit ) {
    switch(time_unit,
           day   = lubridate::days(amount),
           week  = lubridate::weeks(amount),
           month = lubridate::dmonths(amount))
  }
  
  add_time <- time_function(amount, time_unit)
  
  
  cut_data <- data %>%
    group_by(mt_track_id()) %>%
    mutate(new_first_time = min(mt_time(), na.rm = TRUE) + add_time) %>%
    ungroup()%>%
    filter(mt_time() >= new_first_time) %>%
    select(-new_first_time)
  
  
  if(!any(is.null(cut_data) || nrow(cut_data) == 0L)){
    print_table <- data %>%
      group_by( tarck_id = mt_track_id()) %>%
      summarise(old_start_time = min(mt_time(), na.rm = TRUE),
                new_track_duraction_days = round(difftime(mt_time()[n()],mt_time()[1]+add_time, "days"),2),
                .groups = "drop") %>%
      mutate(new_start_time = old_start_time + add_time) %>%
      st_drop_geometry() %>% 
      select(tarck_id, old_start_time, new_start_time, new_track_duraction_days)
    
    logger.info(paste0("You removed the first ",amount," ", time_unit, " of each track."))
    print(print_table)
  }
  logger.info(paste0("Data from ",length(unique(mt_track_id(cut_data)))," out of ", length(unique(mt_track_id(data))), " tracks will be passed on to the next App."))
  if (is.null(cut_data) || nrow(cut_data) == 0L) {
    logger.warn("All data were removed. No data can be passed on to the next App")
  }
  
  
  
  if(!any(is.null(cut_data) || nrow(cut_data) == 0L)){
  print_table <- data %>%
    group_by( tarck_id = mt_track_id()) %>%
    summarise(old_start_time = min(mt_time(), na.rm = TRUE),
              new_track_duraction_days = round(difftime(mt_time()[n()],mt_time()[1]+add_time, "days"),2),
              .groups = "drop") %>%
    mutate(new_start_time = old_start_time + add_time) %>%
    st_drop_geometry() %>% 
    select(tarck_id, old_start_time, new_start_time, new_track_duraction_days)
  
  logger.info(paste0("You removed the first ",amount," ", time_unit, " of each track."))
  print(print_table)
  }
  logger.info(paste0("Data from ",length(unique(mt_track_id(cut_data)))," out of ", length(unique(mt_track_id(data))), " tracks will be passed on to the next App."))
  if (is.null(cut_data) || nrow(cut_data) == 0L) {
    logger.warn("All data were removed. No data can be passed on to the next App")
  }
  
  return(cut_data)
  
}
<<<<<<< HEAD
=======

>>>>>>> a78b2b2986e1397c4edc539284bd5f231ba97e67
