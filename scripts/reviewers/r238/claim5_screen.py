"""r238, claim 5.  Does the degree-3 screen in run_a1_canonical_lift.py test the
reduction's mechanism?

Three probes, none of which the screen performs:

  A. THE KERNEL DIRECTION.  Fact (ii) of the reduction is  ker eps_n  contained in
     ker eps_{n_0}  for n >= n_0 -- a statement about SUBSPACES.  The screen only
     records dim of the image.  In the miniature the kernel at n=4 and at n=5 is a
     LINE in a 2-dim space, so nesting is the sharp statement "the same line", and
     it is testable.  We test it.

  B. THE CEILING.  The screen's freeze assert compares the last two ranks.  With
     only 2 diagram columns the rank can never exceed 2, so once the climb assert
     has forced rank 2 at the largest n, the freeze assert cannot fail unless the
     rank were still 1 at the second-largest n.  We enumerate every rank sequence
     the screen could observe and count how many the freeze assert rejects.

  C. LOVELOCK vs MECHANISM.  Whether the observed climb is dimension-driven at all,
     or an artefact of the sample size / conditioning: we recompute the ranks with
     exact rational arithmetic on integer Weyl tensors, and with many more samples.
"""
import numpy as np
from fractions import Fraction
from itertools import product

rng = np.random.default_rng(3)

def weyl_project(R, n):
    R = 0.25 * (R - R.transpose(1, 0, 2, 3) - R.transpose(0, 1, 3, 2)
                + R.transpose(1, 0, 3, 2))
    R = 0.5 * (R + R.transpose(2, 3, 0, 1))
    R = R - (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric)
    E = Ric - s / n * g
    def KN(A, B):
        return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    W = R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)
    return 0.5 * (W + W.transpose(2, 3, 0, 1))

DIAGS = [
    lambda W: np.einsum('ijkl,klmn,mnij->', W, W, W),
    lambda W: np.einsum('ikjl,kmln,minj->', W, W, W),
]

def sample_matrix(n, samples, seed=None):
    r = rng if seed is None else np.random.default_rng(seed)
    M = np.zeros((samples, len(DIAGS)))
    for s in range(samples):
        W = weyl_project(r.standard_normal((n, n, n, n)), n)
        for d, q in enumerate(DIAGS):
            M[s, d] = q(W)
    return M

def rank_of(M):
    sv = np.linalg.svd(M, compute_uv=False)
    tol = max(sv[0], 1.0) * 1e-9
    return int((sv > tol).sum())

print("=" * 74)
print("A.  THE KERNEL DIRECTION -- the statement fact (ii) actually makes")
print("=" * 74)
print("The screen reports dim(image).  Fact (ii) is about the KERNEL as a subspace.")
print("At n=4 and n=5 the rank is 1, so each kernel is a line (a:b) with a*q1+b*q2=0.")
print("Fact (ii) with n_0=4, n=5 demands ker eps_5 contained in ker eps_4, i.e. the")
print("SAME line.  Measured, from 400 samples each, normalised to b = 1:\n")
ker = {}
for n in (4, 5, 6, 7, 8, 10, 12):
    M = sample_matrix(n, 400, seed=100 + n)
    _, sv, vt = np.linalg.svd(M, full_matrices=False)
    r = int((sv > max(sv[0], 1.0) * 1e-9).sum())
    if r == 1:
        v = vt[1]          # the kernel direction
        v = v / v[1]
        ker[n] = v
        print("   n=%-3d rank %d   kernel direction  q1 : q2  =  %+.10f : 1"
              % (n, r, v[0]))
    else:
        print("   n=%-3d rank %d   kernel is trivial" % (n, r))
print()
if 4 in ker and 5 in ker:
    d = abs(ker[4][0] - ker[5][0])
    print("   |ratio(n=4) - ratio(n=5)| = %.3e" % d)
    print("   -> the two kernels are %s" % ("THE SAME LINE (fact (ii) holds here)"
          if d < 1e-6 else "DIFFERENT LINES -- fact (ii) VIOLATED in the miniature"))
print("   The screen tests NONE of this: it only compares two integers.")

print()
print("=" * 74)
print("B.  THE CEILING -- how much can the freeze assert actually reject?")
print("=" * 74)
K = len(DIAGS)
L = 7                        # the seven dimensions the screen visits
ok_mono, rejected_by_freeze = 0, 0
for seq in product(range(K + 1), repeat=L):
    if not all(seq[i] <= seq[i + 1] for i in range(L - 1)):
        continue             # assert 1 already rejected it
    if not seq[0] < seq[-1]:
        continue             # assert 2 already rejected it
    ok_mono += 1
    if seq[-1] != seq[-2]:
        rejected_by_freeze += 1
print("   rank sequences over %d dimensions with at most %d columns: %d survive"
      % (L, K, ok_mono))
print("   of those, the FREEZE assert rejects %d" % rejected_by_freeze)
print("   -> the freeze assert has %.1f%% discriminating power at K=%d columns"
      % (100.0 * rejected_by_freeze / ok_mono, K))
print("   The ceiling is the NUMBER OF COLUMNS, not an attained universal value.")
print("   Same enumeration with a wider diagram set:")
for K2 in (2, 3, 5, 10):
    a = b = 0
    for seq in product(range(K2 + 1), repeat=L):
        if not all(seq[i] <= seq[i + 1] for i in range(L - 1)): continue
        if not seq[0] < seq[-1]: continue
        a += 1
        if seq[-1] != seq[-2]: b += 1
    print("      K=%-3d  freeze rejects %d of %d  (%.1f%%)" % (K2, b, a, 100.0 * b / a))

print()
print("=" * 74)
print("C.  IS THE CLIMB ROBUST?  exact integer Weyl tensors, no floating point")
print("=" * 74)

def weyl_project_exact(R, n):
    """same projector, in Fraction arithmetic, on an integer array"""
    n_ = n
    def T(A, perm): return np.transpose(A, perm)
    Q4, H = Fraction(1, 4), Fraction(1, 2)
    R = Q4 * (R - T(R,(1,0,2,3)) - T(R,(0,1,3,2)) + T(R,(1,0,3,2)))
    R = H * (R + T(R,(2,3,0,1)))
    R = R - Fraction(1, 3) * (R + T(R,(0,2,3,1)) + T(R,(0,3,1,2)))
    g = np.eye(n_, dtype=object) * Fraction(1)
    Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric)
    E = Ric - Fraction(1, n_) * s * g
    def KN(A, B):
        return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    W = R - Fraction(1, n_ - 2) * KN(E, g) - Fraction(1, 2 * n_ * (n_ - 1)) * s * KN(g, g)
    return Fraction(1, 2) * (W + T(W,(2,3,0,1)))

def exact_rank(n, samples, seed):
    r = np.random.default_rng(seed)
    rows = []
    for _ in range(samples):
        A = r.integers(-4, 5, size=(n, n, n, n)).astype(object)
        A = np.vectorize(Fraction)(A)
        W = weyl_project_exact(A, n)
        assert all(isinstance(x, Fraction) for x in W.ravel()[:5]), "lost exactness"
        rows.append([q(W) for q in DIAGS])
    # exact rank by fraction-free elimination
    M = [list(row) for row in rows]
    rank, col = 0, 0
    while col < len(DIAGS) and rank < len(M):
        piv = next((i for i in range(rank, len(M)) if M[i][col] != 0), None)
        if piv is None:
            col += 1; continue
        M[rank], M[piv] = M[piv], M[rank]
        for i in range(rank + 1, len(M)):
            if M[i][col] != 0:
                f = M[i][col] / M[rank][col]
                M[i] = [M[i][j] - f * M[rank][j] for j in range(len(DIAGS))]
        rank += 1; col += 1
    return rank

for n in (4, 5, 6, 7):
    print("   n=%-3d exact rank over Q from 12 integer samples: %d"
          % (n, exact_rank(n, 12, 900 + n)))
print("   The climb 1 -> 2 at n=6 is real and exact.  It is the classical")
print("   dimension-dependent (Lovelock-type) identity among cubic Weyl")
print("   contractions -- dim (Sym^3 W_n)^O = 1 at n=5 and 2 at n>=6.")
