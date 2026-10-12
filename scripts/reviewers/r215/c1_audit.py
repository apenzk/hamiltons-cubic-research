"""r215 claim 1: audit of run_n12_weights.py against Sage, and of its two
questioned pieces -- dom_rep and the descending-Casimir processing order."""
import json, os, sys, importlib.util
from itertools import permutations, product
from fractions import Fraction as F

SC = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"
sp = importlib.util.spec_from_file_location("w12", os.path.join(SC, "authorrun", "run_n12_weights.py"))
w12 = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(w12); sys.stdout = _o
RANK, POS, RHO, MULT, orbit, dom_rep = w12.RANK, w12.POS, w12.RHO, w12.MULT, w12.orbit, w12.dom_rep

# ---- A. full weight-by-weight comparison with Sage
CHI = {}
for mu, m in MULT.items():
    for nu in orbit(mu): CHI[nu] = CHI.get(nu, 0) + m
sage = {tuple(int(x) for x in k.split(",")): v for k, v in json.load(open(SC + "/sage_chi.json")).items()}
print("A. author weights", len(CHI), "sage weights", len(sage))
print("   identical as dictionaries:", CHI == sage)
print("   dimension", sum(CHI.values()), sum(sage.values()))

# ---- B. dom_rep is the W(D_6) dominant representative, brute force
# for every weight nu of the module, dom_rep(nu) must (i) be dominant,
# (ii) lie in the W(D_6) orbit of nu, (iii) be the unique such dominant weight.
def is_dom(v):
    return all(v[i] >= v[i+1] for i in range(RANK-2)) and v[RANK-2] >= abs(v[RANK-1])
bad = 0
for nu in CHI:
    r = dom_rep(nu)
    o = orbit(nu)
    doms = [x for x in o if is_dom(x)]
    if not (is_dom(r) and r in o and doms == [r]):
        bad += 1
        if bad < 5: print("   FAIL", nu, r, doms)
print("B. dom_rep checked on all", len(CHI), "weights of the module; failures:", bad)
# and on a wider net: every integer vector with entries in -3..3 (odd sign-change traps)
bad2 = 0; n2 = 0
import itertools
for nu in itertools.product(range(-2, 3), repeat=RANK):
    n2 += 1
    r = dom_rep(nu); o = orbit(nu); doms = [x for x in o if is_dom(x)]
    ok = is_dom(r) and r in o and len(doms) == 1 and doms[0] == r
    if not ok:
        bad2 += 1
        if bad2 < 5: print("   FAIL", nu, "->", r, "dominant in orbit:", doms)
print("   wider net over", n2, "integer vectors in [-2,2]^6; failures:", bad2)

# ---- C. the descending-Casimir order.  Two things must hold:
#   (i) every dominant weight strictly below lam has strictly smaller Casimir
#       (so the order is a valid topological order and the denominator is > 0);
#   (ii) at the moment mu is processed, every nu = mu + k*alpha carrying nonzero
#       multiplicity already sits in MULT.
def ip(u, v): return sum(F(x)*F(y) for x, y in zip(u, v))
def cas(mu): return ip(mu, [x + 2*y for x, y in zip(mu, RHO)])
DOM = sorted(MULT, key=lambda m: -cas(m))
print("C. Casimir values in processing order:", [(m, str(cas(m))) for m in DOM])
print("   strictly decreasing:", all(cas(DOM[i]) > cas(DOM[i+1]) for i in range(len(DOM)-1)))
# (ii) replay the recursion and check the break never truncates a live string
viol = 0
seen = set()
for mu in DOM:
    if mu != w12.LAM:
        for a in POS:
            k = 1; broke = False
            while True:
                nu = tuple(mu[t] + k*a[t] for t in range(RANK))
                key = dom_rep(nu)
                inmult = key in seen
                live = key in MULT and MULT[key] > 0
                if not inmult and live:
                    viol += 1
                    if viol < 5: print("   TRUNCATION", mu, a, k, key)
                if not inmult: break
                k += 1
    seen.add(mu)
print("   strings truncated early:", viol)

# ---- D. dominant_below: the root-order test the file uses is
#   partial sums >= 0 and sum even.  The exact D_r condition also needs
#   c_{r-1} = S_{r-1} - S_r/2 >= 0.  Is the omission harmless here?
def exact_below(lam, mu):
    d = [lam[k]-mu[k] for k in range(RANK)]
    S = [sum(d[:k+1]) for k in range(RANK)]
    if S[RANK-1] % 2: return False
    c = list(S[:RANK-2]) + [S[RANK-2+0]]  # placeholder
    c = [S[k] for k in range(RANK-2)] + [S[RANK-2] - 0]
    cr = F(S[RANK-1], 2)
    crm1 = S[RANK-2] - cr
    cs = [S[k] for k in range(RANK-2)] + [crm1, cr]
    return all(x >= 0 and F(x).denominator == 1 for x in cs)
lam = w12.LAM
file_set = set(w12.dominant_below(lam))
true_set = set(mu for mu in file_set if exact_below(lam, mu))
# and also sweep every dominant mu in the box to be sure nothing is MISSED
box = [mu for mu in itertools.product(range(-2, 3), repeat=RANK) if is_dom(mu)]
true_all = set(mu for mu in box if exact_below(lam, mu))
print("D. dominant_below returned", len(file_set), "; exact D_6 root-order test keeps", len(true_set))
print("   spurious (in file, not truly <= lam):", sorted(file_set - true_set))
print("   missed  (truly <= lam, not in file):", sorted(true_all - file_set))
