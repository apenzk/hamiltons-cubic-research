"""Reviewer 61 / C5: rebuild the claimed full-support, two-negative-eigenvalue
witnesses independently and screen them (Ricci, Bianchi, unit norm, negative
count, dim U, theta)."""
import numpy as np, itertools
from review_r61_core import (pairs, pair_index, vec_to_skew, skew_to_vec,
                             ricci_defect, bianchi_defect, theta, weyl_basis,
                             project_weyl)


def selfdual(fs, m):
    """orthonormal self-dual 2-forms on the 4-plane spanned by fs (4 vectors in R^m),
    returned as coordinate vectors in Lambda^2 R^m, each of unit norm."""
    f1, f2, f3, f4 = fs
    def wedge(a, b):
        X = np.outer(a, b) - np.outer(b, a)
        return skew_to_vec(X, m)
    w1 = (wedge(f1, f2) + wedge(f3, f4)) / 2.0
    w2 = (wedge(f1, f3) + wedge(f4, f2)) / 2.0
    w3 = (wedge(f1, f4) + wedge(f2, f3)) / 2.0
    return [w1, w2, w3]


def W4(fs, m, coeffs):
    """padded Weyl_4 element sum_i c_i w_i (x) w_i with sum c_i = 0."""
    ws = selfdual(fs, m)
    D = m * (m - 1) // 2
    W = np.zeros((D, D))
    for c, w in zip(coeffs, ws):
        W += c * np.outer(w, w)
    return W


def dimU(W, tol=1e-9):
    m = int(round((1 + np.sqrt(1 + 8 * W.shape[0])) / 2))
    lam, V = np.linalg.eigh(W)
    order = np.argsort(lam)          # most negative first
    imgs = []
    for k in order[:2]:
        X = vec_to_skew(V[:, k], m)
        u, s, _ = np.linalg.svd(X)
        imgs.append(u[:, s > tol * max(1.0, s[0])])
    M = np.hstack(imgs)
    return np.linalg.matrix_rank(M, tol=1e-8), lam


def screen(W, m, name):
    W = W / np.linalg.norm(W)
    lam = np.linalg.eigvalsh(W)
    nneg = int((lam < -1e-9).sum())
    npos = int((lam > 1e-9).sum())
    du, lam2 = dimU(W)
    pw = np.linalg.norm(W - project_weyl(W, m))
    print(f"  {name}: |W|=1 ricci={ricci_defect(W,m):.1e} bianchi={bianchi_defect(W,m):.1e}"
          f" dist(Weyl)={pw:.1e} neg={nneg} pos={npos} dim U={du} theta={theta(W,m):+.6f}")
    print(f"     nonzero spectrum: {np.round(lam[np.abs(lam)>1e-9],6)}")
    return nneg, du


if __name__ == '__main__':
    print("=== m=8, two ORTHOGONAL 4-planes, q=r ===")
    m = 8
    E = np.eye(m)
    A = [E[0], E[1], E[2], E[3]]
    B = [E[4], E[5], E[6], E[7]]
    W = W4(A, m, (-2, 1, 1)) + W4(B, m, (-2, 1, 1))
    screen(W, m, "orthogonal padding")

    print("\n=== m=6, 4-planes OVERLAPPING in a 2-plane ===")
    m = 6
    E = np.eye(m)
    A = [E[0], E[1], E[2], E[3]]
    B = [E[2], E[3], E[4], E[5]]
    for lbl, cA, cB in [("q=r both", (-2, 1, 1), (-2, 1, 1)),
                        ("q=r, B flipped", (-2, 1, 1), (1, -2, 1)),
                        ("(-3,1.5,1.5)/(-3,1.5,1.5)", (-3, 1.5, 1.5), (-3, 1.5, 1.5))]:
        W = W4(A, m, cA) + W4(B, m, cB)
        screen(W, m, lbl)

    print("\n=== m=6: sweep coefficients and B-plane orientation for 2 negatives + dim U=6 ===")
    rng = np.random.default_rng(5)
    best = []
    for trial in range(4000):
        cA = rng.normal(size=3); cA -= cA.mean()
        cB = rng.normal(size=3); cB -= cB.mean()
        W = W4(A, m, cA) + W4(B, m, cB)
        if np.linalg.norm(W) < 1e-8:
            continue
        W /= np.linalg.norm(W)
        lam = np.linalg.eigvalsh(W)
        nneg = int((lam < -1e-9).sum())
        if nneg <= 2:
            du, _ = dimU(W)
            best.append((nneg, du, theta(W, 6), cA.copy(), cB.copy(),
                         np.round(lam[np.abs(lam) > 1e-9], 6)))
    print(f"  found {len(best)} samples with <=2 negative eigenvalues")
    seen = set()
    for nneg, du, th, cA, cB, sp in sorted(best, key=lambda t: -t[2])[:6]:
        print(f"   neg={nneg} dimU={du} theta={th:+.6f} cA={np.round(cA,4)} cB={np.round(cB,4)}")
        print(f"      spec={sp}")
