"""P2: post-40's bound, its counterexamples, and candidate repairs."""
import sys; sys.path.insert(0,'scripts/reviewers/r319')
import numpy as np, build, core
from itertools import combinations

def analyse(name, n, W, A=None):
    A = A or build.Arena(n)
    W = build.unit(W); N = A.N
    th = A.P3(W); res = np.linalg.norm(A.Q(W) - th*W)
    ev = np.linalg.eigvalsh(W)
    tol = 1e-9
    rp = int((ev > tol).sum()); rm = int((ev < -tol).sum()); z = N - rp - rm
    rk = rp + rm
    lmin = float(ev[0])
    # support dimension: smallest coordinate-free R^s carrying W  -> rank of T_{ip}=sum W_{ijkl}W_{pjkl}
    idx = {p:a for a,p in enumerate(A.P)}
    Tm = np.zeros((n,n))
    def R(i,j,k,l):
        if i==j or k==l: return 0.0
        s=1.0
        if i>j: i,j=j,i; s=-s
        if k>l: k,l=l,k; s=-s
        return s*W[idx[(i,j)],idx[(k,l)]]
    for i in range(n):
        for p in range(n):
            Tm[i,p] = sum(R(i,j,k,l)*R(p,j,k,l) for j in range(n) for k in range(n) for l in range(n))
    supp = int((np.linalg.eigvalsh(Tm) > 1e-9).sum())
    def b(r, NN, nn):
        if r <= 0 or r >= NN: return np.inf
        return (2.0/nn)*np.sqrt(r*NN/(NN-r))
    post40 = b(rp, N, n)
    rep_rank = b(rk, N, n)                       # r := rank
    rep_Nrank = b(rp, rk, n)                     # N := rank
    Ns = supp*(supp-1)//2
    rep_supp = b(rp, Ns, supp)                   # restrict to support
    rep_supp_rank = b(rk, Ns, supp)
    lam = (n-1)*abs(lmin)
    print(f"{name:28s} n={n:3d} N={N:3d} dimE+={rp:3d} dimE-={rm:3d} ker={z:3d} rank={rk:3d} supp={supp:3d}"
          f" | theta={th:.9f} res={res:.1e}"
          f" | post40={post40:.6f} {'OK ' if th<=post40+1e-9 else 'FAIL'}"
          f" | r=rank {rep_rank:9.6f} {'OK' if th<=rep_rank+1e-9 else 'FAIL'}"
          f" | N=rank {rep_Nrank:9.6f} {'OK' if th<=rep_Nrank+1e-9 else 'FAIL'}"
          f" | supp {rep_supp:9.6f} {'OK' if th<=rep_supp+1e-9 else 'FAIL'}"
          f" | (n-1)|lmin| {lam:9.6f} {'OK' if th<=lam+1e-9 else 'FAIL'}")
    return dict(name=name,n=n,N=N,rp=rp,rm=rm,z=z,rk=rk,supp=supp,theta=th,res=res,
                post40=post40,rep_rank=rep_rank,rep_Nrank=rep_Nrank,rep_supp=rep_supp,lam=lam)

def parts(n, kmax=4, minb=2):
    out=[]
    def rec(rem, k, cur, lo):
        if k==0:
            if rem==0: out.append(tuple(cur))
            return
        for s in range(max(lo,minb), rem-minb*(k-1)+1):
            rec(rem-s, k-1, cur+[s], s)
    for k in range(2, kmax+1):
        rec(n, k, [], minb)
    return out

if __name__ == "__main__":
    rows=[]
    for n in [6,8,10,12]:
        A = build.Arena(n)
        for bl in parts(n, 4):
            rows.append(analyse("blocks "+str(bl), n, build.diag_blocks(n, list(bl)), A))
    print()
    for n in [4,6,8,10,12]:
        rows.append(analyse("CP^2 padded", n, build.cp2(n)))
    print()
    # subalgebra family members
    for n in [6,8,10]:
        A = build.Arena(n)
        rows.append(analyse(f"torus so(2)^{n//2}", n, build.subalg_casimir(n, build.torus_basis(n)), A))
    rows.append(analyse("ad(su(3)) in so(8)", 8, build.subalg_casimir(8, build.adjoint_basis(8, build.su3_adjoint()))))
    print("DONE")
