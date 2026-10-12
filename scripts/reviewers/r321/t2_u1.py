import numpy as np, sys
sys.path.insert(0,'scripts/reviewers/r321')
from core import *

def walk_report(name, W, AD, C, n, tol=1e-9):
    lam, Phi = np.linalg.eigh(W)           # columns are eigenvectors in the phi-basis
    # structure constants in the eigenbasis
    Ce = np.einsum('abc,aA,bB,cC->ABC', C, Phi, Phi, Phi, optimize=True)
    v = 0                                   # index of lam_min
    c1 = Ce[v]                              # c1[a,b] = <[v,phi_a],phi_b>? careful: Ce[v,a,b]=<[v,phi_a],phi_b>
    lhs = float(Phi[:,v] @ sharp(W,AD) @ Phi[:,v])
    rhs = 0.5*np.einsum('a,b,ab->', lam, lam, c1**2)
    mass = float((c1**2).sum())
    th = P_func(W,AD)
    crit = np.linalg.norm(Q(W,AD)-th*W)
    print(f"{name}: n={n} theta={th:.12f} critres={crit:.2e} lam_min={lam[0]:.9f}")
    print(f"   <v,W#v>={lhs:.15f}  (1/2)sum lam lam c^2={rhs:.15f}  diff={abs(lhs-rhs):.2e}")
    print(f"   mass sum c^2={mass:.12f}  2(n-2)={2*(n-2)}  diff={abs(mass-2*(n-2)):.2e}")
    print(f"   lam_min(theta-lam_min)={lam[0]*(th-lam[0]):.15f} diff={abs(lhs-lam[0]*(th-lam[0])):.2e}")
    return lam, Ce

# --- point 1,2,3: sphere products
for (n,p) in [(6,3),(8,4),(8,3),(10,5)]:
    WB,N = weyl_basis(n); C,P = struct(n); AD = ad_mats(C)
    W = sphere_product(n,p,WB)
    walk_report(f"S^{p}xS^{n-p}", W, AD, C, n)

# --- point 4: CP^3  (n=6)
n=6; WB,N=weyl_basis(n); C,P=struct(n); AD=ad_mats(C)
W = cpm_weyl(3, WB)
walk_report("CP^3", W, AD, C, n)

# --- point 5: RANDOM (non-critical) Weyl point, to test mass universality off criticality
rng = np.random.default_rng(7)
for k in range(3):
    x = rng.standard_normal(WB.shape[0])
    W = np.einsum('k,kij->ij', x, WB); W/=np.linalg.norm(W)
    lam,Phi = np.linalg.eigh(W)
    Ce = np.einsum('abc,aA,bB,cC->ABC', C, Phi, Phi, Phi, optimize=True)
    lhs = float(Phi[:,0]@sharp(W,AD)@Phi[:,0]); c1=Ce[0]
    rhs = 0.5*np.einsum('a,b,ab->',lam,lam,c1**2); mass=float((c1**2).sum())
    th=P_func(W,AD)
    print(f"random n=6 #{k}: identity diff={abs(lhs-rhs):.2e} mass={mass:.12f} (2(n-2)={2*(n-2)})"
          f" | lam_min(th-lam_min)-<v,W#v> = {lam[0]*(th-lam[0])-lhs:+.4f} (non-critical, must differ)")

# --- mass for an ARBITRARY unit vector (not an eigenvector) and arbitrary n
for n in [5,6,9,12]:
    C,_ = struct(n)
    for t in range(2):
        u = rng.standard_normal(C.shape[0]); u/=np.linalg.norm(u)
        Cu = np.einsum('a,abc->bc', u, C)
        print(f"  n={n} random UNIT vector (not eigen, no W): sum c^2 = {float((Cu**2).sum()):.12f}  2(n-2)={2*(n-2)}")
