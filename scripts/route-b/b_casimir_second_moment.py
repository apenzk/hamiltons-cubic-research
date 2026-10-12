"""The second moment of the eigenvalue gaps is a CONSTANT on Weyl_n: the Casimir.

SOURCE.  Petersen-Wink 1908.09958 Prop 1.7 (transcribed in
references/petersen-wink-2019-bochner-technique/notes.md):

    |L R|^2  =  2 sum_{a<b} (lam_a - lam_b)^2 g(L Xi_a, Xi_b)^2      for L in so(V),

where L acts on Lambda^2 by the derivation ad(L) and {Xi_a} diagonalises R.  In the
project's conventions -- <X,Y> = 1/2 tr(X^T Y), phi_ij = E_ij - E_ji orthonormal,
c'_{abg} = <[v_a,v_b],v_g>, T_{abg} = c'^2 -- taking L = phi_g gives

    || [ ad(phi_g), W ] ||^2  =  sum_{a,b} (lam_a - lam_b)^2 T_{gab} .           (1)

WHAT IS NEW HERE.  Summing (1) over a full orthonormal basis {phi_g} of so(n) makes
the left side the CASIMIR quadratic form of so(n) acting on Sym^2(Lambda^2) by
X . W = [ad(X), W].  Weyl tensors are an IRREDUCIBLE so(n)-module (highest weight
(2,2,0,...)), so the Casimir is a scalar c_W(n) there and

    sum_{a,b} (lam_a - lam_b)^2 R_{ab}  =  c_W(n) ||W||^2 ,   R_{ab} = ||[v_a,v_b]||^2 . (2)

(2) is an EQUALITY tying the eigenvalue gaps to the bracket matrix R in closed form.
It sits outside the class the block-mass ceiling closed, which used only the weights
lam_a lam_b lam_g together with row marginals and pair caps.

WHAT THIS SCRIPT CHECKS -- screening only, no search.
  (1) identity (1) at random Weyl tensors, n = 5..8.
  (2) identity (2), and that its value is CONSTANT over random Weyl tensors -- the
      claim that the Casimir is scalar.  A random symmetric operator on Lambda^2 is
      the control: there the value must vary.
  (3) the Casimir value on the other two curvature summands, the scalar tensor
      (trivial module, expect 0) and a traceless-Ricci tensor.
  (4) a closed form for c_W(n) fitted and then checked exactly.

FALSIFIER.  (1) or (2) failing; c_W(n) varying between Weyl tensors at fixed n.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis, structure_constants

np.set_printoptions(precision=8, suppress=True)


def phis(n):
    pairs, idx = pair_index(n)
    P = np.zeros((len(pairs), n, n))
    for a, (i, j) in enumerate(pairs):
        P[a, i, j] = 1.0; P[a, j, i] = -1.0
    return P, pairs, idx


def mat_of(vec, n):
    P, _, _ = phis(n)
    return np.tensordot(vec, P, axes=([0], [0]))


def rand_weyl(n, rng):
    B = weyl_basis(n)
    co = rng.normal(size=B.shape[0])
    W = np.tensordot(co, B, axes=([0], [0]))
    return W / np.sqrt(np.sum(W * W))


def ad_matrices(n):
    """D[g] = matrix of ad(phi_g) on so(n) in the phi basis: D[g][b,a] = c'_{g a b}."""
    c = structure_constants(n)          # c[a,b,g] = <[phi_a,phi_b],phi_g>
    return np.transpose(c, (0, 2, 1))   # D[g][b,a] = c[g,a,b]


def casimir_form(n, W):
    """sum_g || [ad(phi_g), W] ||_F^2 ."""
    D = ad_matrices(n)
    C = D @ W - W @ D
    return float(np.einsum('gab,gab->', C, C))


def gap_moment(n, W):
    """sum_{a,b} (lam_a-lam_b)^2 R_{ab} in W's own eigenbasis."""
    lam, V = np.linalg.eigh(W)
    P, _, _ = phis(n)
    v = np.einsum('ag,gij->aij', V.T, P)                 # v_a as n x n matrices
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    R = 0.5 * np.einsum('abij,abij->ab', br, br)         # ||[v_a,v_b]||^2, <X,Y>=1/2 tr
    g2 = (lam[:, None] - lam[None, :]) ** 2
    return float(np.sum(g2 * R)), lam, R


def per_generator(n, W, rng):
    """identity (1) at one random generator index."""
    lam, V = np.linalg.eigh(W)
    P, _, _ = phis(n)
    N = P.shape[0]
    v = np.einsum('ag,gij->aij', V.T, P)
    D = ad_matrices(n)
    # W in the phi basis; ad(phi_g) too, so commute directly
    worst = 0.0
    for g in range(N):
        lhs = float(np.sum((D[g] @ W - W @ D[g]) ** 2))
        # T_{g a b} = <[v_g', v_a], v_b>^2 with v_g' = phi_g
        cg = np.einsum('ik,akj->aij', P[g], v) - np.einsum('aik,kj->aij', v, P[g])
        Tg = (0.5 * np.einsum('aij,bij->ab', cg, v)) ** 2
        rhs = float(np.sum((lam[:, None] - lam[None, :]) ** 2 * Tg))
        worst = max(worst, abs(lhs - rhs))
    return worst


def scalar_tensor(n):
    """the constant-curvature tensor: W = Id on Lambda^2."""
    N = n * (n - 1) // 2
    W = np.eye(N)
    return W / np.sqrt(np.sum(W * W))


def ricci_tensor(n, rng):
    """h (x) g Kulkarni-Nomizu with h traceless symmetric: the Sym^2_0 summand."""
    h = rng.normal(size=(n, n)); h = h + h.T; h -= np.trace(h) / n * np.eye(n)
    pairs, idx = pair_index(n)
    N = len(pairs)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            # (h KN g)(i,j,k,l) = h_ik g_jl + h_jl g_ik - h_il g_jk - h_jk g_il
            d = lambda p, q: 1.0 if p == q else 0.0
            W[a, b] = h[i, k]*d(j, l) + h[j, l]*d(i, k) - h[i, l]*d(j, k) - h[j, k]*d(i, l)
    W = 0.5 * (W + W.T)
    return W / np.sqrt(np.sum(W * W))


def main():
    rng = np.random.default_rng(20260823)

    print("=== (1) Petersen-Wink Prop 1.7 per generator ===")
    for n in (5, 6, 7):
        W = rand_weyl(n, rng)
        print(f"  n={n}  max_g |LHS-RHS| = {per_generator(n, W, rng):.2e}")

    print("\n=== (2) the summed identity, and constancy of the Casimir on Weyl_n ===")
    vals = {}
    for n in (5, 6, 7, 8, 9):
        got = []
        for t in range(4):
            W = rand_weyl(n, rng)
            cas = casimir_form(n, W)
            gm, lam, R = gap_moment(n, W)
            got.append((cas, gm))
        spread = max(abs(a - b) for a, _ in got for b, _ in got)
        res = max(abs(a - b) for a, b in got)
        vals[n] = got[0][0]
        print(f"  n={n}  c_W = {got[0][0]:.10f}   spread over 4 Weyl tensors = {spread:.2e}"
              f"   max|Casimir - gap moment| = {res:.2e}")

    print("\n  control -- random symmetric operator on Lambda^2 (not Weyl):")
    for n in (6, 7):
        got = []
        for t in range(3):
            N = n * (n - 1) // 2
            S = rng.normal(size=(N, N)); S = S + S.T; S /= np.sqrt(np.sum(S * S))
            got.append(casimir_form(n, S))
        print(f"    n={n}  values {['%.4f' % g for g in got]}  spread"
              f" = {max(got)-min(got):.3f}")

    print("\n=== (3) the other two curvature summands ===")
    for n in (5, 6, 7, 8):
        s = casimir_form(n, scalar_tensor(n))
        r = casimir_form(n, ricci_tensor(n, rng))
        print(f"  n={n}  scalar module: {s:.2e}   Sym^2_0 module: {r:.10f}"
              f"   Weyl: {vals[n]:.10f}")

    print("\n=== (4) closed form for c_W(n) ===")
    ns = np.array(sorted(vals))
    ys = np.array([vals[n] for n in ns])
    for label, f in (("4n", lambda n: 4.0*n),
                     ("2n", lambda n: 2.0*n),
                     ("4(n+1)", lambda n: 4.0*(n+1)),
                     ("2(n+2)", lambda n: 2.0*(n+2)),
                     ("4(n-1)", lambda n: 4.0*(n-1))):
        err = np.abs(ys - f(ns)).max()
        print(f"  c_W(n) = {label:10s}  max err {err:.2e}"
              + ("   <-- MATCH" if err < 1e-8 else ""))
    print("  measured:", "  ".join(f"n={n}: {vals[n]:.8f}" for n in ns))


if __name__ == '__main__':
    main()
