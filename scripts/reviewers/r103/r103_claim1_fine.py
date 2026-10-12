"""Two fine points on Claim 1: (i) spanning control, (ii) 'Ricci-flatness IS K1=0'."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r103'))
import r103_core as C
from itertools import combinations

print("=== (i) spanning control on the sampler ===")
rng = np.random.default_rng(3)
for n in (5, 6, 7):
    dim = n*(n+1)*(n+2)*(n-3)//12
    S = np.array([C.weyl_from_random(n, rng).ravel() for _ in range(dim+25)])
    sv = np.linalg.svd(S, compute_uv=False)
    print(f" n={n}: dim Weyl_n (formula) = {dim}; numerical rank = {int((sv > sv[0]*1e-10).sum())}; "
          f"gap {sv[dim-1]:.2e} -> {sv[dim]:.2e}")

print()
print("=== (ii) does K1=0 in ONE frame imply Ricci-flatness? ===")
n = 6
rng = np.random.default_rng(19)
# an algebraic curvature tensor whose Ricci is nonzero but has zero diagonal
Ric_target = np.zeros((n, n)); Ric_target[0, 1] = Ric_target[1, 0] = 1.0
R = C.kn(Ric_target, np.eye(n))/(n-2)
R = C.bianchi_project(R)
Ric = C.ricci(R)
K = C.vertex_matrix(R, n)
print(f" R = KN(Ric_target, delta)/(n-2), Bianchi-projected:")
print(f"   Ric(R) diag = {np.round(np.diag(Ric),12)}")
print(f"   Ric(R) offdiag max = {np.abs(Ric - np.diag(np.diag(Ric))).max():.6f}   -> NOT Ricci-flat")
print(f"   K row sums max |.| = {np.abs(K.sum(1)).max():.2e}          -> K1 = 0 anyway")
print(f"   so K1=0 in one frame gives only diag(Ric)=0, not Ric=0.")
print()
print(" frame-invariant version: K(F)1 = 0 for every frame F  <=>  Ric = 0. spot check:")
from scipy.linalg import expm
worst = 0.0
for k in range(30):
    X = rng.standard_normal((n, n)); Q = expm((X - X.T)/2)
    Rr = np.einsum('ai,bj,ck,dl,ijkl->abcd', Q, Q, Q, Q, R)
    worst = max(worst, np.abs(C.vertex_matrix(Rr, n).sum(1)).max())
print(f"   max over 30 rotated frames of |K(F)1| = {worst:.6f}  (nonzero, as it must be)")
