"""Claim 6: build W_5 from the DEFINITION (no highest weight assumed), peel
Sym^3, and compare with the record's 24-block table.  Then show what the
committed script would have printed had the module been the other 35-dim
B_2 irrep, (2,1) = omega_1 + 2 omega_2."""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *

W = weyl_elements(2, 'B'); rh = rho(2, 'B')

def peel(ch):
    cands = sorted({dominant_B(w) for w in ch}, key=lambda x: (-sum(x), x))
    out = {}
    for lam in cands:
        tot = 0
        for perm, signs, det in W:
            key = tuple(a+b-c for a, b, c in zip(lam, rh, act(rh, perm, signs)))
            if all(float(x).is_integer() for x in key):
                v = ch.get(tuple(int(x) for x in key))
                if v:
                    tot += det*v
        if tot:
            out[lam] = tot
    return out

def table(ch, name):
    h3 = divide(add(add(mul(mul(ch, ch), ch), mul(ch, adams(ch, 2)), 3), adams(ch, 3), 2), 6)
    b = peel(h3)
    dd = {l: dim_from_mult(freudenthal(l, 2, 'B'), 2, 'B') for l in b}
    print('%s : dim %d, Sym^3 dim %d' % (name, dim(ch), dim(h3)))
    print('   blocks %d  mult %d  unknowns %d  sum m*d %d'
          % (len(b), sum(b.values()), sum(m*(m+1)//2 for m in b.values()),
             sum(b[l]*dd[l] for l in b)))
    c2 = lambda l: l[0]*(l[0]+3)+l[1]*(l[1]+1)
    print('   c2 distinct %d of %d' % (len({c2(l) for l in b}), len(b)))
    print('   ', sorted(((l, b[l], dd[l]) for l in b)))
    return b

# W_5 straight from Sym^2(Lambda^2) - Lambda^4 - Sym^2(R^5)
chW = char_weyl(2, True)
print('highest weight of the module built from the definition:',
      max(chW, key=lambda w: (w[0]+w[1], w[0])))
b1 = table(chW, 'W_5 from the definition')
print()
# the decoy: the other 35-dimensional B_2 irrep
m21 = freudenthal((2, 1), 2, 'B')
ch21 = full_character(m21, 2, 'B')
b2 = table(ch21, 'V_(2,1) = omega_1 + 2 omega_2, also dim 35')
print()
print('tables identical?', b1 == b2)
