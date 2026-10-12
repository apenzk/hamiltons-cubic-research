"""Reviewer 32: moment tests of the claimed L_e spectrum, valid for ALL (p,q).

Two trace identities hold for the algebra (Fox Thm 1.3, re-measured here from
this reviewer's own implementation, not borrowed):

    tr L_x = 0,              tr(L_x L_y) = kappa <x,y>,   kappa = (2n-1)(n-1)/4.

Applying them at x=y=e turns the claimed multiplicity list into two rational
identities in (p,q) that must hold at every n at once.  If either fails, N10
is refuted for all large (p,q) in one stroke.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys
import numpy as np
import sympy as sp
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r32_core import (struct_sparse_lists, weyl_basis, W_pq,
                             L_operator_sparse)

rng = np.random.default_rng(11)

print("=== A. measure kappa in this reviewer's own implementation ===")
print(f"  {'n':>3} {'tr(L_x)':>14} {'tr(L_x L_y)/<x,y>':>20} {'(2n-1)(n-1)/4':>16}")
for n in range(4, 11):
    N = n * (n - 1) // 2
    B = weyl_basis(n)
    D = B.shape[1]
    lists = struct_sparse_lists(n)
    v1 = rng.standard_normal(D)
    v2 = rng.standard_normal(D)
    x = (B @ v1).reshape(N, N)
    y = (B @ v2).reshape(N, N)
    Lx = B.T @ (L_operator_sparse(n, x, lists) @ B)
    Ly = B.T @ (L_operator_sparse(n, y, lists) @ B)
    ip = float(np.sum(x * y))
    print(f"  {n:3d} {np.trace(Lx):14.3e} {np.trace(Lx@Ly)/ip:20.12f} "
          f"{(2*n-1)*(n-1)/4:16.12f}")

p, q = sp.symbols('p q', positive=True)
n = p + q


def s(m): return (m + 2) * (m - 1) / 2
def cc(m): return m * (m - 1) / 2


mu = (n - 2) / (2 * (p - 1) * (q - 1))
lp = (p - 2) / (2 * (p - 1))
lq = (q - 2) / (2 * (q - 1))
fams = [(-mu, s(p) * s(q)), (mu, cc(p) * cc(q)), (lp, s(p)), (lq, s(q)),
        (sp.Rational(1, 2), p * q), (sp.Integer(1), sp.Integer(1))]

print("\n=== B. tr(L_e) from the claimed multiplicities ===")
t1 = sp.simplify(sum(l * m for l, m in fams))
print("   sum lambda_i m_i =", sp.simplify(sp.factor(t1)), " (must be 0)")

print("\n=== C. tr(L_e^2) vs kappa * ||e||^2 ===")
normW2 = sp.simplify(sp.Rational(1, 2) / (p * (p - 1)) + sp.Rational(1, 2) / (q * (q - 1))
                     + 1 / (p * q))
theta_raw = (n - 1) / (p * q)
norme2 = sp.simplify(normW2 / theta_raw**2)
print("   ||W_raw||^2 =", sp.factor(normW2))
print("   ||e||^2     =", sp.factor(norme2))
kappa = (2 * n - 1) * (n - 1) / 4
t2 = sp.simplify(sum(l**2 * m for l, m in fams))
print("   sum lambda_i^2 m_i =", sp.factor(t2))
print("   kappa * ||e||^2    =", sp.factor(sp.simplify(kappa * norme2)))
print("   difference         =", sp.simplify(t2 - kappa * norme2), " (must be 0)")

print("\n=== D. named total ===")
tot = sp.simplify(sum(m for _, m in fams))
print("   sum m_i        =", sp.factor(tot))
print("   pq(pq+3)/2     =", sp.factor(p * q * (p * q + 3) / 2))
print("   difference     =", sp.simplify(tot - p * q * (p * q + 3) / 2))
dimW = n * (n + 1) * (n + 2) * (n - 3) / 12
print("   dim Weyl - named =", sp.factor(sp.simplify(dimW - tot)))
print("   is that >= 0 for all p,q>=2?  values at small (p,q):")
for pp in range(2, 7):
    for qq in range(pp, 8):
        val = sp.simplify((dimW - tot).subs({p: pp, q: qq}))
        flag = '  <-- NEGATIVE' if val < 0 else ''
        print(f"      (p,q)=({pp},{qq}): {val}{flag}")

print("\n=== E. mu >= 1/2  <=>  (p-2)(q-2) <= 1  (N9) ===")
print("   mu - 1/2 =", sp.factor(sp.simplify(mu - sp.Rational(1, 2))))
print("   numerator sign is that of  (p+q-2) - (p-1)(q-1) = 2 - (p-2)(q-2):",
      sp.expand((p + q - 2) - (p - 1) * (q - 1)))
sols = [(pp, qq) for pp in range(2, 40) for qq in range(pp, 40)
        if (pp - 2) * (qq - 2) <= 1]
print("   (p,q) with p<=q<=39 and (p-2)(q-2)<=1:",
      [t for t in sols if t[0] >= 3], "plus the whole p=2 family")
print("   lambda_m = (m-2)/(2(m-1)) < 1/2 strictly for every m>=2:",
      sp.simplify(sp.Rational(1, 2) - lp))
