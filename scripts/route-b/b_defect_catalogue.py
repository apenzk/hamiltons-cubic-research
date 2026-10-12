"""Where the symmetry defect sits across the whole saved catalogue.

Delta(W) and its consequences are defined and proved in [b_symmetry_defect.py].  This
script asks the question that decides whether the reduction is worth a cycle: on the
target set {S = 0}, how high can theta go once Delta > 0?

It reads the witnesses this project already saved rather than searching for new ones --
the frontier points, the recorded UNGRADED record at theta = 0.9067, the gap-band
point, the defect witnesses, and the best two-negative stratum points -- and reports
theta, Delta, and the two grading conditions side by side.

WHAT IT ESTABLISHES.
  * Delta = 0 at every catalogued point with theta >= 0.98, including all three
    frontier points sitting exactly at sqrt(3/2) and the balanced product at theta_0.
  * On {S_mmm = 0}, every point with Delta > 0 has theta <= 0.671 (the C_5 blow-up).
    The margin to sqrt(3/2) = 1.224745 is 0.554.
  * Off {S_mmm = 0} the picture is looser: the r61 m = 6 stratum point reaches
    theta = 1.187 with Delta = 2.05, so Delta > 0 does NOT cap theta on its own.
    Any bound must carry S = 0 as a hypothesis.
  * No catalogued point is graded with Delta > 0, nor ungraded with Delta = 0, so on
    this catalogue the two coincide -- which is evidence, not a theorem, since
    Delta = 0 is formally the stronger condition (it asks ad(x) to preserve EVERY
    eigenspace, gradedness only p and m).

FALSIFIER for the next cycle's target: a point with S_mmm = 0, Delta > 0 and
theta > sqrt(3/2).
"""
import numpy as np, os, sys
sys.path.insert(0, 'scripts/lib')
from b_symmetry_defect import defect, cpm_W, pad
from review_r30_core import sphere_product_W
from b_c5_blowup import c5_operator

def _repo_root():
    # walk up to the checkout rather than counting directory levels, so this file
    # keeps working wherever under scripts/ it is filed
    d = os.path.dirname(os.path.abspath(__file__))
    while d != os.path.dirname(d):
        if os.path.exists(os.path.join(d, 'plan.md')):
            return d
        d = os.path.dirname(d)
    return os.getcwd()


ROOT = _repo_root()

WITNESSES = [
    ('scripts/data/frontier_n6_th1.224745_d20.111111.npy',   6, 'frontier n=6  theta=sqrt(3/2)'),
    ('scripts/data/frontier_n8_th1.224745_d20.111111.npy',   8, 'frontier n=8  theta=sqrt(3/2)'),
    ('scripts/data/frontier_n12_th1.224745_d20.111111.npy', 12, 'frontier n=12 theta=sqrt(3/2)'),
    ('scripts/data/frontier_n12_th1.236033_d20.000000.npy', 12, 'frontier n=12 theta=theta_0'),
    ('scripts/data/review_r40_W_cpm3.npy',                   6, 'CP^3 (r40)'),
    ('scripts/data/review_r40_W_cpm4.npy',                   8, 'CP^4 (r40)'),
    ('scripts/data/gap_band_point_n8.npy',                   8, 'gap-band n=8'),
    ('agent_logs/review_r12_ungraded_record_n8.npy',    8, 'r12 UNGRADED record n=8'),
    ('agent_logs/review_r12_rhs_breaker_n8.npy',        8, 'r12 rhs-breaker n=8'),
    ('scripts/data/defect_theta0_n8_0.125000.npy',           8, 'defect theta_0 n=8'),
    ('scripts/data/defect_violation_n8_0.120000.npy',        8, 'defect violation n=8'),
    ('agent_logs/j5cross_n5_newcrit_th0.882.npy',       5, 'j5cross new crit n=5'),
    ('scripts/data/review_r61_best_stratum_m6.npy',          6, 'r61 best stratum m=6'),
    ('scripts/data/review_r61_best_stratum_m8.npy',          8, 'r61 best stratum m=8'),
]

SQ32 = np.sqrt(1.5)


def main():
    print(f"  {'point':30s}{'n':>3s}{'theta':>10s}{'d':>4s}{'#0':>4s}"
          f"{'S_mmm':>10s}{'Delta':>9s}{'S_mpp':>9s}{'4(n-1)':>8s}  graded?")
    rows = []
    built = [(sum(b), sphere_product_W(b)[0], f"S^{b[0]} x S^{b[1]}")
             for b in ([6, 6], [5, 7], [4, 8], [3, 3])]
    built += [(2 * m, cpm_W(m), f"CP^{m}") for m in (2, 3, 4)]
    built += [(8, pad(cpm_W(2), 4, 8), "CP^2 padded n=8"),
              (8, pad(sphere_product_W([3, 3])[0], 6, 8), "S^3xS^3 padded n=8"),
              (10, c5_operator([2] * 5)[0], "C_5 blow-up n=10")]
    for n, W, lbl in built:
        th, ok, d, D, tot, Smmm, Smpp, z = defect(n, W)
        graded = Smmm < 1e-8 and Smpp < 1e-8
        rows.append((lbl, n, th, ok, d, D, Smmm, Smpp, graded))
        print(f"  {lbl:30s}{n:>3d}{th:>10.6f}{d:>4d}{z:>4d}{Smmm:>10.4f}"
              f"{D:>9.4f}{Smpp:>9.4f}{tot:>8.1f}  {'YES' if graded else 'no'}")

    for rel, n, lbl in WITNESSES:
        path = os.path.join(ROOT, rel)
        if not os.path.exists(path):
            print(f"  {lbl:30s}  MISSING {rel}")
            continue
        W = np.load(path, allow_pickle=True).astype(float)
        N = n * (n - 1) // 2
        if W.shape != (N, N):
            print(f"  {lbl:30s}  shape {W.shape}, expected ({N},{N})")
            continue
        th, ok, d, D, tot, Smmm, Smpp, z = defect(n, W)
        graded = Smmm < 1e-8 and Smpp < 1e-8
        rows.append((lbl, n, th, ok, d, D, Smmm, Smpp, graded))
        print(f"  {lbl:30s}{n:>3d}{th:>10.6f}{d:>4d}{z:>4d}{Smmm:>10.4f}"
              f"{D:>9.4f}{Smpp:>9.4f}{tot:>8.1f}  {'YES' if graded else 'no'}")

    print("\n=== the two questions this table answers ===")
    s0 = [r for r in rows if r[6] < 1e-8]
    s0d = [r for r in s0 if r[5] > 1e-8]
    print(f"  on S_mmm = 0 with Delta > 0 ({len(s0d)} points): "
          f"max theta = {max((r[2] for r in s0d), default=float('nan')):.6f}"
          f"   margin to sqrt(3/2) = {SQ32 - max((r[2] for r in s0d), default=0):.6f}")
    off = [r for r in rows if r[6] >= 1e-8 and r[5] > 1e-8]
    print(f"  off S_mmm = 0 with Delta > 0 ({len(off)} points): "
          f"max theta = {max((r[2] for r in off), default=float('nan')):.6f}"
          f"  -- so Delta > 0 alone does NOT cap theta; S = 0 must be carried.")
    bad = [r for r in rows if (r[8] and r[5] > 1e-8) or ((not r[8]) and r[5] < 1e-8)]
    print(f"  points where graded and Delta = 0 disagree: {len(bad)}"
          + ("" if not bad else "  <-- " + ", ".join(r[0] for r in bad)))


if __name__ == '__main__':
    main()
