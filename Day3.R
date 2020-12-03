### IMPORT + FORMAT DATA ###
setwd("~/Other/Programming/Advent of code/2020/Data")
hill <- read.table(text = gsub("#", "T", readLines("Day3data.txt")),
                   sep = "",
                   stringsAsFactors = FALSE)
# Change to vector for ease of use
hill <- hill$V1

# Dimensions of hill
height <- length(hill)
width <- nchar(hill[1])

move <- function(posn, r, d) {
  # DESCRIPTION #
  # Performs individual moves down the slope
  
  # PARAMETERS #
  # posn: current position (vector, length 2)
  # r, d: number of tiles right/down to be moved
  
  # RETURNS #
  # position after moving (vector, length 2)
  
  
  
  return(
    c(
      ( (posn[1] + r - 1) %% width ) + 1,
      posn[2] + d
    )
  )
}


### PART 1 ###
SlopeTrees <- function(R, D) {
  # DESCRIPTION #
  # Given a step size, calculates # of trees encountered throughout the whole journey
  
  # PARAMETERS #
  # R, D: The number of squares Right and Down we are to travel each step
  
  # RETURNS #
  # Number of trees encountered along path
  
  
  
  # Initialise
  posn <- c(1, 1)
  numTrees <- 0
  
  # Go down slope, checking for trees
  repeat {
    # Move:
    posn <- move(posn, R, D)
    
    # Check for tree at current location:
    if (substr(hill[posn[2]], posn[1], posn[1]) == "T") {
      numTrees <- numTrees + 1
    }
    
    # Check if at end of slope yet:
    if (posn[2] + D > height) break
  }
  
  return(numTrees)
}

print(SlopeTrees(3, 1))


### PART 2 ###

TreeProd <- SlopeTrees(1, 1)
TreeProd <- TreeProd * SlopeTrees(3, 1)
TreeProd <- TreeProd * SlopeTrees(5, 1)
TreeProd <- TreeProd * SlopeTrees(7, 1)
TreeProd <- TreeProd * SlopeTrees(1, 2)

print(TreeProd)
