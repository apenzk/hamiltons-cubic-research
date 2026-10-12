"""r263 CLAIM 5 -- the FFT attribution, and whether the rank certificate is circular.

run_diagram_realisation.py prints:
    "the upper bound comes from the identity dim nu = sum m_lambda(n)^2, asserted
     per cell below"
and then asserts got == uni at every cell.  Read literally that is circular: the
identity is the conclusion, so it cannot also be the premise supplying the upper
bound.  What is actually available for free is the CONTAINMENT

    nu(B_f(n))  subset  End_{O(n)}(V^{tensor f}),      dim End = sum_lambda m_lambda(n)^2,

the first by every nu(D) being O(n)-equivariant (no FFT needed), the second by
Schur plus complete reducibility.  That is an INEQUALITY, dim nu <= sum m^2, and
it is what turns a modular lower bound attaining sum m^2 into a proof.

This file separates the three quantities and computes each one its own way:
  (A) dim nu(B_f(n))          -- rank of the span of the ACTUAL operators nu(D)
                                 (no Gram matrix, no n^{loops} formula);
  (B) dim End_{O(n)}(V^{f})   -- dim Inv_{O(n)}(V^{tensor 2f}), from the so(n)
                                 GENERATORS and the reflection diag(-1,1,...,1);
                                 no diagram appears;
  (C) sum_lambda m_lambda(n)^2 -- the restricted up-down count.
(B) = (C) is Schur.  (A) <= (B) is the containment.  (A) = (B) is Weyl's FFT for
O(n), and the question is whether it holds at EVERY n or only above a threshold.
"""
import numpy as np
from itertools import combinations

def matchings(pts):
    if not pts:
        yield ()
        return
    a, rest = pts[0], pts[1:]
    for i, b in enumerate(rest):
        for m in matchings(rest[:i] + rest[i+1:]):
            yield ((a, b),) + m

def nu_ops(f, n):
    dim = n ** f
    idx = [tuple((k // n**(f-1-p)) % n for p in range(f)) for k in range(dim)]
    out = []
    for D in matchings(tuple(range(2*f))):
        M = np.zeros((dim, dim))
        for r, j in enumerate(idx):
            for c, i in enumerate(idx):
                lab = j + i
                if all(lab[a] == lab[b] for a, b in D):
                    M[r, c] = 1.0
        out.append(M.reshape(-1))
    return np.array(out)

def so_gens(n):
    G = []
    for a, b in combinations(range(n), 2):
        X = np.zeros((n, n)); X[a, b] = 1.0; X[b, a] = -1.0
        G.append(X)
    return G

def inv_dim(m, n):
    """dim Inv_{O(n)}(V^{tensor m}), from generators only -- no diagram, no Brauer."""
    dim = n ** m
    rows = []
    for X in so_gens(n):
        A = np.zeros((dim, dim))
        for leg in range(m):
            blk = np.eye(1)
            for t in range(m):
                blk = np.kron(blk, X if t == leg else np.eye(n))
            A += blk
        rows.append(A)
    R = np.eye(n); R[0, 0] = -1.0
    Rm = np.eye(1)
    for _ in range(m):
        Rm = np.kron(Rm, R)
    rows.append(Rm - np.eye(dim))
    M = np.vstack(rows)
    return dim - np.linalg.matrix_rank(M, tol=1e-8)

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

print("  (A) dim nu(B_f(n))  from the operators themselves")
print("  (B) dim End_{O(n)}(V^f) = dim Inv_{O(n)}(V^{2f})  from so(n) generators + a reflection")
print("  (C) sum_lambda m_lambda(n)^2  from the restricted up-down recursion\n")
print(f"  {'f':>2} {'n':>2} {'n>=f-1':>7} {'(A) dim nu':>11} {'(B) dim End':>12} "
      f"{'(C) sum m^2':>12}   A<=B   B=C(Schur)   A=B(FFT)")
cells = [(2,2),(2,3),(2,4),(2,5),(2,6),(3,2),(3,3),(4,2),(5,2)]
bad = []
for f, n in cells:
    A = np.linalg.matrix_rank(nu_ops(f, n), tol=1e-8)
    B = inv_dim(2*f, n)
    C = sum(c*c for c in restricted_updown(f, n).values())
    ss = n >= f - 1
    print(f"  {f:>2} {n:>2} {str(ss):>7} {A:>11} {B:>12} {C:>12}   "
          f"{str(A <= B):>5}   {str(B == C):>10}   {str(A == B):>7}")
    if not (A <= B and B == C):
        bad.append((f, n, A, B, C))
print()
print("  A <= B is the CONTAINMENT and needs no FFT -- it is the upper bound the")
print("  reviewed script should be citing.  B = C is Schur.  A = B is Weyl's FFT,")
print("  and it holds at every cell here INCLUDING the sub-threshold (4,2) and (5,2),")
print("  so surjectivity carries no condition on n.")
assert not bad, bad

# the SO(n) contrast: the same statement is FALSE for SO(n)
print("\n  The same three numbers for SO(n) at (f,n) = (2,4), where the FFT acquires")
print("  the epsilon tensor and the diagram image is a PROPER subalgebra:")
def inv_dim_so(m, n):
    dim = n ** m
    rows = []
    for X in so_gens(n):
        A = np.zeros((dim, dim))
        for leg in range(m):
            blk = np.eye(1)
            for t in range(m):
                blk = np.kron(blk, X if t == leg else np.eye(n))
            A += blk
        rows.append(A)
    return dim - np.linalg.matrix_rank(np.vstack(rows), tol=1e-8)
for f, n in ((2, 4),):
    A = np.linalg.matrix_rank(nu_ops(f, n), tol=1e-8)
    print(f"    (f,n) = ({f},{n}):  dim nu = {A},  dim End_O = {inv_dim(2*f, n)},"
          f"  dim End_SO = {inv_dim_so(2*f, n)}")
print("    -- the O and SO numbers differ, which is why the group matters and why")
print("       ASWT's SO statement could not have carried this step.")
