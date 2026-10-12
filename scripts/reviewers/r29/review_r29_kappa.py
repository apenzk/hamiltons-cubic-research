"""R29 attack 4 (extended): fit kappa_W at n=5..12 with several independent random pairs."""
import sys, time
sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r29_core import Alg, weyl_basis, ip, L_matrix

for n in [int(v) for v in sys.argv[1:]]:
    t0 = time.time()
    a = Alg(n); B, _, _ = weyl_basis(a); D = B.shape[0]
    rng = np.random.default_rng(2024 + n)
    xs = [np.tensordot(rng.standard_normal(D), B, axes=([0], [0])) for _ in range(3)]
    Ls = [L_matrix(a, B, x) for x in xs]
    tr1 = [np.trace(L) for L in Ls]
    rat = []
    for i in range(3):
        for j in range(i, 3):
            rat.append(np.trace(Ls[i] @ Ls[j]) / ip(xs[i], xs[j]))
    kap = (2*n-1)*(n-1)/4.0
    print(f"n={n:<3} D={D:<5} tr(L_x) max|.|={max(abs(v) for v in tr1):.2e}  "
          f"kappa measured = {np.array2string(np.array(rat), precision=10)}  "
          f"(2n-1)(n-1)/4 = {kap}  maxdev={max(abs(r-kap) for r in rat):.2e}  [{time.time()-t0:.0f}s]", flush=True)
