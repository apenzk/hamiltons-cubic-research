import sys; sys.path.insert(0,'scripts/reviewers/r97')
import numpy as np
from weyl97 import *
SC='scratchpad'
rng=np.random.default_rng(1997)
print("=== does alpha=8trM^3 need Bianchi/tracefree? test on generic symmetric M ===")
for n in (5,6):
    D=n*(n-1)//2
    A=rng.normal(size=(D,D)); M=(A+A.T)/2; M/=np.linalg.norm(M)
    W=M_to_W(M,n)
    print(f"  n={n} generic sym M: alpha-8trM^3={alpha(W)-8*np.trace(M@M@M):.3e}  beta-2<M#,M>={beta(W)-2*np.sum(sharp(M,n)*M):.3e}")
print()
print("=== Claim B: theta = 3/2 tr M^3 - 1/2 tr(Wring^3);  tr(Wring^2)=3 ===")
for n in range(4,9):
    B=np.load(f'{SC}/wb{n}.npy'); d=len(B)
    e_th=[];e_tr2=[];e_df=[]
    for s in range(12):
        M=np.tensordot(rng.normal(size=d),B,axes=1); M/=np.linalg.norm(M)
        W=M_to_W(M,n)
        O=Wring(W,n,'iklj')
        assert np.abs(O-O.T).max()<1e-10, (n,np.abs(O-O.T).max())
        t3=np.trace(M@M@M); th=theta(M,n)
        tr3=np.trace(O@O@O); tr2=np.trace(O@O)
        e_th.append(abs(th-(1.5*t3-0.5*tr3)))
        e_tr2.append(abs(tr2-3.0))
        # Dai-Fu 3.3 with s=0 directly
        e_df.append(abs(tr3-(-beta(W)+alpha(W)/8)))
    m=(n-1)*(n+2)//2
    print(f"n={n} dimS20={m}(op {O.shape[0]}) max|theta-(3/2 trM3 - 1/2 trO3)|={max(e_th):.3e} max|trO2-3|={max(e_tr2):.3e} max|trO3-(-b+a/8)|={max(e_df):.3e}")
print()
print("=== opposite index order ikjl (sign check) ===")
n=6; B=np.load(f'{SC}/wb{n}.npy')
M=np.tensordot(rng.normal(size=len(B)),B,axes=1); M/=np.linalg.norm(M); W=M_to_W(M,n)
O1=Wring(W,n,'iklj'); O2=Wring(W,n,'ikjl')
print("  O(iklj)+O(ikjl) maxabs:", np.abs(O1+O2).max())
print("  trO1^3=",np.trace(O1@O1@O1)," trO2^3=",np.trace(O2@O2@O2))
print("  theta=",theta(M,n)," 3/2trM3-1/2trO1^3=",1.5*np.trace(M@M@M)-0.5*np.trace(O1@O1@O1),
      " with O2:",1.5*np.trace(M@M@M)-0.5*np.trace(O2@O2@O2))
