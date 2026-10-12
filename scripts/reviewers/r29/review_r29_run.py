import sys, time
sys.path.insert(0, 'scripts/lib')
import numpy as np
from review_r29_core import Alg, weyl_basis, ip, theta0
from review_r29_points import invariant_subspace, from_coords, newton_critical
from review_r29_catalogue import block_gens, u_m_gens, sp_gens
from review_r29_spec import report

def bound(D, one, half):
    """C-S bound on S2 given `one` eigenvalues =1 and `half` eigenvalues =1/2."""
    rest = D - one - half
    if rest <= 0:
        return one + half / 4.0
    return one + half / 4.0 + (one + half / 2.0) ** 2 / rest

def line(r, n):
    D = r['D']; th = r['theta']; kap = (2*n-1)*(n-1)/4.0
    b_claim = bound(D, 1, r['orb'])
    b_obs = bound(D, r['one_mult'], r['half_mult'])
    th_claim = np.sqrt(kap / b_claim); th_obs = np.sqrt(kap / b_obs)
    t0 = theta0(n)
    print(f"{r['name']:<22} th={th:.7f} res={r['resid']:.0e} orb={r['orb']:<3} m(1)={r['one_mult']:<2} "
          f"m(1/2)={r['half_mult']:<3} orb1/2err={r['orbit_half_err']:.1e} th^2S2={r['th2S2']:.6f} "
          f"S2={r['S2']:.4f} S2claim={b_claim:.4f} S2obs={b_obs:.4f} "
          f"bnd/th0={th_claim/t0:.4f} obsbnd/th0={th_obs/t0:.4f} th2S3={r['th2S3']:+.5f} l2={r['lam2']:+.5f}",
          flush=True)

if __name__ == '__main__':
    mode = sys.argv[1]
    if mode == 'named':
        specs = [(6, [('S3xS3', block_gens(6,[3,3])), ('S2xS4', block_gens(6,[2,4])),
                      ('S2xS2xS2', block_gens(6,[2,2,2])), ('CP3', u_m_gens(3))]),
                 (7, [('S3xS4', block_gens(7,[3,4])), ('S2xS5', block_gens(7,[2,5])),
                      ('S2xS2xS3', block_gens(7,[2,2,3]))]),
                 (8, [('S4xS4', block_gens(8,[4,4])), ('S3xS5', block_gens(8,[3,5])),
                      ('S2xS6', block_gens(8,[2,6])), ('S2xS2xS4', block_gens(8,[2,2,4])),
                      ('S2xS3xS3', block_gens(8,[2,3,3])), ('S2^4', block_gens(8,[2,2,2,2])),
                      ('CP4', u_m_gens(4)), ('HP2', sp_gens(2))]),
                 (9, [('S4xS5', block_gens(9,[4,5])), ('S3xS3xS3', block_gens(9,[3,3,3])),
                      ('S2xS2xS2xS3', block_gens(9,[2,2,2,3]))]),
                 (10,[('S5xS5', block_gens(10,[5,5])), ('S2xS2xS3xS3', block_gens(10,[2,2,3,3])),
                      ('S2^5', block_gens(10,[2,2,2,2,2])), ('CP5', u_m_gens(5))])]
        only = set(int(x) for x in sys.argv[2:]) if len(sys.argv) > 2 else None
        for n, items in specs:
            if only and n not in only: continue
            a = Alg(n); B, _, _ = weyl_basis(a)
            print(f"=== n={n} D={B.shape[0]} kappa={(2*n-1)*(n-1)/4} theta0={theta0(n):.7f}")
            for label, gens in items:
                V = invariant_subspace(a, B, gens)
                rng = np.random.default_rng(7)
                seen = []
                starts = [V[0], -V[0]] if V.shape[0] == 1 else [V.T @ rng.standard_normal(V.shape[0]) for _ in range(14)]
                for v0 in starts:
                    v, th, res = newton_critical(a, B, v0, iters=400)
                    if res > 1e-9 or th <= 1e-6: continue
                    if any(abs(abs(v @ w) - 1) < 1e-6 for w in seen): continue
                    seen.append(v)
                    r = report(a, B, v, f"{label}#{len(seen)-1}", rtol=1e-6)
                    line(r, n)
    elif mode == 'random':
        n = int(sys.argv[2]); ntry = int(sys.argv[3])
        a = Alg(n); B, _, _ = weyl_basis(a); D = B.shape[0]
        print(f"=== random critical points n={n} D={D} kappa={(2*n-1)*(n-1)/4} theta0={theta0(n):.7f}")
        rng = np.random.default_rng(1234)
        seen = []
        for t in range(ntry):
            v, th, res = newton_critical(a, B, rng.standard_normal(D), iters=400)
            if res > 1e-9 or th <= 1e-6: continue
            if any(abs(abs(v @ w) - 1) < 1e-6 for w in seen): continue
            seen.append(v)
            r = report(a, B, v, f"rand#{len(seen)-1}", rtol=1e-6)
            line(r, n)
