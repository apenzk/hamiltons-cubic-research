"""r215 claim 2 follow-up: does run_n12_sym3.py's irr_char inherit the defective
root-order test, and what does it do when it fires?

run_n12_weights.py asserts the Freudenthal denominator is positive.  irr_char
DROPPED that assertion and wrote `int(2*num/den) if den else 0`, so a weight that
is not really below lam would be processed with den <= 0 in silence.
"""
import os, sys, pickle, importlib.util
from itertools import product
from fractions import Fraction as F

SC = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"
sp = importlib.util.spec_from_file_location("w12", os.path.join(SC, "authorrun", "run_n12_weights.py"))
w12 = importlib.util.module_from_spec(sp)
_o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(w12); sys.stdout = _o
RANK, POS, RHO = w12.RANK, w12.POS, w12.RHO
def ip(u, v): return sum(F(x)*F(y) for x, y in zip(u, v))
def cas(mu): return ip(mu, [x + 2*y for x, y in zip(mu, RHO)])

def file_dom(lam):
    """the test run_n12_sym3.py's irr_char actually uses"""
    out = []
    rng = range(-max(max(lam), 1), max(max(lam), 1)+1)
    for mu in product(rng, repeat=RANK):
        if any(mu[k] < mu[k+1] for k in range(RANK-2)): continue
        if mu[RANK-2] < abs(mu[RANK-1]): continue
        dd = [lam[k]-mu[k] for k in range(RANK)]
        if sum(dd) % 2: continue
        if any(sum(dd[:k+1]) < 0 for k in range(RANK)): continue
        out.append(mu)
    return out

def truly_below(lam, mu):
    """lam - mu is a non-negative integer combination of the simple roots of D_6:
       alpha_i = e_i - e_{i+1} (i<6), alpha_6 = e_5 + e_6.  Solving,
       c_k = S_k for k <= 4, c_6 = S_6/2, c_5 = S_5 - S_6/2, with S the partial sums."""
    d = [lam[k]-mu[k] for k in range(RANK)]
    S = [sum(d[:k+1]) for k in range(RANK)]
    if S[5] % 2: return False
    c6 = F(S[5], 2); c5 = S[4] - c6
    cs = [S[0], S[1], S[2], S[3], c5, c6]
    return all(x >= 0 and F(x).denominator == 1 for x in cs)

BL = pickle.load(open(os.path.join(SC, "r215_blocks.pkl"), "rb"))
print(f"auditing irr_char's dominant-weight set on all {len(BL)} constituents")
tot_sp = 0; worst = []
for lam in sorted(BL):
    fs = file_dom(lam)
    sp_ = [mu for mu in fs if not truly_below(lam, mu)]
    miss = 0
    if sp_:
        tot_sp += len(sp_)
        dens = [cas(lam) - cas(mu) for mu in sp_]
        worst.append((lam, len(sp_), min(dens), sum(1 for x in dens if x <= 0)))
print(f"  constituents whose dominant set contains weights NOT below lambda: {len(worst)}")
print(f"  spurious weights in total: {tot_sp}")
for lam, n, mind, nonpos in worst[:20]:
    print(f"    {lam}: {n} spurious, min denominator {mind}, non-positive denominators {nonpos}")
