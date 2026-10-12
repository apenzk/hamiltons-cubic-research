"""r276 Claim 6: validate the r261/r262 ledger entry -- "ASWT 3.17(b) is type-B_m,
so the FFT citation fails at n=12" -- and the record's rescue, "it survives because
this programme's group is O(n), not SO(n)".

Decisive small case, computed from scratch: on V^{otimes 4} with V = R^4,
  dim Inv_{O(4)}  = # Brauer pairings of 4 points = 3
  dim Inv_{SO(4)} = 4,   the extra one being the volume form epsilon.
Invariants are computed as the kernel of the so(n) derivation action (SO is connected),
then intersected with the +1 eigenspace of one reflection to get O.
"""
import numpy as np, itertools


def inv_dims(n, k):
    d = n**k
    # so(n) generators acting by derivations on V^{otimes k}
    gens = []
    for i, j in itertools.combinations(range(n), 2):
        A = np.zeros((n, n)); A[i, j] = 1.0; A[j, i] = -1.0
        gens.append(A)
    rows = []
    for A in gens:
        Op = np.zeros((d, d))
        for slot in range(k):
            f = [np.eye(n)] * k; f[slot] = A
            T = f[0]
            for s in range(1, k):
                T = np.kron(T, f[s])
            Op += T
        rows.append(Op)
    Stack = np.vstack(rows)
    dim_so = d - np.linalg.matrix_rank(Stack, tol=1e-8)
    # O(n) = SO(n) + one reflection
    Rm = np.eye(n); Rm[0, 0] = -1.0
    T = Rm
    for s in range(1, k):
        T = np.kron(T, Rm)
    Stack2 = np.vstack([Stack, T - np.eye(d)])
    dim_o = d - np.linalg.matrix_rank(Stack2, tol=1e-8)
    return dim_so, dim_o


def brauer_span(n, k):
    """rank of the span of the pairing invariants delta_{..}delta_{..} in V^{ot k}."""
    idx = list(range(k)); vecs = []
    def pairings(rem):
        if not rem: yield []; return
        a = rem[0]
        for b in rem[1:]:
            for rest in pairings([x for x in rem[1:] if x != b]):
                yield [(a, b)] + rest
    for P in pairings(idx):
        T = np.zeros([n]*k)
        for multi in itertools.product(range(n), repeat=k):
            v = 1.0
            for (a, b) in P:
                if multi[a] != multi[b]: v = 0.0; break
            T[multi] = v
        vecs.append(T.ravel())
    A = np.array(vecs)
    return len(vecs), np.linalg.matrix_rank(A, tol=1e-8)


for (n, k) in ((4, 4), (3, 4), (5, 4), (4, 2), (2, 2)):
    ds, do = inv_dims(n, k)
    nd, rk = brauer_span(n, k)
    print(f"n={n} legs={k}:  dim Inv_SO = {ds:3d}   dim Inv_O = {do:3d}   "
          f"Brauer diagrams {nd} spanning rank {rk}   "
          f"{'SO > O  (epsilon present)' if ds > do else 'SO = O'}")

# the epsilon of SO(4) is exactly the missing direction
n, k = 4, 4
eps = np.zeros([n]*k)
for p in itertools.permutations(range(n)):
    s = 1
    pl = list(p)
    for i in range(n):
        for j in range(i+1, n):
            if pl[i] > pl[j]: s = -s
    eps[p] = s
nd, rk = brauer_span(4, 4)
def pair_vecs():
    out = []
    for P in ([(0,1),(2,3)], [(0,2),(1,3)], [(0,3),(1,2)]):
        T = np.zeros([4]*4)
        for m in itertools.product(range(4), repeat=4):
            v = 1.0
            for (a, b) in P:
                if m[a] != m[b]: v = 0.0; break
            T[m] = v
        out.append(T.ravel())
    return np.array(out)
A = pair_vecs()
print(f"\nrank(Brauer) = {np.linalg.matrix_rank(A):d}, "
      f"rank(Brauer + epsilon) = {np.linalg.matrix_rank(np.vstack([A, eps.ravel()])):d}"
      f"   -> epsilon is OUTSIDE the diagram span, and is SO(4)- but not O(4)-invariant.")
print("\nAt n=12 the same mechanism sits on exactly 12 legs: epsilon_{i1...i12} is")
print("SO(12)-invariant, is not O(12)-invariant, hence is not in the span of the")
print("10395 Brauer diagrams -- so Brauer -> End_{SO(12)}(V^{ot 12}) is NOT surjective,")
print("while Brauer -> End_{O(12)} still is.")
