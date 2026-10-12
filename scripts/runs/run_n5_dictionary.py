"""The dictionary: each of the 36 Gram unknowns as a coefficient vector on the
14 invariant sextics.

Structure that makes this cheap, established before writing any of it:

  * Every adapted basis vector has a definite weight, and so does every graded
    piece of x = W^3.  So expanding x in the adapted basis is NOT one 7770 x 7770
    solve -- it is one square solve per weight, the largest being 234 x 234.
  * Within a copy of V_lambda, vectors of different weight are orthogonal, so the
    pairing metric is block-diagonal by weight.  The largest weight multiplicity
    inside any of the 24 blocks is 14, so the metric blocks are at most 14 x 4.
  * Copies are built by applying the SAME lowering words to each highest-weight
    vector, which is what identifies copy i with copy j equivariantly.  Without
    that, <v_i, v_j> is not even defined.

Then B_ij(W) = (c^i)^dagger M_lambda c^j, and F_5 = sum_lambda sum_ij (G_lam)_ij B_ij
is the linear system to solve, 36 unknowns against 14 equations.
"""
from fractions import Fraction as F
import importlib.util, sys, os, time, json

d = os.path.dirname(os.path.abspath(__file__))
CACHE = os.path.join(d, "n5_hw_cache.json")

def load_hw():
    """highest-weight vectors, from cache when present -- the module rebuild
    costs two to three minutes and every downstream stage would pay it."""
    spec = importlib.util.spec_from_file_location(
        "hw", os.path.join(d, "run_n5_highest_weight.py"))
    m = importlib.util.module_from_spec(spec)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    spec.loader.exec_module(m); sys.stdout = o
    return m

def words_from(u, lower_ops, cap, reduce_against):
    """BFS over lowering words, recording the WORD for each new basis vector.

    The word list is what transports copy i to copy j: applying the same words
    to u_j gives the matching basis, so the two coordinate vectors are directly
    comparable.
    """
    basis, words = [], []
    ech = {}
    frontier = [([], u)]
    while frontier and len(basis) < cap:
        nxt = []
        for word, v in frontier:
            w = reduce_against(v, ech)
            if not w: continue
            piv = max(w); ech[piv] = w
            basis.append(v); words.append(word)
            for oi, op in enumerate(lower_ops):
                nv = op(v)
                if nv: nxt.append((word + [oi], nv))
        frontier = nxt
    return basis, words

print("stage 2 scaffold written; it consumes stage 1's validated copies.")
print("Blocked on: run_n5_copies.py confirming generated == Weyl dimension per block.")
