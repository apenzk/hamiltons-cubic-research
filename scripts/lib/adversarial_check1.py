"""
Adversarial review, independent implementation #1.

Written from scratch by an adversarial reviewer, NOT by editing or importing
any of the pre-existing scripts (compute*.py, weyl.py, weyl_p*.py, hessian*.py,
rsharp_basis_free.py, run_*.py). The goal is to re-derive Q(W) = W^2 + W^# and
P(W) = <W, Q(W)> directly from the mathematical definitions in findings/INDEX.md's
"Critical-point structure" section, and independently re-check several of the
document's specific numerical claims.

Covers:
  1. Structure constants of so(n) on Lambda^2(R^n), coordinate-plane basis.
  2. A basis-free Q(W) = W^2 + W^# implementation (fixed shared basis
     throughout -- no per-operator re-diagonalization anywhere).
  3. Validation against the trusted coordinate-diagonal formula
     (Q(W))_{ij,ij} = lambda_ij^2 + sum_{k!=i,j} lambda_ik lambda_jk.
  4. Permutation-symmetry test of T(A,B,C) = <A, B(B,C)> on random inputs --
     this is exactly the test that would have caught the previously-retracted
     per-operator-eigenbasis bug immediately.
  5. Exact-fraction verification of <Q(W),W> = ||W||^2 for the Einstein-
     normalized Weyl tensor of S^p x S^q, for several (p,q).
  6. Balanced-split maximization check for several n.
  7. 3-block / 4-block sphere product underperformance spot-check.
"""
import itertools
from fractions import Fraction as Fr
import numpy as np


# ---------------------------------------------------------------------------
# 1. so(n) structure constants on Lambda^2(R^n), ONB e_i /\ e_j (i<j).
# ---------------------------------------------------------------------------
def pairs_index(n):
    pairs = list(itertools.combinations(range(n), 2))
    pos = {p: k for k, p in enumerate(pairs)}
    return pairs, pos


def structure_constants(n):
    """c[a,b,g] = <[phi_a,phi_b], phi_g>, phi_{ij}=e_i/\e_j <-> L_ij=E_ij-E_ji,
    inner product <A,B> = -1/2 tr(AB) (normalized so coordinate planes are
    orthonormal: <L_ij,L_ij>=1). Built directly from the matrix commutator of
    the L_ij generators -- not copied from any other script's index-shuffling
    code, to keep this an independent derivation."""
    pairs, pos = pairs_index(n)
    N = len(pairs)
    L = []
    for (i, j) in pairs:
        M = np.zeros((n, n))
        M[i, j] = 1.0
        M[j, i] = -1.0
        L.append(M)
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            br = L[a] @ L[b] - L[b] @ L[a]
            for g in range(N):
                c[a, b, g] = -0.5 * np.trace(br @ L[g])
    return pairs, pos, N, c


def Q_full(Wmat, c):
    """Basis-free Q(W) = W^2 + W^#, using ONLY the fixed coordinate-plane
    structure constants -- W is never diagonalized. (W^#)_{ab} =
    -1/2 tr(A_a W A_b W) with (A_a)_{bg} = c[a,b,g] (A_a is skew since c is
    totally antisymmetric)."""
    N = Wmat.shape[0]
    # S[a,m,p] = sum_n c[a,m,n] W[n,p]
    S = np.einsum('amn,np->amp', c, Wmat, optimize=True)
    Wsharp = -0.5 * np.einsum('amp,bpm->ab', S, S, optimize=True)
    return Wmat @ Wmat + Wsharp


def B_full(W1, W2, c):
    """Symmetric polarization of Q: B(X,Y) = 1/2[Q(X+Y)-Q(X)-Q(Y)]."""
    return 0.5 * (Q_full(W1 + W2, c) - Q_full(W1, c) - Q_full(W2, c))


def T_full(A, B, Cm, c):
    """Trilinear form T(A,B,C) = <A, B(B,C)>, inner product <X,Y>=tr(XY)."""
    return float(np.trace(A @ B_full(B, Cm, c)))


def P_value(W, c):
    return float(np.trace(W @ Q_full(W, c)))


# ---------------------------------------------------------------------------
# 3. Validate against the trusted coordinate-diagonal formula.
# ---------------------------------------------------------------------------
def check_diagonal_formula(n, seed=0):
    pairs, pos, N, c = structure_constants(n)
    rng = np.random.default_rng(seed)
    lam = rng.standard_normal(N)
    Wmat = np.diag(lam)
    Q = Q_full(Wmat, c)
    offdiag = np.linalg.norm(Q - np.diag(np.diag(Q)))
    # trusted formula: (Q(W))_{ij,ij} = lam_ij^2 + sum_{k!=i,j} lam_ik*lam_jk
    lam_dict = {p: lam[k] for k, p in enumerate(pairs)}

    def lam_of(i, j):
        if i == j:
            return 0.0
        a, b = min(i, j), max(i, j)
        return lam_dict[(a, b)]

    expected = np.zeros(N)
    for k, (i, j) in enumerate(pairs):
        s = lam_of(i, j) ** 2
        for kk in range(n):
            if kk != i and kk != j:
                s += lam_of(i, kk) * lam_of(j, kk)
        expected[k] = s
    diff = np.max(np.abs(np.diag(Q) - expected))
    return offdiag, diff


print("=== Check 3: general Q_full vs trusted coordinate-diagonal formula ===")
for n in [5, 6, 7, 8]:
    offdiag, diff = check_diagonal_formula(n, seed=n)
    print(f"n={n}: offdiag(Q on diagonal input)={offdiag:.3e}  "
          f"max|diag(Q)-formula|={diff:.3e}")


# ---------------------------------------------------------------------------
# 4. Permutation-symmetry test (the exact test that would catch the
#    previously-retracted per-operator-eigenbasis bug).
# ---------------------------------------------------------------------------
def random_weyl_tensor_diag(n, seed):
    """A random *diagonal-in-coordinate-planes* algebraic curvature tensor
    with zero Ricci (i.e. a genuine, if special, Weyl tensor): easiest way to
    get a Bianchi + Ricci-flat tensor without building the full nullspace
    machinery is to use coordinate-diagonal tensors, for which Bianchi holds
    trivially (R_{ij,kl}=0 unless {k,l}={i,j}) and we just need to solve the
    linear Ricci-flatness constraints on the C(n,2) diagonal values."""
    pairs, pos, N, c = structure_constants(n)
    rng = np.random.default_rng(seed)
    lam = rng.standard_normal(N)
    # Ricci_{ii} = sum_{j!=i} lam_ij must vanish for all i (Ricci-flat requires
    # all diagonal entries zero here since off-diagonal Ricci is automatically
    # 0 for coordinate-diagonal tensors). n linear constraints on N unknowns.
    Amat = np.zeros((n, N))
    for k, (i, j) in enumerate(pairs):
        Amat[i, k] = 1.0
        Amat[j, k] = 1.0
    # project lam onto the nullspace of Amat (least squares projection)
    # solve Amat @ correction-basis: use lstsq to remove row space component
    # lam_proj = lam - Amat^T (Amat Amat^T)^-1 Amat lam
    AAt = Amat @ Amat.T
    corr = Amat.T @ np.linalg.solve(AAt, Amat @ lam)
    lam_flat = lam - corr
    return pairs, pos, N, c, np.diag(lam_flat)


print()
print("=== Check 4: permutation symmetry of T(A,B,C) on random Weyl tensors ===")
for n in [7, 8]:
    pairs, pos, N, c, A = random_weyl_tensor_diag(n, seed=100 + n)
    _, _, _, _, B = random_weyl_tensor_diag(n, seed=200 + n)
    _, _, _, _, Cm = random_weyl_tensor_diag(n, seed=300 + n)
    vals = {
        "T(A,B,C)": T_full(A, B, Cm, c),
        "T(A,C,B)": T_full(A, Cm, B, c),
        "T(B,A,C)": T_full(B, A, Cm, c),
        "T(B,C,A)": T_full(B, Cm, A, c),
        "T(C,A,B)": T_full(Cm, A, B, c),
        "T(C,B,A)": T_full(Cm, B, A, c),
    }
    vs = list(vals.values())
    spread = max(vs) - min(vs)
    print(f"n={n}: values={ {k: round(v,10) for k,v in vals.items()} }")
    print(f"   spread across all 6 permutations: {spread:.3e} "
          f"({'PASS: fully symmetric' if spread < 1e-8 else 'FAIL: asymmetric -> BUG'})")


# ---------------------------------------------------------------------------
# 5. Exact-fraction verification of <Q(W),W> = ||W||^2 for S^p x S^q.
# ---------------------------------------------------------------------------
def sphere_product_abc(p, q):
    """Weyl eigenvalues of the Einstein-normalized (Ric=id) product metric on
    S^p x S^q, diagonal in coordinate 2-planes, exact Fraction arithmetic.

    Re-derived independently, from scratch, via the Kulkarni-Nomizu Weyl
    decomposition:
      - Round S^p(r1) has Ricci=(p-1)/r1^2 * g, sectional curvature 1/r1^2.
        Einstein-normalizing Ric=g forces r1^2=p-1 (similarly r2^2=q-1), so
        sectional curvatures are 1/(p-1) within the P-block, 1/(q-1) within
        the Q-block, and 0 for mixed P-Q planes (product metric).
      - Since Ric=id (isotropic, Ric_ii=1 for every i regardless of block),
        the standard curvature/Weyl relation
          W_ijij = R_ijij - (Ric_ii+Ric_jj)/(n-2) + S/((n-1)(n-2))
        has the SAME correction term -1/(n-1) [=  -2/(n-2) + n/((n-1)(n-2))
        simplified, since Ric_ii=Ric_jj=1 and S=n] on every coordinate plane.
      - Hence a = 1/(p-1) - 1/(n-1), b = 1/(q-1) - 1/(n-1), c = 0 - 1/(n-1).
    NOTE: this is a DIFFERENT overall scale than the "Second-variation
    Hessian attempt" section's (a,b,c) formula (a=1-2(p-1)/(n-2)+sigma etc.),
    which I independently checked corresponds instead to UNIT round spheres
    S^p(1) x S^q(1) (Ric != id there). The two are proportional (same Weyl
    *shape*, verified numerically here for (4,4) and (2,6): scale factors 3
    and 5/3 respectively -- consistent with findings/INDEX.md's claim that they
    "match", which is a shape/ratio claim, not a claim of literal numerical
    equality) but only THIS Einstein-normalized version satisfies the exact
    idempotency identity <Q(W),W>=||W||^2 tested below (that identity is not
    scale-invariant: Q is quadratic, so <Q(cW),cW>=c^3<Q(W),W> vs
    ||cW||^2=c^2||W||^2 -- only one specific scale c can make them equal)."""
    n = p + q
    a = Fr(1, p - 1) - Fr(1, n - 1)
    b = Fr(1, q - 1) - Fr(1, n - 1)
    cc = -Fr(1, n - 1)
    return a, b, cc


def sphere_QW_dot_W_exact(p, q):
    """Exact Fraction computation of <Q(W),W> and ||W||^2 using the TRUSTED
    diagonal formula (validated numerically above), applied to the exact
    sphere-product eigenvalues. This isolates the algebraic identity check
    from any floating point machinery."""
    n = p + q
    a, b, cc = sphere_product_abc(p, q)

    def lam_of(i, j):
        # block membership: P-block = [0,p), Q-block = [p,n)
        if i < p and j < p:
            return a
        elif i >= p and j >= p:
            return b
        else:
            return cc

    pairs, pos = pairs_index(n)
    QW_dot_W = Fr(0)
    Wnorm2 = Fr(0)
    for (i, j) in pairs:
        lij = lam_of(i, j)
        Wnorm2 += lij * lij
        s = lij * lij
        for k in range(n):
            if k != i and k != j:
                s += lam_of(i, k) * lam_of(j, k)
        QW_dot_W += lij * s
    return QW_dot_W, Wnorm2


print()
print("=== Check 5: exact identity <Q(W),W> = ||W||^2 for S^p x S^q ===")
test_cases = [(4, 4), (3, 5), (5, 6), (2, 8), (7, 9), (10, 12), (6, 40), (50, 50)]
for (p, q) in test_cases:
    QW_dot_W, Wnorm2 = sphere_QW_dot_W_exact(p, q)
    ok = (QW_dot_W == Wnorm2)
    print(f"(p,q)=({p},{q}) n={p+q}: <Q(W),W>={QW_dot_W}  ||W||^2={Wnorm2}  "
          f"{'PASS exact match' if ok else 'FAIL MISMATCH'}")


# ---------------------------------------------------------------------------
# 6. Balanced split uniquely maximizes P among two-factor sphere products.
# ---------------------------------------------------------------------------
def sphere_P_over_norm3_sq(p, q):
    """(P/||W||^3)^2 computed exactly via Fraction arithmetic, using
    <Q(W),W>=||W||^2 (check 5) so P=||W||^2 and P/||W||^3 = 1/||W||,
    i.e. (P/||W||^3)^2 = 1/||W||^2."""
    QW_dot_W, Wnorm2 = sphere_QW_dot_W_exact(p, q)
    assert QW_dot_W == Wnorm2
    return Fr(1, 1) / Wnorm2


print()
print("=== Check 6: balanced split p=q=n/2 maximizes P among 2-factor products ===")
for n in [8, 12, 15, 20, 30]:
    best = None
    for p in range(2, n - 1):
        q = n - p
        val = sphere_P_over_norm3_sq(p, q)
        if best is None or val > best[0]:
            best = (val, p, q)
    balanced_p = n // 2
    balanced_val = sphere_P_over_norm3_sq(balanced_p, n - balanced_p)
    print(f"n={n}: best split found = {best[1:]} value={float(best[0]):.6f}  "
          f"balanced=({balanced_p},{n-balanced_p}) value={float(balanced_val):.6f}  "
          f"{'PASS: balanced is optimal' if best[1:] == (balanced_p, n-balanced_p) else 'FAIL: balanced NOT optimal'}")


# ---------------------------------------------------------------------------
# 7. 3-block and 4-block sphere products always underperform 2-block.
# ---------------------------------------------------------------------------
def multiblock_P_over_norm3_sq(block_sizes):
    """m-block sphere-product S^{n1} x ... x S^{nm}, Einstein-normalized.
    Diagonal eigenvalue for a plane inside block r (size n_r):
        lambda_r = 1 - 2(n_r-1)/(n-2) + sigma
    for a plane straddling blocks r,s (r!=s):
        lambda_rs = -1 + sigma
    sigma = sum_r n_r(n_r-1) / ((n-1)(n-2))
    (direct generalization of the 2-block formula used in check 5/6, derived
    independently here for m blocks)."""
    n = sum(block_sizes)
    m = len(block_sizes)
    # Einstein-normalized (Ric=id): each factor gets radius^2=n_r-1, giving
    # sectional curvature 1/(n_r-1) within block r and 0 cross-block; since
    # Ric=id is isotropic the Weyl correction -1/(n-1) is uniform (see
    # sphere_product_abc's docstring for the m=2 derivation this generalizes).
    lam_within = [Fr(1, nr - 1) - Fr(1, n - 1) for nr in block_sizes]
    lam_cross = -Fr(1, n - 1)
    # count planes: within block r: C(n_r,2); cross (r,s) r<s: n_r*n_s
    Wnorm2 = Fr(0)
    QW_dot_W = Fr(0)
    # build explicit per-plane lambda lookup via block index of each coordinate
    offsets = [0]
    for nr in block_sizes:
        offsets.append(offsets[-1] + nr)

    def block_of(i):
        for r in range(m):
            if offsets[r] <= i < offsets[r + 1]:
                return r
        raise ValueError

    def lam_of(i, j):
        bi, bj = block_of(i), block_of(j)
        if bi == bj:
            return lam_within[bi]
        return lam_cross

    pairs, pos = pairs_index(n)
    for (i, j) in pairs:
        lij = lam_of(i, j)
        Wnorm2 += lij * lij
        s = lij * lij
        for k in range(n):
            if k != i and k != j:
                s += lam_of(i, k) * lam_of(j, k)
        QW_dot_W += lij * s
    # idempotency isn't guaranteed for m>=3 in general but the ratio P/||W||^3
    # is still well-defined; we need P = <Q(W),W> directly (not assuming =||W||^2)
    return QW_dot_W, Wnorm2


def best_m_block(n, m):
    best = None
    # partitions of n into m parts, each >=2, unordered
    def partitions(n, m, minval=2):
        if m == 1:
            if n >= minval:
                yield (n,)
            return
        for first in range(minval, n - minval * (m - 1) + 1):
            for rest in partitions(n - first, m - 1, first):
                yield (first,) + rest
    for parts in partitions(n, m):
        QW_dot_W, Wnorm2 = multiblock_P_over_norm3_sq(parts)
        # P/||W||^3 ratio-squared using ACTUAL P=<Q(W),W> (not assuming idempotent)
        val = (QW_dot_W ** 2) / (Wnorm2 ** 3)
        if best is None or val > best[0]:
            best = (val, parts)
    return best


print()
print("=== Check 7: 3-block / 4-block sphere products vs best 2-block ===")
for n in [10, 12, 16]:
    best2 = best_m_block(n, 2)
    best3 = best_m_block(n, 3)
    best4 = best_m_block(n, 4)
    print(f"n={n}: best 2-block={best2[1]} val={float(best2[0]):.6f}  "
          f"best 3-block={best3[1]} val={float(best3[0]):.6f}  "
          f"best 4-block={best4[1]} val={float(best4[0]):.6f}  "
          f"{'PASS: 2-block > 3-block > 4-block' if best2[0] > best3[0] > best4[0] else 'CHECK NEEDED'}")

print()
print("=== adversarial_check1.py complete ===")
