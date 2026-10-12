"""r275 claim 6: validate the ledger entry
   r260 -- "restriction takes 10,395 diagrams to rank 2, reopening independence".

Independent computation, sharing nothing with r260's scripts.

The Brauer diagrams on 12 legs are the 11!! = 10395 perfect matchings of the 12
index slots of W (x) W (x) W.  Each matching D gives the cubic form
   gamma_D(W) = sum over the contraction pattern of W_{....} W_{....} W_{....} .
"Rank 2" means: restricted to Weyl_n, the 10395 forms span a 2-dimensional space.

Method: enumerate all 10395 matchings; evaluate each on K random unit Weyl
tensors (K > 2, so a rank above 2 would show); take the numerical rank of the
10395 x K value matrix.  A matching with a pair inside one tensor contracts W
against itself in two of its own slots, which is a trace of a trace-free tensor,
so it must give the zero form -- that prediction is checked, not assumed.
"""
import sys, os, itertools, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from r275_geo import Geo

LET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKL"


def matchings(pts):
    if not pts:
        yield []
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i + 1:]):
            yield [(a, b)] + m


def run(n, K=8, seed=275):
    g = Geo(n)
    rng = np.random.default_rng(seed + n)
    Ws = [g.to_tensor(g.rand_weyl(rng)) for _ in range(K)]
    slots = list(range(12))                       # 0-3 first W, 4-7 second, 8-11 third
    rows, kinds = [], []
    t0 = time.time()
    allm = list(matchings(slots))
    assert len(allm) == 10395, len(allm)
    for m in allm:
        lab = [None] * 12
        for k, (i, j) in enumerate(m):
            lab[i] = lab[j] = LET[k]
        sub = "".join(lab[0:4]) + "," + "".join(lab[4:8]) + "," + "".join(lab[8:12]) + "->"
        intra = any(i // 4 == j // 4 for i, j in m)
        vals = [float(np.einsum(sub, W, W, W, optimize=True)) for W in Ws]
        rows.append(vals)
        kinds.append(intra)
    A = np.array(rows)
    intra = np.array(kinds)
    nz = np.abs(A).max(axis=1) > 1e-9
    rk = np.linalg.matrix_rank(A, tol=1e-8 * max(1.0, np.abs(A).max()))
    s = np.linalg.svd(A, compute_uv=False)
    print(f"n={n}  K={K}  dim Weyl_n={(n+2)*(n+1)*n*(n-3)//12}  [{time.time()-t0:.0f}s]")
    print(f"   matchings enumerated          : {len(allm)}   (11!! = 10395)")
    print(f"   with a pair inside one tensor : {int(intra.sum())}  -- of these, "
          f"{int((intra & nz).sum())} give a nonzero form")
    print(f"   giving a nonzero form         : {int(nz.sum())}")
    print(f"   RANK of the 10395 x {K} value matrix : {rk}")
    print(f"   singular values               : {np.array2string(s[:min(6,K)], precision=4)}")
    # identify the two survivors against the record's named pair
    M = g.rand_weyl(np.random.default_rng(9))
    tr3 = float(np.trace(M @ M @ M)); shp = float(np.sum(g.sharp(M) * M))
    v = np.array([float(np.einsum("".join(l[0:4]) + "," + "".join(l[4:8]) + "," + "".join(l[8:12]) + "->",
                                  *(3 * [g.to_tensor(M)]), optimize=True))
                  for l in [[LET[k] for k in range(12)]]])
    print(f"   the record's named pair at a fresh point: tr(W^3)={tr3:.9f}  <W#,W>={shp:.9f}")
    # express every nonzero diagram in the basis (tr(W^3), <W#,W>) over the K samples
    B = np.array([[float(np.trace(g.to_matrix(W) @ g.to_matrix(W) @ g.to_matrix(W))),
                   float(np.sum(g.sharp(g.to_matrix(W)) * g.to_matrix(W)))] for W in Ws])
    resid = A[nz] - A[nz] @ np.linalg.pinv(B.T) @ B.T
    print(f"   max residual of every nonzero diagram against span"
          f"{{tr(W^3), <W#,W>}} : {np.abs(resid).max():.3e}")
    return rk


if __name__ == "__main__":
    for n in (6, 7, 8):
        run(n)
        print()
