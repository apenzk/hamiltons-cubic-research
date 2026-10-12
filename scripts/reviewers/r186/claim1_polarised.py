"""Claim 1, r186: does run_n5_polarised_diagram.eval_polarised put the right
tensor at the right vertex, and do its two checks pin that?

Three things are separated here:
  A. an INDEPENDENT evaluator (tensordot + explicit leg lists, greedy contraction
     order) compared against the shipped einsum-letter code on six DISTINCT tensors;
  B. a WITNESS: a deliberately wrong map that passes both shipped checks;
  C. what the two checks DO pin, proved rather than measured.
"""
import sys, os, random, itertools, time
import numpy as np
ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..")
sys.path.insert(0, os.path.join(ROOT, "scripts", "reviewers", "r179"))
import importlib.util
import weyl_invariants as WI
spec = importlib.util.spec_from_file_location(
    "pol", os.path.join(ROOT, "scripts", "runs", "run_n5_polarised_diagram.py"))
pol = importlib.util.module_from_spec(spec); spec.loader.exec_module(pol)
ep = pol.eval_polarised

N, P, K = 5, 10007, 6

def ref_polarised(tensors, matching, p, maxsize=10):
    """independent: explicit leg lists + np.tensordot, greedy least-output order."""
    legs = {}
    for a, b in matching: legs[a] = b; legs[b] = a
    live = [(np.array(T, dtype=np.int64) % p, [4*v+j for j in range(4)])
            for v, T in enumerate(tensors)]
    while True:
        best = None
        for i in range(len(live)):
            for j in range(i+1, len(live)):
                li, lj = live[i][1], live[j][1]
                sh = [(a, legs[a]) for a in li if legs.get(a) in lj]
                if not sh: continue
                out = len(li) + len(lj) - 2*len(sh)
                if best is None or out < best[0]: best = (out, i, j, sh)
        if best is None: break
        out, i, j, sh = best
        if out > maxsize: return None
        Ti, li = live[i]; Tj, lj = live[j]
        ax0 = [li.index(a) for a, b in sh]; ax1 = [lj.index(b) for a, b in sh]
        Tn = np.tensordot(Ti, Tj, axes=(ax0, ax1)) % p
        ln = [l for x, l in enumerate(li) if x not in ax0] + \
             [l for x, l in enumerate(lj) if x not in ax1]
        live = [live[z] for z in range(len(live)) if z not in (i, j)] + [(Tn, ln)]
    val = 1
    for T, l in live:
        while l:                       # internal self-pairs, traced last
            s = l[0]; t = legs[s]
            if t not in l: return None
            a, b = l.index(s), l.index(t)
            T = np.trace(T, axis1=min(a, b), axis2=max(a, b)) % p
            l = [z for z in l if z not in (s, t)]
        val = val * int(T) % p
    return val % p

rng = np.random.default_rng(186); pyrng = random.Random(186)
TS = [WI.random_weyl(N, P, rng) for _ in range(K)]
MS = []
while len(MS) < 25: MS.append(WI.random_matching(K, pyrng))

print("A. shipped eval_polarised vs an independent tensordot evaluator, "
      "on six DISTINCT Weyl tensors")
agree = diff = skipped = 0
t0 = time.time()
for m in MS:
    r = ref_polarised(TS, m, P)
    if r is None: skipped += 1; continue
    s = ep(TS, m, P)
    if r == s: agree += 1
    else:
        diff += 1
        print(f"   MISMATCH on {m}: shipped {s}, independent {r}")
print(f"   agree {agree}, disagree {diff}, skipped-for-size {skipped}  "
      f"({time.time()-t0:.0f}s)")

print("\n   the same comparison after permuting the six tensors (the assignment "
      "is what is under test)")
agree2 = diff2 = 0
for m in MS[:8]:
    for _ in range(3):
        perm = list(range(K)); pyrng.shuffle(perm)
        TP = [TS[perm[v]] for v in range(K)]
        r = ref_polarised(TP, m, P)
        if r is None: continue
        s = ep(TP, m, P)
        agree2 += (r == s); diff2 += (r != s)
print(f"   agree {agree2}, disagree {diff2}")

print("\nB. WITNESS: a wrong map that passes BOTH shipped checks")
SIGMA = [1, 0, 2, 3, 4, 5]          # swap the tensors at vertices 0 and 1
def eval_wrong(tensors, matching, p):
    return ep([tensors[SIGMA[v]] for v in range(len(tensors))], matching, p)
ok_same = ok_lin = 0; trials = 0
V = WI.random_weyl(N, P, rng); W = TS[0]
for m in MS[:12]:
    trials += 1
    if WI.eval_diagram(W, m, K, P) % P == eval_wrong([W]*K, m, P): ok_same += 1
    lhs = eval_wrong([(W+V) % P] + [W]*(K-1), m, P)
    rhs = (eval_wrong([W]*K, m, P) + eval_wrong([V] + [W]*(K-1), m, P)) % P
    if lhs == rhs: ok_lin += 1
print(f"   check (a) J(W,...,W) = unpolarised:  {ok_same}/{trials}")
print(f"   check (b) multilinear in slot 0:     {ok_lin}/{trials}")
nd = sum(1 for m in MS[:12] if eval_wrong(TS, m, P) != ep(TS, m, P))
print(f"   yet it differs from the shipped map on distinct tensors: {nd}/12 matchings")

print("\nC. how far the six values move under permuting the tensors")
for m in MS[:4]:
    vals = {}
    for perm in itertools.islice(itertools.permutations(range(K)), 0, 720, 7):
        v = ep([TS[i] for i in perm], m, P)
        vals.setdefault(v, 0); vals[v] += 1
    print(f"   matching {m[:3]}...: {len(vals)} distinct values over 103 permutations")

print("\nD. what the two checks DO pin: multilinearity in EVERY slot + the diagonal")
# (i) the shipped check tests slot 0 only.  Test all six.
U = WI.random_weyl(N, P, rng)
per_slot = []
for s in range(K):
    ok = 0
    for m in MS[:6]:
        base = [TS[0]]*K
        lhsL = base[:s] + [(TS[0]+U) % P] + base[s+1:]
        aL = base[:s] + [TS[0]] + base[s+1:]
        bL = base[:s] + [U] + base[s+1:]
        if ep(lhsL, m, P) == (ep(aL, m, P) + ep(bL, m, P)) % P: ok += 1
    per_slot.append(ok)
print(f"   multilinear in slots 0..5: {per_slot} of 6 matchings each")

# (ii) polarisation identity: (1/6!) sum_pi ep(T_pi) == (1/6!) sum_S (-1)^(6-|S|) J(sum_S T)
inv720 = pow(720, P-2, P)
for m in MS[:2]:
    sym = 0
    for perm in itertools.permutations(range(K)):
        sym = (sym + ep([TS[i] for i in perm], m, P)) % P
    sym = sym * inv720 % P
    pol_fd = 0
    for r in range(1, K+1):
        for S in itertools.combinations(range(K), r):
            T = np.zeros((N,)*4, dtype=np.int64)
            for i in S: T = (T + TS[i]) % P
            pol_fd = (pol_fd + (-1)**(K-r) * WI.eval_diagram(T, m, K, P)) % P
    pol_fd = pol_fd * inv720 % P
    print(f"   matching {m[:2]}...: symmetrised ep = {sym}, finite-difference "
          f"polarisation = {pol_fd}, equal: {sym == pol_fd}")

print("\nE. the docstring's recipe -- a single assignment is NOT a coefficient")
# J(x*T0 + y*T1): the coefficient of x^3 y^3, three ways.
m = MS[0]
def Jxy(x, y):
    return WI.eval_diagram((x*TS[0] + y*TS[1]) % P, m, K, P) % P
# exact extraction by 7 evaluations in x with y = 1 (Vandermonde over F_p)
import fractions
pts = list(range(1, 8))
V = [[pow(x, d, P) for d in range(7)] for x in pts]
b = [Jxy(x, 1) for x in pts]
# solve V c = b over F_p
Mx = [row[:] + [b[i]] for i, row in enumerate(V)]
n = 7
for c in range(n):
    piv = next(k for k in range(c, n) if Mx[k][c] % P)
    Mx[c], Mx[piv] = Mx[piv], Mx[c]
    inv = pow(Mx[c][c] % P, P-2, P)
    Mx[c] = [v*inv % P for v in Mx[c]]
    for k in range(n):
        if k != c and Mx[k][c] % P:
            f = Mx[k][c]; Mx[k] = [(u - f*v) % P for u, v in zip(Mx[k], Mx[c])]
coef33 = Mx[3][n] % P
single = ep([TS[0]]*3 + [TS[1]]*3, m, P)
summed = 0
for S in itertools.combinations(range(K), 3):
    asg = [TS[1]]*K
    for i in S: asg[i] = TS[0]
    summed = (summed + ep(asg, m, P)) % P
print(f"   true coefficient of x^3 y^3 : {coef33}")
print(f"   one assignment (docstring)  : {single}   equal: {single == coef33}")
print(f"   sum over the 20 assignments : {summed}   equal: {summed == coef33}")
