"""r308 L1: is the block split of criticality real, and does it need gradedness?"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np
import r308_lib as L
import r308_grade as G


def blocks(W, P, M):
    """P, M: orthonormal column bases of p and m. Returns A, B embedded in Lambda^2."""
    A = P @ (P.T @ W @ P) @ P.T
    B = M @ (M.T @ W @ M) @ M.T
    return A, B


def report(n, W, P, M, label):
    idx, pos, N, c = L.struct(n)
    Ad = L.ad(c)
    W = W / np.linalg.norm(W)
    A, Bm = blocks(W, P, M)
    print(f"\n--- {label}:  dim p = {P.shape[1]}, dim m = {M.shape[1]}")
    print(f"  ||W - A - B||        = {np.linalg.norm(W - A - Bm):.2e}   (W block-diagonal?)")
    Q = L.Qop(Ad, W)
    th = float(np.tensordot(Q, W))
    print(f"  theta                = {th:.9f}   ||Q(W)-theta W|| = {np.linalg.norm(Q-th*W):.2e}")
    S = L.sharp(Ad, W)
    Sk = P @ (P.T @ S @ P) @ P.T
    Sm = M @ (M.T @ S @ M) @ M.T
    print(f"  ||S - S|p - S|m||    = {np.linalg.norm(S - Sk - Sm):.2e}   (is W# block-diagonal?)")
    SAA = L.sharp(Ad, A); SBB = L.sharp(Ad, Bm)
    SAB = L.sharp_bilin(Ad, A, Bm)
    kAA = np.linalg.norm(P.T @ SAA @ P); kBB = np.linalg.norm(P.T @ SBB @ P)
    kAB = np.linalg.norm(P.T @ SAB @ P)
    mAA = np.linalg.norm(M.T @ SAA @ M); mBB = np.linalg.norm(M.T @ SBB @ M)
    mAB = np.linalg.norm(M.T @ SAB @ M)
    print(f"  W#|p  sources: ||A#A|p||={kAA:.6f}  ||B#B|p||={kBB:.6f}  ||A#B|p||={kAB:.2e}")
    print(f"  W#|m  sources: ||A#A|m||={mAA:.2e}  ||B#B|m||={mBB:.2e}  ||A#B|m||={mAB:.6f}")
    err = np.linalg.norm(P.T @ (S - SAA - SBB) @ P)
    err2 = np.linalg.norm(M.T @ (S - 2 * SAB) @ M)
    print(f"  sorting check: ||W#|p - (A#A+B#B)|p|| = {err:.2e}, "
          f"||W#|m - 2(A#B)|m|| = {err2:.2e}")
    # the two L1 equations
    nA2 = float(np.tensordot(A, A)); nB2 = float(np.tensordot(Bm, Bm))
    lhsA = th * nA2; rhsA = float(np.trace(A @ A @ A)) + float(np.tensordot(A, S))
    lhsB = th * nB2; rhsB = float(np.trace(Bm @ Bm @ Bm)) + float(np.tensordot(Bm, S))
    print(f"  L1 eq p: theta||A||^2 = {lhsA:.12f}  vs tr A^3 + <A,W#> = {rhsA:.12f}   "
          f"diff {abs(lhsA-rhsA):.2e}")
    print(f"  L1 eq m: theta||B||^2 = {lhsB:.12f}  vs tr B^3 + <B,W#> = {rhsB:.12f}   "
          f"diff {abs(lhsB-rhsB):.2e}")
    print(f"  ||A||^2 = {nA2:.6f}   ||B||^2 = {nB2:.6f}")
    # decomposition of the p-equation cubic terms
    print(f"  <A, A#A|p> = {float(np.tensordot(A,SAA)):.6f}   "
          f"<A, B#B|p> = {float(np.tensordot(A,SBB)):.6f}   (is the m x m term zero?)")
    print(f"  tr A^3 = {float(np.trace(A@A@A)):.6f}   tr B^3 = {float(np.trace(Bm@Bm@Bm)):.6f}")
    print(f"  <B, 2 A#B|m> = {2*float(np.tensordot(Bm,SAB)):.6f}")
    return dict(theta=th, nA2=nA2, nB2=nB2)
