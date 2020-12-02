expenses <- scan("Day1data.txt")
n <- length(expenses)

for (i in 1:(n-1)) {
  for (j in (i+1):n) {
    if (expenses[i] + expenses[j] == 2020) {
      print(expenses[i] * expenses[j])
    }
  }
}

for (i in 1:(n-2)) {
  for (j in (i+1):(n-1)) {
    for (k in (j+1):n) {
      if (expenses[i] + expenses[j] + expenses[k] == 2020) {
        print(expenses[i] * expenses[j] * expenses[k])
      }
    }
  }
}
