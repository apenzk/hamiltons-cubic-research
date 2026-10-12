"""An explicit basis of the 14 invariant sextics on Weyl_5, and F_5 inside it.

Reviewer 182 named this as one of two objects the pipeline lacks entirely, and
both dictionary routes stall without it.

Method is reviewer 179's, reused rather than rebuilt: by the first fundamental
theorem for O(n), every degree-6 invariant is a combination of complete metric
contractions of W^{otimes 6}, so a basis is any 14 matchings whose evaluation
vectors are independent.  This runs over ALL matchings: eval_diagram is
called with no maxsize, so 179's rank-4-capped family and its losslessness
caveat do not apply here at all (reviewer 184 -- the earlier docstring cited the
wrong caveat).

F_5 = (3/2)|W|^6 - 9 tr(W^3)^2 is then expressed in that basis by solving the
evaluation system, which also CHECKS that F_5 is a degree-6 invariant at all.
"""
import sys, os, numpy as np, random
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "reviewers", "r179"))
import weyl_invariants as WI

N, K, P = 5, 6, 10007
rng = np.random.default_rng(7)
pyrng = random.Random(7)

PTS = [WI.random_weyl(N, P, rng) for _ in range(40)]
print(f"{len(PTS)} Weyl tensors over F_{P}, all four symmetries asserted by the generator")

def col(matching):
    return [WI.eval_diagram(W, matching, K, P) % P for W in PTS]

basis, rows, tries, stall = [], [], 0, 0
while len(basis) < 14 and stall < 4000:
    m = WI.random_matching(K, pyrng); tries += 1
    c = col(m)
    trial = rows + [c]
    if WI.rank_modp([r[:] for r in trial], P) > len(rows):
        rows = trial; basis.append(m); stall = 0
        print(f"  basis {len(basis):2d}/14 after {tries} matchings", flush=True)
    else:
        stall += 1
print(f"\n  found {len(basis)} independent diagrams from {tries} matchings")
print(f"  rank of the evaluation matrix: {WI.rank_modp([r[:] for r in rows], P)}")
print(f"  the record's degree-6 count at n=5 is 14: {len(basis) == 14}")

# --- F_5 = (3/2)|W|^6 - 9 tr(W^3)^2 at the same points ---
# CONVENTION, and it is a coincidence that it is harmless.  Both q and trM3
# below use the FLAT index-pair reshape, while the rest of the record uses the
# Lambda^2 operator (10x10 at n=5).  Each antisymmetric pair is counted twice in
# each slot, so q_flat = 4 q_Lambda2 (two pair-slots) and tr_flat = 8 tr_Lambda2
# (three contractions).  Hence q^3 scales by 4^3 = 64 and tr^2 by 8^2 = 64:
# F_5 as built here is exactly 64 times the record's, a UNIFORM positive scalar,
# so "F_5 is a sum of squares" is unaffected and F_5 still vanishes at W_0.
#
# It is a GRADING rather than a coincidence, and the earlier note here calling it
# one was too pessimistic -- reviewer 183.  tr(M^k) = 2^k tr(A^k) for every k,
# since each unordered pair is counted twice and the diagonal terms vanish, so
# EVERY degree-d product of operator traces scales by exactly 2^d.  At degree 6
# that is 64 for the whole operator-trace subalgebra, not just this target.
# (Suspected while briefing Gate 2, measured by 184, proved by 183.)
def q(W):   # |W|^2, a degree-2 complete contraction
    return int(np.einsum('abcd,abcd->', W, W)) % P
def trM3(W):
    M = W.reshape(N*N, N*N)
    return int(np.trace(M @ M @ M)) % P
inv2 = pow(2, P-2, P)
F5 = [(3*inv2*pow(q(W), 3, P) - 9*pow(trM3(W), 2, P)) % P for W in PTS]

A = [[rows[b][i] for b in range(len(basis))] for i in range(len(PTS))]
import itertools
def solve_modp(A, b, p):
    m, n = len(A), len(A[0])
    M = [row[:] + [b[i]] for i, row in enumerate(A)]
    piv, r = [], 0
    for c in range(n):
        s = next((k for k in range(r, m) if M[k][c] % p), None)
        if s is None: continue
        M[r], M[s] = M[s], M[r]
        inv = pow(M[r][c] % p, p-2, p)
        M[r] = [(x*inv) % p for x in M[r]]
        for k in range(m):
            if k != r and M[k][c] % p:
                f = M[k][c]; M[k] = [(x - f*y) % p for x, y in zip(M[k], M[r])]
        piv.append(c); r += 1
    for k in range(r, m):
        if M[k][n] % p and not any(M[k][c] % p for c in range(n)):
            return None
    x = [0]*n
    for i, c in enumerate(piv): x[c] = M[i][n] % p
    return x

x = solve_modp(A, F5, P)
print(f"\n  F_5 lies in the span of the 14 diagrams: {x is not None}")
if x is not None:
    print(f"  its coordinates are nonzero in {sum(1 for v in x if v)} of 14")
    ok = all(sum(rows[b][i]*x[b] for b in range(len(basis))) % P == F5[i]
             for i in range(len(PTS)))
    print(f"  reproduces F_5 at all {len(PTS)} sample points: {ok}")
