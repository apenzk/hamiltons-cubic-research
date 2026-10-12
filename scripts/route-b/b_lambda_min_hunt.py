"""Route (b)'s missing ingredient: how small can |lam_min| be on {S = 0, non-diagonal}?

WHY THIS JOB EXISTS.  The lambda-weighted bound

    theta  <=  |lam_min| * ( 4(n-1) - Delta - G_0 ) / 4

is sharp at every symmetric-space point and is the only attack of the right shape on the
live target (one inequality over all W, not an enumeration -- fence post 9).  Its single
uncontrolled quantity is |lam_min|.  If |lam_min| is bounded above on the target set by
something small enough, the bound closes the target outright.

WHAT IT DOES.  Long-running, self-contained, writes everything to disk, needs no polling.
Two things at once, both cheap per sample and both cumulative:

  (1) BOUND HUNT.  Over random Weyl tensors and projected-gradient walks constrained to
      S = 0, record the joint distribution of (|lam_min|, Delta, G_0, theta) and keep the
      running maximum of theta and of the BOUND ITSELF.  The bound's max over the set is
      what route (b) needs; the max of theta is a sanity floor.

  (2) FALSIFIER HUNT.  Any point that is Weyl, critical, S = 0, NON-DIAGONAL (by the
      ker Phi test, which decides both ways) and has theta > sqrt(3/2) refutes the live
      target.  Nothing has ever been found above it; a long null run is the evidence base,
      and a hit ends the programme's current route in one line.

Every candidate is screened before it counts: theta_screened for Weyl-ness, criticality
residual, S_mmm, and diagonality.  A number that fails any screen is never recorded --
this project has twice put relaxation values into the record as Weyl values.

OUTPUT.  agent_logs/jobs/lamhunt_n<N>.jsonl, one JSON line per accepted point, plus a
RUNNING BEST line every 200 accepted so a reader can tail it. Resumable: re-running
appends.

USAGE:  python3 scripts/route-b/b_lambda_min_hunt.py <n> [hours]
"""
import json, os, sys, time
import numpy as np

sys.path.insert(0, 'scripts/lib')
from review_r30_core import pair_index, weyl_basis
from weyl_screen import critical_screened
from b_frame_independent_diagonality import diagonalisable

SQ32 = np.sqrt(1.5)
ROOT = os.getcwd()


def phis(n):
    pairs, _ = pair_index(n)
    P = np.zeros((len(pairs), n, n))
    for a, (i, j) in enumerate(pairs):
        P[a, i, j] = 1.0; P[a, j, i] = -1.0
    return P


def profile(n, W, P, tol=1e-9):
    """(theta, info, S_mmm, |lam_min|, Delta, G_0) -- all screened."""
    W = W / np.sqrt(np.sum(W * W))
    th, info = critical_screened(n, W)
    lam, V = np.linalg.eigh(W)
    v = np.einsum('ag,gij->aij', V.T, P)
    br = np.einsum('aik,bkj->abij', v, v) - np.einsum('bik,akj->abij', v, v)
    T = (0.5 * np.einsum('abij,cij->abc', br, v)) ** 2
    g = np.einsum('dab,ab->d', T, (lam[:, None] - lam[None, :]) ** 2)
    m = lam < -tol; p = lam > tol; z = ~m & ~p
    S = float(T[np.ix_(m, m, m)].sum())
    return th, info, S, abs(float(lam.min())), float(g[p].sum()), float(g[z].sum())


def main():
    n = int(sys.argv[1])
    hours = float(sys.argv[2]) if len(sys.argv) > 2 else 20.0
    out = os.path.join(ROOT, 'agent_logs', 'jobs', f'lamhunt_n{n}.jsonl')
    os.makedirs(os.path.dirname(out), exist_ok=True)
    B = weyl_basis(n); P = phis(n)
    rng = np.random.default_rng(int(time.time()) ^ (n * 7919))
    deadline = time.time() + hours * 3600
    best_th = -np.inf; best_bound = -np.inf; acc = 0; tried = 0
    f = open(out, 'a', buffering=1)
    f.write(json.dumps({"START": time.strftime('%F %T'), "n": n, "hours": hours}) + "\n")
    while time.time() < deadline:
        tried += 1
        co = rng.normal(size=B.shape[0])
        W = np.tensordot(co, B, axes=([0], [0]))
        # short projected ascent on theta, staying inside Weyl_n by construction
        for _ in range(60):
            W = W / np.linalg.norm(W)
            th, info, S, lmin, D, G0 = profile(n, W, P)
            grad = np.tensordot(np.einsum('dij,ij->d', B, _q(n, W)), B, axes=([0], [0]))
            W = W + 0.15 * (grad - np.tensordot(np.einsum('dij,ij->d', B, W), B, axes=([0], [0])) * th)
        W = W / np.linalg.norm(W)
        th, info, S, lmin, D, G0 = profile(n, W, P)
        if not info['is_weyl']:
            continue
        M = 4 * (n - 1) - D - G0
        bound = lmin * M / 4.0
        rec = {"theta": th, "crit": info['crit_res'], "S": S, "lmin": lmin,
               "Delta": D, "G0": G0, "bound": bound}
        if S < 1e-8 and info['is_critical']:
            v, _k = diagonalisable(n, W)
            rec["diag"] = v
            if v.startswith('NON-DIAG') and th > SQ32:
                f.write(json.dumps({"FALSIFIER": rec}) + "\n")
                np.save(out.replace('.jsonl', f'_falsifier_{th:.6f}.npy'), W)
        acc += 1
        f.write(json.dumps(rec) + "\n")
        best_th = max(best_th, th); best_bound = max(best_bound, bound)
        if acc % 200 == 0:
            f.write(json.dumps({"RUNNING_BEST": {"tried": tried, "accepted": acc,
                    "max_theta": best_th, "max_bound": best_bound,
                    "elapsed_h": round((time.time() - deadline + hours*3600)/3600, 2)}}) + "\n")
    f.write(json.dumps({"DONE": time.strftime('%F %T'), "tried": tried, "accepted": acc,
                        "max_theta": best_th, "max_bound": best_bound}) + "\n")
    f.close()


def _q(n, W):
    from review_r30_core import Q
    return Q(n, W)


if __name__ == '__main__':
    main()
