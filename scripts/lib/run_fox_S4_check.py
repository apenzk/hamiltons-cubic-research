"""
Part 1 of the hypercomplex/Fox cross-check task.

Builds Fox's S^r(alpha) idempotent (arXiv:1901.04012, Lemma 10.1) LITERALLY
from his index formulas in Section 6 (eqns (6.1)-(6.2)):

    (g ? g)_{ijkl}   = alpha_{k[i} beta_{j]l} - alpha_{l[i} beta_{j]k}     (alpha=beta=g, symmetric case)
    (alpha . alpha)_{ijkl} = -3( alpha_{k[i} alpha_{j]l} - alpha_{l[i} alpha_{j]k}
                                  - 2 alpha_{[ij} alpha_{kl]} )
    S^r(alpha) = 1/(r+2) * ( 3/(r-1) g?g - alpha.alpha )

No shortcuts, no reuse of the pipeline's cp2_block_st_tensor formula for
this construction -- the point is to build Fox's tensor from his own raw
definitions and see whether it lands on the same object (up to scalar) that
run_cp2_ricci_flat.py found independently by demanding Ricci-flatness.

Antisymmetrization brackets are implemented by brute-force permutation sums
(itertools.permutations), not hand-simplified index algebra, to remove any
risk of a sign/combinatorial-factor error.
"""
import numpy as np
import itertools
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, ricci_from_mop, mop_from_4tensor, norm, frob
from cp2_tensor import build_J
from run_cp2_ricci_flat import cp2_block_st_tensor


def bracket2(term, i, j):
    """alpha_{.[i} beta_{.j]} style: antisymmetrize a 2-arg function over (i,j)."""
    return 0.5 * (term(i, j) - term(j, i))


def full_antisym4(alpha, beta, i, j, k, l):
    """alpha_{[ij} beta_{kl]}: full antisymmetrization of alpha_{ab} beta_{cd}
    over the 4-index multi-index (i,j,k,l), via brute-force sum over S_4."""
    idxs = [i, j, k, l]
    total = 0.0
    for perm in itertools.permutations(range(4)):
        # parity of perm
        sign = 1
        p = list(perm)
        for a in range(4):
            while p[a] != a:
                b = p[a]
                p[a], p[b] = p[b], p[a]
                sign = -sign
        pi_, pj_, pk_, pl_ = (idxs[perm[0]], idxs[perm[1]], idxs[perm[2]], idxs[perm[3]])
        total += sign * alpha[pi_, pj_] * beta[pk_, pl_]
    return total / 24.0


def star_product(alpha, beta, i, j, k, l):
    """(alpha ? beta)_{ijkl} = alpha_{k[i} beta_{j]l} - alpha_{l[i} beta_{j]k},
    Fox's (6.1), valid for symmetric alpha,beta (here used for g,g)."""
    t1 = bracket2(lambda a, b: alpha[k, a] * beta[b, l], i, j)
    t2 = bracket2(lambda a, b: alpha[l, a] * beta[b, k], i, j)
    return t1 - t2


def dot_product_2forms(alpha, beta, i, j, k, l):
    """(alpha . beta)_{ijkl}, Fox's (6.2), for antisymmetric alpha,beta."""
    br1 = bracket2(lambda a, b: alpha[k, a] * beta[b, l], i, j)
    br2 = bracket2(lambda a, b: alpha[l, a] * beta[b, k], i, j)
    corr = full_antisym4(alpha, beta, i, j, k, l)
    return -3.0 * (br1 - br2 - 2.0 * corr)


def build_fox_S4(n, block=(0, 1, 2, 3)):
    """Literal construction of Fox's S^4(alpha) via (10.2) with r=4:
       S^4(alpha) = 1/6 * (1 * g?g - alpha.alpha)   [3/(r-1)=3/3=1, 1/(r+2)=1/6]
    g = projection onto the 4-plane (identity on block, zero outside);
    alpha = fundamental 2-form of the complex structure J on that block."""
    J = build_J(n)
    Jmat = J.T.copy()
    g = np.zeros((n, n))
    for i in block:
        g[i, i] = 1.0

    def T(i, j, k, l):
        gg = star_product(g, g, i, j, k, l)
        aa = dot_product_2forms(Jmat, Jmat, i, j, k, l)
        return (1.0 / 6.0) * (gg - aa)
    return T, Jmat, g


def main():
    n = 6
    L2 = Lambda2(n)
    T_fox, Jmat, g = build_fox_S4(n)
    Mop_fox = mop_from_4tensor(L2, T_fox)

    # sanity: is this literally Ricci-flat (i.e. in MC_W) as Fox's item (1) claims?
    Ric = ricci_from_mop(L2, Mop_fox)
    print("max|Ricci(S^4(alpha))| =", np.max(np.abs(Ric)), " (Fox: should be exactly 0)")

    Weyl_fox, Ric2, S2 = weyl_from_mop(L2, Mop_fox)
    print("max|Mop_fox - Weyl(Mop_fox)| =", np.max(np.abs(Mop_fox - Weyl_fox)),
          " (should be ~0 since already Weyl-type)")

    # Fox's stated norm: |S^r(alpha)|^2_h = 6r(r-2)/((r+2)(r-1)) at r=4 -> 48/18 = 8/3
    nrm2_fox_formula = 8.0 / 3.0
    nrm2_pipeline = frob(Mop_fox, Mop_fox)
    print(f"|S^4(alpha)|^2 (pipeline Frobenius on Lambda^2 operator) = {nrm2_pipeline:.10f}")
    print(f"Fox's claimed |S^4(alpha)|^2_h (his tensor-norm convention)   = {nrm2_fox_formula:.10f}")
    print(f"ratio (pipeline / Fox)  = {nrm2_pipeline / nrm2_fox_formula:.10f}")

    # idempotency check under Fox's own product isn't directly available here;
    # instead check the pipeline's Q map fixes it up to scalar (it must, since
    # ANY *-idempotent of Fox's algebra should also satisfy Q(X) = lambda X
    # for pipeline's Q, since both are built from the same B(.,.) polarization
    # up to convention factors -- see run_cp2_ricci_flat.py's idempotent-reldiff check).
    Q_fox = Q_op(L2, Mop_fox)
    lam = frob(Mop_fox, Q_fox) / frob(Mop_fox, Mop_fox)
    reldiff = norm(Q_fox - lam * Mop_fox) / norm(Q_fox)
    print(f"pipeline idempotency check: Q(S^4(alpha)) = lambda*S^4(alpha) reldiff = {reldiff:.3e}")
    Pnorm = frob(Mop_fox, Q_fox) / nrm2_pipeline**1.5
    print(f"P/|W|^3 for the literal Fox tensor = {Pnorm:.8f}  (compare sqrt(3/2)={np.sqrt(1.5):.8f})")

    # ---- now compare directly, entrywise as 4-tensors, against run_cp2_ricci_flat's
    # Ricci-flat (s=1,t=-1) construction ----
    T_pipeline = cp2_block_st_tensor(n, 1.0, -1.0)
    Mop_pipeline = mop_from_4tensor(L2, T_pipeline)

    print("\n--- entrywise comparison: Fox's literal S^4(alpha) vs run_cp2_ricci_flat.py's (s=1,t=-1) tensor ---")
    # find scalar ratio via least-squares over nonzero entries
    A = Mop_fox.flatten()
    Bv = Mop_pipeline.flatten()
    mask = np.abs(Bv) > 1e-12
    ratios = A[mask] / Bv[mask]
    print(f"# nonzero comparison entries = {mask.sum()}")
    print(f"ratio min={ratios.min():.10f} max={ratios.max():.10f} mean={ratios.mean():.10f} std={ratios.std():.3e}")
    c = ratios.mean()
    resid = norm(Mop_fox - c * Mop_pipeline) / norm(Mop_fox)
    print(f"relative residual of Mop_fox - c*Mop_pipeline (c={c:.10f}): {resid:.3e}")


if __name__ == "__main__":
    main()
