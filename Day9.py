### INPUT ###

with open('Data\Day9data.txt') as file:
    XMAS = [int(n) for n in file.read().split('\n')[:-1]]

N = len(XMAS)


### FUNCTIONS ###

def xmascheck(pre, xmas):
    '''
    
    Parameters
    ----------
    pre : length of preamble
    xmas : XMAS encryption file

    Returns
    -------
    List of numbers which are not valid in the xmas file

    '''
    
    invalid = [] # to be returned after filling with invalid numbers
    
    for i in range(pre, N):
        # lets have a variable for checking if xmas[i] is valid or not
        valid = False
        # can we find a way around this with stuff like pass/break?
        # because i know this is bad
        
        for j in range(pre):
            if xmas[i] - xmas[i - (j+1)] in xmas[i-pre:i]:
                valid = True
        
        if valid == False:
            invalid.append(xmas[i])
    
    return(invalid)


### DAY 1 ###

weakness = xmascheck(25, XMAS)[0]
print(weakness)


### DAY 2 ###

def foo():
    # returns first/last values in the sum
    # made it a function because its the easiest way to get out of loops when you're done with them
    
    for i in range(N): # XMAS[i] is the first value in the sum
        for j in range(i, N): # XMAS[j-1] is the last value in the sum
            if sum(XMAS[i:j]) == weakness:
                return([min(XMAS[i:j]), max(XMAS[i:j])])
           
print(sum(foo()))