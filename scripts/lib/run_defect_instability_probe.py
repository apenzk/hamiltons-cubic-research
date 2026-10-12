"""Full second-variation Hessian spectra at every catalogued DEFECTIVE critical
point at n=6 and n=8 (plus zero-defect controls), for the instability program:

    TARGET.  Every critical point W with delta^2(W) > 0 and theta > sqrt(3/2)
             is a saddle of P on the unit sphere of W_n.

This script is the falsify/probe stage.  It generalizes the validated
hessian_fast.py pipeline (which only handles coordinate-diagonal W) to an
arbitrary critical operator W, and computes the exact tangent-space Hessian

    Hess(H,H) = 6*T(W,H,H) - 3*theta*||H||^2 ,   H in W_n, H \perp W,

where T(W,H,H) = <W, Q(H)> (proved in FINDINGS "Second-variation Hessian
attempt" + the full symmetry of <A#B,C>).  The quadratic form H -> <W, Q(H)>
is encoded once as an N^2 x N^2 matrix exactly as in hessian_fast.py, with the
one generalization that the diagonal weight vector w becomes the full matrix W:

    <W, H@H>       -> D1 = kron(W, I_N)              (row-major vec)
    <W, H^#>       -> K[n,p,r,m] = -1/2 sum_{a,b} W[a,b] c[a,m,n] c[b,p,r]

VALIDATION ANCHORS (must pass before anything else is trusted):
  A1  n=8 balanced sphere product: eigenvalues match hessian_fast.run(8,4,4)
      as multisets (that pipeline is itself validated bit-for-bit against
      hessian_pipeline_b and reviewed digit-for-digit by Reviewer 2).
  A2  n=8 Fox S^4(alpha): Hessian negative semidefinite with kernel dimension
      exactly the orbit dimension 4n-14 = 18 (FINDINGS: Fox is a local max,
      Result 3 of the spectral-trace section: cap multiplicity = orbit dim).
  A3  random-H spot check of the Qform encoding against Q_fast directly.

For each catalogued point it reports: theta, criticality residual, delta^2,
Hessian eigenvalue counts (pos/zero/neg), max eigenvalue, orbit dimension
(rank of A -> [D_A, W]) vs. Hessian kernel dimension, and diagnostics of the
top eigenvector (overlap with the orbit-tangent space and with the natural
defect-built candidate directions).

Points (all catalogued in FINDINGS):
  n=6: balanced sphere (3,3) [control], Fox, su(3) Kaehler (theta=sqrt(6/5),
       delta^2=5/48), CP^3 Fubini-Study (theta=theta0(6), delta^2=4/45).
  n=8: balanced sphere (4,4) [anchor], Fox [anchor], su(4) Kaehler
       (theta=sqrt(10/9), delta^2=1/10), padded su(3), QK HP^2,
       the sqrt(3/20) violator (delta^2=3/25, from .npy), the theta=0 stratum
       point (delta^2=1/8, from .npy), the balanced 2-block Fox plateau
       (theta=sqrt(3/4), delta^2=1/9), padded CP^3, SU(3) bi-invariant
       [zero-defect control].
"""
import sys
import time
import numpy as np

from weyl import build_structure_constants
from curvature_operator import Lambda2
from weyl_decomposition import weyl_from_mop, mop_from_4tensor, norm, frob
from run_unconstrained_search import build_weyl_basis
from run_unconstrained_search_n12 import Q_fast, build_Cflat
from run_bianchi_defect import build_alt_indices, bianchi_defect, alt_mop, spectral_split
from run_bianchi_defect_highp_seed import pad_weyl_to_n, build_su3_n8, theta0
from run_defect_penalty_test import fox_weyl, sphere_weyl, qk_weyl
from run_defect_max_hunt import su_m_kahler_weyl, fox_on_block

SQRT32 = np.sqrt(1.5)


# ---------------------------------------------------------------------
# The generalized quadratic-form encoding of H -> <W, Q(H)>.
# ---------------------------------------------------------------------
def build_qform_sym_general(Wmat, c):
    """N^2 x N^2 symmetric Qform with vec(H) @ Qform @ vec(H) = <Wmat, Q(H)>
    for symmetric H, Wmat an arbitrary symmetric N x N operator on Lambda^2.
    Reduces to hessian_fast.build_qform_sym when Wmat is diagonal."""
    N = Wmat.shape[0]
    D1 = np.kron(Wmat, np.eye(N))
    wc = np.einsum('ab,bmn->amn', Wmat, c, optimize=True)
    raw = np.einsum('amn,apr->mnpr', wc, c, optimize=True)
    K = -0.5 * np.transpose(raw, (1, 2, 3, 0))   # K[n,p,r,m]
    Qform = D1 + K.reshape(N * N, N * N)
    return 0.5 * (Qform + Qform.T)


def make_ctx(n, verbose=True):
    t0 = time.time()
    L2 = Lambda2(n)
    idx, pos, N, c = build_structure_constants(n)
    Cflat = build_Cflat(c)
    Qfun = lambda W: Q_fast(W, Cflat, N)
    alt_idx = build_alt_indices(L2)
    Eflat, D = build_weyl_basis(n, idx, pos, N, c, verbose=False)
    if verbose:
        print(f"[ctx] n={n}: N={N}, dim Weyl={D}  ({time.time()-t0:.1f}s)")
    return dict(n=n, L2=L2, idx=idx, pos=pos, N=N, c=c, Qfun=Qfun,
                alt_idx=alt_idx, Eflat=Eflat, D=D)


def orbit_tangent_stack(Wmat, ctx):
    """Rows: flattened [D_g, W] for each so(n) basis element g; the row space
    is the tangent space to the O(n)-orbit of W in S^2(Lambda^2).

    Convention check: weyl.py's structure constants satisfy
    [phi_a, phi_b] = sum_g c[a,b,g] phi_g, so the operator by which phi_g
    acts on Lambda^2 is (D_g)_{a,b} = c[g,b,a], i.e. D_g = c[g].T; it is
    antisymmetric (verified numerically in main)."""
    c, N = ctx["c"], ctx["N"]
    rows = []
    for g in range(N):
        Dop = c[g].T
        H = Dop @ Wmat - Wmat @ Dop
        rows.append(H.reshape(-1))
    return np.array(rows)


def analyze_point(label, Wraw, ctx, expected=None, ntop=6, verbose=True):
    n, N, c, Qfun, Eflat, alt_idx = (ctx["n"], ctx["N"], ctx["c"], ctx["Qfun"],
                                     ctx["Eflat"], ctx["alt_idx"])
    W = Wraw / norm(Wraw)
    Q = Qfun(W)
    theta = frob(W, Q)
    if theta < 0:
        W = -W
        Q = Qfun(W)
        theta = frob(W, Q)
    qn = norm(Q)
    resid_abs = norm(Q - theta * W)
    resid_rel = resid_abs / qn if qn > 1e-14 else resid_abs
    d2 = bianchi_defect(W, alt_idx) ** 2

    # membership in Weyl space
    wflat = W.reshape(-1)
    xcoef = Eflat @ wflat
    recon = np.linalg.norm(Eflat.T @ xcoef - wflat)

    # tangent basis (coefficients orthogonal to xcoef)
    D = Eflat.shape[0]
    u = xcoef / np.linalg.norm(xcoef)
    Mrand = np.eye(D) - np.outer(u, u)
    wB, VB = np.linalg.eigh(Mrand)
    B = VB[:, 1:]                          # (D, D-1), orthonormal, perp to u
    Etan = B.T @ Eflat                     # (D-1, N^2)

    Qform = build_qform_sym_general(W, c)

    # A3 spot check of the encoding
    rng = np.random.default_rng(7)
    enc_err = 0.0
    for _ in range(3):
        hcoef = rng.normal(size=D - 1)
        hcoef /= np.linalg.norm(hcoef)
        Hf = Etan.T @ hcoef
        H = Hf.reshape(N, N)
        v1 = Hf @ Qform @ Hf
        v2 = frob(W, Qfun(H))
        enc_err = max(enc_err, abs(v1 - v2))

    M = Etan @ Qform @ Etan.T
    M = 0.5 * (M + M.T)
    Hess = 6.0 * M - 3.0 * theta * np.eye(D - 1)
    evals, evecs = np.linalg.eigh(Hess)

    tol = 1e-6 * max(1.0, abs(evals).max())
    npos = int(np.sum(evals > tol))
    nzero = int(np.sum(np.abs(evals) <= tol))
    nneg = int(np.sum(evals < -tol))

    # orbit dimension
    Ostack = orbit_tangent_stack(W, ctx)
    svals = np.linalg.svd(Ostack, compute_uv=False)
    orbdim = int(np.sum(svals > 1e-9 * max(svals[0], 1e-30)))

    # orbit tangents should be Weyl and in the Hessian kernel
    ocoef = Ostack @ Etan.T                # (N, D-1) coefficients in tangent basis
    orecon = np.linalg.norm(Ostack - (Ostack @ Eflat.T) @ Eflat)
    # quadratic form on the orbit rows
    worst_orbit_hess = 0.0
    for g in range(Ostack.shape[0]):
        hn = np.linalg.norm(ocoef[g])
        if hn < 1e-8:
            continue
        val = ocoef[g] @ Hess @ ocoef[g] / hn ** 2
        worst_orbit_hess = max(worst_orbit_hess, abs(val))

    # orthonormal basis of the orbit-tangent space (in tangent coefficients)
    Uo, so, _ = np.linalg.svd(ocoef.T, full_matrices=False)
    ko = int(np.sum(so > 1e-9 * max(so[0], 1e-30)))
    Ob = Uo[:, :ko]                        # (D-1, ko)

    # top eigenvector diagnostics
    tops = []
    for r in range(1, ntop + 1):
        ev = evals[-r]
        vv = evecs[:, -r]
        in_orbit = np.linalg.norm(Ob.T @ vv)
        tops.append((ev, in_orbit))

    # candidate defect-built directions
    Wm = spectral_split(W)                 # W_-
    cand = {}
    def tang_val(X, name):
        xf = X.reshape(-1)
        hc = Etan @ xf
        hn = np.linalg.norm(hc)
        if hn < 1e-10:
            cand[name] = (0.0, None)
            return
        hc = hc / hn
        val = hc @ Hess @ hc
        ov_top = abs(np.dot(hc, evecs[:, -1]))
        cand[name] = (val, ov_top)
    tang_val(Wm, "P_tan(W_-)")
    # W_+ # W_- direction, via |W|^# = W^# + 4 W_+#W_- (proven, Reviewer 9):
    absW = W + 2.0 * Wm
    sharp_abs = Qfun(absW) - absW @ absW
    sharp_W = Q - W @ W
    WpWm_sharp = 0.25 * (sharp_abs - sharp_W)   # = W_+ # W_-
    tang_val(WpWm_sharp, "P_tan(W_+#W_-)")
    tang_val(W @ W, "P_tan(W^2)")

    status = ("LOCAL MAX (neg-semidef)" if npos == 0 else f"SADDLE ({npos} unstable)")
    if verbose:
        print("-" * 100)
        print(f"{label}   [n={n}]")
        print(f"  theta={theta:+.9f}  resid_rel={resid_rel:.1e} (abs {resid_abs:.1e})  "
              f"delta^2={d2:.9f}  weyl_recon={recon:.1e}  enc_err={enc_err:.1e}")
        print(f"  Hessian: max={evals[-1]:+.6f}  min={evals[0]:+.6f}  "
              f"#pos={npos}  #zero={nzero}  #neg={nneg}   (dim tan={D-1})")
        print(f"  orbit dim={orbdim}  (orbit rows Weyl-recon err {orecon:.1e}, "
              f"worst |Hess| on orbit dirs {worst_orbit_hess:.1e})")
        print(f"  => {status};   lambda_max(L_W|tan) - theta/2 = {evals[-1]/6.0:+.6f}")
        print(f"  top eigenpairs (eval, |proj onto orbit-tangent space|):")
        for ev, po in tops:
            print(f"      {ev:+.6f}   orbit-overlap {po:.3f}")
        for k, (v, ov) in cand.items():
            ovs = "n/a" if ov is None else f"{ov:.3f}"
            print(f"  candidate {k:18s}: Hess value = {v:+.6f}   |<., top evec>| = {ovs}")
    return dict(label=label, n=n, theta=theta, resid=resid_rel, d2=d2,
                evals=evals, npos=npos, nzero=nzero, nneg=nneg,
                orbdim=orbdim, cand=cand, evecs=evecs, Etan=Etan, W=W,
                Hess=Hess)


# ---------------------------------------------------------------------
# Extra constructions
# ---------------------------------------------------------------------
def cp3_weyl(ctx):
    """Fubini-Study CP^3 Weyl tensor at n=6 (or padded block elsewhere):
    T_ijkl = (d_ik d_jl - d_il d_jk) + (J_ik J_jl - J_il J_jk) + 2 J_ij J_kl
    with J the standard complex structure on R^6, then Weyl-projected."""
    n, L2 = ctx["n"], ctx["L2"]
    m = 6
    J = np.zeros((n, n))
    for k in range(3):
        J[2 * k + 1, 2 * k] = 1.0
        J[2 * k, 2 * k + 1] = -1.0
    d = np.eye(n)
    blockset = set(range(m))

    def T(i, j, k, l):
        if not (i in blockset and j in blockset and k in blockset and l in blockset):
            return 0.0
        val = d[i, k] * d[j, l] - d[i, l] * d[j, k]
        val += J[i, k] * J[j, l] - J[i, l] * J[j, k]
        val += 2.0 * J[i, j] * J[k, l]
        return val

    Weyl, Ric, S = weyl_from_mop(L2, mop_from_4tensor(L2, T))
    return Weyl / norm(Weyl)


def plateau2_weyl(ctx):
    L2, Qfun = ctx["L2"], ctx["Qfun"]
    W1 = fox_on_block(L2, (0, 1, 2, 3), Qfun=Qfun)
    W2 = fox_on_block(L2, (4, 5, 6, 7), Qfun=Qfun)
    W = (W1 + W2) / np.sqrt(2.0)
    return W / norm(W)


def main():
    t_start = time.time()
    results = []

    # ============================= n=6 =============================
    ctx6 = make_ctx(6)
    L2_6 = ctx6["L2"]

    results.append(analyze_point("sphere (3,3) balanced [CONTROL]",
                                 sphere_weyl(ctx6, 3), ctx6))
    results.append(analyze_point("Fox S^4(alpha) at n=6 [CONTROL: local max]",
                                 fox_weyl(ctx6), ctx6))
    results.append(analyze_point("su(3) Kaehler (theta=sqrt(6/5), d2=5/48)",
                                 su_m_kahler_weyl(L2_6, 3), ctx6))
    results.append(analyze_point("CP^3 Fubini-Study (theta=theta0(6), d2=4/45)",
                                 cp3_weyl(ctx6), ctx6))

    # ============================= n=8 =============================
    ctx8 = make_ctx(8)
    L2_8 = ctx8["L2"]

    # anchor A1: eigenvalues vs hessian_fast
    r_sph = analyze_point("sphere (4,4) balanced [ANCHOR A1]",
                          sphere_weyl(ctx8, 4), ctx8)
    results.append(r_sph)
    import hessian_fast
    evals_hf, lamP_hf, Dt_hf = hessian_fast.run(8, 4, 4, verbose=False)
    diff = np.max(np.abs(np.sort(evals_hf) - np.sort(r_sph["evals"])))
    print(f"[ANCHOR A1] hessian_fast lambda={lamP_hf:.9f} vs {r_sph['theta']:.9f}; "
          f"max |eig diff| = {diff:.2e}  {'PASS' if diff < 1e-8 else 'FAIL'}")

    r_fox = analyze_point("Fox S^4(alpha) at n=8 [ANCHOR A2]",
                          fox_weyl(ctx8), ctx8)
    results.append(r_fox)
    a2_pass = (r_fox["npos"] == 0 and r_fox["nzero"] == 4 * 8 - 14)
    print(f"[ANCHOR A2] Fox n=8: npos={r_fox['npos']} nzero={r_fox['nzero']} "
          f"(expect 0, 18)  {'PASS' if a2_pass else 'FAIL'}")

    results.append(analyze_point("su(4) Kaehler (theta=sqrt(10/9), d2=1/10)",
                                 su_m_kahler_weyl(L2_8, 4), ctx8))
    W_su3 = su_m_kahler_weyl(L2_6, 3)
    _, W_su3_pad = pad_weyl_to_n(L2_6, W_su3, 8)
    results.append(analyze_point("su(3) Kaehler padded 6->8", W_su3_pad, ctx8))
    results.append(analyze_point("QK HP^2 (n=8)", qk_weyl(ctx8, 2), ctx8))
    Wviol = np.load("scripts/data/defect_violation_n8_0.120000.npy")
    results.append(analyze_point("violator a*Pi_4 - b*Pi_6 (theta=sqrt(3/20), d2=3/25)",
                                 Wviol, ctx8))
    Wth0 = np.load("scripts/data/defect_theta0_n8_0.125000.npy")
    results.append(analyze_point("theta=0 stratum point (d2=1/8)",
                                 Wth0, ctx8))
    results.append(analyze_point("Fox plateau, balanced 2-block (theta=sqrt(3)/2, d2=1/9)",
                                 plateau2_weyl(ctx8), ctx8))
    W_cp3 = cp3_weyl(ctx6)
    _, W_cp3_pad = pad_weyl_to_n(L2_6, W_cp3, 8)
    results.append(analyze_point("CP^3 padded 6->8", W_cp3_pad, ctx8))
    _, Wsu3bi = build_su3_n8()
    results.append(analyze_point("SU(3) bi-invariant (zero-defect control)",
                                 Wsu3bi, ctx8))

    # ============================= summary =============================
    print("=" * 100)
    print("SUMMARY TABLE")
    print(f"{'point':52s} {'n':>2s} {'theta':>10s} {'delta^2':>9s} "
          f"{'maxHess':>9s} {'#pos':>5s} {'#0':>4s} {'#neg':>5s} {'orb':>4s} verdict")
    for r in results:
        verdict = "LOCAL MAX" if r["npos"] == 0 else "SADDLE"
        kernel_eq_orbit = "kern=orb" if r["nzero"] == r["orbdim"] else f"kern={r['nzero']}!=orb"
        print(f"{r['label'][:52]:52s} {r['n']:2d} {r['theta']:10.6f} {r['d2']:9.6f} "
              f"{r['evals'][-1]:+9.5f} {r['npos']:5d} {r['nzero']:4d} {r['nneg']:5d} "
              f"{r['orbdim']:4d} {verdict} ({kernel_eq_orbit})")
    print(f"\ntotal time: {time.time()-t_start:.1f}s")
    return results


if __name__ == "__main__":
    main()
