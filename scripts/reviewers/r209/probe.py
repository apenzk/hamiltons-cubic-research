"""r209 probe: load the cached basis, time the pieces claims 1-2 need."""
import importlib.util, sys, os, time
from fractions import Fraction as F
D = "scripts/runs"
def load(n):
    sp = importlib.util.spec_from_file_location(n[:-3], os.path.join(D, n))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m
t0 = time.time()
ad = load("run_n5_adapted.py"); print(f"adapted {time.time()-t0:.0f}s", flush=True)
ev = load("run_n5_evaluate.py"); wm = load("run_n5_weyl_module.py"); ex = load("run_n5_extremiser.py")
print(f"modules {time.time()-t0:.0f}s", flush=True)
ADAPTED, MONO, WWT = ad.ADAPTED, ad.MONO, ad.WWT
print("blocks", len(ADAPTED), "copies", sum(len(v) for v in ADAPTED.values()))
print("m per block:", sorted((l, len(c)) for l, c in ADAPTED.items()))
def mwt(idx):
    a,b,c = MONO[idx]
    return (WWT[a][0]+WWT[b][0]+WWT[c][0], WWT[a][1]+WWT[b][1]+WWT[c][1])
MONS = {}
for i in range(len(MONO)): MONS.setdefault(mwt(i), []).append(i)
print("weights", len(MONS), "largest", max(len(v) for v in MONS.values()))
S = ex.S
W0T = wm.sym2_to_R({(a,b): S[a][b] for a in range(len(S)) for b in range(a,len(S)) if S[a][b]})
t1 = time.time(); c0 = ev.coords(W0T); print(f"coords {time.time()-t1:.0f}s", flush=True)
t1 = time.time(); cub0 = ev.cube(c0); print(f"cube {time.time()-t1:.0f}s, support {len(cub0)}", flush=True)
IDXOF = {t: k for k, t in enumerate(MONO)}
wts = {}
for k in cub0: wts.setdefault(mwt(IDXOF[k]), 0); wts[mwt(IDXOF[k])] += 1
print("W0^3 touches", len(wts), "weight classes of", len(MONS))
print("their monomial-block sizes:", sorted((len(MONS[w]) for w in wts), reverse=True)[:12])
print("total monomials in those blocks:", sum(len(MONS[w]) for w in wts))
sup = [len(v) for cs in ADAPTED.values() for c in cs for v in c]
print("adapted supports: max", max(sup), "mean", sum(sup)/len(sup))
# time one ip3 on the biggest weight class
t1 = time.time()
n = 0
for lam, cs in ADAPTED.items():
    v = cs[0][0]; n = len(v); break
print("timing ip3 on a pair of adapted vectors ...", flush=True)
lam0 = max(ADAPTED, key=lambda l: len(ADAPTED[l][0]))
c00 = ADAPTED[lam0][0]
t1 = time.time()
tot = 0
for t in range(min(5, len(c00))):
    u = c00[t]
    s = 0
    for a in u:
        for b in u:
            s += 1
    tot += s
print(f"  block {lam0} dimV={len(c00)}  5 self-pairs term count {tot} in {time.time()-t1:.1f}s")
