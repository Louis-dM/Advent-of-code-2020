library(stringr)

### IMPORT + FORMAT DATA ###
setwd("~/Other/Programming/Advent of code/2020/Data")

# we want to separate the data into four columns:
# min(restricted_letter), max(restricted_letter), restricted_letter, password
# to split up data by both "-" and " ", we sub in " " into every "-" and then use sep = " "
pws <- read.table(text = gsub("-", " ", readLines("Day2data.txt")),
                  sep = " ",
                  stringsAsFactors = FALSE)
# colons are still in col3 but we'll deal with them when we need to to avoid looping unnecessarily

n <- nrow(pws)


### PART 1 ###
count <- 0

for (i in 1:n) {
  # first, since we're in a loop anyway, let's fix the colons
  pws[i, 3] <- sub(":", "", pws[i, 3])
  
  # Now we check if there are the correct number of letters in the password
  letter <- pws[i, 3]
  nletter <- str_count(pws[i, 4], letter)
  if ((pws[i, 1] <= nletter) && (nletter <= pws[i, 2])) {
    count <- count + 1
  }
}
print(count)


### PART 2 ###
count <- 0

for (i in 1:n) {
  # my code isn't ugly right?
  pos1 <- pws[i, 1]
  pos2 <- pws[i, 2]
  letter <- pws[i, 3]
  pw <- pws[i, 4]
  
  # ok now everything is readable lets do this
  if (
    abs( (substr(pw, pos1, pos1) == letter) - (substr(pw, pos2, pos2) == letter) )
    # this works because 1 = TRUE and 0 = FALSE
  ) {
    count <- count + 1
  }
}
print(count)