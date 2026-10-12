"""R41: the U(m)-decomposition of Weyl_{2m} from characters alone -- no
structure constants, no Weyl basis, no linear algebra at all.

   char(Weyl_{2m}) = char(S^2(Lambda^2 V)) - char(Lambda^4 V) - char(S^2 V)

using S^2(Lambda^2 V) = S^{(2,2)}V + Lambda^4 V (GL) and R(V) = Weyl + S^2 V
(O(n)).  V_C has weights {+-eps_i}.  The resulting weight multiset is fed to the
same Racah formula, giving an independent confirmation of the decomposition and
of the zero-weight multiplicity (= dim of the invariants of the maximal torus,
which is the object C1 warns about).
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, itertools, time
from collections import Counter
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r41_weights import racah, gl_dim, fmt


def weights_V(m):
    w = []
    for i in range(m):
        e = [0] * m
        e[i] = 1
        w.append(tuple(e))
        e = [0] * m
        e[i] = -1
        w.append(tuple(e))
    return w


def add(a, b):
    return tuple(x + y for x, y in zip(a, b))


def run(m):
    t0 = time.time()
    V = weights_V(m)
    L2 = [add(V[a], V[b]) for a in range(len(V)) for b in range(a + 1, len(V))]
    c = Counter()
    for a in range(len(L2)):
        for b in range(a, len(L2)):
            c[add(L2[a], L2[b])] += 1
    for q in itertools.combinations(range(len(V)), 4):
        c[add(add(V[q[0]], V[q[1]]), add(V[q[2]], V[q[3]]))] -= 1
    for a in range(len(V)):
        for b in range(a, len(V)):
            c[add(V[a], V[b])] -= 1
    c = Counter({k: v for k, v in c.items() if v})
    D = sum(c.values())
    Dpred = m * (m + 1) * (2 * m + 1) * (2 * m - 3) // 3
    zero = c.get(tuple([0] * m), 0)
    print(f"m={m:2d}: dim from character = {D} (formula {Dpred})  "
          f"zero-weight mult = {zero}   m(m-1) = {m*(m-1)}  "
          f"[{time.time()-t0:.1f}s]")
    assert D == Dpred and min(c.values()) > 0
    dec = racah(c, m)
    tot = sum(dec[l] * gl_dim(l) for l in dec)
    print(f"      summands: {len(dec)}   multiplicity-free: "
          f"{all(v == 1 for v in dec.values())}   sum dim = {tot}")
    for l in sorted(dec, reverse=True):
        print(f"        {fmt(l):26s} x{dec[l]}  dim {gl_dim(l)}")


if __name__ == '__main__':
    for m in range(int(sys.argv[1]), int(sys.argv[2]) + 1):
        run(m)
