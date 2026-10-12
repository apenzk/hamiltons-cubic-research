"""r278 -- the hypothesis of the harmonic-square law, checked three ways.

(1) Frobenius orthogonality is NOT enough: <W_{S3xS3}, W_CP2> = 0 at n=6 with a
    nonvanishing cross term (support-dichotomy.md's own claim, reproduced).
(2) Coordinate-disjointness is sufficient but not necessary: a Lambda^+/Lambda^-
    pair on the SAME four coordinates is circ-orthogonal.
(3) The absolute values in |theta| < min_i|theta_i| are load-bearing:
    (+Fox) (+) (-Fox) at n = 8.
"""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, Q, circ, P, sphere_product_W, normalize
from b_cp2_nondegenerate import padded_cp2

def crit(n, W):
    th = P(n, W); return th, np.linalg.norm(Q(n, W) - th * W)

def embed(W0, n0, n, off):
    p0, _ = pair_index(n0); p1, i1 = pair_index(n)
    out = np.zeros((len(p1), len(p1)))
    for a, (i, j) in enumerate(p0):
        for b, (k, l) in enumerate(p0):
            out[i1[(i+off, j+off)], i1[(k+off, l+off)]] = W0[a, b]
    return out

# (1) n = 6
n = 6
A = normalize(sphere_product_W([3, 3])[0])
Bc = padded_cp2(n)[0]; B = normalize(Bc)
print("(1) n=6  <W_S3xS3, W_CP2> = %.3e   ||A o B||_F = %.6f" %
      (np.tensordot(A, B), np.linalg.norm(circ(n, A, B))))
print("    theta_A = %.6f (res %.1e)   theta_B = %.6f (res %.1e)"
      % (crit(6, A) + crit(6, B)))

# (2) Lambda^+ / Lambda^- on the same four coordinates, n = 4 padded to 6
W4 = padded_cp2(4)[0]                       # self-dual Fox point: W^- = 0
n4 = 4; pairs4, idx4 = pair_index(n4)
# the anti-self-dual mirror: conjugate by a reflection, which swaps Lambda^+/-
Rf = np.eye(4); Rf[3, 3] = -1.0
T = np.zeros((6, 6))
for a, (i, j) in enumerate(pairs4):
    for b, (k, l) in enumerate(pairs4):
        T[a, b] = Rf[i, k] * Rf[j, l] - Rf[i, l] * Rf[j, k]
W4m = T @ W4 @ T.T
Ap = normalize(embed(W4, 4, 6, 0)); Am = normalize(embed(W4m, 4, 6, 0))
print("(2) same 4 coords: <A+,A-> = %.3e  ||A+ o A-||_F = %.3e  overlap = %.3f"
      % (np.tensordot(Ap, Am), np.linalg.norm(circ(6, Ap, Am)),
         abs(np.tensordot(Ap, Am))))
print("    theta+ = %.6f (res %.1e)  theta- = %.6f (res %.1e)"
      % (crit(6, Ap) + crit(6, Am)))
S = normalize(0.5*np.sqrt(2)*Ap + 0.5*np.sqrt(2)*Am)
print("    combined theta = %.9f  res %.1e   harmonic prediction %.9f"
      % (crit(6, S) + (1/np.sqrt(2/crit(6, Ap)[0]**2),)))

# (3) THE ABSOLUTE VALUES, n = 8.  A circ-splitting is only determined up to the
#     SIGN of each piece: A_i -> -A_i flips theta_i and a_i together and leaves W
#     fixed.  So the SAME point W = (F+G)/sqrt2 carries the splitting {F, G} with
#     both theta_i = +sqrt(3/2) and the splitting {F, -G} with theta_2 = -sqrt(3/2),
#     the coefficients being (a1, a2) = (1/sqrt2, +1/sqrt2) and (1/sqrt2, -1/sqrt2).
#     min_i theta_i is therefore not a function of W; min_i |theta_i| is.
n = 8
F = normalize(embed(padded_cp2(4)[0], 4, 8, 0))
G = normalize(embed(padded_cp2(4)[0], 4, 8, 4))
W = normalize((F + G) / np.sqrt(2))
th, r = crit(8, W)
thF, _ = crit(8, F); thG, _ = crit(8, G); thGm, _ = crit(8, -G)
print("(3) n=8  W = (F+G)/sqrt2 : theta = %.9f  res %.1e" % (th, r))
print("    reading A, pieces {F, +G}: theta_i = %+.6f, %+.6f  -> min theta_i = %+.6f"
      % (thF, thG, min(thF, thG)))
print("    reading B, pieces {F, -G}: theta_i = %+.6f, %+.6f  -> min theta_i = %+.6f"
      % (thF, thGm, min(thF, thGm)))
print("    |theta| = %.6f  <  min_i |theta_i| = %.6f   (both readings)"
      % (abs(th), min(abs(thF), abs(thG))))
print("    without the absolute values reading B gives %+.6f < %+.6f : FALSE"
      % (abs(th), min(thF, thGm)))
# and the non-critical near miss, recorded so it is not mistaken for the witness
Wm = normalize((F - G) / np.sqrt(2))
print("    (F-G)/sqrt2 is NOT critical: res %.2e, theta %.1e -- not the witness"
      % (crit(8, Wm)[1], crit(8, Wm)[0]))
