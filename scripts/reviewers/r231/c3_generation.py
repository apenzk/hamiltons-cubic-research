"""r231 claim 3: audit the lemma <B_n, block O(n_0)> = O(n) for n_0 >= 2.

Three things are checked, and the third is the one the file's own screen does
NOT check.

  (a) the combinatorial step -- conjugating the block by coordinate permutations
      reaches every coordinate 2-plane.  Done DETERMINISTICALLY (the file samples
      4000 random signed permutations and could in principle miss a plane).

  (b) the Givens step, CONSTRUCTIVELY: take a random element of O(n), factor it
      into Givens rotations by the standard QR sweep, express every factor as a
      conjugate of an element of the block O(n_0), multiply the word back and
      compare.  This verifies the lemma's conclusion by exhibiting the word,
      rather than citing Givens' theorem.

  (c) the hypothesis n_0 >= 2, by exhibiting what happens at n_0 = 1.
"""
import itertools, numpy as np

rng = np.random.default_rng(11)

def perm_mat(p):
    n = len(p); P = np.zeros((n, n))
    for i, j in enumerate(p):
        P[j, i] = 1.0          # e_i -> e_{p(i)}
    return P

def givens(n, i, j, c, s):
    G = np.eye(n); G[i, i] = c; G[j, j] = c; G[i, j] = -s; G[j, i] = s
    return G

# ---- (a) every coordinate 2-plane is reached, exhaustively over S_n images ---
print("(a) coordinate 2-planes reached, EXHAUSTIVELY over the n_0-subsets")
for n, n0 in ((6, 2), (8, 3), (12, 2), (12, 4), (2, 2), (3, 2), (5, 5)):
    reached = set()
    for S in itertools.combinations(range(n), n0):
        for a, b in itertools.combinations(S, 2):
            reached.add((a, b))
    total = n * (n - 1) // 2
    ok = len(reached) == total
    print(f"    n={n:>3} n_0={n0}:  {len(reached):>3}/{total:>3}  {'OK' if ok else 'MISSING'}")
    assert ok, f"not all 2-planes reached at n={n}, n_0={n0}"

# ---- (c) the planted failure: n_0 = 1 ---------------------------------------
print("\n(c) PLANTED n_0 = 1 -- the hypothesis n_0 >= 2 must be necessary")
for n in (2, 4, 6, 12):
    reached = set()
    for S in itertools.combinations(range(n), 1):
        for a, b in itertools.combinations(S, 2):
            reached.add((a, b))
    total = n * (n - 1) // 2
    print(f"    n={n:>3} n_0=1:  {len(reached):>3}/{total:>3}  "
          f"{'SCREEN FIRES' if len(reached) != total else 'screen silent'}")
    assert len(reached) != total, "n_0=1 should reach no 2-plane for n>=2"
print("    O(1) = {+-1} is already inside B_n, so <B_n, O(1)> = B_n, a FINITE")
print("    group of order 2^n n!, not O(n).  n_0 >= 2 is necessary, and by (b)")
print("    it is sufficient: the hypothesis is SHARP, not conservative.")

# ---- (b) constructive: write a random O(n) element as a word in the generators
def factor_into_givens(Q):
    """QR sweep: return list of (i,j,c,s) with prod(G) @ D = Q, D diagonal +-1."""
    n = Q.shape[0]; A = Q.copy(); ops = []
    for j in range(n):
        for i in range(n - 1, j, -1):
            a, b = A[i - 1, j], A[i, j]
            r = np.hypot(a, b)
            if r < 1e-15:
                continue
            c, s = a / r, b / r           # G(i-1,i,c,s) kills A[i,j]
            G = givens(n, i - 1, i, c, s)
            A = G.T @ A                   # apply G^T on the left
            ops.append((i - 1, i, c, s))
    return ops, A

print("\n(b) CONSTRUCTIVE check of the lemma: a random O(n) element rebuilt as a")
print("    word in {block O(n_0) conjugates by coordinate permutations} u B_n")
for n, n0 in ((6, 2), (8, 3), (12, 4), (5, 5)):
    for trial in range(3):
        M = rng.normal(size=(n, n))
        Q, R = np.linalg.qr(M)
        Q = Q * np.sign(np.diag(R))
        if trial == 0:                      # force a det -1 instance too
            Q[:, 0] *= -1
        ops, D = factor_into_givens(Q)
        assert np.allclose(np.abs(np.diag(D)), 1) and np.allclose(D, np.diag(np.diag(D)), atol=1e-9)
        # rebuild each Givens factor as P B P^T with B in the block O(n_0)
        word = np.eye(n)
        for (i, j, c, s) in ops:
            # a permutation carrying {0,...,n0-1} onto a set containing {i,j}
            rest = [k for k in range(n) if k not in (i, j)]
            target = [i, j] + rest[: n0 - 2]
            others = [k for k in range(n) if k not in target]
            p = target + others            # p(0)=i, p(1)=j, ...
            P = perm_mat(p)
            assert np.allclose(P @ P.T, np.eye(n))
            B = givens(n, 0, 1, c, s)      # lives inside the first-n_0 block
            assert np.allclose(B[n0:, :], np.eye(n)[n0:, :]), "B leaves the block"
            g = P @ B @ P.T
            assert np.allclose(g, givens(n, i, j, c, s)), "conjugation mislands"
            word = word @ g
        signflip = np.diag([-1.0] + [1.0] * (n - 1))   # in B_n, det -1
        # D is diag(+-1); every -1 entry is a sign flip, each a conjugate of signflip
        for k in range(n):
            if D[k, k] < 0:
                p = [k] + [t for t in range(n) if t != k]
                P = perm_mat(p)
                word = word @ (P @ signflip @ P.T)
        err = np.abs(word - Q).max()
        print(f"    n={n:>3} n_0={n0}  det={np.linalg.det(Q):+.0f}  "
              f"|word - Q|_max = {err:.2e}  ({len(ops)} block conjugates)")
        assert err < 1e-9, "the word does not reproduce Q -- generation FAILS"
print("\n    every O(n) element tested is a finite word in the claimed generators,")
print("    for det +1 and det -1 alike.  The lemma's CONCLUSION holds.")
