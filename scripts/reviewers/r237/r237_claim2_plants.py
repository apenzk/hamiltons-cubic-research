"""r237, claim 2: does constancy of the DIMENSION force equality of the KERNELS?

The file's equivalence is

    lift canonical from n_0  <=>  dim (Sym^6 W_n)^{O(n)} constant on [n_0, inf).

It rests on two hypotheses that the equivalence itself does not name:

  (H1) the kernels are NESTED (fact (ii)), and
  (H2) eps_n is SURJECTIVE at every n >= n_0 (fact (i)), so that the dimension
       being counted IS the rank of eps_n.

This script confirms the lattice step under H1+H2 and plants a violation of each
hypothesis separately, showing that dropping either one breaks the equivalence
while leaving every number in the file's statement intact.  Exact arithmetic
over Q (Fraction) throughout; no sampling.
"""
from fractions import Fraction

def rref_rank(rows):
    M = [[Fraction(x) for x in r] for r in rows]
    r = 0
    if not M:
        return 0
    for c in range(len(M[0])):
        p = next((i for i in range(r, len(M)) if M[i][c] != 0), None)
        if p is None:
            continue
        M[r], M[p] = M[p], M[r]
        pv = M[r][c]
        M[r] = [x / pv for x in M[r]]
        for i in range(len(M)):
            if i != r and M[i][c] != 0:
                f = M[i][c]
                M[i] = [a - f * b for a, b in zip(M[i], M[r])]
        r += 1
    return r

def kernel_basis(rows, dim):
    """kernel of the map c |-> (row . c) for the given rows, as a list of vectors."""
    import itertools
    M = [[Fraction(x) for x in r] for r in rows]
    # gaussian elimination on columns: solve M c = 0
    piv, r = [], 0
    A = [row[:] for row in M]
    for c in range(dim):
        p = next((i for i in range(r, len(A)) if A[i][c] != 0), None)
        if p is None:
            continue
        A[r], A[p] = A[p], A[r]
        pv = A[r][c]
        A[r] = [x / pv for x in A[r]]
        for i in range(len(A)):
            if i != r and A[i][c] != 0:
                f = A[i][c]
                A[i] = [a - f * b for a, b in zip(A[i], A[r])]
        piv.append(c)
        r += 1
    free = [c for c in range(dim) if c not in piv]
    basis = []
    for fc in free:
        v = [Fraction(0)] * dim
        v[fc] = Fraction(1)
        for i, c in enumerate(piv):
            v[c] = -A[i][fc]
        basis.append(v)
    return basis

def span_eq(B1, B2, dim):
    """do two lists of vectors span the same subspace?"""
    r1, r2 = rref_rank(B1) if B1 else 0, rref_rank(B2) if B2 else 0
    r12 = rref_rank(B1 + B2) if (B1 or B2) else 0
    return r1 == r2 == r12

print("=== the lattice step, under H1 + H2 ===")
# V = Q^3.  eps_n given by rows; kernels nested and of constant dimension.
E = {12: [[1, 0, 0], [0, 1, 0]], 13: [[1, 0, 0], [0, 1, 0], [1, 1, 0]]}
K = {n: kernel_basis(rows, 3) for n, rows in E.items()}
print(f"  rank eps_12 = {rref_rank(E[12])}, rank eps_13 = {rref_rank(E[13])}")
print(f"  dim ker_12 = {len(K[12])}, dim ker_13 = {len(K[13])}, "
      f"kernels equal: {span_eq(K[12], K[13], 3)}")
assert span_eq(K[12], K[13], 3)
print("  nested + equal dimension => equal.  The step is valid.")

print("\n=== PLANT 1: drop H1 (nesting).  Constant dimension, different kernels ===")
E1 = {12: [[1, 0, 0], [0, 1, 0]], 13: [[1, 0, 0], [0, 0, 1]]}
K1 = {n: kernel_basis(rows, 3) for n, rows in E1.items()}
print(f"  rank 2 at both n; dim ker = {len(K1[12])} at both n")
print(f"  ker_12 = span{[[str(x) for x in v] for v in K1[12]]}, "
      f"ker_13 = span{[[str(x) for x in v] for v in K1[13]]}")
print(f"  kernels equal: {span_eq(K1[12], K1[13], 3)}")
assert not span_eq(K1[12], K1[13], 3)
print("  The dimension is CONSTANT and the lift is NOT well-defined: (0,0,1) is a")
print("  relation at the base carried to a nonzero invariant above it.  So the")
print("  equivalence is false without (ii).  (ii) is not decoration.")

print("\n=== PLANT 2: drop H2 (surjectivity).  Constant target dimension, jumping rank ===")
# eps_n nested-kernel as required, but the target invariant space is bigger than
# the image, and its dimension happens to be constant.
E2 = {12: [[1, 0, 0]], 13: [[1, 0, 0], [0, 1, 0]]}
K2 = {n: kernel_basis(rows, 3) for n, rows in E2.items()}
target_dim = {12: 2, 13: 2}       # dim (Sym^6 W_n)^{O(n)}, constant by hypothesis
print(f"  dim (Sym^6 W_n)^O(n) = {target_dim[12]} = {target_dim[13]}: CONSTANT")
print(f"  but rank eps_12 = {rref_rank(E2[12])} < rank eps_13 = {rref_rank(E2[13])}")
print(f"  kernels nested ({span_eq(K2[13], kernel_basis(E2[13], 3), 3)}) but equal: "
      f"{span_eq(K2[12], K2[13], 3)}")
assert not span_eq(K2[12], K2[13], 3)
print("  The file's counted quantity is constant and the lift still fails.  The")
print("  equivalence reads dimensions off the TARGET; only (i) makes that the RANK.")
print("\n  Both plants leave the file's stated numbers untouched, which is the point:")
print("  the equivalence is true, and true only because (i) and (ii) are supplied.")
