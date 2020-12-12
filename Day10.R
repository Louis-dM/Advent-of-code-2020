### IMPORT + FORMAT DATA ###
setwd("~/Other/Programming/Advent of code/2020/Data")
adaptors <- sort(as.integer(readLines("Day10data.txt"))) # sort data while importing
# let's also add the power supply and the device's built-in adaptor
adaptors <- c(0, adaptors, adaptors[length(adaptors)] + 3)


### PART 1 ###

diffs <- function(ratings) {
  # DESCRIPTION #
  # Given a list of joltage ratings, returns how many 1-, 2- and 3-joltage gaps there are
  
  # PARAMETERS #
  # ratings: a *sorted* list of joltage ratings for adaptors, with gaps of size 1-3 (no more, no less)
  
  # RETURNS #
  # c(# of 1-gaps, # of 2-gaps, # of 3-gaps)
  
  
  gaps <- numeric(3)
  
  for (i in 1:(length(ratings) - 1)) {
    gap <- ratings[i+1] - ratings[i] # calculate size of gap to next number up
    gaps[gap] <- gaps[gap] + 1 # add to the tally of gap sizes
  }
  
  return(gaps)
}

adaptordiffs <- diffs(adaptors)
print(adaptordiffs[1] * adaptordiffs[3])


### PART 2 ###

waystoreach <- numeric(length(adaptors)) # this will contain the # of ways to reach each joltage
waystoreach[adaptors == 0] <- 1 # start out by saying there's 1 way to reach 0

# let's manually find how many ways there are to reach 1 and 2 so we dont get errors when subtracting 3
# (there are adaptors of both voltages so this is ok. doing this "properly" would be a massive pain
#  since you'd have to do 3 checks for two numbers thanks to how r handles empty vectors) 
waystoreach[adaptors == 1] <- waystoreach[adaptors == 0]
waystoreach[adaptors == 2] <- waystoreach[adaptors == 0] + waystoreach[adaptors == 1]

# now we can check everything else
for (i in 4:length(adaptors)) {
  # find number of ways to reach i-3, i-2, i-1, and add them, jump-up-stairs-problem style
  for (j in 1:3) {
    if ((adaptors[i] - j) %in% adaptors) {
      waystoreach[i] <- waystoreach[i] + waystoreach[adaptors == adaptors[i] - j]
    }
  }
}

# have to stop R using scientific notation for displaying numbers this big, stupid data language
format(waystoreach[length(adaptors)], scientific = FALSE)