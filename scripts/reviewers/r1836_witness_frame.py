"""r1836 check: the unit S^6 x S^6 product rotated by pi/4 in the planes (k,6+k), the frame the I121 visibility screen reports as 'the witness'. Prints t^2, pair mass, four-set mass and E(M0) for M0={(k,6+k)} in that frame, to test whether the frame is globally maximal (the matching inequality's hypothesis). Also checks the per-block Hadamard identity behind the sharper constant. Seconds. Run: sage -python r1836_witness_frame.py"""
import numpy as np, itertools
p=q=6; n=p+q
pairs=list(itertools.combinations(range(n),2)); idx={pr:i for i,pr in enumerate(pairs)}; N=len(pairs)
Nn=(n-1)*(n-2); al=q*(q-1)/Nn; be=-(p-1)*(q-1)/Nn; ga=p*(p-1)/Nn
E=np.zeros((N,N))
for (a,b),i in idx.items(): E[i,i]= al if (a<p and b<p) else (ga if (a>=p and b>=p) else be)
E/=np.linalg.norm(E)
g=np.eye(n)
for k in range(p):
    c=s=np.sqrt(0.5); R=np.eye(n); a,b=k,p+k; R[a,a]=c; R[b,b]=c; R[a,b]=-s; R[b,a]=s; g=R@g
L=np.zeros((N,N))
for (a,b),col in idx.items():
    for (x,y),row in idx.items(): L[row,col]=g[x,a]*g[y,b]-g[y,a]*g[x,b]
W=L@E@L.T
def w(a,b,c,d):
    s=1
    if a>b: a,b=b,a; s=-s
    if c>d: c,d=d,c; s=-s
    return s*W[idx[(a,b)],idx[(c,d)]]
t2=sum(W[i,i]**2 for i in range(N)); pair=0; four=0
for (a,b),i in idx.items():
    for (c,d),j in idx.items():
        if i==j: continue
        k=len({a,b,c,d})
        if k==3: pair+=W[i,j]**2
        else: four+=W[i,j]**2
M0=[(k,p+k) for k in range(p)]
EM=sum((w(i,k,j,l)+w(i,l,j,k))**2 for (i,j),(k,l) in itertools.combinations(M0,2))
print(f"norm={np.linalg.norm(W):.6f} t2={t2:.6f} pair={pair:.6f} four={four:.6f} E(M0)={EM:.6f} fraction={EM/four:.6f}")
# Hadamard: sum of the three quarter-squared sign combinations = |m|^2 - (sum m)^2/4
rng=np.random.default_rng(1); m=rng.standard_normal(4)
h=[(1,-1,-1,1),(1,-1,1,-1),(1,1,-1,-1)]
print("hadamard residual", sum(np.dot(x,m)**2 for x in h)/4-(m@m-m.sum()**2/4))
