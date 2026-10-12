"""r239, claim 2 -- an empirical test of the monotonicity that carries the extension.

Fact (ii) of run_a1_canonical_lift.py says ker eps_n is contained in ker eps_{n0} for n >= n0.
That containment holds on ANY subspace of the diagram span, so for a FIXED finite set D of
degree-6 complete-contraction diagrams the rank of eps_n restricted to span(D) must be
NONDECREASING in n.  A dip anywhere would refute (ii) outright, and with it the extension of
89 from the audited n=12 to [12, infinity).

So: fix D once, evaluate every diagram in D on random Weyl tensors at each n, and read the
rank ramp.  Contractions are ordered by a greedy pairwise schedule and diagrams whose largest
intermediate exceeds the budget are rejected when D is built, so the same D is used at every n.

usage: c2_rank_ramp.py NMIN NMAX NDIAG NSAMP
"""
import numpy as np, sys, time

def random_weyl(n, rng):
    R = rng.standard_normal((n, n, n, n))
    R = 0.25 * (R - R.transpose(1, 0, 2, 3) - R.transpose(0, 1, 3, 2) + R.transpose(1, 0, 3, 2))
    R = 0.5 * (R + R.transpose(2, 3, 0, 1))
    R = R - (R + R.transpose(0, 2, 3, 1) + R.transpose(0, 3, 1, 2)) / 3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric)
    E = Ric - s / n * g
    def KN(A, B):
        return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    W = R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)
    W = W / np.sqrt(np.einsum('ijkl,ijkl->', W, W))
    return W

LET = 'abcdefghijklmnopqrstuvwxyz'

def random_matching(rng):
    while True:
        pts = list(range(24))
        rng.shuffle(pts)
        m = [(pts[2 * i], pts[2 * i + 1]) for i in range(12)]
        if all(a // 4 != b // 4 for a, b in m):
            return m

def labels_of(m):
    lab = [None] * 24
    for k, (a, b) in enumerate(m):
        lab[a] = lab[b] = LET[k]
    return [''.join(lab[4 * t: 4 * t + 4]) for t in range(6)]

def greedy_schedule(labs):
    """return (list of (i, j, out_labels), max free-index count over intermediates)"""
    cur = [(i, labs[i]) for i in range(len(labs))]
    steps, worst = [], 4
    while len(cur) > 1:
        best = None
        for i in range(len(cur)):
            for j in range(i + 1, len(cur)):
                a, b = cur[i][1], cur[j][1]
                shared = set(a) & set(b)
                out = ''.join(sorted(set(a) ^ set(b)))
                # an index appearing twice inside a or b alone stays; here labels are distinct
                cost = len(out)
                if best is None or cost < best[0]:
                    best = (cost, i, j, out)
        cost, i, j, out = best
        worst = max(worst, cost)
        steps.append((cur[i][1], cur[j][1], out, i, j))
        rest = [cur[k] for k in range(len(cur)) if k not in (i, j)]
        cur = rest + [(-1, out)]
    return steps, worst

def contract_batch(Wb, labs, steps):
    """Wb has a leading sample axis Z; returns a vector of the contraction, one per sample."""
    arrs = [(l, Wb) for l in labs]
    for a_lab, b_lab, out, i, j in steps:
        A = next(x for x in arrs if x[0] == a_lab)
        B = next(x for x in arrs if x[0] == b_lab)
        R = np.einsum(f"Z{a_lab},Z{b_lab}->Z{out}", A[1], B[1], optimize=False)
        arrs = [x for x in arrs if x[0] not in (a_lab, b_lab)] + [(out, R)]
    assert len(arrs) == 1 and arrs[0][0] == ''
    return arrs[0][1]

if __name__ == "__main__":
    nmin, nmax, ND, NS = (int(x) for x in sys.argv[1:5])
    BUDGET = int(sys.argv[5]) if len(sys.argv) > 5 else 6
    rng = np.random.default_rng(4239)
    D = []
    tries = 0
    while len(D) < ND and tries < 200000:
        tries += 1
        m = random_matching(rng)
        labs = labels_of(m)
        steps, worst = greedy_schedule(labs)
        if worst <= BUDGET:
            D.append((labs, steps))
    print(f"diagram set: {len(D)} diagrams, largest intermediate <= n^{BUDGET} "
          f"({tries} draws)", flush=True)

    for n in range(nmin, nmax + 1):
        t0 = time.time()
        r2 = np.random.default_rng(1000 + n)
        Wall = np.stack([random_weyl(n, r2) for _ in range(NS)])
        A = np.zeros((len(D), NS))
        chunk = max(1, int(4e7 // (n ** BUDGET)))
        for i, (labs, steps) in enumerate(D):
            for lo in range(0, NS, chunk):
                A[i, lo:lo + chunk] = contract_batch(Wall[lo:lo + chunk], labs, steps)
        s = np.linalg.svd(A, compute_uv=False)
        tol = s[0] * max(A.shape) * 1e-11
        rk = int((s > tol).sum())
        gap = (s[rk - 1] / s[rk]) if 0 < rk < len(s) else float('inf')
        print(f"  n={n:2d}: rank {rk:4d}   gap {gap:.2e}   ({time.time()-t0:.0f}s)", flush=True)
