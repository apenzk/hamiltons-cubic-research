"""Screen for the sectional-nonassociativity reformulation (Fox 2022, Lemma 8.2).

Checks, in the record's Frobenius convention on the pair basis:
  (a) theta(S^3 x S^3) = sqrt(10)/3 reproduces, so the convention is the record's;
  (b) at e = W*/theta, max over x of K(e,x) equals theta^2/4, attained on the 1/2-eigenspace;
  (c) sup of K(U) over random planes and over local ascents, against (max theta)^2/4.
Screening only, seconds of compute.
"""
import sys, time
import numpy as np
sys.path.insert(0, "scripts/lib")
from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from g1_le_machinery import weyl_basis

def setup(n):
    idx, pos, N, c = build_structure_constants(n)
    _, _, _, _, B = weyl_basis(n)           # orthonormal basis of Weyl_n, as N x N matrices
    B = np.array(B)
    d = B.shape[0]
    return idx, pos, N, c, B, d

def Q(M, c): return Q_full(M, c)
def ip(A, B): return float(np.sum(A * B))
def circ(x, y, c): return 0.5 * (Q(x + y, c) - Q(x, c) - Q(y, c))
def theta(W, c): return ip(W, Q(W, c)) / ip(W, W) ** 1.5
def K(x, y, c):
    num = ip(circ(x, x, c), circ(y, y, c)) - ip(circ(x, y, c), circ(x, y, c))
    den = ip(x, x) * ip(y, y) - ip(x, y) ** 2
    return num / den

def balanced(n, idx, N):
    p = n // 2
    lam = np.zeros(N)
    for a, (i, j) in enumerate(idx):
        if i < p and j < p: lam[a] = 1.0 / (p * (p - 1))
        elif i >= p and j >= p: lam[a] = 1.0 / (p * (p - 1))
        else: lam[a] = -1.0 / (p * p)
    W = np.diag(lam); return W / np.sqrt(ip(W, W))

def coords(M, B): return np.array([ip(M, b) for b in B])
def from_coords(v, B): return np.einsum('k,kab->ab', v, B)

def run(n, seed=0, n_random=4000, n_ascent=12, steps=150):
    idx, pos, N, c, B, d = setup(n)
    rng = np.random.default_rng(seed)
    W = balanced(n, idx, N); th = theta(W, c)
    print(f"n={n}  dim W_n={d}  theta(S^{n//2}xS^{n//2})={th:.9f}  sqrt(10)/3={np.sqrt(10)/3:.9f}" if n == 6
          else f"n={n}  dim W_n={d}  theta(S^{n//2}xS^{n//2})={th:.9f}")
    e = W / th
    # L_e as a d x d matrix
    Le = np.zeros((d, d))
    for k in range(d):
        Le[:, k] = coords(circ(e, B[k], c), B)
    Le = 0.5 * (Le + Le.T)
    ev, U = np.linalg.eigh(Le)
    ecoord = coords(e, B); ecoord /= np.linalg.norm(ecoord)
    # orthogonal spectrum: drop the eigenvector along e
    along = np.abs(U.T @ ecoord)
    keep = along < 0.5
    ev_perp = ev[keep]
    lam1m = ev_perp * (1 - ev_perp)
    print(f"  spec_perp(L_e): min={ev_perp.min():.6f} max={ev_perp.max():.6f}  count(|lam-1/2|<1e-6)={np.sum(np.abs(ev_perp-0.5)<1e-6)}")
    print(f"  4*|e|^-2*max lam(1-lam) = {4*th**2*lam1m.max():.9f}   theta^2 = {th**2:.9f}")
    # direct K along a 1/2-eigenvector and along the top eigenvector
    x_half = from_coords(U[:, keep][:, np.argmin(np.abs(ev_perp - 0.5))], B)
    print(f"  4*K(e, x_half) = {4*K(e, x_half, c):.9f}")
    # random planes
    t0 = time.time(); best = -1e9
    for _ in range(n_random):
        x = from_coords(rng.standard_normal(d), B); y = from_coords(rng.standard_normal(d), B)
        best = max(best, K(x, y, c))
    print(f"  random planes ({n_random}): max K = {best:.6f}   ({time.time()-t0:.1f}s)")
    # local ascent on K(x,y) over coordinates, crude finite-difference gradient on the sphere pair
    def Kv(v):
        x = from_coords(v[:d], B); y = from_coords(v[d:], B); return K(x, y, c)
    best_asc = -1e9; t0 = time.time()
    for _ in range(n_ascent):
        v = rng.standard_normal(2 * d); v[:d] /= np.linalg.norm(v[:d]); v[d:] /= np.linalg.norm(v[d:])
        f = Kv(v); lr = 0.2
        for it in range(steps):
            g = np.zeros_like(v); h = 1e-5
            for k in range(2 * d):
                v2 = v.copy(); v2[k] += h; g[k] = (Kv(v2) - f) / h
            v_new = v + lr * g; v_new[:d] /= np.linalg.norm(v_new[:d]); v_new[d:] /= np.linalg.norm(v_new[d:])
            f_new = Kv(v_new)
            if f_new > f: v, f = v_new, f_new
            else: lr *= 0.5
            if lr < 1e-6: break
        best_asc = max(best_asc, f)
    print(f"  local ascent ({n_ascent} starts): max K = {best_asc:.6f}   ({time.time()-t0:.1f}s)")
    print(f"  comparison: theta^2/4 at the balanced product = {th**2/4:.6f};  (3/2)/4 = {0.375:.6f}")

if __name__ == "__main__":
    run(6, n_random=3000, n_ascent=6, steps=60)
    run(8, n_random=800, n_ascent=0, steps=0)
