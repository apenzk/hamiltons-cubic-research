"""r282 claim 4: the one-line theorem and the r279/r280 reconciliation."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, weyl as W
from c1_support import cp2_weyl
from scipy.optimize import brentq

def circ(A, B, n):
    return 0.5 * (W.Q(A + B, n) - W.Q(A, n) - W.Q(B, n))

def crit_residual(M, n):
    """||Pi_Weyl Q(M) - P(M) M||, the criticality residual on the unit sphere."""
    G = W.tensor_to_op(W.project_weyl(W.op_to_tensor(W.Q(M, n), n), n), n)
    return float(W.norm(G - W.P(M, n) * M))

def rotate(M, n, g):
    R = W.op_to_tensor(M, n)
    return W.tensor_to_op(np.einsum('ai,bj,ck,dl,ijkl->abcd', g, g, g, g, R), n)

n = 8
A = W.pad(cp2_weyl(4), 4, n)
print("A = padded W_CP2 at n=8:  P =", W.P(A, n), " crit residual =", crit_residual(A, n))

print("\n--- (i) criticality is NOT needed when A o B = 0 is the HYPOTHESIS ---")
rng = np.random.default_rng(4282)
A0 = W.pad(W.random_weyl(4, rng), 4, n)                       # supported on {0,1,2,3}
perm = np.zeros((n, n))
for i in range(4):
    perm[4 + i, i] = 1.0; perm[i, 4 + i] = 1.0
B0 = rotate(W.pad(W.random_weyl(4, rng), 4, n), n, perm)      # supported on {4,..,7}
print("  two NON-critical coordinate-disjoint pieces: crit residuals",
      f"{crit_residual(A0,n):.4f}, {crit_residual(B0,n):.4f}",
      " |A o B| =", f"{W.norm(circ(A0,B0,n)):.2e}", " <A,B> =", f"{np.tensordot(A0,B0):.2e}")
for (a, b) in [(0.6, 0.8), (0.8, -0.6), (-0.5, np.sqrt(0.75))]:
    lhs = W.P(a * A0 + b * B0, n)
    rhs = a**3 * W.P(A0, n) + b**3 * W.P(B0, n)
    print(f"    (a,b)=({a:+.4f},{b:+.4f}): P(aA+bB)={lhs:+.14f}  a^3P(A)+b^3P(B)={rhs:+.14f}  diff={lhs-rhs:+.2e}")

print("\n--- (ii) does criticality DERIVE  A o B = 0  from <A,B> = 0 ? ---")
# one-parameter family of critical, isometric copies of A; find where <A, gA> = 0
def gen(th):
    g = np.eye(n)
    c, s = np.cos(th), np.sin(th)
    g[0, 0] = c; g[0, 4] = -s; g[4, 0] = s; g[4, 4] = c
    g[1, 1] = c; g[1, 5] = -s; g[5, 1] = s; g[5, 5] = c
    return g
f = lambda th: float(np.tensordot(A, rotate(A, n, gen(th))))
from scipy.linalg import expm
rng2 = np.random.default_rng(11)
Xsk = rng2.normal(size=(n, n)); Xsk = Xsk - Xsk.T
f = lambda t: float(np.tensordot(A, rotate(A, n, expm(t * Xsk))))
th = brentq(f, 0.2, 0.35, xtol=1e-14)
B = rotate(A, n, expm(th * Xsk))
print(f"  theta*={th:.12f}: <A,B> = {np.tensordot(A,B):.2e},  both critical "
      f"(residuals {crit_residual(A,n):.1e}, {crit_residual(B,n):.1e}),  P(A)=P(B)={W.P(B,n):.12f}")
print(f"  ||A o B|| = {W.norm(circ(A,B,n)):.9f}   <-- NONZERO: criticality + Frobenius orthogonality"
      f" does NOT give circ-orthogonality")
for c2 in (0.6, 0.8):
    s2 = np.sqrt(1 - c2**2)
    lhs = W.P(c2 * A + s2 * B, n); rhs = c2**3 * W.P(A, n) + s2**3 * W.P(B, n)
    print(f"    additivity HOLDS anyway: (a,b)=({c2},{s2:.4f}) P={lhs:.9f} vs a^3P+b^3P={rhs:.9f}")

print("\n--- (iii) the a_i^3 chain as written at 6bcf1b6, and why the theorem survives ---")
M8 = max(W.P(A, n), 0.0)
a, b = 0.6, -0.8
print(f"  pieces at +M and -M, (a,b)=({a},{b}): sum a_i^3 P(A_i) = {a**3*M8 + b**3*(-M8):+.6f}"
      f"  while  M*sum a_i^3 = {M8*(a**3+b**3):+.6f}  -> the written chain inverts")
print(f"  repair in one line: replace A_2 by -A_2 and a_2 by -a_2 (circ-orthogonality and unit norm survive),"
      f" so WLOG every a_i>0 and the chain is valid; the THEOREM stands.")
