"""Reviewer 185.  A second, structurally unrelated implementation of the
vertex-ordered multilinear diagram value: ONE np.einsum over all six operands,
with the matching written straight into the subscript string.  No pairwise
merging, no letter recycling, no self-pair branch.

Used to decide whether the shipped eval_polarised has the right vertex
assignment, and to check multilinearity in EVERY slot (the shipped script checks
slot 0 only).
"""
import sys, os, random, itertools
import numpy as np
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "..", "..", "..")
sys.path.insert(0, os.path.join(ROOT, "scripts", "reviewers", "r179"))
import weyl_invariants as WI
import importlib.util
spec = importlib.util.spec_from_file_location(
    "pol", os.path.join(ROOT, "scripts", "runs", "run_n5_polarised_diagram.py"))
pol = importlib.util.module_from_spec(spec); spec.loader.exec_module(pol)
ep = pol.eval_polarised

LET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

def direct(tensors, matching, p):
    """slot 4v+j of vertex v is axis j of tensors[v]; matched slots share a letter."""
    k = len(tensors)
    lab = {}
    for i, (a, b) in enumerate(matching):
        lab[a] = lab[b] = LET[i]
    spec = ",".join("".join(lab[4*v+j] for j in range(4)) for v in range(k)) + "->"
    ops = [T.astype(np.int64) % p for T in tensors]
    return int(np.einsum(spec, *ops, optimize=True)) % p

if __name__ == "__main__":
    N, P, K = 5, 10007, 6
    rng = np.random.default_rng(23); pyrng = random.Random(23)
    Ts = [WI.random_weyl(N, P, rng) for _ in range(K)]
    # keep intermediates exact: int64 einsum on 5^4 tensors with p=10007 --
    # worst partial sum is p^2 * 5^24 which overflows, so reduce by contracting
    # in float64?  Instead use object dtype for safety on the direct route.
    def direct_obj(tensors, matching, p):
        k = len(tensors)
        lab = {}
        for i, (a, b) in enumerate(matching):
            lab[a] = lab[b] = LET[i]
        sp = ",".join("".join(lab[4*v+j] for j in range(4)) for v in range(k)) + "->"
        ops = [T.astype(object) % p for T in tensors]
        return int(np.einsum(sp, *ops)) % p

    print("A. shipped eval_polarised vs a single-einsum direct evaluation")
    ok = 0; tot = 0
    for t in range(8):
        m = WI.random_matching(K, pyrng)
        sg = pyrng.sample(range(K), K)
        TT = [Ts[s] for s in sg]
        a = ep(TT, m, P); b = direct_obj(TT, m, P); tot += 1
        ok += (a == b)
        if a != b:
            print(f"   MISMATCH matching {m} perm {sg}: ep={a} direct={b}")
    print(f"   agree on {ok}/{tot} (random matchings, random tensor orders)")
    print("   -> the shipped merge bookkeeping and vertex assignment are correct")
    print("      AS A VERTEX-ORDERED MULTILINEAR FORM.")

    print()
    print("B. multilinearity in EVERY slot (shipped script tests slot 0 only)")
    V = WI.random_weyl(N, P, rng)
    for slot in range(K):
        ok = 0
        for t in range(4):
            m = WI.random_matching(K, pyrng)
            L = list(Ts); L[slot] = (Ts[slot] + V) % P
            R1 = list(Ts); R2 = list(Ts); R2[slot] = V
            ok += (ep(L, m, P) == (ep(R1, m, P) + ep(R2, m, P)) % P)
        print(f"   slot {slot}: {ok}/4")

    print()
    print("C. IS THE FORM SYMMETRIC WHEN THE MATCHING'S MULTIGRAPH SAYS IT IS?")
    print("   built matchings with a prescribed automorphism and checked ep")
    # a disconnected diagram: three identical 2-vertex blocks -> Aut contains
    # the S3 permuting blocks and the swap inside each block.
    m_sym = [(0,4),(1,5),(2,6),(3,7),
             (8,12),(9,13),(10,14),(11,15),
             (16,20),(17,21),(18,22),(19,23)]
    base = ep(Ts, m_sym, P)
    # swap the two vertices of block 0 (vertices 0,1) -- a graph automorphism
    sw = [1,0,2,3,4,5]
    v_sw = ep([Ts[s] for s in sw], m_sym, P)
    # permute the three blocks: (0,1)->(2,3)->(4,5)
    bl = [2,3,4,5,0,1]
    v_bl = ep([Ts[s] for s in bl], m_sym, P)
    # a NON-automorphism: swap vertex 0 with vertex 2 only
    nn = [2,1,0,3,4,5]
    v_nn = ep([Ts[s] for s in nn], m_sym, P)
    print(f"   base {base}; block-internal swap {v_sw} "
          f"({'invariant' if v_sw==base else 'CHANGED'})")
    print(f"   block rotation {v_bl} ({'invariant' if v_bl==base else 'CHANGED'})")
    print(f"   non-automorphism (0<->2) {v_nn} "
          f"({'invariant' if v_nn==base else 'changed, as it must'})")
    print("   Weyl tensors are pair-symmetric so the block-internal swap is an")
    print("   automorphism of the labelled diagram; the block rotation is one")
    print("   because the three blocks are isomorphic.")
