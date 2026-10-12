"""The Rayleigh matrix M: its exact entries, and what the frame contributes.

FOUR IDENTITIES, EACH PROVED RATHER THAN FITTED.  In an eigenbasis {v_a} of W with
Wv_a = lam_a v_a, write b_ab = [v_a, v_b] and M_ab = delta_ab lam_a + 1/2 sum_g
c'^2_abg lam_g.  Expanding sum_g <b_ab, v_g>^2 lam_g = <W b_ab, b_ab> gives

  (1)  M_ab = 1/2 <W [v_a,v_b], [v_a,v_b]>  off the diagonal,
  (2)  M_aa = lam_a EXACTLY, since [v,v] = 0 -- so diag M is the spectrum itself,
  (3)  tr M = tr W = 0, so M is trace-free and lam_max(M) >= 0,
  (4)  sum_b M_ab = lam_a - 1/2 tr(W ad(v_a)^2), from sum_b b_ab (x) b_ab =
       -ad(v_a)^2,

and <lambda, M lambda> = P, with M lambda = theta lambda at a critical point.
Screened below at 1e-16.

THE FENCE POST THAT CLOSES THE OBVIOUS ROUTE.  M depends on W only through the
pair (lambda, T) with T_abg = c'^2_abg.  The recorded bracket-transportation LP
carries every constraint T is known to satisfy -- row marginal 2(n-2), pair cap 2,
tr(W#) = -1 -- and still attains 1.6059 at n = 6 against theta_0(6) = 1.0541.
Since lam_max(M) >= <lambda, M lambda> at unit lambda, that LP optimum is a
feasible point where lam_max(M) exceeds theta_0 by 52%.  So NO argument bounding
lam_max(M) from T's marginals can prove lam_max(M) <= theta_0(n).  Frame
realizability has to enter.

WHERE THE FRAME ENTERS, AND A CORRECTION IT FORCES.  Boehm-Wilking define curvature
operators as the Bianchi subspace S^2_B and state that R^2 + R^# preserves it --
THE SUM.  R^# alone does not, so "Q(W) = theta W is Bianchi, hence b(W^2) = 0" is
false.  What is true is the cancellation

  (5)  b(W^#) = - b(W^2) = - sum_a lam_a^2 (v_a ^ v_a)   for every curvature operator,

with both sides genuinely nonzero: 0.962 at CP^3, 0.953 at CP^4.  That is a
relation between lambda and the frame which no marginal of T can see, so it is the
handle the fence post says is missing.

WHAT M ACTUALLY IS.  Let X = sum_a x_a v_a (x) v_a be the symmetric operator with
W's eigenframe and eigenvalues x.  Boehm-Wilking's formula (4) evaluated on that
frame gives X^# = 1/2 sum_ab x_a x_b b_ab (x) b_ab, so

    <x, M x> = <W, X^2 + X^#> = <W o X, X> = <L_W X, X>,

and therefore

    lam_max(M) = max { <L_W X, X> : ||X|| = 1, X diagonal in the eigenframe },

the top eigenvalue of L_W on a maximal abelian subspace of W's commutant.  This is
the operator the programme already computes: at the C_5 blow-up the ratio
lam_max(M)/theta is 1.206011, matching the recorded lam_max(L_e | W-perp) there to
seven digits.

AND THAT SETTLES WHAT THE ROUTE IS WORTH.  Lemma 24 -- the extremal spectral bound
sigma(L_c | c-perp) subset (-inf, 1/2] with 1 simple -- says that at a GLOBAL
MAXIMISER every eigenvalue off W is at most 1/2, so lam_max(L_e | diagonal) = 1 and

    lam_max(M) = theta   exactly, at every global maximiser.

The Rayleigh bound is therefore tight where it matters and slack elsewhere: proving
sup_W lam_max(M) <= theta_0 is STRICTLY STRONGER than Conjecture A, since the C_5
blow-up has ratio 1.206 while its theta is far below theta_0.  The equivalent
target is the pointwise one at maximisers, and it is Conjecture A rewritten.

A DEGENERATE CASE THAT WOULD HAVE CONFIRMED THE FALSE VERSION.  At S^3 x S^3 both
b(W^2) and b(W^#) vanish outright.  A screen run only there returns 0.000 twice and
reads as confirmation of b(W^2) = 0.  The sample has to vary in the feature.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import adj, normalize, sharp, Q
from b_bianchi_constraint import wedge_map
from b_apriori_bound import rows, theta


def rayleigh_matrix(n, W, c=None):
    """M, its spectrum lambda, and the eigenframe."""
    c = adj(n) if c is None else c
    lam, V = np.linalg.eigh(W)
    T = np.einsum('abg,ap,bq,gr->pqr', c, V, V, V, optimize=True) ** 2
    return np.diag(lam) + 0.5 * np.einsum('pqr,r->pq', T, lam), lam, V


def row_sums_via_ad(n, W, lam, V, c=None):
    """(4): sum_b M_ab = lam_a - 1/2 tr(W ad(v_a)^2)."""
    c = adj(n) if c is None else c
    ad_v = np.einsum('abg,ap->pbg', c, V)
    return np.array([lam[p] - 0.5 * np.trace(W @ (ad_v[p] @ ad_v[p]))
                     for p in range(c.shape[0])])


def L_W_on_eigenframe(n, W, V, c=None):
    """L_W restricted to operators diagonal in W's eigenframe."""
    from review_r30_core import circ
    c = adj(n) if c is None else c
    N = c.shape[0]
    L = np.zeros((N, N))
    for p in range(N):
        C = circ(n, W, np.outer(V[:, p], V[:, p]))
        for q in range(N):
            L[q, p] = float(V[:, q] @ C @ V[:, q])
    return 0.5 * (L + L.T)


def bianchi_defect(T4, X):
    return float(np.linalg.norm(np.einsum('qab,ab->q', T4, X)))


if __name__ == "__main__":
    print("=== identities (1)-(4), and the Bianchi cancellation (5) ===")
    print(f"{'point':16s} {'n':>3s} {'|diagM-lam|':>12s} {'|tr M|':>8s} "
          f"{'|rowsum err|':>12s} {'|<l,Ml>-P|':>11s}")
    for nm, n, W in rows():
        if n > 8:
            continue
        W = normalize(W); c = adj(n)
        M, lam, V = rayleigh_matrix(n, W, c)
        rs = row_sums_via_ad(n, W, lam, V, c)
        print(f"{nm:16s} {n:3d} {np.abs(np.diag(M)-lam).max():12.1e} "
              f"{abs(M.trace()):8.1e} {np.abs(M.sum(1)-rs).max():12.1e} "
              f"{abs(lam @ M @ lam - theta(n, W)):11.1e}")
    print("\n=== lam_max(M) = lam_max of L_W on the eigenframe diagonal ===")
    print(f"{'point':16s} {'n':>3s} {'lam_max(M)':>11s} {'lam_max(L_W|D)':>15s} "
          f"{'theta':>9s} {'ratio':>9s}")
    for nm, n, W in rows():
        if n > 10:
            continue
        W = normalize(W); c = adj(n)
        M, lam, V = rayleigh_matrix(n, W, c)
        L = L_W_on_eigenframe(n, W, V, c)
        lm = float(np.linalg.eigvalsh(M).max()); th = theta(n, W)
        print(f"{nm:16s} {n:3d} {lm:11.6f} "
              f"{float(np.linalg.eigvalsh(L).max()):15.6f} {th:9.6f} {lm/th:9.6f}")

    print(f"\n{'point':16s} {'n':>3s} {'b(W)':>9s} {'b(W^2)':>9s} {'b(W^#)':>9s} "
          f"{'b(Q(W))':>9s}   reading")
    for nm, n, W in rows():
        if n > 8:
            continue
        W = normalize(W); T4 = wedge_map(n)
        b2, bs = bianchi_defect(T4, W @ W), bianchi_defect(T4, sharp(n, W))
        note = ("degenerate: would confirm the false b(W^2)=0" if b2 < 1e-9
                else "b(W^#) = -b(W^2), both nonzero")
        print(f"{nm:16s} {n:3d} {bianchi_defect(T4, W):9.1e} {b2:9.3f} {bs:9.3f} "
              f"{bianchi_defect(T4, Q(n, W)):9.1e}   {note}")
