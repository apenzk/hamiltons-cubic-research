"""r255, claim 2: the one-sidedness of the component rank.

(A) IMPLICATION.  If a constant-coefficient relation holds among the maps whose
    components are read, every component matrix is deficient -- checked against a
    PLANTED relation over many component sets, sample counts and seeds.
(B) CONVERSE.  A deficient matrix carries no information: an ambient-independent
    pair reads rank 1 off the single component (0,1).
(C) SCOPE.  The implication is about the maps whose components are READ.  For the
    projected covariants it fails, which is claim 1's witness restated here in
    claim 2's language.
"""
import sys, os, random
from fractions import Fraction as F
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", "runs"))
from run_component_independence import (weyl_exact, cov_ric_like, cov_trace_g,
                                        component_rank, COMPS)

def cov_planted(W, n, i, j):        # 2*F1 - 5*F2, an exact relation by fiat
    return 2*cov_ric_like(W, n, i, j) - 5*cov_trace_g(W, n, i, j)

print("r255 / claim 2 -- one-sidedness\n")
print("(A) planted relation F3 = 2 F1 - 5 F2, over many (comps, samples, seed):")
bad = []
allcomps = [(i, j) for i in range(3) for j in range(3)]
rnd = random.Random(7)
for trial in range(24):
    k = rnd.randint(1, 4)
    comps = rnd.sample(allcomps, k)
    s = rnd.randint(1, 4)
    seed = rnd.randint(0, 99)
    r = component_rank([cov_ric_like, cov_trace_g, cov_planted], 5, comps, s, seed)
    if r == 3:
        bad.append((comps, s, seed, r))
print(f"    24 trials, rank 3 (a false certificate) seen in: {len(bad)} of them")
print(f"    max rank observed = "
      f"{max(component_rank([cov_ric_like,cov_trace_g,cov_planted],5,allcomps,4,sd) for sd in (0,1,2))}"
      "  (3 columns, a relation present, so <= 2 always)")

print("\n(B) converse: an ambient-INDEPENDENT pair, read on one component:")
for n in (5, 6, 7):
    r_all = component_rank([cov_ric_like, cov_trace_g], n, COMPS, 4)
    r_one = component_rank([cov_ric_like, cov_trace_g], n, [(0, 1)], 4)
    r_diag = component_rank([cov_ric_like, cov_trace_g], n, [(0, 0)], 4)
    print(f"    n={n}: comps {COMPS} -> rank {r_all};  [(0,1)] -> rank {r_one};"
          f"  [(0,0)] -> rank {r_diag}")
print("    so rank < N is a statement about the COMPONENTS, not about the family.")

print("\n(C) which maps the implication is about:")
def cov_shifted(W, n, i, j):
    return cov_ric_like(W, n, i, j) + 17*cov_trace_g(W, n, i, j)
for n in (5, 6, 7):
    print(f"    n={n}: raw rank on (F, F + 17|W|^2 g) = "
          f"{component_rank([cov_ric_like, cov_shifted], n, COMPS, 4)}"
          "   but they are ONE covariant into V_(2) (see r255_target_witness.py)")
