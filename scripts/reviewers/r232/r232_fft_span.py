"""r232 / claim 1b.  Does the FFT for O(n) SPAN at every dimension, or only in a
stable range?  run_bn_transfer_theorem.py asserts "spanning holds at every m,
only independence needs the stable range".  If spanning failed below the stable
range the expansion u_{n_0} = sum_D c_D q_D^{(n_0)} would not exist and step (1)
would be false exactly where n_0 is smallest -- the interesting regime.

TEST.  The tensor form of the FFT: the O(n)-invariants of (R^n)^{otimes 2m} are
spanned by the (2m-1)!! perfect matchings of the 2m slots.  We compute the true
invariant space EXACTLY as

   ker( so(n) acting by derivations )  intersect  fix( a reflection ),

which is O(n)^{invariants} on the nose (so(n) gives the identity component, the
reflection the other one), and compare its dimension with the rank of the
matching span.  Equality at every n tested = spanning at every dimension;
rank < (2m-1)!! below the stable range = independence failing, as claimed.
"""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import r232_lin as L

def so_action(n, d):
    """rows: the images of basis tensors under L_ab, stacked as a constraint
    matrix on R^{n^d} (a tensor is invariant iff every L_ab kills it)."""
    N = n ** d
    rows = []
    for a in range(n):
        for b in range(a + 1, n):
            M = np.zeros((N, N), dtype=np.int64)
            for t, idx in enumerate(itertools.product(range(n), repeat=d)):
                for pos in range(d):
                    if idx[pos] == a:
                        j = list(idx); j[pos] = b
                        s = 0
                        for q in j: s = s * n + q
                        M[s, t] += 1
                    elif idx[pos] == b:
                        j = list(idx); j[pos] = a
                        s = 0
                        for q in j: s = s * n + q
                        M[s, t] -= 1
            rows.append(M)
    return rows

def reflection_constraint(n, d):
    """x_0 -> -x_0 acts diagonally; invariance kills every tensor with an odd
    number of 0-indices."""
    N = n ** d
    M = np.zeros((N, N), dtype=np.int64)
    for t, idx in enumerate(itertools.product(range(n), repeat=d)):
        sgn = -1 if sum(1 for q in idx if q == 0) % 2 else 1
        M[t, t] = sgn - 1
    return M

def matchings(m2):
    pts = list(range(m2))
    if not pts:
        yield []
        return
    def rec(rest):
        if not rest:
            yield []
            return
        a = rest[0]
        for k in range(1, len(rest)):
            b = rest[k]
            for tail in rec(rest[1:k] + rest[k + 1:]):
                yield [(a, b)] + tail
    yield from rec(pts)

def matching_tensor(n, M, d):
    v = np.zeros(n ** d, dtype=np.int64)
    for idx in itertools.product(range(n), repeat=d):
        if all(idx[a] == idx[b] for a, b in M):
            s = 0
            for q in idx: s = s * n + q
            v[s] = 1
    return v

print(f"{'n':>3} {'2m':>3} {'#matchings':>11} {'rank(span)':>11} {'dim inv':>8}  spans?  independent?")
for d in (2, 4, 6):
    for n in (1, 2, 3):
        if n ** d > 1200:
            continue
        C = np.vstack(so_action(n, d) + [reflection_constraint(n, d)]) if n > 1 \
            else reflection_constraint(n, d)
        dim_inv = C.shape[1] - L.rank(C)
        Ms = list(matchings(d))
        span = np.array([matching_tensor(n, M, d) for M in Ms], dtype=np.int64)
        r = L.rank(span)
        print(f"{n:>3} {d:>3} {len(Ms):>11} {r:>11} {dim_inv:>8}   "
              f"{str(r == dim_inv):>5}   {str(r == len(Ms)):>5}")
        assert r == dim_inv, (
            f"SPANNING FAILS at n={n}, 2m={d}: the matchings span a {r}-dimensional "
            f"space inside a {dim_inv}-dimensional invariant space.  Step (1) of the "
            "transfer theorem would then have no diagram expansion at small n_0.")
print()
print("  spanning holds at EVERY n tested, including n below the stable range;")
print("  independence is what fails there.  The file's statement is correct.")
