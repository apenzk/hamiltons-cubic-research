"""
Part 2 of the hypercomplex/Fox cross-check task.

Builds a hypercomplex structure (alpha,beta,gamma) on a fixed 4-plane inside
R^n via quaternion left-multiplication matrices (i,j,k), constructs the three
Fox idempotents S^4(alpha), S^4(beta), S^4(gamma) via the SAME literal
construction validated exactly (residual 0.0) in run_fox_S4_check.py, and:

  1. verifies i^2=j^2=k^2=-1, ij=k, jk=i, ki=j numerically as endomorphisms
     of R^4,
  2. verifies S(alpha)+S(beta)+S(gamma) = 0 (Fox Lemma 10.7(4a), r=4 only),
  3. builds the cross terms alpha.beta, beta.gamma, gamma.alpha (Fox's "."
     product of two different 2-forms) and checks they are Ricci-flat,
     pairwise orthogonal, of equal norm, and orthogonal to Span{S(alpha),
     S(beta), S(gamma)} -- Fox Lemma 10.7(3),
  4. computes the pipeline's own bilinear form B(X,Y) = 1/2[Q(X+Y)-Q(X)-Q(Y)]
     (built from curvature_operator's validated Q_op / R^# machinery, no reliance on
     Fox's abstract algebra) on this basis and decomposes B(S(alpha),S(beta))
     back into the 6-dim spanning set, cross-checking against Fox's stated
     relation (10.16),
  5. solves for ALL idempotents of the 5-dimensional subalgebra B directly
     via Pipeline C's own numerics (not just quoting Fox's closed form),
     confirming the classification and reporting P-values,
  6. reports the P-value of the "natural" symmetric combination
     (S(alpha)+S(beta)+S(gamma))/sqrt(3) [which Fox's algebraic identity
     already forces to be exactly zero] and of the true nonzero idempotents.
"""
import numpy as np
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, ricci_from_mop, mop_from_4tensor, norm, frob, P_value
from run_fox_S4_check import star_product, dot_product_2forms


def quaternion_generators(n, block=(0, 1, 2, 3)):
    """Left-multiplication-by-i,j,k endomorphism matrices on R^4 (embedded in
    R^n, zero outside block), in the same M[b,a] = <M e_a, e_b> convention
    used by cp2_tensor.py's build_J. Returns (I, J, K) with I == build_J(n)."""
    I = np.zeros((n, n)); J = np.zeros((n, n)); K = np.zeros((n, n))
    b0, b1, b2, b3 = block
    # i: e0->e1, e1->-e0, e2->e3, e3->-e2
    I[b1, b0] = 1.0; I[b0, b1] = -1.0
    I[b3, b2] = 1.0; I[b2, b3] = -1.0
    # j: e0->e2, e1->-e3, e2->-e0, e3->e1
    J[b2, b0] = 1.0; J[b0, b2] = -1.0
    J[b3, b1] = -1.0; J[b1, b3] = 1.0
    # k: e0->e3, e1->e2, e2->-e1, e3->-e0
    K[b3, b0] = 1.0; K[b0, b3] = -1.0
    K[b2, b1] = 1.0; K[b1, b2] = -1.0
    return I, J, K


def build_S4(n, Jendo, block=(0, 1, 2, 3)):
    """Fox's literal S^4(alpha) = 1/6*(g?g - alpha.alpha) for the complex
    structure whose endomorphism matrix is Jendo (alpha = Jendo.T, the
    fundamental 2-form). Returns the raw 4-index callable T(i,j,k,l)."""
    Jmat = Jendo.T.copy()
    g = np.zeros((n, n))
    for b in block:
        g[b, b] = 1.0

    def T(i, j, k, l):
        gg = star_product(g, g, i, j, k, l)
        aa = dot_product_2forms(Jmat, Jmat, i, j, k, l)
        return (1.0 / 6.0) * (gg - aa)
    return T, Jmat


def build_dot(n, JendoA, JendoB, block=(0, 1, 2, 3)):
    """Fox's alpha.beta cross term (raw, unscaled, as in (6.2)) for two
    different complex structures' fundamental 2-forms."""
    Amat = JendoA.T.copy()
    Bmat = JendoB.T.copy()

    def T(i, j, k, l):
        return dot_product_2forms(Amat, Bmat, i, j, k, l)
    return T


def main():
    n = 6
    L2 = Lambda2(n)
    I, J, K = quaternion_generators(n)

    # --- 1. verify hypercomplex relations numerically ---
    def restrict(M):
        return M[:4, :4]
    Ir, Jr, Kr = restrict(I), restrict(J), restrict(K)
    print("=== hypercomplex relations (should all be ~0) ===")
    print("max|I^2+Id| =", np.max(np.abs(Ir @ Ir + np.eye(4))))
    print("max|J^2+Id| =", np.max(np.abs(Jr @ Jr + np.eye(4))))
    print("max|K^2+Id| =", np.max(np.abs(Kr @ Kr + np.eye(4))))
    print("max|I@J-K|  =", np.max(np.abs(Ir @ Jr - Kr)))
    print("max|J@K-I|  =", np.max(np.abs(Jr @ Kr - Ir)))
    print("max|K@I-J|  =", np.max(np.abs(Kr @ Ir - Jr)))
    print("max|I@J+J@I| =", np.max(np.abs(Ir @ Jr + Jr @ Ir)))

    # --- build S(alpha), S(beta), S(gamma) ---
    Ta, Amat = build_S4(n, I)
    Tb, Bmat = build_S4(n, J)
    Tc, Cmat = build_S4(n, K)
    Sa = mop_from_4tensor(L2, Ta)
    Sb = mop_from_4tensor(L2, Tb)
    Sc = mop_from_4tensor(L2, Tc)

    print("\n=== Ricci-flatness of S(alpha),S(beta),S(gamma) ===")
    for name, M in [("S(alpha)", Sa), ("S(beta)", Sb), ("S(gamma)", Sc)]:
        Ric = ricci_from_mop(L2, M)
        print(f"{name}: max|Ricci| = {np.max(np.abs(Ric)):.3e}, |.|^2 = {frob(M,M):.8f}")

    print("\n=== Lemma 10.7(4a): S(alpha)+S(beta)+S(gamma) = 0 ? ===")
    Ssum = Sa + Sb + Sc
    print("max|S(alpha)+S(beta)+S(gamma)| =", np.max(np.abs(Ssum)),
          "  (relative to |S(alpha)| =", norm(Sa), ")")

    print("\n=== Gram matrix of {S(alpha),S(beta),S(gamma)} ===")
    G = np.array([[frob(Sa, Sa), frob(Sa, Sb), frob(Sa, Sc)],
                  [frob(Sb, Sa), frob(Sb, Sb), frob(Sb, Sc)],
                  [frob(Sc, Sa), frob(Sc, Sb), frob(Sc, Sc)]])
    print(G)
    print("cos(angle) Sa,Sb =", G[0, 1] / np.sqrt(G[0, 0] * G[1, 1]), " (Fox predicts 1/(2-r)=-1/2)")

    # --- cross terms alpha.beta, beta.gamma, gamma.alpha ---
    Tab = build_dot(n, I, J)
    Tbc = build_dot(n, J, K)
    Tca = build_dot(n, K, I)
    Mab = mop_from_4tensor(L2, Tab)
    Mbc = mop_from_4tensor(L2, Tbc)
    Mca = mop_from_4tensor(L2, Tca)

    print("\n=== cross terms alpha.beta etc: Ricci-flat? pairwise orthogonal? equal norm? ===")
    for name, M in [("alpha.beta", Mab), ("beta.gamma", Mbc), ("gamma.alpha", Mca)]:
        Ric = ricci_from_mop(L2, M)
        print(f"{name}: max|Ricci|={np.max(np.abs(Ric)):.3e}  |.|^2={frob(M,M):.6f}  (Fox: 3r(r+2)=72)")
    print("<ab,bc>=", frob(Mab, Mbc), " <bc,ca>=", frob(Mbc, Mca), " <ca,ab>=", frob(Mca, Mab))
    print("<ab,Sa>=", frob(Mab, Sa), " <ab,Sb>=", frob(Mab, Sb), " <ab,Sc>=", frob(Mab, Sc),
          " (Fox: all orthogonal, should be ~0)")

    # --- pipeline's own bilinear form on this basis ---
    def Bil(X, Y):
        return 0.5 * (Q_op(L2, X + Y) - Q_op(L2, X) - Q_op(L2, Y))

    print("\n=== pipeline's Bil(S(alpha),S(beta)) decomposed in the 6-dim spanning set ===")
    Bab = Bil(Sa, Sb)
    basis = {"Sa": Sa, "Sb": Sb, "Sc": Sc, "Mab": Mab, "Mbc": Mbc, "Mca": Mca}
    for name, M in basis.items():
        coeff = frob(Bab, M) / frob(M, M)
        print(f"  <Bil(Sa,Sb), {name}>/|{name}|^2 = {coeff:.6f}")
    # residual check: is Bil(Sa,Sb) fully explained by {Sa,Sb,Sc}? (Fox: yes, (10.16))
    # least squares fit using Sa,Sb (Sc=-Sa-Sb dependent)
    M1, M2 = Sa.flatten(), Sb.flatten()
    Amat_ls = np.vstack([M1, M2]).T
    coef, *_ = np.linalg.lstsq(Amat_ls, Bab.flatten(), rcond=None)
    fit = coef[0] * Sa + coef[1] * Sb
    resid = norm(Bab - fit) / norm(Bab)
    print(f"  least-squares fit Bil(Sa,Sb) ~ {coef[0]:.6f}*Sa + {coef[1]:.6f}*Sb, "
          f"relative residual = {resid:.3e}")
    lamA = frob(Sa, Q_op(L2, Sa)) / frob(Sa, Sa)
    print(f"  eigenvalue check: Q(Sa) = {lamA:.6f} * Sa (should be exact eigen-relation)")

    # --- P-values ---
    print("\n=== P-values ===")
    print("P/|W|^3 for S(alpha) alone:", P_value(L2, Sa) / norm(Sa)**3)
    Ssum_norm = norm(Ssum)
    print(f"|S(alpha)+S(beta)+S(gamma)| = {Ssum_norm:.3e}  -> the naive symmetric combination "
          f"(sum)/sqrt(3) is IDENTICALLY ZERO (not a valid unit-norm competitor).")

    # --- 5. full idempotent classification within Span{Sa,Sb,Sc} (z=0 case,
    #     sufficient up to conjugation by the SO(3) rotating alpha,beta,gamma) ---
    print("\n=== numerical idempotent search in Span{Sa,Sb} (Sc=-Sa-Sb) ===")
    QSa = Q_op(L2, Sa)
    QSb = Q_op(L2, Sb)
    BilAB = Bil(Sa, Sb)
    # Q(x1*Sa+x2*Sb) = x1^2*QSa + x2^2*QSb + 2*x1*x2*BilAB  (exact, Q is quadratic)
    # project this back onto {Sa,Sb} using least squares (residual should be tiny)
    def project(M):
        c, *_ = np.linalg.lstsq(Amat_ls, M.flatten(), rcond=None)
        resid = norm(M - (c[0]*Sa + c[1]*Sb)) / (norm(M) + 1e-300)
        return c, resid
    cQa, rQa = project(QSa)
    cQb, rQb = project(QSb)
    cBab, rBab = project(BilAB)
    print(f"Q(Sa) -> ({cQa[0]:.6f},{cQa[1]:.6f}) in (Sa,Sb) coords, out-of-span residual={rQa:.2e}")
    print(f"Q(Sb) -> ({cQb[0]:.6f},{cQb[1]:.6f}), residual={rQb:.2e}")
    print(f"Bil(Sa,Sb) -> ({cBab[0]:.6f},{cBab[1]:.6f}), residual={rBab:.2e}")

    import sympy as sp
    x1, x2, lam = sp.symbols('x1 x2 lam', real=True)
    qa0, qa1 = sp.nsimplify(cQa[0], rational=True), sp.nsimplify(cQa[1], rational=True)
    qb0, qb1 = sp.nsimplify(cQb[0], rational=True), sp.nsimplify(cQb[1], rational=True)
    ba0, ba1 = sp.nsimplify(cBab[0], rational=True), sp.nsimplify(cBab[1], rational=True)
    comp1 = qa0*x1**2 + qb0*x2**2 + 2*ba0*x1*x2
    comp2 = qa1*x1**2 + qb1*x2**2 + 2*ba1*x1*x2
    eqs = [sp.Eq(comp1, lam*x1), sp.Eq(comp2, lam*x2)]
    sols = sp.solve(eqs, [x1, x2, lam], dict=True)
    print("\nsolutions of Q(x1*Sa+x2*Sb) = lam*(x1*Sa+x2*Sb) [built purely from pipeline numerics]:")
    for s in sols:
        print(" ", s)

    print("\n=== a generic z!=0 combination is checked NOT idempotent (sanity check) ===")
    Xg = 0.5*Sa + 0.3*Sb + 0.7*Mab + 0.2*Mbc  # generic point of B, off the diagonal locus
    QXg = Q_op(L2, Xg)
    lamg = frob(Xg, QXg) / frob(Xg, Xg)
    reldiff = norm(QXg - lamg*Xg) / norm(QXg)
    print(f"generic X in B: Q(X)=lam*X reldiff = {reldiff:.4f}  (large => not an eigenvector/idempotent)")


if __name__ == "__main__":
    main()
