"""F3, second front: does Lemma 24 have a STRICTER version that Delta could violate?
Krasnov-Tkachev Prop 6.6 is  sigma(L_c|_{c-perp}) subset (-inf, 1/2]  WITH 1 SIMPLE.
Also: does the moment budget (tr L_e = 0, tr L_e^2 = kappa_n/theta^2) constrain the orbit?"""
import sys; sys.path.insert(0, 'scripts/reviewers/r297')
import numpy as np, core297 as C

def full(n, W):
    W = W/np.linalg.norm(W); th = C.Pval(n, W)
    M = C.Le_on_weyl(n, W, th); M = 0.5*(M+M.T)
    ev = np.linalg.eigvalsh(M)
    sp, _, _, _ = C.le_spectrum_perp(n, W, th)
    D, tot, lam = C.Delta(n, W)
    orb = C.rowspace(C.orbit_tangent(n, W)).shape[0]
    kap = (2*n-1)*(n-1)/4.0
    return dict(theta=th, Delta=D, orbit=orb, lmax=sp.max(),
                mult_one=int(np.sum(np.abs(ev-1.0) < 1e-8)),
                mult_half=int(np.sum(np.abs(sp-0.5) < 1e-8)),
                trL=ev.sum(), trL2=(ev**2).sum(), kap_over_th2=kap/th**2, dimW=len(ev))

rows = []
for b in ([3,3],[3,5],[4,4],[2,4],[2,2,2],[2,2,4],[3,3,3]):
    W, n = C.sphere_product(b); rows.append(("S^"+"xS^".join(map(str,b)), n, W))
for m in (2,3): W,n = C.cpm(m); rows.append((f"CP^{m}", n, W))
rows.append(("C_5 blow-up", 10, C.c5_blowup()[0]))

print(f"  {'point':16s}{'n':>3s}{'res':>9s}{'theta':>10s}{'Delta':>9s}{'orbit':>6s}{'lam_max':>10s}"
      f"{'m(1)':>5s}{'m(1/2)':>7s}{'trL':>9s}{'trL^2':>9s}{'kap/th^2':>10s}")
for lbl, n, W in rows:
    Wn = W/np.linalg.norm(W); th = C.Pval(n, Wn)
    res = np.linalg.norm(C.Qmap(n, Wn) - th*Wn)
    d = full(n, W)
    print(f"  {lbl:16s}{n:>3d}{res:>9.1e}{d['theta']:>10.6f}{d['Delta']:>9.4f}{d['orbit']:>6d}"
          f"{d['lmax']:>10.6f}{d['mult_one']:>5d}{d['mult_half']:>7d}{d['trL']:>9.1e}"
          f"{d['trL2']:>9.4f}{d['kap_over_th2']:>10.4f}")

print("\nDoes a large orbit blow the tr(L_e^2) budget?  Need 1 + orbit/4 <= kappa_n/theta^2.")
for n in (8, 10, 12):
    kap = (2*n-1)*(n-1)/4.0; th0 = np.sqrt(1.5)
    print(f"  n={n:2d}: budget kappa/theta^2 at theta=sqrt(3/2) is {kap/th0**2:8.3f};"
          f"  1 + dim so(n)/4 = {1 + n*(n-1)/2/4:7.3f}  -> "
          f"{'no constraint' if 1+n*(n-1)/2/4 <= kap/th0**2 else 'CONSTRAINT'}")
