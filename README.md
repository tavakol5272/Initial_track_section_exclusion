# Initial Track Section Exclusion

MoveApps

Github repository: *https://github.com/tavakol5272/Initial_track_section_exclusion*

## Description
Removes data from the beginning of each track for a user specified period of time, e.g. 5 days. This is often useful if it is known that handling or tagging can affect the behavior of animals for a certain period of time.

## Documentation
Capturing and tagging animals can influence their behavior after release. To account for this, the app allows excluding the initial part of each track so that potentially altered behavior is removed from subsequent analyses.
The user can specify the exclusion time by selecting a time unit (day, week, or month) and the number of units. 

The app determines the start time from the timestamp variable, adds the chosen number of days, weeks, or months to this point, and keeps only the data recorded after this new start date for each animal.
After running the app, a summary table is displayed in the logs of the App, showing for each track, the old start time, the new start time after removing the initial segment, and the new duration of each track.

Notes:
- One week is considered as 7 days.
- Months are converted into seconds (approximate duration of "2629800 seconds ≈ 30.4375 days ~4.35 weeks") before being added.

### Application scope
#### Generality of App usability
This app is species-agnostic and works for any tracking study where you want to exclude the initial tracking period. It trims per track based on each track’s first timestamp.


#### Required data properties
The App should work for any kind of (location) data.

### Input type
`move2::move2_loc

### Output type
`move2::move2_loc

### Artefacts
none

### Settings 
`Choose a time unit`: Defined the unit of time that you want to consider in exclusion. Dropdown with: day, week, or month.

`Number of Units (integer):`:A non-negative integer specifying how many units to exclude from the start of each track.


### Changes in output data
The data set is reduced, it removes all the data before the new start time. If the period to remove is longer than the tracking duration, no data will be returned for that track.


### Most common errors
`All data were removed`: When The new_start_time  is later than the last timestamp for every track. The trimmed dataset is empty and a warning is shown. Fix: Use a smaller Number of units or a shorter Time unit.

### Null or error handling
