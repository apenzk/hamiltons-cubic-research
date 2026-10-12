"""r281 Claim 4: the one-line theorem and the r279/r280 reconciliation on criticality."""
import sys, os
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))
from review_r30_core import weyl_basis, Q, P, circ, pair_index, normalize, sphere_product_W
from scipy.optimize import brentq
import itertools

rng = np.random.default_rng(4281)
fro = lambda X, Y: float(np.tensordot(X, Y))

def rand_weyl(n, blockcoords=None):
    B = weyl_basis(n)
    c = rng.normal(size=B.shape[0])
    W = np.einsum('k,kij->ij', c, B)
    return W / np.sqrt(fro(W, W))

def pad(n0, W0, n, coords):
    p0, i0 = pair_index(n0); pn, iN = pair_index(n)
    Wb = np.zeros((len(pn),) * 2)
    for a, (i, j) in enumerate(p0):
        for b, (k, l) in enumerate(p0):
            ci, cj = coords[i], coords[j]; ck, cl = coords[k], coords[l]
            si = 1.0 if ci < cj else -1.0; sk = 1.0 if ck < cl else -1.0
            Wb[iN[(min(ci,cj),max(ci,cj))], iN[(min(ck,cl),max(ck,cl))]] = si*sk*W0[a, b]
    return Wb

def cp2_4():
    n = 4
    J = np.zeros((n, n)); J[1,0]=1.; J[0,1]=-1.; J[3,2]=1.; J[2,3]=-1.
    Jm = J.T.copy(); d = np.eye(n)
    R = np.zeros((n,)*4)
    for i,j,k,l in itertools.product(range(n), repeat=4):
        R[i,j,k,l] = (d[i,k]*d[j,l]-d[i,l]*d[j,k]) + (Jm[i,k]*Jm[j,l]-Jm[i,l]*Jm[j,k]) + 2*Jm[i,j]*Jm[k,l]
    p4, _ = pair_index(4)
    W = np.array([[R[i,j,k,l] for (k,l) in p4] for (i,j) in p4])
    B = weyl_basis(4)
    c = np.einsum('kij,ij->k', B, W)
    W = np.einsum('k,kij->ij', c, B)
    return normalize(W)

n = 8
print("=== 1. total symmetry of T(X,Y,Z) = <X, Y o Z> ===")
X, Y, Z = rand_weyl(n), rand_weyl(n), rand_weyl(n)
t1 = fro(X, circ(n, Y, Z)); t2 = fro(Y, circ(n, X, Z)); t3 = fro(Z, circ(n, X, Y))
print(f"  T = {t1:.12f} {t2:.12f} {t3:.12f}   spread {max(t1,t2,t3)-min(t1,t2,t3):.2e}")

print()
print("=== 2. additivity from o-orthogonality alone, NON-critical pieces ===")
A = pad(4, rand_weyl(4), 8, [0,1,2,3])
Bb = pad(4, rand_weyl(4), 8, [4,5,6,7])
A = normalize(A); Bb = normalize(Bb)
print(f"  ||A o B|| = {np.sqrt(fro(circ(n,A,Bb),circ(n,A,Bb))):.3e}   <A,B> = {fro(A,Bb):.3e}")
print(f"  crit residuals: ||Q(A)-P(A)A|| = {np.linalg.norm(Q(n,A)-P(n,A)*A):.3e}, "
      f"||Q(B)-P(B)B|| = {np.linalg.norm(Q(n,Bb)-P(n,Bb)*Bb):.3e}   (NOT critical)")
for (a, b) in [(0.6, 0.8), (0.8, -0.6), (-0.6, -0.8), (0.28735, np.sqrt(1-0.28735**2))]:
    lhs = P(n, a*A + b*Bb); rhs = a**3 * P(n, A) + b**3 * P(n, Bb)
    print(f"    a={a:+.5f} b={b:+.5f}:  P(aA+bB)={lhs:+.12f}  a^3P(A)+b^3P(B)={rhs:+.12f}  diff {lhs-rhs:.2e}")

print()
print("=== 3. THE RECONCILIATION'S CLAIM: does criticality + <A,B>=0 give A o B = 0? ===")
A0 = pad(4, cp2_4(), 8, [0,1,2,3])
print(f"  A0 = padded W_CP2, P={P(n,A0):.12f}, crit resid {np.linalg.norm(Q(n,A0)-P(n,A0)*A0):.2e}")
# rotate A0 by a one-parameter SO(8) family and solve <A0, g_t A0> = 0
def riemann(nn, W):
    pairs, idx = pair_index(nn)
    R = np.zeros((nn,)*4)
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            v = W[a, b]
            R[i,j,k,l]=v; R[j,i,k,l]=-v; R[i,j,l,k]=-v; R[j,i,l,k]=v
    return R
def rot(nn, W, O):
    pairs, _ = pair_index(nn)
    R2 = np.einsum('ia,jb,kc,ld,abcd->ijkl', O, O, O, O, riemann(nn, W))
    return np.array([[R2[i,j,k,l] for (k,l) in pairs] for (i,j) in pairs])

from scipy.linalg import expm
Ssk = rng.normal(size=(8,8)); Ssk = Ssk - Ssk.T
f = lambda t: fro(A0, rot(8, A0, expm(t*Ssk)))
ts = np.linspace(0.0, 2.0, 60)
vals = [f(t) for t in ts]
root = None
for i in range(len(ts)-1):
    if vals[i]*vals[i+1] < 0:
        root = brentq(f, ts[i], ts[i+1], xtol=1e-13); break
Bc = rot(8, A0, expm(root*Ssk))
print(f"  found g in SO(8) with <A0, g.A0> = {fro(A0,Bc):.3e}  (t={root:.6f})")
print(f"  g.A0 critical? ||Q-PW|| = {np.linalg.norm(Q(n,Bc)-P(n,Bc)*Bc):.2e},  P = {P(n,Bc):.12f}")
cb = circ(n, A0, Bc)
print(f"  ||A0 o (g.A0)||          = {np.sqrt(fro(cb,cb)):.6f}     <-- NONZERO  => criticality+orthogonality does NOT give o-orthogonality")
print(f"  <A0 o B, A0> = {fro(cb,A0):.2e}   <A0 o B, B> = {fro(cb,Bc):.2e}   (these two DO vanish)")
Wsum = (A0 + Bc)/np.sqrt(2.0)
print(f"  P((A0+B)/sqrt2) = {P(n,Wsum):.12f}  vs additive prediction {2*(1/np.sqrt(2))**3*P(n,A0):.12f}")

print()
print("=== 4. the direction that DOES hold: o-orthogonal + critical => <A,B> = 0 ===")
Ac = pad(4, cp2_4(), 8, [0,1,2,3]); Bd = pad(4, cp2_4(), 8, [4,5,6,7])
cb = circ(n, Ac, Bd)
print(f"  disjoint padded CP2 pair: ||A o B|| = {np.sqrt(fro(cb,cb)):.2e}, <A,B> = {fro(Ac,Bd):.2e}")
print(f"  <Q(A),B> = {fro(Q(n,Ac),Bd):.2e} = P(A)<A,B> = {P(n,Ac)*fro(Ac,Bd):.2e}")

print()
print("=== 5. the sign step in the displayed chain ===")
Mn = 1.2360330811826103   # theta_0(8)? no: M(8) unknown; use the file's M(n) role symbolically
a, b = -0.6, 0.8
Pa, Pb = P(n, A), P(n, Bb)
print(f"  with a={a}, P(A)={Pa:.6f}:  a^3 P(A) = {a**3*Pa:+.6f},  a^3 * M = {a**3*1.3:+.6f}")
print(f"  so 'a_i^3 P(A_i) <= M sum a_i^3' FAILS for a_i<0 unless |a_i|^3 is used: "
      f"{a**3*Pa:+.6f} <= {a**3*1.3:+.6f} is {a**3*Pa <= a**3*1.3}")

print()
print("=== 6. k=2: is CRITICALITY + ORDINARY ORTHOGONALITY already enough for additivity? ===")
print("   (no o-orthogonality: ||A o B|| = %.6f above)" % np.sqrt(fro(circ(n,A0,Bc),circ(n,A0,Bc))))
for (a, b) in [(0.6,0.8), (-0.6,0.8), (0.28735,0.95783), (0.9,-0.43589)]:
    lhs = P(n, a*A0 + b*Bc); rhs = a**3*P(n,A0) + b**3*P(n,Bc)
    print(f"   a={a:+.5f} b={b:+.5f}: P(aA+bB)={lhs:+.12f}  a^3P(A)+b^3P(B)={rhs:+.12f}  diff {lhs-rhs:.2e}"
          f"   ||aA+bB||^2={fro(a*A0+b*Bc,a*A0+b*Bc):.9f}")
# a second, structurally different critical orthogonal pair: sphere products
Wsp, _ = sphere_product_W([4,4]); Wsp = normalize(Wsp)
f2 = lambda t: fro(Wsp, rot(8, Wsp, expm(t*Ssk)))
ts = np.linspace(0.0, 3.0, 90); vals = [f2(t) for t in ts]
r2 = None
for i in range(len(ts)-1):
    if vals[i]*vals[i+1] < 0:
        r2 = brentq(f2, ts[i], ts[i+1], xtol=1e-13); break
B2 = rot(8, Wsp, expm(r2*Ssk))
cb2 = circ(n, Wsp, B2)
print(f"   S^4xS^4 pair: <A,B>={fro(Wsp,B2):.2e}, ||A o B||={np.sqrt(fro(cb2,cb2)):.6f}, "
      f"crit resid {np.linalg.norm(Q(n,B2)-P(n,B2)*B2):.1e}")
for (a, b) in [(0.6,0.8), (-0.7,0.71414)]:
    lhs = P(n, a*Wsp + b*B2); rhs = a**3*P(n,Wsp) + b**3*P(n,B2)
    print(f"   a={a:+.5f} b={b:+.5f}: P={lhs:+.12f}  additive={rhs:+.12f}  diff {lhs-rhs:.2e}")
print()
print("=== 7. k=3: does criticality+orthogonality still give additivity?  T(A,B,C) for distinct pieces ===")
C3 = rot(8, A0, expm(1.7*Ssk))
print(f"   <A0,C>={fro(A0,C3):.3e}  <B,C>={fro(Bc,C3):.3e}   T(A0,B,C)=<A0 o B, C> = {fro(circ(n,A0,Bc),C3):.6f}")
