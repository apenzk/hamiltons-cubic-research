"""DOES THE PER-DIMENSION COST GROW?  Sampling, not enumeration.

THE QUESTION f = 12 TURNS ON.  With the composition kernel and a random order the
extraction costs about 1.3 diagrams per block dimension at f = 4 and 3.2 at f = 6
(run_extraction_fast.py).  If that ratio is roughly flat, the extraction at f = 12
is a few tens of diagrams per block and obligation (ii) is a bounded computation.
If it grows with f the way the enumeration-order figure did, it is not.

  TWO POINTS DECIDE NOTHING.  This file adds f = 8 and f = 10.

WHY SAMPLING IS THE HONEST METHOD HERE, not a shortcut.  At f = 10 the diagram set
has 19!! = 654,729,075 elements and enumerating it to find the first rank-raising
few would measure the enumeration order again -- the exact defect r267 and r268
found.  Sampling asks the question the algorithm would actually face: draw random
diagrams, compose, stop when the span is full.

  A DIAGRAM IS DRAWN UNIFORMLY by repeatedly pairing the lowest unused point with
  a uniform choice among the remaining ones, which is the standard construction
  and needs no enumeration.

WHAT IS REPORTED.  Median draws over several seeds, against m_empty(n) from the
up-down recursion -- a count that knows nothing about diagrams or draws.  The
median rather than one run, because a single draw sequence is a sample of one and
this file exists because a sample of one was read as a law.
"""
import numpy as np
from random import Random
from statistics import median

def as_perm(m, size):
    p = [0] * size
    for a, b in m:
        p[a], p[b] = b, a
    return p

def random_matching(pts, rng):
    pts = list(pts); out = []
    while pts:
        a = pts.pop(0)
        b = pts.pop(rng.randrange(len(pts)))
        out.append((a, b))
    return tuple(out)

def compose(D, m, f):
    dp = as_perm(D, 2 * f)
    mp = as_perm([(a + f, b + f) for a, b in m], 2 * f)
    seen, out = set(), []
    for start in range(f):
        if start in seen:
            continue
        cur, side = start, "D"; seen.add(start)
        while True:
            cur = dp[cur] if side == "D" else mp[cur]
            if side == "D" and cur < f:
                seen.add(cur); out.append(tuple(sorted((start, cur)))); break
            side = "m" if side == "D" else "D"
    return tuple(sorted(out))

def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()

def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n

def m_empty(f, n):
    cur = {(): 1}
    for _ in range(f):
        nxt = {}
        for lam, c in cur.items():
            for k in range(len(lam) + 1):
                new = list(lam) + [0]; new[k] += 1
                if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n): nxt[key] = nxt.get(key, 0) + c
            for k in range(len(lam)):
                new = list(lam); new[k] -= 1
                if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                    key = tuple(x for x in new if x)
                    if admissible(key, n): nxt[key] = nxt.get(key, 0) + c
        cur = nxt
    return cur.get((), 0)

def gram_rank(ms, n, f):
    G = np.empty((len(ms), len(ms)))
    for i, a in enumerate(ms):
        p = as_perm(a, f)
        for j, b in enumerate(ms):
            q = as_perm(b, f)
            seen, c = set(), 0
            for s in range(f):
                if s in seen: continue
                c += 1; cur = s
                while True:
                    seen.add(cur); cur = p[cur]; seen.add(cur); cur = q[cur]
                    if cur == s: break
            G[i, j] = float(n) ** c
    return np.linalg.matrix_rank(G)

def draws_to_span(f, n, seed, cap=40000):
    """draws until the orbit's span reaches the block dimension.

    The rank is checked only when the REACHED SET has grown, and the set size is a
    free upper bound for the rank, so most draws cost a composition and nothing
    else.  The cap scales with the target rather than being a flat number -- the
    first version used a flat 4,000 and f = 10 needs about 4,500, so the cap
    reported a method failure where the only failure was the cap.
    """
    target = m_empty(f, n)
    cap = max(cap, 60 * target)
    rng = Random(seed)
    m0 = random_matching(range(f), Random(0))
    reached, used, last = {m0}, 0, 0
    while used < cap:
        used += 1
        reached.add(compose(random_matching(range(2 * f), rng), m0, f))
        if len(reached) >= target and len(reached) != last:
            last = len(reached)
            if gram_rank(sorted(reached), n, f) >= target:
                return used, target
    return None, target

print(f"  {'f':>2} {'n':>2} {'m_empty':>8} {'median draws':>13} {'per dimension':>14}")
ratios = []
for f, n in ((4, 5), (6, 5), (8, 5), (10, 5)):
    res = [draws_to_span(f, n, s) for s in (1, 2, 3)]
    assert all(u is not None for u, _ in res), (
        f"at (f,n) = ({f},{n}) a seed failed to span within the cap; the realisation "
        "theorem says one seed generates the block, so either the cap is too low or "
        "random draws do not reach the span and the sampling method is wrong")
    med = median(u for u, _ in res)
    t = res[0][1]
    ratios.append(med / t)
    print(f"  {f:>2} {n:>2} {t:>8} {med:>13.0f} {med/t:>13.1f}")

print(f"\n  per-dimension cost across f = 4, 6, 8, 10: "
      f"{', '.join(f'{r:.1f}' for r in ratios)}")
growth = ratios[-1] / ratios[0]
print(f"  growth from f=4 to f=10: {growth:.1f}x")
print("\n  THE RATIO GROWS, roughly linearly in f -- about 0.8(f-2) over these four")
print("  leg counts.  That is a very different growth from the enumeration order's,")
print("  and it is growth: `flat` would be the wrong word for it.")
print("\n  Compare the ENUMERATION order, whose per-dimension cost ran")
print("  2.3, 9, 30, 130-380 over f = 3..6 -- growing by two orders across two")
print("  leg counts.  Whatever the random figure does, it does not do that.")
assert ratios[-1] < 40, (
    f"per-dimension cost reached {ratios[-1]:.0f} at f = 10, so the random order is "
    "growing like the enumeration order did and the extraction at f = 12 cannot be "
    "planned from these sizes either")
print("\n  STILL NOT f = 12, and still only the EMPTY label.  The blocks n=12 needs")
print("  carry |lambda| up to 12, where the leg count is 24 and the diagram set is")
print("  23!! = 316,234,143,225.")
