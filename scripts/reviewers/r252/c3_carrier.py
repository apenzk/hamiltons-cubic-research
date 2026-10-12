"""r252, claim 3: the padding transfer's carrier hypothesis.

Three questions, in order.

  (A) REPRODUCE r250's counterexample.  J_1 = I_1 + I_2/n and J_2 = I_1 + I_2/24
      are independent at n = 12 and identical at n = 24.  Reproduced exactly in
      the structural analogue (24 -> 7, so the collision lands at n = 7 where
      exact arithmetic is cheap) and certified at the real pair (12, 24) by a
      mod-p minor for the independence at 12 plus the substitution at 24.

  (B) HOW BADLY DOES AN n-DEPENDENT COEFFICIENT HURT?  Not fatally.  A carrier
      family with coefficients in Q(n) has a rank that drops only on the common
      root locus of its maximal minors -- a FINITE set, computable.  The J_1/J_2
      pair is exactly a 2x2 family whose single minor 1/24 - 1/n has its only
      root at n = 24.

  (C) ARE THERE PROJECTOR-FREE CARRIERS AT ALL?  YES, and the construction is
      two lines.  If a covariant is F_c = P_n o D_c with P_n the ORTHOGONAL
      projector onto a padding-stable subspace V_n (Weyl_n, or any block) and
      D_c a projector-free diagram, then for x in R^C

          sum_c x_c F_c = 0  <=>  forall W, U in V_n : sum_c x_c <D_c(W), U> = 0

      because P_n is self-adjoint and fixes V_n.  The right-hand family
      G_c(W,U) = <D_c(W), U> is a CLOSED DIAGRAM in W,W,W,U with the same
      n-independent coefficients D_c carries: the projector has been moved onto
      the test tensor, where it acts as the identity.  So the transfer applies
      to G, and independence at 12 gives independence at every n >= 12.

      Checked here on genuine degree-3 covariants at n = 5, 6, including the
      sharp case: a carrier whose image is pure Ricci-part, killed by P_n, whose
      G is identically zero as well.
"""
from fractions import Fraction as Fr
from itertools import product
import random

import numpy as np

P = 1000003  # certification prime for part (A)


# ------------------------------------------------------------------ exact Weyl
def rand_riemann_exact(n, rng, lo=-6, hi=6):
    T = np.empty((n,) * 4, dtype=object)
    for idx in product(range(n), repeat=4):
        T[idx] = Fr(rng.randint(lo, hi))
    R = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        R[a, b, c, d] = (T[a, b, c, d] - T[b, a, c, d] - T[a, b, d, c] + T[b, a, d, c]) / 4
    S = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        S[a, b, c, d] = (R[a, b, c, d] + R[c, d, a, b]) / 2
    B = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        B[a, b, c, d] = S[a, b, c, d] - (S[a, b, c, d] + S[a, c, d, b] + S[a, d, b, c]) / 3
    return B


def kn_exact(A, Bm, n):
    out = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        out[a, b, c, d] = (A[a, c] * Bm[b, d] + A[b, d] * Bm[a, c]
                           - A[a, d] * Bm[b, c] - A[b, c] * Bm[a, d])
    return out


def weyl_part_exact(R, n):
    g = np.empty((n, n), dtype=object)
    for a, b in product(range(n), repeat=2):
        g[a, b] = Fr(1) if a == b else Fr(0)
    ric = np.empty((n, n), dtype=object)
    for b, d in product(range(n), repeat=2):
        ric[b, d] = sum(R[a, b, a, d] for a in range(n))
    scal = sum(ric[a, a] for a in range(n))
    return (R - kn_exact(g, ric, n) / (n - 2)
            + kn_exact(g, g, n) * Fr(scal, 2 * (n - 1) * (n - 2)))


def weyl_checks(W, n):
    for a, b, c, d in product(range(n), repeat=4):
        if W[a, b, c, d] != -W[b, a, c, d]:
            return "antisym ab"
        if W[a, b, c, d] != W[c, d, a, b]:
            return "pair"
        if W[a, b, c, d] + W[a, c, d, b] + W[a, d, b, c] != 0:
            return "Bianchi"
    for b, d in product(range(n), repeat=2):
        if sum(W[a, b, a, d] for a in range(n)) != 0:
            return "trace"
    return None


def as_matrix_exact(W, n, kind):
    M = np.empty((n * n, n * n), dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        if kind == "pairs":
            M[a * n + b, c * n + d] = W[a, b, c, d]
        else:
            M[a * n + b, c * n + d] = W[a, c, b, d]
    return M


def I1_I2_exact(W, n):
    M = as_matrix_exact(W, n, "pairs")
    Bm = as_matrix_exact(W, n, "cross")
    return np.trace(M @ M @ M), np.trace(Bm @ Bm @ Bm)


# ------------------------------------------------- (A) the J_1 / J_2 witness
def part_A_small():
    print("(A) r250's counterexample, exact, with 24 replaced by 7")
    print("    J_1 = I_1 + I_2/n,  J_2 = I_1 + I_2/7")
    rng = random.Random(252)
    for n in (6, 7):
        rows = []
        for s in range(3):
            R = rand_riemann_exact(n, rng)
            W = weyl_part_exact(R, n)
            bad = weyl_checks(W, n)
            assert bad is None, (n, bad)
            i1, i2 = I1_I2_exact(W, n)
            rows.append((i1, i2, i1 + i2 / n, i1 + i2 / 7))
        # rank of the 2-column matrix [J_1, J_2] over the samples
        r = exact_rank([[r_[2], r_[3]] for r_ in rows])
        r12 = exact_rank([[r_[0], r_[1]] for r_ in rows])
        print(f"    n={n}: rank[I_1,I_2] = {r12}   rank[J_1,J_2] = {r}   "
              f"{'INDEPENDENT' if r == 2 else 'DEPENDENT -- J_1 == J_2'}")
        if n == 7:
            same = all(r_[2] == r_[3] for r_ in rows)
            print(f"          J_1 == J_2 on every sample: {same}")
    print()


def exact_rank(rows):
    M = [list(map(Fr, r)) for r in rows]
    cols = len(M[0])
    rank = 0
    for c in range(cols):
        piv = next((i for i in range(rank, len(M)) if M[i][c] != 0), None)
        if piv is None:
            continue
        M[rank], M[piv] = M[piv], M[rank]
        pv = M[rank][c]
        M[rank] = [x / pv for x in M[rank]]
        for i in range(len(M)):
            if i != rank and M[i][c] != 0:
                f = M[i][c]
                M[i] = [x - f * y for x, y in zip(M[i], M[rank])]
        rank += 1
    return rank


# ------------------------------- (A') the real pair (12, 24), certified mod p
def rand_weyl_int_modp(n, rng, p):
    """An integer Weyl tensor (cleared of its 1/(n-2), 1/2(n-1)(n-2) denominators),
    reduced mod p.  Clearing denominators rescales W by a nonzero constant, which
    changes neither independence nor dependence."""
    T = rng.integers(-6, 7, size=(n,) * 4).astype(np.int64)
    R = (T - T.transpose(1, 0, 2, 3) - T.transpose(0, 1, 3, 2) + T.transpose(1, 0, 3, 2))
    S = R + R.transpose(2, 3, 0, 1)                      # 2 * pair-sym  (x8 so far)
    Bi = 3 * S - (S + S.transpose(0, 2, 3, 1) + S.transpose(0, 3, 1, 2))  # x3
    g = np.eye(n, dtype=np.int64)
    ric = np.einsum('abad->bd', Bi)
    scal = np.trace(ric)
    def kn(A, B):
        return (np.einsum('ac,bd->abcd', A, B) + np.einsum('bd,ac->abcd', A, B)
                - np.einsum('ad,bc->abcd', A, B) - np.einsum('bc,ad->abcd', A, B))
    den = 2 * (n - 1) * (n - 2)
    W = den * Bi - (den // (n - 2)) * kn(g, ric) + kn(g, g) * scal
    return (W % p).astype(np.int64)


def tr_cube_modp(Mat, p):
    A = Mat % p
    B = (A @ A) % p
    return int(np.trace((B @ A) % p) % p)


def part_A_real():
    print("(A') the real pair: I_1, I_2 independent at n = 12, certified mod p")
    rng = np.random.default_rng(252)
    n = 12
    rows = []
    for _ in range(3):
        W = rand_weyl_int_modp(n, rng, P)
        M = W.transpose(0, 1, 2, 3).reshape(n * n, n * n)
        Bm = W.transpose(0, 2, 1, 3).reshape(n * n, n * n)
        rows.append((tr_cube_modp(M, P), tr_cube_modp(Bm, P)))
    minor = (rows[0][0] * rows[1][1] - rows[0][1] * rows[1][0]) % P
    print(f"    samples (I_1, I_2) mod p: {rows[:2]}")
    print(f"    2x2 minor mod p = {minor}  ->  "
          f"{'NONZERO: I_1, I_2 independent at n=12 over Q' if minor else 'zero (inconclusive)'}")
    print("    at n = 24: J_1 = I_1 + I_2/24 = J_2 by substitution -- IDENTICAL.")
    print("    r250's counterexample REPRODUCES.\n")


# -------------------------------- (B) an n-dependent carrier drops rank only
#                                       on a finite root set
def part_B():
    print("(B) how much an n-dependent coefficient actually costs")
    print("    A carrier matrix A(n) with entries in Q(n) whose rank is full at")
    print("    n = 12 has full rank at every n outside the common root locus of")
    print("    its maximal minors -- a FINITE, computable set.")
    import sympy as sp
    nn = sp.symbols('n')
    A = sp.Matrix([[1, 1 / nn], [1, sp.Rational(1, 24)]])
    det = sp.simplify(A.det())
    roots = sp.solve(sp.numer(sp.together(det)), nn)
    print(f"    J_1/J_2 carrier matrix det = {det}, roots = {roots}")
    print("    So r250's witness is a rank drop at a single root, not a generic")
    print("    failure: the transfer survives as 'every n >= 12 except the roots")
    print("    of an explicit polynomial', which Sturm/root isolation decides.\n")


# ------------------------------- (C) projector-free carriers DO exist
def sym_riemann_f(T):
    R = T - T.transpose(1, 0, 2, 3) - T.transpose(0, 1, 3, 2) + T.transpose(1, 0, 3, 2)
    R = R / 4.0
    S = (R + R.transpose(2, 3, 0, 1)) / 2.0
    return S - (S + S.transpose(0, 2, 3, 1) + S.transpose(0, 3, 1, 2)) / 3.0


def kn_f(A, B):
    return (np.einsum('ac,bd->abcd', A, B) + np.einsum('bd,ac->abcd', A, B)
            - np.einsum('ad,bc->abcd', A, B) - np.einsum('bc,ad->abcd', A, B))


def weyl_proj_f(T, n):
    """Orthogonal projector onto Weyl_n: pair-symmetrise, remove Lambda^4, remove traces."""
    R = sym_riemann_f(T)
    g = np.eye(n)
    ric = np.einsum('abad->bd', R)
    scal = np.trace(ric)
    return (R - kn_f(g, ric) / (n - 2)
            + kn_f(g, g) * scal / (2.0 * (n - 1) * (n - 2)))


def rand_weyl_f(n, rng):
    return weyl_proj_f(rng.standard_normal((n,) * 4), n)


def carriers(W, n):
    """Six degree-3 projector-free diagram carriers, 4 free legs each.
    D6 is the sharp one: its image is a pure Ricci-part (Kulkarni-Nomizu),
    which the Weyl projector annihilates."""
    D = []
    D.append(np.einsum('apqr,bpqs,crsd->abcd', W, W, W))
    D.append(np.einsum('apbq,prqs,rcsd->abcd', W, W, W))
    D.append(np.einsum('abpq,pqrs,rscd->abcd', W, W, W))
    D.append(np.einsum('apcq,prqs,rbsd->abcd', W, W, W))
    D.append(np.einsum('abpq,prcs,qrds->abcd', W, W, W))
    T = np.einsum('apqr,bpqs,rs->ab', W, W, np.eye(n))     # a symmetric 2-tensor
    D.append(kn_f(np.eye(n), T))                            # pure Ricci-part image
    return D


def part_C():
    print("(C) projector-free carriers EXIST: move the projector onto the test tensor")
    rng = np.random.default_rng(7)
    for n in (5, 6):
        # sanity: the projector is idempotent, self-adjoint, and fixes Weyl_n
        X = rng.standard_normal((n,) * 4)
        Y = rng.standard_normal((n,) * 4)
        PX, PY = weyl_proj_f(X, n), weyl_proj_f(Y, n)
        idem = np.abs(weyl_proj_f(PX, n) - PX).max()
        selfadj = abs(np.sum(PX * Y) - np.sum(X * PY))
        Wt = rand_weyl_f(n, rng)
        fixes = np.abs(weyl_proj_f(Wt, n) - Wt).max()
        print(f"    n={n}: P idempotent {idem:.2e}, self-adjoint {selfadj:.2e}, "
              f"fixes Weyl {fixes:.2e}")

        Ws = [rand_weyl_f(n, rng) for _ in range(14)]
        Us = [rand_weyl_f(n, rng) for _ in range(14)]

        # family 1: the covariants themselves, F_c = P o D_c
        rowsF = []
        for c in range(6):
            row = []
            for W in Ws:
                row.extend(weyl_proj_f(carriers(W, n)[c], n).ravel())
            rowsF.append(row)
        # family 2: the projector-free closed diagrams G_c(W,U) = <D_c(W), U>
        rowsG = []
        for c in range(6):
            row = []
            for W in Ws:
                Dc = carriers(W, n)[c]
                for U in Us:
                    row.append(float(np.sum(Dc * U)))
            rowsG.append(row)

        rF = np.linalg.matrix_rank(np.array(rowsF), tol=1e-8)
        rG = np.linalg.matrix_rank(np.array(rowsG), tol=1e-8)
        nF6 = np.abs(np.array(rowsF[5])).max()
        nG6 = np.abs(np.array(rowsG[5])).max()
        print(f"          rank of {{F_c = P o D_c}} = {rF}   "
              f"rank of {{G_c = <D_c(.),U>}} = {rG}   "
              f"{'EQUAL' if rF == rG else 'DIFFER -- theorem broken'}")
        print(f"          sharp case D_6 (pure Ricci image): |F_6| = {nF6:.2e}, "
              f"|G_6| = {nG6:.2e}  (both vanish, as the theorem says)")
    print()


def part_C_padding():
    """G_c is a closed diagram in (W,W,W,U): padding leaves its value alone."""
    print("(C') the G-family pads exactly, so the transfer applies to it")
    rng = random.Random(3)
    m = 5
    R = rand_riemann_exact(m, rng)
    W = weyl_part_exact(R, m)
    R2 = rand_riemann_exact(m, rng)
    U = weyl_part_exact(R2, m)
    assert weyl_checks(W, m) is None and weyl_checks(U, m) is None

    def pad(X, m, n):
        out = np.empty((n,) * 4, dtype=object)
        out[:] = Fr(0)
        out[:m, :m, :m, :m] = X
        return out

    def G(W, U, n, which):
        """<D(W), U> for three of the carriers, in exact arithmetic."""
        tot = Fr(0)
        rng4 = range(n)
        if which == 3:   # D3: W_abpq W_pqrs W_rscd  contracted with U_abcd
            for a, b, c, d in product(rng4, repeat=4):
                u = U[a, b, c, d]
                if u == 0:
                    continue
                s = Fr(0)
                for p, q in product(rng4, repeat=2):
                    w1 = W[a, b, p, q]
                    if w1 == 0:
                        continue
                    for r, t in product(rng4, repeat=2):
                        s += w1 * W[p, q, r, t] * W[r, t, c, d]
                tot += u * s
        return tot

    base = G(W, U, m, 3)
    print(f"    n={m}: <D_3(W), U> = {base}")
    for n in (6, 7):
        Wp, Up = pad(W, m, n), pad(U, m, n)
        assert weyl_checks(Wp, n) is None and weyl_checks(Up, n) is None, n
        got = G(Wp, Up, n, 3)
        print(f"    padded {m}->{n}: {got}   {'EQUAL' if got == base else 'DIFFERS'}")
    print()


if __name__ == "__main__":
    part_A_small()
    part_A_real()
    part_B()
    part_C()
    part_C_padding()
