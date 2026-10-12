"""r68: C4 -- validity, exactness and failure ratios of the three theta bounds."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import review_r68_core as R


def spectral_data(lam, n, tol=1e-12):
    # tol splits m from h; s, u, lam1, h3 use STRICT positivity, so that the identity
    # s = sum_{a in m} |lam_a| (tracelessness) is never broken by thresholding -- the
    # (+--) spectral estimate rests on exactly that identity.
    N = len(lam)
    neg = lam < -tol
    d = int(neg.sum())
    pos = np.sort(lam[lam > 0])[::-1]
    s = float(pos.sum()); u = float((pos**2).sum())
    v = float((lam[neg]**2).sum())
    b = float(np.max(-lam[neg])) if d else 0.0
    lam1 = float(pos[0]) if len(pos) else 0.0
    h3 = 3.0/np.sum(1.0/pos[:3]) if len(pos) >= 3 else 0.0
    cube = float(np.sum(lam**3))
    return dict(N=N, d=d, s=s, u=u, v=v, b=b, lam1=lam1, h3=h3, cube=cube, npos=len(pos))


def bounds(lam, n, tol=1e-12):
    D = spectral_data(lam, n, tol)
    N, d, cube = D['N'], D['d'], D['cube']
    ppp_mass = 0.5 * D['lam1']**3 * (n-2) * (2*N - 3*d)          # (a) on (+++)
    pmm_mass = 1.5 * D['lam1'] * D['b']**2 * (n-2) * d           # (a) on (+--)
    ppp_spec = D['h3'] * (D['s']**2 - D['u'])                    # (b) on (+++)
    pmm_spec = 3.0 * D['lam1'] * (D['s']**2 - D['v'])            # (b) on (+--)
    a = cube + ppp_mass + pmm_mass
    b_ = cube + ppp_spec + pmm_spec
    c = cube + min(ppp_spec, ppp_mass) + min(pmm_spec, pmm_mass)
    swap = cube + ppp_spec + pmm_mass                            # C6 mixed bound
    swap2 = cube + ppp_mass + pmm_spec
    out = dict(D)
    out.update(dict(a=a, b=b_, c=c, swap=swap, swap2=swap2,
                    ppp_mass=ppp_mass, pmm_mass=pmm_mass,
                    ppp_spec=ppp_spec, pmm_spec=pmm_spec))
    return out


def report(n, name, W, C):
    an = R.analyse(n, W, C)
    bd = bounds(an['lam'], n)
    th = an['theta']
    return an, bd, th


if __name__ == '__main__':
    print("=== C4: the eight recorded test points ===")
    print(f"{'n':>3} {'point':8} {'d':>4} {'theta':>12} {'(a)':>12} {'a/th':>8} {'(b)':>12} {'b/th':>8} {'(c)':>12} {'c/th':>10} {'S_mhh':>7} {'S_mmm':>8}")
    for n in [6, 8, 10, 12]:
        C = R.struct(n)
        for name, W in [('cp2', R.padded_cp2(n)), ('sphere', R.sphere_product(n, n//2))]:
            an, bd, th = report(n, name, W, C)
            print(f"{n:>3} {name:8} {an['d']:>4} {th:12.8f} {bd['a']:12.6f} {bd['a']/th:8.3f} "
                  f"{bd['b']:12.6f} {bd['b']/th:8.3f} {bd['c']:12.6f} {bd['c']/th:10.7f} "
                  f"{an['S']['mhh']:7.2f} {an['S']['mmm']:8.2e}")

    print()
    print("=== block-by-block check: are the individual block estimates valid? ===")
    print(f"{'n':>3} {'point':8} {'3B_hhh':>11} {'mass cap':>11} {'spec cap':>11} | {'3B_mmh':>11} {'mass cap':>11} {'spec cap':>11} | {'3B_mhh':>10} {'3B_mmm':>10}")
    for n in [6, 8, 10, 12]:
        C = R.struct(n)
        for name, W in [('cp2', R.padded_cp2(n)), ('sphere', R.sphere_product(n, n//2))]:
            an, bd, th = report(n, name, W, C)
            B = an['B']
            print(f"{n:>3} {name:8} {B['hhh']:11.6f} {bd['ppp_mass']:11.4f} {bd['ppp_spec']:11.6f} | "
                  f"{B['mmh']:11.6f} {bd['pmm_mass']:11.4f} {bd['pmm_spec']:11.6f} | {B['mhh']:10.6f} {B['mmm']:10.2e}")
