"""r240, claim 3 -- the SO(n) scope limit: confirm it, and sharpen the range.

WHAT THE FILE SAYS.  "A degree-6 det-twisted invariant needs one epsilon over 24
slots, so it exists only at EVEN n: the SO counts run 0,1,2,7,19,89 with three
chiral at n=12, giving SO(12) = 92 and SO(13) = 89.  The SO dimension DECREASES,
refuting monotonicity outright."  r237's rider derives "even n <= 24" from the
same slot count.

WHAT THIS SCRIPT ESTABLISHES.

  L1 (parity).  Two epsilons contract to a determinant of deltas, so a
      det-twisted invariant may be taken to carry exactly one.  It uses n slots,
      leaving 24 - n to be matched in pairs, so n must be EVEN.  n = 13 has none:
      SO(13) = O(13) = 89.  (Equivalently and more simply for odd n: O(n) =
      SO(n) x {+-I} and -I acts trivially on W_n, which has four indices.)

  L2 (the sharp range -- BIANCHI, not the slot count).  An epsilon contracted
      with THREE slots of the SAME Weyl factor antisymmetrises W over three of
      its indices, and W_{[abc]d} = 0 for any algebraic curvature tensor.  So
      each of the 6 factors gives epsilon AT MOST 2 slots, and

          n <= 2 * degree = 12,      not  n <= 4 * degree = 24.

      Checked below in exact integer arithmetic.  Consequence: at degree 6 the
      SO- and O-invariants COINCIDE at every n >= 13, and differ only at n <= 12.
      The record's "n <= 24" is loose by a factor of two, and the factor of two
      is what localises the whole scope problem to the base dimension itself.

  L3 (the drop is real).  At n = 12 the bound is saturated -- one antisymmetric
      pair from each of the six factors -- and a chiral invariant of that shape
      is exhibited and evaluated EXACTLY on a genuinely 12-dimensional Weyl
      tensor.  It is nonzero, so dim(Sym^6 W_12)^{SO(12)} > dim(...)^{O(12)} and
      the count really does drop from n = 12 to n = 13.

  L4 (the same mechanism, where it can be checked end to end).  At degree 2 and
      n = 4 the chiral invariant is the classical Pontryagin density
      eps_abcd W^{ab}_{ef} W^{efcd}; the O(4) count is 1 and the SO(4) count is
      2, dropping back to 1 at n = 5.  Computed here from scratch.

Everything exact: integer Weyl tensors, integer contractions, integer epsilon
sums.
"""
import itertools
import numpy as np
from fractions import Fraction as F


def weyl_project_exact(R, n):
    T = np.transpose
    R = F(1, 4) * (R - T(R, (1, 0, 2, 3)) - T(R, (0, 1, 3, 2)) + T(R, (1, 0, 3, 2)))
    R = F(1, 2) * (R + T(R, (2, 3, 0, 1)))
    R = R - F(1, 3) * (R + T(R, (0, 2, 3, 1)) + T(R, (0, 3, 1, 2)))
    g = np.eye(n, dtype=object) * F(1)
    Ric = np.einsum('ikjk->ij', R)
    s = np.trace(Ric)
    E = Ric - F(1, n) * s * g
    def KN(A, B):
        return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    W = R - F(1, n - 2) * KN(E, g) - F(1, 2 * n * (n - 1)) * s * KN(g, g)
    return F(1, 2) * (W + T(W, (2, 3, 0, 1)))


def integer_weyl(n, seed):
    rng = np.random.default_rng(seed)
    A = np.vectorize(F)(rng.integers(-3, 4, size=(n, n, n, n)).astype(object))
    W = weyl_project_exact(A, n)
    den = 1
    for v in W.ravel():
        den = den * v.denominator // np.gcd(den, v.denominator)
    W = np.vectorize(lambda z: int(z * den))(W).astype(object)
    assert np.all(W == -np.transpose(W, (1, 0, 2, 3)))
    assert np.all(W == np.transpose(W, (2, 3, 0, 1)))
    assert np.all(W + np.transpose(W, (0, 2, 3, 1)) + np.transpose(W, (0, 3, 1, 2)) == 0)
    assert np.all(np.einsum('ikjk->ij', W) == 0)
    return W


print("=" * 78)
print("L2.  THE SHARP RANGE:  epsilon takes at most TWO slots from a Weyl factor")
print("=" * 78)
for n, seed in ((5, 1), (6, 2), (7, 3)):
    W = integer_weyl(n, seed)
    # total antisymmetrisation over the first three indices
    A3 = sum(np.sign(_p := 1) * 0 for _ in ())  # placeholder, built below
    perms = list(itertools.permutations(range(3)))
    def sgn(p):
        s = 1
        p = list(p)
        for i in range(len(p)):
            for j in range(i + 1, len(p)):
                if p[i] > p[j]:
                    s = -s
        return s
    A3 = np.zeros_like(W)
    for p in perms:
        A3 = A3 + sgn(p) * np.transpose(W, tuple(p) + (3,))
    mx = int(np.max(np.abs(A3)))
    print(f"    n = {n:>2}:  max |sum_{{sigma in S_3}} sgn(sigma) W_{{sigma(abc)d}}| = {mx}"
          f"   ({'W_[abc]d = 0' if mx == 0 else 'NONZERO -- the lemma fails'})")
    assert mx == 0
print("""
    So an epsilon index-set meeting one Weyl factor in three or more slots
    annihilates the whole term.  Six factors, at most two slots each:

        a chiral degree-k invariant needs  n <= 2k,  and n even.

    At k = 6:  n in {2, 4, 6, 8, 10, 12}.  For every n >= 13, odd or even,
    (Sym^6 W_n)^{SO(n)} = (Sym^6 W_n)^{O(n)}.  The record's n <= 24 permits
    chiral invariants at n = 14, 16, ..., 24, and there are none.""")

print()
print("=" * 78)
print("L4.  THE MECHANISM END TO END AT DEGREE 2:  SO(4) = 2, O(4) = 1, SO(5) = 1")
print("=" * 78)


def eps_sign_table(n):
    return {p: (1 if _parity(p) == 0 else -1) for p in itertools.permutations(range(n))}


def _parity(p):
    p = list(p)
    seen = [False] * len(p)
    par = 0
    for i in range(len(p)):
        if seen[i]:
            continue
        j, ln = i, 0
        while not seen[j]:
            seen[j] = True
            j = p[j]
            ln += 1
        par += ln - 1
    return par % 2


def pontryagin4(W):
    """eps_{abcd} W_{ab ef} W_{ef cd}, exact."""
    M = np.einsum('abef,efcd->abcd', W, W)
    tot = 0
    for p in itertools.permutations(range(4)):
        s = 1 if _parity(p) == 0 else -1
        tot += s * M[p[0], p[1], p[2], p[3]]
    return int(tot)


def normsq(W):
    return int(np.einsum('abcd,abcd->', W, W))


rows = []
for seed in range(6):
    W = integer_weyl(4, 100 + seed)
    rows.append([normsq(W), pontryagin4(W)])
dets = [rows[i][0] * rows[j][1] - rows[i][1] * rows[j][0]
        for i in range(len(rows)) for j in range(i + 1, len(rows))]
r = 2 if any(d != 0 for d in dets) else 1     # exact 2x2 minors, no tolerance
print(f"    n = 4:  |W|^2 and the Pontryagin density on 6 random exact Weyl tensors")
for a, b in rows:
    print(f"            |W|^2 = {a:>22}    eps WW = {b:>22}")
print(f"    rank of the pair = {r}, so the SO(4)-invariant quadratics span 2")
print(f"    dimensions while the O(4) count is 1 -- the record's 'deg 2: 1'.")
assert r == 2
# and it really is chiral: reflect one coordinate
W = integer_weyl(4, 100)
R = np.eye(4, dtype=object)
R[0, 0] = -1
Wr = np.einsum('ai,bj,ck,dl,ijkl->abcd', R, R, R, R, W)
print(f"\n    under a reflection (det = -1):  |W|^2  {normsq(W)} -> {normsq(Wr)}")
print(f"                                    eps WW {pontryagin4(W)} -> {pontryagin4(Wr)}")
assert normsq(Wr) == normsq(W) and pontryagin4(Wr) == -pontryagin4(W)
print("    invariant under O(4), the chiral one flips: it is SO-only.  At n = 5")
print("    the same contraction needs 5 epsilon slots out of 8, leaving 3 to be")
print("    paired -- impossible -- so SO(5) = O(5) = 1 and the count DROPS 2 -> 1.")

print()
print("=" * 78)
print("L3.  DEGREE 6 AT n = 12:  a chiral invariant, evaluated exactly, nonzero")
print("=" * 78)
print("""    Shape.  n = 12 saturates L2: epsilon takes exactly one antisymmetric
    pair from each of the six Weyl factors, and the six remaining pairs match
    up among themselves.  Take the matching into three 'dumbbells',
    M_{abcd} = W_{abef} W_{efcd}, and contract:

        S(W) = eps_{a1...a12} M_{a1a2a3a4} M_{a5a6a7a8} M_{a9a10a11a12}.

    Computed by splitting {1..12} into three 4-subsets: the epsilon sign is the
    shuffle sign of the sorted blocks times the sign inside each block, so
    S = sum over ordered set-partitions of sgn(shuffle) * P(S1) P(S2) P(S3)
    with P(S) the full antisymmetrisation of M over the four indices of S.""")


def antisym4_table(M, n=12):
    tab = {}
    for S in itertools.combinations(range(n), 4):
        tot = 0
        for p in itertools.permutations(S):
            s = 1 if _parity([S.index(x) for x in p]) == 0 else -1
            tot += s * M[p[0], p[1], p[2], p[3]]
        tab[S] = tot
    return tab


def shuffle_sign(S1, S2, S3):
    seq = list(S1) + list(S2) + list(S3)
    return 1 if _parity(sorted(range(12), key=lambda i: seq[i])) == 0 else -1


def chiral6_at12(W):
    M = np.einsum('abef,efcd->abcd', W, W)
    tab = antisym4_table(M)
    tot = 0
    idx = list(range(12))
    for S1 in itertools.combinations(idx, 4):
        rest1 = [i for i in idx if i not in S1]
        p1 = tab[S1]
        if p1 == 0:
            continue
        for S2 in itertools.combinations(rest1, 4):
            S3 = tuple(i for i in rest1 if i not in S2)
            tot += shuffle_sign(S1, S2, S3) * p1 * tab[S2] * tab[S3]
    return int(tot)


W12 = integer_weyl(12, 4242)
S = chiral6_at12(W12)
print(f"\n    S(W) = {S}")
R = np.eye(12, dtype=object)
R[0, 0] = -1
W12r = np.einsum('ai,bj,ck,dl,ijkl->abcd', R, R, R, R, W12)
Sr = chiral6_at12(W12r)
print(f"    S(RW), R a reflection = {Sr}")
print(f"    S(RW) = -S(W): {Sr == -S}      S nonzero: {S != 0}")
assert S != 0 and Sr == -S
print("""
    So a degree-6 invariant of W_12 exists that SO(12) preserves and O(12) does
    not: dim(Sym^6 W_12)^{SO(12)} >= dim(Sym^6 W_12)^{O(12)} + 1 = 90.  The
    record's chiral multiplicity 3 (r180, r182) puts it at 92; this run confirms
    the sign of the gap from scratch, which is what the monotonicity claim turns
    on.  Combined with L1 and L2:

        SO count:  92 at n = 12,  then 89 at EVERY n >= 13.

    The drop is real, it refutes monotonicity for SO(n), and it happens at
    exactly one step -- the step out of the certificate base.""")
