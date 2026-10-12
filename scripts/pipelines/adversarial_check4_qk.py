"""
Adversarial Reviewer 3 check on the quaternionic-Kaehler (QK) claim in
findings/INDEX.md's three "Quaternionic-Kahler check" sections.

Written FRESH, from scratch: does NOT import curvature_operator.py,
weyl_decomposition.py, run_qk_from_scratch.py, or run_hpm_qk.py. All of
Lambda^2(R^n)/so(n) bracket machinery, the R^2+R# operator, the Ricci/Weyl
decomposition, the quaternion structure, and the Kulkarni-Nomizu tensor
construction are re-implemented here independently, each validated against
an independent sanity check before being trusted (per this project's own
established practice), specifically to test whether the THREE "independent"
QK agents' shared use of curvature_operator.py/weyl_decomposition.py could
be hiding a common bug that only manifests in the m>=2 (non-coordinate-
diagonal, off-diagonal-block) regime those files were not originally
stress-tested on.

Target to reproduce: P/|W|^3 = 1.115547 at n=8 (m=2).
"""
import numpy as np
import itertools

# =================================================================
# 1. Lambda^2(R^n) = so(n), own basis/bracket implementation.
# =================================================================
class Wedge2:
    def __init__(self, n):
        self.n = n
        self.pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
        self.index = {p: a for a, p in enumerate(self.pairs)}
        self.N = len(self.pairs)

    def basis_matrix(self, a):
        i, j = self.pairs[a]
        M = np.zeros((self.n, self.n))
        M[i, j] = 1.0
        M[j, i] = -1.0
        return M

    def entry(self, i, j):
        """signed lookup into pair-index space for arbitrary (i,j), i!=j"""
        if i == j:
            return None, 1.0
        if i < j:
            return self.index[(i, j)], 1.0
        return self.index[(j, i)], -1.0


def build_ad_tensor(W):
    """ad[a] = N x N matrix of bracket-with-basis-vector-a, i.e.
    [E_a, E_b] = sum_c ad[a][c,b] E_c. Built via direct n x n matrix
    commutators (elementary, not reusing any pipeline code)."""
    N = W.N
    Es = [W.basis_matrix(a) for a in range(N)]
    ad = np.zeros((N, N, N))
    for a in range(N):
        for b in range(N):
            C = Es[a] @ Es[b] - Es[b] @ Es[a]
            # decompose C (antisymmetric n x n) into pair-basis coords
            for c, (i, j) in enumerate(W.pairs):
                ad[a, c, b] = C[i, j]
    return ad


def Rsharp(ad, Rmat):
    """<(R#)phi,phi> = -1/2 tr(ad(phi) R ad(phi) R), polarized to the full
    matrix via the standard symmetric bilinear polarization identity.
    ad: N x N x N tensor with ad[a] the N x N matrix of bracket-with-E_a.
    """
    N = Rmat.shape[0]

    def quad(v):
        # build ad(v) = sum_a v[a] * ad[a]
        adv = np.tensordot(v, ad, axes=(0, 0))  # N x N
        M = adv @ Rmat @ adv @ Rmat
        return -0.5 * np.trace(M)

    diag = np.array([quad(np.eye(N)[a]) for a in range(N)])
    Out = np.diag(diag)
    for a in range(N):
        for b in range(a + 1, N):
            v = np.eye(N)[a] + np.eye(N)[b]
            val = quad(v)
            off = 0.5 * (val - diag[a] - diag[b])
            Out[a, b] = off
            Out[b, a] = off
    return Out


def Qop(ad, Rmat):
    return Rmat @ Rmat + Rsharp(ad, Rmat)


def validate_Q_against_diagonal_formula(n, seed=0):
    """Ground truth: for W diagonal in coordinate planes,
    (QW)_{ij,ij} = lam_ij^2 + sum_{k!=i,j} lam_ik lam_jk, and Q(W) stays
    diagonal. This is the project's established trusted anchor."""
    rng = np.random.default_rng(seed)
    W = Wedge2(n)
    ad = build_ad_tensor(W)
    lam = {p: rng.normal() for p in W.pairs}
    Rmat = np.zeros((W.N, W.N))
    for p in W.pairs:
        Rmat[W.index[p], W.index[p]] = lam[p]
    Q = Qop(ad, Rmat)
    worst = 0.0
    for (i, j) in W.pairs:
        known = lam[(i, j)] ** 2
        for k in range(n):
            if k in (i, j):
                continue
            a = (min(i, k), max(i, k))
            b = (min(j, k), max(j, k))
            known += lam[a] * lam[b]
        got = Q[W.index[(i, j)], W.index[(i, j)]]
        worst = max(worst, abs(got - known))
    offmax = np.max(np.abs(Q - np.diag(np.diag(Q))))
    print(f"  [validate] n={n}: worst diag err={worst:.2e}, max off-diag |Q|={offmax:.2e}")
    return worst < 1e-6 and offmax < 1e-6


# =================================================================
# 2. Ricci and Weyl decomposition from a 4-index tensor, own code.
# =================================================================
def ricci_from_tensor(T, n):
    """Ric_{ik} = sum_j T(i,j,k,j)  (standard contraction)."""
    Ric = np.zeros((n, n))
    for i in range(n):
        for k in range(n):
            s = 0.0
            for j in range(n):
                s += T[i, j, k, j]
            Ric[i, k] = s
    return Ric


def weyl_decompose(T, n):
    """Standard formula: T = W + (1/(n-2)) (g (x) Ric)_KN - S/((n-1)(n-2)) (g (x) g)_KN/1
    with g=identity. Returns W as a 4-index array."""
    Ric = ricci_from_tensor(T, n)
    S = np.trace(Ric)
    W = np.zeros_like(T)
    Id = np.eye(n)
    for i, j, k, l in itertools.product(range(n), repeat=4):
        KN_g_Ric = (Id[i, k] * Ric[j, l] - Id[i, l] * Ric[j, k]
                    + Id[j, l] * Ric[i, k] - Id[j, k] * Ric[i, l])
        KN_g_g = (Id[i, k] * Id[j, l] - Id[i, l] * Id[j, k])
        W[i, j, k, l] = T[i, j, k, l] - KN_g_Ric / (n - 2) + S / ((n - 1) * (n - 2)) * KN_g_g
    return W, Ric, S


def tensor_to_pairmat(T, Wg):
    N = Wg.N
    M = np.zeros((N, N))
    for a, (i, j) in enumerate(Wg.pairs):
        for b, (k, l) in enumerate(Wg.pairs):
            M[a, b] = T[i, j, k, l]
    return M


def sanity_sphere_weyl_zero(n):
    Id = np.eye(n)
    T = np.zeros((n, n, n, n))
    for i, j, k, l in itertools.product(range(n), repeat=4):
        T[i, j, k, l] = Id[i, k] * Id[j, l] - Id[i, l] * Id[j, k]
    W, Ric, S = weyl_decompose(T, n)
    print(f"  [validate] round sphere n={n}: max|Weyl|={np.max(np.abs(W)):.2e} "
          f"(expect ~0), Ric_00={Ric[0,0]:.4f} (expect {n-1}), S={S:.4f} (expect {n*(n-1)})")
    return np.max(np.abs(W)) < 1e-8


# =================================================================
# 3. Quaternion structure on R^{4m}, own convention (deliberately
#    different labeling from run_qk_from_scratch.py/run_hpm_qk.py:
#    those use a per-block layout (e0,e1,e2,e3),(e4,..); here we
#    instead build I,J,K via the tensor-product H (x) R^m model,
#    i.e. index k = 4*b + r reinterpreted with a DIFFERENT block
#    internal ordering (r in {0,1,2,3} maps to quaternion units
#    {1,i,j,k} via left-multiplication using the regular
#    representation matrix, built from quaternion multiplication
#    table directly rather than hand-copied signs).
# =================================================================
def quat_mult_table():
    # basis order: 1, i, j, k  (index 0,1,2,3)
    # standard quaternion multiplication table
    tbl = {}
    units = ['1', 'i', 'j', 'k']
    e = {'1': (1, 0), 'i': (1, 1), 'j': (1, 2), 'k': (1, 3),
         '-1': (-1, 0), '-i': (-1, 1), '-j': (-1, 2), '-k': (-1, 3)}
    mult = {
        ('1', '1'): '1', ('1', 'i'): 'i', ('1', 'j'): 'j', ('1', 'k'): 'k',
        ('i', '1'): 'i', ('j', '1'): 'j', ('k', '1'): 'k',
        ('i', 'i'): '-1', ('j', 'j'): '-1', ('k', 'k'): '-1',
        ('i', 'j'): 'k', ('j', 'k'): 'i', ('k', 'i'): 'j',
        ('j', 'i'): '-k', ('k', 'j'): '-i', ('i', 'k'): '-j',
    }
    return units, mult, e


def left_mult_matrix(unit):
    """4x4 real matrix of LEFT multiplication by `unit` in the regular
    representation of H with basis order (1,i,j,k)."""
    units, mult, e = quat_mult_table()
    M = np.zeros((4, 4))
    for c, base in enumerate(units):
        prod = mult[(unit, base)]
        sign, row = e[prod] if prod in e else (1, units.index(prod))
        M[row, c] = sign
    return M


def build_quaternion_structure(n):
    assert n % 4 == 0
    m = n // 4
    Li = left_mult_matrix('i')
    Lj = left_mult_matrix('j')
    Lk = left_mult_matrix('k')
    I = np.zeros((n, n)); J = np.zeros((n, n)); K = np.zeros((n, n))
    for b in range(m):
        sl = slice(4 * b, 4 * b + 4)
        I[sl, sl] = Li
        J[sl, sl] = Lj
        K[sl, sl] = Lk
    return I, J, K


def check_quaternion_relations(I, J, K, n):
    Id = np.eye(n)
    errs = {
        "I^2+Id": np.max(np.abs(I @ I + Id)),
        "J^2+Id": np.max(np.abs(J @ J + Id)),
        "K^2+Id": np.max(np.abs(K @ K + Id)),
        "IJ-K": np.max(np.abs(I @ J - K)),
        "JK-I": np.max(np.abs(J @ K - I)),
        "KI-J": np.max(np.abs(K @ I - J)),
        "IJ+JI": np.max(np.abs(I @ J + J @ I)),
        "I skew": np.max(np.abs(I + I.T)),
        "J skew": np.max(np.abs(J + J.T)),
        "K skew": np.max(np.abs(K + K.T)),
    }
    worst = max(errs.values())
    print(f"  [quat] n={n}: worst relation residual = {worst:.2e}")
    return worst


# =================================================================
# 4. Ishihara/Besse-style curvature tensor, built directly (own code,
#    NOT via Kulkarni-Nomizu-of-2-forms route that run_qk_from_scratch.py
#    used -- deliberately the "other" of the two literature-adjacent
#    routes reported in findings/INDEX.md, so this check spans both).
# =================================================================
def qk_tensor_ishihara(I, J, K, c1, c2, n):
    """T(i,j,k,l) = c1*(d_ik d_jl - d_il d_jk)
                    + c2 * sum_A [ (A_ik A_jl - A_il A_jk) + 2 A_ij A_kl ]
    exactly as stated in findings/INDEX.md's "direct construction (HP^m)" section,
    attributed to Ishihara 1974 / Besse Ch.14."""
    Id = np.eye(n)
    T = np.zeros((n, n, n, n))
    for i, j, k, l in itertools.product(range(n), repeat=4):
        val = c1 * (Id[i, k] * Id[j, l] - Id[i, l] * Id[j, k])
        for A in (I, J, K):
            val += c2 * ((A[i, k] * A[j, l] - A[i, l] * A[j, k]) + 2 * A[i, j] * A[k, l])
        T[i, j, k, l] = val
    return T


def bianchi_violation(T, n):
    maxerr = 0.0
    for i, j, k, l in itertools.product(range(n), repeat=4):
        v = T[i, j, k, l] + T[i, k, l, j] + T[i, l, j, k]
        maxerr = max(maxerr, abs(v))
    return maxerr


# =================================================================
# main
# =================================================================
def main():
    print("=== Step 0: validate Q=R^2+R# against trusted diagonal formula ===")
    for n in [4, 5, 6]:
        ok = validate_Q_against_diagonal_formula(n)
        assert ok, f"Q validation FAILED at n={n}"
    print("  -> Q operator validated. Proceeding.\n")

    print("=== Step 0b: validate Weyl decomposition (round sphere -> Weyl=0) ===")
    for n in [4, 6, 8]:
        ok = sanity_sphere_weyl_zero(n)
        assert ok, f"Weyl sanity FAILED at n={n}"
    print("  -> Weyl decomposition validated.\n")

    print("=== Step 1: build own quaternion structure via regular representation ===")
    n = 8
    I, J, K = build_quaternion_structure(n)
    check_quaternion_relations(I, J, K, n)

    print("\n=== Step 2: Bianchi check of the Ishihara-style tensor (c1=c2=1) ===")
    T = qk_tensor_ishihara(I, J, K, 1.0, 1.0, n)
    viol = bianchi_violation(T, n)
    print(f"  max Bianchi violation = {viol:.2e}")
    assert viol < 1e-8

    print("\n=== Step 3: pinching ratio calibration, own re-derivation ===")
    # quaternionic line: e0, I e0 = e1 (within one H-block)
    Kq = -T[0, 1, 1, 0]
    # totally real: e0 vs e4 (different H-block)
    Kr = -T[0, 4, 4, 0]
    print(f"  K_quat = {Kq:.6f}, K_real = {Kr:.6f}, ratio = {Kq/Kr:.6f}  (expect 4.0 at c1=c2)")

    print("\n=== Step 4: Ricci / Einstein check ===")
    Ric = ricci_from_tensor(T, n)
    einstein_const = np.trace(Ric) / n
    einstein_resid = np.max(np.abs(Ric - einstein_const * np.eye(n)))
    print(f"  Einstein const = {einstein_const:.6f} (expect 4(m+2)={4*(n//4+2)}), "
          f"residual = {einstein_resid:.2e}")

    print("\n=== Step 5: Weyl decomposition, own code ===")
    W4, Ric2, S = weyl_decompose(T, n)
    Wg = Wedge2(n)
    Wmat = tensor_to_pairmat(W4, Wg)
    Wnorm = np.sqrt(np.sum(Wmat * Wmat))
    print(f"  |W| = {Wnorm:.6f}")

    print("\n=== Step 6: idempotency test under own Q operator ===")
    ad = build_ad_tensor(Wg)
    Q = Qop(ad, Wmat)
    Wunit = Wmat / Wnorm
    Qu = Qop(ad, Wunit)
    lam = np.sum(Wunit * Qu)
    resid = np.linalg.norm(Qu - lam * Wunit) / np.linalg.norm(Qu)
    Pnorm = np.sum(Wmat * Q) / Wnorm ** 3
    print(f"  eigenvalue lam = {lam:.6f}")
    print(f"  idempotent residual |Q(Wunit)-lam*Wunit|/|Q(Wunit)| = {resid:.3e}")
    print(f"  P/|W|^3 = {Pnorm:.6f}  (|.| = {abs(Pnorm):.6f})")
    print(f"  TARGET from findings/INDEX.md: 1.115547")
    print(f"  sqrt(3/2) = {np.sqrt(1.5):.6f}")
    sphere_val = np.sqrt(2 * (n - 1) * (n - 2)) / n
    print(f"  balanced sphere-product({n}) = {sphere_val:.6f}")

    diff = abs(abs(Pnorm) - 1.115547)
    print(f"\n  |my value - claimed value| = {diff:.6e}")
    if diff < 1e-4:
        print("  ==> MATCH: fresh independent implementation reproduces findings/INDEX.md's value.")
    else:
        print("  ==> MISMATCH: fresh implementation does NOT reproduce the claimed value!")


if __name__ == "__main__":
    main()
