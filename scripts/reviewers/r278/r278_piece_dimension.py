"""r278 -- does a circ-splitting lower the dimension?

support-dichotomy.md states the decomposable branch with the hypothesis
"each W_i critical of unit norm in dimension n_i < n", and then runs it as an
induction on n with base cases 4 <= n_i <= 11.  This script tests that
hypothesis on the record's own worked example, (S^4)^3 at n = 12, which
second-order.md says splits as S^4xS^8 (+)_o S^4xS^4.

The support dimension of a Weyl operator is frame-covariant: writing R_{ijkl}
for the 4-tensor, G_{ip} = sum_{jkl} R_{ijkl} R_{pjkl} has image exactly the
smallest V with W in S^2(Lambda^2 V), so n_i := rank G.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, Q, circ, P, sphere_product_W, normalize
from b_circ_indecomposable import multiblock_W

def to_tensor(n, W):
    pairs, idx = pair_index(n)
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            v = W[a, b]
            R[i, j, k, l] = v;  R[j, i, k, l] = -v
            R[i, j, l, k] = -v; R[j, i, l, k] = v
    return R

def support_dim(n, W, tol=1e-9):
    R = to_tensor(n, W)
    G = np.einsum('ijkl,pjkl->ip', R, R)
    ev = np.linalg.eigvalsh(G)
    return int((ev > tol * max(1.0, ev.max())).sum()), ev

def crit_res(n, W):
    th = P(n, W)
    return np.linalg.norm(Q(n, W) - th * W), th

def embed(W0, n0, n, off):
    p0, i0 = pair_index(n0); p1, i1 = pair_index(n)
    out = np.zeros((len(p1), len(p1)))
    for a, (i, j) in enumerate(p0):
        for b, (k, l) in enumerate(p0):
            out[i1[(i + off, j + off)], i1[(k + off, l + off)]] = W0[a, b]
    return out

n = 12
W3, _ = multiblock_W([4, 4, 4]); W3 = normalize(W3)
r3, th3 = crit_res(n, W3)
d3, _ = support_dim(n, W3)
print(f"(S^4)^3 at n=12 : theta = {th3:.6f}  crit-res = {r3:.2e}  support dim = {d3}")

# the two pieces the record names
A, _ = sphere_product_W([4, 8]); A = normalize(A)          # blocks {0..3} vs {4..11}
rA, thA = crit_res(n, A); dA, _ = support_dim(n, A)
print(f"S^4 x S^8 at n=12: theta = {thA:.6f}  crit-res = {rA:.2e}  support dim = {dA}")

B8, _ = sphere_product_W([4, 4]); B = normalize(embed(B8, 8, n, 4))  # on {4..11}
rB, thB = crit_res(n, B); dB, _ = support_dim(n, B)
print(f"pad(S^4 x S^4)   : theta = {thB:.6f}  crit-res = {rB:.2e}  support dim = {dB}")

print(f"\n<A,B> = {np.tensordot(A,B):.3e}   ||A o B||_F = {np.linalg.norm(circ(n,A,B)):.3e}")

a = th3 / thA; b = th3 / thB
print(f"a = theta/theta_A = {a:.9f}, b = {b:.9f}, a^2+b^2 = {a*a+b*b:.12f}")
print(f"|| a A + b B - W_(S^4)^3 ||_F = {np.linalg.norm(a*A + b*B - W3):.3e}")
harm = 1.0/np.sqrt(1/thA**2 + 1/thB**2)
print(f"harmonic-square prediction {harm:.9f} vs actual theta {th3:.9f}")
