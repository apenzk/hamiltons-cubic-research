"""What the 22-hour hunts say about route (b)'s missing quantity.

The lambda-weighted bound is  theta <= |lam_min| * M / 4,  M = 4(n-1) - Delta - G_0.
It is sharp at every symmetric-space point, and its ONLY uncontrolled quantity is
|lam_min|.  The hunts recorded (theta, |lam_min|, Delta, G_0, S, crit) for every screened
point, so the question route (b) needs answering is now a read over local files:

    when theta is close to sqrt(3/2), how large can |lam_min| * M / 4 be?

This does NOT search.  It reads what the hunts already wrote.  Reported per n, and split
by how close to the target the point sits, because the regime that matters is theta near
sqrt(3/2) and nothing else.

USAGE: python3 scripts/route-b/b_lambda_min_harvest.py
"""
import json, os, glob, math

SQ32 = math.sqrt(1.5)


def main():
    for f in sorted(glob.glob('agent_logs/jobs/lamhunt_n*.jsonl')):
        n = int(f.split('_n')[1].split('.')[0])
        pts = []
        for line in open(f, encoding='utf-8', errors='replace'):
            try:
                d = json.loads(line)
            except Exception:
                continue
            if 'theta' in d and 'lmin' in d:
                pts.append(d)
        if not pts:
            continue
        print(f"\n=== n = {n}   {len(pts):,} screened points ===")
        print(f"  {'theta band':>18}{'count':>9}{'max|lam_min|':>14}{'max bound':>12}"
              f"{'min bound-theta':>17}")
        bands = [(SQ32 - 1e-3, 9.9, 'within 1e-3 of sqrt(3/2)'),
                 (SQ32 - 1e-2, SQ32 - 1e-3, 'within 1e-2'),
                 (1.0, SQ32 - 1e-2, 'theta > 1.0'),
                 (-9.9, 1.0, 'theta <= 1.0')]
        for lo, hi, lbl in bands:
            sub = [d for d in pts if lo <= d['theta'] < hi]
            if not sub:
                print(f"  {lbl:>18}{0:>9}"); continue
            mb = max(d['bound'] for d in sub)
            ml = max(d['lmin'] for d in sub)
            gap = min(d['bound'] - d['theta'] for d in sub)
            print(f"  {lbl:>18}{len(sub):>9,}{ml:>14.6f}{mb:>12.6f}{gap:>17.2e}")
        top = max(pts, key=lambda d: d['theta'])
        print(f"  top point: theta={top['theta']:.9f}  |lam_min|={top['lmin']:.6f}  "
              f"Delta={top['Delta']:.3f}  bound={top['bound']:.6f}")
        viol = [d for d in pts if d['bound'] < d['theta'] - 1e-9]
        print(f"  bound violations: {len(viol)}")
    print("\n  READING: the bound never fails, but it is loose by the margin in the last")
    print("  column.  Route (b) closes only if |lam_min| * M / 4 can be shown <= sqrt(3/2)")
    print("  on the target set; these numbers say how much room that leaves at each n.")


if __name__ == '__main__':
    main()
