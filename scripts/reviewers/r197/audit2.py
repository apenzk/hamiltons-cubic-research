"""Reviewer 197, part 2: the controls run_n5_assemble.py does not ship.

C. locate the coefficient whose numerator is divisible by p (a live false zero)
D. rebuild HMAT / det h / dis exactly as the file does, with the NameError fixed
E. the control the multi-probe check needs: a same-weight transposition inside
   ONE copy -- reviewer 195's witness -- applied at the earliest legal position,
   and again at a position the probes do not reach
F. a coincidence control that runs the MEASUREMENT rather than a hand-built
   matrix of ones
G. every screen recomputed at a second prime
"""
import importlib.util, sys, os, pickle, itertools, time
from fractions import Fraction as Fr

RUNS = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                    "..", "..", "runs"))
def load(name):
    sp = importlib.util.spec_from_file_location(name[:-3], os.path.join(RUNS, name))
    m = importlib.util.module_from_spec(sp)
    o = sys.stdout; sys.stdout = open(os.devnull, "w")
    sp.loader.exec_module(m); sys.stdout = o
    return m

ev = load("run_n5_evaluate.py")
MONO, H, WT = ev.MONO, ev.H, ev.WT
with open(os.path.join(RUNS, "n5_adapted.pkl"), "rb") as f:
    ADAPTED = pickle.load(f)

_PERMS = list(itertools.permutations(range(3)))

class Fp:
    """the file's arithmetic, parameterised by the prime and the chosen i."""
    def __init__(self, p, imod):
        self.p, self.i = p, imod
        assert pow(imod, 2, p) == p - 1
        self.HP = {k: self.to_p(v) for k, v in H.items()}
        self._c = {}
    def to_p(self, x):
        p = self.p; (a, b) = x
        return (a.numerator * pow(a.denominator % p, p-2, p)
                + b.numerator * pow(b.denominator % p, p-2, p) * self.i) % p
    def ip_mono(self, t, s):
        k = (t, s); r = self._c.get(k)
        if r is None:
            p = self.p; tot = 0
            for pm in _PERMS:
                term = 1
                for i in range(3):
                    e = self.HP.get((t[i], s[pm[i]]))
                    if e is None: term = 0; break
                    term = term * e % p
                tot = (tot + term) % p
            self._c[k] = r = tot
        return r
    def ip3(self, u, v):
        p = self.p; tot = 0
        for a, ca in u.items():
            cap = self.to_p(ca)
            if not cap: continue
            ta = MONO[a]
            for b, cb in v.items():
                k = self.ip_mono(ta, MONO[b])
                if k:
                    cbp = self.to_p((cb[0], -cb[1]))
                    tot = (tot + cap * cbp % p * k) % p
        return tot
    def det(self, M):
        p = self.p
        M = [row[:] for row in M]; n = len(M); d = 1
        for c in range(n):
            piv = next((r for r in range(c, n) if M[r][c] % p), None)
            if piv is None: return 0
            if piv != c: M[c], M[piv] = M[piv], M[c]; d = -d
            d = d * M[c][c] % p
            inv = pow(M[c][c], p-2, p)
            for r in range(c+1, n):
                f = M[r][c] * inv % p
                if f: M[r] = [(x - f*y) % p for x, y in zip(M[r], M[c])]
        return d % p

def mwt(idx):
    a, b, c = MONO[idx]
    return (WT[a][0]+WT[b][0]+WT[c][0], WT[a][1]+WT[b][1]+WT[c][1])

def hmat(F, copies):
    m = len(copies)
    if m == 1: return [[1]]
    q00 = F.ip3(copies[0][0], copies[0][0])
    inv = pow(q00, F.p-2, F.p)
    return [[F.ip3(copies[i][0], copies[j][0]) * inv % F.p for j in range(m)]
            for i in range(m)]

def disagreements(F, copies, HM, tmax=4):
    m = len(copies); dis = 0; skipped = 0
    for t in range(1, min(tmax, len(copies[0]))):
        q = F.ip3(copies[0][t], copies[0][t])
        if not q: skipped += 1; continue
        inv = pow(q, F.p-2, F.p)
        for i in range(m):
            for j in range(m):
                if F.ip3(copies[i][t], copies[j][t]) * inv % F.p != HM[i][j]:
                    dis += 1
    return dis, skipped

# ---------------- C ----------------
print("=== C. the coefficient that is a nonzero rational vanishing mod 65537 ===")
P = 65537
for lam, cs in ADAPTED.items():
    for ci, copy in enumerate(cs):
        for vi, vec in enumerate(copy):
            for mi, (a, b) in vec.items():
                for part, f in (("re", a), ("im", b)):
                    if f.numerator and f.numerator % P == 0:
                        print(f"  lambda={lam} copy={ci} position={vi} monomial={mi} {part} = {f}")
                        print(f"    numerator / p = {f.numerator // P}, reduces to "
                              f"{(f.numerator * pow(f.denominator % P, P-2, P)) % P} mod p")

# ---------------- D ----------------
print("\n=== D. the file's own screens, with the NameError repaired ===")
F = Fp(65537, 256)
t0 = time.time()
HM = {}
for lam, cs in sorted(ADAPTED.items()):
    HM[lam] = hmat(F, cs)
dets = {lam: F.det(HM[lam]) for lam in HM}
sing = [l for l, d in dets.items() if d == 0]
print(f"  det h per block: {dets}")
print(f"  singular blocks: {sing}")
dis_tot = skip_tot = 0
for lam, cs in sorted(ADAPTED.items()):
    if len(cs) == 1: continue
    d, s = disagreements(F, cs, HM[lam])
    dis_tot += d; skip_tot += s
print(f"  dis = {dis_tot}, probes skipped for q == 0: {skip_tot}   [{time.time()-t0:.0f}s]")
ctl = [[HM[lam][0][0] for _ in range(2)] for _ in range(2)]
print(f"  HMAT[lam][0][0] for every block: {sorted({HM[l][0][0] for l in HM})}"
      f"   -> the shipped control matrix is {ctl}, det {F.det(ctl)}")

# ---------------- E ----------------
print("\n=== E. same-weight transposition inside ONE copy (195's witness) ===")
print(f"{'lambda':>9} {'m':>2} | same-weight pairs (t1,t2) with t1<=3 | earliest pair | "
      f"dis after swapping the earliest | dis after swapping an unprobed pair")
seen_by, blind_by = 0, 0
for lam, cs in sorted(ADAPTED.items()):
    m = len(cs)
    if m == 1: continue
    ws = [mwt(max(v)) for v in cs[0]]
    pairs = []
    byw = {}
    for t, w in enumerate(ws): byw.setdefault(w, []).append(t)
    for w, ts in byw.items():
        for x in range(len(ts)):
            for y in range(x+1, len(ts)): pairs.append((ts[x], ts[y]))
    pairs.sort()
    probed = [pr for pr in pairs if pr[0] <= 3]
    unprobed = [pr for pr in pairs if pr[0] > 3]
    def swap_dis(pr):
        if pr is None: return None
        t1, t2 = pr
        mod = [list(c) for c in cs]
        mod[1][t1], mod[1][t2] = mod[1][t2], mod[1][t1]
        HMm = hmat(F, mod)
        d, s = disagreements(F, mod, HMm)
        return d
    e = probed[0] if probed else None
    u = unprobed[0] if unprobed else None
    de, du = swap_dis(e), swap_dis(u)
    if de: seen_by += 1
    if u is not None and not du: blind_by += 1
    print(f"{str(lam):>9} {m:>2} | {len(probed):>3} of {len(pairs):>4} | earliest {pairs[0]} | "
          f"probed {e} -> dis {de} | unprobed {u} -> dis {du}")
print(f"  blocks where the earliest PROBED transposition is caught: {seen_by}")
print(f"  blocks where an UNPROBED transposition passes unnoticed: {blind_by}")

# ---------------- F ----------------
print("\n=== F. a coincidence control that runs the measurement ===")
for lam, cs in sorted(ADAPTED.items()):
    if len(cs) < 2: continue
    dup = [cs[0], cs[0]] + list(cs[2:])
    Hd = hmat(F, dup)
    print(f"  lambda={lam}: h with copy 0 duplicated = {Hd}, det = {F.det(Hd)}"
          f"   (must be 0)")
    break
# and a control that a DEPENDENT triple is caught
for lam, cs in sorted(ADAPTED.items()):
    if len(cs) < 3: continue
    dep = [dict(cs[0][t]) for t in range(len(cs[0]))]
    trip = [cs[0], cs[1], cs[0], cs[1]][:len(cs)]
    Ht = hmat(F, trip)
    print(f"  lambda={lam}: h on a dependent list = det {F.det(Ht)}   (must be 0)")
    break

# ---------------- G ----------------
print("\n=== G. every screen at a second prime ===")
for (p2, i2) in ((1000003, None), (999983, None)):
    pass
# find a prime = 1 mod 4 with an easy square root of -1
def find_i(p):
    for g in range(2, 200):
        r = pow(g, (p-1)//4, p)
        if pow(r, 2, p) == p-1: return r
    return None
for p2 in (1000033, 2000003, 15485867):
    if p2 % 4 != 1: continue
    i2 = find_i(p2)
    if i2 is None: continue
    F2 = Fp(p2, i2)
    HM2 = {lam: hmat(F2, cs) for lam, cs in sorted(ADAPTED.items())}
    s2 = [l for l in HM2 if F2.det(HM2[l]) == 0]
    d2 = sk2 = 0
    for lam, cs in sorted(ADAPTED.items()):
        if len(cs) == 1: continue
        a, b = disagreements(F2, cs, HM2[lam]); d2 += a; sk2 += b
    print(f"  p = {p2} (i = {i2}): singular blocks {s2}, dis {d2}, skipped {sk2}")
