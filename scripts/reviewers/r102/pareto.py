import numpy as np, core, kappa, grads

def unit(W):
    return W / np.linalg.norm(core.to_M(W))

def run(n, lam, W0, rng, outer=200):
    W = unit(W0)
    k2, R = kappa.kappa(W, starts=8, iters=400, rng=rng, return_frame=True)
    th = core.theta_from_M(core.to_M(W), n)
    J = th - lam * k2
    step = 0.08
    for it in range(outer):
        g = grads.grad_theta(W) - lam * grads.grad_kappa2(W, R)
        g = g - (np.sum(g * W) / np.sum(W * W)) * W
        ng = np.linalg.norm(g)
        if ng < 1e-13: break
        Wn = unit(W + step * g / ng)
        k2n, Rn = kappa.kappa_from(Wn, R, iters=60)
        thn = core.theta_from_M(core.to_M(Wn), n)
        Jn = thn - lam * k2n
        if Jn > J:
            W, R, k2, th, J = Wn, Rn, k2n, thn, Jn
            step *= 1.3
        else:
            step *= 0.5
        if step < 1e-9: break
        if it % 25 == 0:   # periodic honest re-optimisation of the frame
            k2f, Rf = kappa.kappa(W, starts=4, iters=300, rng=rng, return_frame=True)
            if k2f > k2: k2, R = k2f, Rf; J = th - lam * k2
    k2, R = kappa.kappa(W, starts=14, iters=800, rng=rng, return_frame=True)
    th = core.theta_from_M(core.to_M(W), n)
    return th, k2, W
