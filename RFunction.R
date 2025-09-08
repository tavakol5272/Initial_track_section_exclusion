library(move2)
library(dplyr)
library(lubridate)

### app
initial_exclusion <- function(data, amount, unit = c("days","weeks","months")) {
  unit <- match.arg(unit)
  add_time <- switch(unit,
                     "days"   = days(amount),
                     "weeks"  = weeks(amount),
                     "months" = months(amount)
  )
  
  data %>%
    group_by(mt_track_id()) %>%
    arrange(.data$timestamp, .by_group = TRUE) %>%
    mutate(
      start_time = if (all(is.na(timestamp))) NA_real_ else min(timestamp, na.rm = TRUE),
      cutoff     = start_time + add_time
    ) %>%
    filter(!is.na(timestamp) & timestamp >= cutoff) %>%
    ungroup()
}


clean_data <- initial_exclusion(mv, amount = 3, unit = "days")