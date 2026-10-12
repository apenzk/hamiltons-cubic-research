"""J2: matrix-free L_e at n=14, and a real (Lanczos) eigensolve of the deflated operator."""
import numpy as np, sys, time
sys.path.insert(0, 'scripts/lib')
from review_r51_core import *
from scipy.sparse.linalg import LinearOperator, eigsh

n = 14
W = normalize(sphere_product_W((6,6), n))
th = float(np.tensordot(W, Qop(n, W)))
e = W / th
P, idx, sgn = pairs_of(n); N = len(P)

print(f"n={n} N={N} theta={th:.9f} theta/theta0={th/theta0(n):.4f}")

# --- A. matrix-free apply vs basis apply -------------------------------------
t0 = time.time(); B = weyl_basis(n); tb = time.time()-t0
d = B.shape[0]
print(f"A. weyl_basis({n}) dim {d} built in {tb:.1f}s")

def Le_free(X):
    Y = weyl_project(n, 0.5*(X+X.T))
    return weyl_project(n, circ(n, e, Y))

rng = np.random.default_rng(7)
errs = []
t0 = time.time()
for _ in range(5):
    co = rng.normal(size=d)
    X = np.tensordot(co, B, axes=(0,0))
    a = Le_free(X)
    b = np.tensordot(np.tensordot(B, circ(n, e, X), axes=([1,2],[0,1])), B, axes=(0,0))
    errs.append(np.linalg.norm(a-b)/np.linalg.norm(b))
t1 = time.time()
print(f"   matrix-free vs basis, 5 random Weyl inputs: max rel err {max(errs):.2e}"
      f"   ({(t1-t0)/5*1000:.1f} ms per matrix-free apply)")

# also on inputs OFF Weyl_n
errs = []
for _ in range(3):
    X = rng.normal(size=(N,N)); X = 0.5*(X+X.T)
    a = Le_free(X)
    Xp = weyl_project(n, X)
    b = np.tensordot(np.tensordot(B, circ(n, e, Xp), axes=([1,2],[0,1])), B, axes=(0,0))
    errs.append(np.linalg.norm(a-b)/np.linalg.norm(b))
print(f"   same on inputs OFF Weyl_n: max rel err {max(errs):.2e}")

# --- B. cost of building the FULL matrix -------------------------------------
t0 = time.time()
C = np.empty_like(B)
for l in range(d):
    C[l] = circ(n, e, B[l])
L = B.reshape(d,-1) @ C.reshape(d,-1).T
L = 0.5*(L+L.T)
t_full = time.time()-t0
ev = np.linalg.eigvalsh(L)
t_eig = time.time()-t0-t_full
print(f"B. FULL {d}x{d} L_e built in {t_full:.1f}s, eigvalsh in {t_eig:.1f}s "
      f"(total {tb+t_full+t_eig:.1f}s incl. basis)")

# --- C. real eigensolve of the deflated operator, matrix-free ----------------
U = onb_rows(orbit_tangent(n, W))          # (orb, N*N)
orb = U.shape[0]
w = W.ravel()/np.linalg.norm(W)
Ucomb = np.vstack([U, w])
q, _ = np.linalg.qr(Ucomb.T); q = q.T      # (orb+1, N*N) orthonormal
print(f"C. orbit dim {orb} (so({n})={N} minus stab so(6)+so(6)+so({n-12})={15+15+(n-12)*(n-13)//2})")
# deflation quality: how much of the orbit survives Pi
def Pi(X):
    Y = weyl_project(n, 0.5*(X+X.T)).ravel()
    Y = Y - q.T @ (q @ Y)
    return Y.reshape(N,N)
leak = max(np.linalg.norm(Pi(u.reshape(N,N)))/np.linalg.norm(u) for u in q)
print(f"   deflation leak: max ||Pi(v)|| over the removed orthonormal basis = {leak:.2e}")

c = 10.0
def Aop(vec):
    X = vec.reshape(N,N)
    Y = Pi(X)
    Z = Le_free(Y) - 0.5*Y
    Z = Le_free(Z) - 0.5*Z
    Z = Pi(Z)
    return (c*(X - Pi(X)) + Z).ravel()   # = Pi (L-1/2)^2 Pi + c (I - Pi)

def Bop(vec):
    return c*vec - Aop(vec)

t0 = time.time()
op = LinearOperator((N*N, N*N), matvec=Bop, dtype=float)
vals = eigsh(op, k=6, which='LA', tol=1e-10, maxiter=5000, return_eigenvectors=False)
t_lan = time.time()-t0
mins = np.sort(c - vals)
print(f"   Lanczos (matrix-free, k=6, {t_lan:.1f}s): smallest (L_e-1/2)^2 on the complement")
print(f"     {'  '.join(f'{x:.6e}' for x in mins)}")

# reference from the full spectrum
half = int(np.sum(np.abs(ev-0.5) < 1e-6))
rest = np.sort(np.abs(ev-0.5))[half:]
print(f"   full-spectrum reference: dim E(1/2)={half}, next |lam-1/2| = {rest[0]:.6e}"
      f"  -> (L_e-1/2)^2 = {rest[0]**2:.6e}")
print(f"   CLAIMED in FINDINGS: 1.9e-2")
