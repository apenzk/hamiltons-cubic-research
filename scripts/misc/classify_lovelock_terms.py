"""Classify the 720 terms of the Lovelock contraction delta^{a1..a6}_{b1..b6} W_{a1a2}^{b1b2} W_{a3a4}^{b3b4} W_{a5a6}^{b5b6}.

For each permutation sigma (b = a o sigma), a term whose factor contracts one of its own lower indices with one of its own
upper indices vanishes on a Ricci-flat W. The rest are canonicalised under relabelling, factor order and the eight
pair symmetries of W, with the sign tracked. Exact combinatorics, no floating point. Output: the survivors are the
alpha class (W_abcd W_abef W_cdef) with signed weight 16 and the gamma class (W_abcd W_aecf W_bfde) with -64, the
input to lean/HamiltonsCubic/Results/L50Lovelock.lean's collapse_of_display.
"""
import itertools
from collections import Counter
def sign(p):
    s=1;p=list(p)
    for i in range(len(p)):
        while p[i]!=i:
            j=p[i];p[i],p[j]=p[j],p[i];s=-s
    return s
# term for sigma: factors k=0,1,2: lower (a[2k],a[2k+1]) upper (a[inv[2k]],a[inv[2k+1]])
def factors(sig):
    inv=[0]*6
    for j,v in enumerate(sig): inv[v]=j
    return [((2*k,2*k+1),(inv[2*k],inv[2*k+1])) for k in range(3)]
def owner(i): return i//2
cnt=Counter()
for sig in itertools.permutations(range(6)):
    F=factors(sig)
    self_edge=any(owner(u)==k for k,(lo,up) in enumerate(F) for u in up)
    if self_edge: cnt[('zero',sign(sig))]+=1; continue
    # each factor's upper slots owners
    pat=tuple(tuple(sorted(owner(u) for u in up)) for (lo,up) in F)
    typ='alpha' if all(p[0]==p[1] for p in pat) else 'mixed'
    cnt[(typ,sign(sig))]+=1
print(cnt)

# canonical forms of surviving terms, with sign, under relabelling + factor order + W symmetries
SYM=[((0,1,2,3),1),((1,0,2,3),-1),((0,1,3,2),-1),((1,0,3,2),1),((2,3,0,1),1),((3,2,0,1),-1),((2,3,1,0),-1),((3,2,1,0),1)]
def canon(facs):
    best=None
    for fo in itertools.permutations(range(3)):
        for syms in itertools.product(SYM,repeat=3):
            sg=1; fs=[]
            for f,(perm,s) in zip([facs[i] for i in fo],syms):
                fs.append(tuple(f[p] for p in perm)); sg*=s
            # relabel by first occurrence
            lab={}; out=[]
            for f in fs:
                t=[]
                for x in f:
                    if x not in lab: lab[x]=len(lab)
                    t.append(lab[x])
                out.append(tuple(t))
            key=tuple(out)
            if best is None or key<best[0]: best=(key,sg)
    return best
tot=Counter()
for sig in itertools.permutations(range(6)):
    F=factors(sig)
    if any(owner(u)==k for k,(lo,up) in enumerate(F) for u in up): continue
    facs=[(lo[0],lo[1],up[0],up[1]) for lo,up in F]
    key,sg=canon(facs)
    tot[key]+=sign(sig)*sg
for k,v in tot.items(): print(k,v)
print('alpha canon', canon([(0,1,2,3),(0,1,4,5),(2,3,4,5)]))
print('beta canon', canon([(0,1,2,3),(0,4,2,5),(1,4,3,5)]))
