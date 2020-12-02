setwd("~/Other/Programming/Advent of code/2020/Data")
expenses <- scan("Day1data.txt")
n <- length(expenses)


### PART 1 ###
part1 <- function() {
  for (i in 1:(n-1)) {
    for (j in (i+1):n) {
      if (expenses[i] + expenses[j] == 2020) {
        return(expenses[i] * expenses[j])
      }
    }
  }
}
part1()


### PART 2 ###
part2 <- function() {
  for (i in 1:(n-2)) {
    for (j in (i+1):(n-1)) {
      for (k in (j+1):n) {
        if (expenses[i] + expenses[j] + expenses[k] == 2020) {
          return(expenses[i] * expenses[j] * expenses[k])
        }
      }
    }
  }
}
part2()
