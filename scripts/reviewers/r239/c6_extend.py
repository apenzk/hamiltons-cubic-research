"""r239, claim 6 -- push the d=6 column well past 16 to test 'stationary from 12' as a
statement about ALL n, not just the range r237 tabulated."""
import sys, os, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from c6_burnside import dim_inv
from c1_haar_moments import CHI_W

for n in range(12, 27):
    t = time.time()
    v = dim_inv(CHI_W, "W", n, 6)
    print(f"  n={n:2d}: dim (Sym^6 W_n*)^{{B_n}} = {int(v)}   ({time.time()-t:.1f}s)", flush=True)
