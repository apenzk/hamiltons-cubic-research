# I73 (c), n = 12, p = 14: every structure of the 16 smallest angle values, as M = L(H1) + 2 D(H2) with
# H1 (single gaps), H2 (doubled pairs), F (free pairs, |F| = |H2| - 1) splitting K6, every vertex touched.
# Prints the least eigenvalue per |H2|; the minimum is 4 - 2 sqrt 3 at |H2| = 1. /usr/bin/python3, about a minute.
# exact enumeration: K6 edges split into H2 (doubled, G2 edges), F (free, G2-1 edges), H1 (rest, single gaps);
# M = L(H1) + 2 D(H2); every vertex touched by H1 u H2; report min lambda_min per G2
import numpy as np, itertools
E=list(itertools.combinations(range(6),2))
best={}
for G2 in range(1,9):
    mins=9; arg=None; mats=[]; keys=[]
    for H2 in itertools.combinations(range(15),G2):
        rest=[k for k in range(15) if k not in H2]
        for F in itertools.combinations(rest,G2-1):
            H1=[k for k in rest if k not in F]
            touched=set()
            for k in list(H1)+list(H2): touched|=set(E[k])
            if len(touched)<6: continue
            M=np.zeros((6,6))
            for k in H1:
                i,j=E[k]; M[i,i]+=1; M[j,j]+=1; M[i,j]-=1; M[j,i]-=1
            for k in H2:
                i,j=E[k]; M[i,i]+=2; M[j,j]+=2
            mats.append(M); keys.append((H2,F))
            if len(mats)==200000:
                ev=np.linalg.eigvalsh(np.array(mats))[:,0]; k=ev.argmin()
                if ev[k]<mins: mins=ev[k]; arg=keys[k]
                mats=[]; keys=[]
    if mats:
        ev=np.linalg.eigvalsh(np.array(mats))[:,0]; k=ev.argmin()
        if ev[k]<mins: mins=ev[k]; arg=keys[k]
    print(G2, round(mins,6), [E[k] for k in arg[0]], [E[k] for k in arg[1]], flush=True)
print('4-2sqrt3 =',4-2*np.sqrt(3))
