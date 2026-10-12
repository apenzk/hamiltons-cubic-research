"""theta <= 9bc(b+c) for a Weyl tensor with exactly two negative eigenvalues, at ANY
number of positive eigenvalues -- and where the chain is lossy.

Lemma 29 proves the cap sqrt(3/2) for ONE positive eigenvalue.  The record flags the
general case as reopening the (+++) and (++-) sign-blocks, which the pair cap alone
does not control.  The vector identity closes them.

THE INPUT.  Contracting the Weitzenbock identity sum_a lam_a ad(v_a)^2 = 2W against
each eigenvector gives, with R_{ab} = ||[v_a,v_b]||^2 = sum_g c'^2_{abg},

    R lam = -2 lam,        R >= 0 entrywise,  R_{aa} = 0,
    row sums 2(m-2),       pair cap R_{ab} <= 2.

The recorded tr(W^#) = -1 is its single lam-contraction.

THE CHAIN.  Write P for the positive indices, -b <= -c < 0 for the two negatives,
s = b + c = sum_P lam (trace-free), u = sum_P lam^2 = 1 - b^2 - c^2, lam_1 = max_P lam.

  (0)  weighted row sum over P:   sum_{a,b in P} R_ab lam_a lam_b  <=  2 s^2 - 2 u,
       whence  s^2 + b^2 + c^2 >= 1,  an identity on the base-case family.
  (1)  theta = sum lam^3 + 3 sum_{a<b<g} T_{abg} lam_a lam_b lam_g   (eigenframe form)
  (2)  (---) block is empty: three distinct negative indices need three negatives
  (3)  (++-) block <= 0 termwise
  (4)  (+--) block  =  bc sum_{a in P} T_{a,N-1,N} lam_a  <=  2 bc lam_1   (pair cap)
  (5)  sum_P lam^3 <= lam_1 u
  (6)  (+++) block:  3 S1 <= lam_1 [ s^2 - u ]   by (0)
  (7)  add, use lam_1 <= s and s^3 - b^3 - c^3 = 3bcs:   theta <= 9 b c s.

WHAT IT DOES NOT REACH.  Turning 9bcs into sqrt(3/2) needs s capped.  With k positive
eigenvalues Cauchy-Schwarz gives u >= s^2/k, so s^2 <= 2k/(k+2) and max (9/4)s^3 is
EXACTLY sqrt(3/2) at k = 1 and 2.25 at k = 2.  So the extension is real and the closing
step degrades in k; the lossy step is (6), which spends the pair cap rather than the
structure of the all-positive block.

This script screens every step separately, so a failure localises to one inequality.

FALSIFIER.  Any Weyl tensor with exactly two negative eigenvalues and theta > 9bc(b+c),
or a step of the chain violated at a real tensor.
"""
import numpy as np, sys, itertools
sys.path.insert(0, 'scripts/lib')
from b0_psd_identity import rand_weyl, C_gens
from b0_full_support_witness import W4
from review_r30_core import P as Pfun

np.set_printoptions(precision=6, suppress=True)


def pieces(m, W):
    """all quantities of the chain, measured at a real Weyl tensor."""
    W = W / np.sqrt(np.sum(W*W))
    lam, V = np.linalg.eigh(W)
    C = C_gens(m)
    ad = np.tensordot(V.T, C, axes=([1], [0]))
    cp = np.einsum('aij,jb,ig->abg', ad, V, V)        # c'_{abg}
    T = cp**2
    R = T.sum(axis=2)
    neg = np.where(lam < -1e-9)[0]
    if len(neg) != 2:
        return None
    iN, iM = neg[0], neg[1]                            # lam[iN] <= lam[iM] < 0
    b, c = -lam[iN], -lam[iM]
    Pidx = np.where(lam > 1e-9)[0]
    lp = lam[Pidx]
    s, u, l1 = lp.sum(), (lp**2).sum(), lp.max()
    d = dict(b=b, c=c, s=s, u=u, l1=l1, theta=Pfun(m, W))
    # step 0
    d['w_rowsum'] = float(lp @ R[np.ix_(Pidx, Pidx)] @ lp)
    d['w_bound'] = 2*s*s - 2*u
    d['constraint'] = s*s + b*b + c*c
    # blocks
    S1 = sum(T[a, bb, g]*lam[a]*lam[bb]*lam[g]
             for a, bb, g in itertools.combinations(Pidx, 3))
    S2 = sum(T[a, bb, g]*lam[a]*lam[bb]*lam[g]
             for a, bb in itertools.combinations(Pidx, 2) for g in (iN, iM))
    S3 = sum(T[a, iN, iM]*lam[a]*lam[iN]*lam[iM] for a in Pidx)
    d.update(S1=S1, S2=S2, S3=S3)
    d['theta_reassembled'] = float((lam**3).sum() + 3*(S1+S2+S3))
    d['S3_bound'] = 2*b*c*l1
    d['cube_bound'] = l1*u
    d['S1_bound'] = l1*(s*s - u)/3.0
    d['final'] = 9*b*c*s
    return d


def report(m, W, name):
    d = pieces(m, W)
    if d is None:
        return
    ok = lambda x: 'OK' if x else '**FAIL**'
    print(f"\n  {name}   (m={m})")
    print(f"    b={d['b']:.6f} c={d['c']:.6f} s={d['s']:.6f} u={d['u']:.6f} lam_1={d['l1']:.6f}")
    print(f"    theta {d['theta']:+.6f}  reassembled {d['theta_reassembled']:+.6f}"
          f"  diff {abs(d['theta']-d['theta_reassembled']):.1e}   [step 1]")
    print(f"    (0) weighted row sum {d['w_rowsum']:.6f} <= {d['w_bound']:.6f}  "
          f"{ok(d['w_rowsum'] <= d['w_bound']+1e-9)}")
    print(f"        s^2+b^2+c^2 = {d['constraint']:.9f} >= 1  {ok(d['constraint'] >= 1-1e-9)}")
    print(f"    (3) (++-) block {d['S2']:+.6f} <= 0  {ok(d['S2'] <= 1e-12)}")
    print(f"    (4) (+--) block {d['S3']:+.6f} <= {d['S3_bound']:.6f}  {ok(d['S3'] <= d['S3_bound']+1e-9)}")
    print(f"    (6) (+++) block {d['S1']:+.6f} <= {d['S1_bound']:.6f}  {ok(d['S1'] <= d['S1_bound']+1e-9)}")
    print(f"    (7) theta {d['theta']:+.6f} <= 9bc(b+c) = {d['final']:.6f}  "
          f"{ok(d['theta'] <= d['final']+1e-9)}   slack {d['final']-d['theta']:.2e}")


if __name__ == '__main__':
    for m in (4, 6, 8):
        report(m, -W4([0, 1, 2, 3], m, 1, 1), "base-case family, q=r")
    for (q, r) in ((2.0, 0.5), (1.0, 0.1)):
        report(6, -W4([0, 1, 2, 3], 6, q, r), f"base-case family, q={q}, r={r}")
    report(6, W4([0, 1, 4, 5], 6, 1, 1) + W4([2, 3, 4, 5], 6, 1, 1), "m=6 full-support witness")
    report(8, W4([0, 1, 2, 3], 8, 1, 1) + W4([4, 5, 6, 7], 8, 1, 1), "m=8 orthogonal witness")
