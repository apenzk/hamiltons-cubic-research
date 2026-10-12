"""Reviewer 61 / C6 clause 3: how large can theta get on the two-negative
stratum, and on its FULL-SUPPORT part?  Frank-Wolfe ascent inside the exact
convex description: with (y,z) fixed, {W in Weyl_m : W + b yy + c zz >= 0,
Wy = -by, Wz = -cz, b,c >= 0} is convex, and grad P = 3 Q(W), so each step
maximises the linear form <W, Q(W_k)> over it under |W|_F <= 1.  y,z are
refreshed from the new W between steps, so the iterate stays in the stratum."""
import numpy as np, cvxpy as cp, sys, time
from review_r61_core import weyl_basis, Q, theta, vec_to_skew, ricci_defect, bianchi_defect
from review_r61_c5 import W4, dimU


def step(m, y, z, Gdir, B):
    D = B.shape[1]
    a = cp.Variable(B.shape[0]); b = cp.Variable(); c = cp.Variable()
    W = cp.reshape(cp.matmul(a, B.reshape(B.shape[0], -1)), (D, D), order='C')
    G = W + b*np.outer(y, y) + c*np.outer(z, z)
    cons = [G >> 0, G @ y == 0, G @ z == 0, b >= 0, c >= 0, cp.norm(a, 2) <= 1]
    prob = cp.Problem(cp.Maximize(cp.sum(cp.multiply(W, Gdir))), cons)
    prob.solve(solver='SCS', eps=1e-8, max_iters=40000)
    if a.value is None:
        return None
    return np.einsum('k,kij->ij', a.value, B)


def support(W, m):
    lam, V = np.linalg.eigh(W)
    X0 = vec_to_skew(V[:, 0], m); X1 = vec_to_skew(V[:, 1], m)
    return float(np.linalg.eigvalsh(X0 @ X0.T + X1 @ X1.T)[0])


def ascend(m, W0, iters=25, label=""):
    B = weyl_basis(m)
    W = W0/np.linalg.norm(W0)
    for k in range(iters):
        lam, V = np.linalg.eigh(W)
        y, z = V[:, 0], V[:, 1]
        Wn = step(m, y, z, Q(W, m), B)
        if Wn is None:
            break
        Wn /= np.linalg.norm(Wn)
        if theta(Wn, m) <= theta(W, m) + 1e-9:
            W = Wn
            break
        W = Wn
    lam = np.linalg.eigvalsh(W)
    du, _ = dimU(W)
    print(f"  {label} m={m}: theta={theta(W,m):+.6f}  #neg={(lam<-1e-8).sum()}"
          f"  dimU={du}  lam_min(S)={support(W,m):.4e}"
          f"  ricci={ricci_defect(W,m):.1e} bianchi={bianchi_defect(W,m):.1e}")
    sys.stdout.flush()
    return theta(W, m), du, W


if __name__ == '__main__':
    rng = np.random.default_rng(31)
    print("sqrt(3/2) = 1.224745")
    for m in (6, 8):
        E = np.eye(m)
        starts = []
        # C5 witness (overlapping / orthogonal), plus random padded-pair starts
        if m == 6:
            starts.append(("C5 witness", W4([E[0], E[1], E[2], E[3]], m, (-2, 1, 1))
                           + W4([E[2], E[3], E[4], E[5]], m, (-2, 1, 1))))
        else:
            starts.append(("C5 witness", W4([E[0], E[1], E[2], E[3]], m, (-2, 1, 1))
                           + W4([E[4], E[5], E[6], E[7]], m, (-2, 1, 1))))
        for s in range(6):
            cA = rng.normal(size=3); cA -= cA.mean()
            cB = rng.normal(size=3); Bc = cB - cB.mean()
            Qm, _ = np.linalg.qr(rng.normal(size=(m, m)))
            fa = [Qm[:, 0], Qm[:, 1], Qm[:, 2], Qm[:, 3]]
            fb = [Qm[:, (4) % m], Qm[:, 5 % m], Qm[:, (m-2)], Qm[:, (m-1)]]
            Ws = W4(fa, m, cA) + W4(fb, m, Bc)
            lam = np.linalg.eigvalsh(Ws)
            if (lam < -1e-9).sum() <= 2 and np.linalg.norm(Ws) > 1e-6:
                starts.append((f"rand{s}", Ws))
        best = (-9, None)
        for lbl, W0 in starts:
            th, du, W = ascend(m, W0, label=lbl)
            if th > best[0]:
                best = (th, du)
        print(f"  ==> m={m}: best theta on the two-negative stratum = {best[0]:+.6f}"
              f" (dim U = {best[1]}, m = {m})\n")
