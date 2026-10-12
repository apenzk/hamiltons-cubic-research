"""r259 -- independent checks behind claims 2, 3 and 5 of commit b6ecd9d.

FOUR COMPUTATIONS, none of which reuses the reviewed script's code path.

(A) dim nu(B_f(n)) FROM THE DIAGRAM GRAM MATRIX.  For two perfect matchings D, D' of
    the 2f boundary points, <nu(D), nu(D')> in the entrywise inner product on
    End(V^{tensor f}) counts the labelings of the 2f points that are constant on the
    blocks of BOTH matchings, so it equals n^{c(D union D')} with c the number of cycles
    in the union.  The rank of that (2f-1)!! square integer matrix IS dim nu(B_f(n)),
    and its size does not depend on n, so f = 5 is reachable where the dense n^f by n^f
    route of the reviewed script is not.

(B) THE MULTIPLICITY SPACES THEMSELVES.  m_lambda(n) = the number of up-down tableaux of
    length f from the empty shape to lambda whose EVERY intermediate shape is
    O(n)-admissible.  sum_lambda m_lambda(n)^2 is a second, independent prediction for
    dim nu(B_f(n)); comparing it against the reviewed script's sum over admissible lambda
    of (dim Delta_lambda)^2 localises any failure and says whether a lambda DROPS OUT or
    keeps a multiplicity space SMALLER than its cell module.

(C) SEMISIMPLICITY OF B_f(n) ITSELF, by Dickson's criterion: over a characteristic-zero
    field an algebra is semisimple iff the trace form of its regular representation is
    nondegenerate.  This tests Rui's inequality head on, in both directions, rather than
    through a consequence of it.

(D) THE ROUTE'S OWN PARAMETERS, f = 12.  The two predictions of (B) computed at f = 12
    for a range of n, to see exactly where they part company.
"""
import sys

import numpy as np

P1, P2 = 2147483647, 2147483629


# ---------------------------------------------------------------- diagram basics

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i + 1:]):
            yield ((a, b),) + m


def basis(m):
    """Brauer diagrams on 2m points as partner arrays; 0..m-1 top, m..2m-1 bottom."""
    out = []
    for D in matchings(tuple(range(2 * m))):
        p = [-1] * (2 * m)
        for a, b in D:
            p[a], p[b] = b, a
        out.append(tuple(p))
    return out


def union_cycles(p, q, m):
    """cycles in the union of two perfect matchings on 2m points."""
    seen = bytearray(2 * m)
    c = 0
    for s in range(2 * m):
        if seen[s]:
            continue
        c += 1
        x, use_p = s, True
        while True:
            seen[x] = 1
            x = p[x] if use_p else q[x]
            use_p = not use_p
            if x == s:
                break
    return c


def compose(a, b, m):
    """a above b: glue a's bottom row to b's top row.  Returns (product, #closed loops).

    Nodes 0..m-1 are a's top, m..2m-1 the glued middle, 2m..3m-1 b's bottom.  ea joins
    a's points (global 0..2m-1), eb joins b's points shifted by m (global m..3m-1).
    """
    ea = [-1] * (3 * m)
    eb = [-1] * (3 * m)
    for i in range(2 * m):
        ea[i] = a[i]
        eb[i + m] = b[i] + m
    res = [-1] * (2 * m)
    seen = bytearray(3 * m)
    ext = list(range(m)) + list(range(2 * m, 3 * m))

    def out_index(x):
        return x if x < m else x - m           # 2m+i -> m+i

    for e in ext:
        if res[out_index(e)] != -1:
            continue
        seen[e] = 1
        x = ea[e] if e < m else eb[e]
        via_a = e < m                          # the edge just used was an a-edge
        while m <= x < 2 * m:
            seen[x] = 1
            x = eb[x] if via_a else ea[x]
            via_a = not via_a
        seen[x] = 1
        res[out_index(e)] = out_index(x)
        res[out_index(x)] = out_index(e)
    loops = 0
    for s in range(m, 2 * m):
        if seen[s]:
            continue
        loops += 1
        x, via_a = s, False
        while True:
            seen[x] = 1
            x = eb[x] if via_a else ea[x]
            via_a = not via_a
            if x == s:
                break
    return tuple(res), loops


def rank_mod_p(M, p):
    A = np.ascontiguousarray(M.astype(np.int64) % p)
    rows, cols = A.shape
    r = 0
    for c in range(cols):
        nz = np.nonzero(A[r:, c])[0]
        if nz.size == 0:
            continue
        piv = r + int(nz[0])
        if piv != r:
            A[[r, piv]] = A[[piv, r]]
        A[r] = (A[r] * pow(int(A[r, c]), p - 2, p)) % p
        col = A[r + 1:, c]
        hit = np.nonzero(col)[0]
        if hit.size:
            A[r + 1 + hit] = (A[r + 1 + hit] - np.outer(col[hit], A[r])) % p
        r += 1
        if r == rows:
            break
    return r


# ------------------------------------------------------- shapes and multiplicities

def conj(lam):
    return tuple(sum(1 for p in lam if p > k) for k in range(lam[0])) if lam else ()


def admissible(lam, n):
    c = conj(lam)
    return (c[0] if c else 0) + (c[1] if len(c) > 1 else 0) <= n


def neighbours(lam):
    out = []
    for k in range(len(lam) + 1):
        new = list(lam) + [0]
        new[k] += 1
        if all(new[t] >= new[t + 1] for t in range(len(new) - 1)):
            out.append(tuple(x for x in new if x))
    for k in range(len(lam)):
        new = list(lam)
        new[k] -= 1
        if new[k] >= 0 and all(new[t] >= new[t + 1] for t in range(len(new) - 1)):
            out.append(tuple(x for x in new if x))
    return out


def updown(m, n=None):
    """n None: dim Delta_lambda.  n given: only paths through admissible shapes."""
    cur = {(): 1}
    for _ in range(m):
        nxt = {}
        for lam, c in cur.items():
            for mu in neighbours(lam):
                if n is not None and not admissible(mu, n):
                    continue
                nxt[mu] = nxt.get(mu, 0) + c
        cur = nxt
    return cur


# --------------------------------------------------------------------------- main

def part_a_b(fmax):
    print("=" * 88)
    print("(A)+(B)  dim nu(B_f(n)) by diagram Gram rank, against the two predictions")
    print("=" * 88)
    print("  pred_cell = sum over O(n)-admissible lambda of (dim Delta_lambda)^2  "
          "<- the reviewed script's")
    print("  pred_mult = sum over lambda of m_lambda(n)^2, restricted up-down tableaux\n")
    for m in range(2, fmax + 1):
        ps = basis(m)
        N = len(ps)
        exps = np.zeros((N, N), dtype=np.int64)
        for i in range(N):
            for j in range(i, N):
                exps[i, j] = exps[j, i] = union_cycles(ps[i], ps[j], m)
        ud = updown(m)
        for n in range(1, 9):
            pred_cell = sum(d * d for lam, d in ud.items() if admissible(lam, n))
            pred_mult = sum(d * d for d in updown(m, n).values())
            ranks = []
            for p in (P1, P2):
                npow = np.array([pow(n, int(e), p) for e in range(2 * m + 1)],
                                dtype=np.int64)
                ranks.append(rank_mod_p(npow[exps], p))
            tag = "MATCH" if ranks[0] == pred_cell else "differs"
            tag2 = "ok" if ranks[0] == pred_mult else "MULT DIFFERS"
            print(f"  f={m} n={n}  {N:>4} diagrams  rank={ranks[0]:>5}"
                  f" (2nd prime {ranks[1]:>5})  pred_cell={pred_cell:>5} {tag:>7}"
                  f"   pred_mult={pred_mult:>5} {tag2}   n>=f-1:{n >= m - 1}")
        print()


def part_c(fmax):
    print("=" * 88)
    print("(C)  semisimplicity of B_f(n) itself, Dickson trace-form criterion")
    print("=" * 88)
    print("  Rui as the record quotes it: B_f(n) semisimple over a char-0 field "
          "iff n >= f-1.\n")
    disagreements = []
    for m in range(2, fmax + 1):
        ps = basis(m)
        idx = {b: i for i, b in enumerate(ps)}
        N = len(ps)
        prod = np.zeros((N, N), dtype=np.int64)
        ploop = np.zeros((N, N), dtype=np.int64)
        for i, a in enumerate(ps):
            for j, b in enumerate(ps):
                g, k = compose(a, b, m)
                prod[i, j] = idx[g]
                ploop[i, j] = k
        diagN = np.arange(N)
        for n in range(0, 9):
            ranks = []
            for p in (P1, P2):
                npow = np.array([pow(n, int(e), p) for e in range(m + 2)],
                                dtype=np.int64)
                t = np.zeros(N, dtype=np.int64)
                for i in range(N):
                    hit = prod[i] == diagN
                    t[i] = int(npow[ploop[i][hit]].sum() % p)
                T = (npow[ploop] * t[prod]) % p
                ranks.append(rank_mod_p(T, p))
            ss = ranks[0] == N and ranks[1] == N
            pred = n >= m - 1
            ok = ss == pred
            if not ok:
                disagreements.append((m, n, ss, pred))
            print(f"  f={m} n={n}  dim B_f={N:>4}  rank(trace form)={ranks[0]:>4}"
                  f"  SEMISIMPLE={str(ss):>5}   Rui predicts {str(pred):>5}"
                  f"   {'ok' if ok else '*** DISAGREES ***'}")
        print()
    print(f"  disagreements with n >= f-1: {disagreements}\n")


def part_d():
    print("=" * 88)
    print("(D)  the route's own parameters: f = 12, the two predictions against n")
    print("=" * 88)
    ud = updown(12)
    print("   n   sum_adm (dim Delta)^2            sum m_lambda(n)^2          equal?"
          "   n>=f-1  n>=f")
    for n in range(4, 15):
        pc = sum(d * d for lam, d in ud.items() if admissible(lam, n))
        pm = sum(d * d for d in updown(12, n).values())
        print(f"  {n:>2}   {pc:>26}   {pm:>26}   {str(pc == pm):>5}"
              f"   {str(n >= 11):>5}  {str(n >= 12):>5}")
    print("\n  dim B_12(n) = 23!! =", sum(d * d for d in ud.values()))


if __name__ == "__main__":
    which = sys.argv[1] if len(sys.argv) > 1 else "all"
    fmax = int(sys.argv[2]) if len(sys.argv) > 2 else 5
    if which in ("all", "ab"):
        part_a_b(fmax)
    if which in ("all", "c"):
        part_c(min(fmax, 5))
    if which in ("all", "d"):
        part_d()
