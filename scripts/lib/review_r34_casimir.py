"""M3/M6/M7: block Casimirs, reflections, and genuine multiplicity tests."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r34_core import struct, weyl_basis, idempotent, Le_matrix

def machinery(p, q):
    n = p+q
    prs, idx, C = struct(n)
    N = len(prs)
    B = weyl_basis(n); D = B.shape[0]
    Bf = B.reshape(D, N*N)
    # so(n) acts on operators by X -> A X - X A  (A = ad of phi_a)
    def gen(a):
        A = C[a]
        out = np.einsum('mn,dnk->dmk', A, B) - np.einsum('dmn,nk->dmk', B, A)
        return Bf @ out.reshape(D, N*N).T
    CP = np.zeros((D, D)); CQ = np.zeros((D, D))
    for a, (i, j) in enumerate(prs):
        if j < p:
            G = gen(a); CP -= G @ G
        elif i >= p:
            G = gen(a); CQ -= G @ G
    # reflections: r_P flips coordinate 0, r_Q flips coordinate p
    def refl(k):
        r = np.eye(n); r[k, k] = -1
        R2 = np.zeros((N, N))
        for a, (i, j) in enumerate(prs):
            R2[a, a] = r[i, i] * r[j, j]
        out = np.einsum('mn,dnk,lk->dml', R2, B, R2)
        return Bf @ out.reshape(D, N*N).T
    RP, RQ = refl(0), refl(p)
    return CP, CQ, RP, RQ, B, D, n

def blocks(mats, D, tol=1e-6):
    """Simultaneously block-diagonalise commuting symmetric mats; return (labels, basis)."""
    Vs = [np.eye(D)]
    labs = [()]
    for M in mats:
        newV, newL = [], []
        for V, lab in zip(Vs, labs):
            S = V.T @ M @ V; S = 0.5*(S+S.T)
            w, U = np.linalg.eigh(S)
            i = 0
            while i < len(w):
                j = i
                while j+1 < len(w) and abs(w[j+1]-w[i]) < tol:
                    j += 1
                newV.append(V @ U[:, i:j+1]); newL.append(lab + (round(float(w[i]), 6),))
                i = j+1
        Vs, labs = newV, newL
    return labs, Vs

if __name__ == "__main__":
    splits = eval(sys.argv[1]) if len(sys.argv) > 1 else [(3,3),(3,4),(3,5),(4,4),(4,5),(3,6),(4,6),(5,5)]
    for (p, q) in splits:
        CP, CQ, RP, RQ, B, D, n = machinery(p, q)
        e, theta, _ = idempotent(p, q)
        L = Le_matrix(e, n, B); L = 0.5*(L+L.T)
        print(f"\n=== (p,q)=({p},{q})  n={n}  D={D} ===")
        for name, mats in (("SO(p)xSO(q) Casimirs", [CP, CQ]),
                           ("O(p)xO(q)  Casimirs+reflections", [CP, CQ, RP, RQ])):
            labs, Vs = blocks(mats, D)
            # merge blocks with identical labels
            info = []
            for lab, V in zip(labs, Vs):
                S = V.T @ L @ V
                w = np.linalg.eigvalsh(0.5*(S+S.T))
                scalar = (w.max()-w.min()) < 1e-8
                info.append((lab, V.shape[1], w.mean(), scalar))
            print(f"  {name}: {len(info)} blocks, L_e scalar on every block: "
                  f"{all(s for *_ , s in info)}")
            print("     " + "  ".join(f"d{d}@{v:+.4f}" for _, d, v, _ in sorted(info, key=lambda t:-t[1])))
