"""theta with its Weyl residuals attached, because theta alone is not a Weyl value.

WHY THIS EXISTS.  In a single review cycle, three separate agents -- two reviewers and
the coordinator -- evaluated theta on an operator that was NOT Ricci-flat and read the
result as a value of Conjecture A's functional:

  * a search over {trace-free, unit norm, S = 0} returned theta = 1.326 at n = 6,
    above sqrt(3/2), with Ricci residual 1.279;
  * a maximisation over symmetric pairs returned theta = 1.2385 at n = 12, ABOVE
    theta_0(12) = 1.236033 and so apparently refuting the conjecture, with Ricci
    residual 0.288 -- the operator Pi_h - (r/N) Id is Ricci-flat only when the isotropy
    leaves no invariant symmetric 2-tensor beyond the identity, which fails for every
    UNBALANCED split so(p)+so(q);
  * the same number was nearly recorded a third time before the residual was checked.

Fence post 14 states the trap plainly and none of the three was stopped by it, so the
check does not belong only in the record.  Call `theta_screened` instead of `P`.

theta on the Bianchi-only relaxation reaches sqrt(2(n-1)/n) at the round sphere, which
exceeds theta_0(n); on the S = 0 relaxation it is unbounded well past that.  A theta
quoted without residuals is not evidence about the conjecture.
"""
import sys
import numpy as np

sys.path.insert(0, 'scripts/lib')
from review_r30_core import P as _P
from b0_psd_identity import ricci as _ricci, bianchi_res as _bianchi
from review_r30_core import Q as _Q

TOL = 1e-9


def theta_screened(n, W, tol=TOL, strict=False):
    """Return (theta, info).  info['is_weyl'] is the only licence to quote theta.

    strict=True raises instead of returning, for use inside a maximisation where a
    non-Weyl point must never enter the running best.
    """
    nrm = float(np.sqrt(np.sum(W * W)))
    if nrm < 1e-14:
        raise ValueError("zero operator")
    Wn = W / nrm
    info = {
        'ricci': float(np.abs(_ricci(n, Wn)).max()),
        'bianchi': float(_bianchi(n, Wn)),
        'trace': float(abs(np.trace(Wn))),
    }
    info['is_weyl'] = (info['ricci'] < tol and info['bianchi'] < tol
                       and info['trace'] < tol)
    theta = _P(n, Wn)
    if strict and not info['is_weyl']:
        raise ValueError(
            f"not a Weyl tensor: ricci={info['ricci']:.2e} bianchi={info['bianchi']:.2e} "
            f"trace={info['trace']:.2e} -- theta={theta:.6f} is a relaxation value")
    return theta, info


def report(n, W, label='', tol=TOL):
    t, i = theta_screened(n, W, tol)
    flag = 'WEYL' if i['is_weyl'] else '*** RELAXATION -- theta is NOT a Weyl value ***'
    print(f"  {label:28s} theta={t:+.6f}  ricci={i['ricci']:.1e}  "
          f"bianchi={i['bianchi']:.1e}  {flag}")
    return t, i


if __name__ == '__main__':
    # the three points that motivated this file, plus a control
    pairs = lambda n: [(i, j) for i in range(n) for j in range(i + 1, n)]
    def split(n, p):
        N = n * (n - 1) // 2
        h = np.array([1.0 if (i < p and j < p) or (i >= p and j >= p) else 0.0
                      for (i, j) in pairs(n)])
        return np.diag(h) - (h.sum() / N) * np.eye(N)
    print("  the near-miss, and its control:")
    report(12, split(12, 5), 'so(5)+so(7), n=12')
    report(12, split(12, 6), 'so(6)+so(6), n=12  [control]')
    print(f"\n  theta_0(12) = {(11/12)*np.sqrt(2*10/11):.6f} -- the unbalanced split appears")
    print("  to beat it, and is not a Weyl tensor.")


# --------------------------------------------------------------------------------
# Criticality screen -- added 2026-08-24 after Gate 2 (Reviewers 71/72).
#
# theta_screened exists because three agents in one cycle read theta off an operator
# that was not a Weyl tensor.  The SAME failure then happened one level up: Lemma 24's
# second-order bound was read off operators that were not CRITICAL POINTS, where the
# lemma has no content at all.  Three rows of a published falsification table were
# computed at operators with criticality residual 0.11 to 0.22.
#
# Lemma 24 says: at a GLOBAL MAXIMISER, spec(L_e restricted to e-perp) is in (-inf, 1/2]
# with 1 simple.  Its hypothesis is criticality, i.e. Q(W) = theta W.  Quoting a
# lam_max against 1/2 at a non-critical W is meaningless.
# --------------------------------------------------------------------------------

def critical_screened(n, W, tol=TOL, strict=False):
    """Return (theta, info) with info['is_critical'] the licence to invoke Lemma 24.

    info carries everything theta_screened returns, plus 'crit_res' = ||Q(W) - theta W||
    at unit norm and 'is_critical'.  A point is usable for any second-order statement
    only when BOTH is_weyl and is_critical are true.  strict=True raises otherwise, so a
    non-critical operator cannot silently enter a Lemma 24 table.
    """
    W = W / np.sqrt(np.sum(W * W))
    th, info = theta_screened(n, W, tol=tol)
    res = float(np.linalg.norm(_Q(n, W) - th * W))
    info['crit_res'] = res
    info['is_critical'] = bool(res < 1e-8)
    if strict and not (info['is_weyl'] and info['is_critical']):
        raise ValueError(
            "not usable for a second-order statement: is_weyl=%s crit_res=%.3e"
            % (info['is_weyl'], res))
    return th, info
