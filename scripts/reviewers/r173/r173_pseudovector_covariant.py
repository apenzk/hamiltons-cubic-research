"""Reviewer 173 -- the cubic pseudo-vector covariant of Weyl_5, exhibited explicitly.

RUN:  python3 scripts/reviewers/r173/r173_pseudovector_covariant.py

Character theory (two independent routes, r173_n5_blocks.sage) says Sym^3(Weyl_5)
carries the 5-dimensional block with multiplicity 1.  As an O(5)-module that block is
[1] (x) det = Lambda^4 R^5, NOT the vector [1]: -Id acts trivially on Weyl_5 and hence on
Sym^3, so [1] is excluded by parity but its det-twist is not.

The covariant is exhibited:   T^e = eps^{abcde} W_{ab}{}^{fg} W_{cd}{}^{hi} W_{fghi}.
It is symmetric under exchanging the first two factors (eps picks up an even permutation,
W_{fghi} = W_{hifg}), so it is a cubic form, i.e. an element of Hom(Sym^3 Weyl_5, Lambda^4).

Two evaluations settle the item:
  * on random Weyl tensors T != 0, so the block is genuinely occupied;
  * on the padded W_{CP^2} the orbit constraint applies, and T(W_0) is computed.
"""
import numpy as np

n = 5
rng = np.random.default_rng(20260828)

eps = np.zeros((5,)*5)
from itertools import permutations
def sgn(p):
    s = 1
    p = list(p)
    for i in range(len(p)):
        for j in range(i+1, len(p)):
            if p[i] > p[j]: s = -s
    return s
for p in permutations(range(5)):
    eps[p] = sgn(p)

def weyl_project(R, n):
    Ric = np.einsum('abad->bd', R)
    Sc  = np.trace(Ric)
    g   = np.eye(n)
    KN  = (np.einsum('ac,bd->abcd', g, Ric) - np.einsum('ad,bc->abcd', g, Ric)
         - np.einsum('bc,ad->abcd', g, Ric) + np.einsum('bd,ac->abcd', g, Ric))
    G   = np.einsum('ac,bd->abcd', g, g) - np.einsum('ad,bc->abcd', g, g)
    return R - KN/(n-2) + Sc*G/((n-1)*(n-2))

def random_curvature(n):
    m = n*(n-1)//2
    idx = [(a,b) for a in range(n) for b in range(a+1,n)]
    S = rng.standard_normal((m,m)); S = S + S.T
    R = np.zeros((n,)*4)
    for i,(a,b) in enumerate(idx):
        for j,(c,d) in enumerate(idx):
            v = S[i,j]
            R[a,b,c,d] =  v; R[b,a,c,d] = -v; R[a,b,d,c] = -v; R[b,a,d,c] =  v
    # project onto the first-Bianchi subspace: subtract the total antisymmetrisation
    A = np.zeros((n,)*4)
    for p in permutations(range(4)):
        A += sgn(p)*np.transpose(R, p)
    A /= 24.0
    return R - A

def checks(W, n, tag):
    g = np.eye(n)
    e1 = np.abs(W + np.transpose(W,(1,0,2,3))).max()
    e2 = np.abs(W - np.transpose(W,(2,3,0,1))).max()
    e3 = np.abs(W + np.transpose(W,(0,2,3,1)) + np.transpose(W,(0,3,1,2))).max()
    e4 = np.abs(np.einsum('abad->bd', W)).max()
    print("  %-14s antisym %.1e  pair %.1e  Bianchi %.1e  traceless %.1e  |W| %.4f"
          % (tag, e1, e2, e3, e4, np.sqrt(np.einsum('abcd,abcd->', W, W))))

def T(W):
    return np.einsum('abcde,abfg,cdhi,fghi->e', eps, W, W, W, optimize=True)

print("random Weyl_5 tensors:")
vals = []
for k in range(6):
    W = weyl_project(random_curvature(5), 5)
    checks(W, 5, "random %d" % k)
    t = T(W)
    vals.append(np.abs(t).max())
    print("      T =", np.array2string(t, precision=5))
print("  max|T| over the sample = %.6g" % max(vals))

# ---- the padded CP^2 Weyl tensor -------------------------------------------------
J = np.zeros((4,4)); J[0,1]=-1; J[1,0]=1; J[2,3]=-1; J[3,2]=1
g4 = np.eye(4)
Rcp = (np.einsum('ac,bd->abcd', g4, g4) - np.einsum('ad,bc->abcd', g4, g4)
     + np.einsum('ac,bd->abcd', J, J)   - np.einsum('ad,bc->abcd', J, J)
     + 2*np.einsum('ab,cd->abcd', J, J))
W4 = weyl_project(Rcp, 4)
checks(W4, 4, "CP^2 (n=4)")
W0 = np.zeros((5,)*4); W0[:4,:4,:4,:4] = W4
checks(W0, 5, "CP^2 padded")
W0 = W0/np.sqrt(np.einsum('abcd,abcd->', W0, W0))
t0 = T(W0)
print("      T(W_CP2 padded) =", np.array2string(t0, precision=8))
print("      |T(W_0)| = %.8g" % np.linalg.norm(t0))

# self-duality cross-check: T^5 should be the n=4 pseudo-scalar tr((W^+)^3)-tr((W^-)^3)
idx4 = [(0,1),(0,2),(0,3),(1,2),(1,3),(2,3)]
M = np.array([[W4[a,b,c,d] for (c,d) in idx4] for (a,b) in idx4])
star = np.zeros((6,6))
for i,(a,b) in enumerate(idx4):
    c,d = [x for x in range(4) if x not in (a,b)]
    j = idx4.index((c,d)); s = sgn([a,b,c,d])
    star[j,i] = s
Wop = 2*M                      # W as an operator on Lambda^2 with the usual factor
Pp = (np.eye(6)+star)/2; Pm = (np.eye(6)-star)/2
Wp = Pp@Wop@Pp; Wm = Pm@Wop@Pm
print("      tr((W^+)^3) = %.6f   tr((W^-)^3) = %.6f" % (np.trace(np.linalg.matrix_power(Wp,3)),
                                                          np.trace(np.linalg.matrix_power(Wm,3))))
