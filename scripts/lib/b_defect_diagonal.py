"""The symmetry defect on the DIAGONAL locus, in closed form -- and what Delta = 0 means there.

DERIVED, not fitted.  A diagonal Weyl operator is the multiplication operator
W phi_ab = M_ab phi_ab on coordinate 2-planes, with M symmetric, hollow, zero row
sums (Ricci-flatness) and sum_{a<b} M_ab^2 = 1.  In that eigenbasis the structure
tensor of Petersen-Wink Prop 1.7 is a single monomial: with phi_ab = E_ab - E_ba,

    [phi_ab, phi_bd] = phi_ad     (a, b, d distinct),

so T_{(ab),(bd),(ad)} = (1/2 <phi_ad, phi_ad>)^2 = 1 and every other entry vanishes.
Hence g_delta = sum_{alpha beta} (lam_a - lam_b)^2 T_{delta alpha beta} collapses to

    g_ab = 2 sum_{d != a,b} (M_ad - M_bd)^2                                     (1)

-- twice the squared distance between rows a and b of M, off the pair itself --
and, tracing over the STRICTLY positive eigenspace p = {ab : M_ab > 0},

    Delta(M) = 2 sum_{a<b, M_ab > 0} sum_{d != a,b} (M_ad - M_bd)^2 .           (2)

THE CASIMIR TOTAL FALLS OUT OF (1) ANALYTICALLY, which is check (d) of Gate 1:
summing over ALL pairs, the two square terms give 2 x (n-2) x ||M||_F^2 = 4(n-2)
and the cross term is -2 sum_{a != b} (M^2)_{ab} = -2 (1^T M^2 1 - tr M^2) = +4,
since M1 = 0.  Total 4(n-1), the recorded Casimir value, with no constant fitted.

THAT TOTAL IS A RICCI-FLATNESS SCREEN, and it is the control this file runs.  The
cross term is the only place M1 = 0 enters, so sum_pairs g = 4(n-1) EXACTLY on
Ricci-flat diagonal points and misses otherwise -- which is how the run below
catches three rows built from block data that is not Ricci-flat at all: the
three-block sphere product of the two-block formula, and the C_5 blow-up entries
4 : -2 : +1 carried to blocks of 3 or with the non-adjacent value moved to 0.
(1) and (2) themselves use no Ricci-flatness, so Delta still agrees there.

WHAT Delta = 0 SAYS HERE.  Call a, b LINKED when M_ab > 0.  By (2), Delta = 0 iff
every linked pair has M_ad = M_bd for all d outside the pair -- a and b are TWINS.
Linkage is then transitive: a-b and b-c linked give M_ac = M_bc > 0, so a-c is
linked too.  So the components of the positive graph G+ are cliques of mutually
twin vertices, M is CONSTANT on each block and on each pair of blocks, within-block
entries are > 0 and every between-block entry is <= 0:

    Delta(M) = 0  <=>  M is block-constant on the components of G+, with all
                       off-block entries <= 0.                                  (3)

So on the diagonal locus the defect measures exactly the positive weight sitting
between NON-twin vertices.  The C_5 blow-up is block-constant and still has
Delta > 0, because its non-adjacent block pairs carry +1: block-constancy alone is
not the condition, the SIGN of the off-block entries is half of it.

Delta = 12 AT THE C_5 BLOW-UP, BY HAND, from (2).  Blocks of 2 in a 5-cycle with
entries 4 : -2 : +1 and sum_{a<b} M_ab^2 = 180 t^2 = 1.  Within-block pairs are
twins and contribute 0.  Each of the 20 non-adjacent-block vertex pairs contributes
9 + 9 + 2x9 + 2x9 = 54 t^2, from the two block partners and the two blocks adjacent
to exactly one of them.  Delta = 2 x 20 x 54 / 180 = 12, the recorded value.

WHAT THIS IS FOR.  The live target's remaining half is {critical, S = 0, Delta > 0}.
On the diagonal locus S = 0 is triangle-freeness of the negative graph and, by (3),
Delta > 0 is a positive entry between non-twins -- so both hypotheses of the target
are combinatorial conditions on one weighted graph, and the falsifier hunt for that
half is a search over weights rather than over tensors.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, sphere_product_W
from b_symmetry_defect import defect
from b_c5_blowup import c5_operator

TOL = 1e-9


def M_of(n, W):
    """The curvature matrix of a diagonal W: M_ab = W_(ab),(ab)."""
    pairs, _ = pair_index(n)
    M = np.zeros((n, n))
    for a, (i, j) in enumerate(pairs):
        M[i, j] = M[j, i] = W[a, a]
    return M


def W_of(M):
    """The diagonal Weyl operator of a curvature matrix M."""
    n = M.shape[0]
    pairs, _ = pair_index(n)
    return np.diag([M[i, j] for (i, j) in pairs])


def g_closed(M):
    """(1): g_ab = 2 sum_{d != a,b} (M_ad - M_bd)^2, as an n x n hollow matrix."""
    n = M.shape[0]
    D = ((M[:, None, :] - M[None, :, :]) ** 2).sum(axis=2)          # sum over ALL d
    for a in range(n):                                              # drop d = a, b
        for b in range(n):
            if a != b:
                D[a, b] -= (M[a, a] - M[b, a]) ** 2 + (M[a, b] - M[b, b]) ** 2
    np.fill_diagonal(D, 0.0)
    return 2.0 * D


def delta_closed(M, tol=TOL):
    """(2): the defect of a diagonal point, from M alone."""
    g = g_closed(M)
    return float(g[(M > tol)].sum() / 2.0)          # each pair counted twice


def total_closed(M):
    return float(g_closed(M).sum() / 2.0)


def blocks_of_positive_graph(M, tol=TOL):
    """Connected components of G+ = {ab : M_ab > 0}, as a label vector."""
    n = M.shape[0]
    lab = list(range(n))
    for _ in range(n):
        for a in range(n):
            for b in range(n):
                if a != b and M[a, b] > tol and lab[a] != lab[b]:
                    lo, hi = sorted((lab[a], lab[b]))
                    lab = [lo if x == hi else x for x in lab]
    return lab


def is_block_constant_nonpositive_off(M, tol=1e-7):
    """(3)'s right-hand side, checked directly."""
    lab = blocks_of_positive_graph(M)
    n = M.shape[0]
    for a in range(n):
        for b in range(n):
            if a == b:
                continue
            if lab[a] != lab[b] and M[a, b] > tol:
                return False, lab
            for c in range(n):
                for d in range(n):
                    if c == d or lab[c] != lab[a] or lab[d] != lab[b]:
                        continue
                    if (c == d) or (a == b):
                        continue
                    if lab[a] == lab[b] and (a == b or c == d):
                        continue
                    if abs(M[a, b] - M[c, d]) > tol:
                        return False, lab
    return True, lab


def random_diagonal_weyl(n, rng):
    """A random hollow symmetric M with zero row sums, unit norm -- the random control."""
    A = rng.normal(size=(n, n)); A = A + A.T; np.fill_diagonal(A, 0.0)
    r = A.sum(axis=1); V = r.sum() / (2 * n - 2)
    v = (r - V) / (n - 2)
    M = A - v[:, None] - v[None, :]
    np.fill_diagonal(M, 0.0)
    M = M / np.sqrt((M ** 2).sum() / 2.0)
    return M


def main():
    rng = np.random.default_rng(11)
    cases = []
    for blocks in ([6, 6], [5, 7], [4, 8], [3, 3], [3, 3, 3]):
        W, _ = sphere_product_W(blocks)
        cases.append((f"S^{' x S^'.join(map(str, blocks))}", sum(blocks), W))
    for sizes in ([2] * 5, [3] * 5):
        W, n = c5_operator(sizes)
        cases.append((f"C_5 blow-up {sizes}", n, W))
    W, n = c5_operator([2] * 5, nonadj=0.0)
    cases.append(("C_5, non-adj set to 0", n, W))
    for n in (6, 8, 10):
        for t in range(2):
            M = random_diagonal_weyl(n, rng)
            cases.append((f"random diagonal n={n} #{t}", n, W_of(M)))

    print("=== (1)/(2) against the general machinery: Delta on the diagonal locus ===")
    print(f"  {'point':26s}{'n':>3s}{'theta':>10s}{'Delta gen':>11s}{'Delta (2)':>11s}"
          f"{'tot gen':>9s}{'4(n-1)':>8s}{'Ric':>5s}{'blk+':>6s}")
    worst = worst_rf = 0.0
    for lbl, n, W in cases:
        W = W / np.linalg.norm(W)
        M = M_of(n, W)
        th, ok, d, D, tot, Smmm, Smpp, z = defect(n, W)
        Dc, tc = delta_closed(M), total_closed(M)
        bc, lab = is_block_constant_nonpositive_off(M)
        rf = float(np.abs(M.sum(axis=1)).max())
        worst = max(worst, abs(D - Dc), abs(tot - tc))
        if rf < 1e-10:
            worst_rf = max(worst_rf, abs(tot - 4 * (n - 1)))
        print(f"  {lbl:26s}{n:>3d}{th:>10.6f}{D:>11.6f}{Dc:>11.6f}"
              f"{tot:>9.4f}{4*(n-1):>8d}{('yes' if rf < 1e-10 else 'NO'):>5s}"
              f"{('YES' if bc else 'no'):>6s}")
    print(f"  worst |general - closed form|, Delta and total, over ALL rows: {worst:.2e}")
    print(f"  worst |total - 4(n-1)| over the RICCI-FLAT rows:              {worst_rf:.2e}")
    print("  the rows marked Ric=NO are not Weyl operators; (1)/(2) hold there anyway,")
    print("  and the Casimir total is exactly what detects them.")

    print("\n=== the equivalence (3), on the same rows ===")
    for lbl, n, W in cases:
        M = M_of(n, W / np.linalg.norm(W))
        Dc = delta_closed(M)
        bc, lab = is_block_constant_nonpositive_off(M)
        agree = (Dc < 1e-8) == bc
        print(f"  {lbl:26s} Delta={Dc:9.5f}  block-const & off<=0: {str(bc):5s}"
              f"  -> {'agrees' if agree else 'MISMATCH'}   blocks={len(set(lab))}")

    print("\n=== the control that the test can fail: the constant 2 in (1) is pinned ===")
    M = M_of(10, c5_operator([2] * 5)[0] / np.linalg.norm(c5_operator([2] * 5)[0]))
    print(f"  C_5 blow-up, Delta with the leading 2 replaced by 1: "
          f"{delta_closed(M) / 2:.6f}  (recorded value is 12)")
    print(f"  and the total then reads {total_closed(M) / 2:.1f} against 4(n-1) = 36")


if __name__ == '__main__':
    main()
