# -*- coding: utf-8 -*-
"""
Created on Thu Oct 27 15:03:48 2022

@author: cleme
"""

- Readme file with your plan, approaches and summary :
    
1. uploading the file 


2. Plan :
    check for missing data using ".isna()"
        
         --> we can see that data is missing from at least each column, but by checking the data we see that row 7 is responsible
         --> after running isna() once again, we can see that we now only have missing data in BirthYear and Profession, as well as the whole Unnamed 7 column that we wil drop too
    
    check for duplicate
    
        --> data.duplicated().any() return nothing for dupliacted row
        --> looking further there is the columned unnamed: 8 that seems to be a mistake while trying to copy the transactions ID, we will drop it too
    
    check for variance and outliers using ".describe"
    
        standard deviation = 0 fro deviation, meaning that it's not relevant for our analysis
         --> meaning we can drop the column
         --> we can observe an outlier in the column amount because the max is way above everything else
         we will then drop it and replace it wit the mean of the column
        
        in the birthyear column we can see, two outlier in 2015 and 2017 except they are registered as barman and driver which makes it impossible and is most probably an error
        --> we will drop them too
        
    Now that everything else is completed we can fill the 4 missing values from earlier, after a quick glance we can see that those row with empty data where about a customerID that used and was complete earlier we will then use the same informations for the missing values
    