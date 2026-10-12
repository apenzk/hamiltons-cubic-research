"""R52 M2: run the REPOSITORY solver review_r13_multiblock.multiblock_point and
compare its solution set with the independent one, including the key/value trap."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, time, importlib.util
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
import review_r52_core as K
import review_r52_m2 as M2

LOG = _os.path.join(_ROOT, 'agent_logs/review_r52_multiblock.log')
def log(m):
    line = f"[{time.strftime('%H:%M:%S')}] {m}"
    print(line, flush=True)
    open(LOG, 'a').write(line + '\n')

spec = importlib.util.spec_from_file_location(
    "r13mb", _os.path.join(_ROOT, "scripts/review_r13_multiblock.py"))
r13mb = importlib.util.module_from_spec(spec)
spec.loader.exec_module(r13mb)

if __name__ == '__main__':
    log("PHASE 3b: repository solver (review_r13_multiblock.multiblock_point)")
    for blocks in [(3, 3, 3), (4, 4, 4), (2, 5, 5), (3, 4, 5), (2, 2, 8), (3, 3, 3, 3)]:
        n = sum(blocks)
        t0 = time.time()
        sols = r13mb.multiblock_point(blocks)
        log(f"  repo {blocks}: {len(sols)} keys [{time.time()-t0:.1f}s]")
        for key, (w, th) in sorted(sols.items(), key=lambda kv: -kv[1][1]):
            W = M2.embed(n, blocks, w)
            nw = np.linalg.norm(W)
            Wn = W / nw if nw > 1e-12 else W
            thc = K.P_val(n, Wn) if nw > 1e-12 else 0.0
            res = np.linalg.norm(K.Q(n, Wn) - thc * Wn) if nw > 1e-12 else 0.0
            Sst = K.slack_structural(n, Wn) if nw > 1e-12 else 0.0
            log(f"      VALUE w_upper={np.round(w[np.triu_indices(len(blocks))],6).tolist()} "
                f"th={th:.7f} embed_th={thc:.7f} resid={res:.1e} S_struct={Sst:.3f}")
            log(f"        (KEY, which is NOT the matrix) = {tuple(np.round(np.array(key),5).tolist())}")
    log("PHASE 3b done")
