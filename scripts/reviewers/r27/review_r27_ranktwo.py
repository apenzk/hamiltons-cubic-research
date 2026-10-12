"""Reviewer 27, claim (D): the rank-two Rayleigh quotient, and whether it is about the right object."""
import numpy as np
from itertools import combinations
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M

rng = np.random.default_rng(3)


def study(n, W, name):
    theta = float(np.trace(W @ C.Q(n, W)))
    e = W / theta
    pr, idx, c = C.struct(n)
    ev, U = np.linalg.eigh(W)
    negm = ev < -1e-10
    mB = U[:, negm]                      # orthonormal basis of m
    hB = U[:, ~negm]
    evm = ev[negm] / theta
    evh = ev[~negm] / theta
    print('\n== %s (n=%d) theta=%.9f' % (name, n, theta))
    print('   e-eigenvalues on m: %s     on h: %s' % (np.unique(np.round(evm, 10)), np.unique(np.round(evh, 10))))
    print('   -1/(n-1) = %.12f' % (-1.0 / (n - 1)))
    B = C.weyl_basis(n)
    coW = np.einsum('kab,ab->k', B, W)

    def quot(v):
        return float(np.trace(v @ C.circ(n, e, v)) / np.trace(v @ v))

    def projquot(v):
        co = np.einsum('kab,ab->k', B, v)
        co -= (co @ coW) * coW
        if np.linalg.norm(co) < 1e-12:
            return None, 0.0
        vp = np.einsum('k,kab->ab', co, B)
        return quot(vp), np.linalg.norm(co) / np.linalg.norm(v)

    worstform = 0.0
    worstsharp = 0.0
    Rs, Rps, C2 = [], [], []
    for trial in range(120):
        a = rng.normal(size=mB.shape[1]); b = rng.normal(size=mB.shape[1])
        x = mB @ a; x /= np.linalg.norm(x)
        y = mB @ b; y -= (y @ x) * x; y /= np.linalg.norm(y)
        v = 0.5 * (np.outer(x, y) + np.outer(y, x))
        R = quot(v)
        z = np.einsum('abg,a,b->g', c, x, y)
        zh = hB.T @ z; zm = mB.T @ z
        alpha = evm[0]; beta = evh[0]
        pred = alpha - 0.5 * (float(zh @ (np.diag(evh) @ zh)) + float(zm @ (np.diag(evm) @ zm)))
        worstform = max(worstform, abs(R - pred))
        sh = float(np.trace(v @ C.sharp_bilinear(n, e, v)))
        worstsharp = max(worstsharp, abs(sh - (-0.25) * float(z @ (e @ z))))
        Rp, frac = projquot(v)
        Rs.append(R); Rps.append(Rp); C2.append(float(z @ z))
    print('   |R - [alpha - (1/2)(<z_h,e z_h>+<z_m,e z_m>)]| max = %.2e' % worstform)
    print('   |<v,sharp(e,v)> + (1/4)<z,e z>|            max = %.2e' % worstsharp)
    print('   raw    R over 120 random rank-two v in Sym^2(m): max %.6f  min %.6f' % (max(Rs), min(Rs)))
    print('   PROJECTED-to-Weyl R:                             max %.6f  min %.6f' % (max(Rps), min(Rps)))
    print('   ||[x,y]||^2 over those pairs: max %.6f' % max(C2))
    # maximise ||[x,y]||^2 over orthonormal pairs in m, and over all of Lambda^2
    from scipy.optimize import minimize

    def negC(p, Bs):
        k = Bs.shape[1]
        a = p[:k]; b = p[k:]
        x = Bs @ a; nx = np.linalg.norm(x)
        y = Bs @ b
        y = y - (y @ x) / nx**2 * x
        ny = np.linalg.norm(y)
        if nx < 1e-8 or ny < 1e-8:
            return 0.0
        x = x / nx; y = y / ny
        z = np.einsum('abg,a,b->g', c, x, y)
        return -float(z @ z)
    best = 0.0
    for _ in range(40):
        p0 = rng.normal(size=2 * mB.shape[1])
        r = minimize(negC, p0, args=(mB,), method='Nelder-Mead',
                     options=dict(maxiter=8000, fatol=1e-12, xatol=1e-10))
        best = max(best, -r.fun)
    bestall = 0.0
    Full = np.eye(len(pr))
    for _ in range(40):
        p0 = rng.normal(size=2 * len(pr))
        r = minimize(negC, p0, args=(Full,), method='Nelder-Mead',
                     options=dict(maxiter=8000, fatol=1e-12, xatol=1e-10))
        bestall = max(bestall, -r.fun)
    print('   max ||[x,y]||^2  restricted to m: %.9f      over all of Lambda^2: %.9f' % (best, bestall))
    # the best rank-two quotient achievable, raw and projected
    def negR(p, proj):
        k = mB.shape[1]
        a = p[:k]; b = p[k:]
        x = mB @ a; nx = np.linalg.norm(x)
        y = mB @ b; y = y - (y @ x) / nx**2 * x; ny = np.linalg.norm(y)
        if nx < 1e-8 or ny < 1e-8:
            return 0.0
        x = x / nx; y = y / ny
        v = 0.5 * (np.outer(x, y) + np.outer(y, x))
        if proj:
            q, fr = projquot(v)
            return -q if q is not None else 0.0
        return -quot(v)
    br = bp = -9
    for _ in range(25):
        p0 = rng.normal(size=2 * mB.shape[1])
        r = minimize(negR, p0, args=(False,), method='Nelder-Mead', options=dict(maxiter=6000))
        br = max(br, -r.fun)
        r = minimize(negR, p0, args=(True,), method='Nelder-Mead', options=dict(maxiter=6000))
        bp = max(bp, -r.fun)
    print('   sup over rank-two in Sym^2(m):  raw %.9f   projected-to-Weyl %.9f' % (br, bp))


if __name__ == '__main__':
    g, f, d = PT.gens_su3_adjoint()
    W, r, Pi = PT.W_subalgebra(8, g)
    study(8, W, 'su(3) adjoint')
    W, r, Pi = PT.W_subalgebra(5, PT.gens_so3_in_so5())
    study(5, W, 'so(3) in so(5)')
    W, r, Pi = PT.W_subalgebra(8, PT.gens_so_direct_sum(8, [4, 4]))
    study(8, W, 'so(4)+so(4)')
