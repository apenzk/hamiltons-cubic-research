"""r231 claim 5: is the newly-computed table right, and are the docstring's
surviving figures emitted by anything?

A CLOSED FORM, so the check is not limited to the small n the dense code reaches.
For W = diag_weyl(Lam) one has W_iklj = Lam_ik (d_il d_kj - d_ij d_kl), hence

    (Wring h)_ij = Lam_ij h_ij  -  d_ij sum_k Lam_ik h_kk

so the Sym^2 spectrum is {Lam_ij : i<j} together with spec(-Lam), and the
S^2_0 spectrum drops the zero that -Lam carries on the all-ones vector.
For the BALANCED product p = q = n/2, with alpha = p/(p-1),

    spec = { alpha  x (p(p-1) + 2p - 2),  -1  x p^2,  -2p  x 1 },   N = 2p^2+p-1.

Verified below against the dense ring() at n = 12, 16, 20.
"""
import importlib.util as il, io, contextlib, numpy as np
from math import sqrt

def load(name):
    sp = il.spec_from_file_location(name[:-3], f"scripts/runs/{name}")
    m = il.module_from_spec(sp)
    with contextlib.redirect_stdout(io.StringIO()):
        sp.loader.exec_module(m)
    return m
sk, cat = load("run_secondkind_sign.py"), load("run_bispectral_catalogue.py")

cap = lambda n: sqrt(2 * (n - 2) / (n - 1))      # (n/(n-1)) theta_0(n), simplified

def closed_form(n):
    """unit-norm S^2_0 second-kind spectrum of the balanced product, order iklj"""
    p = n // 2; a = p / (p - 1)
    vals = np.array([a] * (p * (p - 1) + 2 * p - 2) + [-1.0] * (p * p) + [-2.0 * p])
    s = sqrt(0.75 / (vals ** 2).sum())
    return np.sort(s * vals)

def dense(n, order):
    W = cat.sphere_product(n // 2, n // 2)
    W = W / np.sqrt(np.einsum('ijkl,ijkl->', W, W))
    return np.sort(np.linalg.eigvalsh(sk.ring(W, order)))

def s20_correct(n, order):
    """S^2_0: drop the g-direction eigenvalue, which is the ZERO one"""
    e = dense(n, order)
    return np.delete(e, np.argmin(np.abs(e)))

def s20_asfiled(n, order):
    """what run_second_kind_moment.py does: np.sort(...)[1:]"""
    return dense(n, order)[1:]

print("  Q0  the closed form, checked against the dense operator")
for n in (12, 16, 20):
    a, b = closed_form(n), s20_correct(n, 'iklj')
    print(f"    n={n:>3}  N={len(a):>4}  max|closed - dense| = {np.abs(a - b).max():.2e}")
    assert np.abs(a - b).max() < 1e-9

print("\n  Q1  THE RESTRICTION IS WRONG.  np.sort(...)[1:] drops the SMALLEST")
print("      eigenvalue; the g-direction one is the ZERO.")
print(f"    {'n':>4} {'dropped':>10} {'the zero':>9} | {'p_2 filed':>10} {'p_3 filed':>10} "
      f"{'m filed':>9} | {'p_2 true':>9} {'p_3 true':>10} {'m true':>9}")
for n in (12, 14, 16, 24):
    e = dense(n, 'iklj')
    A, B = s20_asfiled(n, 'iklj'), s20_correct(n, 'iklj')
    print(f"    {n:>4} {e[0]:>10.6f} {e[np.argmin(np.abs(e))]:>9.6f} | "
          f"{(A**2).sum():>10.6f} {(A**3).sum():>10.6f} {-A.min():>9.6f} | "
          f"{(B**2).sum():>9.6f} {(B**3).sum():>10.6f} {-B.min():>9.6f}")
    assert abs((B ** 2).sum() - 0.75) < 1e-9
    assert abs((A ** 2).sum() - 0.75) > 1e-3, "the as-filed restriction is harmless"
print("    p_2 of the file's own S^2_0 spectrum is NOT 3/4 -- the one invariant the")
print("    file says no convention may move -- and its p_3 has the WRONG SIGN.")

print("\n  Q2  '-min omega equals the projection cap with EXACT equality at every")
print("       balanced sphere product' -- checked on the correct restriction")
print(f"    {'n':>5} {'m = -min':>10} {'2m':>10} {'cap':>10} {'|2m - cap|':>11}")
for n in (12, 16, 24, 60, 100, 400):
    m = -closed_form(n).min()
    print(f"    {n:>5} {m:>10.6f} {2*m:>10.6f} {cap(n):>10.6f} {abs(2*m-cap(n)):>11.1e}")
    assert abs(2 * m - cap(n)) < 1e-12
print("    EXACT at every n, with the factor-2 normalisation.  The docstring claim")
print("    holds; the file's own table cannot see it, m being 0.056183 there.")

print("\n  Q3  'p_3/p_3^min rises 0.6075 -> 0.6600 from n=12 to n=100'")
print(f"    {'n':>5} {'N':>6} {'m':>10} {'p_3':>11} {'p_3^min':>11} {'ratio':>8}")
seen = {}
for n in (12, 14, 16, 24, 100, 400):
    om = closed_form(n); N = len(om); m = -om.min()
    p3 = (om ** 3).sum(); lo = 9 / (16 * m * N) - 3 * m / 4
    seen[n] = p3 / lo
    print(f"    {n:>5} {N:>6} {m:>10.6f} {p3:>11.6f} {lo:>11.6f} {p3/lo:>8.4f}")
    assert lo < 0 and p3 < 0
assert abs(seen[12] - 0.6075) < 5e-5, seen[12]
assert abs(seen[100] - 0.6600) < 5e-5, seen[100]
print("    BOTH quoted figures reproduce to four decimals -- from the CORRECT")
print("    restriction, which is not the one the file computes.  The docstring is")
print("    right and the code that was added to substantiate it is wrong.")

print("\n  Q4  'relaxed -3.9585, integrality restored -3.6108, truth -2.4046'")
om = 2 * closed_form(12); N = len(om); m = -om.min()
p2, p3 = (om ** 2).sum(), (om ** 3).sum()
r = p2 / (m * m * N); lo = N * m ** 3 * r * (r - 1)
print(f"    doubled normalisation (p_2 = {p2:.4f}, m = {m:.6f} = the cap):")
print(f"      truth p_3 = {p3:.4f}   relaxed two-atom min = {lo:.4f}   "
      f"ratio {p3/lo:.4f}")
assert abs(p3 + 2.4046) < 5e-4 and abs(lo + 3.9585) < 5e-4
best = None
for k in range(1, N):
    mu = sqrt(p2 / (k + k * k / (N - k))); a = k * mu / (N - k)
    v = -k * mu ** 3 + (N - k) * a ** 3
    if mu <= m + 1e-12 and (best is None or v < best[1]):
        best = (k, v, mu)
print(f"      integer two-atom search: k={best[0]}, p_3={best[1]:.4f}, mu={best[2]:.4f}"
      f"  -- docstring says -3.6108: "
      f"{'reproduced' if abs(best[1]+3.6108)<5e-4 else 'NOT REPRODUCED by this search'}")
print("    -2.4046 and -3.9585 reproduce exactly; both are emitted by NO code in")
print("    the repository, in this file or any other.")
