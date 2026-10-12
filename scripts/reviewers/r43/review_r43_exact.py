"""Reviewer 43: exact GF(p) verification of  e o e = e  at many m, lean in memory.

Only three matrix entries of e o e are needed: by Schur the symmetric
U(m)-commutant of Lambda^2(R^2m) is 3-dimensional (m-part is of complex type,
su(m) real, trivial real, pairwise non-isomorphic), so e o e is determined by
its values on one probe vector from each isotypic piece.
"""
import sys, numpy as np
from fractions import Fraction

P = 99999989          # prime; N*P^2 < 2^63 for N <= 900


def inv(x):
    return pow(int(x) % P, P - 2, P)


def frac_mod(f):
    return (int(f.numerator) % P) * inv(f.denominator) % P


class Lean:
    def __init__(self, m):
        self.m = m
        n = self.n = 2 * m
        pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
        self.pairs = pairs
        self.N = len(pairs)
        self.pos = {p: a for a, p in enumerate(pairs)}
        J = np.zeros((n, n), dtype=np.int64)
        for a in range(m):
            J[2 * a + 1, 2 * a] = 1
            J[2 * a, 2 * a + 1] = -1
        self.J = J

    def coeffs(self, X):
        """antisymmetric n x n -> vector in the phi basis"""
        return np.array([X[i, j] for (i, j) in self.pairs], dtype=np.int64)

    def ad(self, v):
        """v antisymmetric n x n (int) -> ad(v) as N x N int matrix mod P"""
        n, N = self.n, self.N
        A = np.zeros((N, N), dtype=np.int64)
        for b, (i, j) in enumerate(self.pairs):
            # [v, E_ij - E_ji]_{pq}
            C = np.zeros((n, n), dtype=np.int64)
            C[:, j] += v[:, i]
            C[i, :] -= v[j, :]
            C[:, i] -= v[:, j]
            C[j, :] += v[i, :]
            A[:, b] = self.coeffs(C)
        return A % P

    def Pu_Pom(self):
        """P_u and omega-outer-product (unnormalised) as N x N int matrices"""
        n, N, J = self.n, self.N, self.J
        Pu = np.zeros((N, N), dtype=np.int64)   # 2*P_u, kept integral
        for b, (i, j) in enumerate(self.pairs):
            X = np.zeros((n, n), dtype=np.int64)
            X[i, j] = 1; X[j, i] = -1
            Y = X - J @ X @ J                    # = 2 P_u X
            Pu[:, b] = self.coeffs(Y)
        om = self.coeffs(J)
        return Pu, om


def e_modp(m):
    """e = a P_m + b P_su + c P_omega  as an N x N matrix over GF(P)."""
    L = Lean(m)
    N = L.N
    a = Fraction(-1, 2 * m - 1)
    b = Fraction(m - 2, (m + 1) * (2 * m - 1))
    c = Fraction(2 * (m - 1), 2 * m - 1)
    twoPu, om = L.Pu_Pom()
    Pom_num = np.outer(om, om) % P            # omega omega^T ; |omega|^2 = m
    # e = a Id + (b-a) P_u + (c-b) P_omega
    A = frac_mod(a); B = frac_mod(b - a) * inv(2) % P; C = frac_mod(c - b) * inv(m) % P
    e = (A * np.eye(N, dtype=np.int64) + B * twoPu + C * Pom_num) % P
    return L, e, twoPu, om


def sharp_entry(L, e, v):
    """<v, sharp(e,e) v> = -1/2 tr(ad(v) e ad(v) e)  mod P"""
    Av = L.ad(v)
    M = (Av @ e) % P
    t = int(np.trace((M @ M) % P)) % P
    return (-t) * inv(2) % P


def check(m):
    L, e, twoPu, om = e_modp(m)
    n, N = L.n, L.N
    J = L.J
    # probes: omega itself; an su(m) element; an m-part element
    probes = {}
    probes['omega'] = J.copy()
    # su(m): X with XJ=JX, traceless w.r.t. the omega direction
    X = np.zeros((n, n), dtype=np.int64)     # phi_{0,2} = e0 ^ e2
    X[0, 2] = 1; X[2, 0] = -1
    Su = X - J @ X @ J                        # 2 P_u X ; orthogonal to omega
    probes['su'] = Su
    # m-part: X - P_u X
    Y = np.zeros((n, n), dtype=np.int64)
    Y[0, 2] = 1; Y[2, 0] = -1
    Mm = 2 * Y - (Y - J @ Y @ J)              # 2 P_m Y
    probes['m'] = Mm
    out = {}
    for k, v in probes.items():
        vc = L.coeffs(v) % P
        nrm = int(vc @ vc) % P
        ev = (e @ vc) % P
        e2 = int(vc @ ((e @ ev) % P)) % P     # <v, e^2 v>
        sh = sharp_entry(L, e, v)
        lhs = (e2 + sh) % P                   # <v, (e o e) v>
        rhs = int(vc @ ev) % P                # <v, e v>
        out[k] = (lhs == rhs, lhs, rhs, nrm)
    return out


if __name__ == '__main__':
    lo, hi = int(sys.argv[1]), int(sys.argv[2])
    allok = True
    for m in range(lo, hi + 1):
        r = check(m)
        ok = all(v[0] for v in r.values())
        allok &= ok
        print(f"m={m:3d} n={2*m:3d}  e o e == e on probes: "
              + " ".join(f"{k}:{'OK' if v[0] else 'FAIL'}" for k, v in r.items()),
              flush=True)
    print("ALL OK" if allok else "SOME FAILED")
