"""N2: lambda_max(L_e) on W-perp and on the graded slice, at the sphere products."""
import sys, time
sys.path.insert(0, 'scripts/reviewers/r316')
import numpy as np, core
from scipy.sparse.linalg import LinearOperator, eigsh


def report(n, a, dense_ok=True, k=80):
    alg = core.Alg(n); pr = core.ProjFast(alg)
    W = core.sphere_product_weyl(alg, a)
    sh = core.Sharp(alg, W)
    QW = alg.Q(W); PQ = pr.apply(QW)
    th = float(np.sum(PQ * W))
    crit = np.linalg.norm(PQ - th * W)
    sg = core.grading_involution(alg, a)
    Wf = W.reshape(-1)

    def op_full(v):
        H = pr.apply(v.reshape(alg.N, alg.N))
        H = H - np.sum(H * W) * W
        Y = pr.apply(sh.L(H))
        Y = Y - np.sum(Y * W) * W
        return Y.reshape(-1)

    def op_slice(v):
        H = 0.5 * (v.reshape(alg.N, alg.N) + sg * v.reshape(alg.N, alg.N))
        H = pr.apply(H); H = 0.5 * (H + sg * H)
        H = H - np.sum(H * W) * W
        Y = pr.apply(sh.L(H)); Y = 0.5 * (Y + sg * Y)
        Y = Y - np.sum(Y * W) * W
        return Y.reshape(-1)

    D = alg.N * alg.N
    out = {}
    for name, op in (('full', op_full), ('slice', op_slice)):
        A = LinearOperator((D, D), matvec=op, dtype=float)
        w = eigsh(A, k=k, which='LA', return_eigenvectors=False, tol=0, maxiter=20000)
        out[name] = np.sort(w)[::-1] / th
    # orbit tangent dimension and check they are 1/2-eigenvectors
    tang = []
    for X in range(alg.N):
        Hh = alg.A[X] @ W - W @ alg.A[X]
        if np.linalg.norm(Hh) > 1e-10:
            tang.append(Hh.reshape(-1))
    if tang:
        T = np.array(tang); r = np.linalg.matrix_rank(T, tol=1e-8)
        q = np.linalg.qr(T.T)[0]
        ray = [float(np.sum(q[:, i].reshape(alg.N, alg.N) * sh.L(q[:, i].reshape(alg.N, alg.N))) / th)
               for i in range(q.shape[1])]
        gradedness = float(np.linalg.norm(q - 0.5 * (q + (sg.reshape(-1)[:, None] * q))))
    else:
        r, ray, gradedness = 0, [], 0.0
    print(f"n={n} S^{a}xS^{n-a}: theta={th:.9f} crit={crit:.1e} orbit-tangent dim={r} "
          f"Rayleigh on tangent in [{min(ray):.12f},{max(ray):.12f}] "
          f"tangent-in-slice-part={np.linalg.norm(0.5*(q+(sg.reshape(-1)[:,None]*q))):.2e}")
    f = out['full']; s = out['slice']
    nhalf = int(np.sum(f > 0.5 - 1e-9))
    print(f"   FULL  lam_max={f[0]:.12f}  #(=1/2)={nhalf}  next below 1/2 = {f[nhalf] if nhalf<len(f) else None}")
    print(f"   SLICE lam_max={s[0]:.12f}  gap to 1/2 = {0.5-s[0]:.9f}   top5={np.round(s[:5],9)}")
    return th, f, s


if __name__ == '__main__':
    for n, a in [(8, 3), (8, 4), (10, 5), (10, 4)]:
        t = time.time(); report(n, a); print('   %.1fs' % (time.time() - t), flush=True)
