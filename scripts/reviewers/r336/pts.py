import sys,os; sys.path.insert(0,os.path.dirname(__file__))
import numpy as np, fast
def subalg_proj(n,mats):
    P=fast.pairs(n)
    G=np.array([[A[i,j] for (i,j) in P] for A in mats])
    q,_=np.linalg.qr(G.T); return q@q.T
def u_m(n):
    m=n//2; J=np.zeros((n,n))
    for k in range(m): J[2*k,2*k+1]=1; J[2*k+1,2*k]=-1
    P=fast.pairs(n); mats=[]
    for (i,j) in P:
        A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; mats.append(A)
    Cm=np.array([(A@J-J@A).ravel() for A in mats]).T
    u,s,vt=np.linalg.svd(Cm); r=int(np.sum(s>1e-9)); nsp=vt[r:]
    out=[]
    for v in nsp:
        A=np.zeros((n,n))
        for k,(i,j) in enumerate(P): A[i,j]=v[k]; A[j,i]=-v[k]
        out.append(A)
    return out
def cartan(n):
    out=[]
    for k in range(n//2):
        A=np.zeros((n,n)); A[2*k,2*k+1]=1; A[2*k+1,2*k]=-1; out.append(A)
    return out
def block_alg(n,blocks):
    out=[]
    for bl in blocks:
        for x in range(len(bl)):
            for y in range(x+1,len(bl)):
                i,j=bl[x],bl[y]; A=np.zeros((n,n)); A[i,j]=1; A[j,i]=-1; out.append(A)
    return out
def make(n,mats):
    W=fast.weyl_proj(n,subalg_proj(n,mats)); W=(W+W.T)/2; return W/np.linalg.norm(W)
