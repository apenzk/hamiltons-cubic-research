"""r264 / claim 3: the seed lemma tested at NON-TRIVIAL lambda.

run_seed_is_a_diagram.py only ever uses lambda = () and lambda = (1,).  Here the
seed is built for a genuine label: v = c_lambda(e_0 (x) e_1 (x) ... (x) e_{m-1}),
the Young symmetriser applied to a tensor with ALL INDICES DISTINCT (hence
automatically traceless, so the vector lies in the O(n) irreducible V_lambda and
not merely in the GL Weyl module), padded with k cups to f = m + 2k legs.

The prediction under test is the lemma + realisation theorem together:
    dim span{ nu(D) (v (x) cup^{(x)k}) : D a Brauer diagram }  ==  m_lambda(n)
with m_lambda(n) the restricted up-down tableau count, which knows nothing about
seeds.  k = 0 rows test the machinery itself (no padding at all).
"""
import sys, itertools, numpy as np

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

LET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

def apply_diagram(D, f, n, T):
    """nu(D) applied to T (shape (n,)*f).  Points 0..f-1 out, f..2f-1 in."""
    lab = [LET[p] for p in range(2 * f)]
    vin = "".join(lab[f + p] for p in range(f))
    vout = "".join(lab[p] for p in range(f))
    ops, subs = [T], [vin]
    for (a, b) in D:
        ops.append(np.eye(n)); subs.append(lab[a] + lab[b])
    return np.einsum(",".join(subs) + "->" + vout, *ops, optimize=True)

def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()

def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n

def restricted_updown(f, n):
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n):
                        nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur

def young_vector(lam, n):
    """c_lambda applied to e_0 (x) ... (x) e_{m-1}; a nonzero traceless vector of V_lambda."""
    m = sum(lam)
    rows, c = [], 0
    for r in lam:
        rows.append(list(range(c, c + r))); c += r
    cols = [[rows[i][j] for i in range(len(lam)) if lam[i] > j] for j in range(lam[0])]
    def group(blocks):
        for combo in itertools.product(*[list(itertools.permutations(b)) for b in blocks]):
            g = list(range(m)); sgn = 1
            for b, pb in zip(blocks, combo):
                for src, dst in zip(b, pb):
                    g[src] = dst
                # parity of this block permutation
            for b, pb in zip(blocks, combo):
                seen, perm = {}, list(pb)
                for i, x in enumerate(b): seen[x] = i
                idx = [seen[x] for x in perm]
                vis = [False]*len(idx)
                for i in range(len(idx)):
                    if not vis[i]:
                        j, L = i, 0
                        while not vis[j]:
                            vis[j] = True; j = idx[j]; L += 1
                        if L % 2 == 0: sgn = -sgn
            yield tuple(g), sgn
    T = np.zeros((n,) * m)
    base = tuple(range(m))
    # c_lambda = sum_{q in C} sgn(q) sum_{p in R} p q  acting on positions
    for q, sq in group(cols):
        for p, _ in group(rows):
            # position i of the result gets index base[ sigma^{-1}(i) ]; build directly
            sigma = [p[q[i]] for i in range(m)]
            idx = [0]*m
            for i in range(m):
                idx[sigma[i]] = base[i]
            T[tuple(idx)] += sq
    return T

def run(lam, f, n):
    m = sum(lam)
    k = (f - m) // 2
    if not admissible(lam, n):
        return None
    if m > n:
        return ("SKIP m>n", 0, 0)
    T = young_vector(lam, n)
    if np.abs(T).max() == 0:
        return ("ZERO", 0, 0)
    # tracelessness check: every pairwise contraction vanishes
    for a in range(m):
        for b in range(a+1, m):
            if np.abs(np.trace(T, axis1=a, axis2=b)).max() > 1e-9:
                return ("NOT TRACELESS", 0, 0)
    v = T.reshape(-1)
    cupv = np.eye(n).reshape(-1)
    for _ in range(k):
        v = np.kron(v, cupv)
    V = v.reshape((n,) * f)
    rows = [apply_diagram(D, f, n, V).reshape(-1) for D in matchings(tuple(range(2*f)))]
    got = np.linalg.matrix_rank(np.array(rows), tol=1e-8)
    want = restricted_updown(f, n).get(lam, 0)
    return ("OK" if got == want else "MISMATCH", got, want)

CASES = []
for lam in [(2,), (1,1)]:
    for n in (3, 4, 5):
        CASES += [(lam, 2, n), (lam, 4, n)]
    CASES += [(lam, 6, 3), (lam, 6, 4), (lam, 4, 2), (lam, 6, 2)]
for lam in [(2,2), (3,1), (2,1,1), (1,1,1,1), (4,)]:
    CASES += [(lam, 4, 4), (lam, 4, 5), (lam, 6, 4)]

print(f"{'lambda':>14} {'f':>2} {'n':>2} {'k':>2} {'sub-thr':>8} {'rank':>6} {'m_lam(n)':>9}  verdict")
bad = 0
for lam, f, n in CASES:
    r = run(lam, f, n)
    if r is None:
        print(f"{str(lam):>14} {f:>2} {n:>2} {(f-sum(lam))//2:>2} {'-':>8} {'-':>6} {'-':>9}  lambda NOT O(n)-admissible: no such block")
        continue
    st, got, want = r
    sub = "YES" if n < f - 1 else ""
    print(f"{str(lam):>14} {f:>2} {n:>2} {(f-sum(lam))//2:>2} {sub:>8} {got:>6} {want:>9}  {st}")
    if st != "OK":
        bad += 1
print(f"\n{bad} mismatches out of {len(CASES)} cells")
