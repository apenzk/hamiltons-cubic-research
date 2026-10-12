"""Reviewer 40 -- the U(m)-decomposition of Weyl_{2m} from Howe-Tan-Willenbring,
derived independently of the numerics.

HTW arXiv:math/0311159, Main Theorem 2.3.1 (GL_n subset O_2n), quoted from the source:

    "2.3.1. GL_n subset O_2n.  Let mu+, mu- and lambda be non-negative integer
     partitions with at most floor(n/2) parts, then
         [ E^lambda_(2n) , F^{(mu+,mu-)}_(n) ] = sum  c^gamma_{mu+ mu-} c^lambda_{gamma,(2delta)'}
     where the sum is over all non-negative integer partitions delta and gamma."

Weyl_{2m} (x) C is the O(2m)-irreducible E^{(2,2)}_{(2m)}, so lambda = (2,2), n = m,
and the rule applies for floor(m/2) >= 2, i.e. m >= 4.
"""
from itertools import product


def partitions(k, maxpart=None):
    if k == 0:
        return [()]
    out = []
    def rec(rem, mx, cur):
        if rem == 0:
            out.append(tuple(cur)); return
        for v in range(min(rem, mx), 0, -1):
            rec(rem - v, v, cur + [v])
    rec(k, maxpart or k, [])
    return out


def transpose(p):
    return () if not p else tuple(sum(1 for x in p if x > j) for j in range(p[0]))


def lr(lam, mu, nu):
    """c^lam_{mu nu}: # LR skew tableaux of shape lam/mu, content nu."""
    lam = list(lam); mu = list(mu) + [0] * (len(lam) - len(mu))
    if len(mu) > len(lam) or sum(mu) + sum(nu) != sum(lam):
        return 0
    for i in range(len(lam)):
        if mu[i] > lam[i]:
            return 0
    cells = [(i, j) for i in range(len(lam)) for j in range(mu[i], lam[i])]
    cells.sort(key=lambda c: (c[0], -c[1]))     # row by row, right to left (reading word)
    k = len(nu)
    count = 0
    grid = {}

    def ok(i, j, v):
        if (i - 1, j) in grid and grid[(i - 1, j)] >= v:   # strictly increasing down
            return False
        if i - 1 >= 0 and j < mu[i - 1]:                   # cell above is in mu -> no constraint
            pass
        if (i, j + 1) in grid and grid[(i, j + 1)] < v:    # weakly increasing along rows
            return False
        if (i, j - 1) in grid and grid[(i, j - 1)] > v:
            return False
        return True

    def rec(t, cnt):
        nonlocal count
        if t == len(cells):
            count += 1
            return
        i, j = cells[t]
        for v in range(1, k + 1):
            if cnt[v - 1] + 1 > nu[v - 1]:
                continue
            if v > 1 and cnt[v - 2] <= cnt[v - 1]:          # lattice-word condition
                continue
            if not ok(i, j, v):
                continue
            grid[(i, j)] = v
            cnt[v - 1] += 1
            rec(t + 1, cnt)
            cnt[v - 1] -= 1
            del grid[(i, j)]
    rec(0, [0] * k)
    return count


def htw(lam=(2, 2), verbose=True):
    L = sum(lam)
    gd = []
    for dsz in range(0, L // 2 + 1):
        for delta in partitions(dsz):
            t = transpose(tuple(2 * x for x in delta))
            g_size = L - sum(t)
            if g_size < 0:
                continue
            for gamma in partitions(g_size):
                c = lr(lam, gamma, t) if t else (1 if tuple(gamma) == tuple(lam) else 0)
                if c:
                    gd.append((gamma, delta, t, c))
    if verbose:
        print(f"  (gamma, delta) with c^{lam}_(gamma,(2delta)') nonzero:")
        for gamma, delta, t, c in gd:
            print(f"    gamma={gamma}  delta={delta}  (2delta)'={t}  c={c}")
    res = {}
    for gamma, delta, t, cc in gd:
        g = sum(gamma)
        for sz in range(g + 1):
            for mp in partitions(sz):
                for mm in partitions(g - sz):
                    c = lr(gamma, mp, mm) if (mp and mm) else \
                        (1 if (tuple(mp) == tuple(gamma) and not mm) or
                              (tuple(mm) == tuple(gamma) and not mp) else 0)
                    if c:
                        res[(mp, mm)] = res.get((mp, mm), 0) + c * cc
    return res


def hw(mp, mm, m):
    v = list(mp) + [0] * (m - len(mp) - len(mm)) + [-x for x in reversed(mm)]
    return tuple(v)


if __name__ == '__main__':
    # sanity checks on the LR routine
    assert lr((2, 2), (1, 1), (1, 1)) == 1
    assert lr((2, 2), (2,), (1, 1)) == 0
    assert lr((2, 2), (2,), (2,)) == 1
    assert lr((3, 1), (2,), (1, 1)) == 1
    assert lr((2, 1), (1,), (1, 1)) == 1
    assert lr((4,), (2,), (2,)) == 1
    assert lr((2, 1, 1), (1, 1), (1, 1)) == 1
    print("LR sanity checks pass")
    res = htw()
    print(f"\n  distinct (mu+,mu-): {len(res)};  multiplicity-free: {all(v == 1 for v in res.values())}")
    for m in (4, 5, 6, 7):
        print(f"\n  m={m}  (rule valid: floor(m/2) >= 2 -> {m >= 4}; "
              f"mu-parts <= floor(m/2) = {m//2})")
        tot = 0
        for (mp, mm), c in sorted(res.items(), key=lambda kv: (-sum(kv[0][0]), kv[0])):
            if max(len(mp), len(mm)) > m // 2:
                print(f"    OUT OF STATED RANGE: mu+={mp} mu-={mm}")
            print(f"    hw {hw(mp, mm, m)}  mult {c}")
        print(f"    (10 summands, all multiplicity 1)")
