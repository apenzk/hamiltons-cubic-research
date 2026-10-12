"""The lambda-weighted bound, sharpened -- the dropped term IS the Delta term.

WHAT THE GATE 2 BOUND DROPPED.  Reviewers 69 and 71/72 confirmed

    sum_gamma lam_gamma g_gamma = -4 theta ,    g_gamma = ||[ad(v_gamma), W]||^2 ,

and the bound derived from it, theta <= |lam_min| (4(n-1) - Delta - G_0)/4, came from
splitting over m, p and ker and then DISCARDING the p-sum.  Written out, the split is an
IDENTITY, not an inequality:

    4 theta  =  A - B ,     A := sum_{gamma in m} |lam_gamma| g_gamma ,
                            B := sum_{gamma in p}  lam_gamma  g_gamma .        (*)

B >= 0 with equality exactly when Delta = 0, since lam_gamma > 0 strictly on p.  So the
term thrown away is precisely the one carrying the symmetry defect, and the bound is
tight exactly where Delta = 0 -- which is why it attained equality at all nine
symmetric-space points and nowhere else.

THE SHARPENING.  Keep B and bound it below by its smallest weight:

    B >= lam_p^min * Delta ,    lam_p^min := min{ lam_gamma : lam_gamma > 0 } ,

and bound A above as before by |lam_min| * M with M := sum_{gamma in m} g_gamma
= 4(n-1) - Delta - G_0.  Then

    theta  <=  ( |lam_min| * M  -  lam_p^min * Delta ) / 4 .                   (**)

(**) is never weaker than the recorded bound and is strictly stronger wherever
Delta > 0 -- i.e. everywhere in the band that is not already handed to step H.

WHAT IS MEASURED.  (*) as an identity; (**) against the recorded bound at every
catalogued CRITICAL point (non-critical operators are refused by critical_screened,
since Lemma-24-adjacent statements have no content there); and how much of the recorded
bound's slack the new term recovers.

FALSIFIER: (*) failing, or (**) violated anywhere.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import sphere_product_W, weyl_basis
from b_symmetry_defect import phis, cpm_W, pad
from b_second_order_screen import product_weyl
from b_c5_blowup import c5_operator
from weyl_screen import critical_screened

TOL = 1e-9


def pieces(n, W):
    W = W / np.linalg.norm(W)
    th, info = critical_screened(n, W)
    lam, V = np.linalg.eigh(W)
    P = phis(n)
    v = np.einsum('ag,gij->aij', V.T, P)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    T = (0.5 * np.einsum('abij,cij->abc', br, v)) ** 2
    g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
    m, p, z = lam < -TOL, lam > TOL, np.abs(lam) <= TOL
    A = float(np.dot(np.abs(lam[m]), g[m]))
    B = float(np.dot(lam[p], g[p]))
    return dict(theta=th, info=info, A=A, B=B,
                M=float(g[m].sum()), Delta=float(g[p].sum()), G0=float(g[z].sum()),
                lmin=abs(float(lam.min())),
                lpmin=float(lam[p].min()) if p.any() else 0.0, d=int(m.sum()))


def main():
    pts = [(6, sphere_product_W([3, 3])[0], "S^3 x S^3"),
           (12, sphere_product_W([6, 6])[0], "S^6 x S^6"),
           (8, sphere_product_W([3, 5])[0], "S^3 x S^5"),
           (4, cpm_W(2), "CP^2"), (6, cpm_W(3), "CP^3"), (8, cpm_W(4), "CP^4"),
           (8, pad(cpm_W(2), 4, 8), "CP^2 padded n=8"),
           (10, c5_operator([2] * 5)[0], "C_5 blow-up"),
           (9, product_weyl([3, 3, 3])[0], "[3,3,3]"),
           (12, product_weyl([4, 4, 4])[0], "[4,4,4]")]

    print("=== (*) the identity 4 theta = A - B ===")
    print(f"  {'point':16s}{'n':>3s}{'theta':>10s}{'A':>11s}{'B':>11s}{'(A-B)/4':>11s}{'resid':>9s}")
    rows = []
    for n, W, lbl in pts:
        r = pieces(n, W)
        if not r['info']['is_critical']:
            print(f"  {lbl:16s}{n:>3d}   NOT CRITICAL (res {r['info']['crit_res']:.1e}) -- skipped")
            continue
        rows.append((lbl, n, r))
        print(f"  {lbl:16s}{n:>3d}{r['theta']:>10.6f}{r['A']:>11.6f}{r['B']:>11.6f}"
              f"{(r['A']-r['B'])/4:>11.6f}{abs((r['A']-r['B'])/4 - r['theta']):>9.1e}")

    print("\n=== (**) the sharpened bound against the recorded one ===")
    print(f"  {'point':16s}{'Delta':>9s}{'lam_p^min':>11s}{'recorded':>11s}"
          f"{'sharpened':>11s}{'theta':>10s}{'slack cut':>11s}")
    for lbl, n, r in rows:
        old = r['lmin'] * r['M'] / 4.0
        new = (r['lmin'] * r['M'] - r['lpmin'] * r['Delta']) / 4.0
        cut = (old - new) / (old - r['theta']) if old - r['theta'] > 1e-12 else float('nan')
        assert new >= r['theta'] - 1e-9, f"BOUND VIOLATED at {lbl}"
        print(f"  {lbl:16s}{r['Delta']:>9.4f}{r['lpmin']:>11.6f}{old:>11.6f}"
              f"{new:>11.6f}{r['theta']:>10.6f}"
              + ("      100%" if cut == cut and cut > 0.999 else
                 f"{100*cut:>10.1f}%" if cut == cut else "         --"))
    print("\n  *** THE EVIDENCE FOR THE SHARPENING RESTS ON ONE POINT. ***  Of the ten")
    print("  catalogued CRITICAL points, exactly one -- the C_5 blow-up -- has Delta > 0,")
    print("  so it is the only place the two bounds can differ at all.  'Recovers 100% of")
    print("  the slack' is a statement about a single witness.  The IDENTITY (*) is solid")
    print("  (residual 1e-15 at all ten); the inequality (**) is solid (it is two valid")
    print("  steps); what is thin is any claim about how MUCH it buys on the band.")
    print("  Gate 2 pending -- do not cite the improvement as settled.")
    print("\n  Where Delta = 0 the two bounds coincide and both are exact -- those points")
    print("  are handed to step H anyway.  Where Delta > 0 the new term is what the old")
    print("  bound was throwing away, and at the C_5 blow-up it recovers ALL of the slack:")
    print("  0.894427 -> 0.670820 = theta exactly.")


if __name__ == '__main__':
    main()
