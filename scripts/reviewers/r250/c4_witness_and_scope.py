"""r250, claim 4: is the refutation record of 6536b2f faithful and complete?

Part 1 reproduces the witness exactly and isolates the hypothesis it needs.
Part 2 reproduces both Grams and checks the two numbers the record quotes.
Part 3 asks what the projector-free Brauer pairing actually decides, since the
record's framing ("says nothing", "the monomial theorem measures the ambient
space") is read as writing it off.
"""
from fractions import Fraction as F
from itertools import product
import random

import numpy as np
import sympy as sp

import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from c3_padding import (rand_riemann, weyl_part, checks, matchings, cycles,
                        brauer_gram, int_rank)


def A_form(W, V, n):
    return sum(W[a, b, c, d] * V[a, b, c, d] for a, b, c, d in product(range(n), repeat=4))


def C_form(W, V, n):
    return sum(W[a, b, c, d] * V[a, c, b, d] for a, b, c, d in product(range(n), repeat=4))


def rand_pairsym_no_bianchi(n, rng):
    """Riemann symmetries WITHOUT the first Bianchi identity -- isolates the hypothesis."""
    T = np.empty((n,) * 4, dtype=object)
    for idx in product(range(n), repeat=4):
        T[idx] = F(rng.randint(-5, 5))
    R = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        R[a, b, c, d] = (T[a, b, c, d] - T[b, a, c, d] - T[a, b, d, c] + T[b, a, d, c]) / 4
    S = np.empty((n,) * 4, dtype=object)
    for a, b, c, d in product(range(n), repeat=4):
        S[a, b, c, d] = (R[a, b, c, d] + R[c, d, a, b]) / 2
    return S


def part1(rng):
    print("PART 1 -- the witness C = A/2, and the hypothesis it uses")
    for n in (5, 6, 7):
        W = weyl_part(rand_riemann(n, rng), n)
        assert checks(W, n, "Weyl tensor")
        A, C = A_form(W, W, n), C_form(W, W, n)
        print(f"      n={n}: A = {A}, C = {C}, C - A/2 = {C - A / 2}")
        assert C == A / 2
        # polarised: the two forms agree as BILINEAR forms, not merely quadratic
        V = weyl_part(rand_riemann(n, rng), n)
        Ab, Cb = A_form(W, V, n), C_form(W, V, n)
        print(f"            polarised on a second Weyl tensor: C(W,V) - A(W,V)/2 "
              f"= {Cb - Ab / 2}")
        assert Cb == Ab / 2
    print("      so as OPERATORS on W_n the diagram C is exactly (1/2) Id.")

    n = 5
    R = rand_riemann(n, rng)          # Bianchi, traces NOT removed
    A, C = A_form(R, R, n), C_form(R, R, n)
    print(f"\n      on a Riemann tensor (Bianchi, traces present): C - A/2 = {C - A / 2}")
    assert C == A / 2
    S = rand_pairsym_no_bianchi(n, rng)   # pair symmetry, NO Bianchi
    A2, C2 = A_form(S, S, n), C_form(S, S, n)
    print(f"      without the first Bianchi identity:            C - A/2 = {C2 - A2 / 2}")
    assert C2 != A2 / 2
    print("      => the record's attribution to the FIRST BIANCHI IDENTITY alone")
    print("         is exact: tracelessness is not used, Bianchi is indispensable.")


def part2():
    print("\nPART 2 -- the two Grams the record quotes")
    n = sp.symbols("n", positive=True)
    # the two diagrams as matchings of 8 legs: W_abcd W_abcd and W_abcd W_acbd
    mA = ((0, 4), (1, 5), (2, 6), (3, 7))
    mC = ((0, 4), (1, 6), (2, 5), (3, 7))
    G = sp.Matrix(2, 2, lambda i, j: n ** cycles((mA, mC)[i], (mA, mC)[j], 8))
    print(f"      projector-free Brauer Gram = {G.tolist()}")
    print(f"      det = {sp.factor(sp.expand(G.det()))}")
    assert sp.simplify(G.det() - n ** 6 * (n ** 2 - 1)) == 0
    for v in (2, 5, 12, 24):
        assert G.det().subs(n, v) != 0
    print("      nonsingular at every n >= 2 -- the record's claim, confirmed.")

    dim = n * (n + 1) * (n + 2) * (n - 3) / 12
    alt = n ** 2 * (n ** 2 - 1) / 12 - n * (n + 1) / 2   # Riemann minus Ricci
    assert sp.simplify(dim - alt) == 0
    print(f"\n      dim W_n = {sp.factor(dim)} = Riemann - Sym^2, and it is a "
          "QUARTIC POLYNOMIAL")
    print("      values at n = 5,6,7,8:",
          [int(dim.subs(n, v)) for v in (5, 6, 7, 8)], "-- matches the record")
    Gp = sp.Matrix([[dim, dim / 2], [dim / 2, dim / 4]])
    print(f"      apolar Gram with the projector = (dim/4)*[[4,2],[2,1]], det = "
          f"{sp.simplify(Gp.det())}")
    assert sp.simplify(Gp.det()) == 0
    print("      singular at every n, as the dependence requires -- confirmed.")
    print("      NOTE: every entry of that Gram is a POLYNOMIAL in n.  The commit")
    print("      message says 'the second is not polynomial'; the example it")
    print("      offers to prove it is a quartic.  What fails is MONOMIALITY.")


def part3():
    print("\nPART 3 -- what the projector-free pairing decides")
    # (a) it is the Frobenius Gram of the diagram tensors: faithful over R
    for n in (2, 3, 4):
        ms, G = brauer_gram(4, n)
        r_gram = int_rank(G)
        if n <= 3:
            T = np.zeros((len(ms), n ** 8))
            for i, m in enumerate(ms):
                for idx in product(range(n), repeat=4):
                    full = [0] * 8
                    for (p, q), v in zip(m, idx):
                        full[p] = full[q] = v
                    T[i, int("".join(str(x) for x in full), n) if n > 1 else 0] += 1
            r_true = np.linalg.matrix_rank(T, tol=1e-8)
        else:
            r_true = None
        print(f"      8 legs, n={n}: Gram rank {r_gram}"
              + (f", true rank of the {len(ms)} matching tensors {r_true}"
                 if r_true is not None else ", 105 matchings"))
        if r_true is not None:
            assert r_gram == r_true
    print("      the projector-free Gram equals the Frobenius Gram of the diagram")
    print("      tensors, so over R it is POSITIVE SEMIDEFINITE and its rank IS the")
    print("      ambient rank -- exactly, with no gap.")

    print("\n      the consequence, which the record does not state:")
    print("        rank(restrictions to W_n) <= rank(diagrams in the ambient space)")
    print("      so a RANK-DEFICIENT projector-free Gram over R certifies DEPENDENCE")
    print("      of the covariants as functions on W_n.  At n=3 above, 105-91 = 14")
    print("      independent relations are certified this way without any projector.")
    print("      The pairing is a sound test for dependence and an unsound one for")
    print("      independence.  Half a decision procedure, not none.")


if __name__ == "__main__":
    rng = random.Random(4250)
    part1(rng)
    part2()
    part3()
