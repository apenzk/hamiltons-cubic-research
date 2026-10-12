"""Circ-orthogonal splittings: the harmonic-square law's true hypothesis, and a
computable test for indecomposability.

WHY.  Reviewers 56/57 showed that orthogonal direct sums manufacture an infinite
family of non-diagonal S = 0 critical points, so no isotropy-indexed enumeration
can be complete.  This asks whether that family can ever threaten the VALUE bound
sup{theta : S = 0, non-diagonal} <= sqrt(3/2), which is what route B actually
needs.

THE LAW, ON ITS RIGHT HYPOTHESIS.  Q is the quadratic form of the bilinear circ,
Q(X) = X o X, so for any A, B

    Q(aA + bB) = a^2 Q(A) + 2ab (A o B) + b^2 Q(B),

and A o B = 0 makes Q additive.  Disjoint index blocks are one way to get that and
are not needed.  Two consequences follow in two lines each:

  * FROBENIUS ORTHOGONALITY IS FREE.  <A o B, C> is fully symmetric (it polarises
    the cubic P), so if Q(A) = theta_A A then <A o B, A> = <B, Q(A)> = theta_A<A,B>.
    Hence A o B = 0 and theta_A != 0 force <A, B> = 0.  No orthogonality has to be
    assumed alongside circ-orthogonality; it is implied.
  * THE HARMONIC-SQUARE LAW.  Criticality of W = aA + bB then reads
    a^2 theta_A A + b^2 theta_B B = theta(aA + bB), so a theta_A = b theta_B = theta
    and a^2 + b^2 = 1 gives 1/theta^2 = 1/theta_A^2 + 1/theta_B^2, hence
    |theta| <= max_i|theta_i| / sqrt(k) for k >= 2 nonzero pieces.

THE TEST.  If W = sum_i a_i A_i with the A_i pairwise circ-orthogonal and critical,
then A_i o W = a_i Q(A_i) = a_i theta_i A_i = theta A_i, so with e = W/theta

    EVERY circ-SUMMAND OF A CRITICAL POINT LIES IN E(1) OF L_e.

So dim E(1) = 1 certifies that W admits no nontrivial circ-splitting at all.  That
is a rank computation on a matrix the repo already builds, and it is a proof rather
than a search: it rules out splittings nobody has thought of.

WHAT IT DECIDES.  Decomposables are capped by their pieces and can never set a new
maximum, so the infinite family is harmless for the value bound and the residual
narrows to circ-INDECOMPOSABLE non-diagonal S = 0 points.  Padding is the b = 0
case and preserves indecomposability, so padded W_CP2 at sqrt(3/2) stays in the
residual -- it is the sharp case, not a casualty.

FALSIFIER.  A critical point with dim E(1) = 1 that nevertheless splits, or a
circ-orthogonal critical pair whose combination beats (sum 1/theta_i^2)^(-1/2).
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import (pair_index, adj, Q, circ, weyl_basis,
                             sphere_product_W, normalize)
from b_cpm_closed_form import W_cpm
from b_cp2_nondegenerate import padded_cp2
from b_c5_blowup import c5_operator


def multiblock_W(blocks):
    """The Weyl part of a k-block round product, k >= 3.

    The naive 1/(p(p-1)) diagonal is Weyl only for k = 2: built with three equal
    blocks it has criticality residual 0.38, so the trace-correction terms below
    are load-bearing rather than cosmetic."""
    n = sum(blocks); pairs, idx = pair_index(n)
    S = sum(b * (b - 1) for b in blocks); sigma = S / ((n - 1) * (n - 2))
    lab = []
    for bi, b in enumerate(blocks):
        lab += [bi] * b
    W = np.zeros((len(pairs), len(pairs)))
    for a, (i, j) in enumerate(pairs):
        bi, bj = blocks[lab[i]], blocks[lab[j]]
        W[a, a] = (1 - 2 * (bi - 1) / (n - 2) + sigma if lab[i] == lab[j]
                   else -((bi - 1) + (bj - 1)) / (n - 2) + sigma)
    return W, n


def build_Le(n, e, B):
    """Matrix of X -> e o X on span(B), vectorised.  Cross-checked against circ."""
    A = adj(n); N = A.shape[0]; D = len(B)
    Ae = (A.reshape(N * N, N) @ e).reshape(N, N, N)          # Ae[a] = A_a e
    K = np.einsum('apq,bqr->abrp', Ae, A, optimize=True).reshape(N * N, N * N)
    Bf = np.asarray(B).reshape(D, N * N)
    T = (Bf @ K.T).reshape(D, N, N)                          # T[c,a,b]
    out = 0.5 * (e @ np.asarray(B) + np.asarray(B) @ e) - 0.25 * (T + T.transpose(0, 2, 1))
    return Bf @ out.reshape(D, N * N).T


def embed(W0, n0, n, off):
    p0, _ = pair_index(n0); pairs, idx = pair_index(n)
    M = np.zeros((len(pairs), len(pairs)))
    for a, (i, j) in enumerate(p0):
        for b, (k, l) in enumerate(p0):
            M[idx[(i + off, j + off)], idx[(k + off, l + off)]] = W0[a, b]
    return M


def theta(n, W):
    return float(np.tensordot(W, Q(n, W)))


def dim_E1(n, W, B, tol=1e-7):
    """dim E(1), with the criticality guard the test presupposes.

    W itself always satisfies e o W = W, so dim E(1) >= 1 at any critical point;
    a reported 0 means the point handed in is not critical, not that it is rigid."""
    th = theta(n, W)
    res = float(np.linalg.norm(Q(n, W) - th * W))
    L = build_Le(n, W / th, B)
    ev = np.linalg.eigvalsh(0.5 * (L + L.T))
    return int((np.abs(ev - 1.0) < tol).sum()), th, res


def catalogue():
    out = []
    W, _ = sphere_product_W([3, 3]); out.append(("S^3 x S^3", 6, normalize(W)))
    W, _ = sphere_product_W([6, 6]); out.append(("S^6 x S^6 (balanced, n=12)", 12, normalize(W)))
    W, n = multiblock_W([4, 4, 4]); out.append(("(S^4)^3, multi-block", n, normalize(W)))
    W, n = multiblock_W([3, 3, 3, 3]); out.append(("(S^3)^4, multi-block", n, normalize(W)))
    W, _, _ = W_cpm(3); out.append(("CP^3", 6, normalize(W)))
    W, _, _ = W_cpm(4); out.append(("CP^4", 8, normalize(W)))
    W, _ = padded_cp2(12); out.append(("W_CP2 padded to n=12", 12, normalize(W)))
    W, n = c5_operator([2] * 5); out.append(("C_5 blow-up", n, normalize(W)))
    return out


if __name__ == "__main__":
    # ---- cross-check the vectorised L_e against circ, on a case where both run
    n = 6; B = weyl_basis(n); W, _ = sphere_product_W([3, 3]); W = normalize(W)
    th = theta(n, W); e = W / th
    L = build_Le(n, e, B)
    Lref = np.array([[float(np.tensordot(B[d], circ(n, e, B[c]))) for c in range(len(B))]
                     for d in range(len(B))])
    print(f"L_e cross-check vs circ (n=6): max |diff| = {np.abs(L - Lref.T).max():.2e}")

    # ---- Lemma: A o B = 0 and A critical force <A,B> = 0, and the harmonic law
    print("\n=== the law, on circ-orthogonal critical pairs ===")
    print(f"{'A (+) B':38s} {'th_A':>9s} {'th_B':>9s} {'|AoB|':>9s} {'<A,B>':>10s} "
          f"{'theta':>10s} {'law':>10s} {'crit res':>9s}")
    cases = [("W_CP2 (+) S^4xS^4", padded_cp2(4)[0], 4, sphere_product_W([4, 4])[0], 8),
             ("W_CP2 (+) W_CP2", padded_cp2(4)[0], 4, padded_cp2(4)[0], 4),
             ("S^3xS^3 (+) S^3xS^3", sphere_product_W([3, 3])[0], 6, sphere_product_W([3, 3])[0], 6),
             ("W_CP2 (+) S^3xS^3", padded_cp2(4)[0], 4, sphere_product_W([3, 3])[0], 6)]
    for name, WA0, nA, WB0, nB in cases:
        n = nA + nB
        A_ = normalize(embed(normalize(WA0), nA, n, 0))
        B_ = normalize(embed(normalize(WB0), nB, n, nA))
        thA, thB = theta(n, A_), theta(n, B_)
        cross = float(np.linalg.norm(circ(n, A_, B_)))
        ip = float(np.tensordot(A_, B_))
        law = 1.0 / np.sqrt(1 / thA**2 + 1 / thB**2)
        W = law / thA * A_ + law / thB * B_
        W = normalize(W)
        th = theta(n, W)
        res = float(np.linalg.norm(Q(n, W) - th * W))
        print(f"{name+f'  n={n}':38s} {thA:9.6f} {thB:9.6f} {cross:9.2e} {ip:10.2e} "
              f"{th:10.6f} {law:10.6f} {res:9.2e}")

    # ---- dim E(1) across the catalogue, plus a decomposable positive control
    print("\n=== dim E(1) of L_e: 1 certifies circ-indecomposable ===")
    print(f"{'point':32s} {'n':>3s} {'theta':>10s} {'crit res':>9s} {'dim E(1)':>9s}  verdict")
    rows = catalogue()
    nA = 4; nB = 8; n = 12
    A_ = normalize(embed(normalize(padded_cp2(4)[0]), nA, n, 0))
    B_ = normalize(embed(normalize(sphere_product_W([4, 4])[0]), nB, n, nA))
    thA, thB = theta(n, A_), theta(n, B_)
    law = 1.0 / np.sqrt(1 / thA**2 + 1 / thB**2)
    rows.append(("W_CP2 (+) S^4xS^4 (control)", 12,
                 normalize(law / thA * A_ + law / thB * B_)))
    E1cases = []
    for name, n, W in rows:
        B = weyl_basis(n)
        d, th, res = dim_E1(n, W, B)
        if res < 1e-8 and d > 1:
            E1cases.append((name, n, W, B, th, d))
        verdict = ("NOT CRITICAL -- test inapplicable" if res > 1e-8 else
                   "INDECOMPOSABLE (proved)" if d == 1 else "may split")
        print(f"{name:32s} {n:3d} {th:10.6f} {res:9.2e} {d:9d}  {verdict}")

    # ---- is E(1) closed under circ, and what are its idempotents?
    print("\n=== E(1) as an algebra: closure, then its idempotent splittings ===")
    for name, n, W, B, th, d in E1cases:
        L = build_Le(n, W / th, B)
        ev, evec = np.linalg.eigh(0.5 * (L + L.T))
        U = evec[:, np.abs(ev - 1.0) < 1e-7]
        Bf = np.asarray(B)
        basis = np.einsum('cd,cij->dij', U, Bf)            # (d, N, N)
        leak = 0.0
        C = np.zeros((d, d, d))
        for i in range(d):
            for j in range(d):
                Z = circ(n, basis[i], basis[j])
                co = np.array([float(np.tensordot(basis[k], Z)) for k in range(d)])
                C[i, j] = co
                # scale by 1 rather than ||Z||: the products that vanish are the
                # point of the test, and dividing 1e-16 by 1e-12 reports 1e-4
                leak = max(leak, float(np.linalg.norm(
                    Z - np.einsum('k,kij->ij', co, basis)) / max(np.linalg.norm(Z), 1.0)))
        print(f"  {name}: dim E(1) = {d}, circ-leakage out of E(1) = {leak:.2e}")
        if leak > 1e-8:
            continue
        # idempotents of the d-dimensional algebra, by multistart Newton on x o x = x
        rng = np.random.default_rng(7)
        found = []
        for _ in range(4000):
            x = rng.normal(size=d)
            for _ in range(200):
                F = np.einsum('ijk,i,j->k', C, x, x) - x
                J = 2 * np.einsum('ijk,i->jk', C, x) - np.eye(d)
                try:
                    step = np.linalg.solve(J.T, F)
                except np.linalg.LinAlgError:
                    break
                x = x - step
                if np.linalg.norm(step) < 1e-13:
                    break
            if np.linalg.norm(np.einsum('ijk,i,j->k', C, x, x) - x) < 1e-10:
                if not any(np.linalg.norm(x - y) < 1e-6 for y in found):
                    found.append(x.copy())
        prim = [x for x in found if np.linalg.norm(x) > 1e-9]
        print(f"    nontrivial idempotents of E(1): {len(prim)}")
        wv = np.array([float(np.tensordot(basis[k], W)) for k in range(d)]) / th
        # the pieces of e itself: circ-orthogonal idempotents summing to e
        for x in prim:
            for y in prim:
                if np.linalg.norm(x + y - wv) < 1e-8 and np.linalg.norm(
                        np.einsum('ijk,i,j->k', C, x, y)) < 1e-8:
                    Wx = np.einsum('k,kij->ij', x, basis)
                    Wy = np.einsum('k,kij->ij', y, basis)
                    tx = 1 / np.linalg.norm(Wx); ty = 1 / np.linalg.norm(Wy)
                    print(f"    e = e1 + e2 circ-orthogonally: theta = "
                          f"{tx:.6f}, {ty:.6f} -> law {1/np.sqrt(1/tx**2+1/ty**2):.6f} "
                          f"vs theta = {th:.6f}")
                    break
            else:
                continue
            break
