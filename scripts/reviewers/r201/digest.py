"""r201, claim 2: does the cache digest separate corrupted caches?
The digest function is lifted VERBATIM from run_n5_adapted.py lines 103-110 and
applied to corrupted copies of the pickle in memory; the file on disk is never
touched."""
import pickle, hashlib, copy, random
from fractions import Fraction as F

class G:                      # stands in for run_n5_adapted's Gaussian rational
    __slots__ = ("r", "i")
    def __init__(s, a, b): s.r, s.i = a, b

raw = pickle.load(open("scripts/runs/n5_adapted.pkl","rb"))
def build(r):
    return {k: [[{i: G(a, b) for i, (a, b) in vec.items()} for vec in copy]
                for copy in cs] for k, cs in r.items()}

def digest(ADAPTED):          # VERBATIM from run_n5_adapted.py
    _h = hashlib.sha256()
    for k in sorted(ADAPTED):
        _h.update(repr(k).encode())
        for cs in ADAPTED[k]:
            for vec in cs:
                _h.update(repr(sorted((i, (v.r, v.i)) for i, v in vec.items())).encode())
    return _h.hexdigest()[:16]

base = build(raw)
D0 = digest(base)
print(f"clean digest {D0}")

def variant(name, f):
    A = build(raw)
    f(A)
    d = digest(A)
    n = sum(len(v) for cs in A.values() for v in cs)
    print(f"  [{name:42s}] digest {d}  changed {d != D0}   count 7770: {n == 7770}")

def bump(A):
    v = A[(6,6)][0][0]; k = sorted(v)[0]; v[k] = G(v[k].r + 1, v[k].i)
variant("C1 +1 on one coefficient, last block", bump)

def signflip(A):
    for k in sorted(A):
        for cs in A[k]:
            for vec in cs:
                for i, v in vec.items():
                    if v.i:
                        vec[i] = G(v.r, -v.i); return
variant("C2 sign flip on one imaginary part", signflip)

variant("C3 two copies swapped, block (2,2)",
        lambda A: A[(2,2)].insert(0, A[(2,2)].pop(1)))
variant("C4 two positions swapped, copy 1 only",
        lambda A: A[(2,0)][1].insert(5, A[(2,0)][1].pop(9)))
def coincide(A): A[(2,0)][1] = [dict(v) for v in A[(2,0)][0]]
variant("C5 copies made coincident, (2,0)", coincide)
def permall(A):
    for i in range(len(A[(2,0)])):
        c = A[(2,0)][i]; A[(2,0)][i] = c[7:] + c[:7]
variant("C6 positions rotated in EVERY copy", permall)
def scale(A):
    for v in A[(3,2)][2]:
        for i, x in list(v.items()): v[i] = G(x.r*2, x.i*2)
variant("C7 one copy scaled by 2", scale)
def lastcopy(A):
    v = A[(4,2)][3][17]; k = sorted(v)[0]; v[k] = G(v[k].r * 3, v[k].i * 3)
variant("C8 one coefficient in the LAST copy of (4,2)", lastcopy)
def zeroit(A):
    v = A[(2,2)][2][30]; k = sorted(v)[0]; v[k] = G(F(0), F(0))
variant("C9 one coefficient zeroed (support size kept)", zeroit)
