"""r248, claim 3: what does the diagram route actually cost?

The file under review says the 184 x 184 Gram has "entries computed by GLUING
two diagrams -- a bijection sum over six vertices, 720 terms, each a closed-graph
value", and offers that as the reason the route avoids the 635,220-column
elimination.  Neither factor in that sentence is multiplied out, and "closed-graph
value" is left uncosted.  This script costs it.

THE GLUED OBJECT.  Diagram c and diagram b are each degree-6: six Weyl vertices,
24 legs, paired by a perfect matching.  A bijection sigma identifies the six
vertices of c with the six of b; each identified pair carries the Weyl PROJECTOR,
a rank-8 tensor (4 c-side indices, 4 b-side).  The c-side legs are contracted by
M_c and the b-side legs by M_b.  So the closed graph is:

    6 vertices, each of degree 8, 24 edges = M_c (12 edges) union M_b (12 edges),

an 8-regular multigraph on six vertices.  Its evaluation cost is set by the
widest cut any contraction order must cross.

TWO COST MODELS FOR THE SAME GRAPH.

  (A) NUMERIC, at n = 12, as the file's phrase "closed-graph value at n=12"
      invites: an intermediate with k open legs is an array of n^k entries.

  (B) DIAGRAMMATIC: every Weyl projector is O(n)-equivariant, so an intermediate
      with k open legs is an O(n)-INVARIANT tensor and, by the first fundamental
      theorem, lies in the span of the perfect matchings on k points -- (k-1)!!
      coefficients, INDEPENDENT OF n.  Merging two such costs one composition per
      pair of basis matchings, |A| x |B|, each composition an O(k) loop count.

Optimal pairwise contraction order is found exactly by subset DP over the six
vertices (2^6 = 64 subsets), so these are lower bounds on no particular
implementation: they are the best any pairwise order achieves.
"""
import itertools, random, math
from math import comb

NV = 6          # Weyl vertices in a degree-6 diagram
LEGS = 4        # indices per Weyl tensor
N = 12
NDIAG = 184

def dfact(k):
    """(k-1)!! = number of perfect matchings on k points; 0 if k odd."""
    if k % 2: return 0
    r = 1
    for j in range(k - 1, 0, -2): r *= j
    return r

def random_matching(legs, rng):
    ls = legs[:]; rng.shuffle(ls)
    return [(ls[2*i], ls[2*i+1]) for i in range(len(ls)//2)]

def glued_graph(rng):
    """edges of the glued 6-vertex graph, as a list of (u,v) vertex pairs."""
    cl = [(v, i, 'c') for v in range(NV) for i in range(LEGS)]
    bl = [(v, i, 'b') for v in range(NV) for i in range(LEGS)]
    E = []
    for (x, y) in random_matching(cl, rng) + random_matching(bl, rng):
        E.append((x[0], y[0]))
    return E

def cut_of(S, E):
    """open legs of the intermediate for vertex subset S (self-loops excluded)."""
    return sum(1 for (u, v) in E if ((u in S) != (v in S)))

def between(A, B, E):
    return sum(1 for (u, v) in E if (u in A and v in B) or (u in B and v in A))

def optimal_cost(E, step):
    return _opt(E, step, NV)

def _opt(E, step, NV):
    """min total work over pairwise contraction orders.  `step(ka, kb, idx)` is
    the cost of merging intermediates with ka and kb open legs over idx distinct
    index lines.  Returns (total_cost, max_intermediate_legs)."""
    verts = list(range(NV))
    best = {}
    for v in verts:
        best[frozenset([v])] = (0, cut_of({v}, E))
    for r in range(2, NV + 1):
        for S in itertools.combinations(verts, r):
            Sf = frozenset(S); bc, bw = None, None
            # split S into A | B, A containing S[0]
            rest = S[1:]
            for m in range(1, r):
                for sub in itertools.combinations(rest, m - 1):
                    A = frozenset((S[0],) + sub); B = Sf - A
                    ca, wa = best[A]; cb, wb = best[B]
                    ka, kb = cut_of(A, E), cut_of(B, E)
                    idx = ka + kb - between(A, B, E)
                    tot = ca + cb + step(ka, kb, idx)
                    w = max(wa, wb, idx)
                    if bc is None or tot < bc: bc, bw = tot, w
            best[Sf] = (bc, bw)
    return best[frozenset(verts)]

def glued_graph3(rng):
    """the same gluing for two DEGREE-3 diagrams: 3 vertices, degree 8, 12 edges."""
    cl = [(v, i, 'c') for v in range(3) for i in range(LEGS)]
    bl = [(v, i, 'b') for v in range(3) for i in range(LEGS)]
    return [(x[0], y[0]) for (x, y) in random_matching(cl, rng) + random_matching(bl, rng)]

def optimal_cost3(E, step):
    return _opt(E, step, 3)

def main():
    rng = random.Random(248)
    numeric, diagram, widths = [], [], []
    TRIALS = 200
    for _ in range(TRIALS):
        E = glued_graph(rng)
        cn, wn = optimal_cost(E, lambda ka, kb, idx: N ** idx)
        cd, wd = optimal_cost(E, lambda ka, kb, idx: max(dfact(ka), 1) * max(dfact(kb), 1))
        numeric.append(cn); diagram.append(cd); widths.append(wn)
    numeric.sort(); diagram.sort(); widths.sort()
    med_n = numeric[TRIALS // 2]; med_d = diagram[TRIALS // 2]
    print(f"glued graph: {NV} vertices, degree 8, 24 edges; {TRIALS} random gluings")
    print(f"  optimal contraction WIDTH (max open legs): min {widths[0]}, "
          f"median {widths[TRIALS//2]}, max {widths[-1]}")
    print(f"  ONE closed graph, model A (arrays at n={N}):  median {med_n:.3e} flops"
          f"   [min {numeric[0]:.3e}, max {numeric[-1]:.3e}]")
    print(f"  ONE closed graph, model B (Brauer coeffs):    median {med_d:.3e} ops"
          f"   [min {diagram[0]:.3e}, max {diagram[-1]:.3e}]")
    print(f"  peak array at width w={widths[-1]}: {N**widths[-1]:.3e} entries "
          f"= {N**widths[-1]*8/2**40:.3e} TiB in float64")

    entries = NDIAG * (NDIAG + 1) // 2
    graphs = entries * 720
    print()
    print(f"THE GRAM.  {NDIAG}x{NDIAG} symmetric -> {entries:,} entries")
    print(f"  x 720 bijections = {graphs:,} closed graphs")
    print(f"  model A total: {graphs*med_n:.3e} flops")
    print(f"  model B total: {graphs*med_d:.3e} ops")
    # a generous 1e10 flop/s
    print(f"  at 1e10 op/s: model A {graphs*med_n/1e10/3600/24/365:.3e} years, "
          f"model B {graphs*med_d/1e10:.3e} s")

    print()
    print("WHAT WAS ABANDONED, for scale.  The trivial block of Sym^3(Weyl_12) has")
    print("  635,220 columns; r222/r225 extrapolate 42.5 h for it, and the tail run")
    print("  stopped at 7 of 71 blocks.  Dense elimination on a k-column block is")
    print("  ~k^3/3; sparse (r221) beat it on the blocks measured.")
    for k in (6137, 13444, 635220):
        print(f"    k={k:>7,}: k^3/3 = {k**3/3:.3e} flops")
    print(f"  all 71 blocks bounded above by 71 x the largest: "
          f"{71*635220**3/3:.3e} flops")

    print()
    print("AND THE GRAM IS NOT 184 x 184 DENSE.  J_c takes values in the irrep")
    print("  V_{lambda_c}; O(n) irreps are self-dual and inequivalent irreps pair to")
    print("  zero, so <J_c,J_b> = 0 whenever lambda_c != lambda_b.  M(n) is BLOCK")
    print("  DIAGONAL, one block per lambda of size m_lambda.  From the record's own")
    print("  n12_sym3_blocks.pkl:")
    import pickle, os
    BL = pickle.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                     "..", "..", "runs", "n12_sym3_blocks.pkl"), "rb"))
    mult = sorted(BL.values())
    tri = sum(m*(m+1)//2 for m in mult)
    print(f"    {len(mult)} blocks, multiplicities summing to {sum(mult)}, max {max(mult)}")
    print(f"    upper-triangular entries actually needed: {tri}, not {entries:,}")
    print(f"    -> the entry count the file implies is {entries/tri:.0f}x too large,")
    print(f"       and det M(n) is a PRODUCT of {len(mult)} determinants of size <= "
          f"{max(mult)}")
    print()
    print("AND THE DEGREE IS WRONG.  720 = 6! is the bijection count for gluing two")
    print("  DEGREE-6 diagrams, which is what run_n5_diagram_gram.py does -- its")
    print("  objects are degree-6 O(5)-INVARIANTS, counted 14 at n=5 and 89")
    print("  universally (plan A1).  The 184 are degree-3 COVARIANTS in")
    print("  Sym^3(Weyl_12) (r221: 191 SO multiplicities less 7 chiral pairs).")
    print("  Gluing two cubics identifies THREE vertices: 3! = 6 bijections.")
    print("  Priced under the reading the item actually needs -- 184 cubic")
    print("  covariants, block diagonal, 6 bijections, 3-vertex glued graphs:")
    rng2 = random.Random(1248)
    c3n, c3d, w3 = [], [], []
    for _ in range(200):
        E3 = glued_graph3(rng2)
        a, wa = optimal_cost3(E3, lambda ka, kb, idx: N ** idx)
        b, wb = optimal_cost3(E3, lambda ka, kb, idx: max(dfact(ka),1)*max(dfact(kb),1))
        c3n.append(a); c3d.append(b); w3.append(wa)
    c3n.sort(); c3d.sort(); w3.sort()
    g3 = tri * 6
    print(f"    {tri} entries x 6 bijections = {g3:,} closed graphs on 3 vertices")
    print(f"    width: median {w3[100]}, max {w3[-1]}")
    print(f"    model A total {g3*c3n[100]:.3e} flops; model B total "
          f"{g3*c3d[100]:.3e} ops")
    print()
    print("THE r240 REFINEMENT.  brauer-pairing.md: <P,Q> = n^L q_D, a MONOMIAL in n")
    print("  times an n-independent constant.  So per entry one needs (i) L, a cycle")
    print("  count on the glued graph -- O(24) union-find -- and (ii) one constant.")
    print("  NOTHING has to be evaluated at n=12: the dimension never enters.")
    print("  Degree bound it hands the Sturm step, free:")
    print(f"    deg det M(n) <= sum of L along a permutation <= {NDIAG} x 6 = {NDIAG*6}")
    print(f"    and blockwise, <= 6 x max m_lambda = {6*max(mult)} per factor")

if __name__ == '__main__':
    main()
