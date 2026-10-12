# r1821: check at the tie r=pt/(1+t), q=(p-2tr)/b that the arc max of g is p, attained at 0 and at phi0=arccos t,
# and that g'(phi0)=0 follows from L214's first relation at a generic (p,r) pair. Seconds of compute.
import numpy as np
phi = np.linspace(0, np.pi/2, 200001)
for t in [0.05, 0.3, 0.6, 0.9]:
    p = 1.0; b = np.sqrt(1-t*t); r = p*t/(1+t); q = (p-2*t*r)/b
    g = p*np.cos(phi)**3 + 3*r*np.cos(phi)*np.sin(phi)**2 + q*np.sin(phi)**3
    i = np.argmax(g[1000:]) + 1000
    print(f"t={t}: max g={g.max():.12f}, interior argmax={phi[i]:.6f} vs arccos t={np.arccos(t):.6f}, crit lhs-rhs={p*q*q-(p+r)**2*(p-2*r):.2e}")
# off the tie: rho from relation 1 with p<rho; q from relation 2; g(phi0)=rho and g'(phi0)=0
t, p, r = 0.4, 0.8, 0.5; b = np.sqrt(1-t*t); rho = t*p + b*b/t*r; q = (rho-2*t*r)/b
g = lambda f: p*np.cos(f)**3 + 3*r*np.cos(f)*np.sin(f)**2 + q*np.sin(f)**3
f0 = np.arccos(t); h = 1e-6
print("off tie: g(phi0)-rho =", g(f0)-rho, " g'(phi0) =", (g(f0+h)-g(f0-h))/(2*h))
