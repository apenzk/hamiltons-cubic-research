"""r261 claim 1 -- is "the theorem is UNCONDITIONAL in n" correct AS WRITTEN?

The record's argument is: the double centraliser, "needing only complete
reducibility of the O(n)-action, which holds at every n in characteristic zero",
makes nu(B_f(n)) = sum_lambda End(M_lambda) with every M_lambda irreducible.

The hypotheses that argument actually needs are THREE, not one:

  (H1) V^{tensor f} is a SEMISIMPLE module over the group -- complete
       reducibility, which is what the record names.  True for O(n) in
       characteristic zero (O(n) is reductive / has a compact real form).
  (H2) the image is the FULL commutant End_{O(n)}(V^{tensor f}) -- this is the
       FFT (Brauer 1937), unconditional in n, and it is a SEPARATE input from
       the double centraliser.  Without it the image is only a subalgebra of
       the commutant and nothing forces M_lambda to be simple over it.
  (H3) each V_lambda occurring is ABSOLUTELY irreducible, i.e.
       End_{O(n)}(V_lambda) is the ground field.  This is what turns the
       commutant into a sum of FULL matrix algebras End(M_lambda).

This file tests (H2) below every threshold, and tests (H3) at the place the
brief names -- lambda with n/2 rows, the self-associate/chirality case -- both
for O(n), where the claim holds, and for SO(n), where the SAME argument fails
with an explicit witness.
"""
import numpy as np
from itertools import permutations

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def loops_uf(D, E, f):
    par = list(range(2*f))
    def find(x):
        while par[x] != x:
            par[x] = par[par[x]]
            x = par[x]
        return x
    for a, b in tuple(D) + tuple(E):
        ra, rb = find(a), find(b)
        if ra != rb:
            par[ra] = rb
    return len({find(x) for x in range(2*f)})

def rank_mod_np(M, q=1000003):
    """rank over F_q of an integer matrix, vectorised."""
    A = np.array(M, dtype=np.int64) % q
    rows, cols = A.shape
    r = 0
    for c in range(cols):
        piv = np.nonzero(A[r:, c])[0]
        if piv.size == 0:
            continue
        p = r + piv[0]
        if p != r:
            A[[r, p]] = A[[p, r]]
        A[r] = (A[r] * pow(int(A[r, c]), q - 2, q)) % q
        col = A[:, c].copy()
        col[r] = 0
        nz = np.nonzero(col)[0]
        if nz.size:
            A[nz] = (A[nz] - np.outer(col[nz], A[r])) % q
        r += 1
        if r == rows:
            break
    return r

def gram_image_dim(f, n):
    Ds = list(matchings(tuple(range(2*f))))
    G = [[n ** loops_uf(D, E, f) for E in Ds] for D in Ds]
    return rank_mod_np(G), len(Ds)

# ---------------------------------------------------------------- the group

def so_gens(n):
    """basis of so(n): E_ij - E_ji."""
    out = []
    for i in range(n):
        for j in range(i+1, n):
            X = np.zeros((n, n))
            X[i, j], X[j, i] = 1.0, -1.0
            out.append(X)
    return out

def act_lie(X, m, n):
    """the so(n) element X acting as a derivation on V^{tensor m}."""
    dim = n ** m
    A = np.zeros((dim, dim))
    for slot in range(m):
        left, right = n ** slot, n ** (m - slot - 1)
        A += np.kron(np.kron(np.eye(left), X), np.eye(right))
    return A

def act_group(g, m, n):
    """g in O(n) acting as g tensor ... tensor g."""
    A = np.eye(1)
    for _ in range(m):
        A = np.kron(A, g)
    return A

def invariants(m, n, orthogonal=True):
    """a basis of the invariants of V^{tensor m}, as the columns of a matrix.

    O(n)-invariance = killed by every so(n) generator AND fixed by one
    reflection (the reflection is what distinguishes O(n) from SO(n)).
    """
    dim = n ** m
    blocks = [act_lie(X, m, n) for X in so_gens(n)]
    if orthogonal:
        refl = np.diag([-1.0] + [1.0] * (n - 1))
        blocks.append(act_group(refl, m, n) - np.eye(dim))
    M = np.vstack(blocks) if blocks else np.zeros((1, dim))
    u, s, vt = np.linalg.svd(M)
    tol = max(M.shape) * (s[0] if s.size else 1.0) * 1e-12
    null = vt[np.sum(s > tol):]
    return null.T                                  # dim x nullity

# ============================ (H2) the FFT below the threshold, without Brauer

print("(H2) is the diagram image the FULL commutant, at n BELOW every threshold?")
print("     dim End_{O(n)}(V^f) is computed as dim Inv_{O(n)}(V^{2f}) from the")
print("     Lie algebra and a reflection -- no diagram enters that number.")
print(f"     {'f':>2} {'n':>2} {'dim nu (Gram)':>14} {'dim Inv_O(V^2f)':>16} "
      f"{'n>=f-1':>7} {'n>=f':>6}")
for (f, n) in [(2, 2), (2, 3), (2, 4), (2, 5), (3, 2), (3, 3), (4, 2)]:
    d_gram, _ = gram_image_dim(f, n)
    d_comm = invariants(2*f, n).shape[1]
    print(f"     {f:>2} {n:>2} {d_gram:>14} {d_comm:>16} {str(n >= f-1):>7} {str(n >= f):>6}")
    assert d_gram == d_comm, "the image is NOT the full commutant here"
print("     every cell agrees, including (4,2) and (3,2) where B_f(n) is not")
print("     semisimple and (4,2) where nu is not injective -- the FFT is what")
print("     carries this, and it carries it with no inequality.\n")

# ================= (H3) the self-associate case: O(n) holds, SO(n) does NOT

print("(H3) lambda with n/2 rows -- the associate/chirality case.")
n, f = 4, 4
inv_O = invariants(f, n, orthogonal=True)
inv_SO = invariants(f, n, orthogonal=False)
print(f"     n=4, f=4: dim Inv_O(4) = {inv_O.shape[1]}, dim Inv_SO(4) = {inv_SO.shape[1]}")

# the Levi-Civita tensor: an SO(4) invariant that is not an O(4) invariant.
eps = np.zeros(n ** f)
for p in permutations(range(n)):
    sgn = 1
    pl = list(p)
    for i in range(n):
        for j in range(i+1, n):
            if pl[i] > pl[j]:
                sgn = -sgn
    eps[sum(p[k] * n ** (f - 1 - k) for k in range(f))] = sgn

def nu_matrix(D, m, n):
    dim = n ** m
    idx = [tuple((k // n ** (m - 1 - p)) % n for p in range(m)) for k in range(dim)]
    M = np.zeros((dim, dim))
    for r, j in enumerate(idx):
        for c, i in enumerate(idx):
            lab = j + i
            if all(lab[a] == lab[b] for a, b in D):
                M[r, c] = 1.0
    return M

Ds = list(matchings(tuple(range(2*f))))
ops = [nu_matrix(D, f, n) for D in Ds]
span_eps = np.column_stack([A @ eps for A in ops])
delta = np.zeros(n ** f)
for a in range(n):
    for b in range(n):
        delta[a*n**3 + a*n**2 + b*n + b] = 1.0
span_del = np.column_stack([A @ delta for A in ops])
r_eps = np.linalg.matrix_rank(span_eps, tol=1e-9)
r_del = np.linalg.matrix_rank(span_del, tol=1e-9)
print(f"     span{{ nu(D) . eps }}   = {r_eps} of the {inv_SO.shape[1]}-dimensional SO(4) multiplicity space")
print(f"     span{{ nu(D) . delta }} = {r_del} of the {inv_SO.shape[1]}-dimensional SO(4) multiplicity space")
print(f"     over O(4) the same seed delta gives {r_del} of {inv_O.shape[1]} -- the whole space.")
print("     SO(4) WITNESS: the multiplicity space of the trivial label in V^{tensor 4}")
print("     is 4-dimensional for SO(4) and the diagram image cannot reach eps, so")
print("     M_lambda is REDUCIBLE over the image there and no seed generates it.")
print("     The record's theorem survives only because the group is O(n): the")
print("     Levi-Civita direction is exactly the associate/chirality pair, and it")
print("     is O(n)-non-invariant.  A1's SO(n) scope note is where this bites.\n")

# ================= the same question one block up: lambda = (1,1) at n = 4

print("(H3b) a SELF-ASSOCIATE block over O(4): lambda = (1,1), lambda'_1 = 2 = n/2.")
n, f = 4, 4
inv6 = invariants(f + 2, n, orthogonal=True)          # Inv(V^{tensor 6})
print(f"      dim Inv_O(4)(V^6) = {inv6.shape[1]}")
dim6 = n ** (f + 2)
sw = np.zeros((dim6, dim6))                            # swap legs 1 and 2
for k in range(dim6):
    t = [(k // n ** (5 - p)) % n for p in range(6)]
    t[0], t[1] = t[1], t[0]
    sw[sum(t[p] * n ** (5 - p) for p in range(6)), k] = 1.0
A12 = (np.eye(dim6) - sw) / 2.0                        # projector onto Lambda^2 in legs 1,2
M_lam = A12 @ inv6
r_M = np.linalg.matrix_rank(M_lam, tol=1e-9)
print(f"      dim M_(1,1) = dim A_12 . Inv(V^6) = {r_M}")

def nu_on_tail(D, n):
    """nu(D) acting on legs 3..6 of V^{tensor 6}, identity on legs 1,2."""
    return np.kron(np.eye(n * n), nu_matrix(D, 4, n))

tail_ops = [nu_on_tail(D, n) for D in matchings(tuple(range(8)))]
basis = np.linalg.svd(M_lam)[0][:, :r_M]
rng = np.random.default_rng(7)
worst = []
for trial in range(12):
    coeffs = rng.standard_normal(r_M) if trial else np.array([1.0] + [0.0]*(r_M-1))
    c0 = basis @ coeffs
    sp = np.column_stack([A @ c0 for A in tail_ops])
    worst.append(np.linalg.matrix_rank(sp, tol=1e-9))
print(f"      span{{ nu(D) c_0 }} over 12 seeds (one a basis vector, 11 random): "
      f"{sorted(set(worst))} against dim M = {r_M}")
print("      one seed generates the whole self-associate block over O(4) --")
print("      (H3) holds for O(n), which is the group the theorem is stated for.")
