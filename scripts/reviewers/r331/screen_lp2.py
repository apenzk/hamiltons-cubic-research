"""Validate the S3xS5 pinning (polytope dimension probes, integer-scaled LP);
same LP at S5xS7 (n=12) and CP^3 (n=6)."""
import numpy as np
from itertools import combinations
from scipy.optimize import linprog
rng = np.random.default_rng(7)

def census_lp(lam, theta, n, obj_weights=None, probes=0, label=""):
    N = len(lam)
    triples = list(combinations(range(N), 3))
    nv = len(triples)
    Aeq = np.zeros((3*N, nv)); beq = np.zeros(3*N)
    for i, t in enumerate(triples):
        for pos in range(3):
            k = t[pos]; o = [t[j] for j in range(3) if j != pos]
            lb, lc = lam[o[0]], lam[o[1]]
            Aeq[3*k, i] += 1.0; Aeq[3*k+1, i] += lb+lc; Aeq[3*k+2, i] += lb*lc
    for k in range(N):
        beq[3*k] = n-2; beq[3*k+1] = -2*lam[k]; beq[3*k+2] = lam[k]*(theta-lam[k])
    obj = np.array([2*(lam[a]**2*lam[b]**2+lam[b]**2*lam[c]**2+lam[a]**2*lam[c]**2)
                    for (a, b, c) in triples])
    out = {}
    for sense, sgn in (("min", 1.0), ("max", -1.0)):
        r = linprog(sgn*obj, A_eq=Aeq, b_eq=beq, bounds=(0, None), method='highs')
        out[sense] = (sgn*r.fun) if r.status == 0 else None
    print(f"[{label}] S22 min={out['min']}, max={out['max']}")
    for _ in range(probes):
        w = rng.standard_normal(nv)
        lo = linprog(w, A_eq=Aeq, b_eq=beq, bounds=(0, None), method='highs')
        hi = linprog(-w, A_eq=Aeq, b_eq=beq, bounds=(0, None), method='highs')
        print(f"   random objective: min={lo.fun:.6f} max={-hi.fun:.6f} gap={-hi.fun-lo.fun:.6f}")
    return out

# --- S3xS5, integer-scaled: lam=(-4,3,10), theta=28, n=8 ---
lam = np.array([-4.0]*15 + [3.0]*10 + [10.0]*3)
census_lp(lam, 28.0, 8, probes=3, label="S3xS5 n=8 integer-scaled (true S22_scaled=201180*?)")
# true scaled S22: 0.5068783068783069 * 630^2
print("expected scaled S22:", 0.5068783068783069*630**2)

# --- S5xS7, n=12: build ---
def sphere_product(n, p, q):
    k1 = float(q-1); k2 = float(p-1)   # (p-1)k1 = (q-1)k2
    g = np.eye(n); R = np.zeros((n, n, n, n))
    def in1(i): return i < p
    for i in range(n):
        for j in range(n):
            for k in range(n):
                for l in range(n):
                    if all(map(in1, (i, j, k, l))): kap = k1
                    elif not any(map(in1, (i, j, k, l))): kap = k2
                    else: continue
                    R[i, j, k, l] = kap*((i == k)*(j == l)-(i == l)*(j == k))
    return weyl_normalize(R, n)

def weyl_normalize(R, n):
    g = np.eye(n)
    Ric = np.einsum('ijkj->ik', R); s = np.trace(Ric)
    Wt = R.copy()
    Wt -= (np.einsum('ik,jl->ijkl', Ric, g) - np.einsum('il,jk->ijkl', Ric, g)
           + np.einsum('jl,ik->ijkl', Ric, g) - np.einsum('jk,il->ijkl', Ric, g))/(n-2)
    Wt += s*(np.einsum('ik,jl->ijkl', g, g)-np.einsum('il,jk->ijkl', g, g))/((n-1)*(n-2))
    pairs = [(i, j) for i in range(n) for j in range(i+1, n)]
    N = len(pairs)
    Wm = np.zeros((N, N))
    for P, (i, j) in enumerate(pairs):
        for Q_, (k, l) in enumerate(pairs):
            Wm[P, Q_] = Wt[i, j, k, l]
    Wm /= np.sqrt(np.trace(Wm @ Wm))
    return Wm

Wm = sphere_product(12, 5, 7)
lam12 = np.linalg.eigvalsh(Wm)
vals = sorted(set(np.round(lam12, 9)))
mults = [int(np.sum(np.abs(lam12-v) < 1e-8)) for v in vals]
print("S5xS7 spectrum:", vals, mults)
nrm2 = np.sqrt(sum(m*v*v for v, m in zip(vals, mults)))
theta12 = np.sqrt(264/175)
# rationalize: multiply by sqrt(sum m v^2 * D) to guess integers
r0 = np.array(vals)/abs(vals[0])
print("ratios to |min|:", r0, " theta/|min| =", theta12/abs(vals[0]))
census_lp(lam12, theta12, 12, probes=1, label="S5xS7 n=12")

# --- CP^3, n=6 ---
n = 6
J = np.zeros((n, n))
for a in range(3):
    J[2*a, 2*a+1] = 1; J[2*a+1, 2*a] = -1
d = np.eye(n)
R = 0.25*(np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
          + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
          - 2*np.einsum('ij,kl->ijkl', J, J))
Wcp3 = weyl_normalize(R, 6)
lam6 = np.linalg.eigvalsh(Wcp3)
vals6 = sorted(set(np.round(lam6, 9)))
mults6 = [int(np.sum(np.abs(lam6-v) < 1e-8)) for v in vals6]
print("CP3 spectrum:", vals6, mults6)
census_lp(lam6, np.sqrt(10)/3, 6, probes=1, label="CP3 n=6 (theta=theta_0(6))")
