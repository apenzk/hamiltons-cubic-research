"""L2: what the two block equations actually contain.

With tri(X,Y,Z) = <X#Y,Z> totally symmetric and the grading's sorting (A#A, B#B in p;
A#B in m), the four possible cubics collapse:
    tri(A,A,B) = <A#B, A> = 0   (A#B lives in m, A in p)
    tri(B,B,B) = <B#B, B> = 0   (B#B lives in p, B in m)
so with C := tri(A,B,B) = <A, B#B> the two equations are
    p:  theta ||A||^2 = tr A^3 + tri(A,A,A) + C
    m:  theta ||B||^2 = tr B^3 + 2C
and C is the ONLY coupling.  It is LINEAR in A: the m-equation probes A through the single
scalar <A, B#B>, one direction in the space of A's."""
import sys, numpy as np
sys.path.insert(0, 'scripts/reviewers/r307')
from core307 import *

def tri(n, X, Y, Z):
    return float(np.tensordot(sharp_bilin(n, X, Y), Z))

def analyse(name, n, W):
    W = W/np.linalg.norm(W)
    th = float(np.tensordot(Q(n, W), W))
    lam, V = np.linalg.eigh(W)
    Up, Um = V[:, lam > 1e-9], V[:, lam < -1e-9]
    Pp, Pm = Up@Up.T, Um@Um.T
    A, B = Pp@W@Pp, Pm@W@Pm
    C = tri(n, A, B, B)
    tAAA, tAAB, tBBB = tri(n,A,A,A), tri(n,A,A,B), tri(n,B,B,B)
    a2, b2 = np.linalg.norm(A)**2, np.linalg.norm(B)**2
    print(f"\n== {name}  theta={th:.9f}")
    print(f"   tri(A,A,B) = {tAAB:.2e}   tri(B,B,B) = {tBBB:.2e}   (both forced 0 by the sorting)")
    print(f"   C = tri(A,B,B) = <A,B#B> = {C:.9f};  <B,2(A#B)> = {2*tri(n,A,B,B):.9f} (= 2C)")
    print(f"   p-eq: {th*a2:.9f} =? {np.trace(A@A@A)+tAAA+C:.9f}  "
          f"[trA^3={np.trace(A@A@A):.6f} tri(A,A,A)={tAAA:.6f} C={C:.6f}]")
    print(f"   m-eq: {th*b2:.9f} =? {np.trace(B@B@B)+2*C:.9f}  "
          f"[trB^3={np.trace(B@B@B):.6f} 2C={2*C:.6f}]")
    # how much of A does the m-equation see?  It sees only <A, B#B>/|B#B| .
    BB = sharp_bilin(n, B, B)
    u = BB/np.linalg.norm(BB)
    Aperp = A - float(np.tensordot(A, u))*u
    print(f"   the m-equation's probe of A is rank one: |A| = {np.linalg.norm(A):.6f}, "
          f"component seen = {abs(float(np.tensordot(A,u))):.6f}, "
          f"invisible to the m-equation = {np.linalg.norm(Aperp):.6f}")
    # is B#B ad(p)-invariant (Schur) when W is equivariant?
    npos = len(set(np.round(lam[lam>1e-9], 6)))
    print(f"   #distinct positive eigenvalues = {npos}")
    return th

n = 8
analyse('S^3 x S^5 (equivariant)', n, sphere_product_W(n,3))
analyse('n=8 witness (non-equivariant)', n, np.load('scripts/data/w_n8_nondiagonal_witness.npy'))
analyse('S^4 x S^4 (equivariant)', n, sphere_product_W(n,4))
G = np.load('scripts/reviewers/r307/gradedpts_n8_p3_s5.npy')
for k in range(len(G)):
    lam = np.linalg.eigvalsh(G[k]/np.linalg.norm(G[k]))
    if (lam>1e-9).sum() == 13 and len(set(np.round(lam[lam>1e-9],6))) > 2:
        analyse(f'hunted graded non-equivariant #{k}', n, G[k]); break
