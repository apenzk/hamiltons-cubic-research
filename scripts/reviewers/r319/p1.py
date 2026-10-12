import sys; sys.path.insert(0,'scripts/reviewers/r319')
import numpy as np, build, core
from itertools import combinations

def Smmm(A, mbasis):
    """sum_{a,b,c in m} <[phi_a,phi_b],phi_c>^2 for an orthonormal basis of m."""
    cm = np.einsum('abc,ia,jb,kc->ijk', A.c, mbasis, mbasis, mbasis, optimize=True)
    return float(np.sum(cm**2))

def report(name, n, hb):
    A = build.Arena(n); N = A.N; r = hb.shape[0]
    Wr = build.subalg_casimir(n, hb)
    W = build.unit(Wr)
    th = A.P3(W); res = np.linalg.norm(A.Q(W) - th*W)
    ric = np.linalg.norm(A.ricci(W)); bi = A.bianchi(W)
    # m = orthogonal complement of h
    Pi = hb.T @ hb
    ev, evec = np.linalg.eigh(np.eye(N) - Pi)
    mb = evec[:, ev > 0.5].T
    S = Smmm(A, mb)
    Sform = (N-r)*(2*(n-2) - 4*(n-1)*r/N)
    thform = (2.0/n)*np.sqrt(r*N/(N-r))
    cap = n*(n-2)/4.0
    th0 = np.sqrt(2*(n-1)*(n-2))/n
    print(f"{name:26s} n={n:3d} r={r:3d} N={N:3d} cap={cap:6.2f} | crit_res={res:.2e} Ric={ric:.2e} Bi={bi:.1e}"
          f" | theta={th:.9f} formula={thform:.9f} theta0={th0:.9f}"
          f" | S_mmm(direct)={S:.6f} S_mmm(formula)={Sform:.6f}")
    return dict(name=name,n=n,r=r,N=N,res=res,ric=ric,theta=th,thform=thform,th0=th0,S=S,Sform=Sform,cap=cap)

rows=[]
for n in [6,8,10]:
    rows.append(report(f"so({n//2})+so({n//2}) balanced", n, build.so_pq_basis(n, n//2)))
for (n,p) in [(8,3),(8,2),(10,4),(10,3),(6,2)]:
    rows.append(report(f"so({p})+so({n-p}) unbalanced", n, build.so_pq_basis(n,p)))
for n in [6,8,10]:
    rows.append(report(f"maximal torus so(2)^{n//2}", n, build.torus_basis(n)))
for n in [6,8,10]:
    rows.append(report(f"u({n//2}) in so({n})", n, build.um_basis(n)))
