"""K1 and K2: the C_5 blow-up at n=10, criticality, theta, slack, degeneracy."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..'))
import sys
import numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts'))
from review_r54_core import (pairs_of, Q, P, weyl_basis, Le_matrix, orbit_tangent,
                             onb_rows, slack_structural, ricci_of, bianchi_of, theta0)

def blowup_W(sizes, G, diag, adjv, nonadj):
    n = sum(sizes); ps, idx = pairs_of(n); N = len(ps)
    lab = []
    for bi, b in enumerate(sizes): lab += [bi]*b
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(ps):
        A_, B_ = lab[i], lab[j]
        W[a, a] = diag if A_ == B_ else (adjv if G[A_][B_] else nonadj)
    return W, n, lab

def cycle(k):
    G = [[0]*k for _ in range(k)]
    for a in range(k):
        G[a][(a+1) % k] = G[(a+1) % k][a] = 1
    return G

def neg_graph_triangles(n, W, lab=None, tol=1e-9):
    ps, idx = pairs_of(n)
    negedge = {p for a, p in enumerate(ps) if W[a, a] < -tol}
    tri = 0
    for i in range(n):
        for j in range(i+1, n):
            if (i, j) not in negedge: continue
            for k in range(j+1, n):
                if (i, k) in negedge and (j, k) in negedge: tri += 1
    return tri

if __name__ == "__main__":
    G = cycle(5)
    W, n, lab = blowup_W([2]*5, G, 4.0, -2.0, 1.0)
    W = W / np.linalg.norm(W)
    QW = Q(n, W)
    th = float(np.tensordot(W, QW))
    res = float(np.linalg.norm(QW - th*W))
    print("=== K1 ===")
    print(f" n={n}  theta={th:.12f}  theta_0={theta0(n):.12f}  ratio={th/theta0(n):.6f}")
    print(f" criticality residual  = {res:.3e}")
    print(f" |Ric(W)|_max          = {np.abs(ricci_of(n,W)).max():.3e}")
    print(f" |Bianchi(W)|_max      = {np.abs(bianchi_of(n,W)).max():.3e}")
    print(f" S_structural          = {slack_structural(n,W):.6e}")
    print(f" 3 x triangles(G_-)    = {3*neg_graph_triangles(n,W)}")
    ev = np.linalg.eigvalsh(W)
    import collections
    cnt = collections.Counter(np.round(ev, 10))
    print(f" spectrum of W (45 eigenvalues): {dict(sorted(cnt.items()))}")
    print(f" #neg={(ev<-1e-9).sum()} #zero={(np.abs(ev)<1e-9).sum()} #pos={(ev>1e-9).sum()}")
    # exact rational check
    from fractions import Fraction as F
    # unnormalised entries 4,-2,1 -> norm^2 = 5*C(2,2)... count
    ps, idx = pairs_of(n)
    same = sum(1 for (i,j) in ps if lab[i]==lab[j])
    adjc = sum(1 for (i,j) in ps if lab[i]!=lab[j] and G[lab[i]][lab[j]])
    nadj = sum(1 for (i,j) in ps if lab[i]!=lab[j] and not G[lab[i]][lab[j]])
    nsq = F(same*16 + adjc*4 + nadj*1)
    print(f" pair counts same={same} adj={adjc} nonadj={nadj}  |W_raw|^2={nsq}")
    # theta exactly
    lam = {}
    for a,(i,j) in enumerate(ps):
        lam[(i,j)] = F(4) if lab[i]==lab[j] else (F(-2) if G[lab[i]][lab[j]] else F(1))
    Praw = F(0)
    for (i,j) in ps:
        v = lam[(i,j)]**2
        for k in range(n):
            if k in (i,j): continue
            v += lam[(min(i,k),max(i,k))]*lam[(min(j,k),max(j,k))]
        Praw += lam[(i,j)]*v
    from fractions import Fraction
    print(f" exact P_raw={Praw}  |W|^2={nsq}  theta_exact = P_raw/|W|^3 = {Praw}/{nsq}^1.5 "
          f"= {float(Praw)/float(nsq)**1.5:.12f}")
    print(f" theta^2 exact = {Praw**2}/{nsq**3} = {Fraction(Praw**2, nsq**3)}")

    print("\n=== K2 ===")
    B = weyl_basis(n)
    e = W/th
    M = Le_matrix(n, e, B)
    ev = np.linalg.eigvalsh(M)
    dimhalf = int((np.abs(ev-0.5) < 1e-8).sum())
    Ob = onb_rows(orbit_tangent(n, W))
    print(f" dim Weyl_10 = {len(B)}")
    print(f" orbit tangent dim = {Ob.shape[0]}")
    print(f" dim E(1/2)        = {dimhalf}   excess = {dimhalf - Ob.shape[0]}")
    wv = np.einsum('kmn,mn->k', B, W); wv /= np.linalg.norm(wv)
    Pr = np.eye(len(B)) - np.outer(wv, wv)
    evp = np.sort(np.linalg.eigvalsh(Pr @ M @ Pr))
    print(f" |L_e W - W| = {np.linalg.norm(M@wv-wv):.2e}")
    print(f" lambda_max(L_e|W^perp) = {evp[-1]:.6f}  (next {evp[-2]:.6f}, {evp[-3]:.6f})")
    print(f" full L_e spectrum extremes: {ev[:3]} ... {ev[-3:]}")
    # is the orbit tangent inside E(1/2)?
    half = np.linalg.eigh(M)[1][:, np.abs(ev-0.5) < 1e-8]
    Ob_c = np.array([np.einsum('kmn,mn->k', B, o.reshape(len(W), len(W))) for o in
                     Ob.reshape(Ob.shape[0], len(W), len(W))])
    Ob_c = np.linalg.qr(Ob_c.T)[0]
    cos = np.linalg.svd(Ob_c.T @ half, compute_uv=False)
    print(f" principal cosines orbit vs E(1/2): min={cos.min():.9f} max={cos.max():.9f}")
    np.save('scratchpad/r54_c5_W.npy', W)
