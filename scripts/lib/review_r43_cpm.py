"""Reviewer 43: U(m) projections on Lambda^2(R^2m) and the CP^m critical point."""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r43_core import Ambient, dim_weyl, frob
from fractions import Fraction


def Jmat(n):
    """standard complex structure: J e_{2a} = e_{2a+1}, J e_{2a+1} = -e_{2a} (0-based)."""
    m = n // 2
    J = np.zeros((n, n))
    for a in range(m):
        J[2 * a + 1, 2 * a] = 1.0
        J[2 * a, 2 * a + 1] = -1.0
    return J


class Umat:
    """The three U(m)-isotypic projections of Lambda^2(R^2m), in the phi basis."""

    def __init__(self, amb):
        self.amb = amb
        n = amb.n
        self.J = J = Jmat(n)
        N = amb.N
        # omega = J as an element of Lambda^2: omega_a = J_{ij}, a=(i<j)
        om = np.array([J[i, j] for (i, j) in amb.pairs])
        self.omega = om
        self.P_omega = np.outer(om, om) / (om @ om)
        # P_u X = 1/2 (X - J X J)   on antisymmetric X
        Pu = np.zeros((N, N))
        for b, (k, l) in enumerate(amb.pairs):
            X = amb.phi[b]
            Y = 0.5 * (X - J @ X @ J)
            Pu[:, b] = np.array([Y[i, j] for (i, j) in amb.pairs])
        self.P_u = Pu
        self.P_m = np.eye(N) - Pu
        self.P_su = Pu - self.P_omega


def e_closed(m):
    """The claimed closed form  e = a P_m + b P_su + c P_omega  (exact rationals)."""
    a = Fraction(-1, 2 * m - 1)
    b = Fraction(m - 2, (m + 1) * (2 * m - 1))
    c = Fraction(2 * (m - 1), 2 * m - 1)
    return a, b, c


def build_e(m):
    amb = Ambient(2 * m)
    U = Umat(amb)
    a, b, c = e_closed(m)
    e = float(a) * U.P_m + float(b) * U.P_su + float(c) * U.P_omega
    return amb, U, e, (a, b, c)
