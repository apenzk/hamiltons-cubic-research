"""r211, claim 2: EXACT rank over Q of the lifted rows.

run_n5_lift.py checks only a float64 SVD rank with a 1e-10 relative threshold.
That is a screen, not a check: a wrongly reconstructed entry of height 1e16 sits
far outside the tolerance's reach in one direction and inside it in the other.
Over Q the rank is decidable, so decide it.

A wrong reconstruction anywhere raises the rank generically: the true rows span
13 dimensions, so any perturbation of a single entry pushes the row out of that
span.  Exact rank 13, and exact consistency rank([A|F_5]) = 13, is therefore a
real falsification test for the lift.
"""
import os, pickle
from fractions import Fraction as Fr

here = os.path.dirname(os.path.abspath(__file__))
L = pickle.load(open(os.path.join(here, "lifted.pkl"), "rb"))
A, B = L["A"], L["B"]
NR, NC = len(A), len(A[0])

def rank_Q(M):
    M = [row[:] for row in M]
    r = 0
    for c in range(len(M[0])):
        p = next((i for i in range(r, len(M)) if M[i][c]), None)
        if p is None: continue
        M[r], M[p] = M[p], M[r]
        pv = M[r][c]
        M[r] = [x / pv for x in M[r]]
        for i in range(len(M)):
            if i != r and M[i][c]:
                f = M[i][c]
                M[i] = [x - f*y for x, y in zip(M[i], M[r])]
        r += 1
        if r == len(M): break
    return r

rk = rank_Q(A)
print(f"exact rank over Q of the lifted 40 x 47 rows: {rk}   (claimed 13)")
AUG = [A[i] + [B[i]] for i in range(NR)]
rka = rank_Q(AUG)
print(f"exact rank over Q of [A | F_5]:               {rka}")
print(f"CONSISTENT over Q: {rk == rka}")
print(f"affine family dimension: 47 - {rk} = {NC - rk}")

# perturbation control: change one entry by 1 and confirm the rank does move,
# so that "rank 13" is a test with teeth rather than a rank that cannot rise.
import copy
Ap = copy.deepcopy(A)
Ap[0][0] = Ap[0][0] + 1
print(f"\ncontrol: rank after adding 1 to entry (0,0): {rank_Q(Ap)}"
      "   (rises, so the test can fail)")
# and a control that mimics a mis-reconstruction: replace one entry by a small
# rational of the kind ratrec would emit if 123 bits were too few.
Ap2 = copy.deepcopy(A)
Ap2[3][5] = Fr(7, 13)
print(f"control: rank after one entry -> 7/13:        {rank_Q(Ap2)}")
