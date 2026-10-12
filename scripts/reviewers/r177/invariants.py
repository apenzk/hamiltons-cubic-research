#!/usr/bin/env python3
"""r177 claim 3: dim (Sym^d Weyl_5)^{O(5)} for d=2..6, from weight multiplicities.
h_d = (1/d) sum_{k=1..d} p_k h_{d-k};  trivial multiplicity = sum_w eps(w) m(rho - w rho)."""
import json, itertools
from collections import defaultdict
from fractions import Fraction as F
here = "scripts/reviewers/r177/"
wm = {tuple(int(x) for x in k.split(",")): int(v) for k, v in json.load(open(here+"wm_B2.json")).items()}
r = 2
def scale(d,k): return {tuple(k*x for x in w): m for w,m in d.items()}
def mul(a,b):
    o = defaultdict(F)
    for wa,ma in a.items():
        for wb,mb in b.items(): o[tuple(x+y for x,y in zip(wa,wb))] += ma*mb
    return o
def addto(a,b,c):
    for w,m in b.items(): a[w] += c*m
P = {k: scale(wm,k) for k in range(1,8)}
H = {0: {(0,)*r: F(1)}}
for d in range(1,7):
    acc = defaultdict(F)
    for k in range(1,d+1):
        addto(acc, mul(P[k], H[d-k]), F(1,d))
    H[d] = {w:m for w,m in acc.items() if m != 0}
# Weyl group B2
W=[]
for p in itertools.permutations(range(r)):
    psign = -1 if p==(1,0) else 1
    for bits in range(1<<r):
        fl = tuple((-1)**((bits>>i)&1) for i in range(r))
        nneg = sum(1 for f in fl if f<0)
        W.append((p,fl,psign*(-1)**nneg))
two_rho=(3,1)
def act(w,v):
    p,fl,_=w; o=[0]*r
    for i in range(r): o[p[i]] = fl[p[i]]*v[i]
    return tuple(o)
shifts=[]
for w in W:
    d = tuple((a-b)//2 for a,b in zip(two_rho, act(w,two_rho)))
    shifts.append((d, w[2]))
print("d   dim Sym^d(Weyl_5)   dim of O(5)-invariants")
for d in range(1,7):
    tot = sum(H[d].values())
    inv = sum(e*H[d].get(sh,F(0)) for sh,e in shifts)
    assert tot.denominator==1 and inv.denominator==1
    print("%d   %-18d %d" % (d, tot, inv))
