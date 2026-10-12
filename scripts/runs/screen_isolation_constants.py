"""The two constants of [I96]'s isolation estimate, on an explicitly built diagonal basis.

The off-diagonal part of criticality at a split W = D + N is

    (2 L_D - theta) N = -pi_perp(N o N),

so if the linear part is bounded below by gamma transverse to its kernel and the quadratic part
above by kappa, then |N| <= kappa |N|^2 / gamma, hence N = 0 or |N| >= gamma / kappa.

  gamma  = min |2 lambda - theta| over the spectrum of L_D on D_n-perp, EXCLUDING the orbit
           tangent, which is the kernel and is the gauge freedom.
  kappa  = sup |pi_perp(X o X)| over unit X in D_n-perp.

**Why this script exists rather than the earlier screen.** That one masked basis elements of
Weyl_n by whether they were already diagonal, and the basis weyl_basis returns is not aligned with
the diagonal split, so the mask found NO diagonal elements and the measurement ran over the whole
space. Here D_n is built from its own description: symmetric hollow zero-row-sum matrices, placed
on the pair diagonal, which is Ricci-flat and automatically first-Bianchi.

Screening only, seconds to a couple of minutes: the lemma is the derivation.
"""
import sys
import numpy as np
sys.path.insert(0, "scripts/lib")
from g1_le_machinery import weyl_basis, Le_matrix
from rsharp_basis_free import Q_full


def ip(a, b):
    return float(np.sum(a * b))


def diagonal_basis(n, idx, N):
    """An orthonormal basis of D_n, as N x N matrices diagonal in the pair basis.

    D_n is the coordinate-diagonal Weyl tensors: the sectional matrix K is symmetric, hollow and
    has zero row sums, and the operator is diag(K_ab) on the pair basis. Dimension n(n-3)/2.
    """
    rows = []
    for a in range(n):
        r = np.zeros(len(idx))
        for k, (i, j) in enumerate(idx):
            if i == a or j == a:
                r[k] = 1.0
        rows.append(r)
    A = np.array(rows)                      # the n row-sum conditions on the pair vector
    U, s, Vt = np.linalg.svd(A)
    ker = Vt[int(np.sum(s > 1e-9 * s[0])):]  # zero-row-sum sectional matrices
    return np.array([np.diag(v / np.linalg.norm(v)) for v in ker])


def split(n):
    """Orthonormal bases of D_n and of its orthogonal complement inside Weyl_n."""
    Nn, c, L2, alt_idx, B = weyl_basis(n)
    B = np.array(B)
    idx = [(i, j) for i in range(n) for j in range(i + 1, n)]
    D = diagonal_basis(n, idx, Nn)
    # check D lies inside Weyl_n: its coordinates in B must reconstruct it
    for d in D[:3]:
        co = np.array([ip(d, b) for b in B])
        rec = np.einsum('k,kab->ab', co, B)
        assert np.sqrt(ip(d - rec, d - rec)) < 1e-9, "a diagonal element left Weyl_n"
    # complement: project B off D, then orthonormalise
    P = np.array([[ip(b, d) for d in D] for b in B])
    Boff = B - np.einsum('kd,dab->kab', P, D)
    flat = Boff.reshape(len(B), -1)
    U, s, Vt = np.linalg.svd(flat, full_matrices=False)
    keep = s > 1e-8 * s[0]
    Boff = Vt[keep].reshape(-1, Nn, Nn)
    return Nn, c, B, D, np.array(Boff), idx


def run(n):
    Nn, c, B, D, Boff, idx = split(n)
    print(f"n={n}: dim W_n={len(B)}, dim D_n={len(D)} (expected {n*(n-3)//2}), "
          f"dim D_n-perp={len(Boff)}")
    # the balanced product, and gamma from the spectrum of L_e off the diagonal
    p = n // 2
    lam = np.zeros(Nn)
    for a, (i, j) in enumerate(idx):
        lam[a] = 1 / (p * (p - 1)) if (i < p) == (j < p) else -1 / (p * p)
    W = np.diag(lam)
    W /= np.sqrt(ip(W, W))
    Se = np.einsum('amn,np->amp', c, W, optimize=True)
    th = ip(W, W @ W - 0.5 * np.einsum('amp,bpm->ab', Se, Se, optimize=True))
    e = W / th
    # L_e restricted to D_n-perp
    Loff = np.zeros((len(Boff), len(Boff)))
    circ = lambda x, y: 0.5 * (Q_full(x + y, c) - Q_full(x, c) - Q_full(y, c))
    for k, b in enumerate(Boff):
        img = circ(e, b)
        Loff[:, k] = [ip(img, bb) for bb in Boff]
    Loff = 0.5 * (Loff + Loff.T)
    ev = np.linalg.eigvalsh(Loff)
    halves = np.abs(ev - 0.5) < 1e-7
    off = ev[~halves]
    gamma_e = np.min(np.abs(2 * off - 1))     # min |2 lambda_e - 1| off the kernel
    print(f"   theta={th:.9f}; spectrum of L_e on D_n-perp has {int(halves.sum())} halves "
          f"(orbit dim {p*p}), min |2 lambda - 1| elsewhere = {gamma_e:.6f} = 2/(n-2) if "
          f"{2/(n-2):.6f}")
    gamma = th * gamma_e
    # kappa, by random sampling then ascent
    rng = np.random.default_rng(0)
    def val(v):
        X = np.einsum('k,kab->ab', v, Boff)
        X /= np.sqrt(ip(X, X))
        S = Q_full(X, c)
        co = np.array([ip(S, b) for b in Boff])
        return float(np.linalg.norm(co))
    best = max(val(rng.standard_normal(len(Boff))) for _ in range(2000))
    for _ in range(4):
        v = rng.standard_normal(len(Boff)); f = val(v); lr = 0.3
        for _ in range(80):
            g = np.zeros_like(v); h = 1e-5
            for k in range(len(v)):
                v2 = v.copy(); v2[k] += h; g[k] = (val(v2) - f) / h
            vn = v + lr * g; fn = val(vn)
            if fn > f: v, f = vn, fn
            else: lr *= 0.5
            if lr < 1e-7: break
        best = max(best, f)
    print(f"   gamma = theta * min|2 lambda - 1| = {gamma:.6f};  kappa >= {best:.6f};  "
          f"c_n = gamma/kappa <= {gamma/best:.6f}")
    print(f"   and |N| at the nearest known non-diagonal critical point, for comparison: "
          f"padded CP^2 has t=1/2 so |N| = {np.sqrt(0.5):.6f}")


if __name__ == "__main__":
    run(6)
    run(8)
