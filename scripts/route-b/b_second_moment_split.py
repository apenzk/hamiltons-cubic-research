"""Sub-step (iii): the UNSUMMED second moment across the m/h split, measured.

Fence post 18 killed the summed form.  What survives is Petersen-Wink Prop 1.7 one
generator at a time,

    g_delta := || [ad(v_delta), W] ||^2  =  sum_{a,b} (lam_a - lam_b)^2 T_{delta a b} ,

whose weight (lam_a - lam_b)^2 is LARGEST exactly on the (m,h) pairs, which is where
the harm is: writing m for the negative eigenspace and h for its complement,

    theta = sum lam^3 + 1/2 [ U_mmm + 3 U_mmh + 3 U_mhh + U_hhh ],
    U_XYZ := sum_{a in X, b in Y, c in Z} T_{abc} lam_a lam_b lam_c ,

with U_mmm = 0 under S = 0, U_mhh <= 0, and U_mmh >= 0, U_hhh >= 0 the two enemies.
Summing g over delta in m gives an identity in which S = 0 removes the m x m block
outright, because sum_{delta in m} T_{delta a b} = || P_m [v_a, v_b] ||^2.

WHAT THIS SCRIPT MEASURES -- Gate 1 falsification, not a search.
  (a) the cubic split identity for theta, as a screen on the bookkeeping;
  (b) the profile of g_delta: its mean 8/n forced by the Casimir, its value on m,
      and whether m carries an anomalous share;
  (c) the crude bound U_mmh <= sum_{delta in m} |lam_delta| that AM-GM gives from
      g_delta <= 8, against the true U_mmh -- how much room the route has to lose.

FALSIFIER for the route: g_delta on m sits at the dimension-free ceiling 8 at the
catalogued points, so the per-generator identity carries no more than the marginals.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, structure_constants, sphere_product_W
from weyl_screen import theta_screened

np.set_printoptions(precision=6, suppress=True)


def phis(n):
    pairs, idx = pair_index(n)
    P = np.zeros((len(pairs), n, n))
    for a, (i, j) in enumerate(pairs):
        P[a, i, j] = 1.0; P[a, j, i] = -1.0
    return P


def analyse(n, W, label, tol=1e-9):
    W = W / np.sqrt(np.sum(W * W))
    th, info = theta_screened(n, W)
    lam, V = np.linalg.eigh(W)
    P = phis(n)
    v = np.einsum('ag,gij->aij', V.T, P)                       # eigenvectors as matrices
    # c'[a,b,c] = <[v_a,v_b],v_c>,  T = c'^2
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    c = 0.5 * np.einsum('abij,cij->abc', br, v)
    T = c ** 2
    m = lam < -tol
    h = ~m
    d = int(m.sum())

    def U(X, Y, Z):
        return float(np.einsum('abc,a,b,c->', T[np.ix_(X, Y, Z)],
                               lam[X], lam[Y], lam[Z]))
    Ummm, Ummh, Umhh, Uhhh = U(m, m, m), U(m, m, h), U(m, h, h), U(h, h, h)
    cub = float(np.sum(lam ** 3)) + 0.5 * (Ummm + 3*Ummh + 3*Umhh + Uhhh)

    # g_delta in the eigenbasis: g[d] = sum_{a,b} (lam_a-lam_b)^2 T[d,a,b]
    gap2 = (lam[:, None] - lam[None, :]) ** 2
    g = np.einsum('dab,ab->d', T, gap2)

    bound = float(np.abs(lam[m]).sum())        # AM-GM + g <= 8  =>  U_mmh <= this
    print(f"\n--- {label}  (n={n}, d=dim m={d}) ---")
    print(f"  theta={th:.6f}  is_weyl={info['is_weyl']}  cubic split residual={abs(cub-th):.2e}")
    print(f"  S = U_mmm-slack: sum_mmm T = {float(T[np.ix_(m,m,m)].sum()):.3e}   U_mmm={Ummm:.3e}")
    print(f"  U_mmh={Ummh:+.6f}  U_mhh={Umhh:+.6f}  U_hhh={Uhhh:+.6f}  sum lam^3={np.sum(lam**3):+.6f}")
    print(f"  g: mean={g.mean():.6f} (Casimir forces 8/n={8/n:.6f})  max_all={g.max():.6f}"
          f"  max_on_m={g[m].max() if d else float('nan'):.6f}  ceiling=8")
    print(f"  sum_{{m}} g = {g[m].sum():.6f}   of total {g.sum():.6f} = 4(n-1)={4*(n-1)}")
    print(f"  crude bound U_mmh <= sum_m |lam| = {bound:.6f}   actual {Ummh:.6f}"
          f"   slack factor {bound/Ummh if Ummh>1e-12 else float('inf'):.1f}x")
    return dict(label=label, n=n, d=d, theta=th, Ummh=Ummh, gmax_m=g[m].max() if d else 0.0)


def main():
    rows = []
    for blocks, lbl in (([6, 6], "S^6 x S^6  (balanced, theta_0(12))"),
                        ([3, 3], "S^3 x S^3"),
                        ([4, 8], "S^4 x S^8"),
                        ([5, 7], "S^5 x S^7")):
        n = sum(blocks)
        W, _ = sphere_product_W(blocks)
        rows.append(analyse(n, W, lbl))

    print("\n=== verdict on the per-generator identity ===")
    for r in rows:
        room = 8.0 / r['gmax_m'] if r['gmax_m'] > 0 else float('inf')
        print(f"  {r['label']:34s}  d={r['d']:3d}  max g on m = {r['gmax_m']:.4f}"
              f"   ceiling/actual = {room:8.1f}x")
    print("\n  A large ceiling/actual ratio means the dimension-free bound g <= 8 is")
    print("  nowhere near tight at the catalogued points, so a bound built on it")
    print("  cannot reach theta_0 -- the route needs the identity, not the ceiling.")


if __name__ == '__main__':
    main()
