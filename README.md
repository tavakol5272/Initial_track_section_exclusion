# Initial Track section exclusion

MoveApps

Github repository: *https://github.com/tavakol5272/Initial_track_section_exclusion*

## Description
Removes data from the beginning of each track for the specified "Time Unit" and "Number of Units".

## Documentation
Capturing and tagging animals can influence their behavior after release. 
To account for this, the app allows excluding the initial part of each track so that potentially altered behavior is removed from subsequent analyses.
The user can specify the exclusion time by selecting a time unit (day, week, or month) and the number of units. 
For each track, the app:
-finds the first timestamp,
-adds a user-chosen time (e.g. 14 days, 2 weeks, 3 months) and creates the new_start_time
-removes all locations before new_start_time,
-returns the trimmed dataset and a summary table(showing track_id, the old and new start time)
The app determines the start time from the timestamp variable, adds the chosen number of days, weeks, or months to this point, and keeps only the data recorded after this new start date for each animal.
After running the app, a summary table is displayed showing, for each track, the old start time and new start time after trimmed the data.
Notes:
-One week is considered as 7 days.
-Months are converted into seconds (approximate duration of "2629800 seconds ≈ 30.4375 days ~4.35 weeks") before being added.

### Application scope
#### Generality of App usability
This app is species-agnostic and works for any Movebank study where you want to exclude the initial post-release period. It trims per track (typically per deployment) based on each track’s first timestamp.


#### Required data properties
The App should work for any kind of (location) data.

### Input type
`move2::move2_loc

### Output type
`move2::move2_loc

### Artefacts
this app return the new data set that contains all the data after the new start date. It also prints a summary table showing for each track, the old and new start time.

### Settings 
`Choose a time unit`: Defined the unit of time that you want to consider in exclusion. Dropdown with: day, week, or month.

`Number of Units (integer):`:A non-negative integer specifying how many units to exclude from the start of each track.


### Changes in output data
it removes all the data before the new start time



### Most common errors
`All data were removed`: When The new_start_time  is later than the last timestamp for every track, The trimmed dataset is empty and a warning is shown.Fix: Use a smaller Number of units or a shorter Time unit.
`Number of units is not an integer or is missing`:when enter the non integer for "Number of Units" trimming fails. Fix: Provide a non-negative integer (0 keeps data unchanged).

### Null or error handling
