"""Diagram evaluation on six DISTINCT tensors -- the coefficient extraction the
apolarity pairing needs.

<P_i conj(P_j), J_b> pairs a sextic with at most a few thousand monomials
against a diagram functional.  Only the monomials where the product is nonzero
matter, so what is needed is J_b's coefficient on a given monomial -- and that
coefficient is the diagram contracted with the six basis tensors the monomial
names.  Reviewer 179's eval_diagram puts the same W in all six slots; this is
its polarisation.

THE COEFFICIENT CLAIM ABOVE IS FALSE, and reviewer 185 refuted it with a
witness.  This function is a correct VERTEX-ORDERED multilinear form -- 185
confirmed that by an independent single-einsum route -- but a monomial names an
UNORDERED multiset of six tensors, so its coefficient is the S6-symmetrisation,
not one ordering.  The two agree only on the diagonal beta = (6,0,0): across
three matchings and all 21 mixed multi-indices, the finite-difference
polarisation and the symmetrised form agree with each other and disagree with
this one.  eval_polarised takes 701 distinct values over the 720 permutations.

The validation that let it through is the lesson: J(W,...,W) and multilinearity
in slot 0 are both blind to symmetrisation, and the single case where the shipped
function IS right is exactly the case the diagonal check tests.  A check that can
only confirm.

Also: the self-pair `while ia` branch is unreachable under WI.random_matching,
which forbids intra-vertex pairs (0 of 20000).  It is correct when forced on the
ia side and raises ValueError when the self-pair lands on the ib side of a merge.
Dead code, and untested because untestable through this generator.
"""
import sys, os, numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "reviewers", "r179"))
import weyl_invariants as WI

def eval_polarised(tensors, matching, p):
    """the diagram evaluated with tensors[v] in vertex v, over F_p."""
    k = len(tensors)
    legs = {}
    for a, b in matching:
        legs[a] = b; legs[b] = a
    # float64 BLAS rather than object dtype: partial sums are bounded by
    # p^2 * n^6 = 65537^2 * 5^6 ~ 6.7e13, inside 2^53, so einsum is EXACT here
    # and roughly two orders of magnitude faster.  (The bound must be rechecked
    # if p or n grows -- reviewer 179 uses the same argument for its evaluator.)
    live = [(np.asarray(T, dtype=np.float64) % p, [4*v+j for j in range(4)])
            for v, T in enumerate(tensors)]
    while True:
        merged = False
        for x in range(len(live)):
            for y in range(x+1, len(live)):
                (A, ia), (B, ib) = live[x], live[y]
                common = [(s, t) for s in ia for t in ib if legs.get(s) == t]
                if not common: continue
                sub = {}
                nxt = iter("abcdefghijklmnopqrstuvwxyz")
                for s in ia: sub[s] = next(nxt)
                for t in ib: sub[t] = sub[legs[t]] if legs.get(t) in sub else next(nxt)
                out = [s for s in ia if legs.get(s) not in ib] + \
                      [t for t in ib if legs.get(t) not in ia]
                spec = ("".join(sub[s] for s in ia) + "," +
                        "".join(sub[t] for t in ib) + "->" +
                        "".join(sub[s] for s in out))
                live = [live[z] for z in range(len(live)) if z not in (x, y)]
                live.append((np.einsum(spec, A, B) % p, out))
                merged = True; break
            if merged: break
        if not merged: break
    # contract any remaining self-pairs within a single tensor
    val = 1
    for A, ia in live:
        while ia:
            s = ia[0]; t = legs[s]
            if t not in ia: return None
            i, j = ia.index(s), ia.index(t)
            A = np.trace(A, axis1=min(i, j), axis2=max(i, j)) % p
            ia = [z for z in ia if z not in (s, t)]
        val = (val * int(round(float(A)))) % p
    return val % p

if __name__ == "__main__":
    import random
    N, P, K = 5, 10007, 6
    rng = np.random.default_rng(4); pyrng = random.Random(4)
    W  = WI.random_weyl(N, P, rng)
    V  = WI.random_weyl(N, P, rng)
    ok_same = ok_lin = 0; trials = 0
    for _ in range(12):
        m = WI.random_matching(K, pyrng); trials += 1
        a = WI.eval_diagram(W, m, K, P) % P
        b = eval_polarised([W]*K, m, P)
        if a == b: ok_same += 1
        # multilinearity in slot 0: J(W+V, W..) = J(W,W..) + J(V,W..)
        lhs = eval_polarised([(W+V) % P] + [W]*(K-1), m, P)
        rhs = (eval_polarised([W]*K, m, P) +
               eval_polarised([V] + [W]*(K-1), m, P)) % P
        if lhs == rhs: ok_lin += 1
    print(f"  J(W,...,W) equals the unpolarised evaluation: {ok_same}/{trials}")
    print(f"  multilinear in slot 0:                        {ok_lin}/{trials}")
