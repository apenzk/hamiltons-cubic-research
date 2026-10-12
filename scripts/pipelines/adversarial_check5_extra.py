"""
Reviewer 4 (adversarial), part 2: extends adversarial_check5_r8.py with

  (a) r=4 sanity check (own code should reproduce the known 5-dimensional
      collapse and P=sqrt(3/2)),
  (b) r=12 case (the actual conjectured threshold dimension),
  (c) a much larger random-restart completeness sweep at r=8 (20000+ trials,
      multiple seeds) to stress-test the "exactly 3 magnitudes" claim,
  (d) an independent TENSOR-LEVEL check of the claimed HP^2 identification:
      builds the Petersen-Wink R_HP^m operator directly (own code, no
      curvature_operator.py/weyl_decomposition.py), Weyl-decomposes it with
      fresh Ricci/Weyl code, and compares it against the X0 = S(a)+S(b)+S(c)
      branch tensor found here by FULL TENSOR cosine (not just matching
      P-values), at r=8 and r=12.
"""
import numpy as np
import time

from adversarial_check5_r8 import (
    QEngine, quaternion_blocks, random_orthogonal, pair_basis, basis_2form,
    mat_to_vec, build_basis, build_structure_tensor, newton_idempotent_search,
    true_P_clusters, ricci_from_mop, frob, norm, verify_hyperkahler,
)


def weyl_from_mop(n, pairs, idx, M):
    Ric = ricci_from_mop(n, pairs, idx, M)
    S = np.trace(Ric)
    N = len(pairs)
    Corr = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            dij_kl = (Ric[i, k] * (1.0 if j == l else 0.0)
                      - Ric[i, l] * (1.0 if j == k else 0.0)
                      + Ric[j, l] * (1.0 if i == k else 0.0)
                      - Ric[j, k] * (1.0 if i == l else 0.0))
            Corr[a, b] = dij_kl
    Weyl = M - Corr / (n - 2) + (S / ((n - 1) * (n - 2))) * np.eye(N)
    return Weyl, Ric, S


# ----------------------------------------------------------------------
# (a)+(b): r=4 and r=12 idempotent search, same machinery as r=8
# ----------------------------------------------------------------------
def run_full_case(n, r, blocks4, label, n_trials, seed):
    print(f"\n{'='*70}\n{label}  (n={n}, r={r})\n{'='*70}")
    t0 = time.time()
    block = tuple(range(n))
    I, J, K = quaternion_blocks(n, blocks4)
    verify_hyperkahler(I, J, K, label)
    eng = QEngine(n)
    basis, pairs = build_basis(n, r, block, I, J, K)
    names = ["S(a)", "S(b)", "S(c)", "M(ab)", "M(bc)", "M(ca)"]
    m = len(basis)
    G = np.array([[frob(basis[i], basis[j]) for j in range(m)] for i in range(m)])
    eigvals = np.linalg.eigvalsh(G)
    rank = int(np.sum(eigvals > 1e-8 * max(eigvals[-1], 1e-300)))
    print(f"  Gram eigenvalues: {np.array2string(eigvals, precision=6)}  -> rank {rank}")
    Ssum = basis[0] + basis[1] + basis[2]
    ratio = norm(Ssum) / norm(basis[0])
    print(f"  |S(a)+S(b)+S(c)|/|S(a)| = {ratio:.6f} (0 => r=4-style collapse)")

    if rank < 6:
        print("  [collapsed subalgebra: using only the independent generators for the search]")
        # Use SVD to find an independent basis among the (rank-deficient) 6.
        U, s, Vt = np.linalg.svd(G)
        keep = s > 1e-8 * s[0]
        # simplest robust approach for r=4: basis is {Sa, Sb, Mab, Mbc, Mca} (Sc=-Sa-Sb)
        basis_eff = [basis[0], basis[1], basis[3], basis[4], basis[5]]
        names_eff = ["S(a)", "S(b)", "M(ab)", "M(bc)", "M(ca)"]
    else:
        basis_eff = basis
        names_eff = names

    Gm, C, worst_resid = build_structure_tensor(eng, basis_eff)
    print(f"  structure tensor closure residual = {worst_resid:.3e}  (dim={len(basis_eff)})")

    results = newton_idempotent_search(C, len(basis_eff), n_trials=n_trials, seed=seed)
    print(f"  Newton search: {len(results)}/{n_trials} converged")
    clusters = true_P_clusters(results, Gm)
    sqrt32 = np.sqrt(1.5)
    sphere_n = np.sqrt(2.0 * (n - 1) * (n - 2) / n ** 2)
    print(f"  reference: sqrt(3/2)={sqrt32:.6f}, balanced sphere at n={n}: {sphere_n:.6f}")
    print(f"  {len(clusters)} distinct true-P clusters:")
    for Pt, cnt, xus in clusters:
        beats = ""
        if abs(Pt) > sqrt32 + 1e-9:
            beats += " <-- BEATS sqrt(3/2)"
        if abs(Pt) > sphere_n + 1e-9:
            beats += " <-- BEATS sphere"
        print(f"    P = {Pt:+.8f}  (count={cnt}){beats}")
    print(f"  wall time = {time.time()-t0:.1f}s")
    return dict(eng=eng, basis=basis, basis_eff=basis_eff, pairs=pairs, clusters=clusters, G=G)


# ----------------------------------------------------------------------
# (d): independent Petersen-Wink R_HP^m operator, own code
# ----------------------------------------------------------------------
def build_HPm_operator(n, I, J, K):
    """R_HPm(X^Y) = X^Y + IX^IY + JX^JY + KX^KY
                    + 2<X^Y,wI> wI + 2<X^Y,wJ> wJ + 2<X^Y,wK> wK
    built directly as an N x N operator matrix in the pair-vector basis
    (own code, independent of curvature_operator.py)."""
    pairs = pair_basis(n)
    N = len(pairs)
    wI, wJ, wK = I.T.copy(), J.T.copy(), K.T.copy()  # fundamental 2-forms

    def wedge(X, Y):
        return np.outer(X, Y) - np.outer(Y, X)

    def L2_inner(A, B):
        return float(mat_to_vec(pairs, A) @ mat_to_vec(pairs, B))

    e = np.eye(n)
    Rop = np.zeros((N, N))
    for b, (k, l) in enumerate(pairs):
        ek, el = e[k], e[l]
        base = wedge(ek, el)
        img = base.copy()
        img += wedge(I @ ek, I @ el)
        img += wedge(J @ ek, J @ el)
        img += wedge(K @ ek, K @ el)
        img += 2.0 * L2_inner(base, wI) * wI
        img += 2.0 * L2_inner(base, wJ) * wJ
        img += 2.0 * L2_inner(base, wK) * wK
        Rop[:, b] = mat_to_vec(pairs, img)
    return Rop, pairs


def hpm_check(n, blocks4, X0_tensor, X0_label):
    print(f"\n--- independent HP^m tensor-level check at n={n} ---")
    block = tuple(range(n))
    I, J, K = quaternion_blocks(n, blocks4)
    Rop, pairs = build_HPm_operator(n, I, J, K)
    idx = {p: k for k, p in enumerate(pairs)}
    Weyl, Ric, S = weyl_from_mop(n, pairs, idx, Rop)
    m = len(blocks4)
    print(f"  scal(R_HPm) = {S:.6f}  (Petersen-Wink formula: 16m(m+2) = {16*m*(m+2)})")
    Wnorm2 = frob(Weyl, Weyl)
    print(f"  |Weyl(R_HPm)|^2 = {Wnorm2:.6f}")

    Xu = X0_tensor / norm(X0_tensor)
    Wu = Weyl / norm(Weyl)
    cos_angle = frob(Xu, Wu)
    print(f"  cosine(X0_branch_tensor, Weyl(R_HPm)) = {cos_angle:.10f}  ({X0_label})")
    print(f"  (1.0 or -1.0 means the SAME tensor up to sign/scale, not just matching scalar P)")


def main():
    print("### r=4 sanity check (should reproduce known 5-dim collapse, P=sqrt(3/2)) ###")
    run_full_case(4, 4, ((0, 1, 2, 3),), "r=4 baseline", n_trials=1500, seed=11)

    print("\n### r=8 large completeness sweep (multiple seeds, 20000+ trials total) ###")
    res8 = run_full_case(8, 8, ((0, 1, 2, 3), (4, 5, 6, 7)), "r=8 large sweep", n_trials=12000, seed=777)
    res8b = run_full_case(8, 8, ((0, 1, 2, 3), (4, 5, 6, 7)), "r=8 large sweep (2nd seed)", n_trials=8000, seed=54321)

    print("\n### r=12 case (the actual conjectured threshold dimension) ###")
    res12 = run_full_case(12, 12, ((0, 1, 2, 3), (4, 5, 6, 7), (8, 9, 10, 11)), "r=12", n_trials=10000, seed=2024)

    # tensor-level HP^m identification check
    X0_8 = res8['basis'][0] + res8['basis'][1] + res8['basis'][2]
    hpm_check(8, ((0, 1, 2, 3), (4, 5, 6, 7)), X0_8, "r=8, X0=S(a)+S(b)+S(c)")

    X0_12 = res12['basis'][0] + res12['basis'][1] + res12['basis'][2]
    hpm_check(12, ((0, 1, 2, 3), (4, 5, 6, 7), (8, 9, 10, 11)), X0_12, "r=12, X0=S(a)+S(b)+S(c)")


if __name__ == "__main__":
    main()
