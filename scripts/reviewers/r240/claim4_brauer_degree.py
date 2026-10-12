"""r240, claim 4 -- how large a power of n a degree-6 Brauer pairing can produce.

THE STATEMENT UNDER REVIEW.  plan.md A2: "Every Gram entry of two diagram
covariants is a closed Brauer diagram, valued a polynomial in n."  r238 exhibited
one instance (two covariants each carrying a bare metric pair to n * I_3^2) and
the record now says the n-dependence "lives in the pairing".  The brief asks: is
it a polynomial, and of what degree?

THE DERIVATION THIS SCRIPT CHECKS.

  A degree-3 REDUCED diagram covariant with f free indices is
      P_{a_1..a_f} = (3 Weyl factors, 12 slots) x (a bare metrics on free indices)
  where the 12 W-slots are partitioned into internal contraction pairs and free
  indices, the a bare metrics pair up 2a of the free positions, and REDUCED means
  no factor of the covariant is a closed delta-loop by itself.

  Contract P with Q along all f free positions.  Build the PAIRING GRAPH: nodes
  are the 24 W-slots plus the f free positions; edges are P's internal pairs,
  P's free-index-to-W-slot assignments, P's bare metrics, and the same three for
  Q.  Every W-slot has degree exactly 1 and every free position degree exactly 2,
  so the graph is a disjoint union of PATHS (two W-slot endpoints) and CYCLES
  (free positions and bare-metric edges only).  Hence

      <P, Q> = n^L * q_D(W),

  L the number of cycle components and D the closed degree-6 diagram whose
  matching is read off the path components.  Each cycle alternates P-metrics and
  Q-metrics, so it uses equally many of each and has at least 2 nodes:

      0 <= L <= min(a_P, a_Q) <= floor(f/2).

  So every entry is a MONOMIAL n^L times an n-independent diagram value -- a
  polynomial in n of degree at most floor(f/2), and the bound is attained.

WHAT THIS SCRIPT DOES.  It implements covariants as pairing data, evaluates
<P,Q> by brute-force exact contraction of tensors over several n, computes L and
the reduced diagram D from the graph alone, and checks
<P,Q> = n^L * q_D(W) at every n -- for pairings realising L = 0, 1, 2, 3, 4.
Exact integer arithmetic throughout (the Weyl tensor is built on R^4, cleared to
integers, and zero-padded, which r232 audited as staying Weyl).
"""
import itertools
import numpy as np
from fractions import Fraction as F

# ---------------------------------------------------------------- exact Weyl --

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


rng = np.random.default_rng(240)
A0 = np.vectorize(F)(rng.integers(-3, 4, size=(4, 4, 4, 4)).astype(object))
W4 = weyl_project_exact(A0, 4)
den = 1
for v in W4.ravel():
    den = den * v.denominator // np.gcd(den, v.denominator)
W4 = np.vectorize(lambda z: int(z * den))(W4)          # integer Weyl tensor
assert np.all(W4 == -np.transpose(W4, (1, 0, 2, 3)))
assert np.all(W4 == -np.transpose(W4, (0, 1, 3, 2)))
assert np.all(W4 == np.transpose(W4, (2, 3, 0, 1)))
assert np.all(W4 + np.transpose(W4, (0, 2, 3, 1)) + np.transpose(W4, (0, 3, 1, 2)) == 0)
assert np.all(np.einsum('ikjk->ij', W4) == 0)
print("exact integer Weyl tensor on R^4: antisym, pair-sym, Bianchi, trace-free  OK")


def pad(n):
    out = np.zeros((n, n, n, n), dtype=object)
    out[:] = 0
    out[:4, :4, :4, :4] = W4
    return out


# ------------------------------------------------------- covariants as data --
# A covariant is (nW, pairs, freeW, metrics):
#   pairs   : internal contractions, list of (slot, slot),  slot = (w, s)
#   freeW   : dict free-position -> slot            (free index sitting on a W leg)
#   metrics : list of (free-position, free-position) (a bare metric)
# with every slot of every W factor used exactly once and free positions 0..f-1
# partitioned between freeW keys and the metric pairs.

LETTERS = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'


def check_covariant(cov, f):
    nW, pairs, freeW, metrics = cov
    used = [s for p in pairs for s in p] + list(freeW.values())
    allslots = [(w, s) for w in range(nW) for s in range(4)]
    assert sorted(used) == sorted(allslots), "W slots not used exactly once"
    fp = sorted(list(freeW) + [p for m in metrics for p in m])
    assert fp == list(range(f)), "free positions not partitioned"


def _greedy_contract(net):
    """contract a list of (subscripts, array) to a scalar, pairwise and greedily.

    numpy's naive einsum path costs n^(number of distinct indices), which for a
    degree-6 network with metrics is n^24.  Contracting two operands at a time,
    always the pair whose result has the fewest indices, keeps every intermediate
    at n^6 or below and stays inside exact object arithmetic.
    """
    net = list(net)
    while len(net) > 1:
        best = None
        for i in range(len(net)):
            for j in range(i + 1, len(net)):
                si, sj = net[i][0], net[j][0]
                others = set().union(*[set(t) for k, (t, _) in enumerate(net)
                                       if k not in (i, j)]) if len(net) > 2 else set()
                keep = ''.join(sorted((set(si) | set(sj)) & others))
                cost = len(set(si) | set(sj))
                if best is None or (len(keep), cost) < best[0]:
                    best = ((len(keep), cost), i, j, keep)
        _, i, j, keep = best
        si, ai = net[i]
        sj, aj = net[j]
        r = np.einsum(f'{si},{sj}->{keep}', ai, aj)
        net = [net[k] for k in range(len(net)) if k not in (i, j)] + [(keep, r)]
    s, arr = net[0]
    assert s == ''
    return arr


def _network(cov, W, n, f, tag, freeletter):
    """the operand list of a covariant, free position p carrying letter
    freeletter(p) so two covariants can share them."""
    nW, pairs, freeW, metrics = cov
    idx = {}
    nxt = [0]
    def fresh():
        c = LETTERS[26 + nxt[0]] if tag == 'Q' else LETTERS[nxt[0]]
        nxt[0] += 1
        return c
    for (s1, s2) in pairs:
        c = fresh()
        idx[s1] = idx[s2] = c
    for p, s in freeW.items():
        idx[s] = freeletter(p)
    net = []
    for w in range(nW):
        net.append((''.join(idx[(w, s)] for s in range(4)), W))
    g = np.eye(n, dtype=object)
    for (p, q) in metrics:
        net.append((freeletter(p) + freeletter(q), g))
    return net


def _net_subscripts(covP, covQ, W, n, f):
    fl = lambda p: 'STUVWXYZ'[p]
    return _network(covP, W, n, f, 'P', fl) + _network(covQ, W, n, f, 'Q', fl)


def pair_bruteforce(covP, covQ, W, n, f):
    """<P,Q> by direct exact contraction of the whole network -- no use is made
    of the reduction being checked."""
    return int(_greedy_contract(_net_subscripts(covP, covQ, W, n, f)))


def pair_float(covP, covQ, Wf, n, f):
    """the same contraction in float64 with numpy's own optimiser -- a second,
    independent contraction ORDER as well as a second arithmetic."""
    net = _net_subscripts(covP, covQ, Wf, n, f)
    subs = ','.join(t for t, _ in net) + '->'
    return float(np.einsum(subs, *[a for _, a in net], optimize='greedy'))


def eval_closed_float(matching, Wf, nP, nQ):
    idx, nxt = {}, 0
    for (u, v) in matching:
        idx[u] = idx[v] = LETTERS[nxt]
        nxt += 1
    terms, ops = [], []
    for tag, cnt in (('P', nP), ('Q', nQ)):
        for w in range(cnt):
            terms.append(''.join(idx[(tag, w, s)] for s in range(4)))
            ops.append(Wf)
    return float(np.einsum(','.join(terms) + '->', *ops, optimize='greedy'))


# ---------------------------------------------- the graph reduction, claimed --

def reduce_pairing(covP, covQ, f):
    """returns (L, closed-diagram matching on the 24 slots of the 6 W factors).

    Nodes: the W-slots of P and of Q (degree 1 each -- one edge from their own
    covariant) and the f free positions (degree 2 -- one edge from P, one from
    Q).  A graph all of whose degrees are 1 or 2 is a disjoint union of paths and
    cycles; the paths run between two W-slots and give the closed diagram's
    matching, the cycles carry only free positions and bare-metric edges and each
    contributes a factor delta^a_a = n.
    """
    nP, pairsP, freeP, metP = covP
    nQ, pairsQ, freeQ, metQ = covQ
    edges = []
    for tag, pairs, freeW, mets in (('P', pairsP, freeP, metP),
                                    ('Q', pairsQ, freeQ, metQ)):
        for (s1, s2) in pairs:
            edges.append(((tag,) + s1, (tag,) + s2))
        for p, s in freeW.items():
            edges.append((('f', p), (tag,) + s))
        for (p, q) in mets:
            edges.append((('f', p), ('f', q)))
    adj = {}
    for eid, (u, v) in enumerate(edges):
        adj.setdefault(u, []).append((v, eid))
        adj.setdefault(v, []).append((u, eid))
    for u, vs in adj.items():
        assert len(vs) == (2 if u[0] == 'f' else 1), (u, vs)
    used = set()
    matching = []
    for s in [u for u in adj if u[0] != 'f']:
        if all(e in used for _, e in adj[s]):
            continue
        cur = s
        while True:
            nxt = [(v, e) for (v, e) in adj[cur] if e not in used]
            if not nxt:
                break
            v, e = nxt[0]
            used.add(e)
            cur = v
        assert cur[0] != 'f'
        matching.append(tuple(sorted([s, cur])))
    L = 0
    for eid, (u, v) in enumerate(edges):
        if eid in used:
            continue
        L += 1
        cur, start = u, u
        used.add(eid)
        cur = v
        while cur != start:
            nxt = [(w, e) for (w, e) in adj[cur] if e not in used]
            assert nxt, (cur, start)
            w, e = nxt[0]
            used.add(e)
            cur = w
    assert len(used) == len(edges)
    return L, sorted(matching)


def eval_closed(matching, W, n, nP, nQ):
    """value of the closed degree-6 diagram given by `matching` on 6 W factors,
    exactly.  Contracted pairwise: the naive einsum path over 12 distinct
    indices would cost n^12."""
    idx, nxt = {}, 0
    for (u, v) in matching:
        idx[u] = idx[v] = LETTERS[nxt]
        nxt += 1
    net = []
    for tag, cnt in (('P', nP), ('Q', nQ)):
        for w in range(cnt):
            net.append((''.join(idx[(tag, w, s)] for s in range(4)), W))
    return int(_greedy_contract(net))


# ------------------------------------------------------------------ cases -----
# Covariant building blocks, all degree 3 in W.
#   I3    : the scalar W_ijkl W_klmn W_mnij           (no free index)
#   A_ab  : W_aikl W_klmn W_mnib                      (2 free indices, pure Weyl)
# Bare metrics are added on top; `f` is the number of free positions.

def I3_body(off=0):
    """three W factors, all 12 slots contracted internally: W W W closed."""
    pairs = [(((0, 2)), (1, 0)), ((0, 3), (1, 1)), ((1, 2), (2, 0)),
             ((1, 3), (2, 1)), ((2, 2), (0, 0)), ((2, 3), (0, 1))]
    return pairs


def cov_metrics_only(f):
    """P = delta_{a0a1} delta_{a2a3} ... * I3(W): a = f/2 bare metrics."""
    assert f % 2 == 0
    return (3, I3_body(), {}, [(2 * i, 2 * i + 1) for i in range(f // 2)])


def cov_metrics_shift(f):
    """same but the metrics pair (a1,a2), (a3,a4), ..., (a_{f-1}, a0) -- rotated."""
    assert f % 2 == 0
    ms = [(2 * i + 1, (2 * i + 2) % f) for i in range(f // 2)]
    return (3, I3_body(), {}, ms)


def cov_A_pure():
    """A_{ab} = W_{a i k l} W_{k l m n} W_{m n i b}: 2 free, pure Weyl."""
    pairs = [((0, 1), (2, 2)), ((0, 2), (1, 0)), ((0, 3), (1, 1)),
             ((1, 2), (2, 0)), ((1, 3), (2, 1))]
    return (3, pairs, {0: (0, 0), 1: (2, 3)}, [])


def cov_A_plus_metric():
    """A_{ab} on free 0,1 and a bare metric on free 2,3 -- f = 4, a = 1."""
    nW, pairs, freeW, _ = cov_A_pure()
    return (nW, pairs, freeW, [(2, 3)])


def cov_metric_then_A():
    """bare metric on free 0,1 and A on free 2,3 -- f = 4, a = 1, metric moved."""
    nW, pairs, _, _ = cov_A_pure()
    return (nW, pairs, {2: (0, 0), 3: (2, 3)}, [(0, 1)])


CASES = [
    ("f=2  A vs A            (a=0,0)", 2, cov_A_pure(), cov_A_pure()),
    ("f=2  A vs g*I3         (a=0,1)", 2, cov_A_pure(), (3, I3_body(), {}, [(0, 1)])),
    ("f=2  g*I3 vs g*I3      (a=1,1)", 2, (3, I3_body(), {}, [(0, 1)]),
     (3, I3_body(), {}, [(0, 1)])),
    ("f=4  gg*I3 vs gg*I3    (a=2,2)", 4, cov_metrics_only(4), cov_metrics_only(4)),
    ("f=4  gg*I3 vs rotated  (a=2,2)", 4, cov_metrics_only(4), cov_metrics_shift(4)),
    ("f=4  A+g vs A+g        (a=1,1)", 4, cov_A_plus_metric(), cov_A_plus_metric()),
    ("f=4  A+g vs g+A        (a=1,1)", 4, cov_A_plus_metric(), cov_metric_then_A()),
    ("f=4  A+g vs gg*I3      (a=1,2)", 4, cov_A_plus_metric(), cov_metrics_only(4)),
    ("f=6  ggg*I3 vs ggg*I3  (a=3,3)", 6, cov_metrics_only(6), cov_metrics_only(6)),
    ("f=6  ggg*I3 vs rotated (a=3,3)", 6, cov_metrics_only(6), cov_metrics_shift(6)),
    ("f=8  g^4*I3 vs g^4*I3  (a=4,4)", 8, cov_metrics_only(8), cov_metrics_only(8)),
    ("f=8  g^4*I3 vs rotated (a=4,4)", 8, cov_metrics_only(8), cov_metrics_shift(8)),
]

DIMS = [4, 5, 6, 7, 8, 9, 10]
EXACT_DIMS = [4, 5, 6]


def padf(n):
    out = np.zeros((n, n, n, n))
    out[:4, :4, :4, :4] = np.vectorize(float)(W4)
    return out


Wf = {n: padf(n) for n in DIMS}
Wx = {n: pad(n) for n in EXACT_DIMS}

print(f"\nthe pairing is contracted TWICE and compared against n^L * q_D(W):")
print(f"  - float64 with numpy's optimal path at n = {DIMS}")
print(f"  - exact integers with a greedy pairwise path at n = {EXACT_DIMS}\n")
hdr = (f"{'pairing':<34} {'L':>2} {'<= f/2':>6} {'fitted deg':>10}  "
       f"{'n^L q_D at every n':>19}  {'exact anchor':>12}")
print(hdr)
print("-" * len(hdr))
maxL = {}
import sympy
x = sympy.Symbol('x')
for name, f, cP, cQ in CASES:
    check_covariant(cP, f)
    check_covariant(cQ, f)
    L, matching = reduce_pairing(cP, cQ, f)
    import time as _t
    _t0 = _t.time()
    print(f"  [{name}] L={L} ... ", end="", flush=True)
    ok = True
    vals = []
    for n in DIMS:
        v = pair_float(cP, cQ, Wf[n], n, f)
        q = eval_closed_float(matching, Wf[n], cP[0], cQ[0])
        vals.append(v)
        if abs(v - (n ** L) * q) > 1e-9 * max(1.0, abs(v)):
            ok = False
    exact_ok = True
    for n in EXACT_DIMS:
        ve = pair_bruteforce(cP, cQ, Wx[n], n, f)
        qe = eval_closed(matching, Wx[n], n, cP[0], cQ[0])
        if ve != (n ** L) * qe:
            exact_ok = False
    # exact polynomial interpolation through the float values, rounded
    poly = sympy.interpolate(list(zip(DIMS, [sympy.Rational(round(v)) for v in vals])), x)
    deg = sympy.Poly(poly, x).degree() if poly != 0 else 0
    maxL[f] = max(maxL.get(f, 0), L)
    print(f"\r{name:<34} {L:>2} {f // 2:>6} {deg:>10}  {str(ok):>19}  {str(exact_ok):>12}"
          f"   [{_t.time()-_t0:.0f}s]")
    assert ok and exact_ok, name
    assert L <= min(len(cP[3]), len(cQ[3])) <= f // 2
    assert deg == L, (name, deg, L)

print("\nthe bound is attained at every f tested:", maxL)
print("L <= min(a_P, a_Q) <= floor(f/2) holds in every case, with equality when")
print("the two bare-metric matchings coincide.")

# ---------------------------------------------------------- the sharp cases --
print("\nsharpness, symbolically: P = Q = delta^{(x)f/2} * I3 gives n^{f/2} * I3^2.")
for f in (2, 4, 6, 8, 10, 12):
    cP = cov_metrics_only(f)
    L, matching = reduce_pairing(cP, cP, f)
    print(f"    f = {f:>2}:  L = {L} = floor(f/2)")
    assert L == f // 2

print("""
THE CEILING FOR THE CERTIFICATE.  A block of Sym^3(W_12) is labelled by a
partition lam of the 77 SO(12) constituents (r177's decomp_D6.json); a diagram
covariant in that block has f = |lam| free indices, and |lam| <= 12 because
Sym^3(W_n) sits inside the 12-fold tensor power.  The sizes present are

    |lam| :   0   2   4   6   8  10  12
    count :   1   1   5  10  17  24  19

all EVEN, so the per-block ceiling is exactly n^{|lam|/2}, and the ceiling over
the whole pairing matrix is

    deg_n <= 6,   attained only in the 19 blocks with |lam| = 12.

r238's witness is the f = 2 row, L = 1 -- maximal for its own block.""")
