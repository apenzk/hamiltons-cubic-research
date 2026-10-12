"""Reviewer 61 / C6 clause 1, explicit refutation.  C6 asserts every witness of
the padded-Weyl_4 kind has theta <= 0 'because each summand does'.  theta is a
CUBIC form, so it is additive over summands only when their supports are
Frobenius-orthogonal; when the two 4-planes overlap the cross terms survive.
Below: an explicit m=6 witness with two negative eigenvalues, dim U = 6, both
summands at theta < 0, and the sum at theta > 0."""
import numpy as np
from review_r61_core import theta, ricci_defect, bianchi_defect, project_weyl, vec_to_skew
from review_r61_c5 import W4, dimU

m = 6
E = np.eye(m)
A = [E[0], E[1], E[2], E[3]]
B = [E[2], E[3], E[4], E[5]]

cases = [("witness 1", (0.0153, -0.4487, 0.4334), (-0.5412, 0.5404, 0.0008)),
         ("witness 2", (0.0142, -0.8136, 0.7994), (-0.4405, 0.3765, 0.0640)),
         ("witness 3", (-0.4973, 0.0343, 0.4631), (0.0343, -0.8900, 0.8557))]

for name, cA, cB in cases:
    cA = np.array(cA); cA = cA - cA.mean()
    cB = np.array(cB); cB = cB - cB.mean()
    PA = W4(A, m, cA); PB = W4(B, m, cB)
    W = PA + PB
    Wn = W/np.linalg.norm(W)
    lam = np.linalg.eigvalsh(Wn)
    du, _ = dimU(Wn)
    tA = theta(PA/np.linalg.norm(PA), m)
    tB = theta(PB/np.linalg.norm(PB), m)
    print(f"{name}: theta(sum) = {theta(Wn,m):+.6f}   theta(A) = {tA:+.6f}"
          f"   theta(B) = {tB:+.6f}")
    print(f"   #neg={(lam<-1e-9).sum()}  dim U={du}  ricci={ricci_defect(Wn,m):.1e}"
          f"  bianchi={bianchi_defect(Wn,m):.1e}"
          f"  dist(Weyl)={np.linalg.norm(Wn-project_weyl(Wn,m)):.1e}")
    print(f"   spectrum: {np.round(lam[np.abs(lam)>1e-9], 6)}")
    print(f"   <PA,PB> = {np.sum(PA*PB):+.6f}  (Frobenius overlap; zero would make"
          f" theta additive)")
