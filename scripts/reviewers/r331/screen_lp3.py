"""CP3 orientation fix + criticality check; type-mass probes at S3xS5;
max/min theta over the FULL (A),(B),(C),T>=0 system at fixed catalogued spectra;
exact span tests at S5xS7 and CP3 spectra."""
import numpy as np
from itertools import combinations
from scipy.optimize import linprog
from fractions import Fraction

def so_basis(n):
    B = []
    for i in range(n):
        for j in range(i+1, n):
            E = np.zeros((n, n)); E[i, j] = 1; E[j, i] = -1
            B.append(E)
    return B
def inner(X, Y): return 0.5*np.trace(X.T @ Y)

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

def theta_of(Wm, n):
    N = Wm.shape[0]
    B = so_basis(n)
    lam, U = np.linalg.eigh(Wm)
    Phi = [sum(U[k, a]*B[k] for k in range(N)) for a in range(N)]
    c = np.zeros((N, N, N))
    for a in range(N):
        for b in range(a+1, N):
            Cm = Phi[a] @ Phi[b] - Phi[b] @ Phi[a]
            for d2 in range(N):
                v = inner(Phi[d2], Cm)
                c[a, b, d2] = v; c[b, a, d2] = -v
    adm = np.transpose(c, (0, 2, 1))  # (ad_a)_{i j} = c_{a j i}
    Wd = np.diag(lam)
    Sharp = np.zeros((N, N))
    for k in range(N):
        for l in range(k, N):
            Sharp[k, l] = Sharp[l, k] = -0.5*np.trace(adm[k] @ Wd @ adm[l] @ Wd)
    Qm = Wd @ Wd + Sharp
    th = np.trace(Qm @ Wd)/np.trace(Wd @ Wd)
    return lam, th, np.abs(Qm - th*Wd).max()

# CP3
n = 6
J = np.zeros((n, n))
for a in range(3):
    J[2*a, 2*a+1] = 1; J[2*a+1, 2*a] = -1
d = np.eye(n)
R = 0.25*(np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
          + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
          - 2*np.einsum('ij,kl->ijkl', J, J))
Wcp3 = weyl_normalize(R, 6)
lam6, th6, res6 = theta_of(Wcp3, 6)
print("CP3: theta =", th6, " residual:", res6)
if th6 < 0:
    Wcp3 = -Wcp3
    lam6, th6, res6 = theta_of(Wcp3, 6)
    print("CP3 (negated): theta =", th6, " residual:", res6)
vals6 = sorted(set(np.round(lam6, 9)))
print("CP3 spectrum:", vals6, [int(np.sum(np.abs(lam6-v) < 1e-8)) for v in vals6])

def census_lp_obj(lam, theta, n, obj):
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
    res = {}
    for sense, sgn in (("min", 1.0), ("max", -1.0)):
        r = linprog(sgn*obj(triples, lam), A_eq=Aeq, b_eq=beq, bounds=(0, None), method='highs')
        res[sense] = sgn*r.fun if r.status == 0 else None
    return res

S22obj = lambda triples, lam: np.array(
    [2*(lam[a]**2*lam[b]**2+lam[b]**2*lam[c]**2+lam[a]**2*lam[c]**2) for a, b, c in triples])
r = census_lp_obj(lam6, th6, 6, S22obj)
print("CP3 S22 LP:", r)

# ---- type-mass probes at S3xS5 (integer scaled) ----
lam8 = np.array([-4.0]*15 + [3.0]*10 + [10.0]*3)
valmap = {-4.0: 0, 3.0: 1, 10.0: 2}
from itertools import combinations_with_replacement
type_list = list(combinations_with_replacement(range(3), 3))
def type_obj(tau):
    def f(triples, lam):
        w = np.zeros(len(triples))
        for i, (a, b, c) in enumerate(triples):
            tt = tuple(sorted((valmap[lam[a]], valmap[lam[b]], valmap[lam[c]])))
            if tt == tau: w[i] = 1.0
        return w
    return f
print("S3xS5 type-mass pinning probe (value indices 0=-4, 1=3, 2=10):")
for tau in type_list:
    r = census_lp_obj(lam8, 28.0, 8, type_obj(tau))
    gap = None if r['min'] is None else r['max']-r['min']
    print(f"  type {tau}: min={r['min']:.6f} max={r['max']:.6f} gap={gap:.2e}")

# ---- max/min THETA over the full system at fixed spectrum ----
def theta_lp(lam, n, label):
    N = len(lam)
    triples = list(combinations(range(N), 3))
    nv = len(triples)
    Aeq = np.zeros((3*N, nv+1)); beq = np.zeros(3*N)
    for i, t in enumerate(triples):
        for pos in range(3):
            k = t[pos]; o = [t[j] for j in range(3) if j != pos]
            lb, lc = lam[o[0]], lam[o[1]]
            Aeq[3*k, i] += 1.0; Aeq[3*k+1, i] += lb+lc; Aeq[3*k+2, i] += lb*lc
    for k in range(N):
        beq[3*k] = n-2; beq[3*k+1] = -2*lam[k]
        Aeq[3*k+2, nv] = -lam[k]     # ... - lam_k * theta = -lam_k^2
        beq[3*k+2] = -lam[k]**2
    ob = np.zeros(nv+1); ob[nv] = 1.0
    bounds = [(0, None)]*nv + [(None, None)]
    lo = linprog(ob, A_eq=Aeq, b_eq=beq, bounds=bounds, method='highs')
    hi = linprog(-ob, A_eq=Aeq, b_eq=beq, bounds=bounds, method='highs')
    print(f"[{label}] theta range over FULL (A),(B),(C),T>=0:",
          lo.fun if lo.status == 0 else lo.message, "to",
          -hi.fun if hi.status == 0 else hi.message)

theta_lp(lam8, 8, "S3xS5 spectrum, scaled (true theta=28)")
lam12 = np.array([-12.0]*35 + [10.0]*21 + [21.0]*10)
theta_lp(lam12, 12, "S5xS7 spectrum, scaled (true theta=132)")
lam_bal8 = None
# balanced S4xS4 n=8: two eigenvalues; h = so(4)+so(4) dim 12 value x, m dim 16 value y
# from record: E_max=h dim n(n-2)/4=12, E_min dim n^2/4=16, ratio lmax/|lmin| = n/(n-2) = 4/3
lam_bal = np.array([-3.0]*16 + [4.0]*12)
theta_lp(lam_bal, 8, "S4xS4 spectrum, scaled (true theta = ?)")
print("S4xS4 true scaled theta: lmin+(n-2)lmax =", -3+6*4)

# ---- exact span tests ----
exec(open('scripts/reviewers/r331/span_lib.py').read())
span_test([Fraction(-12), Fraction(10), Fraction(21)], [35, 21, 10], "S5xS7 n=12 exact")
v6 = [Fraction(round(v*np.sqrt(240))) for v in vals6]
print("CP3 scaled values:", v6)
span_test(v6, [int(np.sum(np.abs(lam6-v) < 1e-8)) for v in vals6], "CP3 n=6 exact")
