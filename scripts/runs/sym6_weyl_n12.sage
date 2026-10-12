# The degree-6 O(12)-invariant count of Weyl_12, which plan.md owes.
#
# The stable plethysm h_6[s_22 - s_2] in the orthogonal basis gives the
# O(infinity) decomposition.  n = 12 is OUTSIDE the stable range at degree 6
# (which needs n >= 4k = 24), so the finite-n count follows by applying King's
# modification rule to each stable constituent and counting what folds to the
# empty partition.
import sys
Sym = SymmetricFunctions(QQ)
s, h, o = Sym.s(), Sym.h(), Sym.o()
W = s[2, 2] - s[2]

def report(k, N):
    P = o(h[k].plethysm(W))
    d = P.monomial_coefficients()
    print(f"degree {k}: {len(d)} stable constituents, "
          f"multiplicities summing to {sum(d.values())}", flush=True)
    triv = d.get(Partition([]), 0)
    print(f"  stable trivial multiplicity: {triv}", flush=True)
    # King's modification at O(N): a partition with more than N/2 rows either
    # folds to another label with a sign, or dies.  Count what reaches [].
    folded = 0
    for lam, m in d.items():
        lam = Partition(lam)
        if len(lam) <= N // 2:
            if len(lam) == 0: folded += m
            continue
        sign, mu = king_modify(lam, N)
        if sign and len(mu) == 0: folded += sign * m
    print(f"  at O({N}) the trivial multiplicity is {folded}", flush=True)
    return d

def king_modify(lam, N):
    """King's modification rule for O(N).

    A partition with more than N/2 rows is non-standard.  Remove a continuous
    boundary strip of length h = 2*len(lam) - N whose first cell is (1, lam_1);
    if what remains is a partition mu, then [lam]_N = (-1)^(r-1) [mu]_N with r
    the number of ROWS the strip spans.  Otherwise [lam]_N = 0.  Iterate.

    The sign is the whole content of the rule -- omitting it makes almost every
    partition fold onto the trivial and inflates the count.
    """
    lam, sign = list(lam), 1
    while len(lam) > N // 2:
        h = 2 * len(lam) - N
        mu, rows = _remove_rim(lam, h)
        if mu is None: return 0, None
        sign *= (-1) ** (rows - 1)
        lam = mu
    return sign, Partition(lam)

def _remove_rim(lam, h):
    """remove the boundary strip of length h starting at (1, lam_1).

    Returns (mu, rows) or (None, 0).  The walk goes down when the row below
    extends past the current column and left otherwise, which traces the rim.
    """
    lam = list(lam)
    cells, r, c = [], 0, lam[0] - 1
    while len(cells) < h:
        if r >= len(lam) or c < 0 or c >= lam[r]: return None, 0
        cells.append((r, c))
        if r + 1 < len(lam) and lam[r + 1] > c: r += 1
        else: c -= 1
    new = list(lam)
    for (rr, cc) in cells: new[rr] -= 1
    if any(new[i] < new[i + 1] for i in range(len(new) - 1)): return None, 0
    if any(x < 0 for x in new): return None, 0
    return [x for x in new if x > 0], len({rr for rr, _ in cells})

# N = 5 is ground truth: Weyl integration in run_n5_constraint_count.py gives
# 1, 1, 4, 5, 14 for degrees 2..6 by a method sharing nothing with this one.
# The modification rule is trusted at N = 12 only if it reproduces those.
TRUTH5 = {2: 1, 3: 1, 4: 4, 5: 5, 6: 14}
for k in (2, 3, 4, 5, 6):
    P = o(h[k].plethysm(W))
    d = P.monomial_coefficients()
    print(f"\ndegree {k}: {len(d)} stable constituents, "
          f"mults summing to {sum(d.values())}, stable trivial "
          f"{d.get(Partition([]), 0)}", flush=True)
    for N in (5, 12):
        tot = 0
        for lam, m in d.items():
            lam = Partition(lam)
            if len(lam) <= N // 2:
                if len(lam) == 0: tot += m
                continue
            sign, mu = king_modify(lam, N)
            if sign and len(mu) == 0: tot += sign * m
        tag = ""
        if N == 5:
            tag = f"   ground truth {TRUTH5[k]}  MATCH: {tot == TRUTH5[k]}"
        print(f"  O({N}) trivial multiplicity = {tot}{tag}", flush=True)
