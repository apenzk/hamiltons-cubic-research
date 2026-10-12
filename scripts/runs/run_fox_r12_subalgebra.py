"""
Fox Lemma 10.7(4b) check at r=12, the actual conjectured threshold dimension
(Bohm-Wilking Conjecture A requires n>=12). Builds the 6-dimensional
hyperkahler subalgebra B_12 = Span{S^12(alpha),S^12(beta),S^12(gamma),
alpha.beta,beta.gamma,gamma.alpha} exactly as in run_fox_r8_subalgebra.py
(all machinery reused unmodified from that script / run_fox_S4_check.py /
curvature_operator.py / weyl_decomposition.py), with r=n=12 filled by three
4x4 quaternion blocks (flat hyperkahler structure on R^12 = H^3), and
searches for idempotents via the same multi-start Newton solver, clustering
by the correctly tensor-normalized true P value (not the raw Euclidean-
normalized coordinate eigenvalue, which is NOT scale-invariant on a
non-orthonormal basis -- see run_fox_r8_subalgebra.py for the derivation of
why P_true = lam_raw / sqrt(x^T G x) is the correct invariant).
"""
import time
import numpy as np

from curvature_operator import Lambda2, Q_op
from weyl_decomposition import ricci_from_mop, mop_from_4tensor, norm, frob
from run_fox_r8_subalgebra import (
    quaternion_generators_multiblock, build_Sr, build_dot,
    verify_quaternion_relations, build_structure_tensor, newton_search, Q_reduced,
)


def main():
    n = 12
    r = 12
    block = tuple(range(12))
    blocks4 = ((0, 1, 2, 3), (4, 5, 6, 7), (8, 9, 10, 11))

    t_start = time.time()
    L2 = Lambda2(n)
    I, J, K = quaternion_generators_multiblock(n, blocks4)
    verify_quaternion_relations(I, J, K, label="(n=r=12, three 4x4 blocks) ")

    Ta, Amat, g = build_Sr(n, r, I, block)
    Tb, Bmat, _ = build_Sr(n, r, J, block)
    Tc, Cmat, _ = build_Sr(n, r, K, block)
    Sa = mop_from_4tensor(L2, Ta)
    Sb = mop_from_4tensor(L2, Tb)
    Sc = mop_from_4tensor(L2, Tc)

    print("=== Ricci-flatness of S^12(alpha),S^12(beta),S^12(gamma) ===")
    for name, M in [("S^12(alpha)", Sa), ("S^12(beta)", Sb), ("S^12(gamma)", Sc)]:
        Ric = ricci_from_mop(L2, M)
        print(f"{name}: max|Ricci| = {np.max(np.abs(Ric)):.3e}, |.|^2 = {frob(M, M):.8f}")

    print("\n=== Lemma 10.7(4b) at r=12: S^12(alpha)+S^12(beta)+S^12(gamma) nonzero? ===")
    Ssum = Sa + Sb + Sc
    print(f"|S(alpha)+S(beta)+S(gamma)| / |S(alpha)| = {norm(Ssum) / norm(Sa):.6f}  (r=4 would give 0)\n")

    Tab = build_dot(n, I, J)
    Tbc = build_dot(n, J, K)
    Tca = build_dot(n, K, I)
    Mab = mop_from_4tensor(L2, Tab)
    Mbc = mop_from_4tensor(L2, Tbc)
    Mca = mop_from_4tensor(L2, Tca)

    basis = [Sa, Sb, Sc, Mab, Mbc, Mca]
    names = ["S(a)", "S(b)", "S(c)", "M(ab)", "M(bc)", "M(ca)"]
    m = len(basis)
    G = np.array([[frob(basis[i], basis[j]) for j in range(m)] for i in range(m)])
    eigvals = np.linalg.eigvalsh(G)
    rank = np.sum(eigvals > 1e-8 * eigvals[-1])
    print(f"=== Gram matrix rank check === eigenvalues: {eigvals}")
    print(f"=> rank = {rank} (expect 6)\n")

    print("=== building structure tensor (this is the slow O(n^3)-per-Q_op step) ===")
    t0 = time.time()
    G2, C, worst_resid = build_structure_tensor(L2, basis)
    print(f"structure tensor build time = {time.time()-t0:.1f}s, closure residual = {worst_resid:.3e}\n")

    print("=== idempotent search: 20000-trial multi-start Newton solve, clustered by TRUE P value ===")
    t0 = time.time()
    res = newton_search(C, m, n_trials=20000, seed=123)
    print(f"search time = {time.time()-t0:.1f}s, {len(res)} / 20000 trials converged")

    recs = []
    for x, lam, r_ in res:
        if r_ > 1e-6:
            continue
        nrm2 = x @ G2 @ x
        if nrm2 < 1e-12:
            continue
        Pt = lam / np.sqrt(nrm2)
        xu = x / np.sqrt(nrm2)
        recs.append((Pt, xu))
    recs.sort(key=lambda t: t[0])
    clusters = []
    for Pt, xu in recs:
        if clusters and abs(Pt - clusters[-1][0]) < 1e-4:
            clusters[-1][2].append(xu)
            clusters[-1][1] += 1
        else:
            clusters.append([Pt, 1, [xu]])

    print(f"\n{len(clusters)} distinct true-P clusters out of {len(recs)} valid converged points:\n")
    sqrt32 = np.sqrt(1.5)
    sphere_n12 = np.sqrt(2.0 * (n - 1) * (n - 2) / n**2)
    for Pt, cnt, xus in clusters:
        x0 = xus[0]
        coord_str = "  ".join(f"{names[i]}={x0[i]:+.5f}" for i in range(6))
        beats32 = " <-- BEATS sqrt(3/2)!" if abs(Pt) > sqrt32 + 1e-9 else ""
        beatssphere = " <-- BEATS balanced sphere n=12!" if abs(Pt) > sphere_n12 + 1e-9 else ""
        print(f"P = {Pt:+.8f}  count={cnt:5d}{beats32}{beatssphere}   coords: {coord_str}")

    print(f"\nreference: sqrt(3/2) = {sqrt32:.6f}, balanced sphere-product at n=12 = {sphere_n12:.6f}")
    print(f"total wall time = {time.time()-t_start:.1f}s")


if __name__ == "__main__":
    main()
