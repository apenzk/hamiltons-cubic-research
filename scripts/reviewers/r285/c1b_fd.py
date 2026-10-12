"""r285 Claim 1(b),(c): a test at a NON-critical W that can distinguish the identity
from a false one, plus the question route F actually needs: does Q(W) stay in Weyl_n?"""
import numpy as np, sys
sys.path.insert(0, "scripts/reviewers/r285")
from c1_gradient import struct, sharp_i, Q, P, weyl_basis, proj

rng = np.random.default_rng(2851)
for n in (6, 8):
    B, c, N = weyl_basis(n)
    d = B.shape[0]
    print(f"=== n={n}  N={N}  dim Weyl={d} (formula {n*(n+1)*(n+2)*(n-3)//12}) ===")
    # orthonormality of basis
    G = np.einsum('kab,lab->kl', B, B)
    print("  basis orthonormality err:", np.abs(G-np.eye(d)).max())
    for trial in range(3):
        co = rng.standard_normal(d); co /= np.linalg.norm(co)
        W = np.einsum('k,kab->ab', co, B)
        cv = rng.standard_normal(d); cv /= np.linalg.norm(cv)
        V = np.einsum('k,kab->ab', cv, B)
        # V is Weyl by construction; check
        wv = np.linalg.norm(V - proj(B, V))
        # criticality residual: is W critical?
        QW = Q(c, W); th = float(np.trace(W@QW))/float(np.trace(W@W))
        crit = np.linalg.norm(QW - th*W)
        pred = 3.0*float(np.sum(QW*V))
        # Richardson-extrapolated central difference
        best = None
        for h in (1e-3, 1e-4, 1e-5):
            fd = (P(c, W+h*V) - P(c, W-h*V))/(2*h)
            rel = abs(fd-pred)/max(1.0, abs(pred))
            if best is None or rel < best[0]: best = (rel, h, fd)
        print(f"  trial {trial}: crit_resid={crit:.3e}  P={P(c,W):.6f}  pred=3<Q,V>={pred:.12f}"
              f"  fd={best[2]:.12f}  rel_err={best[0]:.2e}  (h={best[1]})  ||V-projV||={wv:.1e}")
    # THE STRUCTURAL QUESTION: does Q(W) lie in Weyl_n?
    print("  --- is Q(W) in Weyl_n? (relative off-Weyl mass) ---")
    for trial in range(3):
        co = rng.standard_normal(d); co /= np.linalg.norm(co)
        W = np.einsum('k,kab->ab', co, B)
        QW = Q(c, W)
        off = np.linalg.norm(QW - proj(B, QW))
        print(f"    trial {trial}: ||Q(W)||={np.linalg.norm(QW):.6f}"
              f"  ||Q(W)-proj_Weyl Q(W)||={off:.6f}  ratio={off/np.linalg.norm(QW):.4f}")
