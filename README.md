# Initial Track section exclusion

MoveApps

Github repository: *https://github.com/tavakol5272/Initial_track_section_exclusion*

## Description
Removes data from the beginning of each track for the specified time unit and amount.

## Documentation
Capturing and tagging animals can influence their behavior after release. 
To account for this, the app allows excluding the initial part of each track so that potentially altered behavior is removed from subsequent analyses.
The user can specify the exclusion window by selecting a time unit (day, week, or month) and the number of units. 
The app determines the start time from the timestamp variable, adds the chosen number of days, weeks, or months to this point, and keeps only the data recorded after this new cutoff for each animal.
After running the app, a summary table is displayed showing, for each track, how many records were kept and how many were excluded.
Notes:
-One week is considered as 7 days.
-Months are converted into seconds (approximate duration of 30 days each) before being added.

### Application scope
#### Generality of App usability
This App can be used with any species or taxonomic group as long as the data include timestamps and track IDs.


#### Required data properties
*State here the required and/or optimal data properties for this App to perform properly.*

*Examples:*

This App is only applicable to data that reflect range resident behavior. 

The data should have a fix rate of at least 1 location per 30 minutes. 

The App should work for any kind of (location) data.

### Input type
*Indicate which type of input data the App requires.*

*Example*: `move2::move2_loc`

### Output type
*Indicate which type of output data the App produces to be passed on to subsequent Apps.*

*Example:* `move2::move2_loc`

### Artefacts
*If the App creates artefacts (e.g. csv, pdf, jpeg, shapefiles, etc), please list them here and describe each.*

*Example:* `rest_overview.csv`: csv-file with Table of all rest site properties

### Settings 
*Please list and define all settings/parameters that the App requires to be set by the App user, if necessary including their unit. Please first state the Setting name the user encounters in the Settings menu defined in the appspecs.json, and between brackets the argument used in the R function to be able to identify it quickly in the code if needed.*

*Example:* `Radius of resting site` (radius): Defined radius the animal has to stay in for a given duration of time for it to be considered resting site. Unit: `metres`.

### Changes in output data
*Specify here how and if the App modifies the input data. Describe clearly what e.g. each additional column means.*

*Examples:*

The App adds to the input data the columns `Max_dist` and `Avg_dist`. They contain the maximum distance to the provided focal location and the average distance to it over all locations. 

The App filterers the input data as selected by the user. 

The output data is the outcome of the model applied to the input data. 

The input data remains unchanged.

### Most common errors
*Please describe shortly what most common errors of the App can be, how they occur and best ways of solving them.*

### Null or error handling
*Please indicate for each setting as well as the input data which behaviour the App is supposed to show in case of errors or NULL values/input. Please also add notes of possible errors that can happen if settings/parameters are improperly set and any other important information that you find the user should be aware of.*

*Example:* **Setting `radius`:** If no radius AND no duration are given, the input data set is returned with a warning. If no radius is given (NULL), but a duration is defined then a default radius of 1000m = 1km is set. 
