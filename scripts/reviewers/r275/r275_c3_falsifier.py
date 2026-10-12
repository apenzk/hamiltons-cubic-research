"""r275 claim 3: independent reproduction of the route-M falsifier screen.

Nothing here imports scripts/reviewers/r274/ (its saved .npy optima are read as
DATA, as seeds and as objects to audit, never as code).

Two optimisers that share no code path:
  A) retraction ascent with an Adam-style adaptive step on the sphere of Weyl_n;
  B) scipy L-BFGS-B on the scale-invariant ambient objective
        f(x) = F( P_W(x)/||P_W(x)|| ) ,
     x ranging over ALL symmetric N x N matrices (P_W is the Weyl projection,
     self-adjoint, so the chain rule is one extra projection).  F is NOT
     homogeneous -- tr(M^3) is cubic and ||M#||_F quadratic -- so the
     normalisation is inside F, not a division by ||W||^3.
Both maximise F(M) = tr(M^3) + ||M#||_F over unit Weyl operators.

Seed families: uniform random Weyl; near S^{n/2} x S^{n/2}; near padded
W_{CP^2}; near padded CP^k for k < n/2; near r274's saved optima.
"""
import sys, os, time, glob
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from scipy.optimize import minimize
from r275_geo import Geo, sphere_product, cp_m, pad, theta0

SQRT3 = np.sqrt(3.0)


# ---------------- optimiser A: adaptive retraction ascent ----------------
def ascent_A(g, M, iters=2500, lr=0.03):
    m1 = np.zeros_like(M); m2 = np.zeros_like(M)
    b1, b2, eps = 0.9, 0.999, 1e-12
    best = g.F(M); bM = M.copy()
    for t in range(1, iters + 1):
        gr = g.proj_weyl(g.grad_F(M))
        gr = gr - np.sum(gr * M) * M               # tangent to the sphere
        m1 = b1 * m1 + (1 - b1) * gr
        m2 = b2 * m2 + (1 - b2) * gr * gr
        step = lr * (m1 / (1 - b1 ** t)) / (np.sqrt(m2 / (1 - b2 ** t)) + eps)
        X = M + step
        X = g.proj_weyl(X); nx = np.linalg.norm(X)
        if nx < 1e-12:
            break
        M = X / nx
        v = g.F(M)
        if v > best:
            best, bM = v, M.copy()
        if t % 400 == 0:
            lr *= 0.55
    return bM, best


# ---------------- optimiser B: L-BFGS on the ambient scale-invariant form ----------------
def _pack(g, M):
    iu = np.triu_indices(g.N)
    return M[iu]


def _unpack(g, x):
    M = np.zeros((g.N, g.N))
    iu = np.triu_indices(g.N)
    M[iu] = x
    return M + M.T - np.diag(np.diag(M))


def ascent_B(g, M0, maxiter=600):
    def fg(x):
        W = g.proj_weyl(_unpack(g, x))
        r = np.linalg.norm(W)
        if r < 1e-10:
            return 0.0, np.zeros_like(x)
        u = W / r
        val = g.F(u)
        gu = g.grad_F(u)
        gr = (gu - u * np.sum(u * gu)) / r          # d/dW of F(W/|W|)
        gA = g.proj_weyl(gr)                        # P_W self-adjoint
        gA = gA + gA.T - np.diag(np.diag(gA))       # packing is the upper triangle
        return -val, -_pack(g, gA)
    res = minimize(fg, _pack(g, M0), jac=True, method='L-BFGS-B',
                   options=dict(maxiter=maxiter, maxfun=4 * maxiter, ftol=1e-16, gtol=1e-12))
    W = g.proj_weyl(_unpack(g, res.x))
    W = W / np.linalg.norm(W)
    return W, g.F(W)


# ---------------- seed families ----------------
def seeds(g, rng, n_rand):
    n = g.n
    out = []
    for _ in range(n_rand):
        A = rng.standard_normal((g.N, g.N))
        W = g.proj_weyl(0.5 * (A + A.T))
        out.append(("random", W / np.linalg.norm(W)))
    def perturbed(name, W, k, scale):
        for _ in range(k):
            A = rng.standard_normal((g.N, g.N))
            P = g.proj_weyl(0.5 * (A + A.T)); P /= np.linalg.norm(P)
            X = g.proj_weyl(W + scale * P); out.append((name, X / np.linalg.norm(X)))
    if n % 2 == 0:
        Wsp = sphere_product(g, n // 2, n // 2)
        out.append(("sphere-product", Wsp)); perturbed("near-sphere", Wsp, 4, 0.25)
        for p in range(2, n // 2):
            if n - p >= 2:
                out.append((f"S^{p}xS^{n-p}", sphere_product(g, p, n - p)))
    for k in range(2, n // 2 + 1):
        if 2 * k <= n:
            gk = Geo(2 * k)
            Wk = cp_m(gk, k)
            Wp = g.proj_weyl(pad(gk, Wk, g)); Wp /= np.linalg.norm(Wp)
            out.append((f"padded CP^{k}", Wp))
            perturbed(f"near-CP^{k}", Wp, 3, 0.30)
    for f in sorted(glob.glob(os.path.join("scripts", "reviewers", "r274", f"best*_n{n}.npy"))):
        A = np.load(f)
        if A.shape == (g.N, g.N):
            W = g.proj_weyl(0.5 * (A + A.T)); W /= np.linalg.norm(W)
            out.append((f"r274:{os.path.basename(f)}", W))
            perturbed(f"near-r274-{os.path.basename(f)}", W, 3, 0.20)
    return out


# ---------------- (d) are r274's saved tensors genuine Weyl operators? ----------------
def audit_r274_tensors():
    print("\n(d)  Are the r274 pipeline's tensors genuine trace-free Bianchi Weyl operators?")
    print("     (checked with r275's own independent projector / tensor conversion)")
    for f in sorted(glob.glob(os.path.join("scripts", "reviewers", "r274", "best*_n*.npy"))):
        A = np.load(f)
        N = A.shape[0]
        n = int(round((1 + np.sqrt(1 + 8 * N)) / 2))
        if n * (n - 1) // 2 != N:
            print(f"  {os.path.basename(f):22s} shape {A.shape} -- not a Lambda^2 operator"); continue
        g = Geo(n)
        R = g.to_tensor(A)
        bia = np.abs(R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))).max()
        ric = np.abs(np.einsum('ijkj->ik', R)).max()
        sym = np.abs(A - A.T).max()
        prj = np.abs(g.proj_weyl(A) - A).max()
        print(f"  {os.path.basename(f):22s} n={n:2d} |A-A^T|={sym:.1e} Bianchi={bia:.1e}"
              f" Ricci={ric:.1e} |P_W A - A|={prj:.1e} |A|={np.linalg.norm(A):.6f}"
              f" tr(A#)={np.trace(g.sharp(A/np.linalg.norm(A))):.9f}")


if __name__ == "__main__":
    audit_r274_tensors()
    print(f"\n  target to beat: sqrt(3) = {SQRT3:.6f}")
    print(f"\n  {'n':>3} {'seeds':>6} {'best F (A)':>12} {'best F (B)':>12} {'best overall':>13}"
          f" {'/sqrt3':>8} {'theta_0':>9} {'F/theta_0':>10} {'best seed family':>26}")
    results = {}
    for n in (6, 8, 10, 12, 14):
        g = Geo(n); rng = np.random.default_rng(275 * 1000 + n)
        S = seeds(g, rng, n_rand=60 if n <= 10 else 40)
        bestA, bestB, bfam, bW, best = -9.0, -9.0, "", None, -9.0
        t0 = time.time()
        fam = {}
        for name, M in S:
            WA, vA = ascent_A(g, M)
            WB, vB = ascent_B(g, WA)          # polish A's answer with a different method
            bestA = max(bestA, vA); bestB = max(bestB, vB)
            v, W = (vB, WB) if vB >= vA else (vA, WA)
            key = name.split(':')[0]
            fam[key] = max(fam.get(key, -9.0), v)
            if v > best:
                best, bfam, bW = v, name, W
        print("      per-family best:", "  ".join(f"{k}={v:.6f}" for k, v in sorted(fam.items())))
        results[n] = (best, bW)
        print(f"  {n:>3} {len(S):>6} {bestA:>12.6f} {bestB:>12.6f} {best:>13.6f}"
              f" {best/SQRT3:>8.4f} {theta0(n):>9.6f} {best/theta0(n):>10.6f} {bfam:>26s}"
              f"   [{time.time()-t0:.0f}s]", flush=True)
        np.save(os.path.join("scripts", "reviewers", "r275", f"r275_bestF_n{n}.npy"), bW)
    hits = [(n, v) for n, (v, _) in results.items() if v > SQRT3]
    print(f"\n  tensors found above sqrt(3): {hits if hits else 'none'}")
