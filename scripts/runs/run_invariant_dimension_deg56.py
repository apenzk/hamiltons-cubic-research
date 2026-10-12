"""
B1: dimensions of the degree-5 and degree-6 O(n)-invariant spaces on W_n.

Degrees 3 and 4 were settled by EXHAUSTIVE enumeration of loop-free complete
contractions of W^{otimes k} modulo S_k x D_4^k (run_cubic_invariant_dimension.py):
dim 2 for n>=6 (1 at n=4,5) and dim 7 for n>=8 (6 at n=6,7).  That route stops
here: degree 5 has 19!! ~ 6.5e8 complete contractions before the loop-free
filter, and degree 6 has 23!! ~ 3.2e11.

Sampling replaces it, and loses nothing.  The loop-free diagrams SPAN the
invariant space, so any random subset of them larger than the dimension spans it
too, with probability 1.  Evaluate K sampled diagrams at M random Weyl tensors,
take the rank of the K x M value matrix, and the rank is the dimension.  The
method is validated below by reproducing the known degree-3 and degree-4 answers,
including their small-n drops, before being used at degrees 5 and 6.

Its nullspace is the space of linear relations among the sampled diagrams, i.e.
exactly the "linear relations" half of B1.
"""
import numpy as np, itertools, sys, time

# ---------------------------------------------------------------- Weyl tensors
def kn(A, B):
    return (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
            - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))

def project_weyl(T, n):
    """Orthogonal projection onto W_n. Identical to the routine in
    run_cubic_invariant_dimension.py, which the degree-3/4 results were computed
    with; an independent rewrite of it here had a wrong scalar-curvature
    coefficient and produced tensors with Ric != 0."""
    T = T - np.transpose(T, (1, 0, 2, 3))
    T = T - np.transpose(T, (0, 1, 3, 2))
    T = T + np.transpose(T, (2, 3, 0, 1))
    A = np.zeros_like(T)                       # kill the Lambda^4 part -> first Bianchi
    for p in itertools.permutations(range(4)):
        seen, par, pl = [0]*4, 0, list(p)
        for i in range(4):
            if seen[i]:
                continue
            j, c = i, 0
            while not seen[j]:
                seen[j] = 1; j = pl[j]; c += 1
            par += c - 1
        A = A + (-1 if par % 2 else 1) * np.transpose(T, p)
    T = T - A / 24.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', T)
    P = (Ric - g * np.trace(Ric) / (2*(n-1))) / (n-2)
    return T - kn(P, g)

def rand_weyl(rng, n):
    W = project_weyl(rng.standard_normal((n,n,n,n)), n)
    return W/np.linalg.norm(W)

# ------------------------------------------------- random loop-free contractions
def sample_matching(nc, rng):
    """A uniform-ish random loop-free perfect matching of the 4*nc slots."""
    while True:
        free, partner, ok = list(range(4*nc)), [-1]*(4*nc), True
        while free:
            a = free[0]
            cands = [b for b in free[1:] if b//4 != a//4]
            if not cands:
                ok = False; break
            b = cands[rng.integers(len(cands))]
            partner[a] = b; partner[b] = a
            free = [x for x in free[1:] if x != b]
        if ok:
            return tuple(partner)

def spec(partner, nc):
    letters, lab, k = 'abcdefghijklmnopqrstuvwx', [None]*(4*nc), 0
    for a in range(4*nc):
        if lab[a] is None:
            lab[a] = letters[k]; lab[partner[a]] = letters[k]; k += 1
    return ','.join(''.join(lab[4*c:4*c+4]) for c in range(nc)) + '->'

def dimension(nc, n, K, M, seed=11):
    rng = np.random.default_rng(seed)
    seen, subs = set(), []
    while len(subs) < K:
        p = sample_matching(nc, rng)
        if p not in seen:
            seen.add(p); subs.append(spec(p, nc))
    Ws = [rand_weyl(rng, n) for _ in range(M)]
    paths = [np.einsum_path(s, *([Ws[0]]*nc), optimize='greedy')[0] for s in subs]
    A = np.empty((K, M))
    for j, W in enumerate(Ws):
        ops = [W]*nc
        for i, s in enumerate(subs):
            A[i, j] = np.einsum(s, *ops, optimize=paths[i])
    sv = np.linalg.svd(A, compute_uv=False)
    r = int((sv > sv[0]*1e-9).sum())
    gap = sv[r]/sv[0] if r < len(sv) else 0.0
    return r, sv[r-1]/sv[0], gap

def rank_curve(nc, n, Ks, M, seed=11):
    """Rank as a function of the number of sampled diagrams, so saturation is
    visible rather than assumed.  This matters: at degree 4, n=8, K=40 returns 6
    and K>=100 returns the true 7 -- forty draws miss a rare orbit among the 23.
    A single K is therefore not evidence; a plateau is."""
    rng = np.random.default_rng(seed)
    seen, subs = set(), []
    while len(subs) < max(Ks):
        p = sample_matching(nc, rng)
        if p not in seen:
            seen.add(p); subs.append(spec(p, nc))
    Ws = [rand_weyl(rng, n) for _ in range(M)]
    paths = [np.einsum_path(s, *([Ws[0]]*nc), optimize='greedy')[0] for s in subs]
    A = np.empty((max(Ks), M)); out, done = [], 0
    for K in Ks:
        for i in range(done, K):
            for j, W in enumerate(Ws):
                A[i, j] = np.einsum(subs[i], *([W]*nc), optimize=paths[i])
        done = K
        sv = np.linalg.svd(A[:K], compute_uv=False)
        out.append(int((sv > sv[0]*1e-9).sum()))
    return out

import time
print("start", time.strftime("%H:%M:%S"), flush=True)
print("\nvalidation of the rank-curve method against the proved degrees")
KV = [40, 100, 200, 400]
print(f"{'deg':>4} {'n':>3}  " + "".join(f"K={k:<6}" for k in KV) + " expected")
for nc, n, exp in [(3,8,2), (4,6,6), (4,8,7), (4,10,7)]:
    rc = rank_curve(nc, n, KV, M=120)
    ok = "ok" if rc[-1] == exp else "MISMATCH"
    print(f"{nc:>4} {n:>3}  " + "".join(f"{r:<8}" for r in rc) + f" {exp}  {ok}", flush=True)

print("\ndegree 5 -- new (a plateau in K is the answer)")
KS5 = [100, 300, 700, 1200, 1800]
print(f"{'deg':>4} {'n':>3}  " + "".join(f"K={k:<6}" for k in KS5))
for n in (6, 7, 8):
    rc = rank_curve(5, n, KS5, M=140)
    print(f"{5:>4} {n:>3}  " + "".join(f"{r:<8}" for r in rc)
          + f"  [{time.strftime('%H:%M:%S')}]", flush=True)
