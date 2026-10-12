"""Test points.  Criticality of each is re-verified independently in r293_d123.crit_res."""
import numpy as np, sys
sys.path.insert(0, 'scripts/lib'); sys.path.insert(0, 'scripts/reviewers/r293')
from review_r30_core import sphere_product_W, weyl_basis, pair_index
from b_symmetry_defect import cpm_W, pad
from b_c5_blowup import c5_operator

def catalogue():
    pts = []
    for b in ([3,3],[6,6],[5,7],[4,8]):
        pts.append((sum(b), sphere_product_W(b)[0], f"S^{b[0]}xS^{b[1]}"))
    for m in (2,3,4):
        pts.append((2*m, cpm_W(m), f"CP^{m}"))
    pts.append((6, pad(cpm_W(2),4,6), "CP^2 padded n=6"))
    pts.append((8, pad(cpm_W(2),4,8), "CP^2 padded n=8"))
    pts.append((10, c5_operator([2]*5)[0], "C_5 blow-up n=10"))
    return pts

def randweyl(n, seed, k=1):
    B = weyl_basis(n); rng = np.random.default_rng(seed)
    return [np.tensordot(rng.normal(size=B.shape[0]), B, axes=([0],[0])) for _ in range(k)]
