"""E1, the kill: an explicitly FEASIBLE symmetric T scoring far above theta_0.

Split indices into S (size p) and its complement (size q = N - p).
Put T = kappa/p^2 uniformly on S^3 and kappa/q^2 uniformly on comp^3.
  symmetric, nonnegative, row sums exactly kappa, pair sums kappa/p, kappa/q <= C.
Take w = +x on S, -y off S, with px = qy and px^2 + qy^2 = 1.
Then  val = sum w^3 + (1/2)[ kappa p x^3 - kappa q y^3 ].
"""
import numpy as np

def witness(n, p, C=2.0):
    N = n*(n-1)//2; q = N - p; kap = 2.0*(n-2)
    if q <= 0 or kap/p > C or kap/q > C: return None      # feasibility of pair caps
    y = np.sqrt(p/(q**2 + p*q)); x = q*y/p
    cubes = p*x**3 - q*y**3
    return cubes + 0.5*kap*(p*x**3 - q*y**3), x, y

print(f"{'n':>4} {'p':>5} {'val':>10} {'theta_0':>9} {'ratio':>7} {'sqrt(n-2)':>10}")
for n in (6, 8, 10, 12, 16, 20, 30, 50, 100):
    N = n*(n-1)//2
    best = max((witness(n, p) for p in range(1, N) if witness(n, p)), key=lambda r: r[0])
    t0 = np.sqrt(2*(n-1)*(n-2))/n
    bp = [p for p in range(1, N) if witness(n, p) and witness(n, p)[0] == best[0]][0]
    print(f"{n:4d} {bp:5d} {best[0]:10.4f} {t0:9.4f} {best[0]/t0:7.2f} {np.sqrt(n-2):10.4f}")

# exact feasibility check of the witness at n = 8, built as a full tensor
n, p = 8, 6
N = n*(n-1)//2; q = N-p; kap = 2.0*(n-2)
T = np.zeros((N, N, N))
T[np.ix_(range(p), range(p), range(p))] = kap/p**2
T[np.ix_(range(p, N), range(p, N), range(p, N))] = kap/q**2
print(f"\nexplicit check at n={n}, p={p}:")
print(f"  symmetric: {np.allclose(T, T.transpose(1,0,2)) and np.allclose(T, T.transpose(0,2,1))}")
print(f"  nonneg: {T.min() >= 0}")
print(f"  row sums all = kappa={kap}: {np.allclose(T.sum(axis=(1,2)), kap)}")
print(f"  max pair sum = {T.sum(axis=2).max():.4f} (cap C=2)")
