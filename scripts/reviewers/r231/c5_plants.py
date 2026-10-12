"""r231 claim 5: can the guards in run_second_kind_moment.py actually fire?

The file's two live asserts are
  A1  p_2 = 3/4 in BOTH index orders (Bianchi), tol 1e-9
  A2  p_3^min < 0 at every n, computed with m = (n/(n-1)) theta_0(n)

Each is re-executed here on a MUTATED input, outside the file under review.
A guard that cannot fire is decoration.
"""
import importlib.util as il, io, contextlib, numpy as np

def load(name):
    sp = il.spec_from_file_location(name[:-3], f"scripts/runs/{name}")
    m = il.module_from_spec(sp)
    with contextlib.redirect_stdout(io.StringIO()):
        sp.loader.exec_module(m)
    return m

sk = load("run_secondkind_sign.py")
cat = load("run_bispectral_catalogue.py")

def p2(W, order):
    e = np.linalg.eigvalsh(sk.ring(W, order))
    return (e ** 2).sum()

def A1(W, order, label):
    """the file's assert, verbatim in condition and tolerance"""
    v = p2(W, order)
    fired = not (abs(v - 0.75) < 1e-9)
    print(f"    {label:<46} order={order}  p_2={v:.10f}  "
          f"{'FIRES' if fired else 'silent'}")
    return fired

n = 12
W0 = cat.sphere_product(n // 2, n // 2)
W0 = W0 / np.sqrt(np.einsum('ijkl,ijkl->', W0, W0))

print("  A1 -- the p_2 = 3/4 assert (Bianchi)")
print("  baseline, unmutated (must stay silent):")
ok = [A1(W0, o, "S^6 x S^6, unit norm") for o in ('iklj', 'ikjl')]
assert not any(ok), "the baseline itself fires -- the guard is miscalibrated"

print("\n  PLANT 1: drop the unit normalisation (W scaled by 1.05).")
print("           p_2 is quadratic in W, so 0.75 -> 0.75*1.05^2 = 0.826875")
f = [A1(1.05 * W0, o, "W -> 1.05 W") for o in ('iklj', 'ikjl')]
assert all(f), "PLANT 1 did not fire -- the p_2 guard is decoration"

print("\n  PLANT 2: break Bianchi itself, keeping the norm exactly 1.")
print("           this is the failure mode the assert's message names")
rng = np.random.default_rng(3)
def weyl_symmetrise(A):
    A = A - A.transpose(1, 0, 2, 3); A = A - A.transpose(0, 1, 3, 2)
    return A + A.transpose(2, 3, 0, 1)
print("           (p_2 deviates QUADRATICALLY in the defect, so record the floor)")
for eps in (1e-1, 1e-3, 1e-4, 1e-5, 1e-6):
    B = weyl_symmetrise(rng.normal(size=(n,) * 4))
    B = B / np.sqrt(np.einsum('ijkl,ijkl->', B, B))
    Wp = W0 + eps * B
    Wp = Wp / np.sqrt(np.einsum('ijkl,ijkl->', Wp, Wp))
    bia = np.abs(Wp + Wp.transpose(1, 2, 0, 3) + Wp.transpose(2, 0, 1, 3)).max()
    f = [A1(Wp, o, f"Bianchi defect {bia:.2e} (eps={eps:g})") for o in ('iklj', 'ikjl')]
    if eps >= 1e-4:
        assert all(f), f"PLANT 2 at eps={eps} did not fire"

print("\n  A2 -- the p_3^min < 0 assert")
from math import sqrt
def theta0(k): return sqrt(2 * (k - 1) * (k - 2)) / k
def lo_of(m, N): return 9 / (16 * m * N) - 3 * m / 4
print("  as the file computes it, m = (n/(n-1)) theta_0(n):")
for k in (12, 24, 100):
    N = k * (k + 1) // 2 - 1
    m = (k / (k - 1)) * theta0(k)
    print(f"    n={k:>4}  m={m:.6f}  p_3^min={lo_of(m, N):+.6f}  "
          f"{'FIRES' if not lo_of(m, N) < 0 else 'silent'}")
print("  PLANT 3: the same assert on the m the file's OWN LAST TABLE uses,")
print("           m = -min(omega) measured in order iklj:")
viol = 0
for k in (12, 14, 16, 24):
    Wn = cat.sphere_product(k // 2, k // 2)
    Wn = Wn / np.sqrt(np.einsum('ijkl,ijkl->', Wn, Wn))
    om = np.sort(np.linalg.eigvalsh(sk.ring(Wn, 'iklj')))[1:]
    N, m = len(om), -om.min()
    lo = lo_of(m, N)
    fired = not (lo < 0)
    viol += fired
    print(f"    n={k:>4}  m={m:.6f}  p_3^min={lo:+.6f}  "
          f"{'WOULD FIRE' if fired else 'silent'}")
assert viol == 4, "expected the file's own printed table to violate its own assert"
print("\n  The file's last table prints p_3^min > 0 at every n, which is exactly")
print("  what A2 declares makes 'the route as framed make no sense' -- but A2 is")
print("  scoped to a different m and never sees it.")
