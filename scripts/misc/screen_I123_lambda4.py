"""I123, the lift of P to the Ricci-free operators Weyl + Lambda^4 at n = 12 (screen).

reviews/2026-09-28o-I123-coupling.md, second attempt. Builds so(12)'s structure constants, the
halved # in L265's form C#X = 1/2 sum_i lam_i ad_{v_i} X ad_{v_i}^T (checked on I#I = 10 I through
the product values), the 495 Lambda^4 operators e_{ijkl}, and at each critical point W the top and
bottom of T(W,Y,Y) = <(WY+YW)/2 + W#Y, Y> over unit Y in Lambda^4, against theta/2. Then follows
the top eigenvector at S^4 x S^8, whose value passes theta0(12). /usr/bin/python3, about a minute.
Run from outside a folder holding a file named types.py.
"""
import numpy as np, itertools, sys
n=12; pairs=list(itertools.combinations(range(n),2)); N=len(pairs); idx={p:k for k,p in enumerate(pairs)}
def E(i,j):
    M=np.zeros((n,n)); M[j,i]=1; M[i,j]=-1; return M
Es=[E(i,j) for i,j in pairs]
def tovec(M): return np.array([M[j,i] for i,j in pairs])
c=np.zeros((N,N,N))
for a in range(N):
    for b in range(N): c[a,b,:]=tovec(Es[a]@Es[b]-Es[b]@Es[a])
ad=[c[k].T for k in range(N)]   # ad_{e_k}: (ad)_{ab}=c[k,b,a]
def adv(v): return np.einsum('k,kab->ab',v,np.array(ad))
def sharpW(W,Y):
    lam,V=np.linalg.eigh(W); out=np.zeros((N,N))
    for l,v in zip(lam,V.T):
        if abs(l)>1e-12:
            A=adv(v); out+=0.5*l*A@Y@A.T
    return out
def G(X):
    X=X/np.linalg.norm(X); return np.trace(X@X@X)+np.sum(sharpW(X,X)*X)
def formop(quad):
    i,j,k,l=quad; base=[i,j,k,l]; Y=np.zeros((N,N))
    for perm in itertools.permutations(range(4)):
        sgn=round(np.linalg.det(np.eye(4)[list(perm)]))
        x,y,z,w=[base[t] for t in perm]
        if x<y and z<w: Y[idx[(x,y)],idx[(z,w)]]+=sgn
    Y=(Y+Y.T)/2; return Y/np.linalg.norm(Y)
quads=list(itertools.combinations(range(n),4)); Ys=[formop(q) for q in quads]
def lam4top(W):
    W=W/np.linalg.norm(W); th=G(W)
    if th<0: W=-W; th=-th
    Ls=[]
    for Y in Ys:
        LY=0.5*(W@Y+Y@W)+sharpW(W,Y); Ls.append(LY)
    M=np.array([[np.sum(L*Y2) for Y2 in Ys] for L in Ls]); M=(M+M.T)/2
    ev=np.linalg.eigvalsh(M); return th, ev[-1], ev[0]
I=np.eye(N)
def product(p):
    A=set(range(p)); B=set(range(p,n)); q=n-p
    P1=np.diag([1.0 if (i in A and j in A) else 0 for i,j in pairs]); P2=np.diag([1.0 if (i in B and j in B) else 0 for i,j in pairs])
    return -q/(p-1)*P1-p/(q-1)*P2+(I-P1-P2)
def cp2pad():
    # W_CP2 on coords 0..3: self-dual Weyl diag(2,-1,-1) on Lambda+ with basis (e01+e23),(e02-e13),(e03+e12)
    vs=[]
    for (a,b,s,c2,d) in [((0,1),(2,3),1,None,None),((0,2),(1,3),-1,None,None),((0,3),(1,2),1,None,None)]:
        pass
    v1=np.zeros(N); v1[idx[(0,1)]]=1; v1[idx[(2,3)]]=1; v1/=np.sqrt(2)
    v2=np.zeros(N); v2[idx[(0,2)]]=1; v2[idx[(1,3)]]=-1; v2/=np.sqrt(2)
    v3=np.zeros(N); v3[idx[(0,3)]]=1; v3[idx[(1,2)]]=1; v3/=np.sqrt(2)
    return 2*np.outer(v1,v1)-np.outer(v2,v2)-np.outer(v3,v3)

print('I#I = 10 I:', np.allclose(sharpW(I,I), 10*I))
for name,W in [('S6xS6',product(6)),('S5xS7',product(5)),('S4xS8',product(4)),('padded CP2',cp2pad())]:
    th,top,bot=lam4top(W); print(name,'theta=%.5f'%th,'top T=%.5f'%top,'theta/2=%.5f'%(th/2),'bottom=%.5f'%bot, flush=True)
W=product(4); W=W/np.linalg.norm(W)
if G(W)<0: W=-W
Ls=[0.5*(W@Y+Y@W)+sharpW(W,Y) for Y in Ys]
M=np.array([[np.sum(L*Y2) for Y2 in Ys] for L in Ls]); M=(M+M.T)/2
ev,V=np.linalg.eigh(M); Ystar=sum(cf*Y for cf,Y in zip(V[:,-1],Ys))
best=max((G(W+t*Ystar),t) for t in np.linspace(-2,2,4001))
print('S4xS8 along its top Lambda^4 direction: max %.6f at t=%.4f, against theta0(12)=%.6f (exact 8 sqrt(15015)/715 = %.6f)'%(best[0],best[1],np.sqrt(55)/6,8*np.sqrt(15015)/715))
