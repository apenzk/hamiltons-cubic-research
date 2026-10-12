import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *

r = 6
WD3 = weyl_elements(3, 'D')
# H = SO(6) x SO(6) inside SO(12): equal rank, W_H = W(D3) x W(D3)
WH = []
for p1, s1, d1 in WD3:
    for p2, s2, d2 in WD3:
        perm = tuple(list(p1) + [3 + x for x in p2])
        signs = tuple(list(s1) + list(s2))
        WH.append((perm, signs, d1 * d2))
rhoH = (2, 1, 0, 2, 1, 0)
print('|W_H| =', len(WH))

tests = [(0,0,0,0,0,0), (2,0,0,0,0,0), (1,1,0,0,0,0), (2,2,0,0,0,0), (1,0,0,0,0,0),
         (2,2,2,0,0,0), (3,1,0,0,0,0), (2,1,1,0,0,0), (4,2,0,0,0,0), (2,2,2,2,2,2),
         (2,2,2,2,2,-2), (3,3,0,0,0,0), (4,4,2,2,0,0), (1,1,1,1,1,1)]
for lam in tests:
    m = freudenthal(lam, r, 'D')
    ch = full_character(m, r, 'D')
    d = dim_from_mult(m, r, 'D')
    inv = branch_trivial_multiplicity(ch, WH, rhoH)
    alleven = all(x % 2 == 0 for x in lam)
    print(lam, 'dim', d, 'dim V^{SO6xSO6} =', inv, ' all parts even:', alleven)
