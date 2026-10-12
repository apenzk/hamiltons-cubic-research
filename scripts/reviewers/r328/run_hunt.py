"""M4 hunt: critical points at n=5..8 and their saturation slack. Logs as it goes."""
import numpy as np, sys, os, time, json
sys.path.insert(0, os.path.dirname(__file__))
import core, points, lemma70, search

LOG = 'agent_logs/r328-lemma71.log'
def log(s):
    with open(LOG, 'a') as f: f.write(s + '\n'); f.flush()

def analyse(n, W):
    res, th = core.crit_res(n, W)
    dmax, dmin, off, (lam, lmin, lmax, m, h, r) = lemma70.saturation(n, W)
    # Lemma 70 identity check: theta = lmin + (n-2) lmax - D/|lmin|
    pred = lmin + (n - 2) * lmax - dmax / abs(lmin)
    return dict(theta=th, res=res, wdist=core.weyl_dist(n, W), Dmax=dmax, Dmin=dmin,
                off=off, dm=m.shape[1], dh=h.shape[1], dr=r.shape[1],
                lmin=lmin, lmax=lmax, ratio=lmax/abs(lmin), id_err=abs(pred - th),
                nspec=len(np.unique(np.round(lam, 7))), rank=int(np.sum(np.abs(lam) > 1e-8)))

def seeds(n, rng, nrand):
    d = core.weyl_basis(n).shape[0]
    out = [rng.normal(size=d) for _ in range(nrand)]
    # structured: paddings of lower-dimensional critical points, perturbed
    struct = []
    for ns in range(4, n):
        if ns == 4:
            struct.append(points.pad(n, points.cp2(4), 4))
        if ns % 2 == 0 and ns >= 6:
            struct.append(points.pad(n, points.sphere_product(ns, ns // 2), ns))
        for k in range(2, ns - 1):
            struct.append(points.pad(n, points.sphere_product(ns, k), ns))
    for k in range(2, n - 1):
        struct.append(points.block_proj(n, [list(range(k)), list(range(k, n))]))
    struct.append(points.maximal_torus(n))
    for S in struct:
        S = core.weyl_proj(n, S)
        if np.linalg.norm(S) < 1e-9: continue
        S = S / np.linalg.norm(S)
        x = search.coords(n, S)
        out.append(x)
        for eps in (0.05, 0.2, 0.5):
            out.append(x + eps * rng.normal(size=len(x)))
    return out

def run(n, nrand, tag=''):
    rng = np.random.default_rng(1000 + n)
    S = seeds(n, rng, nrand)
    log(f'[hunt n={n}] {len(S)} seeds, dim Weyl={core.weyl_basis(n).shape[0]}')
    found = []
    t0 = time.time()
    for i, x0 in enumerate(S):
        try:
            x, r = search.solve(n, x0 / np.linalg.norm(x0))
        except Exception as e:
            continue
        if r > 1e-9 or not np.all(np.isfinite(x)): continue
        W = search.mat(n, x)
        if np.linalg.norm(W) < 1e-9: continue
        a = analyse(n, W)
        if abs(a['theta']) < 1e-8: continue
        found.append(a)
        if time.time() - t0 > 150:
            best = min(found, key=lambda z: z['Dmax'])
            log(f"[hb n={n}] {i+1}/{len(S)} seeds, {len(found)} crits, min Dmax={best['Dmax']:.3e} "
                f"at theta={best['theta']:.6f} dims {best['dm']}/{best['dh']}/{best['dr']}")
            t0 = time.time()
    # deduplicate by (theta, spectrum signature)
    uniq = {}
    for a in found:
        key = (round(a['theta'], 6), a['dm'], a['dh'], a['dr'])
        uniq[key] = a
    rows = sorted(uniq.values(), key=lambda z: z['Dmax'])
    log(f'[hunt n={n}] DONE {len(found)} converged, {len(rows)} distinct')
    for a in rows[:25]:
        log('   theta %+.6f res %.1e wdist %.1e Dmax %.4e off %.3e dims %d/%d/%d rank %d nspec %d ratio %.4f idErr %.1e'
            % (a['theta'], a['res'], a['wdist'], a['Dmax'], a['off'], a['dm'], a['dh'], a['dr'],
               a['rank'], a['nspec'], a['ratio'], a['id_err']))
    sat = [a for a in rows if a['Dmax'] < 1e-9]
    log(f'[hunt n={n}] SATURATING: {len(sat)}' + ''.join(
        ['\n   *** theta %+.6f dims %d/%d/%d rank %d nspec %d' % (a['theta'], a['dm'], a['dh'], a['dr'], a['rank'], a['nspec']) for a in sat]))
    return rows

if __name__ == '__main__':
    ns = [int(v) for v in sys.argv[1].split(',')]
    nr = int(sys.argv[2])
    for n in ns:
        run(n, nr)
    log('[hunt] ALL DONE ' + str(ns))
