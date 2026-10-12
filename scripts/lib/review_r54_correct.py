"""K3, the empirical half: correctors, and where they actually land.

Three things the recorded run did not do.
  (a) Ask whether a returned point is on the SAME ORBIT as W or merely at the same
      theta.  The spectrum of W as an operator on Lambda^2 and the spectrum of L_e
      are both SO(n)-conjugation invariants, so equal spectra is a real test and
      equal theta is not.
  (b) Push past t = 0.4.
  (c) Push along directions OUTSIDE E(1/2), where a nearby S > 0 point may well sit.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_core import (Q, P, weyl_basis, Le_matrix, orbit_tangent,
                             slack_structural, theta0)
from review_r54_k1k2 import blowup_W, cycle

def setup():
    W, n, lab = blowup_W([2]*5, cycle(5), 4.0, -2.0, 1.0)
    W /= np.linalg.norm(W)
    th = P(n, W)
    B = weyl_basis(n)
    M = Le_matrix(n, W/th, B)
    ev, V = np.linalg.eigh(M)
    H = V[:, np.abs(ev - 0.5) < 1e-8]
    Ob = np.einsum('amn,dmn->ad', orbit_tangent(n, W), B).T
    u_, s_, _ = np.linalg.svd(Ob, full_matrices=False)
    Oc = u_[:, s_ > 1e-9*s_[0]]
    Pexc = H - Oc @ (Oc.T @ H)
    uu, ss, _ = np.linalg.svd(Pexc, full_matrices=False)
    Exc = uu[:, ss > 1e-8]
    # directions outside E(1/2) entirely, and outside orbit
    Rest = V[:, np.abs(ev - 0.5) >= 1e-8]
    wv = np.einsum('dmn,mn->d', B, W); wv /= np.linalg.norm(wv)
    Rest = Rest - np.outer(wv, wv @ Rest)
    uu, ss, _ = np.linalg.svd(Rest, full_matrices=False)
    Rest = uu[:, ss > 1e-8]
    return W, n, th, B, H, Oc, Exc, Rest, wv, ev, V

def L_at(n, X, B):
    """M[d,k] = <B_d, X o B_k>, the multiplication operator by an arbitrary X."""
    from review_r54_core import struct
    c = struct(n); N = c.shape[0]; D = len(B)
    AX = np.einsum('amn,np->amp', c, X, optimize=True)
    Z = (AX.reshape(N*N, N) @ c.transpose(1, 0, 2).reshape(N, N*N)).reshape(N, N, N, N)
    Z = Z.transpose(0, 2, 1, 3)                      # (a,b,m,q)
    Csh = B.reshape(D, N*N) @ Z.reshape(N*N, N*N)    # (D, m*q)
    Msh = -0.5 * (Csh.reshape(D, N, N).reshape(D, N*N) @ B.transpose(0, 2, 1).reshape(D, N*N).T)
    XB = np.einsum('mn,knp->kmp', X, B, optimize=True)
    T1 = 0.5 * (np.einsum('dmn,kmn->dk', B, XB, optimize=True)
                + np.einsum('dmn,knm->dk', B, XB, optimize=True))
    M = T1 + Msh
    return 0.5 * (M + M.T)


def make_resid(n, B):
    def resid(c):
        Wc = np.einsum('d,dij->ij', c, B)
        QW = Q(n, Wc)
        t = float(np.tensordot(Wc, QW))
        g = np.einsum('dij,ij->d', B, QW)
        return np.append(g - t*c, np.dot(c, c) - 1.0)

    def jac(c):
        Wc = np.einsum('d,dij->ij', c, B)
        QW = Q(n, Wc)
        t = float(np.tensordot(Wc, QW))
        g = np.einsum('dij,ij->d', B, QW)
        J = 2.0 * L_at(n, Wc, B) - 3.0 * np.outer(c, g) - t * np.eye(len(B))
        return np.vstack([J, 2.0 * c])
    return resid, jac

if __name__ == "__main__":
    W, n, th0v, B, H, Oc, Exc, Rest, wv, ev, V = setup()
    resid, jacf = make_resid(n, B)
    D = len(B)
    specW = np.round(np.linalg.eigvalsh(W), 8)
    print(f"base: theta={th0v:.9f}, W-spectrum {sorted(set(specW))}, |resid|={np.linalg.norm(resid(wv)):.1e}")
    rng = np.random.default_rng(540)

    def report(c):
        Wn = np.einsum('d,dij->ij', c, B); Wn /= np.linalg.norm(Wn)
        thn = float(np.tensordot(Wn, Q(n, Wn)))
        if thn < 0: Wn, thn = -Wn, -thn
        S = slack_structural(n, Wn)
        sp = np.round(np.linalg.eigvalsh(Wn), 6)
        same_spec = np.allclose(sp, np.round(specW, 6), atol=2e-5)
        # displacement from the base, and displacement modulo the orbit direction
        cn = np.einsum('dij,ij->d', B, Wn)
        if cn @ wv < 0: cn = -cn
        dc = cn - wv
        return thn, S, same_spec, np.linalg.norm(dc), np.linalg.norm(dc - Oc @ (Oc.T @ dc)), sp

    dirsets = [("excess E(1/2)", Exc), ("outside E(1/2)", Rest)]
    print(f"\n{'direction set':>16} {'t':>6} {'#':>4} {'conv':>5} {'theta':>12} {'S':>10} "
          f"{'same spec':>10} {'|dc|':>8} {'|dc_perp orbit|':>15}")
    for name, Dset in dirsets:
        ncols = Dset.shape[1]
        picks = range(ncols) if ncols <= 20 else rng.choice(ncols, 20, replace=False)
        for t in (0.05, 0.2, 0.4, 0.7, 1.0, 1.4):
            agg = {}
            nconv = 0
            for i in picks:
                c = wv + t*Dset[:, i]; c /= np.linalg.norm(c)
                sol = least_squares(resid, c, jac=jacf, xtol=3e-16, ftol=3e-16,
                                    gtol=3e-16, max_nfev=400)
                rn = np.linalg.norm(resid(sol.x))
                if rn > 1e-5:
                    agg.setdefault('NOCONV', [0])[0] += 1
                    continue
                nconv += 1
                thn, S, ss, dcn, dcp, sp = report(sol.x)
                key = (round(thn, 6), round(S, 4), ss)
                agg.setdefault(key, []).append((dcn, dcp))
            for key, v in sorted(agg.items(), key=lambda x: str(x[0])):
                if key == 'NOCONV':
                    print(f"{name:>16} {t:>6.2f} {len(list(picks)):>4} {'--':>5} {'not converged':>12} "
                          f"{'':>10} {'':>10} {v[0]:>8} ")
                else:
                    dcn = max(a for a, _ in v); dcp = max(b for _, b in v)
                    print(f"{name:>16} {t:>6.2f} {len(v):>4} {'yes':>5} {key[0]:>12.6f} {key[1]:>10.4f} "
                          f"{str(key[2]):>10} {dcn:>8.4f} {dcp:>15.6f}")

    print("\n--- random Weyl-space directions (no spectral structure at all) ---")
    for t in (0.2, 0.5, 1.0):
        agg = {}
        for _ in range(20):
            v = rng.normal(size=D); v -= (v @ wv)*wv; v /= np.linalg.norm(v)
            c = wv + t*v; c /= np.linalg.norm(c)
            sol = least_squares(resid, c, jac=jacf, xtol=3e-16, ftol=3e-16,
                                gtol=3e-16, max_nfev=400)
            if np.linalg.norm(resid(sol.x)) > 1e-5:
                agg['NOCONV'] = agg.get('NOCONV', 0) + 1
                continue
            thn, S, ss, dcn, dcp, sp = report(sol.x)
            key = (round(thn, 6), round(S, 3), ss)
            agg[key] = agg.get(key, 0) + 1
        print(f"  t={t}: {agg}")
