"""S^3 x S^5 at n=8: build, validate, extract spectrum; rank tests for {2,2,0} span
membership at several spectra (exact rationals); LP min/max of S_22 (Q4 witnesses)."""
import numpy as np
from fractions import Fraction
from itertools import combinations

n, p, q = 8, 3, 5
k1, k2 = 2.0, 1.0     # 1/r1^2, 1/r2^2 with (p-1)k1' ... Einstein: (p-1)k1 = (q-1)k2
assert (p-1)*k1 == (q-1)*k2
g = np.eye(n)
R = np.zeros((n, n, n, n))
def in1(i): return i < p
for i in range(n):
    for j in range(n):
        for k in range(n):
            for l in range(n):
                if all(map(in1, (i, j, k, l))): kap = k1
                elif not any(map(in1, (i, j, k, l))): kap = k2
                else: continue
                R[i, j, k, l] = kap*((i == k)*(j == l) - (i == l)*(j == k))
Ric = np.einsum('ijkj->ik', R); s = np.trace(Ric)
Wt = R.copy()
for i in range(n):
    for j in range(n):
        for k in range(n):
            for l in range(n):
                Wt[i, j, k, l] -= (Ric[i, k]*g[j, l] - Ric[i, l]*g[j, k]
                                   + Ric[j, l]*g[i, k] - Ric[j, k]*g[i, l])/(n-2)
                Wt[i, j, k, l] += s*(g[i, k]*g[j, l] - g[i, l]*g[j, k])/((n-1)*(n-2))
print("Ric(W):", np.abs(np.einsum('ijkj->ik', Wt)).max())

pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
N = len(pairs)
Wm = np.zeros((N, N))
for P, (i, j) in enumerate(pairs):
    for Q_, (k, l) in enumerate(pairs):
        Wm[P, Q_] = Wt[i, j, k, l]
nrm = np.sqrt(np.trace(Wm @ Wm)); Wm /= nrm
lamr, U = np.linalg.eigh(Wm)
vals = sorted(set(np.round(lamr, 10)))
print("distinct eigenvalues:", vals, "mults:", [int(np.sum(np.abs(lamr-v) < 1e-9)) for v in vals])
print("unnormalized * norm ratios:", [v*nrm for v in vals])

# criticality check via structure constants
def so_basis(n):
    B = []
    for i in range(n):
        for j in range(i+1, n):
            E = np.zeros((n, n)); E[i, j] = 1; E[j, i] = -1
            B.append(E)
    return B
B = so_basis(n)
def inner(X, Y): return 0.5*np.trace(X.T @ Y)
Phi = [sum(U[k, a]*B[k] for k in range(N)) for a in range(N)]
c = np.zeros((N, N, N))
for a in range(N):
    for b in range(a+1, N):
        Cm = Phi[a] @ Phi[b] - Phi[b] @ Phi[a]
        for d in range(N):
            v = inner(Phi[d], Cm)
            c[a, b, d] = v; c[b, a, d] = -v
T = c**2
adm = np.zeros((N, N, N))
for a in range(N):
    for i2 in range(N):
        for j2 in range(N):
            adm[a, i2, j2] = c[a, j2, i2]
Wd = np.diag(lamr)
Sharp = np.zeros((N, N))
for k in range(N):
    for l in range(k, N):
        Sharp[k, l] = Sharp[l, k] = -0.5*np.trace(adm[k] @ Wd @ adm[l] @ Wd)
Qm = Wd @ Wd + Sharp
th_num = np.trace(Qm @ Wd)/np.trace(Wd @ Wd)
print("theta =", th_num, " sqrt(56/45) =", np.sqrt(56/45),
      " criticality residual:", np.abs(Qm - th_num*Wd).max())
S22_true = np.einsum('abc,a,b->', T, lamr**2, lamr**2)
print("S22 at the point itself:", S22_true)

# ---------- exact rank tests: is F220 in span of averaged (A),(B),(C) rows? ----------
def span_test(values, mults, label):
    """values: list of Fractions; mults: multiplicities. Returns (rank, in_span)."""
    d = len(values)
    types = [t for t in combinations(sorted(range(d)), 1)]
    # multisets of size 3 respecting multiplicities
    from itertools import combinations_with_replacement
    types = [t for t in combinations_with_replacement(range(d), 3)
             if all(t.count(v) <= mults[v] for v in set(t))]
    rows = []
    for v in range(d):
        for rel in ('A', 'B', 'C'):
            row = []
            for t in types:
                acc = Fraction(0)
                for pos in range(3):
                    if t[pos] == v:
                        others = [t[i] for i in range(3) if i != pos]
                        if rel == 'A': acc += 1
                        elif rel == 'B': acc += values[others[0]] + values[others[1]]
                        else: acc += values[others[0]]*values[others[1]]
                row.append(acc)
            rows.append(row)
    F = []
    for t in types:
        x, y, z = (values[t[0]], values[t[1]], values[t[2]])
        F.append(x*x*y*y + y*y*z*z + z*z*x*x)
    # exact Gaussian elimination for rank and membership
    Mrows = [r[:] for r in rows]
    ncols = len(types)
    piv = []
    r_i = 0
    for col in range(ncols):
        sel = None
        for rr in range(r_i, len(Mrows)):
            if Mrows[rr][col] != 0: sel = rr; break
        if sel is None: continue
        Mrows[r_i], Mrows[sel] = Mrows[sel], Mrows[r_i]
        pv = Mrows[r_i][col]
        Mrows[r_i] = [x/pv for x in Mrows[r_i]]
        for rr in range(len(Mrows)):
            if rr != r_i and Mrows[rr][col] != 0:
                f = Mrows[rr][col]
                Mrows[rr] = [a - f*b for a, b in zip(Mrows[rr], Mrows[r_i])]
        piv.append(col); r_i += 1
        if r_i == len(Mrows): break
    rank = r_i
    # reduce F against the echelon rows
    Fred = F[:]
    for rr, col in enumerate(piv):
        if Fred[col] != 0:
            f = Fred[col]
            Fred = [a - f*b for a, b in zip(Fred, Mrows[rr])]
    in_span = all(x == 0 for x in Fred)
    print(f"[{label}] d={d} #types={len(types)} rank={rank} F220 in span: {in_span}")
    return rank, in_span

# S3xS5 spectrum: exact values proportional to measured ones. ratios:
ratios = [v*nrm for v in vals]
print("attempt rationalization of ratios/k2:", [r for r in ratios])
# use the floating values scaled to small rationals if clean, else use Fractions of rounded ratio*90
fr = [Fraction(round(r*720), 720) for r in ratios]
print("rationalized:", fr, " check:", [float(a)-b for a, b in zip(fr, ratios)])
mults = [int(np.sum(np.abs(lamr-v) < 1e-9)) for v in vals]
span_test(fr, mults, "S3xS5 n=8 (exact ratios)")

# padded CP2 spectrum (by-hand check in the report):
span_test([Fraction(2), Fraction(-1), Fraction(0)], [1, 2, 12], "padded CP2 n=6")
# generic d=3 with all mults >= 3:
span_test([Fraction(2), Fraction(-1), Fraction(3)], [3, 3, 3], "generic d=3 mults>=3")
# generic d=3 with a zero value, all mults >= 3:
span_test([Fraction(2), Fraction(-1), Fraction(0)], [3, 3, 3], "d=3 with kernel, mults>=3")
# generic d=4,5,6:
span_test([Fraction(x) for x in (2, -1, 3, 5)], [3]*4, "generic d=4")
span_test([Fraction(x) for x in (2, -1, 3, 5, -7)], [3]*5, "generic d=5")
span_test([Fraction(x) for x in (2, -1, 3, 5, -7, 11)], [3]*6, "generic d=6")
# two-eigenvalue balanced-type:
span_test([Fraction(3), Fraction(-2)], [6, 9], "d=2 balanced-type")
