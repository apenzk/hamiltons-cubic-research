"""The control's error state: replace ip3 with nonsense and see which controls notice."""
import importlib.util, sys, os
RUNS = "scripts/runs"
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(m); sys.stdout = o
    return m
ad = load("run_n5_adapted.py"); ADAPTED, MONO, WWT, G, ZERO = ad.ADAPTED, ad.MONO, ad.WWT, ad.G, ad.ZERO
ev = load("run_n5_evaluate.py"); sym3_ip = ev.sym3_ip
PRIME, IMOD = 65537, 256
def to_p(x):
    a, b = (x.r, x.i) if hasattr(x, "r") else x
    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME)
            + b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) * IMOD) % PRIME
_C = {}
def sip(t, s):
    if (t, s) not in _C: _C[(t, s)] = to_p(sym3_ip(t, s))
    return _C[(t, s)]
def ip3_real(u, v):
    tot = 0
    for a, ca in u.items():
        cap = to_p(ca); ta = MONO[a]
        if not cap: continue
        for b, cb in v.items():
            k = sip(ta, MONO[b])
            if k:
                cbp = to_p((cb.r, -cb.i) if hasattr(cb, "r") else (cb[0], -cb[1]))
                tot = (tot + cap * cbp % PRIME * k) % PRIME
    return tot
def ip3_nonsense(u, v):   # ignores its arguments entirely
    return 12345
def det_p(M):
    M = [r[:] for r in M]; n = len(M); d = 1
    for c in range(n):
        p = next((r for r in range(c, n) if M[r][c] % PRIME), None)
        if p is None: return 0
        if p != c: M[c], M[p] = M[p], M[c]; d = -d
        d = d * M[c][c] % PRIME; inv = pow(M[c][c], PRIME-2, PRIME)
        for r in range(c+1, n):
            f = M[r][c] * inv % PRIME
            if f: M[r] = [(x - f*y) % PRIME for x, y in zip(M[r], M[c])]
    return d % PRIME
def h_of(cps, ip):
    q = ip(cps[0][0], cps[0][0]); inv = pow(q, PRIME-2, PRIME)
    return [[ip(cps[i][0], cps[j][0]) * inv % PRIME for j in range(len(cps))]
            for i in range(len(cps))]
def scal(v, c): return {k: x*c for k, x in v.items()}
def addv(u, v):
    o = dict(u)
    for k, c in v.items(): o[k] = o.get(k, ZERO) + c
    return {k: c for k, c in o.items() if c}

lam = next(l for l, cs in ADAPTED.items() if len(cs) > 1)
c = ADAPTED[lam]
shipped = [c[0], c[0]]                                     # THE SHIPPED CONTROL (aliased)
real_a  = [c[0], [dict(v) for v in c[0]]]                  # distinct objects, equal content
real_b  = [c[0], [scal(v, G(3, 0)) for v in c[0]]]         # rescaled copy
real_c  = [c[0], c[1], [addv(a, b) for a, b in zip(c[0], c[1])]]   # dependent triple
print(f"block lambda = {lam}\n")
print(f"{'control':<34}{'det, real ip3':>16}{'det, ip3 := 12345':>22}   verdict")
for name, cps in (("shipped: [c0, c0] aliased", shipped),
                  ("real A: [c0, copy-of-c0]", real_a),
                  ("real B: [c0, 3*c0]", real_b),
                  ("real C: [c0, c1, c0+c1]", real_c)):
    a = det_p(h_of(cps, ip3_real)); b = det_p(h_of(cps, ip3_nonsense))
    v = "no error state" if b == 0 else "FAILS on broken ip3 -> real"
    print(f"{name:<34}{a:>16}{b:>22}   {v}")
print("\nthe genuine block, for discrimination:")
print(f"{'ADAPTED[lam] as built':<34}{det_p(h_of(c, ip3_real)):>16}"
      f"{det_p(h_of(c, ip3_nonsense)):>22}")

print("\n\n--- claim 3: what probes 1..3 actually are ---")
def mwt(i):
    a, b, cc = MONO[i]
    return (WWT[a][0]+WWT[b][0]+WWT[cc][0], WWT[a][1]+WWT[b][1]+WWT[cc][1])
print(f"{'lambda':>8} {'m':>3} {'dim':>5}   probe weights t=0..3, q!=0?")
for l, cs in ADAPTED.items():
    if len(cs) == 1: continue
    row = []
    for t in range(0, min(4, len(cs[0]))):
        v = cs[0][t]
        row.append(f"t{t}:{mwt(max(v))} q={'y' if ip3_real(v, v) else 'ZERO'}")
    print(f"{str(l):>8} {len(cs):>3} {len(cs[0]):>5}   " + "  ".join(row))
