"""K3, the third-order tangent cone at the C_5 blow-up.

The second-order obstruction is vacuous here: T vanishes identically on E(1/2)^3
(measured 9e-14 against a scale of 450), so every E(1/2) direction integrates to
second order.  Expanding to third order on the unit sphere,
    c(t) = W + t v + t^2 u + t^3 s,  v in E(1/2),
gives  theta(2L_e-1)u = -(v o v)   (lambda_2 = 0 exactly, since <v,L_e v>=|v|^2/2
and <W,u>=-|v|^2/2), and the t^3 equation is solvable for s iff

    Psi(v) := P_{E(1/2)}( v o u ) = 0,   u = -(1/theta)(2L_e-1)^{-1}(v o v),

a cubic condition, independent of the free E(1/2)-part of u (again because T
vanishes on E(1/2)^3).  The tangent cone to Crit at W is contained in {Psi = 0}.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time
import numpy as np
from scipy.optimize import least_squares
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_core import (struct, Q, P, circ, weyl_basis, Le_matrix,
                             orbit_tangent, slack_structural)
from review_r54_k1k2 import blowup_W, cycle

SCR = 'scratchpad'

def build(sizes=(2,2,2,2,2)):
    W, n, lab = blowup_W(list(sizes), cycle(5), 4.0, -2.0, 1.0)
    W /= np.linalg.norm(W)
    th = P(n, W)
    B = weyl_basis(n)
    M = Le_matrix(n, W/th, B)
    ev, V = np.linalg.eigh(M)
    H = V[:, np.abs(ev - 0.5) < 1e-8]
    Ob = np.einsum('amn,dmn->ad', orbit_tangent(n, W), B).T     # (D, 45)
    u_, s_, _ = np.linalg.svd(Ob, full_matrices=False)
    Oc = u_[:, s_ > 1e-9 * s_[0]]
    inv = np.where(np.abs(ev - 0.5) < 1e-8, 0.0, 1.0 / (2 * ev - 1.0))
    K = (V * inv) @ V.T
    return W, n, th, B, H, Oc, K, M, ev, V

def tensorC(n, B, H):
    """C[d,i,j] = <B_d, X_i o X_j> for X_i the E(1/2) basis."""
    c = struct(n); N = c.shape[0]
    X = np.einsum('dk,dmn->kmn', H, B); r = X.shape[0]
    t0 = time.time()
    Z = np.einsum('ibc,jca->ijba', X, X, optimize=True)
    part1 = np.einsum('dab,ijba->dij', B, Z, optimize=True)
    del Z
    R = np.einsum('amn,inp->iamp', c, X, optimize=True)
    Sre = np.einsum('bpq,jqm->jbmp', c, X, optimize=True)
    G = np.einsum('iamp,jbmp->ijab', R, Sre, optimize=True)
    del R, Sre
    part2 = -0.5 * np.einsum('dab,ijab->dij', B, G, optimize=True)
    print(f"   C tensor built in {time.time()-t0:.0f}s, shape {part1.shape}")
    return part1 + part2

if __name__ == "__main__":
    W, n, th, B, H, Oc, K, M, ev, V = build()
    D = len(B); r = H.shape[1]
    print(f"D={D} dim E(1/2)={r} orbit={Oc.shape[1]} theta={th:.9f}")
    C = tensorC(n, B, H)
    print(f"C symmetry |C-C^T(ij)| = {np.abs(C - C.transpose(0,2,1)).max():.2e}")
    # cross-check against circ
    rng = np.random.default_rng(54)
    X = np.einsum('dk,dmn->kmn', H, B)
    a, b = rng.normal(size=r), rng.normal(size=r)
    Ya, Yb = np.einsum('k,kmn->mn', a, X), np.einsum('k,kmn->mn', b, X)
    direct = np.einsum('dmn,mn->d', B, circ(n, Ya, Yb))
    viat = np.einsum('dij,i,j->d', C, a, b)
    print(f"cross-check C: rel err {np.linalg.norm(direct-viat)/np.linalg.norm(direct):.2e}")
    # E(1/2)-component of C must vanish (the second-order fact)
    print(f"|H^T C| (2nd-order obstruction, must be 0) = {np.abs(np.einsum('dl,dij->lij', H, C)).max():.2e}")

    # fast cubic:  Psi(v) = -(1/theta) T4[l,i,j,k] v_i v_j v_k
    import time as _t
    t0 = _t.time()
    Cbar = np.einsum('de,eij->dij', K, C.reshape(D, -1).reshape(D, r, r), optimize=True)
    T4 = -(1.0 / th) * np.einsum('dli,djk->lijk', C, Cbar, optimize=True)
    T4 = (T4 + T4.transpose(0, 1, 3, 2)) / 2.0
    print(f"   T4 built in {_t.time()-t0:.0f}s, shape {T4.shape}")

    def Psi(v):
        return np.einsum('lijk,i,j,k->l', T4, v, v, v, optimize=True)

    def dPsi(v):
        A = np.einsum('lijk,j,k->li', T4, v, v, optimize=True)
        Bm = np.einsum('lijk,i,k->lj', T4, v, v, optimize=True)
        Cm = np.einsum('lijk,i,j->lk', T4, v, v, optimize=True)
        return A + Bm + Cm

    # check the fast form against the slow one
    vt = rng.normal(size=r)
    q = np.einsum('dij,i,j->d', C, vt, vt); ut = -(1.0/th)*(K @ q)
    slow = np.einsum('dli,d,i->l', C, ut, vt)
    print(f"   Psi fast-vs-slow rel err = {np.linalg.norm(Psi(vt)-slow)/np.linalg.norm(slow):.2e}")

    Oh = H.T @ Oc
    Qo, _ = np.linalg.qr(Oh)
    Pe = np.eye(r) - Qo @ Qo.T
    uu, ss, _ = np.linalg.svd(Pe)
    Exc = uu[:, ss > 1e-8]
    print(f"orbit in E(1/2) coords: rank {Qo.shape[1]}, excess {Exc.shape[1]}")

    worst = max(np.linalg.norm(Psi(Qo @ z / np.linalg.norm(Qo @ z))) for z in rng.normal(size=(300, 40)))
    print(f"VALIDATION  max |Psi| over 300 unit ORBIT directions = {worst:.3e}")
    ctrl = [np.linalg.norm(Psi(v / np.linalg.norm(v))) for v in rng.normal(size=(300, r))]
    print(f"CONTROL     |Psi| over 300 random unit E(1/2) directions: "
          f"min={min(ctrl):.4f} median={np.median(ctrl):.4f} max={max(ctrl):.4f}")
    pure = [np.linalg.norm(Psi(Exc @ z / np.linalg.norm(Exc @ z))) for z in rng.normal(size=(300, 20))]
    print(f"            |Psi| over 300 unit PURE-EXCESS directions: "
          f"min={min(pure):.4f} median={np.median(pure):.4f} max={max(pure):.4f}")

    print("\n--- search: a cone direction with nonzero excess component ---")
    nO, nE = 40, 20
    Basis = np.hstack([Qo, Exc])
    def resid(z):
        v = Basis @ z
        return np.append(Psi(v), np.dot(z[nO:], z[nO:]) - 1.0)
    def jac(z):
        v = Basis @ z
        J = dPsi(v) @ Basis
        last = np.zeros(nO + nE); last[nO:] = 2 * z[nO:]
        return np.vstack([J, last])
    best = (np.inf, None); hits = []
    t0 = _t.time()
    for trial in range(600):
        if trial and trial % 50 == 0:
            print(f'      {trial} starts, best {best[0]:.3e}, {len(hits)} hits, {_t.time()-t0:.0f}s', flush=True)
        z0 = np.concatenate([rng.normal(size=nO), rng.normal(size=nE)])
        z0[nO:] /= np.linalg.norm(z0[nO:])
        sol = least_squares(resid, z0, jac=jac, xtol=1e-14, ftol=1e-14, gtol=1e-14, max_nfev=3000)
        rn = np.linalg.norm(sol.fun)
        if rn < 1e-9:
            hits.append(sol.x.copy())
        if rn < best[0]:
            best = (rn, sol.x.copy())
    print(f"600 starts in {_t.time()-t0:.0f}s: {len(hits)} exact hits, min residual {best[0]:.3e}")
    if hits:
        np.save(f'{SCR}/r54_cone3_hits.npy', np.array(hits))
        # cluster by the excess direction (up to sign)
        E = np.array([h[nO:] / np.linalg.norm(h[nO:]) for h in hits])
        G = np.abs(E @ E.T)
        seen = np.zeros(len(E), bool); reps = []
        for i in range(len(E)):
            if seen[i]: continue
            grp = np.where(G[i] > 1 - 1e-6)[0]
            seen[grp] = True; reps.append(i)
        print(f"  distinct excess directions (up to sign): {len(reps)}")
        for i in reps[:10]:
            v = Qo @ hits[i][:nO] + Exc @ hits[i][nO:]
            print(f"   rep: |orbit|={np.linalg.norm(hits[i][:nO]):.4f} |exc|=1  |Psi|={np.linalg.norm(Psi(v)):.1e}")
    np.savez(f'{SCR}/r54_cone3.npz', C=C, H=H, Qo=Qo, Exc=Exc, K=K, W=W, B=B, th=th, M=M)
