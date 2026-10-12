"""P3: the four kernel failures, verified independently, plus discriminating witnesses."""
import sys; sys.path.insert(0,'scripts/reviewers/r319')
import numpy as np, build, core

def so_vec(A, M):
    """coefficients of an antisymmetric n x n matrix M in the orthonormal Lambda^2 basis."""
    _, B = core.so_basis(A.n)
    return np.array([0.5*np.sum(M*B[a]) for a in range(A.N)])

def isotropy(A, W, tol=1e-9):
    """k(W) = {x in so(n) : [ad(x), W] = 0}; returns dim and an orthonormal basis (coeffs)."""
    rows = []
    for a in range(A.N):
        x = np.zeros(A.N); x[a] = 1.0
        M = A.ad(x)
        rows.append((M @ W - W @ M).reshape(-1))
    Mmat = np.array(rows)                     # (N, N*N)
    U, S, Vh = np.linalg.svd(Mmat.T, full_matrices=True)
    rk = int((S > tol*max(1.0, S[0])).sum())
    return A.N - rk, Vh[rk:]

def defect(A, W, which='pos', tol=1e-9):
    ev, evec = np.linalg.eigh(W)
    sel = ev > tol if which == 'pos' else ev < -tol
    tot = 0.0
    for k in np.where(sel)[0]:
        M = A.ad(evec[:, k])
        tot += float(np.sum((M @ W - W @ M)**2))
    return tot

def Sabc(A, ba, bb, bc):
    T = np.einsum('abc,ia,jb,kc->ijk', A.c, ba, bb, bc, optimize=True)
    return float(np.sum(T**2))

def splitting(A, W, tol=1e-9):
    ev, evec = np.linalg.eigh(W)
    p = evec[:, ev > tol].T
    m = evec[:, ev < -tol].T
    k = evec[:, np.abs(ev) <= tol].T
    return p, m, k

def screen(name, n, W):
    A = build.Arena(n); W = build.unit(W)
    th = A.P3(W); res = np.linalg.norm(A.Q(W)-th*W)
    p, m, k = splitting(A, W)
    dimk, _ = isotropy(A, W)
    print(f"\n== {name}  n={n} N={A.N}")
    print(f"   theta={th:.9f}  crit residual={res:.1e}")
    print(f"   dim E+={p.shape[0]}  dim E-={m.shape[0]}  dim ker={k.shape[0]}   (E+ + E- spans so(n)? "
          f"{'YES' if k.shape[0]==0 else 'NO'})")
    print(f"   S_mmm={Sabc(A,m,m,m):.6f}   S_mpp={Sabc(A,m,p,p):.6f}   S_ppp={Sabc(A,p,p,p):.6f}"
          f"   S_mmp={Sabc(A,m,m,p):.6f}")
    if k.shape[0]:
        print(f"   kernel-aware: S_mmk={Sabc(A,m,m,k):.6f}  S_ppk={Sabc(A,p,p,k):.6f}  S_kkk={Sabc(A,k,k,k):.6f}"
              f"  S_pmk={Sabc(A,p,m,k):.6f}")
    print(f"   Delta (= sum over E+ of orbit mass) = {defect(A,W):.6e}    dim k(W) = {dimk}")
    rp = p.shape[0]
    bd = (2.0/n)*np.sqrt(rp*A.N/(A.N-rp)) if 0<rp<A.N else np.inf
    print(f"   post-40 bound with r=dim E+ : {bd:.6f}  -> {'HOLDS' if th<=bd+1e-9 else 'FAILS'}")
    return dict(theta=th, dimk=dimk, ker=k.shape[0])

if __name__ == "__main__":
    screen("W_CP^2 at n=4", 4, build.cp2(4))
    screen("padded W_CP^2 at n=8", 8, build.cp2(8))
    screen("padded W_CP^2 at n=12", 12, build.cp2(12))
    screen("S^3 x S^5 at n=8 (ker=0)", 8, build.diag_blocks(8,[3,5]))
    screen("S^4 x S^4 at n=8 (ker=0)", 8, build.diag_blocks(8,[4,4]))
    print("\nDONE")
