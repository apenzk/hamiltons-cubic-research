"""Reviewer 35 / M8: the bridge Hess P|_{W-perp} = 6 theta (L_e - 1/2 Id), checked
against the honest second derivative along great circles."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r35_core import *
np.random.seed(11)
for (p, q) in [(3,3),(4,4),(3,5),(4,5),(5,5)]:
    n = p+q; B = weyl_basis(n)
    Wn, th, _ = unit_and_theta(n, W_sphere_product(p, q)); e = Wn/th
    L = Le_matrix(n, e, B); Bf = np.array([b.ravel() for b in B])
    wc = 0.5*(Bf @ Wn.ravel())
    worst = 0.0
    for _ in range(5):
        c = np.random.randn(len(B)); c -= (c @ wc)*wc/(wc @ wc)
        c /= np.linalg.norm(c)
        v = sum(ci*b for ci, b in zip(c, B))
        f = lambda t: ip(np.cos(t)*Wn + np.sin(t)*v, Q(n, np.cos(t)*Wn + np.sin(t)*v))
        h = 1e-4
        d2 = (f(h) - 2*f(0.0) + f(-h))/h**2
        pred = 6*th*(c @ (L @ c) - 0.5)
        worst = max(worst, abs(d2-pred))
    print(f"  ({p},{q}) max |d2/dt2 P(great circle) - 6*theta*(<v,L_e v>-1/2)| = {worst:.2e}"
          f"   (theta={th:.6f})")
