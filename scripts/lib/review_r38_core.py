"""Reviewer 38: independent implementation of Weyl_n, sharp_bilin, and S(p,q).

Written from the definitions in the brief only.  Nothing is imported from
scripts/b_*.py or scripts/review_r3*.py.  All arithmetic is exact: integers for
the operator identity, Fractions for every linear-algebra nullspace.

Conventions (from the brief):
  phi_ij = E_ij - E_ji for i < j,  <X,Y> = 1/2 tr(X^T Y)   -> orthonormal
  (A_a)_mn = c_amn  with  [phi_a, phi_b] = sum_c c_abc phi_c
  sharp_bilin(X,Y)_ab = -1/4 (T_ab + T_ba),  T_ab = tr(A_a X A_b Y)
  R_{ijkl} = <R(e_i ^ e_j), e_k ^ e_l> = R[(ij),(kl)] for i<j, k<l
"""
from fractions import Fraction
from itertools import combinations
import numpy as np


# ---------------------------------------------------------------- basis ----
def pair_data(n):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    idx = {p: k for k, p in enumerate(pairs)}
    return pairs, idx


def signed(idx, i, j):
    """Return (position, sign) for the bivector e_i ^ e_j; None if i == j."""
    if i == j:
        return None
    return (idx[(i, j)], 1) if i < j else (idx[(j, i)], -1)


# --------------------------------------------------- structure constants ----
def structure_constants(n):
    """A[a] with (A_a)_{mn} = <[phi_a, phi_m], phi_n>, as an integer array.

    Uses the derivation action of so(n) on Lambda^2:
      phi_ij . (e_k ^ e_l) = (phi_ij e_k) ^ e_l + e_k ^ (phi_ij e_l),
    with phi_ij e_j = e_i, phi_ij e_i = -e_j, phi_ij e_r = 0 otherwise.
    """
    pairs, idx = pair_data(n)
    N = len(pairs)
    A = np.zeros((N, N, N), dtype=np.int64)

    def act(i, j, r):
        """phi_ij applied to e_r -> list of (coeff, basis index)."""
        if r == j:
            return [(1, i)]
        if r == i:
            return [(-1, j)]
        return []

    for a, (i, j) in enumerate(pairs):
        for m, (k, l) in enumerate(pairs):
            # phi_ij . (e_k ^ e_l)
            terms = []
            for c, r in act(i, j, k):
                terms.append((c, r, l))
            for c, r in act(i, j, l):
                terms.append((c, k, r))
            for c, u, v in terms:
                s = signed(idx, u, v)
                if s is None:
                    continue
                A[a, m, s[0]] += c * s[1]
    return A


def verify_structure_constants(n):
    """Check [A_a, A_b] closes with the same constants, and total antisymmetry."""
    pairs, idx = pair_data(n)
    N = len(pairs)
    A = structure_constants(n)
    # total antisymmetry of c_abc in all three indices
    C = A  # C[a,b,c] = c_abc
    assert np.array_equal(C, -np.transpose(C, (0, 2, 1))), "c_abc not skew in b,c"
    assert np.array_equal(C, -np.transpose(C, (1, 0, 2))), "c_abc not skew in a,b"
    # Jacobi via ad: ad_a = -A_a; check [ad_a, ad_b] = ad_{[a,b]}
    ad = -np.transpose(A, (0, 2, 1))  # (ad_a)_{n m} = c_amn  -> ad_a = A_a^T ... fix below
    ad = np.transpose(A, (0, 2, 1))   # (ad_a)_{n,m} = (A_a)_{m,n} = c_amn
    for a in range(N):
        for b in range(N):
            lhs = ad[a] @ ad[b] - ad[b] @ ad[a]
            rhs = np.zeros((N, N), dtype=np.int64)
            for c in range(N):
                if C[a, b, c]:
                    rhs = rhs + C[a, b, c] * ad[c]
            assert np.array_equal(lhs, rhs), (a, b)
    return True


# ------------------------------------------------------------ sharp_bilin ---
def sharp_bilin_int(A, X, Y):
    """-1/4 (T + T^T) with T_ab = tr(A_a X A_b Y); returns 4*sharp as integers.

    Returned value is  -(T + T^T), i.e. 4 * sharp_bilin(X,Y).
    """
    N = A.shape[0]
    M = A @ X                     # M[a] = A_a X
    P = A @ Y                     # P[b] = A_b Y
    Mf = M.reshape(N, N * N)
    Pf = np.transpose(P, (0, 2, 1)).reshape(N, N * N)
    T = Mf @ Pf.T                 # T[a,b] = tr(A_a X A_b Y)
    return -(T + T.T)


# ------------------------------------------------- exact rational nullspace -
def rref(rows, ncols):
    """Fraction RREF.  rows: list of lists of Fraction.  Returns (rows, pivots)."""
    mat = [r[:] for r in rows]
    pivots = []
    r = 0
    for c in range(ncols):
        piv = None
        for rr in range(r, len(mat)):
            if mat[rr][c] != 0:
                piv = rr
                break
        if piv is None:
            continue
        mat[r], mat[piv] = mat[piv], mat[r]
        pv = mat[r][c]
        mat[r] = [x / pv for x in mat[r]]
        for rr in range(len(mat)):
            if rr != r and mat[rr][c] != 0:
                f = mat[rr][c]
                mat[rr] = [x - f * y for x, y in zip(mat[rr], mat[r])]
        pivots.append(c)
        r += 1
        if r == len(mat):
            break
    return mat[:r], pivots


def nullspace(rows, ncols):
    """Exact rational nullspace basis (list of lists of Fraction)."""
    if not rows:
        basis = []
        for f in range(ncols):
            v = [Fraction(0)] * ncols
            v[f] = Fraction(1)
            basis.append(v)
        return basis
    R, pivots = rref(rows, ncols)
    free = [c for c in range(ncols) if c not in set(pivots)]
    basis = []
    for f in free:
        v = [Fraction(0)] * ncols
        v[f] = Fraction(1)
        for ri, pc in enumerate(pivots):
            v[pc] = -R[ri][f]
        basis.append(v)
    return basis


# ------------------------------------------------------- Weyl constraints ---
def sym_vars(N):
    """Variables for a symmetric N x N matrix: index map (a,b) -> column."""
    cols = {}
    k = 0
    for a in range(N):
        for b in range(a, N):
            cols[(a, b)] = k
            k += 1
    return cols, k


def tensor_entry(idx, cols, i, j, k, l):
    """(column, sign) for R_{ijkl}; None if identically zero."""
    s1 = signed(idx, i, j)
    if s1 is None:
        return None
    s2 = signed(idx, k, l)
    if s2 is None:
        return None
    a, sa = s1
    b, sb = s2
    key = (a, b) if a <= b else (b, a)
    return cols[key], sa * sb


def bianchi_rows(n, cols, ncols):
    pairs, idx = pair_data(n)
    rows = []
    for i, j, k, l in combinations(range(n), 4):
        row = [Fraction(0)] * ncols
        for (a, b, c, d, sg) in [(i, j, k, l, 1), (i, k, j, l, -1), (i, l, j, k, 1)]:
            e = tensor_entry(idx, cols, a, b, c, d)
            if e:
                row[e[0]] += sg * e[1]
        if any(row):
            rows.append(row)
    return rows


def ricci_rows(n, cols, ncols):
    pairs, idx = pair_data(n)
    rows = []
    for i in range(n):
        for j in range(i, n):
            row = [Fraction(0)] * ncols
            for k in range(n):
                e = tensor_entry(idx, cols, i, k, j, k)
                if e:
                    row[e[0]] += e[1]
            if any(row):
                rows.append(row)
    return rows


def mat_from_vec(vec, cols, N):
    M = np.zeros((N, N), dtype=object)
    for (a, b), c in cols.items():
        M[a, b] = vec[c]
        M[b, a] = vec[c]
    return M


def dim_weyl(n):
    pairs, idx = pair_data(n)
    N = len(pairs)
    cols, ncols = sym_vars(N)
    rows = bianchi_rows(n, cols, ncols) + ricci_rows(n, cols, ncols)
    R, piv = rref(rows, ncols)
    return ncols - len(piv)


# ------------------------------------------------------------- classes ------
def plane_class(pairs, p):
    """'PP' if both indices < p, 'QQ' if both >= p, 'MX' otherwise."""
    out = []
    for (i, j) in pairs:
        if i < p and j < p:
            out.append('PP')
        elif i >= p and j >= p:
            out.append('QQ')
        else:
            out.append('MX')
    return out


def support_columns(n, p, cols):
    """Columns (a<=b) with one of a,b PP and the other MX."""
    pairs, idx = pair_data(n)
    cl = plane_class(pairs, p)
    keep = []
    for (a, b), c in cols.items():
        s = {cl[a], cl[b]}
        if s == {'PP', 'MX'}:
            keep.append(c)
    return sorted(keep)


def S_space(n, p, use_bianchi=True, use_ricci=True):
    """Exact rational basis of {V in Weyl_n : supp V in (PP,MX)}, as N x N matrices.

    Returned as (basis_matrices_object, dim).  Constraints are built on the FULL
    variable set and then restricted to the support columns, which is the same as
    forcing every non-support entry to zero.
    """
    pairs, idx = pair_data(n)
    N = len(pairs)
    cols, ncols = sym_vars(N)
    sup = support_columns(n, p, cols)
    pos = {c: k for k, c in enumerate(sup)}
    rows = []
    src = []
    if use_bianchi:
        src += bianchi_rows(n, cols, ncols)
    if use_ricci:
        src += ricci_rows(n, cols, ncols)
    for r in src:
        rr = [r[c] for c in sup]
        if any(rr):
            rows.append(rr)
    nb = nullspace(rows, len(sup))
    mats = []
    for v in nb:
        full = [Fraction(0)] * ncols
        for c in sup:
            full[c] = v[pos[c]]
        mats.append(mat_from_vec(full, cols, N))
    return mats, len(nb)


def I_p_matrix(n, p):
    pairs, idx = pair_data(n)
    N = len(pairs)
    cl = plane_class(pairs, p)
    M = np.zeros((N, N), dtype=np.int64)
    for a in range(N):
        if cl[a] == 'PP':
            M[a, a] = 1
    return M


def to_int_matrix(Mobj):
    """Clear denominators of a Fraction-valued matrix; return (int array, denom)."""
    den = 1
    for x in Mobj.flat:
        if isinstance(x, Fraction):
            den = den * x.denominator // np.gcd(den, x.denominator)
    arr = np.zeros(Mobj.shape, dtype=np.int64)
    for i in range(Mobj.shape[0]):
        for j in range(Mobj.shape[1]):
            arr[i, j] = int(Fraction(Mobj[i, j]) * den)
    return arr, den
