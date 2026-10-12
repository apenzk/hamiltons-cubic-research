# King's modification rule for O(N), screened against ground truth.
#
# The earlier implementation used the condition 2*len(lam) <= N.  King's rule is
# stated on COLUMN lengths: lam is standard for O(N) iff lam'_1 + lam'_2 <= N,
# and the hook to remove has length lam'_1 + lam'_2 - N.  Several sign
# conventions appear in the literature, so all are screened against the one
# sequence this project knows independently: dim (Sym^d Weyl_5)^{O(5)} =
# 1, 1, 4, 5, 14 for d = 2..6, from Weyl integration in
# run_n5_constraint_count.py, which shares no machinery with this.
import sys
Sym = SymmetricFunctions(QQ)
s, h, o = Sym.s(), Sym.h(), Sym.o()
W = s[2, 2] - s[2]

def rim(lam, k):
    """remove the rim hook of length k starting at (1, lam_1); (mu, rows) or None."""
    lam = list(lam)
    cells, r, c = [], 0, lam[0] - 1
    while len(cells) < k:
        if r >= len(lam) or c < 0 or c >= lam[r]: return None
        cells.append((r, c))
        if r + 1 < len(lam) and lam[r + 1] > c: r += 1
        else: c -= 1
    new = list(lam)
    for (rr, cc) in cells: new[rr] -= 1
    if any(new[i] < new[i+1] for i in range(len(new)-1)) or any(x < 0 for x in new):
        return None
    return [x for x in new if x > 0], len({rr for rr, _ in cells})

def modify(lam, N, variant):
    lam, sign = list(lam), 1
    for _ in range(60):
        conj = Partition(lam).conjugate() if lam else Partition([])
        c1 = conj[0] if len(conj) > 0 else 0
        c2 = conj[1] if len(conj) > 1 else 0
        if c1 + c2 <= N: return sign, Partition(lam)
        k = c1 + c2 - N
        got = rim(lam, k)
        if got is None: return 0, None
        mu, rows = got
        if variant == 'a': sign *= (-1) ** (rows - 1)
        elif variant == 'b': sign *= -((-1) ** (rows - 1))
        elif variant == 'c': sign *= (-1) ** (k - rows)
        elif variant == 'd': sign *= -((-1) ** (k - rows))
        lam = mu
    return 0, None

TRUTH5 = {2: 1, 3: 1, 4: 4, 5: 5, 6: 14}
DEC = {}
for d in (2, 3, 4, 5, 6):
    DEC[d] = o(h[d].plethysm(W)).monomial_coefficients()
    print(f"degree {d}: {len(DEC[d])} stable constituents", flush=True)

for v in ('a', 'b', 'c', 'd'):
    got = []
    for d in (2, 3, 4, 5, 6):
        tot = 0
        for lam, m in DEC[d].items():
            sg, mu = modify(Partition(lam), 5, v)
            if sg and len(mu) == 0: tot += sg * m
        got.append(tot)
    ok = got == [TRUTH5[d] for d in (2, 3, 4, 5, 6)]
    print(f"variant {v}: {got}   truth [1, 1, 4, 5, 14]   MATCH: {ok}", flush=True)
    if ok:
        n12 = []
        for d in (2, 3, 4, 5, 6):
            tot = 0
            for lam, m in DEC[d].items():
                sg, mu = modify(Partition(lam), 12, v)
                if sg and len(mu) == 0: tot += sg * m
            n12.append(tot)
        print(f"  ==> O(12) invariant dimensions, degrees 2..6: {n12}", flush=True)
