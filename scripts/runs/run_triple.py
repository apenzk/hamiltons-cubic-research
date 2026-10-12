import numpy as np
import itertools
from curvature_operator import Lambda2, Q_op
from weyl_decomposition import weyl_from_mop, norm, frob

def block_product_mop(L2, blocks):
    # blocks: list of block sizes summing to n; assign block id to each index
    n = L2.n
    assert sum(blocks) == n
    block_id = np.zeros(n, dtype=int)
    c = 0
    for bi, bs in enumerate(blocks):
        for k in range(bs):
            block_id[c] = bi
            c += 1
    N = L2.N
    Mop = np.zeros((N, N))
    for a, (i, j) in enumerate(L2.pairs):
        if block_id[i] == block_id[j]:
            Mop[a, a] = 1.0
    return Mop

def Pnorm_blocks(n, blocks):
    L2 = Lambda2(n)
    Mop = block_product_mop(L2, blocks)
    Weyl, Ric, S = weyl_from_mop(L2, Mop)
    nv = norm(Weyl)
    Q = Q_op(L2, Weyl)
    Pv = frob(Weyl, Q)
    return Pv / nv**3

if __name__ == "__main__":
    for n in [9, 12, 15]:
        best2 = None
        for p in range(2, n - 1):
            q = n - p
            val = Pnorm_blocks(n, [p, q])
            if best2 is None or val > best2[1]:
                best2 = ([p, q], val)
        best3 = None
        for p in range(2, n - 3):
            for q in range(2, n - p - 1):
                r = n - p - q
                if r < 2:
                    continue
                if p > q or q > r:
                    continue  # canonical order to avoid dup
                val = Pnorm_blocks(n, [p, q, r])
                if best3 is None or val > best3[1]:
                    best3 = ([p, q, r], val)
        print(f"n={n}: best 2-block={best2}  best 3-block={best3}")
