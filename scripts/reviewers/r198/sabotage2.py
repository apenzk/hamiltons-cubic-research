"""Which negative controls have an ERROR STATE?

A control is real only if some plausible defect makes it stop returning 0.
Run every candidate control against a bank of broken ip3 variants.
"""
import importlib.util, sys, os
RUNS = "scripts/runs"
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w"); sp.loader.exec_module(m); sys.stdout = o
    return m
ad = load("run_n5_adapted.py"); ADAPTED, MONO, G, ZERO = ad.ADAPTED, ad.MONO, ad.G, ad.ZERO
ev = load("run_n5_evaluate.py"); sym3_ip = ev.sym3_ip
PRIME, IMOD = 65537, 256
def to_p(x, im=IMOD):
    a, b = (x.r, x.i) if hasattr(x, "r") else x
    return (a.numerator * pow(a.denominator % PRIME, PRIME-2, PRIME)
            + b.numerator * pow(b.denominator % PRIME, PRIME-2, PRIME) * im) % PRIME
_C = {}
def sip(t, s):
    if (t, s) not in _C: _C[(t, s)] = to_p(sym3_ip(t, s))
    return _C[(t, s)]
def mkip(conj=True, swap=False, const=None):
    def f(u, v):
        if const is not None: return const
        tot = 0
        for a, ca in u.items():
            cap = to_p(ca); ta = MONO[a]
            if not cap: continue
            for b, cb in v.items():
                k = sip(MONO[b], ta) if swap else sip(ta, MONO[b])
                if k:
                    r, i = (cb.r, cb.i) if hasattr(cb, "r") else cb
                    cbp = to_p((r, -i if conj else i))
                    tot = (tot + cap * cbp % PRIME * k) % PRIME
        return tot
    return f
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
    q = ip(cps[0][0], cps[0][0])
    if not q: return None
    inv = pow(q, PRIME-2, PRIME)
    return [[ip(cps[i][0], cps[j][0]) * inv % PRIME for j in range(len(cps))]
            for i in range(len(cps))]
def scal(v, c): return {k: x*c for k, x in v.items()}
def addv(u, v):
    o = dict(u)
    for k, c in v.items(): o[k] = o.get(k, ZERO) + c
    return {k: c for k, c in o.items() if c}

lam = next(l for l, cs in ADAPTED.items() if len(cs) > 1)
c = ADAPTED[lam]
I = G(0, 1)
CTLS = [
    ("SHIPPED  [c0, c0]  (aliased)",      [c0 := c[0], c[0]]),
    ("A  [c0, deep-copy of c0]",          [c[0], [dict(v) for v in c[0]]]),
    ("B  [c0, 3*c0]",                     [c[0], [scal(v, G(3)) for v in c[0]]]),
    ("B' [c0, i*c0]",                     [c[0], [scal(v, I) for v in c[0]]]),
    ("C  [c0, c1, c0+c1]",                [c[0], c[1], [addv(a, b) for a, b in zip(c[0], c[1])]]),
    ("C' [c0, c1, i*c0+3*c1]",            [c[0], c[1],
                                           [addv(scal(a, I), scal(b, G(3)))
                                            for a, b in zip(c[0], c[1])]]),
]
VARS = [("correct", mkip()),
        ("no conjugation", mkip(conj=False)),
        ("swapped sym3_ip args", mkip(swap=True)),
        ("ip3 := 12345", mkip(const=12345))]
w = max(len(n) for n, _ in CTLS) + 2
print(f"det of h, by control (rows) and ip3 defect (columns).  a control is REAL")
print(f"only if it is 0 under 'correct' and NONZERO under some defect.\n")
print(" " * w + "".join(f"{n:>24}" for n, _ in VARS))
for name, cps in CTLS + [("POSITIVE: block as built", c)]:
    cells = []
    for _, ip in VARS:
        h = h_of(cps, ip)
        cells.append("q00=0" if h is None else str(det_p(h)))
    print(f"{name:<{w}}" + "".join(f"{x:>24}" for x in cells))
print(f"\nlambda = {lam}, m = {len(c)}")
print("\nthe shipped control's four ip3 calls: _dup[0] IS _dup[1], so all four are")
print("ip3(c0[0], c0[0]) -- the SAME call.  h = [[1,1],[1,1]] identically, for any")
print("ip3 with ip3(x,x) != 0.  No property of the adapted basis is under test.")
