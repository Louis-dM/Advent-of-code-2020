### IMPORT + FORMAT DATA ###
setwd("~/Other/Programming/Advent of code/2020/Data")
boot <- read.table(text = gsub("-", "- ",
                               gsub("\\+", "\\+ ",
                                    readLines("Day8data.txt"))),
                   sep = " ",
                   stringsAsFactors = FALSE)


### FUNCTIONS ###
updateACC <- function(acc, op, num) {
  # DESCRIPTION #
  # Originally designed to update the accumulator according to given instructions
  # However, it also serves to update the instruction line when a jump command is used
  
  # PARAMETERS #
  # acc: current value in accumulator OR current instruction line
  # op: operation ("+" or "-")
  # num: value by which accumulator OR current instruction line is to be updated by, in direction
  #      specified by op
  return(
    eval(
      parse(
        text = paste(
          toString(acc),
          op,
          toString(num)
        )
      )
    )
  )
}

read <- function(bootcode, acc, inst) {
  # DESCRIPTION #
  # takes current accumulator value and instruction line number and returns their updated values after
  # reading and parsing the current line of code
  
  # PARAMETERS #
  # bootcode: table of boot instructions
  # acc: current acumulator value
  # inst: current instruction line
  
  # RETURNS
  # c(updated accumulator value, updated boot code line)
  
  
  fn <- bootcode[inst, 1]
  sgn <- bootcode[inst, 2]
  num <- bootcode[inst, 3]
  
  if (fn == "nop") {
    return(c(acc,
             inst + 1))
  } else if (fn == "acc") {
    return(c(updateACC(acc,
                     sgn,
                     num),
             inst + 1))
  } else {
    return(c(acc,
             updateACC(inst,
                     sgn,
                     num)))
}

### PART 1 ###
ACC <- 0
instr <- 1
n <- nrow(boot)
visited <- numeric(n)

while (visited[instr] == 0) {
  visited[instr] <- 1
  # we can update accumulator and instruction line separately ONLY IF WE UPDATE THE ACCUMULATOR FIRST
  # (because instr affects the next update of ACC, but ACC does not affect the next update of instr)
  ACC <- read(boot, ACC, instr)[1]
  instr <- read(boot, ACC, instr)[2]
  }
}

print(ACC)



### PART 2 ###


######################### PART WHERE I WORK OUT HOW TO FIX THE BOOT CODE ##########################

###################################################################################################

runboot <- function(bootcode) {
  # DESCRIPTION #
  # Runs entire boot sequence and checks for errors (e.g. index oob or a loop)

  # PARAMETERS
  # bootcode: table of boot instructions
  
  # RETURNS
  # either "ERROR" if there is a loop or the index goes oob,
  # or the value of the accumulator if the code works
  
  
  # reset boot sequence
  ACC <- 0
  instr <- 1
  visited <- numeric(n)
  
  repeat {
    # check if we've left the range of instructions (or reached a loop) and act accordingly
    # order matters: the third check needs to be done after the first two
    if (instr > n+1) {
      return("ERROR")
    }
    if (instr == n+1) {
      return(ACC)
    }
    if (visited[instr] == 1) {
      return("ERROR")
    }
    
    # and if we haven't, carry on as normal
    visited[instr] <- 1
    
    ACC <- read(bootcode, ACC, instr)[1]
    instr <- read(bootcode, ACC, instr)[2]
  }
}

# Now we can loop through, changing each instruction and running the new versions of the code
for (i in 1:n) {
  newboot <- boot
  if (boot[i, 1] == "jmp") {
    newboot[i, 1] <- "nop" # make attempt to fix instruction
    result <- runboot(newboot) # run new boot code
    if (result != "ERROR") { # print result if code works
      print(result)
      break
    }
  } else if (boot[i, 1] == "nop") {
    newboot[i, 1] <- "jmp" # make attempt to fix instruction
    result <- runboot(newboot) # run new boot code
    if (result != "ERROR") { # print result if code works
      print(result)
      break
    }
  }
}
