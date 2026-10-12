"""Reviewer 180 -- the 71 blocks of Sym^3(W_12) and dim V_lam^{SO(6)xSO(6)},
built from the definition of W_12 with nothing imported from the record."""
import sys, os, time, json, resource
sys.path.insert(0, os.path.dirname(__file__))
from wtlib import *

try:
    resource.setrlimit(resource.RLIMIT_DATA, (6 * 1024**3, 6 * 1024**3))
except Exception as e:
    print('no rlimit:', e)
t0 = time.time()
def log(*a):
    print('[%7.1fs]' % (time.time()-t0), *a, flush=True)

r, typ = 6, 'D'
ch = char_weyl(r, False)
log('chi(W_12): dim', dim(ch), 'distinct weights', len(ch))

p1 = ch
p2 = adams(ch, 2)
p3 = adams(ch, 3)
sq = mul(p1, p1)
log('p1^2 terms', len(sq))
cub = mul(sq, p1)
log('p1^3 terms', len(cub))
h3 = divide(add(add(cub, mul(p1, p2), 3), p3, 2), 6)
log('Sym^3 terms', len(h3), 'dim', dim(h3), 'expected', 1640*1639*1638//6)

# ---- Racah peel into D6 irreducibles
W = weyl_elements(r, typ)
rh = rho(r, typ)
log('|W(D6)| =', len(W))

# candidate dominant weights: those in the support of h3
cands = set()
for w in h3:
    d = dominant_D(w)
    cands.add(d)
cands = sorted(cands, key=lambda x: (-sum(x), x))
log('candidate dominant weights:', len(cands))

blocks = {}
for lam in cands:
    tot = 0
    for perm, signs, det in W:
        key = tuple(a + b - c for a, b, c in zip(lam, rh, act(rh, perm, signs)))
        v = h3.get(key)
        if v:
            tot += det * v
    if tot:
        blocks[lam] = tot
log('D6 blocks:', len(blocks), 'total multiplicity', sum(blocks.values()))

# check dimensions add up
tot = 0
dims = {}
for lam, m in blocks.items():
    mult = freudenthal(lam, r, typ)
    dims[lam] = dim_from_mult(mult, r, typ)
    tot += m * dims[lam]
log('sum m_lam d_lam =', tot, 'expected', 1640*1639*1638//6, 'MATCH' if tot == 1640*1639*1638//6 else 'MISMATCH')

# ---- dim V_lam^{SO(6)xSO(6)}
WD3 = weyl_elements(3, 'D')
WH = []
for pa, sa, da in WD3:
    for pb, sb, db in WD3:
        WH.append((tuple(list(pa) + [3+x for x in pb]), tuple(list(sa)+list(sb)), da*db))
rhoH = (2, 1, 0, 2, 1, 0)

res = {}
for lam in sorted(blocks, key=lambda x: (-sum(x), x)):
    mult = freudenthal(lam, r, typ)
    chl = full_character(mult, r, typ)
    inv = branch_trivial_multiplicity(chl, WH, rhoH)
    res[lam] = inv
    log(lam, 'm=%d' % blocks[lam], 'd=%d' % dims[lam], 'dimV^H0=%d' % inv,
        'alleven' if all(x % 2 == 0 for x in lam) else '')

json.dump({'blocks': {str(k): v for k, v in blocks.items()},
           'dims': {str(k): v for k, v in dims.items()},
           'invH0': {str(k): v for k, v in res.items()}},
          open(os.path.join(os.path.dirname(__file__), 'sym3_d6.json'), 'w'), indent=1)

# aggregate cross-check straight off the Sym^3 character
agg = branch_trivial_multiplicity(h3, WH, rhoH)
log('dim (Sym^3 W_12)^{SO6xSO6} direct =', agg,
    ' from blocks =', sum(blocks[l]*res[l] for l in blocks))
log('dim (Sym^3 W_12)^{SO(12)} =', trivial_multiplicity(h3, r, typ, W, rh))
