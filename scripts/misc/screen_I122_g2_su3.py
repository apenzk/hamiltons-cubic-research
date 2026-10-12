"""Checks a positive, full-range, non-scalar sharp-eigenoperator on the simple Lie algebra g2.

g2 is the stabiliser in so(7) of the 3-form phi, su(3) the stabiliser in g2 of the unit vector e7,
m their orthogonal complement in g2 (the real 6-dimensional C^3). With the record's metric and #
(so(7)'s structure constants in the e_ij basis, I#I = 5I), G = P_su3 + r P_m, supported on g2 and
positive definite there, satisfies G#G = lambda G at r = 1 (scalar on g2) and, by the two-weight
equations with kappa/C = h(su3)/h(g2) = 3/4, at r = 1/3. Prints the residual |G#G - lambda G| over
a grid of r and the value <G#G,G>/|G|^3 at both roots.
Run: sage -python scripts/misc/screen_I122_g2_su3.py   (seconds)
"""
import itertools
import numpy as np
from scipy.linalg import null_space

m = 7
P = list(itertools.combinations(range(m), 2)); N = len(P)
E = []
for (i, j) in P:
    X = np.zeros((m, m)); X[i, j] = 1; X[j, i] = -1; E.append(X)
c = np.zeros((N, N, N))
for a in range(N):
    for b in range(N):
        C = E[a] @ E[b] - E[b] @ E[a]
        for g in range(N):
            c[a, b, g] = 0.5 * np.sum(C * E[g])

def sharp(G):
    GXG = np.einsum('ge,aed,dz->agz', G, c, G, optimize=True)
    return 0.5 * np.einsum('agz,bgz->ab', GXG, c, optimize=True)

assert np.allclose(sharp(np.eye(N)), (m - 2) * np.eye(N))
phi = np.zeros((m,) * 3)
for (a, b, cc), s in [((0, 1, 2), 1), ((0, 3, 4), 1), ((0, 5, 6), 1), ((1, 3, 5), 1),
                      ((1, 4, 6), -1), ((2, 3, 6), -1), ((2, 4, 5), -1)]:
    for p in itertools.permutations(range(3)):
        idx = tuple((a, b, cc)[k] for k in p)
        sgn = np.linalg.det(np.eye(3)[list(p)])
        phi[idx] = s * sgn
def act(X):  # derivation action of X on phi
    return (np.einsum('da,dbc->abc', X, phi) + np.einsum('db,adc->abc', X, phi)
            + np.einsum('dc,abd->abc', X, phi))
A = np.array([act(X).ravel() for X in E]).T          # columns: e_ij
g2 = null_space(A); assert g2.shape[1] == 14          # coordinates in the orthonormal e_ij basis
e7 = np.zeros(m); e7[6] = 1
B = np.array([(sum(v[k] * E[k] for k in range(N)) @ e7) for v in g2.T]).T
su3 = g2 @ null_space(B); assert su3.shape[1] == 8
Pg2 = g2 @ g2.T; Psu3 = su3 @ su3.T; Pm = Pg2 - Psu3
assert np.linalg.matrix_rank(Pm, 1e-9) == 6
def resid(r):
    G = Psu3 + r * Pm; S = sharp(G); lam = np.sum(S * G) / np.sum(G * G)
    return np.linalg.norm(S - lam * G), lam, np.sum(S * G) / np.linalg.norm(G) ** 3
for r in (0.2, 1/3, 0.5, 0.8, 1.0, 1.5):
    res, lam, T = resid(r)
    print(f"r = {r:.4f}: |G#G - lambda G| = {res:.2e}, lambda = {lam:.6f}, <G#G,G>/|G|^3 = {T:.6f}")
