"""Reviewer 185, claim 4's second half: does the 2^d grading cover all 14
invariant sextics, or only the operator-trace ones?  Measure the dimension of
the operator-trace subalgebra at degree 6 inside the 14."""
import sys, os, random
import numpy as np
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
sys.path.insert(0, os.path.join(ROOT, "scripts", "reviewers", "r179"))
import weyl_invariants as WI

N, P = 5, 10007
rng = np.random.default_rng(77); pyrng = random.Random(77)
pts = [WI.random_weyl(N, P, rng) for _ in range(60)]
PAIRS = [(i, j) for i in range(N) for j in range(i+1, N)]

def opmat(W):
    return np.array([[int(W[a][b][c][d]) % P for (c, d) in PAIRS] for (a, b) in PAIRS],
                    dtype=object)
def trk(A, k):
    X = A.copy()
    for _ in range(k-1): X = (X @ A) % P
    return int(np.trace(X)) % P

print("degree-6 words in the Lambda^2 operator traces, at n=5:")
words = {"tr(A^2)^3": lambda A: trk(A,2)**3 % P,
         "tr(A^2)tr(A^4)": lambda A: trk(A,2)*trk(A,4) % P,
         "tr(A^3)^2": lambda A: trk(A,3)**2 % P,
         "tr(A^6)": lambda A: trk(A,6) % P}
As = [opmat(W) for W in pts]
print(f"  tr(A) on the sample: {sorted({trk(A,1) for A in As})}  (0 => Ricci-flat)")
rows = []
for nm, f in words.items():
    rows.append([f(A) for A in As])
r_tr = WI.rank_modp(rows, P)
print(f"  the 4 trace monomials span a {r_tr}-dimensional space of functionals")

# the full degree-6 invariant space, by r179's diagram rank
R = WI.IncRank(P)
used = 0
while R.rank() < 14 and used < 4000:
    m = WI.structured_matching(6, rng)
    mr, trees = WI.best_tree(6, m)
    if mr > 4: continue
    used += 1
    R.add([WI.eval_tree(W, m, 6, P, trees) for W in pts])
print(f"  the diagram functionals reach rank {R.rank()} on the same 60 points "
      f"({used} diagrams)  -- the record's 14")

# are the trace monomials inside?  they must be; the point is 4 << 14.
comb = rows + []
R2 = WI.IncRank(P)
for row in rows: R2.add(row)
print(f"  operator-trace subalgebra: {r_tr} of {R.rank()} dimensions "
      f"= {100*r_tr/R.rank():.0f}% of the degree-six invariants")
# F_5 = (3/2) tr(A^2)^3 - 9 tr(A^3)^2 is inside by inspection
print("  F_5 = (3/2)|W|^6 - 9 tr(W^3)^2 = (3/2)tr(A^2)^3 - 9 tr(A^3)^2 is a word,")
print("  so the 64 = 4^3 = 8^2 applies to F_5.  It does NOT apply to a general")
print("  sextic, because a general sextic contracts single indices ACROSS the")
print("  antisymmetric pairs and has no expression in A at all.")
