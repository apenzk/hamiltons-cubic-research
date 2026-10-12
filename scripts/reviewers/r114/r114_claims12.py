import numpy as np, sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r114_core import *

def sphere_product(blocks, n):
    """W of a product of spheres, blocks = list of block sizes (sum<=n; rest is padding).
    Vertex matrix: w_ij = (n_B - within? ) built from zero-row-sum hollow symmetric with
    +(sum of other blocks)/(n_b-1) inside block b and -1 across blocks."""
    prs, idx = pair_index(n)
    lab = []
    s = 0
    for b, nb in enumerate(blocks):
        lab += [b]*nb; s += nb
    lab += [-1]*(n-s)
    tot = sum(blocks)
    M = np.zeros((len(prs), len(prs)))
    for k,(i,j) in enumerate(prs):
        if lab[i] == -1 or lab[j] == -1: continue
        if lab[i] == lab[j]:
            nb = blocks[lab[i]]
            M[k,k] = (tot-nb)/(nb-1)
        else:
            M[k,k] = -1.0
    return M/np.linalg.norm(M)

def report(name, M, n):
    S = Setup(n)
    th = S.theta(M); res = np.linalg.norm(S.Q(M)-th*M)
    ev = np.linalg.eigvalsh(M)
    nz = [abs(e) for e in ev if abs(e) > 1e-9]
    r = grading_report(S, M)
    print(f"{name:26s} n={n:2d} theta={th: .9f} res={res:.1e} zeros={int((np.abs(ev)<=1e-9).sum()):3d} "
          f"min|l|nz={min(nz):.9f} S={float(r['S']):.2e} Thhm={float(r['T']['hhm']):.2e} "
          f"ker={r['dim_ker']} graded={r['graded_kerfree']}")
    return min(nz), th

print("== Claim 1: padding, zero counts, nonzero-spectrum invariance ==")
for n in [6,8,12]:
    report("S3xS3 padded", sphere_product([3,3], n), n)
print()
print("== Claim 2: balanced product gap vs sqrt2(n-2)/(n sqrt((n-1)(n-2))) ==")
for n in [6,8,10,12,16]:
    g,_ = report(f"S{n//2}xS{n//2}", sphere_product([n//2,n//2], n), n)
    f = np.sqrt(2)*(n-2)/(n*np.sqrt((n-1)*(n-2)))
    print(f"    formula {f:.12f}  deviation {abs(f-g):.2e}")
print()
print("== Claim 2: fixed-n floor among two-block products ==")
for n in [10,12]:
    best=None
    for p in range(2, n//2+1):
        q=n-p
        g,th = report(f"S{p}xS{q}", sphere_product([p,q], n), n)
        if best is None or g<best[0]: best=(g,p,q)
    print(f"  n={n}: minimum gap {best[0]:.6f} at S^{best[1]}xS^{best[2]}")
print()
print("== 4-block interleave check at n=12 ==")
report("S3xS3xS3xS3", sphere_product([3,3,3,3],12), 12)
