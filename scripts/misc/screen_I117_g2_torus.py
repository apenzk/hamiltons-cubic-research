"""Screen: positive-definite #-idempotents on the torus family of g2 inside so(7) (I117, R48).

g2 is built as the stabiliser of the 3-form in so(7), the record's # is restricted to it (c = 4), and
the torus family (the commutant of a Cartan, nine-dimensional) is searched for solutions of C#C = C
from 300 starts near I/c; each positive-definite solution is reported with its squared norm and the
top eigenvalue of X -> C#X on C-perp in all of Sym^2 g2 (stable iff at most 1/2).
Run: sage -python scripts/misc/screen_I117_g2_torus.py   (seconds)
"""
import itertools, numpy as np
from scipy.linalg import null_space
from scipy.optimize import least_squares
m=7; P=list(itertools.combinations(range(m),2)); N=len(P); E=[]
for (i,j) in P:
    X=np.zeros((m,m)); X[i,j]=1; X[j,i]=-1; E.append(X)
c=np.zeros((N,N,N))
for a in range(N):
    for b in range(N):
        C=E[a]@E[b]-E[b]@E[a]
        for g in range(N): c[a,b,g]=0.5*np.sum(C*E[g])
def sharp(A,B):
    AXB=np.einsum('ge,aed,dz->agz',A,c,B,optimize=True)
    return 0.5*np.einsum('agz,bgz->ab',AXB,c,optimize=True)
phi=np.zeros((m,)*3)
for (a,b,cc),s in [((0,1,2),1),((0,3,4),1),((0,5,6),1),((1,3,5),1),((1,4,6),-1),((2,3,6),-1),((2,4,5),-1)]:
    for p in itertools.permutations(range(3)):
        phi[tuple((a,b,cc)[k] for k in p)]=s*np.linalg.det(np.eye(3)[list(p)])
act=lambda X:(np.einsum('da,dbc->abc',X,phi)+np.einsum('db,adc->abc',X,phi)+np.einsum('dc,abd->abc',X,phi))
g2=null_space(np.array([act(X).ravel() for X in E]).T)   # 21 x 14, orthonormal coordinates in e_ij basis
d=g2.shape[1]
# structure constants of g2 in its own orthonormal basis (record metric)
Bm=[sum(g2[k,a]*E[k] for k in range(N)) for a in range(d)]
cg=np.array([[[0.5*np.sum((Bm[a]@Bm[b]-Bm[b]@Bm[a])*Bm[g]) for g in range(d)] for b in range(d)] for a in range(d)])
def sh(A,B):
    AXB=np.einsum('ge,aed,dz->agz',A,cg,B,optimize=True)
    return 0.5*np.einsum('agz,bgz->ab',AXB,cg,optimize=True)
I=np.eye(d); cI=np.trace(sh(I,I))/d; print('g2: d',d,'c',round(cI,6))
# Cartan: two commuting elements; take a generic element of g2 and its centraliser
rng=np.random.default_rng(0)
x=rng.standard_normal(d); adx=np.einsum('a,abg->gb',x,cg)   # ad_x matrix: (ad_x)_{g b} = c_{a b g} x_a
cent=null_space(adx); assert cent.shape[1]==2
h1,h2=cent[:,0],cent[:,1]
ad=lambda y: np.einsum('a,abg->gb',y,cg)
# torus-invariant symmetric operators = commutant of ad(h1), ad(h2) among symmetric matrices
basis=[]
for i in range(d):
    for j in range(i,d):
        S=np.zeros((d,d)); S[i,j]=S[j,i]=1; basis.append(S)
M=np.array([np.concatenate([(S@ad(h1)-ad(h1)@S).ravel(),(S@ad(h2)-ad(h2)@S).ravel()]) for S in basis]).T
K=null_space(M); fam=[sum(K[k,t]*basis[k] for k in range(len(basis))) for t in range(K.shape[1])]
Q,_=np.linalg.qr(np.array([F.ravel() for F in fam]).T); fam=[Q[:,t].reshape(d,d) for t in range(Q.shape[1])]
print('torus family dimension',len(fam))
def Cof(y): return sum(y[t]*fam[t] for t in range(len(fam)))
def res(y):
    C=Cof(y); S=sh(C,C); return (S-C).ravel()
sols=[]
for trial in range(300):
    y0=np.array([np.sum(fam[t]*(np.eye(d)/cI)) for t in range(len(fam))])*(1+0.6*rng.standard_normal(len(fam)))
    r=least_squares(res,y0,max_nfev=300,xtol=1e-15,ftol=1e-15,gtol=1e-15)
    if np.linalg.norm(r.fun)<1e-10:
        C=Cof(r.x); ev=np.linalg.eigvalsh(C)
        if ev[0]>1e-8: sols.append((round(np.sum(C*C),8),C))
uniq={}
for q,C in sols: uniq.setdefault(q,C)
print('positive definite torus-invariant idempotents found (norm^2):',sorted(uniq), ' I/c has',round(d/cI**2,8))
# stability on all of Sym^2(g2): top eigenvalue of X -> C#X on C-perp
for q,C in sorted(uniq.items()):
    B=np.array([sh(C,S).ravel() for S in basis]).T  # image of symmetric basis (not orthonormal)
    # orthonormal basis of Sym^2
    OB=[]
    for i in range(d):
        for j in range(i,d):
            S=np.zeros((d,d)); 
            if i==j: S[i,i]=1
            else: S[i,j]=S[j,i]=1/np.sqrt(2)
            OB.append(S)
    Mx=np.array([[np.sum(sh(C,Sb)*Sa) for Sb in OB] for Sa in OB])
    cv=np.array([np.sum(C*Sa) for Sa in OB]); cv/=np.linalg.norm(cv)
    Pp=np.eye(len(OB))-np.outer(cv,cv)
    top=np.max(np.linalg.eigvalsh(Pp@Mx@Pp))
    print(f'  |C|^2 = {q:.6f}: top eigenvalue of C#. on C-perp = {top:.6f} (stable iff <= 1/2)')
