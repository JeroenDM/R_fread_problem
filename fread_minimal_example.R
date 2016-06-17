setwd("C:/Users/jeroen.demaeyer/Documents/R/fread_problem")

library(data.table)

mydf <- fread("data.csv", sep=";", dec=",", data.table = F, verbose = T)


# Warning messages:
#   1: In fread(filename, sep = ";", dec = ",", data.table = F) :
#   Bumped column 23 to type character on data row 565, field contains '-0,0'. Coercing previously read values in this column from logical, integer or numeric back to character which may not be lossless; e.g., if '00' and '000' occurred before they will now be just '0', and there may be inconsistencies with treatment of ',,' and ',NA,' too (if they occurred in this column before the bump). If this matters please rerun and set 'colClasses' to 'character' for this column. Please note that column type detection uses the first 5 rows, the middle 5 rows and the last 5 rows, so hopefully this message should be very rare. If reporting to datatable-help, please rerun and include the output from verbose=TRUE.

fileName <- 'data.csv'
pureString <- readChar(fileName, file.info(fileName)$size)
library(stringr)
newString <- str_replace_all(pureString, ",", ".")
write(newString, file ="data_decimal_point.csv")

mydf2 <- fread("data_decimal_point.csv", sep=";", dec=".", data.table = F, verbose = T)
