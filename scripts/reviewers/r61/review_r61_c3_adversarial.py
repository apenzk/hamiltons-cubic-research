"""Reviewer 61 / C3, adversarial singular-value patterns.  The claimed proof
runs a case analysis on multiplicities; the root-system reading predicts the
answer depends on the multiplicity pattern ONLY (z(c) is contained in the Cartan
whenever no root is proportional to the singular-value vector, which for D_p with
all coordinates positive needs p >= 3).  Test alphas with deliberate rational
relations, near-collisions, and huge spreads."""
import numpy as np
from review_r61_c2_c3 import test, partitions


def sweep(m, cases, rng):
    p = m//2
    for name, al in cases:
        mults = tuple([1]*len(al))
        if len(al) != p:
            continue
        X, dz, dc, dzc, dres, cont = test(m, mults, np.array(al, float), rng)
        flag = "" if dres == 1 else "   <-- NOT 1"
        print(f"  m={m} {name:32s} alphas={al}  dim z(x)={dz:3d} dim c={dc:3d}"
              f" dim z(c)={dzc:3d}  dim(z(c) cap c^perp)={dres}{flag}")


if __name__ == '__main__':
    rng = np.random.default_rng(23)
    print("=== m=4 (the exceptional rank): alpha_1 = alpha_2 is the only escape ===")
    sweep(4, [("equal", [1.0, 1.0]), ("near equal 1e-9", [1.0, 1.0+1e-9]),
              ("ratio 2", [2.0, 1.0]), ("ratio 1+1e-4", [1.0, 1.0001])], rng)
    print("\n=== m=6, adversarial alpha relations ===")
    sweep(6, [("a1=a2+a3", [3.0, 2.0, 1.0]), ("geometric", [4.0, 2.0, 1.0]),
              ("two nearly equal", [1.0, 1.0+1e-8, 2.0]),
              ("huge spread", [1e6, 1.0, 1e-6]),
              ("a1=a2, a3 free (mult 2)", [1.0, 1.0, 3.0]),
              ("all equal", [1.0, 1.0, 1.0]),
              ("root-like (1,1,0) direction", [1.0, 1.0, 1e-9])], rng)
    print("\n=== m=8, adversarial ===")
    sweep(8, [("a=(1,1,1,1)", [1.0]*4), ("a=(3,2,1,1)", [3.0, 2, 1, 1]),
              ("a=(1,1,eps,eps)", [1.0, 1.0, 1e-9, 1e-9]),
              ("sum relation", [6.0, 3.0, 2.0, 1.0])], rng)
    print("\n=== m=10, 12: all-equal and near-degenerate ===")
    sweep(10, [("all equal", [1.0]*5), ("near equal", list(1+1e-9*np.arange(5)))], rng)
    sweep(12, [("all equal", [1.0]*6), ("pairs", [1.0, 1.0, 2.0, 2.0, 3.0, 3.0])], rng)
