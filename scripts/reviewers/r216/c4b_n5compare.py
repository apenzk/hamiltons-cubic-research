"""r216, claim 4b, part 3.  The n=5 side of the comparison the commit makes.

`largest 234` at n=5 against `635,220` at n=12 is an ABSOLUTE comparison of a
quantity whose whole purpose is RELATIVE: the highest-weight route exists to
avoid touching Sym^3, so what it buys is the ratio dim Sym^3 / (largest weight
space).  This file computes the n=5 column of that table with the same
Littlewood + Jacobi-Trudi machinery used at n=12, so both sides are derived, not
quoted.
"""
from collections import defaultdict
from itertools import combinations_with_replacement as cwr
from math import comb

def table(N):
    R = N // 2
    X = []
    for i in range(R):
        for s in (1, -1):
            v = [0]*R; v[i] = s; X.append(tuple(v))
    if N % 2: X.append(tuple([0]*R))          # B_r has the zero weight in C^N
    assert len(X) == N
    def h(k):
        d = defaultdict(int)
        for c in cwr(X, k): d[tuple(sum(t) for t in zip(*c))] += 1
        return dict(d)
    def mul(P, Q):
        d = defaultdict(int)
        for a, ca in P.items():
            for b, cb in Q.items(): d[tuple(a[t]+b[t] for t in range(R))] += ca*cb
        return {k: v for k, v in d.items() if v}
    def sub(P, Q):
        d = defaultdict(int, P)
        for k, v in Q.items(): d[k] -= v
        return {k: v for k, v in d.items() if v}
    h1, h2, h3 = h(1), h(2), h(3)
    CHI = sub(sub(mul(h2, h2), mul(h3, h1)), h2)          # s_22 - h_2
    dW = sum(CHI.values())
    assert dW == N*(N+1)*(N+2)*(N-3)//12, (N, dW)
    C2 = mul(CHI, CHI)
    P2 = {tuple(2*x for x in k): v for k, v in CHI.items()}
    P3 = {tuple(3*x for x in k): v for k, v in CHI.items()}
    def s3(lam):
        A1 = sum(c*C2.get(tuple(lam[t]-w[t] for t in range(R)), 0) for w, c in CHI.items())
        A2 = sum(c*P2.get(tuple(lam[t]-w[t] for t in range(R)), 0) for w, c in CHI.items())
        return (A1 + 3*A2 + 2*P3.get(lam, 0))//6
    Z = (0,)*R
    return dW, comb(dW+2, 3), s3(Z)

print(f"{'n':>4} {'dim Weyl_n':>11} {'dim Sym^3':>15} {'trivial weight space':>21} {'compression':>12}")
for N in (5, 6, 7, 8, 12):
    dW, dS, z = table(N)
    print(f"{N:>4} {dW:>11,} {dS:>15,} {z:>21,} {dS/z:>11,.0f}x")
print()
print("The commit reads 635,220 against 234 as the route degrading.  By the ratio")
print("the route is built to improve, it improves by a factor of about 35 from")
print("n=5 to n=12.")
