"""Reviewer 61 / C6: exact convex test.  With the two negative directions y,z
fixed and orthonormal, a Weyl_m tensor whose only negative eigenvalues are
-b,-c on span{y,z} exists iff  G = W + b y(x)y + c z(x)z  is PSD with Gy=Gz=0.
Maximise the margin t in  G >= t*Pi  (Pi = projector onto {y,z}^perp),
normalised by b+c=2.  t < 0 certifies infeasibility for that (y,z)."""
import numpy as np, cvxpy as cp, sys
from review_r61_core import weyl_basis, skew_to_vec, vec_to_skew, pairs


def margin(m, y, z, verbose=False, solver='SCS'):
    B = weyl_basis(m)
    D = B.shape[1]
    a = cp.Variable(B.shape[0])
    b = cp.Variable(); c = cp.Variable()
    t = cp.Variable()
    W = cp.sum([a[k]*B[k] for k in range(B.shape[0])]) if False else \
        cp.reshape(cp.matmul(a, B.reshape(B.shape[0], -1)), (D, D), order='C')
    G = W + b*np.outer(y, y) + c*np.outer(z, z)
    Pi = np.eye(D) - np.outer(y, y) - np.outer(z, z)
    cons = [G - t*Pi >> 0, G @ y == 0, G @ z == 0, b + c == 2, b >= 0.05, c >= 0.05]
    prob = cp.Problem(cp.Maximize(t), cons)
    prob.solve(solver=solver, verbose=verbose, eps=1e-7 if solver == 'SCS' else None,
               max_iters=20000)
    Wv = None
    if a.value is not None:
        Wv = np.einsum('k,kij->ij', a.value, B)
    return prob.value, Wv, (b.value, c.value)


def neg_dirs(W):
    lam, V = np.linalg.eigh(W)
    return V[:, 0], V[:, 1], -lam[0], -lam[1]


if __name__ == '__main__':
    from review_r61_c5 import W4, dimU
    rng = np.random.default_rng(2)

    print("=== validation: the C5 witnesses should be feasible (t ~ 0), random (y,z) not ===")
    E = np.eye(6)
    A = [E[0], E[1], E[2], E[3]]; Bp = [E[2], E[3], E[4], E[5]]
    W6 = W4(A, 6, (-2, 1, 1)) + W4(Bp, 6, (-2, 1, 1)); W6 /= np.linalg.norm(W6)
    y, z, b, c = neg_dirs(W6)
    v, Wv, bc = margin(6, y, z)
    print(f"  m=6 witness (y,z): t = {v:+.3e}  (b,c)={np.round(bc,4)}")
    D6 = 15
    for k in range(2):
        Y = rng.normal(size=(D6, 2)); Y, _ = np.linalg.qr(Y)
        v, _, _ = margin(6, Y[:, 0], Y[:, 1])
        print(f"  m=6 random (y,z) #{k}: t = {v:+.3e}")

    E = np.eye(8)
    A = [E[0], E[1], E[2], E[3]]; Bp = [E[4], E[5], E[6], E[7]]
    W8 = W4(A, 8, (-2, 1, 1)) + W4(Bp, 8, (-2, 1, 1)); W8 /= np.linalg.norm(W8)
    y, z, b, c = neg_dirs(W8)
    v, _, bc = margin(8, y, z)
    print(f"  m=8 witness (y,z): t = {v:+.3e}  (b,c)={np.round(bc,4)}")
    D8 = 28
    Y = rng.normal(size=(D8, 2)); Y, _ = np.linalg.qr(Y)
    v, _, _ = margin(8, Y[:, 0], Y[:, 1])
    print(f"  m=8 random (y,z): t = {v:+.3e}")

    print("\n=== C4 test: y NONDEGENERATE, only ONE negative eigenvalue ===")
    # one negative: drop z by taking z with c forced to ~0 -> use a separate program
    def margin_one(m, y):
        B = weyl_basis(m); D = B.shape[1]
        a = cp.Variable(B.shape[0]); t = cp.Variable()
        W = cp.reshape(cp.matmul(a, B.reshape(B.shape[0], -1)), (D, D), order='C')
        G = W + 1.0*np.outer(y, y)
        Pi = np.eye(D) - np.outer(y, y)
        prob = cp.Problem(cp.Maximize(t), [G - t*Pi >> 0, G @ y == 0])
        prob.solve(solver='SCS', eps=1e-7, max_iters=20000)
        return prob.value
    for m in (4, 6, 8):
        p = m//2
        al = np.arange(1, p+1) * 1.0
        X = np.zeros((m, m))
        for i in range(p):
            X[2*i, 2*i+1] = al[i]; X[2*i+1, 2*i] = -al[i]
        yv = skew_to_vec(X, m); yv /= np.linalg.norm(yv)
        print(f"  m={m} y = diag alphas {al}: t = {margin_one(m, yv):+.3e}")
        # complex structure
        X = np.zeros((m, m))
        for i in range(p):
            X[2*i, 2*i+1] = 1.0; X[2*i+1, 2*i] = -1.0
        yv = skew_to_vec(X, m); yv /= np.linalg.norm(yv)
        print(f"  m={m} y = complex structure: t = {margin_one(m, yv):+.3e}")
