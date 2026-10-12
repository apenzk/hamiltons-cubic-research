"""r272 -- what the file's Cauchy-Schwarz bound actually gives, and its floor."""
import numpy as np, itertools, os, importlib.util
spec = importlib.util.spec_from_file_location("adf", os.path.join(os.path.dirname(os.path.abspath(__file__)), "r272_adform.py"))
adf = importlib.util.module_from_spec(spec); spec.loader.exec_module(adf)

print("||ad_{phi_a}||_op for so(n), and the sum over the basis")
for n in range(4, 15):
    pairs, mats, N, c = adf.struct(n) if n <= 9 else (None, None, n*(n-1)//2, None)
    if c is None:
        # ad-norm is basis-element independent by O(n)-conjugation; take it from n=9 pattern
        continue
    ad = adf.ad_ops(c)
    ops = [np.linalg.norm(ad[a], 2) for a in range(N)]
    print(f"  n={n:2d} N={N:3d}  ||ad_a||_op in [{min(ops):.6f},{max(ops):.6f}]  sum={sum(ops):.4f}  N*max={N*max(ops):.4f}")

print()
print("the file's bound  |<M#,M>| <= (1/2)(sum_a ||ad_a||_op)^2 ||M||_F^2 max_ab|M_ab|")
print("with ||ad_a||_op = 2 for every a and every n>=4:  = 2 N^2 max_ab|M_ab|,  N=n(n-1)/2")
print()
print("FLOOR: ||M||_F=1 over N^2 entries forces max_ab|M_ab| >= 1/N, so the bound is >= 2N = n(n-1)")
print()
print(f"{'n':>3} {'N':>4} {'2N^2/N = 2N':>12} {'theta_0(n)':>11} {'ratio':>10}")
def theta0(n):
    m = n / 2.0
    # theta_0(2m) = 3/2 p3(mu) - 1/2 p3(omega) at the balanced sphere product
    A = 1.0 / (m * np.sqrt((m - 1) * (2 * m - 1)))
    p3mu = A
    p3om = -(4 * m * m - 6 * m - 1) * A
    return 1.5 * p3mu - 0.5 * p3om
for n in [6, 8, 10, 12, 16, 20, 24, 40, 100]:
    N = n * (n - 1) // 2
    print(f"{n:>3} {N:>4} {2*N:>12.1f} {theta0(n):>11.6f} {2*N/theta0(n):>10.1f}")

print()
print("and the value of max_ab|M_ab| actually attained at the conjectured maximiser S^{n/2}xS^{n/2}")
def sphere_product_weyl(m):
    n = 2 * m
    # metric g on S^m(1) x S^m(1): R_{ijkl} = (g_ik g_jl - g_il g_jk) within each factor
    g = np.eye(n)
    R = np.zeros((n, n, n, n))
    for blk in [range(m), range(m, n)]:
        for i, j, k, l in itertools.product(blk, repeat=4):
            R[i, j, k, l] = (g[i, k]*g[j, l] - g[i, l]*g[j, k])
    ric = np.einsum('ijil->jl', R); s = np.trace(ric)
    # Weyl = R - (1/(n-2)) (Ric0 KN g) - s/(n(n-1)) (g KN g)/2 ; do it by projection instead
    def KN(h):
        return (np.einsum('ik,jl->ijkl', h, g) + np.einsum('jl,ik->ijkl', h, g)
                - np.einsum('il,jk->ijkl', h, g) - np.einsum('jk,il->ijkl', h, g))
    B = []
    for i in range(n):
        for j in range(i, n):
            h = np.zeros((n, n)); h[i, j] += 1; h[j, i] += 1
            v = KN(h)
            for u in B: v = v - np.sum(v*u)*u
            nv = np.linalg.norm(v)
            if nv > 1e-9: B.append(v/nv)
    W = R.copy()
    for u in B: W = W - np.sum(W*u)*u
    return W
for m in [3, 4, 5, 6]:
    n = 2*m
    W = sphere_product_weyl(m)
    pairs, mats, N, c = adf.struct(n)
    M = adf.to_operator(W, pairs); M /= np.linalg.norm(M)
    ad = adf.ad_ops(c)
    S = adf.sharp_hamilton(M, c)
    theta = np.trace(M@M@M) + np.sum(S*M)
    mx = np.abs(M).max()
    print(f"  n={n:2d}  theta={theta:.6f} (theta_0={theta0(n):.6f})  max|M_ab|={mx:.6f}"
          f"  1/N={1/N:.6f}   file bound = {2*N*N*mx:.1f}")
