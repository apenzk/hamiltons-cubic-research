"""r201: exact Q(i) computation of the multiplicity Gram h on all 12 blocks,
compared against the mod-p pair arithmetic in run_n5_assemble.py."""
import importlib.util, sys, os, pickle, time
from fractions import Fraction as F

RUNS = "scripts/runs"
SCR  = "/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/ea3d63f3-07ce-4bf2-a0fb-4a245ad3dc41/scratchpad"

def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m

t0 = time.time()
ev = load("run_n5_evaluate.py")
H, sym3_ip, cmul, cadd, cconj, MONO = ev.H, ev.sym3_ip, ev.cmul, ev.cadd, ev.cconj, ev.MONO
print(f"evaluate loaded [{time.time()-t0:.0f}s], |H| = {len(H)}", flush=True)

# Hermiticity of the kernel, measured rather than assumed
bad = 0
for (a, b), v in H.items():
    w = H.get((b, a))
    if w is None or w != cconj(v): bad += 1
print(f"H Hermitian: {bad == 0}  (violations {bad})")

raw = pickle.load(open(os.path.join(RUNS, "n5_adapted.pkl"), "rb"))
ADAPTED = {k: [[{i: (F(a), F(b)) for i, (a, b) in vec.items()} for vec in copy]
               for copy in cs] for k, cs in raw.items()}

_C = {}
def K(t, s):
    v = _C.get((t, s))
    if v is None:
        v = sym3_ip(t, s); _C[(t, s)] = v
    return v

def ip_exact(u, v):
    tot = (F(0), F(0))
    for a, ca in u.items():
        ta = MONO[a]
        for b, cb in v.items():
            k = K(ta, MONO[b])
            if k != (F(0), F(0)):
                tot = cadd(tot, cmul(cmul(ca, cconj(cb)), k))
    return tot

def cdiv(x, y):
    d = y[0]*y[0] + y[1]*y[1]
    return ((x[0]*y[0] + x[1]*y[1])/d, (x[1]*y[0] - x[0]*y[1])/d)

OUT = {}
for lam in sorted(ADAPTED):
    cs = ADAPTED[lam]
    m = len(cs)
    if m == 1: continue
    t1 = time.time()
    X = [[ip_exact(cs[i][0], cs[j][0]) for j in range(m)] for i in range(m)]
    h = [[cdiv(X[i][j], X[0][0]) for j in range(m)] for i in range(m)]
    herm = all(h[i][j] == cconj(h[j][i]) for i in range(m) for j in range(m))
    offc = sum(1 for i in range(m) for j in range(m) if i != j and h[i][j][1] != 0)
    offz = sum(1 for i in range(m) for j in range(m) if i != j and h[i][j] == (F(0), F(0)))
    OUT[lam] = h
    print(f"  lambda={lam} m={m}  Hermitian {herm}  complex off-diag {offc}  "
          f"zero off-diag {offz}  X00={X[0][0]}  [{time.time()-t1:.0f}s]", flush=True)
    for i in range(m):
        print("     " + " | ".join(f"{h[i][j][0]}{'+' if h[i][j][1]>=0 else '-'}{abs(h[i][j][1])}i"
                                   for j in range(m)))
pickle.dump({k: [[(str(x[0]), str(x[1])) for x in r] for r in v] for k, v in OUT.items()},
            open(os.path.join(SCR, "r201_h_exact.pkl"), "wb"))
print(f"\ntotal [{time.time()-t0:.0f}s]")
