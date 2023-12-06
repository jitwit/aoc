import numpy as np

X = []
for l in open('../../input/2023/4.in','r').readlines():
    t = " ".join(l.split()[2:]).split('|')
    [a,b] = [ [ int(y) for y in x.split() ] for x in t ]
    X.append(len(set(a) & set(b)))
print(sum(2**(np.array(X)) >> 1))

Y = [1]*len(X)
for i,x in enumerate(X):
    for j in range(i,x+i):
        Y[j+1] += Y[i]
print(sum(Y))
