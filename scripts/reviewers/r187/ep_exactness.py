"""Reviewer 187.  run_n5_polarised_diagram.py switched to float64 BLAS mid-review,
on the argument that partial sums stay under 2^53.  Check the switch is exact by
re-running the same contractions in Python-int (object) arithmetic, which cannot
round, and by measuring the largest intermediate that actually occurs."""
import sys, os, random, itertools
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from common import WI, ep

P, K, N = 10007, 6, 5

def ep_object(tensors, matching, p):
    """the same routine with dtype=object -- exact by construction."""
    legs = {}
    for a, b in matching: legs[a] = b; legs[b] = a
    live = [(np.asarray(T).astype(object) % p, [4*v+j for j in range(4)])
            for v, T in enumerate(tensors)]
    biggest = 0
    while True:
        merged = False
        for x in range(len(live)):
            for y in range(x+1, len(live)):
                (A, ia), (B, ib) = live[x], live[y]
                common = [(s, t) for s in ia for t in ib if legs.get(s) == t]
                if not common: continue
                sub = {}; nxt = iter("abcdefghijklmnopqrstuvwxyz")
                for s in ia: sub[s] = next(nxt)
                for t in ib: sub[t] = sub[legs[t]] if legs.get(t) in sub else next(nxt)
                out = [s for s in ia if legs.get(s) not in ib] + \
                      [t for t in ib if legs.get(t) not in ia]
                spec = ("".join(sub[s] for s in ia) + "," +
                        "".join(sub[t] for t in ib) + "->" + "".join(sub[s] for s in out))
                R = np.asarray(np.einsum(spec, A, B), dtype=object)
                biggest = max(biggest, max((int(v) for v in np.ravel(R)), default=0))
                live = [live[z] for z in range(len(live)) if z not in (x, y)]
                live.append((R % p, out)); merged = True; break
            if merged: break
        if not merged: break
    val = 1
    for A, ia in live:
        while ia:
            s = ia[0]; t = legs[s]
            if t not in ia: return None, biggest
            i, j = ia.index(s), ia.index(t)
            A = np.trace(A, axis1=min(i, j), axis2=max(i, j)) % p
            ia = [z for z in ia if z not in (s, t)]
        val = (val * int(A)) % p
    return val % p, biggest

if __name__ == "__main__":
    rng = np.random.default_rng(187); pyrng = random.Random(187)
    E = [WI.random_weyl(N, P, rng) for _ in range(6)]
    ok = tot = 0; worst = 0
    for _ in range(30):
        m = WI.random_matching(K, pyrng)
        seq = [E[i] for i in (pyrng.randrange(6) for _ in range(6))]
        a = ep(seq, m, P)
        b, big = ep_object(seq, m, P)
        worst = max(worst, big)
        ok += (a == b); tot += 1
    print(f"float64 eval_polarised == object-dtype eval_polarised: {ok}/{tot}")
    print(f"largest partial sum actually seen: {worst:.3e}  (2^53 = {2**53:.3e})")
    print(f"headroom: {2**53/max(worst,1):.1f}x")
