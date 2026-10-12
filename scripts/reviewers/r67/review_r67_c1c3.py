"""Reviewer 67 -- C1 (marginal identities), C2 (gamma = 2 S_mhh), C3 (refuted monotonicity)."""
import numpy as np
from review_r67_core import *

np.set_printoptions(precision=10, suppress=True)

def report(n, name, W, om):
    N = W.shape[0]
    lam, V, T = spectrum_data(W, om)
    th = theta_from(lam, T)
    Smmm, Smmh, Smhh, Shhh = block_sums(lam, T)
    st = spectral_stats(lam)
    d = st['d']
    # row marginal + pair cap
    rows = T.sum(axis=(1, 2))
    prs = T.sum(axis=2)
    id1 = 6*Smmm + 4*Smmh + 2*Smhh - 2*d*(n-2)
    id2 = 6*Shhh + 4*Smhh + 2*Smmh - 2*(N-d)*(n-2)
    # C2
    negi = np.where(lam < -1e-9)[0]
    mu = float(T[np.ix_(negi, negi)].sum())          # sum_{a,b in m} ||[e_a,e_b]||^2
    X = float(T[negi].sum()) - mu
    gamma = 2*(n-2)*d - 2*mu
    print(f"n={n:3d} {name:22s} N={N:3d} d={d:3d} theta={th:.10f}")
    print(f"    S = ({Smmm:.10g}, {Smmh:.10g}, {Smhh:.10g}, {Shhh:.10g})")
    print(f"    row marginal max dev from 2(n-2)={2*(n-2)}: {np.abs(rows-2*(n-2)).max():.3e}")
    print(f"    pair cap max sum_g T_abg = {prs.max():.10f}  (cap 2)")
    print(f"    identity1 resid {id1:.3e}   identity2 resid {id2:.3e}")
    print(f"    C2: mu={mu:.10g} 2S_mmh={2*Smmh:.10g} | X={X:.10g} 2S_mmh+2S_mhh={2*Smmh+2*Smhh:.10g}"
          f" | mu+X={mu+X:.10g} 2(n-2)d={2*(n-2)*d} | gamma={gamma:.10g} 2S_mhh={2*Smhh:.10g}")
    ppp, ppm, pmm, mmm = sign_blocks(lam, T)
    print(f"    blocks x3: (+++)={ppp:.10g} (++-)={ppm:.10g} (+--)={pmm:.10g} (---)={mmm:.10g}"
          f" | sum lam^3={st['cube']:.10g}  total={st['cube']+ppp+ppm+pmm+mmm:.10f}")
    return dict(n=n, name=name, N=N, d=d, theta=th, S=(Smmm,Smmh,Smhh,Shhh), lam=lam,
                blocks=(ppp,ppm,pmm,mmm), gamma=gamma, mu=mu, X=X)

if __name__ == "__main__":
    import sys
    res = []
    for n in [6, 8, 10, 12]:
        om = omega_tensor(n)
        res.append(report(n, "padded W_CP2", padded_cp2(n), om))
        res.append(report(n, "balanced sphere prod", balanced_sphere_product(n), om))
        print(f"    theta0({n}) = {theta0(n):.10f}   sqrt(3/2) = {np.sqrt(1.5):.10f}")
        print()
    print("=== C3 table ===")
    print(f"{'n':>3} {'point':22s} {'d':>4} {'S_mmm':>10} {'S_mhh':>10} {'theta':>12}")
    for r in res:
        print(f"{r['n']:>3} {r['name']:22s} {r['d']:>4} {r['S'][0]:>10.3e} {r['S'][2]:>10.4f} {r['theta']:>12.7f}")
