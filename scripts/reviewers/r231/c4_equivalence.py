"""r231 claim 4: does the lemma HALVE the transfer question, or restate it?

THE LOGICAL POINT.  Let E be the extension.  By construction (Levin-Chandrasekaran
over {B_n}) E is B_n-invariant, so its stabiliser Inv(E) is a subgroup of O(n)
CONTAINING B_n.  The lemma says <B_n, block O(n_0)> = O(n).  Therefore

    E is block-O(n_0)-invariant   <=>   E is O(n)-invariant

  (=>)  Inv(E) contains B_n and the block, hence contains the group they
        generate, which the lemma says is O(n).
  (<=)  the block is a subgroup of O(n).

So the residual statement is EQUIVALENT to the original, not weaker.  This script
exhibits that equivalence concretely on a space where both sides are computable:
homogeneous polynomials on R^n, where "the description" is a polynomial, B_n acts
by signed permutation of coordinates and O(n) acts by rotation.

  dim {B_n-invariant} >= dim {B_n-inv AND block-inv} = dim {O(n)-invariant}

The middle equals the right for EVERY n_0 >= 2 -- adding the block to B_n buys
exactly full O(n)-invariance, no intermediate.  And the left is strictly bigger,
so the question is not vacuous: B_n-invariant non-O(n)-invariant extensions exist.
"""
import itertools
from sympy import symbols, Poly, Rational, expand, diff, zeros, Matrix

def run(n, deg, n0):
    x = symbols(f'x0:{n}')

    # --- basis of B_n-invariant homogeneous polys of degree deg -------------
    # B_n = signed permutations: invariants are symmetric in the x_i^2, i.e.
    # monomial symmetric functions in x^2 indexed by partitions of deg/2.
    assert deg % 2 == 0
    parts = []
    def gen(rem, mx, cur):
        if rem == 0:
            parts.append(tuple(cur)); return
        for k in range(min(rem, mx), 0, -1):
            gen(rem - k, k, cur + [k])
    gen(deg // 2, deg // 2, [])
    parts = [p for p in parts if len(p) <= n]
    basis = []
    for p in parts:
        s = 0
        seen = set()
        for idx in itertools.permutations(range(n), len(p)):
            key = tuple(sorted(zip(idx, p)))
            if key in seen:
                continue
            seen.add(key)
            t = 1
            for i, e in zip(idx, p):
                t *= x[i] ** (2 * e)
            s += t
        basis.append(expand(s))

    # --- impose the infinitesimal rotation L_{01} = x0 d1 - x1 d0 -----------
    # (L_{01} generates SO(2) inside the block; every other plane rotation of
    #  the block is its conjugate by a coordinate permutation, which is in B_n,
    #  so on B_n-invariants this ONE generator already imposes the whole block.)
    L = lambda f, i, j: expand(x[i] * diff(f, x[j]) - x[j] * diff(f, x[i]))
    gens = [(i, j) for i in range(n0) for j in range(i + 1, n0)]  # ALL of the block
    images = [L(b, i, j) for b in basis for (i, j) in gens]
    mons = sorted({m for im in images for m in Poly(im, *x).monoms()}) if any(images) else []
    nb = len(basis)
    rows = []
    for m in mons:
        for gi in range(len(gens)):
            rows.append([Poly(images[b * len(gens) + gi], *x).coeff_monomial(m)
                         for b in range(nb)])
    A = Matrix(rows) if rows else zeros(1, nb)
    ker = A.nullspace()
    # the same computation with the SINGLE generator L_{01}, to show the other
    # block generators are redundant on B_n-invariants
    rows1 = [[Poly(images[b * len(gens)], *x).coeff_monomial(m) for b in range(nb)]
             for m in mons]
    ker1 = (Matrix(rows1) if rows1 else zeros(1, nb)).nullspace()
    assert len(ker1) == len(ker), (
        "the block's extra generators cut further than L_01 alone -- then the "
        "n_0=2 corollary would be strictly weaker than the n_0-block statement")

    # --- O(n)-invariants of degree deg: exactly span{ (sum x_i^2)^(deg/2) } --
    on_dim = 1
    return len(basis), len(ker), on_dim, parts

print("  space: homogeneous degree-d polys on R^n")
print("  (dim B_n+block imposes ALL n_0(n_0-1)/2 block generators; an internal")
print("   assert checks the single generator L_01 already cuts as far)")
print(f"  {'n':>3} {'d':>3} {'n_0':>4} {'dim B_n-inv':>12} {'dim B_n+block':>14} "
      f"{'dim O(n)-inv':>13} {'verdict':>10}")
for n, deg in ((5, 4), (5, 6), (6, 4), (6, 6), (6, 8), (7, 6)):
    for n0 in (2, 3, 4):
        if n0 > n:
            continue
        b, k, o, parts = run(n, deg, n0)
        v = "EQUAL" if k == o else "DIFFERS"
        print(f"  {n:>3} {deg:>3} {n0:>4} {b:>12} {k:>14} {o:>13} {v:>10}")
        assert k == o, (
            f"block-invariance at n_0={n0} left a {k}-dimensional space where "
            f"O(n)-invariance leaves {o}.  If this ever fired, the residual "
            "statement would be STRICTLY WEAKER than O(n)-invariance and the "
            "lemma would buy something.")
        assert b > o, (
            "B_n-invariance alone already forces O(n)-invariance, so the "
            "transfer question would be vacuous")
print("\n  In every case the block-invariant B_n-invariants are EXACTLY the")
print("  O(n)-invariants.  Adding the block to B_n leaves no intermediate class:")
print("  the residual question is the original question, restated.")
print("\n  And the strictly-bigger left column is the witness that the question")
print("  is real: e.g. sum x_i^4 is B_n-invariant and not O(n)-invariant.")
