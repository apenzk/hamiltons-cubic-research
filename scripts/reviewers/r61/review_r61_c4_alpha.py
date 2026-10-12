"""Reviewer 61 / C4: does the semidefinite infeasibility depend on the singular
values, or only on the multiplicity pattern?  C3's root argument says the
centraliser quantity is alpha-independent; this checks the SDP directly with
several draws per pattern, including deliberately special ratios."""
import numpy as np, sys
from review_r61_c4_sdp_sweep import margin_one, xvec
from review_r61_c2_c3 import partitions

if __name__ == '__main__':
    rng = np.random.default_rng(71)
    for m in (6, 8):
        p = m//2
        print(f"=== m={m} ===")
        for mults in partitions(p):
            r = len(mults)
            draws = [np.arange(1, r+1)*1.0,
                     np.array([2.0**k for k in range(r)]),
                     np.array([1.0 + 1e-6*k for k in range(r)]),
                     np.sort(rng.uniform(0.2, 5.0, r))[::-1]]
            vals = []
            for al in draws:
                al = np.array(al, float)
                if len(set(np.round(al, 12))) < r:
                    al = al + 1e-3*np.arange(r)
                vals.append(margin_one(m, xvec(m, mults, al), +1))
            print(f"  mult={str(mults):14s} margins over 4 alpha draws: "
                  + "  ".join(f"{v:+.3e}" for v in vals))
            sys.stdout.flush()
