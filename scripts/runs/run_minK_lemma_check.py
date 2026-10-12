"""CHECK (not establish) the derived lemma:  |min K| >= sqrt(t/(n(n-1)(n-2)))
for K hollow symmetric with zero row sums and ||K||_F^2 = t.

The proof is in findings/bispectral.md; this only confirms it and looks for the
equality case, which the proof predicts is one row of the form (a,..,a,-(M-1)a).
"""
import numpy as np
rng=np.random.default_rng(211)
def randK(n,t,rng):
    A=rng.standard_normal((n,n)); K=(A+A.T)/2; np.fill_diagonal(K,0)
    for _ in range(400):
        r=K.sum(1)/(n-2); K=K-np.add.outer(r,r)+(K.sum()/((n-1)*(n-2)))
        np.fill_diagonal(K,0); K=(K+K.T)/2
    nr=np.linalg.norm(K)
    return None if nr<1e-12 else K*np.sqrt(t)/nr
def sphereK(n):
    m=n//2; K=np.zeros((n,n)); b=1.0; a=-m*b/(m-1)
    for i in range(n):
        for j in range(n):
            if i!=j: K[i,j]= a if (i<m)==(j<m) else b
    return K
print(f"{'n':>3} {'t':>5} {'bound':>10} {'min |K| found':>14} {'ratio':>8}  (ratio >= 1 confirms)")
worst=9
for n in [6,8,12]:
    for t in [0.5,1.0,2.0]:
        bd=np.sqrt(t/(n*(n-1)*(n-2))); best=9
        for _ in range(300):
            K=randK(n,t,rng)
            if K is None: continue
            off=K[~np.eye(n,dtype=bool)]
            best=min(best, abs(off.min()))
        print(f"{n:3d} {t:5.2f} {bd:10.6f} {best:14.6f} {best/bd:8.3f}")
        worst=min(worst,best/bd)
print(f"\nworst ratio over all cells: {worst:.3f}   {'HOLDS' if worst>=1-1e-9 else 'VIOLATED'}")
print("\nAt the balanced sphere product's own K (t=2):")
for n in [6,8,12]:
    K=sphereK(n); K=K*np.sqrt(2)/np.linalg.norm(K)
    off=K[~np.eye(n,dtype=bool)]; bd=np.sqrt(2/(n*(n-1)*(n-2)))
    print(f"  n={n:2d}: |min K| = {abs(off.min()):.6f}   bound {bd:.6f}   ratio {abs(off.min())/bd:.3f}")
