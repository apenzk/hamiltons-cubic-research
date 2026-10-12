import sys, os
import numpy as np
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from run_h4b import go, n_isotypes
from core import Geom
from points import c5_blowup, cpm
from le import build_weyl, Le_matrix, HA_span, compression
from run_h5 import lam_matrix, blocks_of, edge_pairs
from run_h1 import log

log("[p6b] C_5 edge family: eigenspace or Rayleigh-Ritz block?")
g, W = c5_blowup(); B, sv = build_weyl(g); th = g.P(W)
Le = Le_matrix(g, W, B, sv, th)
L = lam_matrix(g, W); lab, nb = blocks_of(L); val, ep, allp = edge_pairs(L, lab, nb)
cols = []
for (a, b) in ep:
    A = np.zeros((g.n, g.n)); A[a, b] = A[b, a] = 1 / np.sqrt(2.0)
    Hm = g.H(W, A)
    cols.append(B.T @ sv.vec(0.5 * (Hm + Hm.T)))
Cm = np.array(cols).T
e = B.T @ sv.vec(W); Cm = Cm - np.outer(e, e @ Cm)
U, M, _ = compression(Le, Cm)
log(f"     edge family dim={U.shape[1]} ||L_e U - U M||={np.linalg.norm(Le@U-U@M):.3e} "
    f"spec={np.unique(np.round(np.linalg.eigvalsh(0.5*(M+M.T)),9)).tolist()}")
C2, _ = HA_span(g, W, B, sv)
U2, M2, _ = compression(Le, C2)
log(f"     full Sym_0 image dim={U2.shape[1]} ||L_e U - U M||={np.linalg.norm(Le@U2-U2@M2):.3e}")
log("[p6c] isotype count at the C_5 blow-up and CP^4")
for nm, f in [("CP4", lambda: cpm(4)), ("C5blowup", c5_blowup)]:
    go(nm, f)
