"""r250, claim 3: does zero-padding give independence-at-12 => independence at every n >= 12?

Four things are checked, all in exact rational or integer arithmetic.

  (1) THE INCLUSION.  Zero-padding W_m -> W_n (m <= n) lands in W_n: the Riemann
      symmetries and the first Bianchi identity are index identities and survive
      verbatim; tracelessness survives because the n-dimensional trace sums the
      extra directions over zeros.

  (2) THE CARRIER.  A reduced contraction diagram takes the SAME value on the
      padded tensor.  A diagram carrying free metric loops takes (n/m)^L times
      it -- a nonzero scalar -- so the no-free-loop lemma is a convenience, not a
      hypothesis of the direction claimed.

  (3) THE DIRECTION.  restriction f |-> f o iota is linear and carries the level-n
      family to the level-m family; {T v_i} independent => {v_i} independent.
      Smaller => larger.  The script exhibits the implication and its failure the
      other way round.

  (4) THE CONVERSE IS FALSE, with an exact witness: the 105 Brauer matchings on
      8 legs have a nonsingular Gram at n = 4 and a rank-100 Gram at n = 3.
      Independence at the LARGER dimension says nothing at the smaller one.
"""
from fractions import Fraction as F
from itertools import product, combinations
import random

import numpy as np


# ---------------------------------------------------------------- exact Weyl
def rand_riemann(n, rng):
    """A random tensor with the Riemann symmetries and the first Bianchi identity."""
    T = np.empty((n,) * 4, dtype=object)
    for idx in product(range(n), repeat=4):
        T[idx] = F(rng.randint(-6, 6))
    # antisymmetrise ab and cd, then symmetrise the pairs
    R = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        R[a, b, c, d] = (T[a, b, c, d] - T[b, a, c, d] - T[a, b, d, c] + T[b, a, d, c]) / 4
    S = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        S[a, b, c, d] = (R[a, b, c, d] + R[c, d, a, b]) / 2
    # remove the totally antisymmetric part -> first Bianchi
    B = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        B[a, b, c, d] = S[a, b, c, d] - (S[a, b, c, d] + S[a, c, d, b] + S[a, d, b, c]) / 3
    return B


def kn(A, Bm, n):
    """Kulkarni-Nomizu product of two symmetric 2-tensors."""
    out = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        out[a, b, c, d] = (A[a, c] * Bm[b, d] + A[b, d] * Bm[a, c]
                           - A[a, d] * Bm[b, c] - A[b, c] * Bm[a, d])
    return out


def weyl_part(R, n):
    g = np.empty((n, n), dtype=object)
    for a, b in product(range(n), repeat=2):
        g[a, b] = F(1) if a == b else F(0)
    ric = np.empty((n, n), dtype=object)
    for b, d in product(range(n), repeat=2):
        ric[b, d] = sum(R[a, b, a, d] for a in range(n))
    scal = sum(ric[a, a] for a in range(n))
    W = (R - kn(g, ric, n) / (n - 2)
         + kn(g, g, n) * F(scal, 2 * (n - 1) * (n - 2)))
    return W


def checks(W, n, label):
    bad = []
    for a, b, c, d in product(range(n), repeat=4):
        if W[a, b, c, d] != -W[b, a, c, d]:
            bad.append(("antisym ab", (a, b, c, d)))
        if W[a, b, c, d] != W[c, d, a, b]:
            bad.append(("pair", (a, b, c, d)))
        if W[a, b, c, d] + W[a, c, d, b] + W[a, d, b, c] != 0:
            bad.append(("Bianchi", (a, b, c, d)))
        if bad:
            break
    for b, d in product(range(n), repeat=2):
        if sum(W[a, b, a, d] for a in range(n)) != 0:
            bad.append(("trace", (b, d)))
            break
    print(f"  {label:<28} n={n:<3} Weyl checks: {'PASS' if not bad else bad[:2]}")
    return not bad


def pad(W, m, n):
    out = np.empty((n,) * 4, dtype=object)
    out[:] = F(0)
    out[:m, :m, :m, :m] = W
    return out


# ------------------------------------------------------- diagram evaluations
def as_matrix(W, n, kind):
    M = np.empty((n * n, n * n), dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        if kind == "pairs":            # M[(ab),(cd)] = W_abcd
            M[a * n + b, c * n + d] = W[a, b, c, d]
        else:                          # M[(ab),(cd)] = W_acbd
            M[a * n + b, c * n + d] = W[a, c, b, d]
    return M


def invariants(W, n):
    A = sum(W[a, b, c, d] * W[a, b, c, d] for a, b, c, d in product(range(n), repeat=4))
    C = sum(W[a, b, c, d] * W[a, c, b, d] for a, b, c, d in product(range(n), repeat=4))
    M = as_matrix(W, n, "pairs")
    Bm = as_matrix(W, n, "cross")
    I1 = np.trace(M @ M @ M)
    I2 = np.trace(Bm @ Bm @ Bm)
    return {"A = WW": A, "C = W_abcd W_acbd": C, "I1 = tr M^3": I1, "I2 = tr B^3": I2}


# --------------------------------------------------------------- Brauer Gram
def matchings(k):
    pts = list(range(2 * k))
    def rec(rest):
        if not rest:
            yield ()
            return
        a, others = rest[0], rest[1:]
        for i, b in enumerate(others):
            for m in rec(others[:i] + others[i + 1:]):
                yield ((a, b),) + m
    return list(rec(pts))


def cycles(m1, m2, npts):
    nb = {i: [] for i in range(npts)}
    for a, b in m1:
        nb[a].append(b); nb[b].append(a)
    for a, b in m2:
        nb[a].append(b); nb[b].append(a)
    seen, c = set(), 0
    for s in range(npts):
        if s in seen:
            continue
        c += 1
        stack = [s]
        while stack:
            v = stack.pop()
            if v in seen:
                continue
            seen.add(v)
            stack.extend(w for w in nb[v] if w not in seen)
    return c


def brauer_gram(k, n):
    ms = matchings(k)
    N = len(ms)
    G = [[n ** cycles(ms[i], ms[j], 2 * k) for j in range(N)] for i in range(N)]
    return ms, G


def int_rank(G, p=1000003):
    """rank over F_p of an integer matrix; p chosen far from any entry structure."""
    A = [[x % p for x in row] for row in G]
    rows, cols = len(A), len(A[0])
    r = 0
    for c in range(cols):
        piv = next((i for i in range(r, rows) if A[i][c]), None)
        if piv is None:
            continue
        A[r], A[piv] = A[piv], A[r]
        inv = pow(A[r][c], p - 2, p)
        A[r] = [(x * inv) % p for x in A[r]]
        for i in range(rows):
            if i != r and A[i][c]:
                f = A[i][c]
                A[i] = [(A[i][j] - f * A[r][j]) % p for j in range(cols)]
        r += 1
        if r == rows:
            break
    return r


# ------------------------------------------------------------------- driver
def main():
    rng = random.Random(250)

    print("(1)+(2) the padding inclusion, and diagram values under it")
    for m, targets in ((5, (6, 7, 9)), (6, (8,))):
        R = rand_riemann(m, rng)
        W = weyl_part(R, m)
        assert checks(W, m, "source Weyl tensor")
        base = invariants(W, m)
        for n in targets:
            Wp = pad(W, m, n)
            assert checks(Wp, n, f"padded {m}->{n}")
            got = invariants(Wp, n)
            for key in base:
                same = got[key] == base[key]
                print(f"      {key:<22} {m}->{n}: {'EQUAL' if same else 'DIFFERS'}"
                      f"   value = {base[key]}")
                assert same, (key, base[key], got[key])
            # a diagram with one free metric loop: delta_aa * A
            loop_m, loop_n = m * base["A = WW"], n * got["A = WW"]
            print(f"      free-loop diagram      {m}->{n}: ratio "
                  f"{F(loop_n, 1) / F(loop_m, 1)} = n/m -> nonzero scalar, "
                  "independence preserved")

    print("\n(3) the direction, stated as linear algebra")
    print("      T: Fun(W_n) -> Fun(W_m), f |-> f o iota, is linear")
    print("      T(J_D^(n)) = J_D^(m)  (line (2))")
    print("      {T v_i} independent => {v_i} independent   [standard]")
    print("      so independence at m=12 => independence at every n >= 12.")

    print("\n(4) the converse is FALSE -- exact Brauer witness, 8 legs, 105 matchings")
    for n in (3, 4, 5):
        ms, G = brauer_gram(4, n)
        r = int_rank(G)
        print(f"      n={n}: {len(ms)} matchings, Gram rank {r}"
              f" -> {'independent' if r == len(ms) else 'DEPENDENT'}")
    print("      independence at n=4 with dependence at n=3: the downward")
    print("      direction fails, so the direction of step 2 is load-bearing.")

    print("\n(5) the same drop, for the very objects at issue: two REDUCED cubic")
    print("    contraction diagrams on Weyl tensors, I1 = tr M^3 and I2 = tr B^3")
    for n in (4, 5, 6, 7):
        rows = []
        for _ in range(3):
            W = weyl_part(rand_riemann(n, rng), n)
            v = invariants(W, n)
            rows.append([v["I1 = tr M^3"], v["I2 = tr B^3"]])
        M = [[F(x) for x in row] for row in rows]
        # exact rank of the 4x2 sample matrix
        r = 0
        cols = 2
        A = [row[:] for row in M]
        for c in range(cols):
            piv = next((i for i in range(r, len(A)) if A[i][c] != 0), None)
            if piv is None:
                continue
            A[r], A[piv] = A[piv], A[r]
            pv = A[r][c]
            A[r] = [x / pv for x in A[r]]
            for i in range(len(A)):
                if i != r and A[i][c] != 0:
                    f = A[i][c]
                    A[i] = [A[i][j] - f * A[r][j] for j in range(cols)]
            r += 1
        ratios = {M[i][1] / M[i][0] for i in range(len(M)) if M[i][0] != 0}
        tag = f"  I2/I1 = {ratios.pop()} on every sample" if len(ratios) == 1 else ""
        print(f"      n={n}: sample rank of (I1, I2) = {r}{tag}")
    print("      DEPENDENT at n=4,5 (I2 = I1/2 identically), INDEPENDENT at n>=6:")
    print("      two reduced diagrams independent at the larger dimension and")
    print("      dependent at the smaller.  Downward transfer is false for the")
    print("      exact class of objects claim 3 speaks about.")


    print("\n(6) the ONE hypothesis the step needs, and a counterexample to dropping it")
    print("      the carrier must have n-INDEPENDENT coefficients.  Let I1, I2 be the")
    print("      two diagrams above, independent as functions for every n >= 6 (rank")
    print("      is non-decreasing in n by padding itself).  Put")
    print("          J1^(n) = I1 + (1/n) I2,      J2^(n) = I1 + (1/24) I2.")
    print("      At n=12 these are I1 + I2/12 and I1 + I2/24: INDEPENDENT.")
    print("      At n=24 they are the same function: DEPENDENT.")
    print("      Nothing is wrong with the padding map; the level-12 family is simply")
    print("      not the restriction of the level-24 family once coefficients see n.")
    print("      Trace removal introduces exactly such coefficients (1/(n-2), 1/n),")
    print("      so the 184 covariants must be carried by PROJECTOR-FREE diagrams.")


if __name__ == "__main__":
    main()
