"""r215: replay Freudenthal for all 77 constituents with the two guards the
file's irr_char dropped -- denominator strictly positive on weights genuinely
below lambda, and 2*num/den exactly an integer (the file writes int(), which
TRUNCATES a non-integer instead of failing)."""
import os, sys, pickle, importlib.util
from itertools import product
from fractions import Fraction as F

SC = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"
sp = importlib.util.spec_from_file_location("w12", os.path.join(SC, "authorrun", "run_n12_weights.py"))
w12 = importlib.util.module_from_spec(sp); _o = sys.stdout
sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(w12); sys.stdout = _o
RANK, POS, RHO, orbit = w12.RANK, w12.POS, w12.RHO, w12.orbit
def ip(u, v): return sum(F(x)*F(y) for x, y in zip(u, v))
def cas(mu): return ip(mu, [x + 2*y for x, y in zip(mu, RHO)])
def dom_rep(mu):
    v = sorted((abs(x) for x in mu), reverse=True)
    if sum(1 for x in mu if x < 0) % 2: v[-1] = -v[-1]
    return tuple(v)
def truly_below(lam, mu):
    d = [lam[k]-mu[k] for k in range(RANK)]
    S = [sum(d[:k+1]) for k in range(RANK)]
    if S[5] % 2: return False
    c6 = F(S[5], 2); c5 = S[4] - c6
    return all(x >= 0 and F(x).denominator == 1 for x in [S[0],S[1],S[2],S[3],c5,c6])
def wdim(lam):
    n = d = F(1)
    for a in POS:
        n *= ip([x+y for x, y in zip(lam, RHO)], a); d *= ip(RHO, a)
    return n/d

def freudenthal(lam):
    dom = []
    b = max(max(lam), 1)
    for mu in product(range(-b, b+1), repeat=RANK):
        if any(mu[k] < mu[k+1] for k in range(RANK-2)): continue
        if mu[RANK-2] < abs(mu[RANK-1]): continue
        if truly_below(lam, mu): dom.append(mu)
    M = {}
    for mu in sorted(dom, key=lambda m: -cas(m)):
        if mu == lam: M[mu] = 1; continue
        num = F(0)
        for a in POS:
            k = 1
            while True:
                nu = tuple(mu[t] + k*a[t] for t in range(RANK))
                key = dom_rep(nu)
                if key not in M: break
                num += M[key]*ip(nu, a); k += 1
        den = cas(lam) - cas(mu)
        assert den > 0, f"denominator {den} at {mu} below {lam}"
        val = 2*num/den
        assert val.denominator == 1, f"non-integer multiplicity {val} at {mu} below {lam}"
        assert val >= 0
        M[mu] = int(val)
    return M

BL = pickle.load(open(os.path.join(SC, "r215_blocks.pkl"), "rb"))
S3 = pickle.load(open(os.path.join(SC, "authorrun", "n12_sym3_char.pkl"), "rb"))
tot = 0; recon = {}
for lam, m in sorted(BL.items()):
    M = freudenthal(lam)
    d = sum(mm*len(orbit(mu)) for mu, mm in M.items())
    assert d == wdim(lam), f"{lam}: weight system {d} vs Weyl formula {wdim(lam)}"
    tot += m*d
    for mu, mm in M.items():
        for nu in orbit(mu): recon[nu] = recon.get(nu, 0) + m*mm
print("all 77 Freudenthal runs pass: denominators > 0, multiplicities exact integers,")
print("and each weight system sums to the Weyl dimension formula.")
print(f"sum m*dim = {tot:,}")
print("reassembled character equals the Sym^3 character:", recon == S3)
