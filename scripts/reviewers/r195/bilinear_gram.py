"""r195: the same question under the invariant BILINEAR form.

The weight-orthogonality that makes Q block-diagonal is a statement about the
HERMITIAN Gram H_ab = sum_ijkl T_a T_b-bar.  Under the invariant BILINEAR Gram
B_ab = sum_ijkl T_a T_b -- no conjugate -- the pairing is between mu and -mu, so
the same word basis gives a block-ANTI-diagonal matrix.  Built here from the
same cached tensors, with NO weight filter, so both statements are measured
rather than assumed.
"""
import sys, os, json, pickle
from fractions import Fraction as Fr
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import common195 as K

SC = K.SCRATCH
p = os.path.join(SC, "r195_B.pkl")
if os.path.exists(p):
    B = pickle.load(open(p, "rb"))
else:
    T = [[K.gq(K.C["wbasis_tensors"][a][i][j][k][l])
          for i in range(5) for j in range(5) for k in range(5) for l in range(5)]
         for a in range(35)]
    B = {}
    for a in range(35):
        for b in range(35):
            re = im = Fr(0)
            for x, y in zip(T[a], T[b]):
                if (x[0] or x[1]) and (y[0] or y[1]):
                    re += x[0]*y[0] - x[1]*y[1]
                    im += x[0]*y[1] + x[1]*y[0]
            if (re, im) != K.ZC: B[(a, b)] = (re, im)
    pickle.dump(B, open(p, "wb"))

def tab(M, name):
    eq0  = sum(1 for (a, b) in M if K.WT[a] == K.WT[b] == (0, 0))
    eqn  = sum(1 for (a, b) in M if K.WT[a] == K.WT[b] != (0, 0))
    anti = sum(1 for (a, b) in M
               if K.WT[b] == (-K.WT[a][0], -K.WT[a][1]) and K.WT[a] != (0, 0))
    print(f"{name}: {len(M)} nonzero of 1225 -- on mu=0: {eq0}; equal weights "
          f"mu!=0: {eqn}; (mu,-mu) mu!=0: {anti}; anything else: "
          f"{len(M)-eq0-eqn-anti}")

tab(K.HFULL, "HERMITIAN Gram H")
tab(B,       "BILINEAR  Gram B")
print("\nSo 'vectors of different weight are orthogonal' is a property of the")
print("CONJUGATION, not of the weight grading: the invariant bilinear form on the")
print("same basis is supported exactly on the pairs (mu, -mu).")
