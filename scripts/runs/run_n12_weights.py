"""The weight system of Weyl_12, by Freudenthal.  Step 1 of the n>=12 build.

WHY NOT THE n=5 ROUTE.  run_n5_weyl_module.py builds the module by nullspace over
Q inside Sym^2(Lambda^2), then carries the so(5) action as 10 dense 35x35
matrices.  At n=12 that is Sym^2(Lambda^2) of dimension 2211 and 66 generators of
size 1638x1638 -- 177 million entries before any arithmetic.  The prototype's
stage 2, the adapted basis, is worse still: Sym^3(Weyl_12) has dimension
C(1640,3) = 733,813,080 against 7770.

So the module is handled by its WEIGHT SYSTEM rather than by matrices.  That is
enough for what comes next, because a highest-weight vector of weight mu lives in
the mu weight space of Sym^3, and those spaces are small even when Sym^3 is not.

Weyl_n is the O(n) representation with Young diagram [2,2], which for
so(12) = D_6 is the irreducible with highest weight (2,2,0,0,0,0).  Freudenthal's
recursion gives its weight multiplicities; the dimension they sum to must be
    dim Weyl_12 = 12*13*14*9/12 = 1638,
which is the check this file exists to pass.
"""
from itertools import permutations, product
from fractions import Fraction as F

N = 12
RANK = N // 2                      # D_6
LAM = (2, 2, 0, 0, 0, 0)
DIM_WEYL = N*(N+1)*(N+2)*(N-3)//12
print(f"so({N}) = D_{RANK}, highest weight {LAM}, target dimension {DIM_WEYL}")

# D_r roots: e_i +- e_j for i < j.  Positive: e_i - e_j and e_i + e_j, i < j.
POS = []
for i in range(RANK):
    for j in range(i+1, RANK):
        a = [0]*RANK; a[i] = 1; a[j] = -1; POS.append(tuple(a))
        b = [0]*RANK; b[i] = 1; b[j] = 1;  POS.append(tuple(b))
assert len(POS) == RANK*(RANK-1)
RHO = tuple(F(sum(a[k] for a in POS), 2) for k in range(RANK))
print(f"  {len(POS)} positive roots, rho = {tuple(str(x) for x in RHO)}")
assert RHO == tuple(F(RANK-1-k) for k in range(RANK)), "rho is wrong for D_r"

def ip(u, v): return sum(F(x)*F(y) for x, y in zip(u, v))

def dominant_below(lam):
    """every dominant weight mu <= lam in the root order, for D_r.

    lam - mu must be a nonnegative integer combination of simple roots; for D_r
    that is equivalent to the partial sums condition plus a parity condition on
    the total, which is cheapest to impose by generating candidates and testing
    membership in the root lattice.
    """
    tot = sum(lam)
    out = []
    # D_r dominant integral: mu_1 >= ... >= mu_{r-1} >= |mu_r|
    rng = range(-max(lam), max(lam)+1)
    for mu in product(rng, repeat=RANK):
        if any(mu[k] < mu[k+1] for k in range(RANK-2)): continue
        if mu[RANK-2] < abs(mu[RANK-1]): continue
        d = [lam[k] - mu[k] for k in range(RANK)]
        if sum(d) % 2: continue                     # root lattice of D_r
        if any(sum(d[:k+1]) < 0 for k in range(RANK)): continue
        out.append(mu)
    return out

DOM = dominant_below(LAM)
print(f"  {len(DOM)} dominant weights below {LAM}")

# AN INDEPENDENT DIMENSION, before any Freudenthal.  The Weyl dimension formula
# needs only the root system, so if it disagrees with n(n+1)(n+2)(n-3)/12 then
# (2,2,0,0,0,0) is the wrong highest weight and nothing else matters.
_num = _den = F(1)
for a in POS:
    _num *= ip([x + y for x, y in zip(LAM, RHO)], a)
    _den *= ip(RHO, a)
_wdim = _num / _den
print(f"  Weyl dimension formula for {LAM}: {_wdim}")
assert _wdim == DIM_WEYL, (
    f"the Weyl dimension formula gives {_wdim}, not {DIM_WEYL}, so {LAM} is not "
    "the highest weight of Weyl_12")

def orbit(mu):
    """the Weyl orbit of mu under W(D_r): permutations and EVEN sign changes."""
    seen = set()
    for pm in permutations(mu):
        for signs in product((1, -1), repeat=RANK):
            if signs.count(-1) % 2: continue
            seen.add(tuple(s0*x for s0, x in zip(signs, pm)))
    return seen

def dom_rep(mu):
    """the dominant representative of mu under W(D_r): sort |mu| descending, and
    make the number of negative entries even by flipping the smallest."""
    v = sorted((abs(x) for x in mu), reverse=True)
    if sum(1 for x in mu if x < 0) % 2:
        v[-1] = -v[-1]
    return tuple(v)

def casimir(mu):
    return ip(mu, [x + 2*y for x, y in zip(mu, RHO)])

# PROCESS IN CASIMIR ORDER, NOT BY COORDINATE SUM.  A first version sorted by
# sum(mu), and (1,1,1,1,0,0) ties with (2,2,0,0,0,0) at 4 -- so Freudenthal ran
# on a weight before the highest weight had been set, and the system summed to 65
# against 1638.  mu < lambda in the dominant order implies casimir(mu) <
# casimir(lambda), which is exactly the positivity of Freudenthal's denominator,
# so descending Casimir is a valid topological order and the denominator cannot
# vanish.
MULT = {}
for mu in sorted(DOM, key=lambda m: -casimir(m)):
    if mu == LAM: MULT[mu] = 1; continue
    num = F(0)
    for a in POS:
        k = 1
        while True:
            nu = tuple(mu[t] + k*a[t] for t in range(RANK))
            key = dom_rep(nu)
            if key not in MULT: break
            num += MULT[key] * ip(nu, a)
            k += 1
    den = casimir(LAM) - casimir(mu)
    assert den > 0, f"Freudenthal denominator {den} at {mu} is not positive"
    MULT[mu] = int(2*num/den)

def orbit_size(mu):
    return len(orbit(mu))

total = sum(MULT[mu]*orbit_size(mu) for mu in MULT)
print(f"\n  dominant weight multiplicities:")
for mu in sorted(MULT, key=lambda m: (-sum(m), m)):
    print(f"    {mu}  multiplicity {MULT[mu]:2d}  orbit {orbit_size(mu):4d}")
print(f"\n  dimension from the weight system: {total}")
print(f"  dim Weyl_12 = n(n+1)(n+2)(n-3)/12 = {DIM_WEYL}")
assert total == DIM_WEYL, (
    f"the weight system sums to {total}, not {DIM_WEYL}.  Freudenthal, the root "
    "system or the dominance test is wrong, and everything downstream would "
    "inherit it.")
print("\n  MATCHES.  The weight system of Weyl_12 is correct.")
