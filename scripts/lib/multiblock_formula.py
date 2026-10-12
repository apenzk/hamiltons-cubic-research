from math import comb
import itertools

def multiblock_P(n, blocks):
    m = len(blocks)
    assert sum(blocks) == n
    S = sum(b * (b - 1) for b in blocks)
    denom1 = n - 2
    denom2 = (n - 1) * (n - 2)
    sigma = S / denom2

    def w_same(a):
        return 1 - 2 * (a - 1) / denom1 + sigma

    def w_diff(a, b):
        return -((a - 1) + (b - 1)) / denom1 + sigma

    wsame = [w_same(b) for b in blocks]
    wdiff = {}
    for i in range(m):
        for j in range(i + 1, m):
            wdiff[(i, j)] = w_diff(blocks[i], blocks[j])

    def wd(i, j):
        if i == j:
            return wsame[i]
        return wdiff[(min(i, j), max(i, j))]

    # sum of cubes over all pairs (i<j) of vertices, grouped by block-pair type
    sum_cubes = 0.0
    for i in range(m):
        sum_cubes += comb(blocks[i], 2) * wsame[i] ** 3
    for i in range(m):
        for j in range(i + 1, m):
            sum_cubes += blocks[i] * blocks[j] * wdiff[(i, j)] ** 3

    normsq = 0.0
    for i in range(m):
        normsq += comb(blocks[i], 2) * wsame[i] ** 2
    for i in range(m):
        for j in range(i + 1, m):
            normsq += blocks[i] * blocks[j] * wdiff[(i, j)] ** 2

    # triangle sum over all unordered triples of vertices, grouped by which blocks they fall in
    tri = 0.0
    # case: all 3 vertices in same block a
    for a in range(m):
        tri += comb(blocks[a], 3) * wsame[a] ** 3
    # case: 2 vertices in block a, 1 in block b (a!=b)
    for a in range(m):
        for b in range(m):
            if a == b:
                continue
            tri += comb(blocks[a], 2) * blocks[b] * wsame[a] * wd(a, b) ** 2
    # case: vertices in 3 distinct blocks a<b<c
    for a, b, c in itertools.combinations(range(m), 3):
        tri += blocks[a] * blocks[b] * blocks[c] * wd(a, b) * wd(a, c) * wd(b, c)

    P_raw = sum_cubes + 3 * tri
    return P_raw / normsq ** 1.5


if __name__ == "__main__":
    # sanity vs 2-block hand formula
    from run_sphere import hand_formula_P
    for n, p in [(8, 4), (9, 4), (12, 6), (15, 7)]:
        q = n - p
        hp, _, _, _ = hand_formula_P(n, p)
        mp = multiblock_P(n, [p, q])
        print(f"n={n} p={p},q={q}: 2block-hand={hp:.6f} multiblock={mp:.6f} diff={abs(hp-mp):.2e}")
