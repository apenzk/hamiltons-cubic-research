"""B1: reconcile the two builds of the trivial isotype at the C_5 blow-up.

THE DISAGREEMENT ([bounds.md](../../findings/bounds.md)): r301 reports the trivial
isotype at dimension 4 carrying {0.441754, 0.820541}; an independent build in the
record returns dimension 5 carrying {0.152312, 0.274865, 0.413011, 0.516880,
0.601823}.  Until it is settled no census number is citable.

THE DERIVATION THIS TESTS.  At the C_5 blow-up with blocks (2,2,2,2,2) the isotropy
k(W) is so(2)^5, a maximal torus of so(10).  A symmetric matrix commuting with every
rotation is a multiple of I_2 on each diagonal block and zero off it, so the torus
invariants are 5-dimensional in Sym and 4-dimensional in Sym_0.  The missing direction
is A = I, and D_I is twice the identity on Lambda^2, so H_I is a multiple of W itself
-- the RADIAL direction, which is exactly what Lemma 24 excludes.  So the prediction
is: dimension 4 is the trivial isotype of Sym_0, dimension 5 is that space plus the
radial direction, and a compression that keeps the radial direction is not a
restriction to an invariant subspace, so its eigenvalues need not be eigenvalues of
L_e at all.

The test of that prediction is whether the 4 values lie in the full Sym_0 spectrum
(r301's do) and whether the 5 values do not.
"""
import sys
import numpy as np

sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, Q, sharp_bilin
from b_c5_blowup import c5_operator


def derivation(n, A):
    """D_A on Lambda^2: D_A(e_i ^ e_j) = (A e_i) ^ e_j + e_i ^ (A e_j)."""
    pairs, idx = pair_index(n)
    N = len(pairs)
    D = np.zeros((N, N))
    for b, (i, j) in enumerate(pairs):
        for k in range(n):
            if k != j:
                a, s = (k, j), 1.0
                if k > j:
                    a, s = (j, k), -1.0
                D[idx[a], b] += s * A[k, i]
            if k != i:
                a, s = (i, k), 1.0
                if i > k:
                    a, s = (k, i), -1.0
                D[idx[a], b] += s * A[k, j]
    return D


def H_of(n, W, A):
    D = derivation(n, A)
    return D @ W + W @ D


def L_e(n, W, th, H):
    return (0.5 * (W @ H + H @ W) + sharp_bilin(n, W, H)) / th


def sym0_basis(n):
    """Orthonormal basis of trace-free symmetric n x n matrices."""
    B = []
    for i in range(n):
        for j in range(i + 1, n):
            E = np.zeros((n, n))
            E[i, j] = E[j, i] = 1 / np.sqrt(2)
            B.append(E)
    for i in range(1, n):
        d = np.zeros(n)
        d[:i] = 1.0
        d[i] = -i
        d /= np.linalg.norm(d)
        B.append(np.diag(d))
    return np.array(B)


def torus_invariants(n, blocks, trace_free):
    """alpha_a I_2 on each block; trace-free removes one dimension."""
    B = []
    off = 0
    for b in blocks:
        E = np.zeros((n, n))
        for t in range(b):
            E[off + t, off + t] = 1.0
        B.append(E / np.linalg.norm(E))
        off += b
    B = np.array(B)
    if not trace_free:
        return B
    I = np.eye(n) / np.sqrt(n)
    out = []
    for E in B:
        F = E - float(np.tensordot(E, I)) * I
        if np.linalg.norm(F) > 1e-9:
            out.append(F / np.linalg.norm(F))
    return np.array(np.linalg.qr(np.array([o.ravel() for o in out]).T)[0].T
                    ).reshape(-1, n, n)


def spectrum_on(n, W, th, A_basis, label):
    """Eigenvalues of L_e compressed to span{H_A}, and whether the span is invariant."""
    Hs = [H_of(n, W, A) for A in A_basis]
    V = np.array([h.ravel() for h in Hs])
    keep = [i for i in range(len(V)) if np.linalg.norm(V[i]) > 1e-9]
    V = V[keep]
    Qb, _ = np.linalg.qr(V.T)
    Qb = Qb.T
    LH = np.array([L_e(n, W, th, q.reshape(W.shape)).ravel() for q in Qb])
    M = Qb @ LH.T
    resid = np.linalg.norm(LH - (LH @ Qb.T) @ Qb)
    ev = np.sort(np.linalg.eigvalsh(0.5 * (M + M.T)))
    print(f"\n  {label}: dim {len(Qb)}", flush=True)
    print(f"    invariance residual ||L_e H - proj|| = {resid:.3e}"
          f"   ({'invariant' if resid < 1e-9 else 'NOT invariant -- a compression'})",
          flush=True)
    print(f"    values {np.array2string(ev, precision=6)}", flush=True)
    return ev, resid


if __name__ == '__main__':
    blocks = [2] * 5
    W, n = c5_operator(blocks)
    QW = Q(n, W)
    th = float(np.tensordot(QW, W))
    print(f"C_5 blow-up, blocks {tuple(blocks)}, n = {n}, theta = {th:.9f}", flush=True)
    print(f"  criticality residual {np.linalg.norm(QW - th * W):.2e}", flush=True)

    S0 = sym0_basis(n)
    full, _ = spectrum_on(n, W, th, S0, "FULL Sym_0")
    vals, cnt = np.unique(np.round(full, 6), return_counts=True)
    print(f"    distinct: {dict(zip(vals, cnt))}", flush=True)

    e4, _ = spectrum_on(n, W, th, torus_invariants(n, blocks, True),
                        "torus invariants of Sym_0  (predicted dim 4)")
    e5, _ = spectrum_on(n, W, th, torus_invariants(n, blocks, False),
                        "torus invariants of Sym, trace INCLUDED (predicted dim 5)")

    print("\n  Are the values eigenvalues of L_e on the full space?", flush=True)
    for name, ev in (("dim-4 set", e4), ("dim-5 set", e5)):
        hits = [bool(np.min(np.abs(full - v)) < 1e-6) for v in ev]
        print(f"    {name}: {sum(hits)}/{len(ev)} lie in the full spectrum", flush=True)
    print(f"\n  r301 reports dim 4, values {{0.441754, 0.820541}}", flush=True)
    print(f"  record's rival build reports dim 5, values "
          f"{{0.152312, 0.274865, 0.413011, 0.516880, 0.601823}}", flush=True)
