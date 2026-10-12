"""T1/T2 with the cache's index convention made explicit.

n5_hw_cache.json stores E1C[j][k] = coefficient of weight-basis vector k in
E1(weight-basis vector j) -- i.e. the TRANSPOSE of the matrix acting on column
vectors.  raise_mono / raise_vec both read it that way.  Transposing first, the
Serre relations and the kernel counts are stated in the ordinary convention.
"""
from fractions import Fraction as F
import json
C = json.load(open("scripts/runs/n5_hw_cache.json"))
WWT = [tuple(w) for w in C["weights"]]

class G:
    __slots__ = ("r", "i")
    def __init__(s, r=0, i=0): s.r = F(r); s.i = F(i)
    def __add__(s, o): o = mk(o); return G(s.r+o.r, s.i+o.i)
    def __sub__(s, o): o = mk(o); return G(s.r-o.r, s.i-o.i)
    def __mul__(s, o): o = mk(o); return G(s.r*o.r-s.i*o.i, s.r*o.i+s.i*o.r)
    def __truediv__(s, o):
        o = mk(o); d = o.r*o.r+o.i*o.i
        return G((s.r*o.r+s.i*o.i)/d, (s.i*o.r-s.r*o.i)/d)
    __rmul__ = __mul__
    def __bool__(s): return bool(s.r) or bool(s.i)
    def __repr__(s): return f"({s.r}{'+' if s.i>=0 else '-'}{abs(s.i)}i)"
def mk(x): return x if isinstance(x, G) else G(x)
def fj(p): return G(F(p[0][0], p[0][1]), F(p[1][0], p[1][1]))
Z, ONE = G(0), G(1)

# transpose on load: E[out][in]
E1 = [[fj(C["E1C"][j][k]) for j in range(35)] for k in range(35)]
E2 = [[fj(C["E2C"][j][k]) for j in range(35)] for k in range(35)]

def shifts(E, a):
    return all(not E[o][i] or (WWT[o][0] == WWT[i][0]+a[0] and WWT[o][1] == WWT[i][1]+a[1])
               for o in range(35) for i in range(35))
print(f"E1 raises the weight by alpha1 = (1,-1): {shifts(E1, (1,-1))}")
print(f"E2 raises the weight by alpha2 = (0, 1): {shifts(E2, (0, 1))}")

def mm(A, B):
    return [[sum((A[i][k]*B[k][j] for k in range(35) if A[i][k]), Z) for j in range(35)]
            for i in range(35)]
def msub(A, B): return [[a-b for a, b in zip(x, y)] for x, y in zip(A, B)]
def nz(A): return any(any(r) for r in A)
def br(A, B): return msub(mm(A, B), mm(B, A))

E12, = [br(E1, E2)]
E212 = br(E2, E12)
print(f"\nSerre (ad E1)^2 E2 = 0: {not nz(br(E1, E12))}")
print(f"Serre (ad E2)^3 E1 = 0: {not nz(br(E2, E212))}")
print(f"[E1,E2] != 0: {nz(E12)},  [E2,[E2,E1]] != 0: {nz(E212)},  "
      f"[E1,[E2,[E2,E1]]] = 0: {not nz(br(E1, E212))}")
print("  -> E1,E2 generate a 4-dimensional nilpotent algebra, one element per")
print("     positive root of B2.  A mis-built pair fails these.")

def rank(rows, n):
    M = [r[:] for r in rows]; r = 0
    for c in range(n):
        p = next((k for k in range(r, len(M)) if M[k][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        inv = ONE/M[r][c]; M[r] = [x*inv for x in M[r]]
        for k in range(len(M)):
            if k != r and M[k][c]:
                f = M[k][c]; M[k] = [x - f*y for x, y in zip(M[k], M[r])]
        r += 1
        if r == len(M): break
    return r

kh = 35 - rank(E1 + E2, 35)
kl = 35 - rank([[E1[i][j] for i in range(35)] for j in range(35)]
             + [[E2[i][j] for i in range(35)] for j in range(35)], 35)
print(f"\ndim ker(E1) ^ ker(E2) on Weyl_5 (highest-weight lines) = {kh}")
print(f"codim (im E1 + im E2) on Weyl_5 (lowest-weight lines)  = {kl}")
print(f"  both 1 => Weyl_5 is the irreducible V_(2,2): {kh == 1 == kl}")




