"""r1847 screen: post F81 witness, E(M0) against t^2 - sum_{e in M0} a_e^2 (the matching inequality's slack), and J_{M0}. Run: sage -python review_r1847_f81.py m"""
import numpy as np, itertools, sys
m=int(sys.argv[1]); n=2*m
pairs=list(itertools.combinations(range(n),2)); idx={p:i for i,p in enumerate(pairs)}; N=len(pairs)
P_=set(range(m)); al,be=-m,(m-1)
W=np.zeros((N,N))
for I,(a,b) in enumerate(pairs):
    W[I,I]=al if ({a,b}<=P_ or not ({a,b}&P_)) else be
print("Ricci-free check trace:",np.trace(W))
# rotate by pi/4 in planes (k, m+k)
Rn=np.eye(n); c=s=1/np.sqrt(2)
for k in range(m):
    p,q=k,m+k; Rn[p,p]=c; Rn[q,q]=c; Rn[p,q]=-s; Rn[q,p]=s
L=np.zeros((N,N))
for I,(a,b) in enumerate(pairs):
    for J,(c_,d) in enumerate(pairs):
        L[I,J]=Rn[a,c_]*Rn[b,d]-Rn[a,d]*Rn[b,c_]
W=L@W@L.T; W/=np.linalg.norm(W)
def g(a,b,c,d):
    s=1
    if a>b: a,b=b,a; s=-s
    if c>d: c,d=d,c; s=-s
    return s*W[idx[(a,b)],idx[(c,d)]]
t2=sum(W[i,i]**2 for i in range(N))
M0=[(k,m+k) for k in range(m)]
E=0; Jmax=0
for e,f in itertools.combinations(M0,2):
    (i,j),(k,l)=e,f; E+=(g(i,k,j,l)+g(i,l,j,k))**2; Jmax=max(Jmax,abs(g(i,j,k,l)))
aM=sum(g(i,j,i,j)**2 for (i,j) in M0)
print("n=%d t2=%.6f (1/n=%.6f)  E(M0)=%.6f  t2-sum a_e^2=%.6f  max|J_M0|=%.2e"%(n,t2,1/n,E,t2-aM,Jmax))
