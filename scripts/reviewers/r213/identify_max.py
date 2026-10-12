import numpy as np, importlib.util, os
from itertools import combinations
sp = importlib.util.spec_from_file_location("h", os.path.join(os.path.dirname(os.path.abspath(__file__)), "hunt_f5_negative.py"))
h = importlib.util.module_from_spec(sp); sp.loader.exec_module(h)
x = np.load("scripts/reviewers/r213/argmax.npy"); x /= np.linalg.norm(x)
T = (x @ h.BAS).reshape(5,5,5,5)
P = list(combinations(range(5),2))
# Lambda^2 operator: (Wh)_{(ij),(kl)} = T[i,j,k,l]
Wh = np.array([[T[i,j,k,l] for (k,l) in P] for (i,j) in P])
ev = np.linalg.eigvalsh(Wh)
print("Lambda^2 operator eigenvalues (x10 for reading):")
print(np.round(ev, 8))
print("sum (must be 0):", ev.sum())
print("|Wh|_F^2:", (Wh**2).sum(), "   |T|^2:", (T**2).sum(), " ratio:", (T**2).sum()/(Wh**2).sum())
print("tr(Wh^3):", np.trace(Wh@Wh@Wh), "  tr(M^3)/8:", np.trace(((x@h.BAS).reshape(25,25))**0 @ np.eye(25))*0)
M = (x@h.BAS).reshape(25,25)
print("tr(M^3):", np.trace(M@M@M), "  8*tr(Wh^3):", 8*np.trace(Wh@Wh@Wh))
print("ratio ev/ev[0]:", np.round(ev/ev[-1], 8))
