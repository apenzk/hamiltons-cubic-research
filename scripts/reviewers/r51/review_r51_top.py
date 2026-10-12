"""Is S^6xS^6 pad 12->14 really the highest theta/theta_0 among padded points?"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r51_core import *
from review_r51_cp2 import measure, W_cp2

print("theta_0:", {n: round(theta0(n),9) for n in range(10,15)})
print()
print("== candidates padded INTO n=14 ==")
for blocks, n0 in (((6,6),12), ((5,7),12), ((6,7),13), ((5,8),13), ((4,9),13)):
    W0 = normalize(sphere_product_W(blocks, n0))
    th = float(np.tensordot(W0, Qop(n0, W0)))
    print(f"  S^{blocks[0]}xS^{blocks[1]} native n={n0}: theta={th:.9f} "
          f"th/th0({n0})={th/theta0(n0):.4f}  ->padded to 14: {th/theta0(14):.4f}")
print(f"  W_CP2 padded to 14: {1.224744871/theta0(14):.4f}")
print()
print("== full eigensolve on the top padded candidates at n=14 ==")
measure("S6xS7 pad 13->14", 14, sphere_product_W((6,7), 14))
measure("S6xS6 pad 12->14", 14, sphere_product_W((6,6), 14))
measure("S6xS7 native n=13", 13, sphere_product_W((6,7), 13))
print()
print("== and into n=12 ==")
measure("S5xS6 pad 11->12", 12, sphere_product_W((5,6), 12))
measure("W_CP2 pad ->12", 12, W_cp2(12))
measure("S6xS6 native n=12", 12, sphere_product_W((6,6), 12))
