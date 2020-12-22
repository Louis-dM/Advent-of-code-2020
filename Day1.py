### INPUT ###

with open('Data\Day1data.txt') as file:
    expenses = [int(n) for n in file.read().split('\n')[:-1]]

N = len(expenses)


### PART 1 ###

def expcheck2(total):
    for i in range(N):
        n = expenses[i]
        for j in range(i+1, N):
            m = expenses[j]
            if n + m == total:
                return(n*m)
            
    return("Error")
            
print(expcheck2(2020))


### PART 2 ###

def expcheck3(total):
    for i in range(N):
        n = expenses[i]
        for j in range(i+1, N):
            m = expenses[j]
            for k in range(j+1, N):
                l = expenses[k]
                if n + m + l == total:
                    return(n*m*l)
           
    return("Error")

print(expcheck3(2020))
