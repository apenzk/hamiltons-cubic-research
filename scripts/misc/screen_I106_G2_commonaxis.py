# Screen of batch 11's reduction, seconds: for U, V sharing the eigenvector e_2 and diagonal fields A, C,
# Phi = 15/4 tr U^3 + 9/4 tr(U V^2) + tr(UA) + tr(VC) equals the formula in (u2, p, phi, v2, r, chi).
import numpy as np
rng = np.random.default_rng(41)
alpha, beta = 15 / 4, 9 / 4
def refl(t): return np.array([[np.cos(t), np.sin(t)], [np.sin(t), -np.cos(t)]])
def build(x2, amp, ang):
    M = np.zeros((3, 3)); B = -x2 / 2 * np.eye(2) + amp * refl(ang)
    M[np.ix_([0, 2], [0, 2])] = B; M[1, 1] = x2; return M
worst = 0
for t in range(30):
    u2, p, ph, v2, r, ch = rng.normal(size=6); p, r = abs(p), abs(r)
    A = np.diag(rng.normal(size=3)); C = np.diag(rng.normal(size=3))
    U = build(u2, p, 2 * ph); V = build(v2, r, 2 * ch)
    direct = alpha * np.trace(U @ U @ U) + beta * np.trace(U @ V @ V) + np.trace(U @ A) + np.trace(V @ C)
    a, b = -u2 / 2, -v2 / 2; dA = (A[0, 0] - A[2, 2]) / 2; dC = (C[0, 0] - C[2, 2]) / 2
    formula = (alpha * (0.75 * u2 ** 3 - 3 * u2 * p ** 2)
               + beta * (u2 * v2 ** 2 + 2 * a * (b ** 2 + r ** 2) - 2 * p * v2 * r * np.cos(2 * ph - 2 * ch))
               + A[1, 1] * u2 + a * (A[0, 0] + A[2, 2]) + 2 * p * dA * np.cos(2 * ph)
               + C[1, 1] * v2 + b * (C[0, 0] + C[2, 2]) + 2 * r * dC * np.cos(2 * ch))
    worst = max(worst, abs(direct - formula))
    nU = np.sum(U * U) - (1.5 * u2 ** 2 + 2 * p ** 2); nV = np.sum(V * V) - (1.5 * v2 ** 2 + 2 * r ** 2)
    worst = max(worst, abs(nU), abs(nV))
print(f"common-eigenvector reduction of Phi and of the norms: max residual {worst:.1e}")
