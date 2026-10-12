import sys, numpy as np
sys.path.insert(0, 'scripts/lib'); sys.path.insert(0, 'scripts/reviewers/r291')
from r291_core import *
from b_symmetry_defect import defect as record_defect
from review_r30_core import sphere_product_W

rng = np.random.default_rng(291)
print("=== C1/C2/C3 on the diagonal locus: my g vs the record's defect() ===")
for n in (4, 5, 6, 7, 8):
    B = locus_basis(n)
    for t in range(3):
        M = rand_M(n, rng, B)
        W = M_to_W(M)
        D, tot, S, g, lam = defect_mine(n, W)
        gf = g_formula(M)                                  # C1
        # the record's numbers
        th, isw, d, Drec, totrec, Smmm, Smpp, nz = record_defect(n, W)
        # C2 by the closed form
        C2 = sum(2.0 * sum((M[a, dd] - M[b, dd]) ** 2 for dd in range(n) if dd not in (a, b))
                 for (a, b) in pairs_of(n) if M[a, b] > 0)
        e1 = np.abs(np.sort(g) - np.sort(gf)).max()         # g is basis-dependent only inside
        e1b = np.abs(g - gf).max()
        print(f" n={n} |g-gf|inf={e1b:.2e} sorted={e1:.2e}  Delta mine={D:.10f} rec={Drec:.10f} C2={C2:.10f}"
              f"  total={tot:.10f} vs 4(n-1)={4*(n-1)}  S mine={S:.4f} rec={Smmm:.4f} weyl={isw}")

print("\n=== C3: the deficit off the Ricci-flat locus ===")
for n in (4, 5, 6):
    for t in range(3):
        A = rng.normal(size=(n, n)); A = A + A.T; np.fill_diagonal(A, 0.0)
        s = np.sqrt(sum(A[i, j] ** 2 for (i, j) in pairs_of(n))); A /= s
        W = M_to_W(A)
        D, tot, S, g, lam = defect_mine(n, W)
        rs = A @ np.ones(n)
        print(f"  n={n} total={tot:.8f}  4(n-1)-2||M1||^2={4*(n-1)-2*rs@rs:.8f}  ||M1||^2={rs@rs:.6f}"
              f"  sum g_formula={g_formula(A).sum():.8f}")
