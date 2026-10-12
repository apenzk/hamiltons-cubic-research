"""r283 claim 2: the three diagonality instruments, rebuilt from the definitions.

Independent of scripts/b_diagonality_split.py: W_CPm is built from the Fubini-Study
curvature tensor and Weyl-projected here, not read off the isotypic closed form.

Reports, per point:
  * the Lambda^2 spectrum, and for each eigenspace min ||omega ^ omega|| over its
    unit sphere (the Plucker obstruction; 0 iff the eigenspace meets the Grassmann
    cone).  Convention: (omega ^ omega)_{ijkl} = w_ij w_kl - w_ik w_jl + w_il w_jk.
  * the off-diagonal Frobenius mass minimised over O(n), with a positive control.
"""
import numpy as np, itertools, sys

def pairs_of(n): return [(i, j) for i in range(n) for j in range(i + 1, n)]

def fs_weyl(m):
    """Weyl operator of CP^m on Lambda^2(R^2m), unit Frobenius norm."""
    n = 2 * m
    J = np.zeros((n, n))
    for k in range(m):
        J[2 * k, 2 * k + 1] = 1.0; J[2 * k + 1, 2 * k] = -1.0
    g = np.eye(n)
    R = np.zeros((n, n, n, n))
    for i, j, k, l in itertools.product(range(n), repeat=4):
        R[i, j, k, l] = (g[i, k] * g[j, l] - g[i, l] * g[j, k]
                         + J[i, k] * J[j, l] - J[i, l] * J[j, k]
                         + 2.0 * J[i, j] * J[k, l])
    Ric = np.einsum('ijkj->ik', R)
    scal = np.trace(Ric)
    # Einstein, so only the scalar part is subtracted
    c = scal / (n * (n - 1))
    W = R - c * (np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g))
    return W, n

def op_from_tensor(W, n):
    """Matrix of W on Lambda^2 in the basis {e_i ^ e_j}_{i<j}."""
    P = pairs_of(n)
    return np.array([[W[i, j, k, l] for (k, l) in P] for (i, j) in P])

def normalise(A): return A / np.linalg.norm(A)

def ricci_of_op(A, n):
    P = pairs_of(n); idx = {p: a for a, p in enumerate(P)}
    def g(i, j, k, l):
        if i == j or k == l: return 0.0
        s = 1.0
        if i > j: i, j, s = j, i, -s
        if k > l: k, l, s = l, k, -s
        return s * A[idx[(i, j)], idx[(k, l)]]
    return max(abs(sum(g(i, k, j, k) for k in range(n))) for i in range(n) for j in range(n))

def bianchi_of_op(A, n):
    P = pairs_of(n); idx = {p: a for a, p in enumerate(P)}
    def g(i, j, k, l):
        s = 1.0
        if i > j: i, j, s = j, i, -s
        if k > l: k, l, s = l, k, -s
        return s * A[idx[(i, j)], idx[(k, l)]]
    return max(abs(g(i, j, k, l) + g(i, k, l, j) + g(i, l, j, k))
               for i, j, k, l in itertools.combinations(range(n), 4))

def wedge_norm(w, n, P):
    """||omega ^ omega|| for omega given by its {i<j} coordinates."""
    M = np.zeros((n, n))
    for a, (i, j) in enumerate(P):
        M[i, j] = w[a]; M[j, i] = -w[a]
    tot = 0.0
    for i, j, k, l in itertools.combinations(range(n), 4):
        c = M[i, j] * M[k, l] - M[i, k] * M[j, l] + M[i, l] * M[j, k]
        tot += c * c
    return float(np.sqrt(tot))

def min_wedge(basis, n, P, seed=0, starts=60, iters=600):
    """min ||omega ^ omega|| over the unit sphere of span(basis) (rows)."""
    rng = np.random.default_rng(seed)
    d = basis.shape[0]
    if d == 1:
        return wedge_norm(basis[0] / np.linalg.norm(basis[0]), n, P)
    best = np.inf
    for _ in range(starts):
        x = rng.normal(size=d); x /= np.linalg.norm(x)
        step = 0.3
        f = wedge_norm(basis.T @ x, n, P)
        for _ in range(iters):
            gr = np.zeros(d); h = 1e-6
            for a in range(d):
                y = x.copy(); y[a] += h; y /= np.linalg.norm(y)
                gr[a] = (wedge_norm(basis.T @ y, n, P) - f) / h
            y = x - step * gr
            y /= np.linalg.norm(y)
            fy = wedge_norm(basis.T @ y, n, P)
            if fy < f: x, f = y, fy; step *= 1.2
            else: step *= 0.5
            if step < 1e-12: break
        best = min(best, f)
    return best

def lam2(R, n, P):
    L = np.zeros((len(P), len(P)))
    for b, (k, l) in enumerate(P):
        for a, (i, j) in enumerate(P):
            L[a, b] = R[i, k] * R[j, l] - R[i, l] * R[j, k]
    return L

def offdiag(A): return float(np.linalg.norm(A - np.diag(np.diag(A))))

def min_offdiag(A, n, seed=0, starts=25, iters=4000):
    rng = np.random.default_rng(seed)
    P = pairs_of(n)
    best = offdiag(A)
    for s in range(starts):
        X = rng.normal(size=(n, n)) * 0.5; X = X - X.T
        step = 0.2
        cur = offdiag(lam2(expm(X), n, P) @ A @ lam2(expm(X), n, P).T)
        for _ in range(iters):
            G = rng.normal(size=(n, n)); G = G - G.T
            Y = X + step * G
            L = lam2(expm(Y), n, P)
            v = offdiag(L @ A @ L.T)
            if v < cur: X, cur = Y, v
            else: step *= 0.97
            if step < 1e-9: break
        best = min(best, cur)
    return best

from scipy.linalg import expm

def eigenspaces(A, tol=1e-8):
    w, V = np.linalg.eigh(A)
    out = []
    i = 0
    while i < len(w):
        j = i
        while j + 1 < len(w) and abs(w[j + 1] - w[i]) < tol: j += 1
        out.append((w[i], V[:, i:j + 1].T.copy()))
        i = j + 1
    return out

def padded_cp2(n):
    """W_{CP^2} on Lambda^2(R^4), padded into Lambda^2(R^n), unit norm."""
    W4, _ = fs_weyl(2)
    A4 = op_from_tensor(W4, 4)
    P4 = pairs_of(4); P = pairs_of(n); idx = {p: a for a, p in enumerate(P)}
    A = np.zeros((len(P), len(P)))
    for a, p in enumerate(P4):
        for b, q in enumerate(P4):
            A[idx[p], idx[q]] = A4[a, b]
    return normalise(A)

def sphere_product(p, q):
    """Weyl operator of S^p x S^q, from the curvature tensor, unit norm."""
    n = p + q
    # product of round spheres with Einstein-balanced radii: use curvature
    # R = k1 (g1 o g1)/2 on block 1, k2 on block 2, zero mixed.
    g = np.eye(n)
    idx1 = list(range(p)); idx2 = list(range(p, n))
    k1 = 1.0 / (p - 1); k2 = 1.0 / (q - 1)   # Ricci = Id on each block
    R = np.zeros((n, n, n, n))
    def inb(i, s): return i in s
    for i, j, k, l in itertools.product(range(n), repeat=4):
        if all(inb(t, idx1) for t in (i, j, k, l)):
            R[i, j, k, l] = k1 * (g[i, k] * g[j, l] - g[i, l] * g[j, k])
        elif all(inb(t, idx2) for t in (i, j, k, l)):
            R[i, j, k, l] = k2 * (g[i, k] * g[j, l] - g[i, l] * g[j, k])
    Ric = np.einsum('ijkj->ik', R); scal = np.trace(Ric)
    Ric0 = Ric - (scal / n) * g
    # Kulkarni-Nomizu with Ric0 and with g
    KN = (np.einsum('ik,jl->ijkl', Ric0, g) - np.einsum('il,jk->ijkl', Ric0, g)
          + np.einsum('ik,jl->ijkl', g, Ric0) - np.einsum('il,jk->ijkl', g, Ric0))
    W = (R - KN / (n - 2)
         + scal / ((n - 1) * (n - 2)) * (np.einsum('ik,jl->ijkl', g, g) - np.einsum('il,jk->ijkl', g, g)))
    return normalise(op_from_tensor(W, n)), n

if __name__ == "__main__":
    print("=== construction checks ===")
    for m in (2, 4, 5):
        W, n = fs_weyl(m); A = normalise(op_from_tensor(W, n))
        print(f"CP^{m}: n={n} |Ric|={ricci_of_op(A, n):.2e} Bianchi={bianchi_of_op(A, n):.2e}")
    A, n = sphere_product(3, 3)
    print(f"S3xS3: n={n} |Ric|={ricci_of_op(A, n):.2e} Bianchi={bianchi_of_op(A, n):.2e}")

    print("\n=== Plucker: min ||w ^ w|| per eigenspace ===")
    cases = []
    for m in (4, 5):
        W, n = fs_weyl(m); cases.append((f"CP^{m}", normalise(op_from_tensor(W, n)), n))
    cases.append(("padded W_CP2 (n=8)", padded_cp2(8), 8))
    cases.append(("S^3xS^3 control", *sphere_product(3, 3)[::1]))
    for name, A, n in cases:
        P = pairs_of(n)
        print(f"-- {name}")
        for ev, B in eigenspaces(A):
            mw = min_wedge(B, n, P, starts=(1 if B.shape[0] == 1 else 25), iters=400)
            print(f"   eig {ev:+.6f} dim {B.shape[0]:3d}  min||w^w|| = {mw:.4f}")
