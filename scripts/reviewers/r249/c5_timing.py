"""r249 / claim 5: measured cost of the file's 8-index build route, extrapolated
from a safe size.  Measures at n=7,8 (16.7M entries at n=8, 134 MB) and scales
by n^8, which is what the loop `P += einsum('abcd,efgh->abcdefgh', b, b)` costs
per basis element.
"""
import numpy as np, time
def dim_weyl(n): return n*(n+1)*(n+2)*(n-3)//12
rows=[]
for n in (6,7,8):
    b=np.random.default_rng(0).standard_normal((n,)*4)
    P=np.zeros((n,)*8)
    t0=time.time()
    for _ in range(3): P+=np.einsum('abcd,efgh->abcdefgh',b,b)
    per=(time.time()-t0)/3
    rows.append((n,per))
    print(f"  n={n}: one accumulate over n^8={n**8:,} entries: {per*1000:.1f} ms "
          f"({n**8*8*2/per/2**30:.1f} GB/s effective)")
    del P
bw=np.mean([n**8*8*2/per/2**30 for n,per in rows])
n=12; E=n**8
build=dim_weyl(n)*E*8*2/(bw*2**30)
print(f"\n  extrapolation to n=12 at {bw:.1f} GB/s:")
print(f"    array          {E:,} doubles = {E*8/2**30:.2f} GB")
print(f"    build loop     {dim_weyl(n)} accumulates ~ {build/60:.0f} min")
print(f"    P.P check      {2*(n**4)**3/1e12:.1f} Tflop, ~{3*E*8/2**30:.1f} GB resident"
      f" -> {2*(n**4)**3/5e10/60:.0f} min at 50 Gflop/s")
print(f"    degree-6 gluing inserts SIX such P per closed graph, over 720 bijections")
print(f"\n  matrix-free alternative (scripts/reviewers/r249/c15_matrix_free.py):")
print(f"    one application of P at n=12: 0.4 ms, O(n^4)={n**4:,} entries, no storage")
