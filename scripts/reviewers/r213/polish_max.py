"""r213: is the ascent maximum exactly 1/sqrt(6), or fractionally above it?

Float64 gives F_5/|W|^6 = -8e-15 at the argmax, which is zero to the precision
available and cannot distinguish a sharp bound from a violated one.  This polishes
the maximiser in 60-digit arithmetic by the critical-point equation
P(W^2) = lambda W on the unit sphere, and reports the ratio there.
"""
import numpy as np, mpmath as mp
from itertools import combinations
import importlib.util, os
sp = importlib.util.spec_from_file_location("h", os.path.join(os.path.dirname(os.path.abspath(__file__)), "hunt_f5_negative.py"))
h = importlib.util.module_from_spec(sp); sp.loader.exec_module(h)

mp.mp.dps = 60
BAS = mp.matrix([[mp.mpf(float(x)) for x in r] for r in h.BAS])   # 35 x 625
x = mp.matrix([mp.mpf(float(v)) for v in np.load("scripts/reviewers/r213/argmax.npy")])

def tens(x):
    return [sum(x[i]*BAS[i, c] for i in range(35)) for c in range(625)]

def t3_grad(x):
    v = tens(x)
    M = mp.matrix(25, 25)
    for a in range(25):
        for b in range(25):
            M[a, b] = v[a*25+b]
    M2 = M*M
    g = mp.matrix(35, 1)
    for i in range(35):
        s = mp.mpf(0)
        for a in range(25):
            for b in range(25):
                s += BAS[i, a*25+b]*M2[a, b]
        g[i] = 3*s
    t3 = sum(M2[a, b]*M[b, a] for a in range(25) for b in range(25))
    return t3, g

def norm(x): return mp.sqrt(sum(xi*xi for xi in x))

x = x / norm(x)
for it in range(200):
    t3, g = t3_grad(x)
    # fixed point of the critical equation: x <- g/|g| (gradient of a cubic)
    y = g / norm(g)
    if sum(y[i]*x[i] for i in range(35)) < 0: y = -y
    d = norm(y - x)
    x = y
    if d < mp.mpf(10)**(-50): break
t3, g = t3_grad(x)
r = t3 / norm(x)**3
print(f"iterations {it}, last step {mp.nstr(d, 5)}")
print(f"tr(W^3)/|W|^3 at the polished critical point:")
print("   ", mp.nstr(r, 40))
print(f"1/sqrt(6)                                  :")
print("   ", mp.nstr(1/mp.sqrt(6), 40))
print(f"difference (positive would refute F_5 >= 0) : {mp.nstr(abs(r) - 1/mp.sqrt(6), 10)}")
print(f"F_5/|W|^6 = 3/2 - 9 r^2                     : {mp.nstr(mp.mpf(3)/2 - 9*r*r, 10)}")
