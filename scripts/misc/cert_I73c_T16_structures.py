# I73 (c), n = 12, p = 14, L252's certificate, written by r1203 and reproduced by the author. /usr/bin/python3, about 20 s.
# Exact certificate: for every structure touching all six vertices, 2M - I is positive definite
# (all leading principal minors > 0, integer Bareiss in int64), so lambda_min(M) > 1/2 > tau.
import itertools, numpy as np
edges=list(itertools.combinations(range(6),2))
G=[];S=[]
for (i,j) in edges:
    g=np.zeros(6,dtype=np.int64); g[i]=1; g[j]=-1
    s=np.zeros(6,dtype=np.int64); s[i]=1; s[j]=1
    G.append(np.outer(g,g)); S.append(np.outer(s,s))
G=np.array(G);S=np.array(S)
def pd_all(A):
    A=A.copy(); n=6; prev=np.ones(len(A),dtype=np.int64); ok=np.ones(len(A),bool)
    for k in range(n):
        piv=A[:,k,k]; ok&=piv>0   # piv = k+1 leading principal minor (Bareiss)
        if k==n-1: break
        for i in range(k+1,n):
            for j in range(k+1,n):
                A[:,i,j]=(A[:,i,j]*piv - A[:,i,k]*A[:,k,j])//prev
        prev=np.where(piv==0,1,piv)
    return ok
tot=0; bad=0
for k in range(1,9):
    mats=[]
    for H2 in itertools.combinations(range(15),k):
        rest=[e for e in range(15) if e not in H2]
        for F in itertools.combinations(rest,k-1):
            H1=[e for e in rest if e not in F]
            tv=set(v for e in list(H1)+list(H2) for v in edges[e])
            if len(tv)<6: continue
            mats.append(G[H1].sum(0)+G[list(H2)].sum(0)+S[list(H2)].sum(0))
    A=2*np.array(mats)-np.eye(6,dtype=np.int64)
    ok=pd_all(A); tot+=len(A); bad+=int((~ok).sum()); print(k,len(A),"not PD:",int((~ok).sum()),flush=True)
print("total",tot,"not PD",bad)
