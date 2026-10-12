"""Claim 1 -- a test that DISCRIMINATES the Sym^3 conventions.

Reviewers 189/190 tried weights.  A weight check cannot separate the candidates
because every candidate is the same matrix up to a diagonal rescaling
d_t > 0 depending only on the repetition pattern of t, and such a rescaling is
block-diagonal inside each weight space: it commutes with the Cartan.

What does NOT commute with a pattern-dependent rescaling is a ROOT vector.  The
induced metric is the unique (up to one global scalar) form on Sym^3 V for which
the compact real form acts by anti-Hermitian operators, i.e.

        <E u, v>_M  =  <u, F v>_M     with  F = E^dagger on V.

E and F move between weight spaces, so this identity ties the normalisation of
one weight space to the next -- exactly the coupling a diagonal rescaling
breaks.  It is scale-blind (both sides carry the same global factor), so it
tests the SHAPE of sym3_ip; the scale is pinned separately in claim3.

Candidates tested (all Hermitian, all weight-diagonal, all agreeing with
sym3_ip up to a pattern-diagonal rescaling):
  FISCHER   sym3_ip itself                       <x^a,x^a>_{H=I} = a!
  BOMBIERI  sym3_ip / 3!                         <x^a,x^a>_{H=I} = a!/3!
  IDBIJ     product over the identity bijection only (no permutation sum)
  MULT_UP   multinom(t) multinom(s) sym3_ip
  MULT_DN   sym3_ip / (multinom(t) multinom(s))
"""
import sys, os, random, itertools
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import *
from lowering import H, FS

Hm = Hfull(H)

def sym3_ip(t, s):
    tot = Z
    for perm in itertools.permutations(range(3)):
        term = ONE; ok = True
        for i in range(3):
            e = H.get((t[i], s[perm[i]]))
            if e is None: ok = False; break
            term = cmul(term, e)
        if ok: tot = cadd(tot, term)
    return tot

def idbij(t, s):
    term = ONE
    for i in range(3):
        e = H.get((t[i], s[i]))
        if e is None: return Z
        term = cmul(term, e)
    return term

SIX = (F(6), F(0))
CAND = {
    "FISCHER  (the code)": lambda t, s: sym3_ip(t, s),
    "BOMBIERI (/3!)":      lambda t, s: cdiv(sym3_ip(t, s), SIX),
    "IDBIJ    (no sum)":   idbij,
    "MULT_UP":             lambda t, s: cmul(sym3_ip(t, s),
                                             (F(multinom(t)*multinom(s)), F(0))),
    "MULT_DN":             lambda t, s: cdiv(sym3_ip(t, s),
                                             (F(multinom(t)*multinom(s)), F(0))),
}

BYMW = {}
for i, w in enumerate(MW): BYMW.setdefault(w, []).append(i)

def test(M, k, pairs):
    """returns (n_tested, first failing (t_idx, s_idx, lhs, rhs))"""
    E, Fo = EC[k], FS[k]
    n = 0; bad = None
    for (ti, si) in pairs:
        R  = raise_mono(ti, E)
        Rf = raise_mono(si, Fo)
        t, s = MONO[ti], MONO[si]
        lhs = Z
        for kk, v in R.items(): lhs = cadd(lhs, cmul(v, M(MONO[kk], s)))
        rhs = Z
        for jj, v in Rf.items(): rhs = cadd(rhs, cmul(cconj(v), M(t, MONO[jj])))
        n += 1
        if lhs != rhs and bad is None: bad = (ti, si, lhs, rhs)
    return n, bad

random.seed(191)
# sample (t,s) pairs with wt(s) = wt(t) + alpha, biased to MIXED repetition
# patterns inside one weight space, which is where a pattern rescaling bites.
def sample(k, npairs):
    a = ALPHA[k]; out = []
    keys = [w for w in BYMW if (w[0]+a[0], w[1]+a[1]) in BYMW]
    while len(out) < npairs:
        w = random.choice(keys)
        ti = random.choice(BYMW[w])
        si = random.choice(BYMW[(w[0]+a[0], w[1]+a[1])])
        out.append((ti, si))
    return out

print("=== adjointness <E u, v> = <u, F v> on Sym^3, per candidate metric ===")
pairs = {k: sample(k, 60) for k in (1, 2)}
for name, M in CAND.items():
    verdicts = []
    for k in (1, 2):
        n, bad = test(M, k, pairs[k])
        verdicts.append((k, n, bad))
    allok = all(b is None for _, _, b in verdicts)
    print(f"\n{name:22s} : {'PASS' if allok else 'FAIL'}")
    for k, n, bad in verdicts:
        if bad is None:
            print(f"   alpha_{k}: {n}/{n} pairs satisfy the identity")
        else:
            ti, si, lhs, rhs = bad
            print(f"   alpha_{k}: FAILS.  witness t={MONO[ti]} (wt {MW[ti]}), "
                  f"s={MONO[si]} (wt {MW[si]})")
            print(f"            <E x_t, x_s> = ({lhs[0]}) + ({lhs[1]})i   "
                  f"<x_t, F x_s> = ({rhs[0]}) + ({rhs[1]})i")

# --- the same witness, restricted so the discrimination is visible by hand ---
print("\n=== why a weight check cannot see this ===")
print("every candidate is  M'(t,s) = d_t d_s M(t,s)  with d depending only on the")
print("repetition pattern, hence block-diagonal in each weight space:")
for w, idxs in sorted(BYMW.items(), key=lambda kv: -len(kv[1]))[:1]:
    pats = {}
    for i in idxs:
        m = sorted((MONO[i].count(x) for x in set(MONO[i])), reverse=True)
        pats[tuple(m)] = pats.get(tuple(m), 0) + 1
    print(f"  weight {w}: {len(idxs)} monomials, repetition patterns {pats}")
    print("  -> a weight-space check compares only monomials of the SAME weight,")
    print("     and the rescaling is diagonal there; a root vector crosses weights.")
