# Screen of the 6x6 embedding for G(2) at fixed total norm, seconds, on random traceless symmetric U, V, A, C.
import numpy as np
rng = np.random.default_rng(31)
def tl(): X = rng.normal(size=(3, 3)); X = (X + X.T) / 2; return X - np.trace(X) / 3 * np.eye(3)
alpha, beta = 15 / 4, 9 / 4
for c in (3 + 2 * np.sqrt(2), 3 - 2 * np.sqrt(2)):
    lam = np.sqrt((1 + c ** 2) / 6)
    kappa = beta / (3 * lam ** 2 * (1 + c))
    worst = [0, 0, 0]
    for t in range(20):
        U, V, A, C = tl(), tl(), tl(), tl()
        M = np.block([[U, lam * V], [lam * V, c * U]])
        F = np.block([[A / (1 + c ** 2), C / (2 * lam)], [C / (2 * lam), c * A / (1 + c ** 2)]])
        cub = kappa * np.trace(M @ M @ M) - (alpha * np.trace(U @ U @ U) + beta * np.trace(U @ V @ V))
        nrm = np.sum(M * M) - 4 * lam ** 2 * (1.5 * np.sum(U * U) + 0.5 * np.sum(V * V))
        fld = np.sum(M * F) - (np.trace(U @ A) + np.trace(V @ C))
        worst = [max(worst[0], abs(cub)), max(worst[1], abs(nrm)), max(worst[2], abs(fld))]
    print(f"c = {c:.6f}, lambda^2 = {lam**2:.6f}, kappa = {kappa:.6f}: max residuals cubic {worst[0]:.1e}, norm {worst[1]:.1e}, field {worst[2]:.1e}")
# The commutator identity at a critical point of Phi on 1.5|U|^2 + 0.5|V|^2 = T: with the Lagrange forms
# A = 3 mu U - 3 alpha U^2 - beta V^2 and C = mu V - beta {U,V} (up to multiples of I), for traceless U, V,
# [A, C] = (3 mu^2 + 1.5 alpha beta |U|^2 - 0.5 beta^2 |V|^2) [U,V] - 3 mu (alpha+beta) [U^2,V] + 3 alpha beta U[U,V]U - beta^2 V[U,V]V.
worst = 0
for t in range(20):
    U, V = tl(), tl(); mu = rng.normal()
    A = 3 * mu * U - 3 * alpha * U @ U - beta * V @ V; C = mu * V - beta * (U @ V + V @ U)
    K = U @ V - V @ U
    rhs = (3 * mu ** 2 + 1.5 * alpha * beta * np.sum(U * U) - 0.5 * beta ** 2 * np.sum(V * V)) * K - 3 * mu * (alpha + beta) * (U @ U @ V - V @ U @ U) + 3 * alpha * beta * U @ K @ U - beta ** 2 * V @ K @ V
    worst = max(worst, np.abs((A @ C - C @ A) - rhs).max())
print(f"commutator identity at the Lagrange forms: max residual {worst:.1e}")
