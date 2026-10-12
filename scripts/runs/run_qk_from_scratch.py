"""
Independent, from-scratch construction of a quaternionic-Kahler (QK)-type
algebraic curvature tensor, built ONLY from the defining symmetry property
(Sp(m)Sp(1)-invariance), with NO reliance on any looked-up closed-form
formula from the QK literature. This is a deliberate cross-check against a
parallel agent who is looking up the standard HP^m curvature formula.

Method
------
1. Build one reference hypercomplex structure (I0,J0,K0) on R^{4m}
   (m=1,2,3, i.e. n=4,8,12) as block-diagonal quaternion left-multiplication
   matrices (m copies of the same 4x4 block), so Sp(m) acts on the R^{4m}
   factor structure and the SO(3)=Sp(1)/{+-1} of unit imaginary quaternions
   rotates (I0,J0,K0) among themselves by conjugation.
2. Build Omega = KN(omega_I,omega_I) + KN(omega_J,omega_J) + KN(omega_K,omega_K)
   under the Kulkarni-Nomizu product, using the KN formula stated in the task:
     (A o B)(X,Y,Z,W) = A(X,Z)B(Y,W) - A(X,W)B(Y,Z) + A(Y,W)B(X,Z) - A(Y,Z)B(X,W)
   applied literally to the (antisymmetric) fundamental 2-forms omega_I = I0
   (as a matrix representing the bilinear form <I0 X,Y>; overall sign is
   irrelevant since each form is squared against itself).
3. VERIFY Sp(1)-invariance directly and numerically: rotate (I0,J0,K0) by a
   random unit-quaternion conjugation (a genuine SO(3) rotation of the
   imaginary-quaternion triple), rebuild Omega' from the rotated triple, and
   check Omega' == Omega to machine precision. This is the correctness
   certificate for the whole construction.
4. Form R(c) = c*(g o g)/2 + Omega, verify first Bianchi for g o g, Omega,
   and R(c) directly (index sum T(i,j,k,l)+T(i,k,l,j)+T(i,l,j,k) = 0).
5. Because g o g has identically zero Weyl part (the round-sphere tensor is
   conformally flat -- already sanity-checked in weyl_decomposition.py), the
   Weyl part of R(c) is provably independent of c; this is checked
   numerically over a small grid of c, then the unique Ricci-flat c is found
   by solving one linear equation, and R(c_flat) is checked to equal
   Weyl(Omega) entrywise.
6. Idempotency of W = Weyl(Omega) under Pipeline C's validated Q = W^2 + W^#
   is tested for n=4,8,12 (m=1,2,3), and P/|W|^3 is compared against
   sqrt(3/2) (Fox's S^4(alpha) competitor) and the balanced sphere-product
   value sqrt(2(n-1)(n-2))/n.
"""
import numpy as np
import itertools

from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, ricci_from_mop, mop_from_4tensor, norm, frob, P_value


# ---------------------------------------------------------------
# 1. Reference hypercomplex structure on R^{4m}, block-diagonal.
# ---------------------------------------------------------------
def quaternion_units(n):
    """Block-diagonal (m = n/4 copies) left-multiplication-by-i,j,k matrices
    on R^{4m} = H^m, one identical quaternion block per m-summand. This is
    exactly the "tensor product / block-diagonal" construction requested:
    Sp(m) acts on the R^{4m} factor structure (permutes/rotates the m H-blocks
    quaternion-linearly) while I0,J0,K0 are fixed within each block."""
    assert n % 4 == 0
    m = n // 4
    I0 = np.zeros((n, n)); J0 = np.zeros((n, n)); K0 = np.zeros((n, n))
    for b in range(m):
        o = 4 * b
        # i: e0->e1, e1->-e0, e2->e3, e3->-e2
        I0[o+1, o+0] = 1.0; I0[o+0, o+1] = -1.0
        I0[o+3, o+2] = 1.0; I0[o+2, o+3] = -1.0
        # j: e0->e2, e1->-e3, e2->-e0, e3->e1
        J0[o+2, o+0] = 1.0; J0[o+0, o+2] = -1.0
        J0[o+3, o+1] = -1.0; J0[o+1, o+3] = 1.0
        # k: e0->e3, e1->e2, e2->-e1, e3->-e0
        K0[o+3, o+0] = 1.0; K0[o+0, o+3] = -1.0
        K0[o+2, o+1] = 1.0; K0[o+1, o+2] = -1.0
    return I0, J0, K0


def check_quaternion_relations(I0, J0, K0, n):
    Id = np.eye(n)
    checks = {
        "I^2+Id": I0 @ I0 + Id,
        "J^2+Id": J0 @ J0 + Id,
        "K^2+Id": K0 @ K0 + Id,
        "I@J-K": I0 @ J0 - K0,
        "J@K-I": J0 @ K0 - I0,
        "K@I-J": K0 @ I0 - J0,
        "I@J+J@I": I0 @ J0 + J0 @ I0,
        "J@K+K@J": J0 @ K0 + K0 @ J0,
        "K@I+I@K": K0 @ I0 + I0 @ K0,
        "I skew": I0 + I0.T,
        "J skew": J0 + J0.T,
        "K skew": K0 + K0.T,
    }
    worst = max(np.max(np.abs(v)) for v in checks.values())
    print(f"  n={n}: quaternion-relation max residual = {worst:.2e}")
    return worst


# ---------------------------------------------------------------
# 2. Kulkarni-Nomizu product and the Omega / g-o-g tensors.
# ---------------------------------------------------------------
def KN_entry(A, B, i, j, k, l):
    return A[i, k] * B[j, l] - A[i, l] * B[j, k] + A[j, l] * B[i, k] - A[j, k] * B[i, l]


def omega_sum_tensor(I0, J0, K0):
    def T(i, j, k, l):
        return (KN_entry(I0, I0, i, j, k, l)
                + KN_entry(J0, J0, i, j, k, l)
                + KN_entry(K0, K0, i, j, k, l))
    return T


def gg_tensor(n):
    Id = np.eye(n)
    def T(i, j, k, l):
        return KN_entry(Id, Id, i, j, k, l)
    return T


def bianchi_check(T, n, label):
    maxerr = 0.0
    for i, j, k, l in itertools.product(range(n), repeat=4):
        val = T(i, j, k, l) + T(i, k, l, j) + T(i, l, j, k)
        maxerr = max(maxerr, abs(val))
    print(f"  {label}: max first-Bianchi violation over all n={n} indices = {maxerr:.2e}")
    return maxerr


def tensor_to_array(T, n):
    A = np.zeros((n, n, n, n))
    for i, j, k, l in itertools.product(range(n), repeat=4):
        A[i, j, k, l] = T(i, j, k, l)
    return A


def bianchi_project(A):
    """Given a 4-index array A with the Sym^2(Lambda^2) symmetries
    (antisymmetric in (i,j), antisymmetric in (k,l), pair-symmetric under
    (ij)<->(kl)), remove its Lambda^4 (Bianchi-violating) component exactly.

    Standard fact: CyclicSum(A)(i,j,k,l) := A(i,j,k,l)+A(i,k,l,j)+A(i,l,j,k)
    is automatically totally antisymmetric whenever A has the symmetries
    above, and for a pure 4-form Lambda, CyclicSum(Lambda) = 3*Lambda. Hence
    Lambda = CyclicSum(A)/3 is exactly A's Lambda^4 part, and
    A_Bianchi := A - Lambda is the unique Bianchi-satisfying (genuine
    algebraic-curvature-tensor) part of A.
    """
    cyc = A + np.transpose(A, (0, 2, 3, 1)) + np.transpose(A, (0, 3, 1, 2))
    lam4 = cyc / 3.0
    return A - lam4, lam4


# ---------------------------------------------------------------
# 3. Sp(1)-invariance certificate: rotate (I0,J0,K0) by conjugation
#    with a random unit quaternion, rebuild Omega, compare.
# ---------------------------------------------------------------
def random_unit_quaternion(rng):
    v = rng.normal(size=4)
    return v / np.linalg.norm(v)


def quat_conj_rotmatrix(q):
    """3x3 SO(3) matrix R such that conjugation by unit quaternion q=(a,b,c,d)
    sends the imaginary unit x*i+y*j+z*k to (R@(x,y,z)) . (i,j,k)."""
    a, b, c, d = q
    return np.array([
        [1 - 2*(c*c + d*d), 2*(b*c - a*d),     2*(b*d + a*c)],
        [2*(b*c + a*d),     1 - 2*(b*b + d*d), 2*(c*d - a*b)],
        [2*(b*d - a*c),     2*(c*d + a*b),     1 - 2*(b*b + c*c)],
    ])


def rotate_triple(I0, J0, K0, R):
    # conj_q(i) = R[:,0] . (i,j,k)  =>  I' = R[0,0]*I0 + R[1,0]*J0 + R[2,0]*K0
    Ip = R[0, 0]*I0 + R[1, 0]*J0 + R[2, 0]*K0
    Jp = R[0, 1]*I0 + R[1, 1]*J0 + R[2, 1]*K0
    Kp = R[0, 2]*I0 + R[1, 2]*J0 + R[2, 2]*K0
    return Ip, Jp, Kp


def sp1_invariance_check(L2, I0, J0, K0, n, rng, ntrials=3):
    T0 = omega_sum_tensor(I0, J0, K0)
    Mop0 = mop_from_4tensor(L2, T0)
    n0 = norm(Mop0)
    worst_rel = 0.0
    for t in range(ntrials):
        q = random_unit_quaternion(rng)
        R = quat_conj_rotmatrix(q)
        # sanity: R must be an actual rotation
        orth_err = np.max(np.abs(R @ R.T - np.eye(3)))
        det_err = abs(np.linalg.det(R) - 1.0)
        Ip, Jp, Kp = rotate_triple(I0, J0, K0, R)
        # sanity: rotated triple must still satisfy quaternion relations
        rel_err = check_quaternion_relations(Ip, Jp, Kp, n)
        Tp = omega_sum_tensor(Ip, Jp, Kp)
        Mopp = mop_from_4tensor(L2, Tp)
        rel = norm(Mopp - Mop0) / n0
        worst_rel = max(worst_rel, rel)
        print(f"    trial {t}: R orth err={orth_err:.2e}, det err={det_err:.2e}, "
              f"rotated-triple relation err={rel_err:.2e}, |Omega'-Omega|/|Omega|={rel:.2e}")
    return worst_rel


# ---------------------------------------------------------------
# main per-n pipeline
# ---------------------------------------------------------------
def run_for_n(n, rng):
    m = n // 4
    print(f"\n{'='*70}\nn={n}  (m={m}, R^{n}=H^{m})\n{'='*70}")
    L2 = Lambda2(n)
    I0, J0, K0 = quaternion_units(n)

    print("-- quaternion relations for reference triple --")
    check_quaternion_relations(I0, J0, K0, n)

    print("-- Sp(1)-invariance certificate (random SO(3) via quaternion conjugation) --")
    worst_inv = sp1_invariance_check(L2, I0, J0, K0, n, rng)
    print(f"  worst relative |Omega'-Omega| over trials: {worst_inv:.2e}")

    print("-- first Bianchi identity (raw, literal KN formula as specified) --")
    T_gg = gg_tensor(n)
    T_om = omega_sum_tensor(I0, J0, K0)
    bianchi_check(T_gg, n, "g o g")
    bianchi_check(T_om, n, "Omega (raw, uncorrected)")
    print("  NOTE: the raw KN self-square of an ANTISYMMETRIC form is not Bianchi-closed")
    print("  (unlike g o g for symmetric g) -- it carries a genuine Lambda^4 component.")
    print("  This is projected out exactly below before Omega is treated as a curvature tensor.")

    A_om = tensor_to_array(T_om, n)
    A_om_B, A_om_lam4 = bianchi_project(A_om)
    lam4_norm = np.sqrt(np.sum(A_om_lam4**2))
    om_norm = np.sqrt(np.sum(A_om**2))
    print(f"  |Lambda^4 part of Omega| / |Omega| = {lam4_norm/om_norm:.4f}  (fraction removed)")
    # verify projection worked: corrected tensor must satisfy Bianchi to machine precision
    T_om_B = lambda i, j, k, l: A_om_B[i, j, k, l]
    bianchi_check(T_om_B, n, "Omega (Bianchi-projected)")
    # sanity: the removed part should itself be totally antisymmetric (a
    # genuine 4-form). (ij)- and (kl)-antisymmetry are inherited automatically
    # from A_om; the independent new check is antisymmetry under swapping the
    # middle two indices j,k -- together these three transpositions generate
    # all of S4, certifying total antisymmetry.
    antisym_err = 0.0
    for i, j, k, l in itertools.product(range(n), repeat=4):
        antisym_err = max(antisym_err, abs(A_om_lam4[i, j, k, l] + A_om_lam4[j, i, k, l]))
        antisym_err = max(antisym_err, abs(A_om_lam4[i, j, k, l] + A_om_lam4[i, j, l, k]))
        antisym_err = max(antisym_err, abs(A_om_lam4[i, j, k, l] + A_om_lam4[i, k, j, l]))
    print(f"  removed Lambda^4 piece: max total-antisymmetry residual (all pair swaps) = {antisym_err:.2e}")

    # confirm Sp(1)-invariance survives the Bianchi projection too (the
    # projection is a fixed index-permutation operator, so this should be
    # automatic, but check it directly rather than assume it)
    q = random_unit_quaternion(rng)
    R = quat_conj_rotmatrix(q)
    Ip, Jp, Kp = rotate_triple(I0, J0, K0, R)
    A_om_rot = tensor_to_array(omega_sum_tensor(Ip, Jp, Kp), n)
    A_om_rot_B, _ = bianchi_project(A_om_rot)
    rel_B = np.sqrt(np.sum((A_om_rot_B - A_om_B)**2)) / np.sqrt(np.sum(A_om_B**2))
    print(f"  Sp(1)-invariance of Bianchi-corrected Omega under a fresh random rotation: "
          f"relative diff = {rel_B:.2e}")

    # from here on, use the Bianchi-corrected Omega as THE candidate tensor
    T_om = T_om_B
    Mop_gg = mop_from_4tensor(L2, T_gg)
    Mop_om = mop_from_4tensor(L2, T_om)

    print("-- Weyl part of R(c) = c*(g o g)/2 + Omega across a grid of c --")
    Weyl_om, Ric_om, S_om = weyl_from_mop(L2, Mop_om)
    Weyl_gg, Ric_gg, S_gg = weyl_from_mop(L2, Mop_gg)
    print(f"  |Weyl(g o g)| = {norm(Weyl_gg):.3e}  (expect ~0: round sphere is conformally flat)")
    for c in [-2.0, -1.0, 0.0, 1.0, 2.0, 5.0]:
        Mop_c = c/2.0 * Mop_gg + Mop_om
        Weyl_c, Ric_c, S_c = weyl_from_mop(L2, Mop_c)
        rel_to_om = norm(Weyl_c - Weyl_om) / (norm(Weyl_om) + 1e-300)
        print(f"    c={c:+.2f}: |Weyl(R(c)) - Weyl(Omega)| / |Weyl(Omega)| = {rel_to_om:.2e}")

    # Ricci is affine in c: Ric(c) = c/2 * Ric(g o g) + Ric(Omega); Ric(g o g) = (n-1)*Id (round sphere)
    # solve one diagonal entry for the Ricci-flat c, then verify the whole matrix.
    c_flat = -2.0 * Ric_om[0, 0] / Ric_gg[0, 0]
    Mop_flat = c_flat/2.0 * Mop_gg + Mop_om
    Ric_flat = ricci_from_mop(L2, Mop_flat)
    print(f"-- Ricci-flat point: c_flat = {c_flat:.6f}, max|Ricci(R(c_flat))| = {np.max(np.abs(Ric_flat)):.2e}")
    print(f"   |R(c_flat) - Weyl(Omega)| / |Weyl(Omega)| = "
          f"{norm(Mop_flat - Weyl_om)/(norm(Weyl_om)+1e-300):.2e}  (should be ~0: R(c_flat) IS the Weyl tensor)")

    W = Weyl_om
    Wn = norm(W)
    print(f"-- |Weyl(Omega)| = {Wn:.6f}")
    if Wn < 1e-8:
        print(f"   Weyl(Omega) ~ 0 at n={n}: no nontrivial competitor here "
              f"(consistent with HP^1=S^4 being conformally flat at m=1).")
        return dict(n=n, weyl_norm=Wn, idempotent_residual=None, P_over_norm3=None)

    Qm = Q_op(L2, W)
    lam = frob(W, Qm) / frob(W, W)
    residual = norm(Qm - lam * W) / norm(Qm)
    Pv = frob(W, Qm)
    Pnorm = Pv / Wn**3
    print(f"-- idempotency of Weyl(Omega) under Q: eigenvalue lam={lam:.6f}, "
          f"relative residual |Q(W)-lam W|/|Q(W)| = {residual:.3e}")
    print(f"-- P/|W|^3 = {Pnorm:.6f}   |P/|W|^3| = {abs(Pnorm):.6f}")

    sphere_val = np.sqrt(2.0 * (n-1) * (n-2)) / n
    print(f"-- comparison: |P/|W|^3|={abs(Pnorm):.6f} vs sqrt(3/2)={np.sqrt(1.5):.6f} "
          f"vs balanced-sphere({n})={sphere_val:.6f}")

    return dict(n=n, weyl_norm=Wn, idempotent_residual=residual, P_over_norm3=abs(Pnorm),
                sphere_val=sphere_val, sqrt32=np.sqrt(1.5), lam=lam)


# ---------------------------------------------------------------
# Cross-check against Petersen-Wink's literature formula for the
# curvature OPERATOR of HP^m (not used to build Omega above -- this
# is only invoked at the end, to compare against this repo's parallel
# literature-lookup agent's formula, per the task's final instruction).
# Petersen-Wink (arXiv:2105.09290), Sec.4:
#   R_HPm(X^Y) = X^Y + IX^IY + JX^JY + KX^KY
#                + 2<X^Y,om_I>om_I + 2<X^Y,om_J>om_J + 2<X^Y,om_K>om_K
# ---------------------------------------------------------------
def lambda2_action(L2, M):
    """Matrix of the induced map Lambda^2(M): e_i^e_j -> (M e_i)^(M e_j),
    in the pair basis."""
    N = L2.N
    Out = np.zeros((N, N))
    for a, (i, j) in enumerate(L2.pairs):
        Mi = M[:, i]
        Mj = M[:, j]
        for b, (p, q) in enumerate(L2.pairs):
            Out[b, a] = Mi[p]*Mj[q] - Mi[q]*Mj[p]
    return Out


def petersen_wink_operator(L2, I0, J0, K0):
    N = L2.N
    Id = np.eye(N)
    LI = lambda2_action(L2, I0)
    LJ = lambda2_action(L2, J0)
    LK = lambda2_action(L2, K0)
    vI = L2.matrix_to_vec(I0)
    vJ = L2.matrix_to_vec(J0)
    vK = L2.matrix_to_vec(K0)
    outer = 2*(np.outer(vI, vI) + np.outer(vJ, vJ) + np.outer(vK, vK))
    return Id + LI + LJ + LK + outer


def cross_check_petersen_wink(n, I0, J0, K0, Weyl_om):
    m = n // 4
    L2 = Lambda2(n)
    Mop_pw = petersen_wink_operator(L2, I0, J0, K0)
    sym_err = np.max(np.abs(Mop_pw - Mop_pw.T))
    print(f"  Petersen-Wink operator: symmetry residual = {sym_err:.2e}")
    normsq = frob(Mop_pw, Mop_pw)
    print(f"  |R_HPm|^2 = {normsq:.4f}  (Petersen-Wink formula predicts 16m(5m+1) = {16*m*(5*m+1)})")
    Weyl_pw, Ric_pw, S_pw = weyl_from_mop(L2, Mop_pw)
    ric_dev = np.max(np.abs(Ric_pw - (S_pw/n)*np.eye(n)))
    print(f"  scal(R_HPm) = {S_pw:.4f}  (Petersen-Wink formula predicts 16m(m+2) = {16*m*(m+2)}), "
          f"Einstein deviation = {ric_dev:.2e}")
    if norm(Weyl_om) < 1e-8 or norm(Weyl_pw) < 1e-8:
        print(f"  |Weyl(Omega)|={norm(Weyl_om):.2e}, |Weyl(R_HPm)|={norm(Weyl_pw):.2e} "
              f"-- at least one is ~0, skipping direction comparison")
        return
    cos_angle = frob(Weyl_om, Weyl_pw) / (norm(Weyl_om) * norm(Weyl_pw))
    print(f"  cos(angle) between Weyl(Omega) [this construction] and Weyl(R_HPm) "
          f"[Petersen-Wink literature formula] = {cos_angle:+.10f}")
    if abs(abs(cos_angle) - 1.0) < 1e-8:
        print("  -> EXACT MATCH (up to scale/sign): the two independently-built "
              "Weyl tensors are the same tensor.")
    else:
        print("  -> MISMATCH: the two constructions give different Weyl tensors.")


if __name__ == "__main__":
    rng = np.random.default_rng(12345)
    results = []
    weyl_cache = {}
    for n in [4, 8, 12]:
        r = run_for_n(n, rng)
        results.append(r)

    print(f"\n{'='*70}\nCROSS-CHECK vs Petersen-Wink literature formula for R_HPm\n{'='*70}")
    for n in [4, 8, 12]:
        print(f"\n-- n={n} --")
        I0, J0, K0 = quaternion_units(n)
        L2 = Lambda2(n)
        T_om = omega_sum_tensor(I0, J0, K0)
        A_om = tensor_to_array(T_om, n)
        A_om_B, _ = bianchi_project(A_om)
        Mop_om = mop_from_4tensor(L2, lambda i, j, k, l: A_om_B[i, j, k, l])
        Weyl_om, _, _ = weyl_from_mop(L2, Mop_om)
        cross_check_petersen_wink(n, I0, J0, K0, Weyl_om)

    print(f"\n{'='*70}\nSUMMARY\n{'='*70}")
    for r in results:
        if r["idempotent_residual"] is None:
            print(f"n={r['n']}: Weyl(Omega) ~ 0 (|W|={r['weyl_norm']:.2e}) -- no competitor")
        else:
            print(f"n={r['n']}: |W|={r['weyl_norm']:.4f}, idempotent residual={r['idempotent_residual']:.3e}, "
                  f"|P/|W|^3|={r['P_over_norm3']:.6f}, sqrt(3/2)={r['sqrt32']:.6f}, "
                  f"balanced-sphere={r['sphere_val']:.6f}")
