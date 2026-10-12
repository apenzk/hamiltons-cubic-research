"""I121 screen: the double-rotation formula for the diagonal mass at (pi/4, pi/4), checked on random symmetric operators on Lambda^2 R^7. Run with sage -python (numpy). Gate 1 (b) for the working note reviews/2026-09-28-I121-MG-audit.md."""
import numpy as np, itertools
rng=np.random.default_rng(1); n=7
pairs=list(itertools.combinations(range(n),2)); idx={p:i for i,p in enumerate(pairs)}
def biv(g):  # action of g in O(n) on Lambda^2 in the basis e_a^e_b, a<b
    N=len(pairs); G=np.zeros((N,N))
    for (a,b),i in idx.items():
        for (c,d),j in idx.items():
            G[j,i]=g[c,a]*g[d,b]-g[d,a]*g[c,b]
    return G
def rot(n,i,j,th):
    g=np.eye(n); c,s=np.cos(th),np.sin(th); g[i,i]=c; g[j,j]=c; g[i,j]=-s; g[j,i]=s; return g
def E(R,a,b,c,d):
    sgn=1
    if a>b: a,b=b,a; sgn=-sgn
    if c>d: c,d=d,c; sgn=-sgn
    return sgn*R[idx[(a,b)],idx[(c,d)]]
worst=0
for trial in range(20):
    X=rng.standard_normal((len(pairs),)*2); R=X+X.T
    diag=lambda M: np.sum(np.diag(M)**2)
    g=rot(n,0,1,np.pi/4)@rot(n,2,3,np.pi/4); G=biv(g)
    change=diag(G@R@G.T)-diag(R)
    a=lambda i,j: E(R,i,j,i,j)
    v=E(R,0,2,1,3); w=E(R,0,3,1,2)
    box=a(0,2)-a(0,3)-a(1,2)+a(1,3)
    x12=lambda m: E(R,0,m,1,m); x34=lambda m: E(R,2,m,3,m)
    d12=lambda m:(a(0,m)-a(1,m))/2; d34=lambda m:(a(2,m)-a(3,m))/2
    out=[m for m in range(n) if m not in (0,1,2,3)]
    pred=((v+w)**2-box**2/4 + (x34(0)+x34(1))**2-(d34(0)+d34(1))**2 + (x12(2)+x12(3))**2-(d12(2)+d12(3))**2
          + 2*sum(x12(m)**2-d12(m)**2+x34(m)**2-d34(m)**2 for m in out))
    worst=max(worst,abs(change-pred)); 
print('max |change - formula| over 20 random symmetric operators, n=7:',worst)
