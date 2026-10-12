"""r267 claim 4 -- the extraction screen, taken apart.

run_basis_extraction.py reports "about TEN diagrams per dimension of the block,
flat in n across n = 2, 3, 4" and asserts used <= 12*target + 5.  Four questions:

  (a) can odd f reach the empty partition at all;
  (b) does the cost look the same for a NON-TRIVIAL lambda, which is what n=12 needs;
  (c) is `used` an artefact of the enumeration order of `matchings`;
  (d) is the `rows` pruning rank-safe.

The diagram action here is built as an explicit n^f x n^f incidence matrix by
broadcasting over index tuples -- a different route from the reviewed file's
O(n^{2f}) double loop, and fast enough to run every question many times over.
"""
import numpy as np
from itertools import permutations

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i + 1:]):
            yield ((a, b),) + m

def nu_matrix(D, f, n):
    """nu(D) as an n^f x n^f matrix, same convention as the reviewed file:
    label = (output legs) ++ (input legs), entry 1 when every matched pair agrees."""
    N = n ** f
    dig = np.array([[(k // n ** (f - 1 - p)) % n for p in range(f)] for k in range(N)])
    J = dig[:, None, :]                       # output index, shape (N,1,f)
    I = dig[None, :, :]                       # input index,  shape (1,N,f)
    def lab(a):
        return J[:, :, a] if a < f else I[:, :, a - f]
    m = np.ones((N, N), dtype=bool)
    for a, b in D:
        m &= (lab(a) == lab(b))
    return m.astype(np.float64)

def cup_seed(f, n):
    v = np.array([1.0])
    c = np.zeros(n * n); c[::n + 1] = 1.0
    for _ in range(f // 2):
        v = np.kron(v, c)
    return v

def antisym_seed(f, n):
    """a lambda = (1^f) vector: the wedge e_0 ^ ... ^ e_{f-1}.  Needs n >= f."""
    v = np.zeros(n ** f)
    for p in permutations(range(f)):
        sgn = 1
        q = list(p)
        for i in range(f):
            for j in range(i + 1, f):
                if q[i] > q[j]:
                    sgn = -sgn
        v[sum(p[k] * n ** (f - 1 - k) for k in range(f))] += sgn
    return v

def harmonic_sym_seed(f, n):
    """a lambda = (f) vector: (e_0 + i e_1)^{tensor f} is traceless and symmetric;
    its real part is a real harmonic symmetric tensor."""
    u = np.zeros(n, dtype=complex); u[0] = 1; u[1] = 1j
    v = np.array([1.0 + 0j])
    for _ in range(f):
        v = np.kron(v, u)
    return v.real

def generic_seed(f, n, seed=0):
    return np.random.default_rng(seed).standard_normal(n ** f)

def full_span(mats, v):
    R = np.array([M @ v for M in mats])
    return np.linalg.matrix_rank(R, tol=1e-9 * max(1.0, np.abs(R).max())), R

def used_for(R, target, order):
    """first index at which the running span of R[order] reaches `target`.
    No pruning: the running rank is the rank of ALL rows seen so far."""
    cur = []
    for t, i in enumerate(order, 1):
        cur.append(R[i])
        A = np.array(cur)
        if np.linalg.matrix_rank(A, tol=1e-9 * max(1.0, np.abs(A).max())) == target:
            return t
    return None

if __name__ == "__main__":
    print("(a)  ODD f AND THE EMPTY PARTITION")
    print("     An up-down path in Young's lattice changes |lambda| by exactly +-1")
    print("     each step, so |lambda| after f steps has the parity of f.  Odd f")
    print("     therefore cannot end at |lambda| = 0.  Checked by enumeration:")
    def m_lambda(f, n, target):
        cur = {(): 1}
        for _ in range(f):
            nxt = {}
            for lam, c in cur.items():
                for k in range(len(lam) + 1):
                    new = list(lam) + [0]; new[k] += 1
                    if all(new[t] >= new[t+1] for t in range(len(new)-1)):
                        key = tuple(x for x in new if x)
                        cj = tuple(sum(1 for p in key if p > j) for j in range(key[0])) if key else ()
                        if (cj[0] if cj else 0) + (cj[1] if len(cj) > 1 else 0) <= n:
                            nxt[key] = nxt.get(key, 0) + c
                for k in range(len(lam)):
                    new = list(lam); new[k] -= 1
                    if new[k] >= 0 and all(new[t] >= new[t+1] for t in range(len(new)-1)):
                        key = tuple(x for x in new if x)
                        cj = tuple(sum(1 for p in key if p > j) for j in range(key[0])) if key else ()
                        if (cj[0] if cj else 0) + (cj[1] if len(cj) > 1 else 0) <= n:
                            nxt[key] = nxt.get(key, 0) + c
            cur = nxt
        return cur.get(target, 0)
    print(f"     {'f':>2} {'m_empty':>8} {'m_(1)':>7} {'m_(2)':>7} {'m_(1,1)':>8} {'m_(3)':>7}")
    for f in range(1, 8):
        print(f"     {f:>2} {m_lambda(f,6,()):>8} {m_lambda(f,6,(1,)):>7} "
              f"{m_lambda(f,6,(2,)):>7} {m_lambda(f,6,(1,1)):>8} {m_lambda(f,6,(3,)):>7}")
    print("     TRUE for lambda = empty, and it is a statement about THAT block only:")
    print("     odd f carries blocks of odd |lambda| and they are not empty.")
    print("     (And seed(f,n) returns a vector of length n^(f-1) at odd f, which")
    print("      apply_diagram cannot consume -- odd f was never runnable anyway.)")

    print("\n(b)/(c)  COST AT NON-TRIVIAL lambda, AND ORDER DEPENDENCE")
    print("     target = rank of the FULL diagram orbit of the seed; `used` = the")
    print("     index at which the running span first attains it.  200 random orders.")
    print(f"\n     {'f':>2} {'n':>2} {'seed':>10} {'target':>7} {'as-enum':>8} "
          f"{'rand min':>9} {'rand med':>9} {'rand max':>9} {'med/target':>11}")
    seeds = [("cup", cup_seed), ("antisym", antisym_seed),
             ("harm sym", harmonic_sym_seed), ("generic", generic_seed)]
    rows_summary = []
    for f, n in ((4, 3), (4, 4), (4, 5), (4, 6)):
        Ds = list(matchings(tuple(range(2 * f))))
        mats = [nu_matrix(D, f, n) for D in Ds]
        for name, fn in seeds:
            if name == "antisym" and n < f:
                continue
            v = fn(f, n)
            if np.abs(v).max() == 0:
                continue
            tgt, R = full_span(mats, v)
            if tgt == 0:
                continue
            u_enum = used_for(R, tgt, list(range(len(Ds))))
            rng = np.random.default_rng(17)
            us = []
            for _ in range(200):
                o = list(rng.permutation(len(Ds)))
                us.append(used_for(R, tgt, o))
            us = np.array([x for x in us if x is not None])
            rows_summary.append((f, n, name, tgt, u_enum, us.min(), int(np.median(us)), us.max()))
            print(f"     {f:>2} {n:>2} {name:>10} {tgt:>7} {u_enum:>8} "
                  f"{us.min():>9} {int(np.median(us)):>9} {us.max():>9} "
                  f"{np.median(us)/tgt:>11.1f}")

    print("\n(d)  THE PRUNING BRANCH")
    print("     `rows = rows[argsort(-max|row|)][:target+10]` keeps the rows with the")
    print("     LARGEST entries.  Magnitude is not a rank criterion.  Two things to")
    print("     settle: does it fire in the four reported cells, and is it rank-safe.")
    def fires(f, n, target):
        """does len(rows) exceed 4*target+40 before the reported `used`?"""
        return None
    # 1. does it fire?  used < 4*target+40 in every reported cell => it never fires.
    print(f"\n     {'f':>2} {'n':>2} {'m_empty':>8} {'reported used':>14} "
          f"{'threshold 4m+40':>16} {'fires?':>7}")
    for f, n, used in ((2, 3, 1), (4, 2, 31), (4, 3, 31), (4, 4, 31)):
        t = m_lambda(f, n, ())
        thr = 4 * t + 40
        print(f"     {f:>2} {n:>2} {t:>8} {used:>14} {thr:>16} "
              f"{'yes' if used > thr else 'no':>7}")
    # 2. is it rank-safe?  the selection sorts by magnitude, which is not a rank
    #    criterion.  Minimal witness, then the real row sets.
    print("\n     Minimal witness that max|entry| is not a rank criterion:")
    W = np.array([[1000., 0.], [1000., 0.], [0., 1.]])
    sel = W[np.argsort(-np.abs(W).max(1))][:2]
    print(f"       rows {W.tolist()} -> keep 2 by max|entry| -> rank "
          f"{np.linalg.matrix_rank(sel)}, full rank {np.linalg.matrix_rank(W)}")
    print("       and DUPLICATE rows are the norm here: many diagrams send the seed")
    print("       to the same vector, so the top-k by magnitude is often k copies.")
    print(f"\n     {'f':>2} {'n':>2} {'seed':>10} {'rows':>5} {'distinct':>9} "
          f"{'full rk':>8} {'top-(t+10) rk':>14}")
    for f, n in ((4, 4), (4, 5)):
        Ds = list(matchings(tuple(range(2 * f))))
        mats = [nu_matrix(D, f, n) for D in Ds]
        for name, fn in seeds:
            v = fn(f, n)
            R = np.array([M @ v for M in mats])
            if np.abs(R).max() == 0:
                continue
            t = np.linalg.matrix_rank(R, tol=1e-9 * np.abs(R).max())
            distinct = len({tuple(np.round(r, 9)) for r in R})
            sel = R[np.argsort(-np.abs(R).max(1))][:t + 10]
            rk = np.linalg.matrix_rank(sel, tol=1e-9 * max(1e-30, np.abs(sel).max()))
            print(f"     {f:>2} {n:>2} {name:>10} {len(R):>5} {distinct:>9} "
                  f"{t:>8} {rk:>14}" + ("" if rk == t else "   <-- RANK LOST"))

    print("\n     3. the reviewed loop, verbatim, on a NON-TRIVIAL lambda seed.")
    def extraction_cost_verbatim(mats, v, target, prune=True):
        rows, rank, used = [], 0, 0
        for M in mats:
            used += 1
            rows.append(M @ v)
            r = np.linalg.matrix_rank(np.array(rows), tol=1e-9)
            if r > rank:
                rank = r
                if rank == target:
                    return used
            if prune and len(rows) > 4 * target + 40:
                rows = list(np.array(rows)[np.argsort(-np.abs(np.array(rows)).max(1))][:target + 10])
        return None
    print(f"       {'f':>2} {'n':>2} {'seed':>10} {'target':>7} {'with prune':>11} "
          f"{'no prune':>9}")
    for f, n in ((4, 4), (4, 5), (4, 6)):
        Ds = list(matchings(tuple(range(2 * f))))
        mats = [nu_matrix(D, f, n) for D in Ds]
        for name, fn in (("harm sym", harmonic_sym_seed), ("antisym", antisym_seed)):
            v = fn(f, n)
            R = np.array([M @ v for M in mats])
            t = np.linalg.matrix_rank(R, tol=1e-9 * np.abs(R).max())
            a = extraction_cost_verbatim(mats, v, t, prune=True)
            b = extraction_cost_verbatim(mats, v, t, prune=False)
            print(f"       {f:>2} {n:>2} {name:>10} {t:>7} {str(a):>11} {str(b):>9}"
                  + ("" if a == b else "   <-- PRUNE CHANGED THE ANSWER"))
            print(f"          assert used <= 12*target+5 = {12*t+5}: "
                  f"{'HOLDS' if (b is not None and b <= 12*t+5) else 'WOULD FIRE'}")
