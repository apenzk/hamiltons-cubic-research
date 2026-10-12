"""Diagnostic 3: the GL-congruence Hessian as a function of A.

For a critical point W (unit, Q(W)=theta W) and symmetric traceless A, set
    D_A  = wedge derivation of A on Lambda^2,
    Y_A  = D_A W + W D_A            (Bianchi automatically),
    H_A  = tangent Weyl projection of Y_A,
    h(A) = Hess(H_A,H_A) = 6 T(W,H_A,H_A) - 3 theta ||H_A||^2.

This defines a quadratic form A -> h(A) on Sym_0(R^n).  This script:
  1. builds the full matrix of h on Sym_0 (dim n(n+1)/2 - 1) and reports its
     eigenvalues and the maximizing A's structure, at each catalogued point;
  2. at Fox: identifies the A's with h(A)=0 (the flat GL directions) --
     are they supported on the distinguished 4-plane? do they commute with J?
  3. tests the canonical choices A = traceless Ric(|W|), A = traceless
     Ric(W_-^2), A = traceless Ric(W^2), A = traceless (W.A) fixed points...
  4. checks the conjectured identity Ric({D_A,W}) = c1 * (W.A) with
     (W.A)_{ik} = sum_{j,l} W_{ijkl} A_{jl}   (curvature action on Sym^2).
"""
import numpy as np

from weyl_decomposition import norm, frob, ricci_from_mop, get_entry
from run_bianchi_defect import bianchi_defect, spectral_split
from run_bianchi_defect_highp_seed import build_su3_n8
from run_defect_penalty_test import fox_weyl, sphere_weyl, qk_weyl
from run_defect_max_hunt import su_m_kahler_weyl

from run_defect_instability_probe import (make_ctx, build_qform_sym_general,
                                          cp3_weyl, plateau2_weyl)
from run_defect_instability_diag2 import DA_on_lambda2, sym0_basis


def ric_of_op(Mop, ctx):
    """Ricci contraction of a symmetric operator on Lambda^2 (n x n matrix):
    Ric_{ik} = sum_j R_{ijkj} with R the 4-tensor of Mop."""
    L2, n = ctx["L2"], ctx["n"]
    idx = L2.idx
    Ric = np.zeros((n, n))
    for i in range(n):
        for k in range(i, n):
            v = 0.0
            for j in range(n):
                if j == i or j == k:
                    continue
                v += get_entry(Mop, idx, i, j, k, j)
            Ric[i, k] = Ric[k, i] = v
    return Ric


def w_dot_A(Wmat, A, ctx):
    """(W.A)_{ik} = sum_{jl} W_{ijkl} A_{jl}  -- curvature action on Sym^2."""
    L2, n = ctx["L2"], ctx["n"]
    idx = L2.idx
    out = np.zeros((n, n))
    for i in range(n):
        for k in range(i, n):
            v = 0.0
            for j in range(n):
                for l in range(n):
                    if i == j or k == l:
                        continue
                    v += get_entry(Wmat, idx, i, j, k, l) * A[j, l]
            out[i, k] = out[k, i] = v
    return out


def gl_hessian_form(W, ctx):
    """Matrix of the quadratic form A -> h(A) in an orthonormal basis of
    Sym_0, plus the pieces needed for diagnostics."""
    n, N, c, Qfun, Eflat = ctx["n"], ctx["N"], ctx["c"], ctx["Qfun"], ctx["Eflat"]
    Q = Qfun(W)
    theta = frob(W, Q)
    wflat = W.reshape(-1)
    xcoef = Eflat @ wflat
    D = Eflat.shape[0]
    u = xcoef / np.linalg.norm(xcoef)
    wB, VB = np.linalg.eigh(np.eye(D) - np.outer(u, u))
    B = VB[:, 1:]
    Etan = B.T @ Eflat
    Qform = build_qform_sym_general(W, c)
    M = Etan @ Qform @ Etan.T
    Hess = 6.0 * 0.5 * (M + M.T) - 3.0 * theta * np.eye(D - 1)

    basis = sym0_basis(n)
    hccoefs = []
    for A in basis:
        DA = DA_on_lambda2(A, ctx)
        Y = DA @ W + W @ DA
        hc = Etan @ Y.reshape(-1)
        hccoefs.append(hc)
    hccoefs = np.array(hccoefs)          # (dimSym0, D-1)
    # h(A) as quadratic form in the A-basis: since A -> H_A is LINEAR,
    # h_form[a,b] = hccoefs[a] @ Hess @ hccoefs[b]
    hform = hccoefs @ Hess @ hccoefs.T
    hform = 0.5 * (hform + hform.T)
    # Gram of the map A -> H_A (to normalize: generalized eigenproblem)
    gram = hccoefs @ hccoefs.T
    return dict(theta=theta, hform=hform, gram=gram, basis=basis,
                hccoefs=hccoefs, Etan=Etan, Hess=Hess, W=W)


def analyze(label, Wraw, ctx):
    n = ctx["n"]
    W = Wraw / norm(Wraw)
    Qfun = ctx["Qfun"]
    if frob(W, Qfun(W)) < 0:
        W = -W
    out = gl_hessian_form(W, ctx)
    theta, hform, gram, basis = out["theta"], out["hform"], out["gram"], out["basis"]
    d2 = bianchi_defect(W, ctx["alt_idx"]) ** 2

    # generalized eigenproblem h(A) vs ||H_A||^2: eigenvalues of Hess
    # restricted to the GL image, weighted properly
    wg, Vg = np.linalg.eigh(gram)
    keep = wg > 1e-9 * wg[-1]
    Vk = Vg[:, keep] / np.sqrt(wg[keep])
    Hred = Vk.T @ hform @ Vk           # Hessian per unit ||H_A||
    ev, evec = np.linalg.eigh(Hred)
    print("-" * 100)
    print(f"{label}  [n={n}] theta={theta:+.6f} d2={d2:.6f}: GL-Hess/unit-norm "
          f"spectrum: max={ev[-1]:+.6f} min={ev[0]:+.6f} "
          f"npos={int(np.sum(ev>1e-7))} nzero={int(np.sum(np.abs(ev)<=1e-7))} "
          f"(rank {Vk.shape[1]})")

    # reconstruct the maximizing A (and the zero A's at Fox)
    def A_from_coef(coef_reduced):
        coef = Vk @ coef_reduced
        A = sum(cc * Ab for cc, Ab in zip(coef, basis))
        return A / np.linalg.norm(A)

    Amax = A_from_coef(evec[:, -1])
    # structure of Amax: eigenvalues, commutation with W's distinguished bits
    evA = np.linalg.eigvalsh(Amax)
    print(f"  maximizing A eigenvalues: {np.round(evA, 4)}")

    # canonical A tests
    Wm = spectral_split(W)
    absW = W + 2.0 * Wm
    tests = {
        "Ric(|W|)_0": ric_of_op(absW, ctx),
        "Ric(W_-^2)_0": ric_of_op(Wm @ Wm, ctx),
        "Ric(W^2)_0": ric_of_op(W @ W, ctx),
    }
    for name, Araw in tests.items():
        A0 = Araw - np.trace(Araw) / n * np.eye(n)
        nA = np.linalg.norm(A0)
        if nA < 1e-12:
            print(f"  A={name:12s}: traceless part = 0 (skipped)")
            continue
        A0 /= nA
        DA = DA_on_lambda2(A0, ctx)
        Y = DA @ W + W @ DA
        hc = out["Etan"] @ Y.reshape(-1)
        nh = np.linalg.norm(hc)
        if nh < 1e-10:
            print(f"  A={name:12s}: H_A = 0 (radial/stab direction)")
            continue
        val = hc @ out["Hess"] @ hc / nh ** 2
        print(f"  A={name:12s}: Hess(H_A)/||H_A||^2 = {val:+.6f}  (||H_A||={nh:.3f})")

    return out, Vk, evec, ev, basis


def main():
    ctx6 = make_ctx(6)
    L2_6 = ctx6["L2"]

    # 4. constant in Ric({D_A,W}) = c1 * (W.A) -- test on random A at Fox and CP^3
    rng = np.random.default_rng(0)
    for lbl, W in [("Fox n=6", fox_weyl(ctx6)), ("CP^3", cp3_weyl(ctx6)),
                   ("su(3)", su_m_kahler_weyl(L2_6, 3) / norm(su_m_kahler_weyl(L2_6, 3)))]:
        A = rng.normal(size=(6, 6)); A = 0.5 * (A + A.T); A -= np.trace(A) / 6 * np.eye(6)
        DA = DA_on_lambda2(A, ctx6)
        Y = DA @ W + W @ DA
        RicY = ric_of_op(Y, ctx6)
        WA = w_dot_A(W, A, ctx6)
        # fit RicY = c1 * WA + c2 * (A-term)? Ric(W)=0 so try single term
        c1 = frob(RicY, WA) / max(frob(WA, WA), 1e-30)
        res = norm(RicY - c1 * WA) / max(norm(RicY), 1e-30)
        print(f"[Ric(Y) vs W.A] {lbl}: c1={c1:+.6f}, rel residual={res:.2e}")

    analyze("sphere (3,3) [max]", sphere_weyl(ctx6, 3), ctx6)
    o_fox = analyze("Fox n=6 [max]", fox_weyl(ctx6), ctx6)
    analyze("su(3) [max]", su_m_kahler_weyl(L2_6, 3), ctx6)
    analyze("CP^3 [saddle]", cp3_weyl(ctx6), ctx6)

    # Fox flat GL directions: what are the A's with h(A)=0?
    out, Vk, evec, ev, basis = o_fox
    W = out["W"]
    nz = np.abs(ev) <= 1e-7
    print(f"\nFox n=6: {int(nz.sum())} flat GL directions; structure of each A:")
    for i in np.where(nz)[0]:
        coef = Vk @ evec[:, i]
        A = sum(cc * Ab for cc, Ab in zip(coef, basis))
        A /= np.linalg.norm(A)
        blk4 = np.linalg.norm(A[:4, :4])
        blkc = np.linalg.norm(A[4:, 4:])
        mix = np.linalg.norm(A[:4, 4:])
        # commutation with J on the 4-plane
        J = np.zeros((6, 6))
        J[1, 0] = 1; J[0, 1] = -1; J[3, 2] = 1; J[2, 3] = -1
        cj = np.linalg.norm(A @ J - J @ A)
        aj = np.linalg.norm(A @ J + J @ A)
        print(f"  flat A: |A_44|={blk4:.3f} |A_cc|={blkc:.3f} |A_mix|={mix:.3f} "
              f" ||[A,J]||={cj:.3f} ||{{A,J}}||={aj:.3f} eig={np.round(np.linalg.eigvalsh(A),3)}")

    ctx8 = make_ctx(8)
    L2_8 = ctx8["L2"]
    analyze("Fox n=8 [max]", fox_weyl(ctx8), ctx8)
    analyze("su(4) [saddle]", su_m_kahler_weyl(L2_8, 4), ctx8)
    analyze("QK HP^2 [max]", qk_weyl(ctx8, 2), ctx8)
    analyze("violator [saddle]", np.load("scripts/data/defect_violation_n8_0.120000.npy"), ctx8)
    analyze("plateau 2-block [saddle]", plateau2_weyl(ctx8), ctx8)
    _, Wsu3bi = build_su3_n8()
    analyze("SU(3) bi-invariant [saddle]", Wsu3bi, ctx8)


if __name__ == "__main__":
    main()
