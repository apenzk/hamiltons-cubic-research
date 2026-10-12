"""r285 Claims 2 and 4: is the sphere product a local max (F's 'falsifier'), and is
padded W_CP2 one too (route D's closure)?  Hessian of P on the unit sphere at a
critical point is 6 theta (L_e - 1/2 Id), e = W/theta, L_e X = e o X.
All constructions are my own; only the two point formulas are taken from the record.
"""
import numpy as np, sys, itertools
sys.path.insert(0, "scripts/reviewers/r285")
from c1_gradient import struct, sharp_i, Q, weyl_basis, proj

def circ(c, X, Y):
    return 0.5*(X@Y + Y@X) + sharp_i(c, X, Y)

def pairs_of(n):
    return list(itertools.combinations(range(n), 2))

def sphere_product(n):
    """balanced S^{n/2} x S^{n/2}: diag, 1/(p(p-1)) within a block, -1/(pq) across."""
    p = n//2; lab = [0]*p + [1]*p
    pr = pairs_of(n); N = len(pr)
    W = np.zeros((N, N))
    for a, (i, j) in enumerate(pr):
        W[a, a] = 1.0/(p*(p-1)) if lab[i] == lab[j] else -1.0/(p*p)
    return W

def padded_cp2(n):
    """The CP^2 WEYL tensor (its Weyl part taken in dimension 4, where CP^2 lives)
    zero-padded into Lambda^2 R^n.  T = (dd-dd) + (JJ-JJ) + 2 J_ij J_kl on R^4."""
    J = np.zeros((4, 4)); J[1,0]=1.0; J[0,1]=-1.0; J[3,2]=1.0; J[2,3]=-1.0
    Jm = J.T.copy(); d = np.eye(4)
    def T(i,j,k,l):
        return (d[i,k]*d[j,l]-d[i,l]*d[j,k]) + (Jm[i,k]*Jm[j,l]-Jm[i,l]*Jm[j,k]) + 2*Jm[i,j]*Jm[k,l]
    pr4 = pairs_of(4); N4 = len(pr4)
    R = np.zeros((N4, N4))
    for a,(i,j) in enumerate(pr4):
        for b,(k,l) in enumerate(pr4):
            R[a,b] = T(i,j,k,l)
    R = 0.5*(R+R.T)
    B4, _, _ = weyl_basis(4)          # Weyl part taken in dimension 4
    W4 = proj(B4, R); W4 = W4/np.linalg.norm(W4)
    pr = pairs_of(n); ix = {p_: t for t, p_ in enumerate(pr)}
    W = np.zeros((len(pr), len(pr)))
    for a,(i,j) in enumerate(pr4):
        for b,(k,l) in enumerate(pr4):
            W[ix[(i,j)], ix[(k,l)]] = W4[a,b]
    return W

def Le_matrix(c, B, e):
    D = len(B); Bf = B.reshape(D, -1)
    M = np.empty((D, D))
    for k in range(D):
        M[:, k] = Bf @ circ(c, e, B[k]).ravel()
    return 0.5*(M+M.T)

def orbit_dim(c, n, W):
    """span of [A_a, W], A_a = ad(phi_a) with (A_a)_{mn} = c[a,m,n]."""
    N = W.shape[0]
    V = np.array([c[a] @ W - W @ c[a] for a in range(N)]).reshape(N, -1)
    s = np.linalg.svd(V, compute_uv=False)
    return int((s > 1e-8*s.max()).sum())

def wedge_min(vecs, pr, n, seed=7):
    """min ||omega ^ omega|| over the unit sphere of span(vecs); vectorised."""
    quad = list(itertools.combinations(range(n), 4))
    ix = {p_: t for t, p_ in enumerate(pr)}
    # (omega ^ omega)_{ijkl} = w_ij w_kl + w_ik w_lj + w_il w_jk, w in the pair basis
    trip = np.array([[(ix[(i,j)], ix[(k,l)]), (ix[(i,k)], ix[(j,l)]), (ix[(i,l)], ix[(j,k)])]
                     for (i,j,k,l) in quad])           # (M,3,2); note w_lj = -w_jl
    sgn = np.array([1.0, -1.0, 1.0])
    def f(v):
        a = v[trip[:, :, 0]]; b = v[trip[:, :, 1]]
        val = (sgn * a * b).sum(axis=1)
        return float(np.sqrt((val**2).sum()))
    k = len(vecs)
    if k == 1:
        return f(vecs[0]/np.linalg.norm(vecs[0]))
    best = np.inf
    for t in np.linspace(0, np.pi, 200001):
        v = np.cos(t)*vecs[0] + np.sin(t)*vecs[1]
        best = min(best, f(v))
    rng = np.random.default_rng(seed)
    for _ in range(2000):
        co = rng.standard_normal(k); co /= np.linalg.norm(co)
        best = min(best, f(sum(co[t]*vecs[t] for t in range(k))))
    return best

if __name__ == "__main__":
    for n in (8, 12):
        pr, N, c = struct(n)
        B, _, _ = weyl_basis(n); D = len(B)
        print(f"=== n={n}  N={N}  dim Weyl={D} ===", flush=True)
        pts = {"balanced sphere product": sphere_product(n), "padded W_CP2": padded_cp2(n)}
        for name, W0 in pts.items():
            W = proj(B, W0); W = W/np.linalg.norm(W)
            th = float(np.sum(W*Q(c, W)))
            res = np.linalg.norm(Q(c, W) - th*W)
            e = W/th
            M = Le_matrix(c, B, e)
            cw = (B.reshape(D,-1) @ W.ravel()); cw /= np.linalg.norm(cw)
            Pp = np.eye(D) - np.outer(cw, cw)
            wp = np.linalg.eigvalsh(Pp @ M @ Pp)
            # discard the single spurious 0 from the W direction: it is not the max here
            above = int((wp > 0.5 + 1e-8).sum()); at = int((np.abs(wp-0.5) < 1e-8).sum())
            od = orbit_dim(c, n, W)
            print(f"  {name:26s} theta={th:.12f} crit={res:.2e} "
                  f"maxspec(L_e|Wperp)={wp.max():.12f} >1/2:{above} =1/2:{at} orbit={od}", flush=True)
            # Plucker on each eigenspace of small dimension
            ev, U = np.linalg.eigh(W)
            groups = []
            i = 0
            while i < len(ev):
                j = i
                while j+1 < len(ev) and abs(ev[j+1]-ev[i]) < 1e-8: j += 1
                groups.append((ev[i], U[:, i:j+1].T)); i = j+1
            for lam, vecs in groups:
                if len(vecs) <= 2:
                    mn = wedge_min(list(vecs), pr, n)
                    print(f"      eigval {lam:+.6f} dim {len(vecs)}: min||w^w|| = {mn:.6f}", flush=True)
