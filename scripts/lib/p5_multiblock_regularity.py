"""
The two-sided regularity on the one structured family known to be ungraded.

Every named structured family enumerated so far -- two-block sphere products and
CP^m -- turned out graded, so the regularity could not be tested where it
matters.  The multi-block products (S^{n1} x ... x S^{nk}) with k >= 3 are the
exception: Reviewer 13 found them ungraded (S > 0), and one of them, (S^8)^3 at
n = 24, is what refuted the separation by driving RHS above sqrt(3/2).

An earlier attempt built them by a naive block-diagonal ansatz, which is not
critical and was silently dropped by the screen.  They are built here by the
vertex system that actually solves the criticality equations, taken from the
reviewer's own helper rather than reimplemented.

The regularity under test:

    every ungraded critical point with RHS >= sqrt(3/2) has theta <= 0.916.

If it survives on this family it is worth a proof attempt, since together with
theta <= RHS it would separate everywhere and close the ungraded half.  If it
fails, the last recorded lead on that half is gone and the plan should say so.
"""
import numpy as np

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad
from review_r13_multiblock import multiblock_point

SQ32 = np.sqrt(1.5)


def embed_local(L2, blocks, w):
    n = sum(blocks)
    starts = np.cumsum([0] + list(blocks))
    blk = np.zeros(n, int)
    for a in range(len(blocks)):
        blk[starts[a]:starts[a + 1]] = a
    M = np.zeros((L2.N, L2.N))
    for t, (i, j) in enumerate(L2.pairs):
        M[t, t] = w[blk[i], blk[j]]
    return M


def measure(L2, W, c, alt):
    nrm = np.linalg.norm(W)
    if nrm < 1e-12:
        return None
    W = W / nrm
    QW = Q_full(W, c)
    th = float(np.sum(W * QW))
    if th < 0:
        W, th = -W, -th
        QW = Q_full(W, c)
    res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
    ev, V = np.linalg.eigh(W)
    neg = ev < 0
    Wm = (V[:, neg] * (-ev[neg])) @ V[:, neg].T
    d2 = float(delta2_and_grad(W, alt)[0])
    rho = ricci_from_mop(L2, Wm)
    nr2 = float(np.sum(rho * rho))
    if nr2 < 1e-14:
        return None
    Sh = rho / np.sqrt(nr2)
    trSh4 = float(np.trace(np.linalg.matrix_power(Sh, 4)))
    RicWm2 = ricci_from_mop(L2, Wm @ Wm)
    # (1 - e^2) was dropped here, making RHS too large -- (6,6,6) printed
    # 1.322183 against a true 1.200263, and 100% of the family appeared to
    # trigger where only 0.6% does.  e^2 is the squared cosine between W_- and
    # its Ricci reconstruction; recomputed below.
    tr_wm = float(np.trace(Wm))
    # WRONG DEFINITION -- kept only to mark the error.  e^2 is not
    # 1 - |Ric(W_-)|^2/|W_-|^2, which clips to 0 on this whole family and makes
    # the factor 1.  The definition is sqrt(1-e^2) = <|W|, Ric^Ric>/||Ric^Ric||
    # with Ric = Ric(|W|), implemented at review_r13_independent.py:277.
    e2 = 0.0 if tr_wm < 1e-14 else max(0.0, 1.0 - nr2 / max(float(np.sum(Wm * Wm)), 1e-300))
    rhs = (np.sqrt(2) * np.sqrt(max(1 - trSh4, 0.0)) * np.sqrt(max(1 - e2, 0.0))
           - float(np.sum(RicWm2 * rho)) / nr2
           + 12.0 * d2 * float(np.linalg.eigvalsh(rho)[-1]) / nr2)
    S = nr2 + 6 * d2 - th * float(np.trace(Wm)) - float(np.trace(Wm @ Wm))
    return th, rhs, S, res


cases = [(12, (4, 4, 4)), (12, (3, 3, 3, 3)), (12, (2, 5, 5)), (12, (3, 4, 5)),
         (15, (5, 5, 5)), (16, (4, 6, 6)), (18, (6, 6, 6)), (20, (4, 8, 8)),
         (21, (7, 7, 7)), (24, (8, 8, 8)), (24, (6, 6, 6, 6))]
rows = []
for n, blocks in cases:
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt = build_alt_indices(L2)
    try:
        sols = multiblock_point(blocks)
    except Exception as e:
        print(f"  n={n} {blocks}: builder failed ({e})", flush=True)
        continue
    for key, (w, th0) in sorted(sols.items()):
        m = measure(L2, embed_local(L2, blocks, w), c, alt)
        if m is None:
            continue
        th, rhs, S, res = m
        if res < 1e-8 and th > 1e-6:
            rows.append((n, blocks, th, rhs, S))

print(f"{'n':>4} {'blocks':>16} {'theta':>10} {'RHS':>10} {'S':>10}  class")
seen = set()
for n, b, th, rhs, S in rows:
    k = (n, b, round(th, 9))
    if k in seen:
        continue
    seen.add(k)
    cls = "ungraded" if S > 1e-8 else "graded"
    flag = ""
    if rhs >= SQ32 and S > 1e-8:
        flag = "  <- ungraded with RHS>=sqrt(3/2)" + ("  *** theta>0.916 ***" if th > 0.916 else "")
    print(f"{n:>4} {str(b):>16} {th:>10.6f} {rhs:>10.6f} {S:>10.4f}  {cls}{flag}")

un_hi = [r for r in rows if r[4] > 1e-8 and r[3] >= SQ32]
print(f"\nungraded points with RHS >= sqrt(3/2): {len(un_hi)}")
if un_hi:
    mx = max(r[2] for r in un_hi)
    print(f"   max theta among them = {mx:.6f}"
          f"   {'*** REGULARITY REFUTED ***' if mx > 0.916 else 'consistent with theta <= 0.916'}")
else:
    print("   none -- the regularity is still untested")
