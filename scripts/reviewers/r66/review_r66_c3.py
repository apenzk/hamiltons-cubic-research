"""Reviewer 66 / C3: rigidity at the cap, tested constructively rather than by
fitting a group element.

For the symmetric pair m = off-diagonal block of so(p)+so(q), k = [m,m] equals
so(p)+so(q) exactly, and k acting on R^n has precisely two invariant subspaces.
So: draw a random isotropic subspace of dimension floor(n^2/4), form k = [m,m],
compute the commutant of k inside the symmetric matrices on R^n, read off the
isotypic decomposition R^n = V + V', and check that m is *exactly* the space of
skew maps swapping V and V'.  That either produces the conjugating rotation or
exhibits a genuinely inequivalent subspace.
"""
import sys
import numpy as np
from review_r66_core import basis, ip, omega_tensor, isotropy_mass, symmetric_pair
from review_r66_c2_search import hunt


def to_matrices(V, B):
    return [sum(V[t, c] * B[t] for t in range(V.shape[0])) for c in range(V.shape[1])]


def bracket_algebra(mats, tol=1e-8):
    """Basis (as n x n matrices) of span{[u,v]}."""
    n = mats[0].shape[0]
    rows = []
    for i in range(len(mats)):
        for j in range(i + 1, len(mats)):
            C = mats[i] @ mats[j] - mats[j] @ mats[i]
            rows.append(C.ravel())
    A = np.array(rows)
    u, s, vt = np.linalg.svd(A, full_matrices=False)
    r = int((s > tol * max(1.0, s[0])).sum())
    return [vt[k].reshape(n, n) for k in range(r)]


def commutant_symmetric(ks, n, tol=1e-8):
    """Symmetric n x n matrices commuting with every element of ks."""
    idx = [(i, j) for i in range(n) for j in range(i, n)]
    basis_sym = []
    for (i, j) in idx:
        M = np.zeros((n, n)); M[i, j] = 1.0; M[j, i] = 1.0
        basis_sym.append(M)
    rows = []
    for K in ks:
        for M in basis_sym:
            rows.append((K @ M - M @ K).ravel())
    A = np.array(rows).reshape(len(ks), len(basis_sym), n * n)
    A = np.transpose(A, (0, 2, 1)).reshape(-1, len(basis_sym))
    _, s, vt = np.linalg.svd(A)
    nul = int((s < tol * max(1.0, s[0])).sum()) + (len(basis_sym) - len(s))
    return [sum(vt[-(k + 1)][t] * basis_sym[t] for t in range(len(basis_sym)))
            for k in range(nul)], nul


def test(n, seed, V=None):
    B, _ = basis(n)
    W, _ = omega_tensor(n)
    N, cap = W.shape[0], n * n // 4
    if V is None:
        mass, V = hunt(n, cap, starts=6, seed=seed, verbose=False)
        if mass > 1e-18:
            return None, f"no cap isotropic found (mass {mass:.1e})"
    mats = to_matrices(V, B)
    ks = bracket_algebra(mats)
    comm, nul = commutant_symmetric(ks, n)
    if nul != 2:
        return False, f"commutant of [m,m] on R^n has dim {nul} (symmetric pair: 2)"
    # isotypic projectors: diagonalise a generic element of the commutant
    G = comm[0] + 0.6180339887 * comm[1]
    w, U = np.linalg.eigh(G)
    # cluster eigenvalues
    groups, cur = [], [0]
    for t in range(1, n):
        if abs(w[t] - w[t - 1]) < 1e-6 * max(1.0, abs(w[t])):
            cur.append(t)
        else:
            groups.append(cur); cur = [t]
    groups.append(cur)
    dims = sorted(len(g) for g in groups)
    if len(groups) != 2:
        return False, f"isotypic decomposition has {len(groups)} blocks, dims {dims}"
    # in the basis U, is m exactly the off-diagonal block?
    p = len(groups[0])
    perm = np.array(groups[0] + groups[1])
    Uo = U[:, perm]
    off = 0.0; on = 0.0
    for M in mats:
        Mp = Uo.T @ M @ Uo
        on = max(on, np.abs(Mp[:p, :p]).max(), np.abs(Mp[p:, p:]).max())
        off = max(off, np.abs(Mp[:p, p:]).max())
    ok = on < 1e-7 * max(1.0, off)
    return ok, (f"split {p}+{n-p}, dim m={V.shape[1]}=p*q={p*(n-p)}, "
                f"max |block-diagonal part| = {on:.2e} (off-block scale {off:.2e}), "
                f"det(U)={np.linalg.det(Uo):+.3f}")


if __name__ == '__main__':
    for n in [int(a) for a in sys.argv[1:]] or [5, 6, 7]:
        cap = n * n // 4
        print(f"\n### so({n}) cap dim {cap}", flush=True)
        # control: the symmetric pair itself, and a random SO(n)-rotation of it
        ok, msg = test(n, 0, V=symmetric_pair(n, n // 2))
        print(f"  control (symmetric pair as given): {ok} | {msg}", flush=True)
        good = 0; tot = 0
        for s in range(12):
            r = test(n, 5000 + 37 * s)
            if r[0] is None:
                print(f"  draw {s}: {r[1]}", flush=True); continue
            tot += 1; good += bool(r[0])
            if not r[0]:
                print(f"  draw {s}: NOT a symmetric pair -> {r[1]}", flush=True)
        print(f"  random cap isotropics conjugate to the symmetric pair: {good}/{tot}", flush=True)
