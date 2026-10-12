"""Reviewer 17: structure of the second-order obstruction at both points.

(1) su(3) Kahler: is Phi(v) = |v|^2 u for one fixed u in K?  If so the obstruction
    is nonvanishing on all of T for a structural reason, not just at 5 basis
    vectors.
(2) does the orbit part of Pi_ker matter?  Recompute the obstruction with the
    projection restricted to the TRANSVERSE part of the kernel and see whether
    any verdict flips.
"""
import numpy as np
from curvature_operator import Lambda2
from review_r11_graded_law import weyl_sphere_product_mop
from run_defect_max_hunt import su_m_kahler_weyl
from review_r17_obstruction import Ctx, analyse, Qbil


def main():
    ctx = Ctx(6)
    L2 = Lambda2(6)
    for name, Wm in [("S^3 x S^3", weyl_sphere_product_mop(L2, 3, 3)),
                     ("su(3) Kahler", su_m_kahler_weyl(L2, 3))]:
        st = analyse(name, ctx, Wm)
        W, th, w, B, ker, T, Ob = (st[k] for k in ("W", "th", "w", "B", "ker", "T", "Ob"))
        Kd, Od, Td = B @ ker, B @ Ob, B @ T
        m = T.shape[1]
        mats = [ctx.mat(Td[:, a]) for a in range(m)]
        C = np.zeros((ker.shape[1], m, m))
        for i in range(m):
            for j in range(i, m):
                y = Kd.T @ ctx.coord(Qbil(mats[i], mats[j], ctx.c))
                C[:, i, j] = C[:, j, i] = y
        print(f"\n##### {name} #####")
        # is C[:,i,j] = u delta_ij ?
        u = C[:, 0, 0]
        dev = 0.0
        for i in range(m):
            for j in range(m):
                tgt = u if i == j else np.zeros_like(u)
                dev = max(dev, np.linalg.norm(C[:, i, j] - tgt))
        print(f"  Phi(v) = |v|^2 u ?   max deviation over all (i,j) = {dev:.3e}   |u| = {np.linalg.norm(u):.6f}")
        if dev < 1e-9:
            uD = Kd @ u
            print(f"    -> YES.  u splits as |orbit part| = {np.linalg.norm(Od.T @ uD):.6f},"
                  f"  |transverse part| = {np.linalg.norm(Td.T @ uD):.6f}")
            print(f"    -> the obstruction is |v|^2 |u| = {np.linalg.norm(u):.6f} for EVERY v, so it "
                  f"cannot vanish: no branch, for all of T at once.")
        # (2) does dropping the orbit part of the projection change anything?
        rng = np.random.default_rng(4)
        full, tro, orb = [], [], []
        for _ in range(400):
            a = rng.standard_normal(m); a /= np.linalg.norm(a)
            y = np.einsum('kij,i,j->k', C, a, a)
            yD = Kd @ y
            full.append(np.linalg.norm(yD))
            tro.append(np.linalg.norm(Td.T @ yD))
            orb.append(np.linalg.norm(Od.T @ yD))
        print(f"  over 400 random unit v in T:  |Pi_K Q(v)| in [{min(full):.4f},{max(full):.4f}]"
              f"   transverse part [{min(tro):.4f},{max(tro):.4f}]"
              f"   orbit part [{min(orb):.2e},{max(orb):.2e}]")
        print("    -> restricting Pi to the transverse part changes nothing: the obstruction has no"
              " orbit component at all." if max(orb) < 1e-9 else
              "    -> the obstruction DOES have an orbit component; restricting Pi would change the numbers.")




def quartic_check():
    """Is |Phi(v)|^2 exactly c |v|^4 on T?  Compare the fully symmetrised quartic
    coefficient tensor with c * Sym(delta (x) delta)."""
    ctx = Ctx(6)
    L2 = Lambda2(6)
    for name, Wm in [("S^3 x S^3", weyl_sphere_product_mop(L2, 3, 3)),
                     ("su(3) Kahler", su_m_kahler_weyl(L2, 3))]:
        st = analyse(name, ctx, Wm)
        B, ker, T = st["B"], st["ker"], st["T"]
        Kd, Td = B @ ker, B @ T
        m = T.shape[1]
        mats = [ctx.mat(Td[:, a]) for a in range(m)]
        C = np.zeros((ker.shape[1], m, m))
        for i in range(m):
            for j in range(i, m):
                y = Kd.T @ ctx.coord(Qbil(mats[i], mats[j], ctx.c))
                C[:, i, j] = C[:, j, i] = y
        Qt = np.einsum('kij,klm->ijlm', C, C)
        S = (Qt + np.einsum('ijlm->iljm', Qt) + np.einsum('ijlm->imjl', Qt)) / 3.0
        S = (S + np.einsum('ijlm->jilm', S) + np.einsum('ijlm->ijml', S) + np.einsum('ijlm->jiml', S)) / 4.0
        I = np.eye(m)
        base = (np.einsum('ij,lm->ijlm', I, I) + np.einsum('il,jm->ijlm', I, I)
                + np.einsum('im,jl->ijlm', I, I)) / 3.0
        cbest = float(np.sum(S * base) / np.sum(base * base))
        print(f"\n  {name}: |Phi(v)|^2 vs c|v|^4 -- c = {cbest:.9f}, sqrt(c) = {np.sqrt(max(cbest,0)):.9f}, "
              f"residual |S - c*base| = {np.linalg.norm(S - cbest*base):.3e}  (|S| = {np.linalg.norm(S):.3e})")
        for r in [(2,9),(4,9),(3,7),(9,20),(1,2),(4,45),(10,9),(2,5)]:
            if abs(cbest - r[0]/r[1]) < 1e-9:
                print(f"      c = {r[0]}/{r[1]} exactly")


if __name__ == "__main__":
    quartic_check()
