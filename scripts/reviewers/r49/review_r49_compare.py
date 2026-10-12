"""Reviewer 49 phase P1b: run the repository's own code and compare it to mine.

A reimplementation written from a description can only confirm the description.
This runs scripts/review_r30_core.py (the module b_block_sum_law.py imports) and
scripts/b_block_sum_law.py itself, and diffs their outputs against my machinery.
"""
import sys
import numpy as np
sys.path.insert(0, 'scripts/lib')
import review_r49_core as C
import review_r30_core as R          # repository code, run not copied
import b_block_sum_law as BL         # repository code under audit


def main():
    print("=== structure constants: repo vs mine ===", flush=True)
    for n in (4, 5, 6, 7):
        print(f"  n={n}: max|c_repo - c_mine| = {np.abs(R.structure_constants(n) - C.struct(n)).max():.2e}",
              flush=True)

    print("\n=== Q and sphere operators: repo vs mine ===", flush=True)
    rng = np.random.default_rng(77)
    for n in (4, 5, 6, 7, 8):
        Bm = C.weyl_basis(n); Br = R.weyl_basis(n)
        print(f"  n={n}: dim repo={Br.shape[0]} mine={Bm.shape[0]}", end="", flush=True)
        X = np.einsum('k,kij->ij', rng.standard_normal(Bm.shape[0]), Bm)
        dq = np.abs(R.Q(n, X) - C.Qmap(n, X)).max()
        # same subspace?
        Fm = Bm.reshape(Bm.shape[0], -1); Fr = Br.reshape(Br.shape[0], -1)
        gap = np.linalg.norm(Fr - Fr @ Fm.T @ Fm)
        print(f"  max|Q_repo-Q_mine|={dq:.2e}  subspace gap={gap:.2e}", flush=True)

    print("\n=== sphere_product_W: repo vs mine ===", flush=True)
    for blocks in [(3, 3), (2, 4), (4, 4), (5, 5), (6, 6), (3, 3, 3)]:
        Wr, _ = R.sphere_product_W(blocks)
        Wm = C.sphere_product(blocks)
        print(f"  {blocks}: max diff {np.abs(Wr - Wm).max():.2e}", flush=True)

    print("\n=== b_block_sum_law.block_sum: repo output vs my recomputation ===", flush=True)
    print(f"{'blocks':>22} {'repo theta':>12} {'repo pred':>12} {'repo resid':>10} "
          f"{'mine theta':>12} {'mine resid':>10} {'|diff|':>9}", flush=True)
    for (pA, nA, pB, nB) in [((3, 3), 6, (3, 3), 6), ((3, 3), 6, (2, 4), 6), ((4, 4), 8, (3, 3), 6),
                             ((4, 4), 8, (2, 4), 6), ((5, 5), 10, (3, 3), 6)]:
        thA, thB, th, pred, res = BL.block_sum(pA, nA, pB, nB)
        # my own construction of the same point
        n = nA + nB
        WA = C.normalize(C.sphere_product(pA))
        WB = C.normalize(C.sphere_product(pB))
        tA = C.Pval(nA, WA); tB = C.Pval(nB, WB)
        tp = 1.0 / np.sqrt(1 / tA**2 + 1 / tB**2)
        W = (tp / tA) * C.embed(WA, nA, n, tuple(range(nA))) + \
            (tp / tB) * C.embed(WB, nB, n, tuple(range(nA, n)))
        W = C.normalize(W)
        rm, tm = C.crit_residual(n, W)
        lbl = f"S^{pA[0]}xS^{pA[1]}+S^{pB[0]}xS^{pB[1]}"
        print(f"{lbl:>22} {th:12.9f} {pred:12.9f} {res:10.1e} {tm:12.9f} {rm:10.1e} "
              f"{abs(th-tm):9.1e}", flush=True)


if __name__ == "__main__":
    main()
