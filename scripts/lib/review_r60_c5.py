"""Reviewer 60, C5: rebuild the claimed full-support dim m_neg <= 2 witnesses from scratch."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
from review_r60_core import *
from review_r60_q import theta, Q

TOL = 1e-9


def selfdual(m, plane):
    """the three self-dual 2-forms of the 4-plane 'plane' = (a,b,c,d), as UNIT skew m x m matrices"""
    a, b, c, d = plane
    out = []
    for (p, q) in [(((a, b), (c, d))), (((a, c), (d, b))), (((a, d), (b, c)))]:
        X = phi(m, *p) + phi(m, *q)
        out.append(X / np.sqrt(ip(X, X)))
    return out


def W4_padded(m, plane, q, r):
    w = selfdual(m, plane)
    v = [mat_to_vec(m, X) for X in w]
    return (-(q + r) * np.outer(v[0], v[0]) + q * np.outer(v[1], v[1]) + r * np.outer(v[2], v[2]))


def analyse(m, W, name):
    ric, bia, sy = is_weyl(m, W)
    nrm = np.linalg.norm(W)
    lam, V = np.linalg.eigh(W)
    scale = max(1.0, abs(lam).max())
    nneg = int(np.sum(lam < -TOL * scale))
    npos = int(np.sum(lam > TOL * scale))
    order = np.argsort(lam)                     # most negative first
    U = []
    for a in order[:2]:
        U.append(vec_to_mat(m, V[:, a]))
    Ucols = np.hstack([X for X in U])
    dimU = np.linalg.matrix_rank(Ucols, tol=1e-8)
    dimU1 = np.linalg.matrix_rank(vec_to_mat(m, V[:, order[-1]]), tol=1e-8)  # im v_1 (top positive)
    print(f"\n[{name}]  m={m}")
    print(f"  Ricci-flat residual   : {ric:.3e}")
    print(f"  first-Bianchi residual: {bia:.3e}")
    print(f"  symmetry residual     : {sy:.3e}")
    print(f"  |W|_F                 : {nrm:.9f}")
    print(f"  normalised spectrum   : {np.round(np.sort(lam)/nrm, 6)}")
    print(f"  (n_neg, n_pos)        : ({nneg}, {npos})")
    print(f"  dim U = rk(im v_N + im v_(N-1)) : {dimU}   [m = {m}]")
    print(f"  rank of top positive eigenvector: {dimU1}")
    print(f"  theta = <W,Q(W)>/|W|^3          : {theta(m, W):.9f}")
    return dict(ric=ric, bia=bia, nneg=nneg, dimU=dimU, theta=theta(m, W), lam=np.sort(lam)/nrm)


# --- base case: W4(q,r) on R^4 ---
W = W4_padded(4, (0, 1, 2, 3), 0.5, 0.5)
analyse(4, W, "base W4(1/2,1/2) on R^4")

# --- m=8, two ORTHOGONAL 4-planes ---
q = r = 0.5
W8 = W4_padded(8, (0, 1, 2, 3), q, r) + W4_padded(8, (4, 5, 6, 7), q, r)
res8 = analyse(8, W8, "m=8: two ORTHOGONAL 4-planes, q=r=1/2")
print("  claimed normalised spectrum {-0.57735 (x2), 0.28868 (x4)}, theta=-0.866025, dimU=8")
print(f"  -> -1/sqrt(3) = {-1/np.sqrt(3):.6f}, 1/(2 sqrt 3) = {1/(2*np.sqrt(3)):.6f}, "
      f"-sqrt(3)/2 = {-np.sqrt(3)/2:.6f}")

# --- m=6, 4-planes OVERLAPPING in a 2-plane ---
W6 = W4_padded(6, (0, 1, 2, 3), q, r) + W4_padded(6, (2, 3, 4, 5), q, r)
res6 = analyse(6, W6, "m=6: 4-planes {0123} and {2345} overlapping in {2,3}")
print("  claimed normalised spectrum (-3,-1,1,1,1,1)/sqrt(14), theta=-1.030865, dimU=6")
print(f"  -> (-3,-1,1,1,1,1)/sqrt(14) = {np.round(np.array([-3,-1,1,1,1,1])/np.sqrt(14),6)}")

# --- sweep the gluing: overlap dimension and the (q,r) parameters ---
print("\n=== sweep: overlap of the two 4-planes, and (q,r) ===")
rng = np.random.default_rng(605)
for m, pl1, pl2, ov in [(6, (0,1,2,3), (2,3,4,5), 2), (7, (0,1,2,3), (3,4,5,6), 1),
                        (8, (0,1,2,3), (4,5,6,7), 0), (6, (0,1,2,3), (1,2,4,5), 2),
                        (5, (0,1,2,3), (1,2,3,4), 3)]:
    for (qq, rr) in [(0.5, 0.5), (0.3, 0.7), (1.0, 0.2)]:
        Wm = W4_padded(m, pl1, qq, rr) + W4_padded(m, pl2, qq, rr)
        lam = np.linalg.eigvalsh(Wm); nrm = np.linalg.norm(Wm)
        sc = max(1.0, abs(lam).max())
        nneg = int(np.sum(lam < -TOL*sc))
        V = np.linalg.eigh(Wm)[1]; o = np.argsort(lam)
        dimU = np.linalg.matrix_rank(np.hstack([vec_to_mat(m, V[:, a]) for a in o[:2]]), tol=1e-8)
        ric, bia, _ = is_weyl(m, Wm)
        print(f"  m={m} planes overlap {ov}  (q,r)=({qq},{rr}): n_neg={nneg} dimU={dimU} "
              f"theta={theta(m,Wm):+.6f} ric={ric:.1e} bia={bia:.1e}")
