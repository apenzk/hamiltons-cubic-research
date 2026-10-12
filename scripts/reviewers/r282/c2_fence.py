"""r282 claim 2: does the padding dichotomy clear the fence posts -- and does it
REOPEN posts 34/35 by removing their witnesses?  Ascent on tr(M^3)+||M^#||_F,
then the support dimension of the maximiser."""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import numpy as np, io, contextlib
buf = io.StringIO()
with contextlib.redirect_stdout(buf):
    import weyl as W
    from c1_support import cp2_weyl

def polar_sharp(A, B, n):
    return 0.5 * (W.sharp(A + B, n) - W.sharp(A, n) - W.sharp(B, n))

def proj(M, n):
    return W.tensor_to_op(W.project_weyl(W.op_to_tensor(M, n), n), n)

rng = np.random.default_rng(282282)
# check the trilinear <A#B,C> is fully symmetric (needed for the gradient)
n = 6
A, B, C = (W.random_weyl(n, rng) for _ in range(3))
t1 = np.tensordot(polar_sharp(A, B, n), C)
t2 = np.tensordot(polar_sharp(A, C, n), B)
t3 = np.tensordot(polar_sharp(B, C, n), A)
print(f"trilinear symmetry of <A#B,C> at n=6: {t1:.12f} {t2:.12f} {t3:.12f}  spread {max(abs(t1-t2),abs(t1-t3)):.1e}")

def F(M, n):
    S = W.sharp(M, n)
    return float(np.trace(M @ M @ M)) + float(np.sqrt(np.tensordot(S, S)))

def gradF(M, n):
    S = W.sharp(M, n)
    ns = float(np.sqrt(np.tensordot(S, S)))
    return 3.0 * (M @ M) + 2.0 * polar_sharp(M, S, n) / ns

print("\nAscent on  F(M) = tr(M^3) + ||M^#||_F  over unit Weyl_n -- post 34's own quantity")
for n in (6, 8, 10, 12):
    best = -9.9; bestM = None
    for _ in range(12 if n <= 8 else 6):
        M = W.random_weyl(n, rng)
        step = 0.25
        for it in range(500):
            G = proj(gradF(M, n), n)
            G = G - np.tensordot(G, M) * M
            Mn = M + step * G; Mn = proj(Mn, n); Mn = Mn / W.norm(Mn)
            if F(Mn, n) < F(M, n):
                step *= 0.5
                if step < 1e-9: break
            else:
                M = Mn
        if F(M, n) > best:
            best, bestM = F(M, n), M
    print(f"  n={n:2d}: max F/theta_0 = {best/W.theta0(n):.4f}  (post 34 records "
          f"{ {6:1.3403,8:1.2399,10:1.1881,12:1.1564}[n] })   support of the maximiser s = "
          f"{W.support_dim(bestM,n)}   theta/theta_0 = {W.P(bestM,n)/W.theta0(n):.4f}")
print("\nPost 35's witness, padded W_CP2:")
for n in (12, 14, 16):
    M = W.pad(cp2_weyl(4), 4, n)
    print(f"  n={n}: s={W.support_dim(M,n)}  F={F(M,n):.12f}  theta={W.P(M,n):.9f}")
