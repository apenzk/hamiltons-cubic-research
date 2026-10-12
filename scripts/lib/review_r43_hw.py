"""Reviewer 43, R3+R4: explicit U(m) highest-weight vectors in Weyl_2m (x) C.

No deflation, no Rayleigh quotients on small residues: each summand is reached by
its own highest-weight vector, verified annihilated by every raising operator of
gl(m), then L_e is applied to it directly.
"""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
from review_r43_core import Ambient, frob
from review_r43_cpm import Umat, build_e
from fractions import Fraction


class HW:
    def __init__(self, m):
        self.m = m
        self.n = n = 2 * m
        self.amb, self.U, self.e, self.abc = build_e(m)
        amb = self.amb
        # complex frame: f_a = e_{2a} - i e_{2a+1}   (J f_a = i f_a)
        F = np.zeros((n, n), dtype=complex)
        for a in range(m):
            F[2 * a, a] = 1.0;   F[2 * a + 1, a] = -1j       # f_a
            F[2 * a, m + a] = 1.0; F[2 * a + 1, m + a] = 1j   # fbar_a
        self.F = F
        self.Finv = np.linalg.inv(F)
        self.f = [F[:, a] for a in range(m)]
        self.fb = [F[:, m + a] for a in range(m)]

    def gl(self, a, b):
        """Z_{ab} in so(2m,C): f_b -> f_a,  fbar_a -> -fbar_b."""
        m, n = self.m, self.n
        Zc = np.zeros((n, n), dtype=complex)
        Zc[a, b] = 1.0
        Zc[m + b, m + a] = -1.0
        return self.F @ Zc @ self.Finv

    def rho(self, g):
        """action of g in so(2m,C) on Lambda^2, in the phi basis."""
        amb = self.amb; N = amb.N
        R = np.zeros((N, N), dtype=complex)
        for b in range(N):
            C = g @ amb.phi[b] - amb.phi[b] @ g
            R[:, b] = [C[i, j] for (i, j) in amb.pairs]
        return R

    def wedge(self, u, v):
        """u ^ v as a vector in the phi basis"""
        amb = self.amb
        M = np.outer(u, v) - np.outer(v, u)
        return np.array([M[i, j] for (i, j) in amb.pairs])

    def odot(self, x, y):
        return 0.5 * (np.outer(x, y) + np.outer(y, x))

    def pw(self, X):
        amb = self.amb
        return amb.weyl_project(X.real) + 1j * amb.weyl_project(X.imag)

    def Le(self, X):
        amb = self.amb; e = self.e
        return 0.5 * (e @ X + X @ e) + (amb.sharp(e, X.real) + 1j * amb.sharp(e, X.imag))


def analyse(m, verbose=True):
    H = HW(m); amb = H.amb; U = H.U
    om = U.omega.astype(complex)
    f, fb = H.f, H.fb
    W = H.e / np.linalg.norm(H.e)
    cases = {}
    cases['trivial <W>'] = (H.e.astype(complex), tuple([0] * m))
    if m >= 2:
        w = [0] * m; w[0] = 1; w[m - 1] -= 1
        cases['su(m) adjoint'] = (H.odot(H.wedge(f[0], fb[m - 1]), om), tuple(w))
        w = [0] * m; w[0] += 1; w[1] += 1
        cases['orbit  Lam^2 E'] = (H.odot(H.wedge(f[0], f[1]), om), tuple(w))
        w = [0] * m; w[0] += 2; w[1] += 2
        cases['V_(2,2);0'] = (H.odot(H.wedge(f[0], f[1]), H.wedge(f[0], f[1])), tuple(w))
        w = [0] * m; w[0] += 2; w[m - 1] -= 2
        cases['V_(2);(2) Bochner'] = (H.odot(H.wedge(f[0], fb[m - 1]), H.wedge(f[0], fb[m - 1])), tuple(w))
        w = [0] * m; w[0] += 2; w[1] += 1; w[m - 1] -= 1
        cases['V_(2,1);(1)'] = (H.odot(H.wedge(f[0], f[1]), H.wedge(f[0], fb[m - 1])), tuple(w))
    if m >= 4:
        w = [0] * m; w[0] += 1; w[1] += 1; w[m - 2] -= 1; w[m - 1] -= 1
        cases['V_(1,1);(1,1)'] = (H.odot(H.wedge(f[0], f[1]), H.wedge(fb[m - 2], fb[m - 1])), tuple(w))
    raisers = [H.rho(H.gl(a, a + 1)) for a in range(m - 1)]
    cartan = [H.rho(H.gl(a, a)) for a in range(m)]
    out = []
    for name, (v0, wt) in cases.items():
        v = H.pw(v0)
        nv = np.linalg.norm(v)
        if nv < 1e-10 * max(np.linalg.norm(v0), 1e-30):
            out.append((name, wt, 0.0, None, None, None)); continue
        v = v / nv
        hw = max(np.abs(R @ v - v @ R).max() for R in raisers) if raisers else 0.0
        wts = [np.abs((C @ v - v @ C) - wt[a] * v).max() for a, C in enumerate(cartan)]
        Lv = H.Le(v)
        lam = np.vdot(v.ravel(), Lv.ravel()) / np.vdot(v.ravel(), v.ravel())
        res = np.linalg.norm(Lv - lam * v)
        out.append((name, wt, nv / np.linalg.norm(v0), hw, max(wts), (lam, res)))
    return out


if __name__ == '__main__':
    for m in [int(x) for x in sys.argv[1:]] or [4, 5, 6]:
        print(f'\n=== m = {m}  (n = {2*m}) ===')
        print(f'{"summand":22} {"weight":26} {"surv":>9} {"raised":>9} {"cartan":>9} {"L_e eig":>22} {"resid":>9}')
        for name, wt, surv, hw, cw, lr in analyse(m):
            if lr is None:
                print(f'{name:22} {str(wt):26} {surv:9.2e}   -- projects to ZERO --')
                continue
            lam, res = lr
            print(f'{name:22} {str(wt):26} {surv:9.3f} {hw:9.1e} {cw:9.1e} '
                  f'{lam.real:12.9f}{lam.imag:+.1e}i {res:9.1e}')
