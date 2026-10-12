"""The n=5 certificate: solve 36 unknowns against 14 constraints, exactly.

The deliverable is a PROOF, so a floating-point feasible point is only a search
step.  The route is: solve the affine system over Q to get the 22-dimensional
family of candidate Grams, find an interior point numerically, round it to
rationals, and then VERIFY exactly -- both the 14 equalities and the positive
semidefiniteness of every block, by rational LDL^T with no square roots.

A rounded point that verifies is a certificate; a rounded point that fails to
verify sends the search back rather than being reported.
"""
from fractions import Fraction as F

def ldl_psd(M):
    """exact PSD test for a rational symmetric matrix, by LDL^T with symmetric
    pivoting.  Returns (is_psd, diagonal).  No square roots, so it stays in Q."""
    n = len(M)
    A = [[F(M[i][j]) for j in range(n)] for i in range(n)]
    D, perm = [], list(range(n))
    for k in range(n):
        p = max(range(k, n), key=lambda i: A[i][i])
        if A[p][p] < 0: return False, D
        if A[p][p] == 0:
            # The max remaining diagonal is 0, so every remaining diagonal is
            # <= 0.  A PSD matrix has non-negative diagonal, and if its diagonal
            # vanishes on a block then that whole block vanishes.  Checking only
            # the pivot ROW and then `continue`-ing without swapping left the
            # index in place and never examined the rest: [[-1,0],[0,0]] came
            # back PSD.  (Reviewer 182, with 255 of 20000 random misclassified.)
            if any(A[i][i] < 0 for i in range(k, n)): return False, D
            if any(A[i][j] for i in range(k, n) for j in range(k, n)):
                return False, D
            D.extend([F(0)]*(n-k)); return True, D
        A[k], A[p] = A[p], A[k]
        for r in range(n): A[r][k], A[r][p] = A[r][p], A[r][k]
        perm[k], perm[p] = perm[p], perm[k]
        d = A[k][k]; D.append(d)
        for i in range(k+1, n):
            f = A[i][k]/d
            for j in range(k+1, n): A[i][j] -= f*A[k][j]
            A[i][k] = F(0)
    return all(x >= 0 for x in D), D

# --- self-test on matrices whose status is known by inspection ---
if __name__ == "__main__":
    tests = [([[2,1],[1,2]], True,  "positive definite"),
             ([[1,1],[1,1]], True,  "positive semidefinite, rank 1"),
             ([[1,2],[2,1]], False, "indefinite, det < 0"),
             ([[0,1],[1,0]], False, "indefinite with a zero pivot"),
             ([[0,0],[0,3]], True,  "psd with a genuine zero row"),
             ([[1,0,0],[0,0,1],[0,1,0]], False, "indefinite in a lower block"),
             ([[-1,0],[0,0]], False, "reviewer 182's witness: negative behind a zero pivot"),
             ([[0,0],[0,-1]], False, "the same, with the order swapped"),
             ([[0,0],[0,0]], True,  "the zero form"),
             ([[2,0,0],[0,0,0],[0,0,-3]], False, "negative hidden two places down")]
    for M, want, why in tests:
        got, _ = ldl_psd(M)
        print(f"  {'OK ' if got == want else '!! '}{str(M):28s} psd={got:5}  ({why})")
    print("\nexact PSD test ready; the affine solve consumes the dictionary stage.")


# ---------- stage 3: the affine solve, exact over Q ----------
def rref(A, b):
    """exact reduced row echelon on [A|b]; returns (pivots, free, A, b)."""
    m, n = len(A), len(A[0])
    A = [[F(x) for x in row] for row in A]; b = [F(x) for x in b]
    piv, r = [], 0
    for c in range(n):
        p = next((k for k in range(r, m) if A[k][c]), None)
        if p is None: continue
        A[r], A[p] = A[p], A[r]; b[r], b[p] = b[p], b[r]
        inv = F(1)/A[r][c]
        A[r] = [x*inv for x in A[r]]; b[r] *= inv
        for k in range(m):
            if k != r and A[k][c]:
                f = A[k][c]
                A[k] = [x - f*y for x, y in zip(A[k], A[r])]; b[k] -= f*b[r]
        piv.append(c); r += 1
        if r == m: break
    return piv, [c for c in range(n) if c not in piv], A, b

def affine_family(D, target):
    """solutions of D x = target: a particular x0 and a basis of the nullspace.

    D is the dictionary -- 14 rows (invariant sextics) by 36 columns (Gram
    unknowns) -- and target is F_5 in the same sextic basis.  Inconsistency here
    would mean F_5 is not in the image at all, which refutes the ansatz rather
    than the arithmetic.
    """
    piv, free, A, b = rref(D, target)
    m, n = len(D), len(D[0])
    for k in range(len(piv), m):
        if b[k] and not any(A[k]):
            return None, None            # inconsistent: F_5 outside the image
    x0 = [F(0)]*n
    for i, c in enumerate(piv): x0[c] = b[i]
    ns = []
    for f in free:
        v = [F(0)]*n; v[f] = F(1)
        for i, c in enumerate(piv): v[c] = -A[i][f]
        ns.append(v)
    return x0, ns

if __name__ == "__main__":
    print("\n--- stage 3 self-test: a system whose solution set is known ---")
    # x1 + x2 = 1, x3 = 2 in three unknowns: a 1-dimensional family
    D = [[1, 1, 0], [0, 0, 1]]; t = [1, 2]
    x0, ns = affine_family(D, t)
    print(f"  particular {x0}   nullspace dim {len(ns)} (expect 1)")
    ok = all(sum(D[i][j]*x0[j] for j in range(3)) == t[i] for i in range(2))
    okn = all(sum(D[i][j]*v[j] for j in range(3)) == 0 for v in ns for i in range(2))
    print(f"  particular satisfies the system: {ok}; nullspace is in the kernel: {okn}")
    # an inconsistent system must be reported as such, not solved
    bad, _ = affine_family([[1, 1], [2, 2]], [1, 3])
    print(f"  inconsistent system detected: {bad is None}")
