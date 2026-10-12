"""Do L220's step 7 and step 8 want the SAME shape, or different ones?

The chain bounds two terms of the same pairing:
    step 7:  P(q) = 18xyz            <= (sqrt3/2) |q|^3
    step 8:  kappa <= max(x,y,z) |q| |r|^2   <= (1/sqrt3) |q| |r|^2
over unit patterns (x,y,z) with x + y + z = 0 and 2(x^2+y^2+z^2) = 1.

If both maxima sit at the SAME shape the chain can be tight and there is no gain.
If they sit at DIFFERENT shapes, neither is tight where the other is, and the sum is
strictly below the sum of the maxima: that is the 0.02's source and F68's conflict
pattern.  This CHECKS which, and does not establish it.
"""
import numpy as np
# x + y + z = 0 and x^2+y^2+z^2 = 1/2 is a circle; parametrise by angle t
th=np.linspace(0,2*np.pi,2000001)
r=1/np.sqrt(3)                      # so that x^2+y^2+z^2 = 1/2
x=r*np.cos(th); y=r*np.cos(th-2*np.pi/3); z=r*np.cos(th+2*np.pi/3)
assert abs((x+y+z)).max()<1e-12 and abs(x**2+y**2+z**2-0.5).max()<1e-12

P=18*x*y*z                          # step 7's numerator, |q| = 1
M=np.maximum.reduce([x,y,z])        # step 8's factor

iP=P.argmax(); iM=M.argmax()
print(f"step 7  max 18xyz      = {P[iP]:.6f}  at angle {th[iP]:.4f}, (x,y,z)=({x[iP]:.4f},{y[iP]:.4f},{z[iP]:.4f})")
print(f"        the bound sqrt3/2 = {np.sqrt(3)/2:.6f}")
print(f"step 8  max(x,y,z) max = {M[iM]:.6f}  at angle {th[iM]:.4f}, (x,y,z)=({x[iM]:.4f},{y[iM]:.4f},{z[iM]:.4f})")
print(f"        the bound 1/sqrt3 = {1/np.sqrt(3):.6f}")
print()
print(f"step 8's factor AT step 7's maximiser : {M[iP]:.6f}   deficit {1/np.sqrt(3)-M[iP]:+.6f}")
print(f"step 7's value  AT step 8's maximiser : {P[iM]:.6f}   deficit {np.sqrt(3)/2-P[iM]:+.6f}")
print()
same = abs(th[iP]-th[iM])<1e-3 or abs(abs(th[iP]-th[iM])-2*np.pi)<1e-3
print("SAME shape" if same else "DIFFERENT shapes -> the two bounds CONFLICT")
