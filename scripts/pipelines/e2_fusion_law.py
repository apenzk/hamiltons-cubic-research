"""E2: is Fox's algebra AXIAL at the high-value idempotents?

e = W/theta is an idempotent of X o Y := B(X,Y), the polarization of Q.
L_e = e o (.) is (up to 6 theta) the Hessian of P.  Axial theory asks:
do the eigenspaces of L_e obey a FUSION LAW, E_l o E_m contained in a
prescribed sum of eigenspaces?  If so, the Z_2-grading of the record is the
Miyamoto involution and "high theta => graded" becomes fusion rigidity.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..'))
import sys, itertools
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import alt_mop

def weyl_basis(n, L2, alt_idx):
    """Orthonormal basis of {symmetric W on Lambda^2 : Ric(W)=0, Alt(W)=0}."""
    N = L2.N
    sym = []
    for a in range(N):
        for b in range(a, N):
            M = np.zeros((N, N)); M[a, b] = M[b, a] = 1.0
            sym.append(M / np.linalg.norm(M))
    rows = []
    for M in sym:
        rows.append(np.concatenate([ricci_from_mop(L2, M).ravel(),
                                    alt_mop(M, alt_idx).ravel()]))
    A = np.array(rows).T
    U, s, Vt = np.linalg.svd(A, full_matrices=True)
    ker = Vt[int(np.sum(s > 1e-9*s[0])):]
    basis = []
    for v in ker:
        M = sum(v[k]*sym[k] for k in range(len(sym)))
        basis.append(M/np.linalg.norm(M))
    # re-orthonormalize
    G = np.array([[np.sum(a*b) for b in basis] for a in basis])
    w, V = np.linalg.eigh(G)
    keep = w > 1e-9
    B = []
    for k in np.where(keep)[0]:
        M = sum(V[i, k]*basis[i] for i in range(len(basis)))
        B.append(M/np.linalg.norm(M))
    return B

def sphere_product(n, p, L2):
    N = L2.N; q = n-p
    x, y, z = 1.0/(p*(p-1)), 1.0/(q*(q-1)), -1.0/(p*q)
    lam = np.zeros(N)
    for a, (i, j) in enumerate(L2.pairs):
        lam[a] = x if (i < p and j < p) else (y if (i >= p and j >= p) else z)
    W = np.diag(lam); return W/np.linalg.norm(W)

n = 8
idx, pos, N, c = build_structure_constants(n)
L2 = Lambda2(n); alt_idx = build_alt_indices(L2)
Bs = weyl_basis(n, L2, alt_idx)
print(f"n={n}  dim Weyl = {len(Bs)}  (formula {n*(n+1)*(n+2)*(n-3)//12})")

W = sphere_product(n, 4, L2)
th = float(np.sum(W*Q_full(W, c)))
e = W/th
print(f"W* = balanced, theta = {th:.9f}, idempotent residual = "
      f"{np.linalg.norm(Q_full(e,c)-e):.2e}")

def circ(X, Y):
    return 0.5*(Q_full(X+Y, c) - Q_full(X, c) - Q_full(Y, c))

M = np.array([[np.sum(Bs[i]*circ(e, Bs[j])) for j in range(len(Bs))]
              for i in range(len(Bs))])
M = 0.5*(M+M.T)
ev, V = np.linalg.eigh(M)
uniq = []
for x in ev:
    if not uniq or abs(x-uniq[-1][0]) > 1e-7: uniq.append([x, 1])
    else: uniq[-1][1] += 1
print("\nL_e spectrum (eigenvalue, multiplicity):")
for val, m in uniq: print(f"   {val:+.9f}  x{m}")

# ---------------- fusion table ----------------
labels = [f"{v:+.2f}" for v, m in uniq]
groups = []
start = 0
for val, m in uniq:
    groups.append((val, V[:, start:start+m])); start += m

def to_mop(vec):
    return sum(vec[i]*Bs[i] for i in range(len(Bs)))

rng = np.random.default_rng(0)
print("\nfusion table: mass fraction of E_l o E_m landing in each eigenspace")
print("            " + "".join(f"{lab:>10}" for lab in labels))
grading = {}
for i, (lv, LV) in enumerate(groups):
    for j, (mv, MV) in enumerate(groups):
        if j < i: continue
        acc = np.zeros(len(groups))
        for _ in range(6):
            u = to_mop(LV @ rng.normal(size=LV.shape[1]))
            v = to_mop(MV @ rng.normal(size=MV.shape[1]))
            pr = circ(u, v)
            coord = np.array([np.sum(pr*Bs[k]) for k in range(len(Bs))])
            tot = np.linalg.norm(coord)
            if tot < 1e-12: continue
            for g, (gv, GV) in enumerate(groups):
                acc[g] += np.linalg.norm(GV.T @ coord)**2 / tot**2
        acc /= max(acc.sum(), 1e-30)
        hit = [labels[g] for g in range(len(groups)) if acc[g] > 1e-8]
        grading[(lv, mv)] = hit
        print(f"  {labels[i]} o {labels[j]}" + "".join(f"{acc[g]:10.5f}" for g in range(len(groups)))
              + "   -> " + ",".join(hit))
