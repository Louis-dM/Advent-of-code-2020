### IMPORT + FORMAT DATA ###
setwd("~/Other/Programming/Advent of code/2020/Data")
# read in data and substitute 1s/0s in place of letters
rawdata <- gsub("F|L", 0,
                gsub("B|R", 1,
                               readLines("Day5data.txt")
                     )
                )
n <- nrow(BPs)
BPs <- matrix(0, nrow = n, ncol = 10) # set up matrix for data
for (i in 1:n) {
  BPs[i,] <- as.integer(unlist(strsplit(rawdata[i], split = ""))) # split strings and fill matrix
}


### FUNCTIONS ###
BProw <- function(BP) {
  # DESCRIPTION #
  # Takes a single Boarding Pass and gives the row number
  
  # PARAMETERS #
  # BP: Vector of length 10. First 7 digits correspond to Row number, last 3 are column number.
  
  # RETURNS #
  # Row number
  
  
  return(sum(BP[1:7] * 2^(6:0)))
}


BPcol <- function(BP) {
  # DESCRIPTION #
  # Takes a single Boarding Pass and gives the column number
  
  # PARAMETERS #
  # BP: Vector of length 10. First 7 digits correspond to Row number, last 3 are column number.
  
  # RETURNS #
  # Column number
  
  
  return(sum(BP[8:10] * 2^(2:0)))
}


BPseat <- function(r, c) {
  # DESCRIPTION #
  # Takes a row and column number and returns the seat ID
  
  # PARAMETERS #
  # r: row number
  # c: column number
  
  # RETURNS #
  # Seat ID
  
  
  return(r*8 + c)
}


### PART 1 ###
seatIDs <- numeric(n)

for (i in 1:n) {
  seatIDs[i] <- BPseat(BProw(BPs[i,]),
                       BPcol(BPs[i,])
                       )
}
max(seatIDs)


### PART 2 ###
min(seatIDs[as.logical(1 - ((seatIDs+1) %in% seatIDs))]) + 1
# A much-needed explanation:
# The inner part checks which seats have the following seat missing
# It does this by checking which seats have the following seat *present*, and doing as.logical(1 - x)
# There should only be two: the highest seat number, and 1 less than your seat number
# So, take the minimum of these and add 1
