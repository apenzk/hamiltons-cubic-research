"""Claim 2, refuted: kappa = 3! is a formal identity in (H, w), not a check.

THEOREM.  Let H be ANY Hermitian form on C^N (no positivity, no invariance, no
relation to a Weyl basis).  Let w in C^N be ANY vector.  Let

    c_t = multinom(t) * prod_{a in t} w_a          (t a multiset of size 3)
    K(t,s) = sum_{sigma in S_3} prod_i H(t_i, s_{sigma(i)})     (FISCHER)
    tot    = sum_{t,s} c_t conj(c_s) K(t,s),      n2 = w^dagger H w.

Then tot = 3! * n2^3, identically.

PROOF.  Writing sum_t multinom(t) w^t f(t) = sum over ORDERED triples a of
w^a f(t(a)), and noting K(t(a),t(b)) = perm[H(a_i,b_j)],

    tot = sum_{a,b ordered} w^a conj(w^b) sum_sigma prod_i H(a_i, b_sigma(i))
        = sum_sigma prod_{i=1}^{3} ( sum_{p,q} w_p conj(w_q) H(p,q) )
        = 3! (w^dagger H w)^3.                                        QED

Three corollaries, each a hole in "breaking any ONE of the three destroys its
constancy":
  (i)   w is arbitrary -> the COORDINATE SOLVE is not tested at all;
  (ii)  H is arbitrary -> the METRIC's correctness is not tested at all;
  (iii) only the multinom/permanent pairing is tested, and only up to a
        compensating rescale -- exhibited below.
"""
import itertools, random, sys
from fractions import Fraction as F

N = 7
random.seed(194)

def cmul(x, y): return (x[0]*y[0] - x[1]*y[1], x[0]*y[1] + x[1]*y[0])
def cadd(x, y): return (x[0] + y[0], x[1] + y[1])
def cconj(x):   return (x[0], -x[1])
def rnd(): return (F(random.randint(-5, 5)), F(random.randint(-5, 5)))

from math import factorial
def multinom(t):
    m = {}
    for x in t: m[x] = m.get(x, 0) + 1
    r = 6
    for v in m.values(): r //= factorial(v)
    return r
def aut(t):
    m = {}
    for x in t: m[x] = m.get(x, 0) + 1
    r = 1
    for v in m.values(): r *= factorial(v)
    return r

MONO = list(itertools.combinations_with_replacement(range(N), 3))

def rand_herm(diagonal_only=False, weights=None):
    """A Hermitian H. Optionally kill the off-diagonal / cross-weight entries."""
    H = {}
    for a in range(N):
        for b in range(a, N):
            if diagonal_only and a != b: continue
            if weights is not None and weights[a] != weights[b]: continue
            z = rnd() if a != b else (F(random.randint(1, 9)), F(0))
            H[(a, b)] = z
            if a != b: H[(b, a)] = cconj(z)
    return H

def ip(H, t, s, rule):
    tot = (F(0), F(0))
    for perm in itertools.permutations(range(3)):
        term = (F(1), F(0)); ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    if rule == "FISCHER":  return tot
    if rule == "BOMBIERI": return (tot[0]/6, tot[1]/6)
    if rule == "MULT_UP":
        f = F(1, aut(t)*aut(s)); return (tot[0]*f, tot[1]*f)
    if rule == "MULT_UP_x36":
        f = F(36, aut(t)*aut(s)); return (tot[0]*f, tot[1]*f)
    raise ValueError(rule)

def cube(w, use_multinom=True, scale=F(1)):
    out = {}
    for t in MONO:
        z = (F(multinom(t)) * scale if use_multinom else F(1) * scale, F(0))
        for a in t: z = cmul(z, w[a])
        if z != (F(0), F(0)): out[t] = z
    return out

def kappa(H, w, use_multinom=True, rule="FISCHER", scale=F(1)):
    c3 = cube(w, use_multinom, scale)
    tot = (F(0), F(0))
    for t, ct in c3.items():
        for s, cs in c3.items():
            e = ip(H, t, s, rule)
            if e != (F(0), F(0)): tot = cadd(tot, cmul(cmul(ct, cconj(cs)), e))
    n2 = (F(0), F(0))
    for a in range(N):
        for b in range(N):
            if (a, b) in H: n2 = cadd(n2, cmul(cmul(w[a], cconj(w[b])), H[(a, b)]))
    assert n2[1] == 0, "n2 must be real"
    if n2[0] == 0: return None, tot[1], n2[0]
    return tot[0] / n2[0]**3, tot[1], n2[0]

print("=" * 74)
print("(A) kappa = 6 for a RANDOM Hermitian H and a RANDOM w -- both arbitrary")
print("=" * 74)
for trial in range(6):
    H = rand_herm()
    w = [rnd() for _ in range(N)]
    k, im, n2 = kappa(H, w)
    print(f"  trial {trial}: |W|^2_H = {str(n2):>8}  (indefinite H, so may be <0)"
          f"   kappa = {k}   Im = {im}")

print()
print("=" * 74)
print("(B) the three pipeline ingredients, corrupted ONE AT A TIME")
print("=" * 74)
H = rand_herm(); w = [rnd() for _ in range(N)]
print(f"  baseline                                   kappa = {kappa(H, w)[0]}")
Hd = dict(H)
for a in range(N):
    for b in range(N):
        if a != b: Hd.pop((a, b), None)
print(f"  METRIC corrupted (all off-diagonals of H")
print(f"    deleted -- exactly the 'nothing else in")
print(f"    the pipeline looks' entries)            kappa = {kappa(Hd, w)[0]}")
w2 = [rnd() for _ in range(N)]
print(f"  COORDINATE SOLVE corrupted (w replaced by")
print(f"    an unrelated random vector)             kappa = {kappa(H, w2)[0]}")
print(f"  CUBE MAP corrupted (multinomial dropped)  kappa = {kappa(H, w, use_multinom=False)[0]}"
      f"   <- the only one that moves")

print()
print("=" * 74)
print("(C) a COMPENSATING PAIR: two errors, each individually fatal,")
print("    whose product restores kappa = 6 EXACTLY")
print("=" * 74)
print("    error 1: cube() drops the multinomial       (191: 'gives 4 values')")
print("    error 2: sym3_ip uses 36 * MULT_UP          (191: MULT_UP FAILS adjointness)")
print("    identity: multinom(t) = 6/aut(t), so")
print("      c_t c_s K       = (36/(aut t)(aut s)) w^t w^s K")
print("      w^t w^s (36 K/(aut t)(aut s))  -- the same number, term by term.")
for trial in range(4):
    H = rand_herm(); w = [rnd() for _ in range(N)]
    kg = kappa(H, w)[0]
    kb = kappa(H, w, use_multinom=False, rule="MULT_UP_x36")[0]
    print(f"  trial {trial}:  correct kappa = {kg}   compensated-pair kappa = {kb}"
          f"   equal: {kg == kb}")

print()
print("=" * 74)
print("(D) the one-parameter scalar family kappa cannot see")
print("=" * 74)
print("    scale cube() by lambda and the metric rule by 1/lambda^2.")
H = rand_herm(); w = [rnd() for _ in range(N)]
while kappa(H, w)[0] is None: H = rand_herm(); w = [rnd() for _ in range(N)]
for lam in (F(1), F(3), F(1, 5), F(-2)):
    c3s = kappa(H, w, scale=lam)[0]
    print(f"  cube scaled by {str(lam):>6}: kappa = {str(c3s):>12}"
          f"   = 6 * lambda^2 = {6*lam*lam}   -> divide the ip rule by"
          f" {lam*lam} and kappa returns to 6")

print()
print("=" * 74)
print("(E) BOMBIERI is caught, but only because 6 is remembered as the target")
print("=" * 74)
H = rand_herm(); w = [rnd() for _ in range(N)]
while kappa(H, w)[0] is None: H = rand_herm(); w = [rnd() for _ in range(N)]
for rule in ("FISCHER", "BOMBIERI", "MULT_UP"):
    k = kappa(H, w, rule=rule)[0]
    print(f"  rule {rule:<9} kappa = {k}"
          f"   {'CONSTANT across w? see below' if rule != 'MULT_UP' else ''}")
print("    FISCHER and BOMBIERI are both CONSTANT in (H, w) -- 6 and 1.  The")
print("    script's printed test is `len(set(kappas)) == 1`, i.e. CONSTANCY,")
print("    which BOMBIERI passes.  Only the remembered value 6 separates them,")
print("    and that value is never asserted in code.")
ks = set()
for _ in range(5):
    Hx = rand_herm(); wx = [rnd() for _ in range(N)]
    while kappa(Hx, wx)[0] is None: Hx = rand_herm(); wx = [rnd() for _ in range(N)]
    ks.add(kappa(Hx, wx, rule="BOMBIERI")[0])
print(f"    BOMBIERI over 5 random (H, w): {ks}   constant: {len(ks) == 1}")
