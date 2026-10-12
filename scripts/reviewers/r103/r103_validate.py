"""Validate the independent implementation against known points."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r103'))
import r103_core as C
from itertools import combinations

def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n

def balanced_vertex(m):
    n = 2*m
    a = 1.0/np.sqrt((m-1)*(2*m-1))
    b = -(m-1)*a/m
    K = np.full((n, n), b)
    K[:m, :m] = a; K[m:, m:] = a
    np.fill_diagonal(K, 0.0)
    return K

def cpm(m):
    n = 2*m
    J = np.zeros((n, n))
    for k in range(m):
        J[2*k, 2*k+1] = 1.0; J[2*k+1, 2*k] = -1.0
    I = np.eye(n)
    R = (np.einsum('ik,jl->ijkl', I, I) - np.einsum('il,jk->ijkl', I, I)
         + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
         + 2*np.einsum('ij,kl->ijkl', J, J))
    return C.weyl_part(R, n), J

print("== balanced sphere products S^m x S^m ==")
for m in (3, 4, 6):
    n = 2*m
    K = balanced_vertex(m)
    W = C.weyl_from_vertex(K)
    ch = C.weyl_checks(W, n)
    th, mu, om, Wn = C.theta_bispectral(W, n)
    Kn = C.vertex_matrix(Wn, n)
    print(f" n={n} checks_max={max(ch.values()):.1e} theta={th:.9f} theta0={theta0(n):.9f} "
          f"diff={th-theta0(n):+.2e} t={np.linalg.norm(Kn)**2:.9f} "
          f"sum_mu2={np.sum(mu**2):.9f} sum_om2={np.sum(om**2):.9f} sum_om={np.sum(om):.1e}")

print("== CP^m ==")
for m in (2, 3, 4, 6):
    n = 2*m
    W, J = cpm(m)
    ch = C.weyl_checks(W, n)
    th, mu, om, Wn = C.theta_bispectral(W, n)
    Kn = C.vertex_matrix(Wn, n)
    print(f" n={n} checks_max={max(ch.values()):.1e} theta={th:.9f}  (sqrt(3/2)={np.sqrt(1.5):.9f}) "
          f"theta0={theta0(n):.6f} t_coordframe={np.linalg.norm(Kn)**2:.6f}")

print("== random Weyl: norms and traces ==")
rng = np.random.default_rng(11)
for n in (5, 6, 7):
    W = C.weyl_from_random(n, rng)
    th, mu, om, Wn = C.theta_bispectral(W, n)
    print(f" n={n} sum_mu={np.sum(mu):+.1e} sum_mu2={np.sum(mu**2):.12f} "
          f"sum_om={np.sum(om):+.1e} sum_om2={np.sum(om**2):.12f} theta={th:+.6f}")
