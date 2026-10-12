"""Diagnostic 2 for the instability program: WHAT are the unstable directions?

Hypothesis under test (motivated by the multiplicity 8 = dim Herm_0(3) at CP^3):
the unstable directions at the defective saddles are GL(n)-congruence
directions.  For symmetric traceless A on R^n let D_A be the induced
symmetric operator on Lambda^2 (derivation of the wedge action,
D_A(e_i ^ e_j) = (A e_i)^e_j + e_i^(A e_j)); the congruence flow
W -> (L2 g) W (L2 g)^T differentiates to the anticommutator {D_A, W},
which is automatically Bianchi (GL(n) preserves the Bianchi subspace)
but not Ricci-free; its tangent Weyl projection is the candidate direction.

For each catalogued point this script reports:
  - dim of the GL-direction subspace  V_GL = Pi_tan{ {D_A,W} : A in Sym_0 }
  - the Hessian eigenvalues of the compression to V_GL (a small matrix)
  - the overlap of the FULL Hessian's unstable eigenspace with V_GL
  - same for the orthogonal-orbit space (control: should carry Hess=0)
  - block structure of the top eigenvector w.r.t. the spectral projections
    of W (P_+, P_-, P_0) and its commutator norm with W.
"""
import numpy as np

from weyl import build_structure_constants
from curvature_operator import Lambda2
from weyl_decomposition import norm, frob
from run_bianchi_defect import build_alt_indices, bianchi_defect, alt_mop, spectral_split
from run_bianchi_defect_highp_seed import pad_weyl_to_n, build_su3_n8
from run_defect_penalty_test import fox_weyl, sphere_weyl, qk_weyl
from run_defect_max_hunt import su_m_kahler_weyl

from run_defect_instability_probe import (make_ctx, build_qform_sym_general,
                                          orbit_tangent_stack, cp3_weyl,
                                          plateau2_weyl)


def DA_on_lambda2(A, ctx):
    """Induced operator on Lambda^2 from a symmetric n x n matrix A:
    in the pair basis phi_{ij} (i<j), (D_A)_{(kl),(ij)} coefficient of
    phi_kl in A e_i ^ e_j + e_i ^ A e_j."""
    idx, N, n = ctx["idx"], ctx["N"], ctx["n"]
    pos = ctx["pos"]
    D = np.zeros((N, N))
    for a, (i, j) in enumerate(idx):
        # A e_i ^ e_j = sum_k A[k,i] e_k ^ e_j ; e_i ^ A e_j = sum_k A[k,j] e_i ^ e_k
        for k in range(n):
            if k != j:
                p, q, s = (k, j, 1.0) if k < j else (j, k, -1.0)
                D[pos[(p, q)], a] += s * A[k, i]
            if k != i:
                p, q, s = (i, k, 1.0) if i < k else (k, i, -1.0)
                D[pos[(p, q)], a] += s * A[k, j]
    return D


def sym0_basis(n):
    out = []
    for i in range(n):
        for j in range(i + 1, n):
            A = np.zeros((n, n))
            A[i, j] = A[j, i] = 1.0 / np.sqrt(2.0)
            out.append(A)
    for k in range(1, n):
        d = np.zeros(n)
        d[:k] = 1.0
        d[k] = -float(k)
        out.append(np.diag(d) / np.linalg.norm(d))
    return out


def analyze(label, Wraw, ctx, tol_pos=1e-6):
    n, N, c, Qfun, Eflat = ctx["n"], ctx["N"], ctx["c"], ctx["Qfun"], ctx["Eflat"]
    W = Wraw / norm(Wraw)
    Q = Qfun(W)
    theta = frob(W, Q)
    if theta < 0:
        W = -W
        theta = -theta
    d2 = bianchi_defect(W, ctx["alt_idx"]) ** 2

    wflat = W.reshape(-1)
    xcoef = Eflat @ wflat
    D = Eflat.shape[0]
    u = xcoef / np.linalg.norm(xcoef)
    wB, VB = np.linalg.eigh(np.eye(D) - np.outer(u, u))
    B = VB[:, 1:]
    Etan = B.T @ Eflat

    Qform = build_qform_sym_general(W, c)
    M = Etan @ Qform @ Etan.T
    M = 0.5 * (M + M.T)
    Hess = 6.0 * M - 3.0 * theta * np.eye(D - 1)
    evals, evecs = np.linalg.eigh(Hess)
    hmax = evals[-1]
    npos = int(np.sum(evals > tol_pos * max(1.0, abs(evals).max())))

    # unstable eigenspace
    tolp = tol_pos * max(1.0, abs(evals).max())
    Upos = evecs[:, evals > tolp]         # (D-1, npos)

    # GL-congruence directions
    rows = []
    for A in sym0_basis(n):
        DA = DA_on_lambda2(A, ctx)
        H = DA @ W + W @ DA
        rows.append(H.reshape(-1))
    GLstack = np.array(rows)              # (dim Sym0, N^2)
    # sanity: Bianchi (Alt of each row ~ 0)
    alt_err = 0.0
    for r in rows[:4]:
        alt_err = max(alt_err, norm(alt_mop(r.reshape(N, N), ctx["alt_idx"])))
    glcoef = GLstack @ Etan.T             # coefficients in tangent basis (Weyl proj!)
    Ug, sg, _ = np.linalg.svd(glcoef.T, full_matrices=False)
    kg = int(np.sum(sg > 1e-9 * max(sg[0], 1e-30)))
    Vgl = Ug[:, :kg]                      # (D-1, kg) orthonormal

    # Hessian compressed to V_GL
    Hgl = Vgl.T @ Hess @ Vgl
    egl = np.linalg.eigvalsh(Hgl)
    npos_gl = int(np.sum(egl > tolp))

    # overlap of unstable space with V_GL
    if Upos.shape[1] > 0:
        ov = np.linalg.svd(Vgl.T @ Upos, compute_uv=False)
        # fraction of unstable space captured: singular values in [0,1]
        cap = float(np.sum(ov ** 2)) / Upos.shape[1]
        mins = float(ov.min()) if len(ov) >= Upos.shape[1] else 0.0
    else:
        cap, mins = float("nan"), float("nan")

    # orbit control
    Ostack = orbit_tangent_stack(W, ctx)
    ocoef = Ostack @ Etan.T
    Uo, so, _ = np.linalg.svd(ocoef.T, full_matrices=False)
    ko = int(np.sum(so > 1e-9 * max(so[0], 1e-30)))

    # top eigenvector block structure
    w_eig, V_eig = np.linalg.eigh(W)
    tolw = 1e-7 * max(1.0, abs(w_eig).max())
    Pp = V_eig[:, w_eig > tolw]
    Pm = V_eig[:, w_eig < -tolw]
    P0 = V_eig[:, np.abs(w_eig) <= tolw]
    Htop = (Etan.T @ evecs[:, -1]).reshape(N, N)
    def bl(Pa, Pb):
        return np.linalg.norm(Pa.T @ Htop @ Pb)
    comm = np.linalg.norm(Htop @ W - W @ Htop)
    # overlap of top evec with V_GL
    ov_top = np.linalg.norm(Vgl.T @ evecs[:, -1])

    print("-" * 100)
    print(f"{label}  [n={n}]  theta={theta:+.6f}  d2={d2:.6f}")
    print(f"  Hess: max={hmax:+.6f}  npos={npos};  GL-subspace dim={kg} "
          f"(Bianchi err {alt_err:.1e}), orbit dim={ko}")
    print(f"  Hess|GL: max={egl[-1]:+.6f}  min={egl[0]:+.6f}  npos={npos_gl}")
    print(f"  unstable-space capture by GL dirs: {cap:.4f} (1.0 = fully inside); "
          f"|Vgl^T top| = {ov_top:.4f}")
    print(f"  top evec blocks |P+HP+|={bl(Pp,Pp):.3f} |P-HP-|={bl(Pm,Pm):.3f} "
          f"|P0HP0|={bl(P0,P0):.3f} |P+HP-|={bl(Pp,Pm):.3f} |P+HP0|={bl(Pp,P0):.3f} "
          f"|P-HP0|={bl(Pm,P0):.3f}  ||[H,W]||={comm:.3f}")
    return dict(theta=theta, d2=d2, hmax=hmax, npos=npos, kg=kg,
                egl_max=egl[-1], npos_gl=npos_gl, cap=cap)


def main():
    ctx6 = make_ctx(6)
    L2_6 = ctx6["L2"]
    analyze("sphere (3,3) [control max]", sphere_weyl(ctx6, 3), ctx6)
    analyze("Fox n=6 [control max]", fox_weyl(ctx6), ctx6)
    analyze("su(3) Kaehler [max]", su_m_kahler_weyl(L2_6, 3), ctx6)
    analyze("CP^3 [saddle mult 8]", cp3_weyl(ctx6), ctx6)

    ctx8 = make_ctx(8)
    L2_8 = ctx8["L2"]
    analyze("Fox n=8 [control max]", fox_weyl(ctx8), ctx8)
    analyze("su(4) Kaehler [saddle mult 3]", su_m_kahler_weyl(L2_8, 4), ctx8)
    analyze("QK HP^2 [max]", qk_weyl(ctx8, 2), ctx8)
    analyze("violator sqrt(3/20) [saddle 66]",
            np.load("scripts/data/defect_violation_n8_0.120000.npy"), ctx8)
    analyze("theta=0 stratum [saddle 114]",
            np.load("scripts/data/defect_theta0_n8_0.125000.npy"), ctx8)
    analyze("Fox plateau 2-block [saddle 11]", plateau2_weyl(ctx8), ctx8)
    _, Wsu3bi = build_su3_n8()
    analyze("SU(3) bi-invariant [saddle 8]", Wsu3bi, ctx8)


if __name__ == "__main__":
    main()
