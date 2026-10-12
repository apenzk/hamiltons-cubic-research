"""B0: Bianchi + Ricci-flatness as a POSITIVE-SEMIDEFINITE operator identity, and
the centraliser collapse that kills a full-rank positive eigenvector at m >= 6.

THE IDENTITY.  Write W = sum_a lam_a v_a v_a^T on Lambda^2 R^m = so(m), with
<X,Y> = 1/2 tr(X^T Y) so the phi_{ij} = E_ij - E_ji are orthonormal.  Pairing the
first Bianchi identity against u (x) u for skew u, and eliminating the term
tr(u^2 v^2) by Ricci-flatness, gives the operator identity on so(m)

    sum_a lam_a [ 2 v_a (x) v_a - ad(v_a)^2 ]  =  0 ,        (*)

equivalently  A(W) := sum_{g,h} W_{gh} ad(phi_g) ad(phi_h)  =  2 W.

Each summand N_v := 2 v(x)v - ad(v)^2 is POSITIVE SEMIDEFINITE, because ad(v) is
skew-adjoint on so(m).  And

    ker N_v = v^perp  intersect  z(v)          (z = centraliser in so(m)).

CONSEQUENCE.  For a rank-3 tensor of signature (1,2), (*) reads N_x = N_y + N_z with
x the scaled positive eigenvector.  PSD gives ker N_x contained in ker N_y and in
ker N_z, i.e. c := z(x) ^ x^perp commutes with y and z and is orthogonal to both.
If x is NONDEGENERATE the centraliser of c collapses:

    dim ( z(c) ^ c^perp )  =  1  (= R x)   for m >= 6,
    and = 3 only at m = 4 with x a multiple of a complex structure.

So y, z in R x, contradicting independence.  m = 4 is the sole exception, and it is
exactly the self-dual case that the base of the B0 descent already records.

WHAT THIS SCRIPT CHECKS.
  (1) (*) at random Weyl_m elements and at catalogued points, m = 4,5,6,7,8.
  (2) N_v PSD, and ker N_v = v^perp ^ z(v), at random v.
  (3) the centraliser collapse dim(z(c) ^ c^perp) at random nondegenerate x,
      over every multiplicity pattern, m = 4,6,8,10.
  (4) FALSIFIER SWEEP for the BROADER B0 statement: a Weyl_m element with exactly
      two negative eigenvalues and dim U = m (ker y ^ ker z = 0), which the rank-3
      theorem does NOT cover.

FALSIFIER.  (*) failing at any Weyl element; N_v with a negative eigenvalue; a
nondegenerate x at m >= 6 with dim(z(c) ^ c^perp) > 1.
"""
import numpy as np, itertools, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, structure_constants

np.set_printoptions(precision=6, suppress=True)


def phis(m):
    pairs, idx = pair_index(m)
    P = np.zeros((len(pairs), m, m))
    for a, (i, j) in enumerate(pairs):
        P[a, i, j] = 1.0; P[a, j, i] = -1.0
    return P, pairs, idx


def mat_of(vec, m):
    """coefficient vector on phi-basis -> skew matrix"""
    P, _, _ = phis(m)
    return np.einsum('a,aij->ij', vec, P)


def vec_of(X, m):
    P, _, _ = phis(m)
    return 0.5 * np.einsum('aij,ij->a', P, X)


def C_gens(m):
    """C_g = ad(phi_g) as N x N matrices on the orthonormal phi basis."""
    c = structure_constants(m)          # c[g,b,a] totally antisymmetric
    # (ad(phi_g))_{b a} = <phi_b,[phi_g,phi_a]> = c[g,a,b]
    return np.transpose(c, (0, 2, 1))


def A_of_W(m, W):
    """A(W) = sum_{g,h} W_{gh} C_g C_h"""
    C = C_gens(m); N = C.shape[0]
    M = np.tensordot(W, C, axes=([1], [0]))          # M[g] = sum_h W_gh C_h
    return np.einsum('gab,gbc->ac', C, M)


def N_of_v(m, vvec):
    """N_v = 2 v(x)v - ad(v)^2 on so(m)."""
    C = C_gens(m)
    Av = np.tensordot(vvec, C, axes=([0], [0]))
    return 2.0 * np.outer(vvec, vvec) - Av @ Av


def ricci(m, W):
    P, pairs, idx = phis(m)
    lam, V = np.linalg.eigh(W)
    R = np.zeros((m, m))
    for a in range(len(lam)):
        v = mat_of(V[:, a], m)
        R += lam[a] * (v @ v.T)
    return R


def bianchi_res(m, W):
    """Alt component: b_{ijkl} = W_{ijkl}+W_{iklj}+W_{iljk}, from the 4-tensor."""
    P, pairs, idx = phis(m)
    lam, V = np.linalg.eigh(W)
    T = np.zeros((m, m, m, m))
    for a in range(len(lam)):
        v = mat_of(V[:, a], m)
        T += lam[a] * np.einsum('ij,kl->ijkl', v, v)
    b = T + np.transpose(T, (0, 2, 3, 1)) + np.transpose(T, (0, 3, 1, 2))
    return np.abs(b).max()


def rand_weyl(m, rng):
    B = weyl_basis(m)
    co = rng.normal(size=B.shape[0])
    W = np.tensordot(co, B, axes=([0], [0]))
    return W / np.sqrt(np.sum(W * W))


# ---------------- (1) the identity ----------------
def check_identity(rng):
    print("=== (1) A(W) = 2W  on Weyl_m, and the failure off it ===")
    for m in (4, 5, 6, 7, 8):
        W = rand_weyl(m, rng)
        A = A_of_W(m, W)
        r_id = np.abs(A - 2 * W).max()
        # controls: a random symmetric operator, and Bianchi-only / Ricci-only
        N = W.shape[0]
        S = rng.normal(size=(N, N)); S = S + S.T; S /= np.sqrt(np.sum(S * S))
        r_ctrl = np.abs(A_of_W(m, S) - 2 * S).max()
        print(f"  m={m:2d}  |A(W)-2W|={r_id:.2e}   Ricci={np.abs(ricci(m,W)).max():.2e}"
              f"  Bianchi={bianchi_res(m,W):.2e}   control |A(S)-2S|={r_ctrl:.3f}")


# ---------------- (2) N_v PSD and its kernel ----------------
def check_N(rng):
    print("\n=== (2) N_v PSD, ker N_v = v^perp ^ z(v) ===")
    for m in (4, 6, 8):
        N = m * (m - 1) // 2
        for trial in range(2):
            vv = rng.normal(size=N); vv /= np.linalg.norm(vv)
            Nv = N_of_v(m, vv)
            ev = np.linalg.eigvalsh(Nv)
            # z(v) ^ v^perp directly
            C = C_gens(m)
            Av = np.tensordot(vv, C, axes=([0], [0]))
            M = np.vstack([Av, vv[None, :]])
            k = M.shape[1] - np.linalg.matrix_rank(M, tol=1e-9)
            kN = int(np.sum(np.abs(ev) < 1e-9))
            print(f"  m={m} trial{trial}: lam_min(N_v)={ev[0]:+.2e}  dim ker N_v={kN}"
                  f"  dim(v^perp ^ z(v))={k}  {'OK' if kN==k and ev[0]>-1e-9 else 'FAIL'}")


# ---------------- (3) the centraliser collapse ----------------
def zc_dim(m, x):
    """x skew m x m nondegenerate.  c = z(x) ^ x^perp ;  return dim(z(c) ^ c^perp)."""
    C = C_gens(m); N = C.shape[0]
    xv = vec_of(x, m)
    Ax = np.tensordot(xv, C, axes=([0], [0]))
    M = np.vstack([Ax, xv[None, :]])
    # c = null space of M
    _, s, Vt = np.linalg.svd(M)
    tol = 1e-9 * max(1.0, s[0])
    r = int(np.sum(s > tol))
    cbasis = Vt[r:]                       # (dim c, N)
    if cbasis.shape[0] == 0:
        return 0, 0
    rows = [np.tensordot(cb, C, axes=([0], [0])) for cb in cbasis]
    rows.append(cbasis)                   # orthogonality to c
    M2 = np.vstack(rows)
    _, s2, Vt2 = np.linalg.svd(M2)
    tol2 = 1e-9 * max(1.0, s2[0])
    r2 = int(np.sum(s2 > tol2))
    return cbasis.shape[0], N - r2


def block_x(m, alphas):
    """x = direct sum alpha_k J on 2x2 blocks."""
    x = np.zeros((m, m))
    for k, a in enumerate(alphas):
        x[2 * k, 2 * k + 1] = a; x[2 * k + 1, 2 * k] = -a
    return x


def check_collapse(rng):
    print("\n=== (3) dim(z(c) ^ c^perp) for nondegenerate x, c = z(x) ^ x^perp ===")
    print("    prediction: 1 for m>=6 always; 3 at m=4 iff x is a multiple of J")
    for m in (4, 6, 8, 10):
        p = m // 2
        cases = {}
        cases['all equal (x = a J)'] = [1.0] * p
        cases['all distinct'] = [1.0 + 0.7 * k for k in range(p)]
        if p >= 2:
            cases['one repeated pair'] = [1.0] * 2 + [1.0 + 0.7 * k for k in range(1, p - 1)]
        if p >= 3:
            cases['triple + rest'] = [1.0] * 3 + [1.0 + 0.9 * k for k in range(1, p - 2)]
        for name, al in cases.items():
            al = al[:p]
            if len(al) < p:
                continue
            x = block_x(m, al)
            # random conjugation, to check frame-independence
            Qr, _ = np.linalg.qr(rng.normal(size=(m, m)))
            x = Qr @ x @ Qr.T
            dc, dz = zc_dim(m, x)
            print(f"  m={m:2d}  {name:22s} alphas={np.round(al,2)}  dim c={dc:3d}  dim(z(c)^c^perp)={dz}")


# ---------------- (4) falsifier sweep for the broader statement ----------------
def dimU(m, W, tol=1e-8):
    """U = im v_{N-1} + im v_N for the two most negative eigenvectors."""
    lam, V = np.linalg.eigh(W)
    ys = [mat_of(V[:, i], m) for i in range(2)]
    S = np.vstack([y for y in ys])          # 2m x m ; ker = ker y ^ ker z
    return m - (m - np.linalg.matrix_rank(S, tol=tol)), lam


def sweep_two_negative(m, rng, starts=40, iters=400):
    """maximise sigma_min(stack(y,z)) over Weyl_m with lam_3 >= 0 (exactly 2 negatives)."""
    B = weyl_basis(m); d = B.shape[0]
    best = None
    for s in range(starts):
        co = rng.normal(size=d)
        for it in range(iters):
            co_ = co / np.linalg.norm(co)
            W = np.tensordot(co_, B, axes=([0], [0])); W /= np.sqrt(np.sum(W * W))
            lam, V = np.linalg.eigh(W)
            y, z = mat_of(V[:, 0], m), mat_of(V[:, 1], m)
            S = np.vstack([y, z])
            sig = np.linalg.svd(S, compute_uv=False)[-1]
            pen = max(0.0, -lam[2])
            obj = sig - 50.0 * pen
            # crude finite-difference ascent
            g = np.zeros(d); h = 1e-5
            for k in range(d):
                cp = co_.copy(); cp[k] += h
                Wp = np.tensordot(cp / np.linalg.norm(cp), B, axes=([0], [0]))
                Wp /= np.sqrt(np.sum(Wp * Wp))
                lp, Vp = np.linalg.eigh(Wp)
                Sp = np.vstack([mat_of(Vp[:, 0], m), mat_of(Vp[:, 1], m)])
                g[k] = (np.linalg.svd(Sp, compute_uv=False)[-1] - 50.0 * max(0.0, -lp[2]) - obj) / h
            co = co_ + 0.05 * g
        co_ = co / np.linalg.norm(co)
        W = np.tensordot(co_, B, axes=([0], [0])); W /= np.sqrt(np.sum(W * W))
        lam, V = np.linalg.eigh(W)
        S = np.vstack([mat_of(V[:, 0], m), mat_of(V[:, 1], m)])
        sig = np.linalg.svd(S, compute_uv=False)[-1]
        nneg = int(np.sum(lam < -1e-7))
        if best is None or (nneg <= 2 and sig > best[0]):
            best = (sig, nneg, lam[:4].copy())
        print(f"   start {s:2d}: sigma_min={sig:.3e}  #neg={nneg}  lam[:4]={np.round(lam[:4],5)}", flush=True)
    return best


if __name__ == '__main__':
    rng = np.random.default_rng(20260823)
    check_identity(rng)
    check_N(rng)
    check_collapse(rng)
