"""Claim 3: are the weight spaces of V_(4,1) and V_(3,3) in B_2 really disjoint?"""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *

a1, a2 = (1, -1), (0, 1)
def in_cone(v):
    # v = c1 a1 + c2 a2  =>  c1 = v1, c2 = v1 + v2
    return (v[0], v[0] + v[1])

for x, y in [((4,1),(3,3)), ((3,3),(4,1))]:
    v = tuple(p-q for p, q in zip(x, y))
    print(x, '-', y, '=', v, ' = %d*a1 + %d*a2' % in_cone(v))

W41 = full_character(freudenthal((4,1), 2, 'B'), 2, 'B')
W33 = full_character(freudenthal((3,3), 2, 'B'), 2, 'B')
print('dim V_(4,1) =', sum(W41.values()), ' #weights', len(W41))
print('dim V_(3,3) =', sum(W33.values()), ' #weights', len(W33))
common = set(W41) & set(W33)
print('SHARED weights:', len(common), 'of', len(W41), 'and', len(W33))
print('shared, sorted:', sorted(common))
print('is (3,3) a weight of V_(4,1)?', (3,3) in W41)
print('is (4,1) a weight of V_(3,3)?', (4,1) in W33)
print('c2(4,1) =', 4*7+1*2, ' c2(3,3) =', 3*6+3*4)

print()
print('--- what actually sits in the weight-(4,1) space of Sym^3(W_5) ---')
ch = char_weyl(2, True)
h3 = divide(add(add(mul(mul(ch, ch), ch), mul(ch, adams(ch, 2)), 3), adams(ch, 3), 2), 6)
print('dim Sym^3(W_5)_{(4,1)} =', h3.get((4,1)))
tab = {(4,2):4,(2,2):4,(3,2):3,(5,2):2,(4,3):2,(4,4):2,(4,1):2,(3,1):2,(4,0):2,(2,1):2,
       (3,0):2,(2,0):2,(6,6):1,(6,4):1,(6,3):1,(6,2):1,(6,0):1,(5,4):1,(5,3):1,(5,1):1,
       (5,0):1,(3,3):1,(1,0):1,(0,0):1}
contrib = []
for lam, m in tab.items():
    c = full_character(freudenthal(lam, 2, 'B'), 2, 'B')
    if c.get((4,1)):
        contrib.append((lam, m, c[(4,1)], m*c[(4,1)]))
contrib.sort()
tot = sum(x[3] for x in contrib)
print('blocks contributing to that weight space (lam, mult, wt-mult, product):')
for x in contrib:
    print('   ', x)
print('total', tot, ' matches', h3.get((4,1)))
print('(3,3) among them?', any(x[0]==(3,3) for x in contrib))
print('m_{(4,1)} = 2, so the highest-weight cut removes', h3.get((4,1))-2, 'of', h3.get((4,1)), 'dimensions')
