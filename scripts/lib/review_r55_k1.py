"""Reviewer 55, K1: is the C_5 blow-up exactly critical, Ricci-flat, S=0, at the
stated theta?  Done in exact rational arithmetic as well as float."""
import numpy as np, sys, itertools
from fractions import Fraction
sys.path.insert(0, 'scripts/lib')
from review_r55_core import *

def c5_vertex(sizes, diag=4, adjv=-2, non=1):
    k = len(sizes); n = sum(sizes)
    lab = sum([[a]*b for a,b in enumerate(sizes)], [])
    G = [[0]*k for _ in range(k)]
    for a in range(k):
        G[a][(a+1)%k] = G[(a+1)%k][a] = 1
    lam = np.zeros((n,n))
    for i in range(n):
        for j in range(n):
            if i==j: continue
            a,b = lab[i], lab[j]
            lam[i,j] = diag if a==b else (adjv if G[a][b] else non)
    return lam, lab

def exact_check(sizes, diag=4, adjv=-2, non=1):
    """Rational arithmetic: row sums and criticality Q(lam) = t*lam for the
    unnormalized operator (t rational)."""
    k=len(sizes); n=sum(sizes)
    lab = sum([[a]*b for a,b in enumerate(sizes)], [])
    G=[[0]*k for _ in range(k)]
    for a in range(k): G[a][(a+1)%k]=G[(a+1)%k][a]=1
    L=[[Fraction(0)]*n for _ in range(n)]
    for i in range(n):
        for j in range(n):
            if i==j: continue
            a,b=lab[i],lab[j]
            L[i][j]=Fraction(diag if a==b else (adjv if G[a][b] else non))
    rows = [sum(L[i]) for i in range(n)]
    # Q
    QL=[[Fraction(0)]*n for _ in range(n)]
    for i in range(n):
        for j in range(n):
            if i==j: continue
            s=L[i][j]**2
            for m in range(n):
                if m==i or m==j: continue
                s+=L[i][m]*L[j][m]
            QL[i][j]=s
    # ratio
    ratios=set()
    for i in range(n):
        for j in range(n):
            if i==j: continue
            ratios.add(QL[i][j]/L[i][j] if L[i][j]!=0 else None)
    nrm2 = sum(L[i][j]**2 for i in range(n) for j in range(n))/2   # |W|^2
    P = (sum(L[i][j]**3 for i in range(n) for j in range(n))
         + sum(L[i][m]*L[m][j]*L[j][i] for i in range(n) for m in range(n) for j in range(n)))/2
    return rows, ratios, nrm2, P

if __name__=="__main__":
    sizes=[2]*5; n=sum(sizes)
    rows, ratios, nrm2, P = exact_check(sizes)
    print("EXACT (Fraction) arithmetic, unnormalised entries 4:-2:+1")
    print("  row sums          :", set(rows))
    print("  Q(lam)/lam ratios :", ratios)
    print("  |W|^2             :", nrm2)
    print("  P (unnormalised)  :", P)
    # theta of the normalised operator = P/|W|^3
    import math
    th = float(P)/float(nrm2)**1.5
    print(f"  theta = P/|W|^3   = {th:.15f}")
    print(f"  theta_0(10)       = {theta0(n):.15f}")
    print(f"  theta/theta_0     = {th/theta0(n):.10f}")
    print(f"  exact theta^2     = {Fraction(P*P, nrm2**3)}  -> sqrt = {math.sqrt(float(Fraction(P*P,nrm2**3))):.15f}")

    print()
    print("FLOAT, full Lambda^2 operator (45x45)")
    lam,_ = c5_vertex(sizes)
    W = diag_operator(lam); W = W/np.linalg.norm(W)
    QW = Q(n,W); th = float(np.tensordot(W,QW))
    print(f"  theta             = {th:.15f}")
    print(f"  criticality resid = {np.linalg.norm(QW-th*W):.3e}")
    # Ricci and Bianchi
    B = weyl_basis(n); Bf = B.reshape(B.shape[0],-1)
    print(f"  dist to Weyl_n    = {np.linalg.norm(W.ravel()-Bf.T@(Bf@W.ravel())):.3e}")
    S = slack_struct(n,W)
    ev = np.linalg.eigvalsh(W)
    print(f"  eigenvalues       : {sorted(set(np.round(ev,10)))}, dim m = {(ev<-1e-9).sum()}")
    print(f"  S_structural      = {S:.6e}")
    # negative block graph triangles
    negedges=[(i,j) for i in range(n) for j in range(i+1,n) if lam[i,j]<0]
    tri=sum(1 for a,b,c_ in itertools.combinations(range(n),3)
            if (min(a,b),max(a,b)) in [(min(x),max(x)) for x in []] )
    E=set((min(i,j),max(i,j)) for i,j in negedges)
    tri=sum(1 for a,b,c_ in itertools.combinations(range(n),3)
            if (a,b) in E and (a,c_) in E and (b,c_) in E)
    print(f"  neg graph: {len(E)} edges, {tri} triangles -> 3*tri = {3*tri}")
