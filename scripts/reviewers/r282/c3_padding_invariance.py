"""r282 claim 3: is every one of posts 6, 26, 33, 34, 35 a bound on a
PADDING-INVARIANT quantity?  One fixed W, padded, every quantity recomputed."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, weyl as W
from c1_support import cp2_weyl

def weyl_basis(n):
    """Orthonormal basis of Weyl_n inside Sym^2(Lambda^2), from the projector."""
    N = n * (n - 1) // 2
    cols = []
    idxs = [(a, b) for a in range(N) for b in range(a, N)]
    Amat = np.zeros((N * N, len(idxs)))
    for c, (a, b) in enumerate(idxs):
        M = np.zeros((N, N)); M[a, b] = 1.0; M[b, a] = 1.0
        Mp = W.tensor_to_op(W.project_weyl(W.op_to_tensor(M, n), n), n)
        Amat[:, c] = Mp.reshape(-1)
    U, s, _ = np.linalg.svd(Amat, full_matrices=False)
    k = int((s > 1e-9 * s[0]).sum())
    return [U[:, i].reshape(N, N) for i in range(k)]

def L_W(Wop, n, basis):
    """L_W(H) = 1/2 (Q(W+H) - Q(W) - Q(H)), projected to Weyl_n."""
    D = len(basis)
    QW = W.Q(Wop, n)
    L = np.zeros((D, D))
    for j, H in enumerate(basis):
        B = 0.5 * (W.Q(Wop + H, n) - QW - W.Q(H, n))
        Bp = W.tensor_to_op(W.project_weyl(W.op_to_tensor(B, n), n), n)
        for i, G in enumerate(basis):
            L[i, j] = np.tensordot(G, Bp)
    return L

def second_kind_moments(Wop, n):
    R = W.op_to_tensor(Wop, n)
    idx = [(i, j) for i in range(n) for j in range(i, n)]
    D = len(idx)
    A = np.zeros((D, D))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            v = R[i, k, j, l] if k == l else (R[i, k, j, l] + R[i, l, j, k])
            sc = 1.0 if i == j else np.sqrt(2.0)
            sc2 = 1.0 if k == l else np.sqrt(2.0)
            A[a, b] = v * (sc2 / sc) if False else v
    # symmetrise in the orthonormal Sym^2 basis
    S = np.zeros((D, D))
    for a, (i, j) in enumerate(idx):
        for b, (k, l) in enumerate(idx):
            na = 1.0 if i == j else np.sqrt(2.0)
            nb = 1.0 if k == l else np.sqrt(2.0)
            val = R[i, k, j, l] + (0.0 if k == l else R[i, l, j, k])
            S[a, b] = val * nb / na
    S = 0.5 * (S + S.T)
    ev = np.linalg.eigvalsh(S)
    return float(np.sum(ev)), float(np.sum(ev**2)), float(np.sum(ev**3))

def sharp_norm_quantity(Wop, n):
    Ms = W.sharp(Wop, n)
    return float(np.trace(Wop @ Wop @ Wop)), float(np.sqrt(np.tensordot(Ms, Ms)))

rng = np.random.default_rng(8282)
base = W.random_weyl(6, rng)
cases = {"random Weyl_6": base, "padded W_CP2": W.pad(cp2_weyl(4), 4, 6)}
print("Post 6 quantity: spectral moments of L_W(H)=B(W,H) on Weyl_n")
print("Posts 34/35 quantity: tr(M^3) + ||M^#||_F")
print("Post 33 quantity: moments of the second-kind spectrum omega\n")
for name, M6 in cases.items():
    print(f"--- {name} (unit, fixed, then padded) ---")
    for n in (6, 7, 8):
        Mn = W.pad(M6, 6, n) if n > 6 else M6
        bas = weyl_basis(n)
        L = L_W(Mn, n, bas)
        ev = np.linalg.eigvalsh(L)
        t3, sn = sharp_norm_quantity(Mn, n)
        p1, p2, p3 = second_kind_moments(Mn, n)
        print(f"  n={n:2d} dimWeyl={len(bas):4d} | tr L_W^2={np.sum(ev**2):12.6f} "
              f"(formula (n-1)(2n-1)/4={((n-1)*(2*n-1))/4:8.4f})  tr L_W^3={np.sum(ev**3):12.6f} "
              f"| lam_max(L_W)={ev.max():.6f}")
        print(f"          P={W.P(Mn,n):.12f}  tr(M^3)+||M^#||_F={t3+sn:.12f}  "
              f"omega moments p1={p1:.9f} p2={p2:.9f} p3={p3:.9f}")
