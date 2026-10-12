"""Reviewer 202, claim 1 last part: are the printed complex-off-diagonal counts
the truth over Q(i), or could a nonzero imaginary part have reduced to 0 mod p?
The six blocks the run reports as 0 are the ones at risk, so h at probe 0 is
recomputed EXACTLY over Q(i) for every block with m > 1."""
import sys, os, time
from fractions import Fraction as Fr
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import harness as H
ev = H.ev
sym3_ip, cmul, cadd, cconj = ev.sym3_ip, ev.cmul, ev.cadd, ev.cconj
MONO = H.MONO
Z = (Fr(0), Fr(0))

def ip3_exact(u, v):
    tot = Z
    for a, ca in u.items():
        ta = MONO[a]
        cap = (ca.r, ca.i) if hasattr(ca, "r") else ca
        if cap == Z: continue
        for b, cb in v.items():
            k = sym3_ip(ta, MONO[b])
            if k != Z:
                cbp = (cb.r, cb.i) if hasattr(cb, "r") else cb
                tot = cadd(tot, cmul(cmul(cap, cconj(cbp)), k))
    return tot

def cdiv(u, v):
    d = v[0]*v[0] + v[1]*v[1]
    return ((u[0]*v[0] + u[1]*v[1])/d, (u[1]*v[0] - u[0]*v[1])/d)

t0 = time.time()
lams = sorted((l for l in H.ADAPTED if len(H.ADAPTED[l]) > 1),
              key=lambda l: len(H.ADAPTED[l][0]))
print("block  m  supports of the probe-0 vectors   exact complex off-diag   mod-p")
for lam in lams:
    cs = H.ADAPTED[lam]; m = len(cs)
    sup = [len(c[0]) for c in cs]
    q00 = ip3_exact(cs[0][0], cs[0][0])
    Rex = [[cdiv(ip3_exact(cs[i][0], cs[j][0]), q00) for j in range(m)]
           for i in range(m)]
    ex_off = sum(1 for i in range(m) for j in range(m) if i != j and Rex[i][j][1])
    Rp = H.measure_h(H.ADAPTED, lam)
    p_off = sum(1 for i in range(m) for j in range(m) if i != j and Rp[i][j][1])
    herm = all(Rex[i][j] == (Rex[j][i][0], -Rex[j][i][1])
               for i in range(m) for j in range(m))
    agree = all(H.gp(Rex[i][j]) == Rp[i][j] for i in range(m) for j in range(m))
    print(f"{lam} {m}  sup {sup}  exact {ex_off}  modp {p_off}  "
          f"MATCH {ex_off == p_off}  exact-Hermitian {herm}  "
          f"reduces to the mod-p h: {agree}   [{time.time()-t0:.0f}s]", flush=True)
    if lam == (2, 0):
        print(f"      exact h = {Rex}")
