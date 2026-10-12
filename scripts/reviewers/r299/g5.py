import sys, os
sys.path.insert(0, os.path.dirname(__file__))
import numpy as np, core, points, le, g123, g1b

def check(nm, W, n):
    th = core.P(n, W)
    Lm, _, B, Bf = le.Lmat(n, W, th); d = Lm.shape[0]
    Lp, Uc, w = le.restrict_perp(Lm, Bf, W); Lp = 0.5*(Lp+Lp.T)
    ev, evec = np.linalg.eigh(Lp)
    # orbit tangent, in weyl coords then e-perp coords
    O = g1b.orbit_basis(n, W)                       # (k, N*N)
    Ow = O @ Bf.T
    leak = np.linalg.norm(O - (Ow @ Bf))            # orbit outside Weyl_n?
    Oc = Ow @ Uc
    u_, s_, vt_ = np.linalg.svd(Oc, full_matrices=False); Ob = vt_[s_>1e-9]
    ev_orbit = np.linalg.eigvalsh(Ob @ Lp @ Ob.T)
    # top eigenspace vs orbit
    lmax = ev[-1]; Etop = evec[:, np.abs(ev-lmax)<1e-8]
    orb_comp = np.linalg.norm(Ob @ Etop)
    # H_A leakage out of Weyl_n
    S = core.sym0_basis(n); leaks = []
    for Amat in S:
        D = core.deriv(n, Amat); H = D@W+W@D; H = 0.5*(H+H.T)
        nn = np.linalg.norm(H)
        if nn > 1e-12:
            leaks.append(np.linalg.norm(H - core.proj_weyl(n, H))/nn)
    # finite difference along top eigendirection, on the unit sphere of Weyl_n
    v = (Etop[:, 0] @ Uc.T) @ B.reshape(d, -1)
    V = v.reshape(W.shape); V /= np.linalg.norm(V)
    out = []
    for t in (1e-3, 1e-4):
        Wt = W*np.cos(t) + V*np.sin(t); Wt /= np.linalg.norm(Wt)
        out.append((core.P(n, Wt)-th)/t**2)
    pred = 3*th*(lmax-0.5)
    print(f"== {nm} n={n} theta={th:.9f} lam_max={lmax:.9f} mult={Etop.shape[1]}")
    print(f"   orbit dim={Ob.shape[0]} leak out of Weyl={leak:.2e} spec(L_e|orbit) in "
          f"[{ev_orbit.min():.12f},{ev_orbit.max():.12f}]")
    print(f"   ||orbit component of E_top|| = {orb_comp:.2e}")
    print(f"   H_A leakage out of Weyl_n: min={min(leaks):.4f} max={max(leaks):.4f} mean={np.mean(leaks):.4f}")
    print(f"   (P(W_t)-theta)/t^2 = {out[0]:.6f}, {out[1]:.6f}   vs 3 theta (lam-1/2) = {pred:.6f}")

if __name__ == "__main__":
    for nm, W, n in [("S^3xS^5",)+points.sphere_product([3,5]),
                     ("CP^4",)+points.cpm(4),
                     ("C5blowup",)+points.c5_blowup()]:
        check(nm, W, n)
