# fread problem with decimal character

I encountered a problem with a random component when reading a large data file with fread from the data.table package.
When loading the file some numeric data columns are into characters. Sadly the warning is only reproducable when using a big data file. Therefore I have added my minimal working example to a github repo.


    # set working directory to data.csv file location
    
    library(data.table)

    mydf <- fread("data.csv", sep=";", dec=",", data.table = F, verbose = T)
    
When running this example with a big data file I get the warning

    Warning message:
    In fread("data.csv", sep = ";", dec = ",", data.table = F, verbose = T) :
    Bumped column 16 to type character on data row 780, field contains '254,0'. Coercing previously read values in this column from logical, integer or numeric back to character which may not be lossless; e.g., if '00' and '000' occurred before they will now be just '0', and there may be inconsistencies with treatment of ',,' and ',NA,' too (if they occurred in this column before the bump). If this matters please rerun and set 'colClasses' to 'character' for this column. Please note that column type detection uses the first 5 rows, the middle 5 rows and the last 5 rows, so hopefully this message should be very rare. If reporting to datatable-help, please rerun and include the output from verbose=TRUE

The row number and data field for which this warning shows up changes every time I run the code. When setting verbose to true the following output is given before the warning:

    dec=',' but current locale ('C') has dec='.'. Attempting to change locale to one that has the desired decimal point.
    This R session's locale is now ' Dutch_Belgium.1252 ' which provides the desired decimal point for reading numerics in the file - success! The locale will be restored to what it was (' C ) even if the function fails for other reasons.
    Input contains no \n. Taking this to be a filename to open
    File opened, filesize is 0.000361 GB.
    Memory mapping ... ok
    Detected eol as \r\n (CRLF) in that order, the Windows standard.
    Positioned on line 1 after skip or autostart
    This line is the autostart and not blank so searching up for the last non-blank ... line 1
    Using supplied sep ';' ... found ok
    Detected 31 columns. Longest stretch was from line 1 to line 30
    Starting data input on line 1 (either column names or first row of data). First 10 characters: ta;Ubike;I
    All the fields on line 1 are character fields. Treating as the column names.
    Count of eol: 2818 (including 1 at the end)
    Count of sep: 84510
    nrow = MIN( nsep [84510] / ncol [31] -1, neol [2818] - nblank [1] ) = 2817
    Type codes (   first 5 rows): 1333333111133113313313333333311
    Type codes (+ middle 5 rows): 1333333111133113313313333333311
    Type codes (+   last 5 rows): 1333333111133113313313333333311
    Type codes: 1333333111133113313313333333311 (after applying colClasses and integer64)
    Type codes: 1333333111133113313313333333311 (after applying drop or select (if supplied)
    Allocating 31 column slots (31 - 0 dropped)
    Bumping column 16 from REAL to STR on data row 780, field contains '254,0'
    Read 2817 rows. Exactly what was estimated and allocated up front
       0.000s (  0%) Memory map (rerun may be quicker)
       0.000s (  0%) sep and header detection
       0.000s (  0%) Count rows (wc -l)
       0.000s (  0%) Column type detection (first, middle and last 5 rows)
       0.000s (  0%) Allocation of 2817x31 result (xMB) in RAM
       0.064s ( 96%) Reading data
       0.002s (  3%) Allocation for type bumps (if any), including gc time if triggered
       0.001s (  1%) Coercing data already read in type bumps (if any)
       0.000s (  0%) Changing na.strings to NA
       0.067s        Total
       
