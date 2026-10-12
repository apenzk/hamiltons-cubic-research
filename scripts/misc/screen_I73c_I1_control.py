import sys, numpy as np, sympy as sp
sys.path.insert(0, __file__.rsplit('/', 1)[0])
from screen_I73_pair_direction import pairs, structure_constants, sharp_mat, ortho_basis
from screen_I73_pair_blindness import padded_cp2
exec(open(__file__.rsplit('/', 1)[0] + '/screen_I73c_I1_rowspan.py').read().split('for trial in range')[0])
n = 8; N = 28; c = structure_constants(n); P = ortho_basis(n)
W = padded_cp2(n); W /= np.sqrt(np.trace(W @ W))
th = np.trace(W @ W @ W) + np.sum(W * sharp_mat(c, W, W)); E = W / th
lam, V = np.linalg.eigh(E); vals = sorted(set(np.round(lam, 9)))
cls = [int(np.argmin([abs(l - v) for v in vals])) for l in lam]
m = [cls.count(a) for a in range(3)]
print("theta", th, "eps", vals, "m", m)
cp = np.einsum('abc,ax,by,cz->xyz', c, V, V, V); T = cp**2
# normalisation check: row A says sum_{b,c} T = 2(n-2)
print("row-A check (should be 2(n-2)=12):", np.round(T.sum(axis=(1, 2))[:3], 9))
tau = np.zeros((3, 3, 3))
for x in range(N):
    for y in range(N):
        for z in range(N):
            tau[cls[x], cls[y], cls[z]] += T[x, y, z]
Psi = [sum(V[k, x] * P[k] for k in range(N)) for x in range(N)]
A = [sum(Psi[x] @ Psi[x].T for x in range(N) if cls[x] == a) for a in range(3)]
Gt = np.array([[np.trace(A[a] @ A[b]) for b in range(3)] for a in range(3)])
eps = [sp.Rational(v).limit_denominator(10**8) for v in vals]
I1, rows, tvars, g12 = build(n, m, eps)
sub = {t: sp.Float(tau[tuple(int(ch) for ch in str(t)[1:])]) for t in tvars}; sub[g12] = sp.Float(Gt[0, 1])
print("rows residuals:", [round(float(r.subs(sub)), 9) for r in rows])
p = eps[1] - eps[0]; E2 = sum(m[a]*eps[a]**2 for a in range(3)); E3 = sum(m[a]*eps[a]**3 for a in range(3))
Gam = sp.Rational(n + 4, 12) * ((n - 1) * E3 - (n - 3) * E2)
print("I1 at padded CP2:", float(I1.subs(sub)), " window [", float(Gam / p), ", 0]")
print("Gram matrix:", np.round(Gt, 6), " tau_12x:", np.round(tau[0, 1], 6))
