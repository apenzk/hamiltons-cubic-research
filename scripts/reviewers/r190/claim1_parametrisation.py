"""Claim 1, second bullet: is the Hermitian parametrisation right?

Direct test: pick a random Hermitian G, evaluate sum_ij G_ij P_i conj(P_j) honestly
as a double sum, and compare with row . x for the row the script builds and the
coordinate vector x it implies (G_ii on the diagonal, Re G_ij and Im G_ij off it).
The value must also come out REAL, which is what makes the identification legitimate.
"""
import os, sys
import numpy as np
d = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, d)
from claim2_convention import P, HW2, gmul, gadd, omegas, Pval, WI

BL = sorted(HW2, key=lambda l: (-len(HW2[l]), l))
FLAT = [(lam, k) for lam in BL for k in range(len(HW2[lam]))]
U = [HW2[lam][k] for lam, k in FLAT]
BOFF, off = {}, 0
for lam in BL: BOFF[lam] = off; off += len(HW2[lam])
print(f"{len(U)} covariants, sum m^2 over blocks = {sum(len(HW2[l])**2 for l in BL)}")

rng = np.random.default_rng(5)
G = {}
x = []
pairs = []
for lam in BL:
    m = len(HW2[lam]); o = BOFF[lam]
    for i in range(m):
        a = int(rng.integers(P)); G[(o+i, o+i)] = (a, 0)
        pairs.append((o+i, o+i)); x.append(a)
        for j in range(i+1, m):
            a, b = int(rng.integers(P)), int(rng.integers(P))
            G[(o+i, o+j)] = (a, b); G[(o+j, o+i)] = (a, (-b) % P)
            pairs.append((o+i, o+j)); x += [a, b]

for s in range(3):
    W = WI.random_weyl(5, P, np.random.default_rng(300+s))
    pv = [Pval(u, omegas(W)) for u in U]
    honest = (0, 0)
    for (i, j), g in G.items():
        honest = gadd(honest, gmul(g, gmul(pv[i], (pv[j][0], (-pv[j][1]) % P))))
    row = []
    for (i, j) in pairs:
        z = gmul(pv[i], (pv[j][0], (-pv[j][1]) % P))
        if i == j: row.append(z[0] % P)
        else:      row.append((2*z[0]) % P); row.append((-2*z[1]) % P)
    dot = sum(a*b for a, b in zip(row, x)) % P
    print(f"  sample {s}: honest double sum = {honest}   row.x = {dot}   "
          f"real = {honest[1] == 0}   agree = {honest[0] == dot}")
print(f"  unknowns in the parametrisation: {len(x)}")
