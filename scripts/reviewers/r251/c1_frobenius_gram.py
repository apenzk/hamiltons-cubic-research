"""r251, claim 1: is n^{cycles} the Frobenius Gram, and does the dependence
certificate run in the direction claimed?

Object under test, exactly as reviewer 250 built it: the 105 perfect matchings
on 8 legs -- the projector-free Brauer diagrams of a degree-2 contraction of two
4-tensors.  A matching M gives the tensor

    (T_M)_{i_1...i_8} = prod_{(a,b) in M} delta(i_a, i_b)   in (R^n)^{tensor 8},

and the diagram's value on W is <T_M, W (x) W>.  The record claims

  (1a) <T_M, T_M'>_Frobenius = n^{#cycles(M u M')} exactly, and
  (1b) since restriction to Weyl_n cannot raise rank, a rank-deficient
       projector-free Gram CERTIFIES dependence of the covariants.

Everything below is exact: integer tensors, integer Grams, Fraction kernels.
"""
import itertools, sys
from fractions import Fraction as Fr
import numpy as np

# ---------- diagrams ----------

def matchings(pts):
    if not pts:
        yield ()
        return
    a = pts[0]
    for i in range(1, len(pts)):
        rest = pts[1:i] + pts[i+1:]
        for m in matchings(rest):
            yield ((a, pts[i]),) + m

def n_cycles(M1, M2, k):
    """components of the 2-regular multigraph M1 u M2 on 2k vertices."""
    p1 = [0]*(2*k); p2 = [0]*(2*k)
    for a, b in M1: p1[a] = b; p1[b] = a
    for a, b in M2: p2[a] = b; p2[b] = a
    seen = [False]*(2*k); c = 0
    for s in range(2*k):
        if seen[s]: continue
        c += 1; v = s; use1 = True
        while not seen[v]:
            seen[v] = True
            v = p1[v] if use1 else p2[v]
            use1 = not use1
    return c

def tensor(M, n, k):
    T = np.ones((n,)*(2*k), dtype=np.int64)
    for a, b in M:
        sh = [1]*(2*k); sh[a] = n; sh[b] = n
        d = np.zeros((n, n), dtype=np.int64); np.fill_diagonal(d, 1)
        T = T * d.reshape(sh)
    return T

# ---------- exact linear algebra over Q ----------

def rref(rows):
    """rows: list of lists of Fraction.  returns (rank, rref rows, pivot cols)."""
    A = [r[:] for r in rows]; m = len(A); nc = len(A[0]) if m else 0
    piv = []; r = 0
    for c in range(nc):
        pr = next((i for i in range(r, m) if A[i][c] != 0), None)
        if pr is None: continue
        A[r], A[pr] = A[pr], A[r]
        inv = Fr(1, 1)/A[r][c]
        A[r] = [x*inv for x in A[r]]
        for i in range(m):
            if i != r and A[i][c] != 0:
                f = A[i][c]
                A[i] = [x - f*y for x, y in zip(A[i], A[r])]
        piv.append(c); r += 1
        if r == m: break
    return r, A, piv

def nullspace(rows):
    m = len(rows); nc = len(rows[0])
    r, A, piv = rref(rows)
    free = [c for c in range(nc) if c not in piv]
    basis = []
    for f in free:
        v = [Fr(0)]*nc; v[f] = Fr(1)
        for i, c in enumerate(piv):
            v[c] = -A[i][f]
        basis.append(v)
    return basis

def rank_mod_p(A, p):
    A = A.astype(np.int64) % p
    m, nc = A.shape; r = 0
    for c in range(nc):
        pr = None
        for i in range(r, m):
            if A[i, c] % p: pr = i; break
        if pr is None: continue
        A[[r, pr]] = A[[pr, r]]
        A[r] = (A[r] * pow(int(A[r, c]), p-2, p)) % p
        col = A[:, c].copy(); col[r] = 0
        A = (A - np.outer(col, A[r])) % p
        r += 1
        if r == m: break
    return r

# ---------- 1a: the Frobenius identity ----------

print("=" * 72)
print("1a  <T_M, T_M'> == n^{cycles(M u M')} ?   exact integer check")
print("=" * 72)
for k in (2, 3, 4):
    Ms = list(matchings(tuple(range(2*k))))
    for n in (2, 3, 4, 5)[:4 if k < 4 else 3]:
        flat = np.array([tensor(M, n, k).ravel() for M in Ms], dtype=np.int64)
        G = flat @ flat.T
        C = np.array([[n**n_cycles(A, B, k) for B in Ms] for A in Ms], dtype=np.int64)
        ok = np.array_equal(G, C)
        print(f"  {len(Ms):>3} matchings on {2*k} legs, n={n}: "
              f"Frobenius == n^cycles  {ok}   "
              f"(entries {G.min()}..{G.max()})")
        assert ok, "THE FROBENIUS IDENTITY FAILS"

# COVARIANTS.  A diagram with f free legs is a map into (R^n)^{tensor f}, i.e.
# an element of (R^n)^{tensor (2k+f)}: the free legs are matched to f OUTPUT
# slots.  So the covariant case is the matching case on 2k+f legs, and the same
# identity must hold on the sub-family where every output slot is matched to an
# input slot.  (A first version of this check modelled a free leg as an
# unconstrained slot, i.e. tensored with all-ones -- that is a different tensor
# and it is my error, not the record's.)
print("\n  covariant case: 8 input legs + 2 OUTPUT legs, output matched to input")
k = 5   # 10 legs = 8 input + 2 output
COV = [M for M in matchings(tuple(range(10)))
       if not any({a, b} <= {8, 9} for a, b in M)]
COV = COV[:60]
for n in (2, 3, 4):
    flat = np.array([tensor(M, n, k).ravel() for M in COV], dtype=np.int64)
    G = flat @ flat.T
    C = np.array([[n**n_cycles(A, B, k) for B in COV] for A in COV], dtype=np.int64)
    print(f"    {len(COV)} degree-2 covariant diagrams, n={n}: "
          f"Frobenius == n^cycles  {np.array_equal(G, C)}")
    assert np.array_equal(G, C), "THE FROBENIUS IDENTITY FAILS FOR COVARIANTS"

# ---------- 1b: rank equality and the certificate ----------

print("\n" + "=" * 72)
print("1b  rank(Gram) == rank(diagram tensors) over Q, and what it certifies")
print("=" * 72)
k = 4
Ms = list(matchings(tuple(range(2*k))))
print(f"  {len(Ms)} matchings on 8 legs (degree-2 diagrams)")
for n in (2, 3, 4, 5):
    C = [[Fr(n**n_cycles(A, B, k)) for B in Ms] for A in Ms]
    rG, _, _ = rref(C)
    ker = nullspace(C)
    # exact verification: does every Gram kernel vector kill the TENSORS?
    flat = np.array([tensor(M, n, k).ravel() for M in Ms], dtype=np.int64)
    worst = 0
    for v in ker:
        den = 1
        for x in v: den = den*x.denominator//np.gcd(den, x.denominator)
        vi = np.array([int(x*den) for x in v], dtype=object)
        comb = sum(int(c)*flat[i] for i, c in enumerate(vi) if c)
        worst = max(worst, int(np.abs(comb).max()) if np.ndim(comb) else 0)
    rT_lo = max(rank_mod_p(flat.copy(), p) for p in (10007, 100003))
    dw = n*(n+1)*(n+2)*(n-3)//12 if n >= 3 else 0
    print(f"  n={n}: rank(Gram)={rG:>3}  nullity={len(ker):>2}  "
          f"| max |sum v_M T_M| over kernel = {worst}  "
          f"| rank(tensors) >= {rT_lo}  | dim Weyl_n = {max(dw,0)}")
    assert worst == 0, "A GRAM KERNEL VECTOR DOES NOT KILL THE TENSORS"
    assert rT_lo <= rG, "rank(tensors) exceeded rank(Gram) -- identity broken"

# ---------- how much does the certificate actually see? ----------

print("\n" + "=" * 72)
print("what the certificate SEES vs what is THERE (functions on Weyl_n)")
print("=" * 72)

def weyl_random(n, rng):
    R = rng.standard_normal((n, n, n, n))
    R = 0.25*(R - R.transpose(1,0,2,3) - R.transpose(0,1,3,2) + R.transpose(1,0,3,2))
    R = 0.5*(R + R.transpose(2,3,0,1))
    R = R - (R + R.transpose(0,2,3,1) + R.transpose(0,3,1,2))/3.0
    g = np.eye(n)
    Ric = np.einsum('ikjk->ij', R); sc = np.trace(Ric); E = Ric - sc/n*g
    def KN(A,B): return (np.einsum('ik,jl->ijkl',A,B)+np.einsum('jl,ik->ijkl',A,B)
                         -np.einsum('il,jk->ijkl',A,B)-np.einsum('jk,il->ijkl',A,B))
    W = R - KN(E,g)/(n-2) - sc/(2*n*(n-1))*KN(g,g)
    return 0.5*(W + W.transpose(2,3,0,1))

rng = np.random.default_rng(251)
LET = "abcdefgh"

def diagram_value(M, W):
    """<T_M, W (x) W> by einsum -- no n^8 array is ever built."""
    lab = [None]*8
    nxt = 0
    for a, b in M:
        lab[a] = lab[b] = LET[nxt]; nxt += 1
    return float(np.einsum("".join(lab[:4]) + "," + "".join(lab[4:]) + "->", W, W))

for n in (4, 5, 6):
    C = [[Fr(n**n_cycles(A, B, k)) for B in Ms] for A in Ms]
    rG, _, _ = rref(C)
    V = np.array([[diagram_value(M, W) for M in Ms]
                  for W in (weyl_random(n, rng) for _ in range(30))])
    rF = np.linalg.matrix_rank(V, tol=1e-8*max(1.0, np.abs(V).max()))
    dw = n*(n+1)*(n+2)*(n-3)//12
    print(f"  n={n}: dim Weyl_n={dw:>4}  rank(Gram)={rG:>4} -> certifies "
          f"{len(Ms)-rG:>3} relations;  ACTUAL rank of the 105 functions on "
          f"Weyl_n = {rF}, i.e. {len(Ms)-rF} relations")

# ---------- the certificate is empty where the programme needs it ----------

print("\n" + "=" * 72)
print("when is the projector-free Gram deficient at all?  (matchings on 2k legs)")
print("=" * 72)
for k in (2, 3, 4, 5):
    Ms_ = list(matchings(tuple(range(2*k))))
    row = []
    for n in range(1, 7):
        C = np.array([[n**n_cycles(A, B, k) for B in Ms_] for A in Ms_], dtype=np.int64)
        r = rank_mod_p(C % 100003, 100003)
        row.append((n, r))
    print(f"  2k={2*k:>2} legs, {len(Ms_):>4} matchings:  " +
          "  ".join(f"n={n}:{r}" for n, r in row) +
          f"   -> full rank from n = {min(n for n, r in row if r == len(Ms_))}")

print("\n  the pattern is the classical one: the matchings on 2k legs are")
print("  INDEPENDENT exactly when n >= k.  Degree-3 covariants have 12 legs,")
print("  k = 6, and the programme needs n = 12 >= 6: the Gram is NONSINGULAR")
print("  there, so the dependence certificate CANNOT FIRE at n = 12.")

# direct spot check at 12 legs, n = 12, on a random subset
k = 6
allM = list(itertools.islice(matchings(tuple(range(2*k))), 10395))
sub = [allM[i] for i in np.random.default_rng(7).choice(len(allM), 900, replace=False)]
C = np.array([[12**n_cycles(A, B, k) % 100003 for B in sub] for A in sub], dtype=np.int64)
r = rank_mod_p(C.copy(), 100003)
print(f"\n  spot check: 900 random matchings on 12 legs at n=12, Gram rank mod p "
      f"= {r} of 900 -> {'FULL, no certificate' if r == 900 else 'DEFICIENT'}")

# ---------- soundness is over R only ----------
print("\n" + "=" * 72)
print("the certificate needs R (or char 0): mod p it certifies nothing")
print("=" * 72)
k = 4; Ms_ = list(matchings(tuple(range(2*k))))
for (n, p) in ((4, 2), (3, 3), (6, 3), (12, 2)):
    C = np.array([[pow(n, n_cycles(A, B, k), p) for B in Ms_] for A in Ms_], dtype=np.int64)
    rGp = rank_mod_p(C.copy(), p)
    nn = min(n, 5)
    flat = np.array([tensor(M, nn, k).ravel() % p for M in Ms_], dtype=np.int64)
    rTp = rank_mod_p(flat.copy(), p)
    print(f"  n={n:>2}, p={p}: rank(Gram mod p) = {rGp:>3}, but rank of the same "
          f"105 tensors mod p (at n={nn}) = {rTp:>3}")
print("  -> over F_p a deficient Gram does NOT certify dependence.  The record")
print("     scopes the rank equality 'over R'; the sibling file run_n5_diagram_gram.py")
print("     computes mod 10007, where the certificate is void.")
print("\nDONE")
