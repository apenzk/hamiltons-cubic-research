"""Reviewer 43, R4 in exact arithmetic: the highest-weight rows over GF(p), p = 1 mod 4."""
import sys, numpy as np
from fractions import Fraction

def make_field(p):
    assert p % 4 == 1
    # a square root of -1
    for g in range(2, 200):
        r = pow(g, (p - 1) // 4, p)
        if (r * r) % p == p - 1:
            return r
    raise RuntimeError


class ModWeyl:
    def __init__(self, n, p):
        self.n = n; self.p = p
        self.I = make_field(p)
        pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
        self.pairs = pairs; self.N = N = len(pairs)
        pos = {}
        for a, (i, j) in enumerate(pairs):
            pos[(i, j)] = (a, 1); pos[(j, i)] = (a, -1)
        self.pos = pos
        phi = np.zeros((N, n, n), dtype=np.int64)
        for a, (i, j) in enumerate(pairs):
            phi[a, i, j] = 1; phi[a, j, i] = -1
        self.phi = phi
        A = np.zeros((N, N, N), dtype=np.int64)
        for a in range(N):
            com = phi[a] @ phi - phi @ phi[a]
            for cc, (i, j) in enumerate(pairs):
                A[a, :, cc] = com[:, i, j]
        self.A = A % p

    def inv(self, x):
        return pow(int(x) % self.p, self.p - 2, self.p)

    def rat(self, f):
        f = Fraction(f)
        return (int(f.numerator) % self.p) * self.inv(f.denominator) % self.p

    def to_tensor(self, W):
        n, p = self.n, self.p
        T = np.zeros((n, n, n, n), dtype=np.int64)
        for a, (i, j) in enumerate(self.pairs):
            for b, (k, l) in enumerate(self.pairs):
                v = W[a, b] % p
                for (ii, jj, s1) in ((i, j, 1), (j, i, -1)):
                    for (kk, ll, s2) in ((k, l, 1), (l, k, -1)):
                        T[ii, jj, kk, ll] = (s1 * s2 * v) % p
        return T

    def to_op(self, T):
        N = self.N
        W = np.zeros((N, N), dtype=np.int64)
        for a, (i, j) in enumerate(self.pairs):
            for b, (k, l) in enumerate(self.pairs):
                W[a, b] = T[i, j, k, l]
        return W % self.p

    def weyl_project(self, W):
        n, p = self.n, self.p
        T = self.to_tensor(W)
        b = (T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))) % p
        T = (T - b * self.inv(3)) % p
        ric = np.einsum('ijil->jl', T) % p
        tr = int(np.trace(ric)) % p
        h = ((ric - (tr * self.inv(2 * n - 2)) % p * np.eye(n, dtype=np.int64)) * self.inv(n - 2)) % p
        d = np.eye(n, dtype=np.int64)
        KN = (np.einsum('ik,jl->ijkl', h, d) + np.einsum('jl,ik->ijkl', h, d)
              - np.einsum('il,jk->ijkl', h, d) - np.einsum('jk,il->ijkl', h, d)) % p
        return self.to_op((T - KN) % p)

    def sharp(self, X, Y):
        p, A = self.p, self.A
        U = np.einsum('amq,qr->amr', A, X) % p
        V = np.einsum('bmq,qr->bmr', A, Y) % p
        T1 = np.einsum('apq,bqp->ab', U, V) % p
        return ((-(T1 + T1.T)) * self.inv(4)) % p

    def Le(self, e, X):
        p = self.p
        return ((e @ X + X @ e) % p * self.inv(2) + self.sharp(e, X)) % p


def build(m, p):
    n = 2 * m
    M = ModWeyl(n, p)
    N = M.N
    J = np.zeros((n, n), dtype=np.int64)
    for a in range(m):
        J[2 * a + 1, 2 * a] = 1; J[2 * a, 2 * a + 1] = -1
    om = np.array([J[i, j] for (i, j) in M.pairs], dtype=np.int64) % p
    twoPu = np.zeros((N, N), dtype=np.int64)
    for b, (i, j) in enumerate(M.pairs):
        X = M.phi[b]
        Y = X - J @ X @ J
        twoPu[:, b] = [Y[i2, j2] for (i2, j2) in M.pairs]
    twoPu %= p
    a = Fraction(-1, 2 * m - 1); bb = Fraction(m - 2, (m + 1) * (2 * m - 1)); c = Fraction(2 * (m - 1), 2 * m - 1)
    e = (M.rat(a) * np.eye(N, dtype=np.int64)
         + M.rat(bb - a) * M.inv(2) % p * twoPu
         + M.rat(c - bb) * M.inv(m) % p * (np.outer(om, om) % p)) % p
    return M, e, J, om


def rows(m, p):
    M, e, J, om = build(m, p)
    n, N, I = M.n, M.N, M.I
    def vec(u, v):
        Mx = (np.outer(u, v) - np.outer(v, u)) % p
        return np.array([Mx[i, j] for (i, j) in M.pairs], dtype=np.int64) % p
    f = []; fb = []
    for a in range(m):
        u = np.zeros(n, dtype=np.int64); u[2 * a] = 1; u[2 * a + 1] = (-I) % p; f.append(u % p)
        u2 = np.zeros(n, dtype=np.int64); u2[2 * a] = 1; u2[2 * a + 1] = I; fb.append(u2 % p)
    def odot(x, y):
        return ((np.outer(x, y) + np.outer(y, x)) % p * M.inv(2)) % p
    cases = {
        'trivial':        (e, Fraction(1)),
        'su(m) adjoint':  (odot(vec(f[0], fb[m-1]), om), Fraction(m + 2, 2 * (m + 1))),
        'orbit':          (odot(vec(f[0], f[1]), om), Fraction(1, 2)),
        'V_(2,2);0':      (odot(vec(f[0], f[1]), vec(f[0], f[1])), Fraction(-3, m + 1)),
        'V_(2);(2)':      (odot(vec(f[0], fb[m-1]), vec(f[0], fb[m-1])), Fraction(0)),
        'V_(2,1);(1)':    (odot(vec(f[0], f[1]), vec(f[0], fb[m-1])), Fraction(0)),
    }
    if m >= 4:
        cases['V_(1,1);(1,1)'] = (odot(vec(f[0], f[1]), vec(fb[m-2], fb[m-1])), Fraction(2, m + 1))
    out = []
    for name, (v0, lam) in cases.items():
        v = M.weyl_project(v0 % p)
        nz = bool(np.any(v % p))
        if not nz:
            out.append((name, lam, 'PROJECTS TO ZERO')); continue
        L = M.Le(e, v)
        ok = np.all((L - M.rat(lam) * v) % p == 0)
        out.append((name, lam, 'EXACT' if ok else 'MISMATCH'))
    return out


if __name__ == '__main__':
    primes = [1048573, 2097169]
    print('primes used:', primes[:2])
    for m in [int(x) for x in sys.argv[1:]] or [4, 5, 6]:
        for p in primes[:2]:
            r = rows(m, p)
            print(f'  m={m} p={p}: ' + ' | '.join(f'{n2}={s}({l})' for n2, l, s in r), flush=True)
