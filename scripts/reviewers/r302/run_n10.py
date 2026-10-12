import sys, os, time
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from run_validate import analyse, log
from points import sphere_product, c5_blowup

if __name__ == '__main__':
    log("[p1] n=10 validation start")
    out = {}
    for nm, f in [("C5blowup", c5_blowup),
                  ("S4xS6", lambda: sphere_product(4, 6)),
                  ("S3xS7", lambda: sphere_product(3, 7)),
                  ("S5xS5", lambda: sphere_product(5, 5))]:
        g, W = f()
        r = analyse(nm, g, W)
        vals = np.round(r['spec'], 9)
        u, c = np.unique(vals, return_counts=True)
        log(f"   {nm} Sym0 spectrum: " + ", ".join(f"{a:.6f}x{b}" for a, b in zip(u, c)))
        np.save(f'/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/r302_{nm}_M.npy', r['M'])
    log("[p1] n=10 done")
