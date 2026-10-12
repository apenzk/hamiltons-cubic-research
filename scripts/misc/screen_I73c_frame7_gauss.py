import numpy as np
rng=np.random.default_rng(1)
def ip(A,B): return 0.5*np.trace(A.T@B)
def T(X): return sum(ip(X[i]@X[j]-X[j]@X[i],X[i]@X[j]-X[j]@X[i]) for i in range(7) for j in range(7) if i!=j)
def ident(X):
    Q=[-x@x for x in X]; S={}
    tot=0
    for i in range(7):
        for j in range(7):
            if i==j: continue
            Sij=X[i]@X[j]+X[j]@X[i]
            tot+=np.trace(Q[i])*np.trace(Q[j])+2*np.trace(Q[i]@Q[j])-0.5*np.sum(Sij**2)
    return tot-168
def bound(X):
    P=sum(-x@x for x in X); ev=np.linalg.eigvalsh(P); d=int((ev>1e-9).sum()); r=min(7,d-1)
    return (1-1/r)*(196+2*np.trace(P@P))-168, np.trace(P@P), d
def randframe(n):
    A=rng.standard_normal((7,n,n)); A=A-A.transpose(0,2,1)
    M=np.array([a[np.triu_indices(n,1)] for a in A]).T
    q,_=np.linalg.qr(M); X=[]
    for k in range(7):
        B=np.zeros((n,n)); B[np.triu_indices(n,1)]=q[:,k]; B=B-B.T; X.append(B)
    return X
worst=0
for n in [5,6,7,8,10,12]:
    for t in range(200):
        X=randframe(n); a=T(X); b=ident(X); bb=bound(X)[0]
        assert abs(a-b)<1e-8, (a,b)
        worst=max(worst,a-bb)
print("identity ok; max T-bound over random:",worst)
# octonion
import itertools
tri=[(1,2,3),(1,4,5),(1,7,6),(2,4,6),(2,5,7),(3,4,7),(3,6,5)]
m=np.zeros((8,8,8))
for i in range(8): m[0,i,i]=1;m[i,0,i]=1
for i in range(1,8): m[i,i,0]=-1
for (a,b,c) in tri:
    for (x,y,z) in [(a,b,c),(b,c,a),(c,a,b)]:
        m[x,y,z]=1; m[y,x,z]=-1
L=[m[i].T for i in range(1,8)]  # L_i e_j = e_i e_j
L=[0.5*l for l in L]
print("octonion T",T(L),"bound",bound(L))
