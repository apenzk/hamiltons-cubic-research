"""Does step (ii) hold literally?  Which planes r actually contribute to the
quadratic form <X, e o X>, and to the raw T_ab before symmetrisation?"""
import sys
from fractions import Fraction as F
sys.path.insert(0, 'scripts/lib')
from review_r33_n8 import pairs, c_full, X_support, eps_vec

p, q = 5, 5; n = p+q; D = n*(n-1)//2
P = pairs(n); C = c_full(n); Xe = X_support(p, q)
core = {0, 1, p, p+1}
Xmat = {}
for (a, b), v in Xe.items(): Xmat[(a, b)] = v

# tr(A_r X A_r X) = sum_{m,n,s,t} c_{rms} X_st c_{rtn} X_nm
def trAXAX(r):
    tot = F(0)
    for (s, t), xst in Xe.items():
        for (nn, m), xnm in Xe.items():
            v1 = C.get((r, m, s)); v2 = C.get((r, t, nn))
            if v1 and v2: tot += v1*xst*v2*xnm
    return tot

nz = [(P[r], trAXAX(r)) for r in range(D) if trAXAX(r) != 0]
print("planes r with tr(A_r X A_r X) != 0 :")
for pl, v in nz: print("   ", pl, "both-in-core:", set(pl) <= core, " value", v)
print("total:", len(nz), "of", D)

# now the RAW T_ab: which r feed a nonzero contribution at all?
byam = {}
for (a, m, r), v in C.items(): byam.setdefault((a, m), []).append((r, v))
brq = {}
for (b, r, qq), v in C.items(): brq.setdefault((r, qq), []).append((b, v))
eps = eps_vec(p, q)
Traw = {}
rused = set()
for (qq, mm), xv in Xe.items():
    for a in range(D):
        for (r, v1) in byam.get((a, mm), []):
            w = xv*v1*eps[r]
            if w == 0: continue
            for (b, v2) in brq.get((r, qq), []):
                if w*v2 != 0:
                    Traw[(a, b)] = Traw.get((a, b), F(0)) + w*v2
                    rused.add(r)
Traw = {k: v for k, v in Traw.items() if v != 0}
gen = [P[r] for r in sorted(rused) if not set(P[r]) <= core]
print(f"\nplanes r entering a nonzero TERM of T_ab: {len(rused)}; with a generic index: {len(gen)}")
print("  examples:", gen[:8])
offsup = [(P[a], P[b], v) for (a, b), v in Traw.items() if (a, b) not in Xmat]
print(f"nonzero raw T_ab entries: {len(Traw)}, of which OFF the support of X: {len(offsup)}")
print("  examples:", offsup[:6])
