"""r230 claims 3-5."""
import numpy as np, itertools, importlib.util, os, io, contextlib
sp = importlib.util.spec_from_file_location("c1", os.path.join(os.path.dirname(__file__), "c1_li_external.py"))
c1 = importlib.util.module_from_spec(sp); 
with contextlib.redirect_stdout(io.StringIO()): sp.loader.exec_module(c1)
ring_li, diag_curv, s20_basis = c1.ring_li, c1.diag_curv, c1.s20_basis
rng = np.random.default_rng(11)

print("=== claim 3: does the B_n screen fire when n_0 is planted at 1? ===")
def signed_perm(n, rs):
    P = np.zeros((n, n))
    for i, j in enumerate(rs.permutation(n)): P[i, j] = rs.choice([-1.0, 1.0])
    return P
for n, n0 in ((6, 1), (12, 1), (6, 2), (8, 3)):
    reached = set()
    for _ in range(4000):
        P = signed_perm(n, rng)
        img = sorted(int(np.flatnonzero(P[:, k])[0]) for k in range(n0))
        for a in range(len(img)):
            for b in range(a + 1, len(img)): reached.add((img[a], img[b]))
    total = n * (n - 1) // 2
    print(f"  n={n:>3} n_0={n0}: reached {len(reached):>3} of {total:>3}  -> "
          f"{'assert FIRES' if len(reached) != total else 'assert passes'}")

print("\n=== claim 3b: does the block O(n_0) plus B_n actually generate O(n)? numerical closure test ===")
def close_group_dim(n, n0, trials=4000):
    """Lie-algebra span reached: so(n_0) block conjugated by permutations. dim so(n) = n(n-1)/2."""
    gens = []
    for a in range(n0):
        for b in range(a + 1, n0):
            A = np.zeros((n, n)); A[a, b] = 1; A[b, a] = -1; gens.append(A)
    span = []
    for _ in range(trials):
        P = signed_perm(n, rng)
        for A in gens: span.append((P @ A @ P.T).ravel())
    if not span: return 0
    return np.linalg.matrix_rank(np.array(span), tol=1e-9)
for n, n0 in ((6, 1), (6, 2), (8, 3), (12, 2), (12, 4)):
    d = close_group_dim(n, n0)
    print(f"  n={n:>3} n_0={n0}: span of conjugated block so({n0}) has dim {d:>3}; dim so(n) = {n*(n-1)//2:>3}"
          f"  -> {'generates SO(n)' if d == n*(n-1)//2 else 'DOES NOT'}")

print("\n=== claim 5: is p_2 = (3/4)|R|^2 really true for EVERY algebraic curvature tensor? ===")
def s2_full_basis(n): return s20_basis(n) + [np.eye(n) / np.sqrt(n)]
def ring_full(R):
    B = s2_full_basis(R.shape[0])
    return np.array([[np.einsum('ijkl,il,jk->', R, a, b) for b in B] for a in B])
def random_acv(n, ricci_flat):
    A = rng.standard_normal((n, n, n, n))
    R = A - A.transpose(1, 0, 2, 3); R = R - R.transpose(0, 1, 3, 2); R = R + R.transpose(2, 3, 0, 1)
    R = R - (R + R.transpose(1, 2, 0, 3) + R.transpose(2, 0, 1, 3)) / 3
    if not ricci_flat: return R
    g = np.eye(n); Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric); E = Ric - s / n * g
    KN = lambda A, B: (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                       - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    return R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)
def sphere(n): return diag_curv(np.ones((n, n)) - np.eye(n))
cases = [("round S^6 (NOT Ricci-flat)", sphere(6)),
         ("round S^7 (NOT Ricci-flat)", sphere(7)),
         ("S^3xS^3 full R (NOT Ricci-flat)", diag_curv(np.block([[np.ones((3,3))-np.eye(3), np.zeros((3,3))],[np.zeros((3,3)), np.ones((3,3))-np.eye(3)]]))),
         ("random ACT n=6 (NOT Ricci-flat)", random_acv(6, False)),
         ("random Weyl n=6 (Ricci-flat)", random_acv(6, True)),
         ("random Weyl n=7 (Ricci-flat)", random_acv(7, True))]
print(f"  {'case':34s} {'tr(Rring0^2) on S^2_0':>22} {'(3/4)|R|^2':>12} {'tr on full S^2':>15}")
for lab, R in cases:
    nn = R.shape[0]
    Op0 = ring_li(R); Opf = ring_full(R)
    nrm = np.einsum('ijkl,ijkl->', R, R)
    print(f"  {lab:34s} {np.trace(Op0@Op0):>22.6f} {0.75*nrm:>12.6f} {np.trace(Opf@Opf):>15.6f}")
