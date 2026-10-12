"""Reviewer 56 -- D4: is 'unitary isotropy' EQUIVALENT to non-diagonalisability?

The sufficient direction is sound and is re-proved here in the form it is
actually used: if W is diagonal in the coordinate 2-planes of a frame f, then
EVERY diagonal sign change g = diag(eps_1..eps_n) fixes W, because rho(g) acts on
phi_jk by eps_j eps_k and W's entries carry eps_j^2 eps_k^2 = 1.  In particular a
single reflection r_u = I - 2 u u^T fixes W: an element with the real eigenvalue
-1 of multiplicity ONE.  No element of U(m) has that.  Hence

     isotropy(W) contains no reflection  ==>  W is coordinate-diagonal in no frame.

The converse is what D4 asserts, and it is what the enumeration rests on.  This
script tests it:
  (a) at the record's OWN listed points, by searching for a fixing reflection;
  (b) by building a critical point with S=0, non-diagonalisable, and isotropy
      containing reflections -- an orthogonal BLOCK SUM, which the record's own
      'S=0 is closed under orthogonal direct sums' paragraph guarantees.
"""
import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from review_r56_core import *

def embed(Wsmall, idx_small, idx_big, offset):
    N = len(idx_big)
    M = np.zeros((N, N))
    look = {p: k for k, p in enumerate(idx_big)}
    for a, (i, j) in enumerate(idx_small):
        A = look[(i + offset, j + offset)]
        for b, (k, l) in enumerate(idx_small):
            B = look[(k + offset, l + offset)]
            M[A, B] = Wsmall[a, b]
    return M

def eigenspaces(W, tol=1e-8):
    ev, V = np.linalg.eigh(W)
    out, i = [], 0
    while i < len(ev):
        j = i
        while j + 1 < len(ev) and abs(ev[j + 1] - ev[i]) < tol:
            j += 1
        out.append((float(np.mean(ev[i:j + 1])), V[:, i:j + 1]))
        i = j + 1
    return out

def full_report(label, n, W, idx, c, frames=True, refl=True, pl=True):
    W = W / np.linalg.norm(W)
    th, res = theta_res(W, c)
    if th < 0:
        W = -W; th, res = theta_res(W, c)
    S, leak = slack_struct(W, c)
    r = fixing_reflections(W, idx, n, tries=40, seed=5) if refl else float('nan')
    mn = min_offdiag_over_frames(W, n, idx, tries=6, seed=2) if frames else float('nan')
    print(f"{label}")
    print(f"   n={n}  theta={th:.9f}  theta/theta_0={th/theta0(n):.4f}  crit_res={res:.1e}")
    print(f"   ||Ric||={np.linalg.norm(ricci(W,idx,n)):.1e}  ||Bianchi||={np.linalg.norm(bianchi(W,idx,n)):.1e}")
    print(f"   S_structural={S:.3e}   leakage ratio={leak:.3e}")
    print(f"   min over frames of off-diagonal mass = {mn:.4f}")
    print(f"   best reflection residual  ||r_u.W - W|| = {r:.2e}"
          f"   -> isotropy {'CONTAINS' if r < 1e-6 else 'contains NO'} a reflection")
    if pl:
        for v, E in eigenspaces(W):
            if E.shape[1] <= 4:
                pm = plucker_min(E, idx, n, tries=20, seed=4)
                print(f"      eigsp lambda={v:+.6f} mult={E.shape[1]} min||w^w||={pm:.3e}")
    return th, S

if __name__ == "__main__":
    print("=== (a) do the record's OWN non-diagonal S=0 points have unitary isotropy? ===\n")
    idx12, _, N12, c12 = struct(12)
    idx8, _, N8, c8 = struct(8)
    full_report("padded W_CP2 into n=12  (= Fox S^4(alpha), the record's closest point)",
                12, w_cp2_padded(12, idx12), idx12, c12)
    print()
    full_report("CP^4 in its native n=8 (unpadded, for contrast)",
                8, cpm(8, idx8), idx8, c8)

    print("\n=== (b) a NEW non-diagonal S=0 critical point: the orthogonal block sum ===\n")
    idx4, _, N4, c4 = struct(4)
    W4 = w_cp2_padded(4, idx4)
    th4, _ = theta_res(W4, c4)
    idx8s, _, _, c8s = struct(8)
    W8 = sphere_product(8, (4, 4), idx8s)
    th8, _ = theta_res(W8, c8s)
    thsum = 1.0 / np.sqrt(1 / th4**2 + 1 / th8**2)
    a, b = thsum / th4, thsum / th8
    W = a * embed(W4, idx4, idx12, 0) + b * embed(W8, idx8s, idx12, 4)
    print(f"   built from theta_A={th4:.9f} (W_CP2 on coords 0..3) and "
          f"theta_B={th8:.9f} (S^4xS^4 on coords 4..11)")
    print(f"   harmonic-square prediction theta = {thsum:.9f},  a={a:.6f} b={b:.6f}\n")
    full_report("W_CP2(0..3)  (+)  W_{S^4xS^4}(4..11)   at n=12", 12, W, idx12, c12)
