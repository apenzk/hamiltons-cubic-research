"""Screen for I106b: the singular locus of phi_r strictly contains the split locus at n = 4.

The DERIVATION this screens, which needs no code.  The tangent to O(n) at Q is Q @ Omega for
skew Omega, so d phi_r (Q Omega) = 2 * Q .* (Q Omega), whose diagonal entries are
2 * Q[i,i] * (Q Omega)[i,i].  At a Q with ZERO DIAGONAL every one of those vanishes, so the
image of the differential lies in the zero-diagonal subspace on top of the zero row and column
sums that every bistochastic tangent already satisfies.

**That is a strict rank drop ONLY AT k = 3 AND k = 4**, and this docstring first claimed it at every n,
which Gate 2 refuted (r974 and r975).  The drop needs (k-1)^2 - k < choose(k,2), which is
(k^2 - 5k + 2)/2 < 0 and so holds at k = 3, 4 and at no larger k: 1 < 3, 5 < 6, then 11 > 10, 19 > 15.
The BOUND is exact rather than lossy, the k diagonal functionals being independent of the row and
column sums and of each other at every k >= 3, so it is the mechanism that runs out, not the estimate.
And beyond k = 4 the conclusion is FALSE rather than unproved: a SYMMETRIC zero-diagonal Q in O(k)
with all off-diagonal entries nonzero is REGULAR, since Q*Omega diagonal forces Omega = Q D and
skewness gives d_i = -d_j for all i != j, hence d = 0.  Realised at k = 6 by the normalised Paley
conference matrix and at k = 5 by an exact circulant.

And the second type cannot appear before n = 4: for rows (0,a,b), (c,0,d), (e,f,0) in O(3) the
first two rows pair to b*d = 0, so a zero diagonal with every other entry nonzero is impossible
at n = 3.  That is consistent with Bengtsson et al. Theorem 2.4, which says singular = splits
there, and it explains why Theorem 2.6's second type appears first at n = 4.

What the code adds is the RANK, which the derivation bounds but does not pin, since the n
zero-diagonal conditions could in principle be dependent on the zero-sum ones.

Gate 1: (a) the generic control reproduces the full rank dim O(4) = 6 on the same code path,
(b) the witness's orthogonality and its image (J - I)/3 are checked in closed form, (c) the
object's validity is screened rather than assumed, (d) the rank is compared against the ceiling
dim O(4) = 6 and the derived bound.
"""

import numpy as np

n = 4
SQ3 = np.sqrt(3.0)

# The witness, verified orthogonal by hand: zero diagonal, every other entry nonzero.
Q = np.array([
    [0.0,  1.0,  1.0,  1.0],
    [1.0,  0.0, -1.0,  1.0],
    [1.0,  1.0,  0.0, -1.0],
    [1.0, -1.0,  1.0,  0.0],
]) / SQ3


def skew_basis(m):
    """An orthonormal basis of the skew-symmetric m x m matrices, dimension m(m-1)/2."""
    out = []
    for i in range(m):
        for j in range(i + 1, m):
            E = np.zeros((m, m))
            E[i, j] = 1.0
            E[j, i] = -1.0
            out.append(E / np.sqrt(2.0))
    return out


def dphi_rank(Qm):
    """Rank of d phi_r at Qm, phi_r(Q) = Q .* Q, on the tangent space Q @ skew."""
    rows = [(2.0 * Qm * (Qm @ Om)).ravel() for Om in skew_basis(Qm.shape[0])]
    return np.linalg.matrix_rank(np.array(rows), tol=1e-9), np.array(rows)


def splits(B, tol=1e-12):
    """A bistochastic B splits iff some proper nonempty row set maps onto a column set of equal
    size, i.e. the bipartite support graph is disconnected.  Checked by connectivity."""
    m = B.shape[0]
    seen, stack = {0}, [0]
    while stack:                      # rows reachable through nonzero entries
        r = stack.pop()
        for c in range(m):
            if abs(B[r, c]) > tol:
                for r2 in range(m):
                    if abs(B[r2, c]) > tol and r2 not in seen:
                        seen.add(r2)
                        stack.append(r2)
    return len(seen) < m


print("=" * 78)
print("I106b: the singular locus strictly contains the split locus at n = 4")
print("=" * 78)

# (c) screen the object's validity rather than assume it
orth = np.abs(Q @ Q.T - np.eye(n)).max()
diag = np.abs(np.diag(Q)).max()
offd = min(abs(Q[i, j]) for i in range(n) for j in range(n) if i != j)
print(f"\nwitness Q, orthogonality residual   {orth:.3e}   (0 expected)")
print(f"witness Q, max |diagonal entry|      {diag:.3e}   (0 expected)")
print(f"witness Q, min |off-diagonal entry|  {offd:.6f}   (nonzero expected)")

B = Q * Q
target = (np.ones((n, n)) - np.eye(n)) / 3.0
print(f"\nQ.*Q equals (J - I)/3 to            {np.abs(B - target).max():.3e}")
print(f"row sums {np.round(B.sum(axis=1), 12)}, column sums {np.round(B.sum(axis=0), 12)}")
print(f"does the image split?                {splits(B)}   (False expected)")

r_wit, rows_wit = dphi_rank(Q)
print(f"\nrank d phi_r at the witness          {r_wit}")
print(f"max |diagonal of d phi_r image|      "
      f"{max(abs(row.reshape(n, n)[i, i]) for row in rows_wit for i in range(n)):.3e}")

# (a) the generic control, same code path
rng = np.random.default_rng(0)
ranks = []
for _ in range(200):
    G, _ = np.linalg.qr(rng.standard_normal((n, n)))
    ranks.append(dphi_rank(G)[0])
print(f"rank d phi_r at 200 generic Q         min {min(ranks)}, max {max(ranks)}")
print(f"ceiling, dim O(4)                     {n * (n - 1) // 2}")

bound = (n - 1) ** 2 - n
print(f"derived bound (n-1)^2 - n             {bound}")

print("\n" + "=" * 78)
ok = (orth < 1e-12 and diag < 1e-12 and offd > 1e-6
      and not splits(B) and r_wit < n * (n - 1) // 2 and min(ranks) == n * (n - 1) // 2)
print("SCREEN PASSES" if ok else "SCREEN FAILS")
print("The witness is orthogonal, does NOT split, and is singular, while the generic point is")
print("regular.  So at n = 4 'singular implies splits' is FALSE, and R28's induction step needs")
print("the second type handled rather than assumed away.")
print("=" * 78)
