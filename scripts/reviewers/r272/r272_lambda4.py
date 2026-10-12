"""r272 -- how # interacts with S^2(Lambda^2) = S^2_B + Lambda^4, and whether the
proposed 'separate the Lambda^4 component' step can reach <M#,M> at all."""
import numpy as np, itertools
import importlib.util, sys, os
spec = importlib.util.spec_from_file_location("adf", os.path.join(os.path.dirname(os.path.abspath(__file__)), "r272_adform.py"))
adf = importlib.util.module_from_spec(spec); spec.loader.exec_module(adf)

def to_tensor(M, pairs, n):
    pos = {p: k for k, p in enumerate(pairs)}
    T = np.zeros((n, n, n, n))
    for i, j, k, l in itertools.product(range(n), repeat=4):
        if i == j or k == l: continue
        si = 1.0; a = (i, j)
        if i > j: a = (j, i); si = -1.0
        sk = 1.0; b = (k, l)
        if k > l: b = (l, k); sk = -1.0
        T[i, j, k, l] = si * sk * M[pos[a], pos[b]]
    return T

def cyc(T):
    return (T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))) / 3.0

def rand_sym_op(N, rng):
    A = rng.normal(size=(N, N)); return (A + A.T) / 2

for n in [4, 5, 6]:
    rng = np.random.default_rng(7 * n)
    pairs, mats, N, c = adf.struct(n)
    W = adf.random_weyl(n, rng)
    M = adf.to_operator(W, pairs); M /= np.linalg.norm(M)
    S = adf.sharp_hamilton(M, c)
    TM, TS, TM2 = to_tensor(M, pairs, n), to_tensor(S, pairs, n), to_tensor(M @ M, pairs, n)
    print(f"n={n}")
    print(f"  [A] b(M#)+b(M^2) on a Weyl M : {np.linalg.norm(cyc(TS)+cyc(TM2)):.2e}"
          f"   (|b(M#)|={np.linalg.norm(cyc(TS)):.4f})")
    print(f"  [B] <cyc(M#), M>_4tensor    : {np.sum(cyc(TS)*TM):.2e}"
          f"   vs <M#,M>_4tensor = {np.sum(TS*TM):.6f}  (matrix pairing {np.sum(S*M):.6f})")
    # is Lambda^4 orthogonal to S^2_B inside S^2(Lambda^2)?
    ort = []
    for _ in range(30):
        A = rand_sym_op(N, rng); TA = to_tensor(A, pairs, n)
        TB = TA - cyc(TA)
        ort.append(abs(np.sum(cyc(TA) * TB)))
    print(f"  [C] max |<Lambda^4 part, S^2_B part>| over 30 random ops : {max(ort):.2e}")
    # does b(R^2+R^#)=0 for GENERAL symmetric R (not Bianchi)?
    gen = []
    for _ in range(5):
        A = rand_sym_op(N, rng); A /= np.linalg.norm(A)
        SA = adf.sharp_hamilton(A, c)
        TT = to_tensor(A @ A + SA, pairs, n)
        gen.append(np.linalg.norm(cyc(TT)) / np.linalg.norm(TT))
    print(f"  [D] relative Lambda^4 defect of R^2+R^# for GENERAL sym R : "
          f"{min(gen):.3f} .. {max(gen):.3f}")
    # and for Bianchi-but-not-traceless (algebraic curvature operators)
    curv = []
    for _ in range(5):
        A = rand_sym_op(N, rng); TA = to_tensor(A, pairs, n)
        TA = TA - cyc(TA)
        # back to matrix
        B = np.zeros((N, N))
        for a, (i, j) in enumerate(pairs):
            for b2, (k, l) in enumerate(pairs):
                B[a, b2] = TA[i, j, k, l]
        B = (B + B.T) / 2; B /= np.linalg.norm(B)
        SB = adf.sharp_hamilton(B, c)
        TT = to_tensor(B @ B + SB, pairs, n)
        curv.append(np.linalg.norm(cyc(TT)) / max(np.linalg.norm(TT), 1e-30))
    print(f"  [E] rel Lambda^4 defect of R^2+R^# for Bianchi R (Ricci NOT removed): "
          f"{min(curv):.2e} .. {max(curv):.2e}")
