"""J1, sharper: determine alpha and beta each in COMPLETE isolation.

  X = KN(h0), h0 traceless  ->  s = 0, so the beta term is absent: P(X)=0 pins alpha alone.
  X = KN(g)                 ->  rho_0 = 0, so the alpha term is absent: P(X)=0 pins beta alone.
  X in Lambda^4             ->  P(X)=0 pins the Bianchi step alone.
No compensating pair can survive these, because in each test only one coefficient is live.
"""
import sys, numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r50_core as C

rng = np.random.default_rng(11)
print(f"{'n':>3} {'alpha solved':>14} {'2/(n-2)':>12} {'beta solved':>16} {'1/(n(n-1))':>14} {'Lam4->0':>10}")
for n in (5, 6, 7, 8, 9, 10, 11, 12):
    N = len(C.pairs_idx(n)[0])
    g = np.eye(n)
    # --- alpha alone ---
    h = rng.normal(size=(n, n)); h = 0.5 * (h + h.T); h0 = h - np.trace(h) / n * g
    X = C.KN(n, h0)
    Y = X - C.alt_part(n, X)
    rho = C.ricci(n, Y); s = float(np.trace(rho)); rho0 = rho - s / n * g
    K = C.KN(n, rho0)
    alpha = float(np.tensordot(Y, K) / np.tensordot(K, K))
    assert abs(s) < 1e-9 * np.linalg.norm(rho), f"s not zero: {s}"
    resid_a = np.linalg.norm(Y - alpha * K) / np.linalg.norm(Y)
    # --- beta alone ---
    Xg = C.KN(n, g)
    Yg = Xg - C.alt_part(n, Xg)
    rg = C.ricci(n, Yg); sg = float(np.trace(rg)); rg0 = rg - sg / n * g
    assert np.linalg.norm(rg0) < 1e-9 * np.linalg.norm(rg), "rho_0 not zero on KN(g)"
    Kg = sg * C.KN(n, g)
    beta = float(np.tensordot(Yg, Kg) / np.tensordot(Kg, Kg))
    resid_b = np.linalg.norm(Yg - beta * Kg) / np.linalg.norm(Yg)
    # --- Lambda^4 ---
    Z = rng.normal(size=(N, N)); Z = 0.5 * (Z + Z.T); Z = C.alt_part(n, Z)
    l4 = np.linalg.norm(C.weyl_project_free(n, Z)) / np.linalg.norm(Z)
    print(f"{n:3d} {alpha:14.11f} {2.0/(n-2):12.9f} {beta:16.13f} {1.0/(n*(n-1)):14.11f} {l4:10.2e}"
          f"   (fit resid {resid_a:.1e}, {resid_b:.1e})")
