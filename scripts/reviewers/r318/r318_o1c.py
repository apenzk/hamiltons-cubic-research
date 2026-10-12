import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, r318_lib as L, r318_spaces as S
np.random.seed(3181)
n=8
here=os.path.dirname(os.path.abspath(__file__))
W=np.load(os.path.join(here,'W_A_not_B_n8.npy'))

def min_over_involutions(W,n,p,tries=60,steps=900):
    """min ||Lambda^2(sigma) W - W Lambda^2(sigma)||^2 over sigma ~ signature (p,n-p)."""
    D=np.diag([1.0]*p+[-1.0]*(n-p))
    best=np.inf
    for t in range(tries):
        A=np.random.randn(n,n); A=(A-A.T)/2
        lr=0.25
        for it in range(steps):
            g=np.eye(n)
            # matrix exponential by scaling and squaring via eigh of skew
            w,V=np.linalg.eig(A)
            g=np.real(V@np.diag(np.exp(w))@np.linalg.inv(V))
            sig=g@D@g.T
            Ls=L.lam2(sig,n)
            Cm=Ls@W-W@Ls
            f=float(np.sum(Cm*Cm))
            # numerical gradient on the skew parameters (cheap: n(n-1)/2=28 dims)
            if f<best: best=f
            if f<1e-18: return 0.0
            gr=np.zeros((n,n)); h=1e-5
            for i in range(n):
                for j in range(i+1,n):
                    E=np.zeros((n,n)); E[i,j]=h; E[j,i]=-h
                    w2,V2=np.linalg.eig(A+E)
                    g2=np.real(V2@np.diag(np.exp(w2))@np.linalg.inv(V2))
                    s2=g2@D@g2.T; L2=L.lam2(s2,n); C2=L2@W-W@L2
                    d=(float(np.sum(C2*C2))-f)/h
                    gr[i,j]=d; gr[j,i]=-d
            A=A-lr*gr
            if it%300==299: lr*=0.4
    return best

print('witness W (A but claimed not B): minimising ||[Lambda^2(sigma), W]||^2 over each signature')
for p in range(1,n//2+1):
    b=min_over_involutions(W,n,p,tries=8,steps=250)
    print(f'   signature ({p},{n-p}):  min ||[Lam2(sigma),W]||^2 = {b:.6f}')
print()
print('control: W_CP^4 (equivariant, (A) and claimed (B) only via an anti-holomorphic sigma)')
def solve_blocks(projs, nn, fix=None):
    rws=[];tgt=[]
    for M in L.ricci_rows(nn):
        rws.append([float(np.sum(M*Pi)) for Pi in projs])
    for j in range(nn):
        for l in range(j,nn): tgt.append(0.5 if j==l else 0.0)
    for M in L.bianchi_rows(nn):
        rws.append([float(np.sum(M*Pi)) for Pi in projs]); tgt.append(0.0)
    if fix:
        for (i,v) in fix:
            r=[0.0]*len(projs); r[i]=1.0; rws.append(r); tgt.append(v)
    A=np.array(rws); t=np.array(tgt); lam,*_=np.linalg.lstsq(A,t,rcond=None)
    return sum(l*Pi for l,Pi in zip(lam,projs))
for m in [3,4]:
    nn=2*m
    Pj,Psu,Pm,um,mm,jv=S.cp_blocks(m)
    R=solve_blocks([Pj,Psu,Pm],nn,fix=[(2,0.0)]); Wc=L.weyl_of(R,nn); Wc/=np.linalg.norm(Wc)
    # explicit anti-holomorphic involution: negate every odd coordinate
    sig=np.diag([1.0 if k%2==0 else -1.0 for k in range(nn)])
    Ls=L.lam2(sig,nn)
    print(f'   CP^{m}: sigma=diag(1,-1,...) has sigma J sigma = -J ? ||sJs+J||={np.linalg.norm(sig@S.Jmat(m)@sig+S.Jmat(m)):.1e};'
          f'  ||[Lam2(sigma), W_CP^{m}]|| = {np.linalg.norm(Ls@Wc-Wc@Ls):.2e}  (signature ({m},{m}))')
