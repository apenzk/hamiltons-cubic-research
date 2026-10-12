"""The SYMMETRY DEFECT: what the unsummed second moment sees that the marginals cannot.

Fence post 18 killed the summed form of Petersen-Wink Prop 1.7.  The unsummed form,

    g_delta := || [ad(v_delta), W] ||^2  =  sum_{a,b} (lam_a - lam_b)^2 T_{delta a b} ,

is a quadratic form in delta, so its trace over any subspace is basis-independent.
Take the trace over p := span{v_a : lam_a > 0}, the STRICTLY positive eigenspace:

    Delta(W) := sum_{delta in p} g_delta   >= 0 ,   bounded by 4(n-1), the Casimir
                value of fence post 18.

WHY STRICTLY POSITIVE.  Using {lam >= 0} makes Delta a function of the EMBEDDING
rather than of W: zero-padding W from n0 into n adds ker directions that are not
symmetries, and Delta then grows linearly in n -- 8, 16, 24, 32 for CP^2 padded to
n = 6, 8, 10, 12, at fixed theta = sqrt(3/2).  Under {lam > 0} every padded point
returns 0, as an artefact of the embedding must.

WHAT DELTA MEANS.  x |-> [ad(x), W] is linear and g is its squared norm, so

    Delta(W) = 0   <=>   [ad(x), W] = 0 for every x in p
               <=>   p is contained in the isotropy algebra k(W) = {x : [ad x, W] = 0},

i.e. every POSITIVE eigenvector of W is an infinitesimal symmetry of W.  This is a
statement about the eigenvectors as elements of so(n) -- it is invisible to any bound
built from the spectrum together with the marginals and pair caps of T, which is the
class Reviewers 67/68 proved has a ceiling of 1.60/2.29/2.49 at n = 6, 8, 12.

THE CONSEQUENCE, and it is why Delta is worth having.  If Delta(W) = 0 then ad(x)
commutes with W for every x in p, so ad(x) preserves every eigenspace of W, hence
preserves p and m.  Therefore

    [p, p] contained in p   and   [p, m] contained in m .

Adding S := S_mmm = 0, which says exactly [m, m] perp m, gives the third relation
[m, m] contained in p PROVIDED ker W = 0, so so(n) = p + m is a Z_2-GRADING and W is
graded.  Step H of the route already handles graded critical points.  So on the target
set {S = 0} AND WITH TRIVIAL KERNEL,

    Delta(W) = 0   ==>   W is graded,

and the band's open question becomes: does theta > sqrt(3/2) force Delta(W) = 0?

** ker W = 0 IS LOAD-BEARING AND WAS OMITTED HERE.  Gate 2, both reviewers. **
It is used twice: for so(n) = p + m to exhaust so(n) at all, and to upgrade
[m,m] perp m into [m,m] contained in p.  Without it what survives is only
"p + m is a Z_2-graded SUBALGEBRA".  Witness: padded W_CP^2 at n = 8 has Delta = 0,
S_mmm = 0 and all three relations on p + m, yet [z,z] -> m = 16 with z = ker W,
and so(8) is not Z_2-graded.  The `graded?` column printed by main() tests only
S_mmm and S_mpp, so it says YES there and at padded S^3 x S^3; READ IT TOGETHER WITH
THE #0 COLUMN, and treat #0 > 0 as "graded subalgebra", not "graded".

** AND THE CONSEQUENCE EXCLUDES CP^2 ITSELF. **  W_CP^2 at n = 4 is self-dual with a
3-dimensional kernel (dim p = 1, dim m = 2), so the point that sets the sqrt(3/2)
threshold is outside the hypothesis.  Relatedly, the claim below that dim p equals the
isotropy dimension "at each of them" is FALSE at CP^2, where dim p = 1 while
dim k(W) = dim u(2) = 4 -- the printed table shows it.

WHAT IS MEASURED HERE.
  (a) Delta = 0 at every catalogued high-theta point: the four sphere products and
      CP^m for m = 2, 3, 4.  At each of them dim h is exactly the dimension of the
      isotropy algebra -- so(p)+so(q) and u(m) respectively -- so h IS k(W) and m is
      its orthogonal complement, the tangent space of the symmetric space.
  (b) Delta > 0, at exact integer values, at critical points that are not symmetric
      spaces: 12 at the C_5 blow-up (theta = 0.6708, S = 0, n = 10, NO zero
      eigenvalues, which is why it survives the convention fix).  The padded points
      return 0 under the {lam > 0} convention used here; the "8 at padded S^3 x S^3"
      once written on this line was the old {lam >= 0} number and is deleted.
  (c) Delta ~ 0.5 * 4(n-1) at random Weyl tensors.

SO CRITICALITY DOES NOT FORCE Delta = 0 -- (b) is the falsification that settles it,
and it is what makes Delta a discriminator rather than an identity.

FALSIFIER for using Delta: a catalogued point with theta >= theta_0(n) and Delta > 0,
or a point in the band 3 <= dim m < floor(n^2/4) with Delta = 0 and theta > sqrt(3/2).
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, sphere_product_W
from weyl_screen import theta_screened
from b_c5_blowup import c5_operator

np.set_printoptions(precision=6, suppress=True)
TOL = 1e-9


def phis(n):
    pairs, _ = pair_index(n)
    P = np.zeros((len(pairs), n, n))
    for a, (i, j) in enumerate(pairs):
        P[a, i, j] = 1.0; P[a, j, i] = -1.0
    return P


def defect(n, W, tol=TOL):
    """(theta, is_weyl, d, Delta, total, S_mmm, S_mpp, n_zero).

    Delta traces g over the STRICTLY positive eigenspace; see the header.
    S_mpp is the second grading condition, <[p,p],m>^2 summed."""
    W = W / np.sqrt(np.sum(W * W))
    th, info = theta_screened(n, W)
    lam, V = np.linalg.eigh(W)
    P = phis(n)
    v = np.einsum('ag,gij->aij', V.T, P)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    T = (0.5 * np.einsum('abij,cij->abc', br, v)) ** 2
    g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
    m, p = lam < -tol, lam > tol
    return (th, info['is_weyl'], int(m.sum()), float(g[p].sum()), float(g.sum()),
            float(T[np.ix_(m, m, m)].sum()), float(T[np.ix_(m, p, p)].sum()),
            int((np.abs(lam) <= tol).sum()))


def cpm_W(m):
    """Weyl part of the Fubini-Study curvature operator on CP^m, n = 2m."""
    from review_r30_core import pair_index
    n = 2 * m
    J = np.zeros((n, n))
    for t in range(m):
        J[2*t, 2*t+1] = 1.0; J[2*t+1, 2*t] = -1.0
    d = np.eye(n)
    Tn = (np.einsum('ik,jl->ijkl', d, d) - np.einsum('il,jk->ijkl', d, d)
          + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
          + 2.0 * np.einsum('ij,kl->ijkl', J, J))
    p, _ = pair_index(n)
    R = np.array([[Tn[i, j, k, l] for (k, l) in p] for (i, j) in p])
    N = len(p)
    Ric = np.zeros((n, n))
    for i in range(n):
        for j in range(n):
            Ric[i, j] = sum(Tn[i, k, j, k] for k in range(n))
    scal = np.trace(Ric)
    # subtract the constant-curvature part: for CP^m the Ricci is Einstein, so the
    # scalar term alone removes it
    W = R - (scal / (n * (n - 1))) * np.eye(N)
    return W / np.linalg.norm(W)


def pad(W0, n0, n):
    p0, _ = pair_index(n0)
    p1, i1 = pair_index(n)
    W = np.zeros((len(p1), len(p1)))
    for a, (i, j) in enumerate(p0):
        for b, (k, l) in enumerate(p0):
            W[i1[(i, j)], i1[(k, l)]] = W0[a, b]
    return W


def main():
    rows = []
    for blocks in ([6, 6], [5, 7], [4, 8], [3, 3]):
        rows.append((sum(blocks), sphere_product_W(blocks)[0],
                     f"S^{blocks[0]} x S^{blocks[1]}",
                     sum(b * (b - 1) // 2 for b in blocks)))
    for m in (2, 3, 4):
        rows.append((2 * m, cpm_W(m), f"CP^{m}", m * m))
    rows.append((8, pad(cpm_W(2), 4, 8), "CP^2 padded n=8", None))
    rows.append((8, pad(sphere_product_W([3, 3])[0], 6, 8), "S^3xS^3 padded n=8", None))
    rows.append((10, c5_operator([2] * 5)[0], "C_5 blow-up n=10", None))

    print("=== Delta over the STRICTLY positive eigenspace, and what it implies ===")
    print(f"  {'point':22s}{'n':>3s}{'theta':>10s}{'d':>4s}{'#0':>4s}{'dim p':>7s}"
          f"{'iso':>5s}{'S_mmm':>9s}{'Delta':>9s}{'S_mpp':>9s}{'4(n-1)':>8s}  graded?")
    for n, W, lbl, iso in rows:
        th, ok, d, D, tot, Smmm, Smpp, z = defect(n, W)
        N = n * (n - 1) // 2
        graded = Smmm < 1e-8 and Smpp < 1e-8
        print(f"  {lbl:22s}{n:>3d}{th:>10.6f}{d:>4d}{z:>4d}{N-d-z:>7d}"
              f"{(iso if iso is not None else -1):>5d}{Smmm:>9.1e}{D:>9.4f}"
              f"{Smpp:>9.4f}{tot:>8.1f}  {'YES' if graded else 'no'}")
    print("  (iso = -1 where the padded point has no single isotropy dimension to quote)")

    print("\n=== the falsification: criticality does not force Delta = 0 ===")
    print("  The C_5 blow-up is a genuine Weyl_10 critical point with S_mmm = 0 and NO")
    print("  zero eigenvalues, at theta = 0.670820, and it carries Delta = 12 of 36.")
    print("  Padded points return Delta = 0 under this convention, as they must.")
    print("\n  READ 'graded?' TOGETHER WITH '#0'.  The column tests only S_mmm and S_mpp,")
    print("  so where #0 > 0 it means 'p + m is a graded SUBALGEBRA', not that so(n) is")
    print("  Z_2-graded: padded CP^2 has [z,z] -> m = 16.  Gate 2, both reviewers.")

    print("\n=== control: random Weyl tensors sit near half the Casimir ===")
    rng = np.random.default_rng(5)
    for n in (6, 8, 10):
        B = weyl_basis(n)
        for t in range(2):
            co = rng.normal(size=B.shape[0])
            th, ok, d, D, tot, Smmm, Smpp, z = defect(n, np.tensordot(co, B, axes=([0], [0])))
            print(f"  n={n:2d}  theta={th:+.5f}  d={d:3d}  S_mmm={Smmm:8.3f}"
                  f"  Delta={D:8.3f} of {tot:5.1f} ({100*D/tot:5.1f}%)  S_mpp={Smpp:8.3f}")


if __name__ == '__main__':
    main()
