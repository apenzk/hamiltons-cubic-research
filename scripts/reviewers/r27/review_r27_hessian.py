"""Reviewer 27, claim (A): the constrained Hessian identity, checked against the definition."""
import numpy as np
import review_r27_core as C, review_r27_points as PT, review_r27_measure as M

rng = np.random.default_rng(7)


def check(n, W, name, ntest=6):
    QW = C.Q(n, W)
    theta = float(np.trace(W @ QW))
    print('%s  theta=%.12f  crit res %.2e' % (name, theta, np.linalg.norm(QW - theta * W)))
    B = C.weyl_basis(n)
    coW = np.einsum('kab,ab->k', B, W)
    worst = 0.0
    for _ in range(ntest):
        co = rng.normal(size=B.shape[0]); co -= (co @ coW) * coW
        co /= np.linalg.norm(co)
        v = np.einsum('k,kab->ab', co, B)
        # exact great-circle second derivative, by high-order finite difference
        def f(t):
            X = np.cos(t) * W + np.sin(t) * v
            return C.P(n, X)
        h = 1e-3
        d2 = (-f(2 * h) + 16 * f(h) - 30 * f(0) + 16 * f(-h) - f(-2 * h)) / (12 * h * h)
        pred = 6 * theta * (np.trace(v @ C.circ(n, W / theta, v)) - 0.5)
        worst = max(worst, abs(d2 - pred))
        # also the ambient-Lagrange form: D^2 P - 2 mu Id with mu = 3 theta/2
        amb = 6 * np.trace(v @ C.circ(n, W, v)) - 3 * theta * np.trace(v @ v)
        assert abs(amb - pred) < 1e-9 * max(1, abs(pred))
    print('   max |geodesic f\'\'(0) - 6 theta (<v,L_e v> - 1/2)| over %d random tangents = %.3e' % (ntest, worst))
    # off-tangent sanity: at v = W itself the ambient formula must give the radial value
    print('   <e, L_e e> (must be 1, e idempotent) = %.15f' % (np.trace((W / theta) @ C.circ(n, W / theta, W / theta)) / np.trace((W / theta) @ (W / theta))))


if __name__ == '__main__':
    W, r, Pi = PT.W_subalgebra(8, PT.gens_so_direct_sum(8, [4, 4]))
    check(8, W, 'so(4)+so(4) n=8')
    g, f, d = PT.gens_su3_adjoint()
    W, r, Pi = PT.W_subalgebra(8, g)
    check(8, W, 'su(3) adjoint n=8')
    W, r, Pi = PT.W_subalgebra(5, PT.gens_so3_in_so5())
    check(5, W, 'so(3) in so(5)')
