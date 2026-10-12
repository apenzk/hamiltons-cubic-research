"""r286 claims 4 and 5.

Claim 4: route D is closed because padded W_CP2 is (a) a local maximum and (b)
Plucker-obstructed.  Both halves verified independently, from an independently
built padded W_CP2 (built in Lambda^2 from the self-dual forms, not from the
repo's 4-tensor constructors).

Claim 5: (i) every one-positive/two-negative element is Plucker-obstructed,
(ii) no maximiser lies in that stratum, (iii) therefore
     Plucker-obstructed  =>  theta <= sqrt(3/2).
(iii) is attacked with a witness.
"""
import sys, os, itertools
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', '..'))
import review_r27_core as core

np.random.seed(2864)
S32 = np.sqrt(1.5)

def sd_basis(n):
    """self-dual 2-forms on span(e0..e3), as vectors in Lambda^2 R^n coords."""
    pr = core.pairs(n); idx = {p: k for k, p in enumerate(pr)}
    N = len(pr)
    def ph(i, j):
        v = np.zeros(N)
        s = 1.0
        if i > j: i, j, s = j, i, -1.0
        v[idx[(i, j)]] = s
        return v
    r2 = np.sqrt(2.0)
    w1 = (ph(0,1) + ph(2,3))/r2
    w2 = (ph(0,2) + ph(3,1))/r2
    w3 = (ph(0,3) + ph(1,2))/r2
    return w1, w2, w3

def padded_cp2(n):
    w1, w2, w3 = sd_basis(n)
    W = 2*np.outer(w1,w1) - np.outer(w2,w2) - np.outer(w3,w3)
    return W/np.linalg.norm(W)

def stratum_member(n, q, r):
    """W^+ = diag(q+r,-q,-r) on the self-dual forms, padded: the record's
    one-parameter one-positive/two-negative family."""
    w1, w2, w3 = sd_basis(n)
    W = (q+r)*np.outer(w1,w1) - q*np.outer(w2,w2) - r*np.outer(w3,w3)
    return W/np.linalg.norm(W)

def wedge_norm(omega_vec, n):
    pr = core.pairs(n); idx = {p: k for k, p in enumerate(pr)}
    w = np.zeros((n, n))
    for (i, j), k in idx.items():
        w[i, j] = omega_vec[k]; w[j, i] = -omega_vec[k]
    tot = 0.0
    for i, j, k, l in itertools.combinations(range(n), 4):
        v = w[i,j]*w[k,l] + w[i,k]*w[l,j] + w[i,l]*w[j,k]
        tot += v*v
    return np.sqrt(tot)

def min_wedge_over(space, n, tries=4000):
    """min ||omega ^ omega|| over the unit sphere of the span of columns of `space`."""
    d = space.shape[1]
    if d == 1:
        return wedge_norm(space[:, 0]/np.linalg.norm(space[:, 0]), n)
    best = np.inf
    for _ in range(tries):
        c = np.random.randn(d); c /= np.linalg.norm(c)
        best = min(best, wedge_norm(space @ c, n))
    return best

def eigenspaces(W, tol=1e-8):
    ev, U = np.linalg.eigh(W)
    groups, cur = [], [0]
    for k in range(1, len(ev)):
        if abs(ev[k]-ev[cur[-1]]) < tol: cur.append(k)
        else: groups.append(cur); cur = [k]
    groups.append(cur)
    return [(float(np.mean(ev[g])), U[:, g]) for g in groups]

def check_weyl(n, W):
    pr, idx, c = core.struct(n)
    return np.linalg.norm(core.ricci(W, n, idx)), core.alt_norm(W, n, idx)

def le_max(n, W, B=None):
    """max spec of L_e = e o (.) on Weyl_n cap W^perp, e = W/theta.  Sphere Hessian
    of P is 6 theta (L_e - 1/2)."""
    if B is None: B = core.weyl_basis(n)
    th = core.P(n, W)
    e = W/th
    D = len(B); Bf = B.reshape(D, -1)
    M = np.zeros((D, D))
    for k in range(D):
        M[:, k] = Bf @ core.circ(n, e, B[k]).ravel()
    M = 0.5*(M + M.T)
    cW = Bf @ W.ravel(); cW /= np.linalg.norm(cW)
    Pp = np.eye(D) - np.outer(cW, cW)
    wp = np.linalg.eigvalsh(Pp @ M @ Pp)
    # drop the eigenvalue of the removed W direction (it is 0 by construction)
    return th, wp, M, cW

print("=" * 78)
print("CLAIM 4 -- route D's closure, both halves, independently")
for n in (8, 12):
    W = padded_cp2(n)
    ric, bia = check_weyl(n, W)
    res, th = core.crit_residual(n, W)
    print(f"\nn={n}: padded W_CP2 built in Lambda^2 from the self-dual forms")
    print(f"   |Ric| = {ric:.2e}, Bianchi = {bia:.2e}  (so it is in Weyl_n)")
    print(f"   criticality residual {res:.2e}, theta = {th:.12f}, sqrt(3/2) = {S32:.12f}")
    B = core.weyl_basis(n)
    th, wp, M, cW = le_max(n, W, B)
    top = np.sort(wp)[::-1][:6]
    n_half = int(np.sum(np.abs(wp - 0.5) < 1e-9))
    n_above = int(np.sum(wp > 0.5 + 1e-9))
    print(f"   HALF (a) LOCAL MAX: dim Weyl = {len(B)}, max spec(L_e|W^perp) = {wp.max():.12f}")
    print(f"      eigenvalues > 1/2: {n_above};  eigenvalues = 1/2: {n_half};  top six {np.round(top,10)}")
    # orbit tangent directions: d/dt exp(tA) . W  =  [A_hat, W] with A in so(n)
    pr, idx, c = core.struct(n)
    A = core.Aops(n)          # A[a] = the matrix of ad(phi_a) on Lambda^2
    orb = []
    for a in range(len(pr)):
        Vv = A[a] @ W - W @ A[a]
        if np.linalg.norm(Vv) > 1e-10: orb.append(Vv/np.linalg.norm(Vv))
    if orb:
        Of = np.array([o.ravel() for o in orb])
        rank_orb = np.linalg.matrix_rank(Of, tol=1e-8)
    else:
        rank_orb = 0
    print(f"      dim of the O(n)-orbit tangent at W = {rank_orb}  (matches the 1/2-eigenspace: {rank_orb==n_half})")
    # P constant along the orbit?
    dev = max(abs(core.P(n, W + 1e-3*o) - core.P(n, W)) for o in orb[:20])
    print(f"      |P(W+1e-3 orbit dir) - P(W)| <= {dev:.2e}  (P is constant along the orbit to O(eps^2))")
    # HALF (b): Plucker
    print(f"   HALF (b) PLUCKER:")
    for lam, sp in eigenspaces(W):
        if abs(lam) < 1e-10: continue
        mw = min_wedge_over(sp, n)
        print(f"      eigenvalue {lam: .9f} (dim {sp.shape[1]}): min ||omega^omega|| = {mw:.9f}")
    # is the criterion right?  check the Hessian formula by finite differences
    Bf = B.reshape(len(B), -1)
    for _ in range(2):
        cv = np.random.randn(len(B)); V = np.einsum('k,kab->ab', cv, B)
        V = V - np.trace(V@W)*W; V /= np.linalg.norm(V)
        h = 1e-4
        Wp = W + h*V; Wp /= np.linalg.norm(Wp)
        Wm = W - h*V; Wm /= np.linalg.norm(Wm)
        fd = (core.P(n, Wp) - 2*core.P(n, W) + core.P(n, Wm))/h**2
        pred = 6*th*(float(np.trace(core.circ(n, W/th, V) @ V)) - 0.5)
        print(f"      Hessian check: FD {fd: .8f} vs 6 theta (<L_e V,V> - 1/2) {pred: .8f}")

print()
print("=" * 78)
print("CLAIM 5 -- the mechanism route D left behind")
n = 12
B = core.weyl_basis(n)
print("\n(i) is every one-positive/two-negative element Plucker-obstructed?")
for (q, r) in [(1.0,1.0), (1.0,0.3), (1.0,0.05), (2.0,1.3)]:
    W = stratum_member(n, q, r)
    ric, bia = check_weyl(n, W)
    ev = np.linalg.eigvalsh(W)
    npos = int(np.sum(ev > 1e-10)); nneg = int(np.sum(ev < -1e-10))
    obstructed = []
    for lam, sp in eigenspaces(W):
        if abs(lam) < 1e-10: continue
        obstructed.append((round(lam,9), sp.shape[1], round(min_wedge_over(sp, n), 9)))
    print(f"   (q,r)=({q},{r}): |Ric|={ric:.1e} Bianchi={bia:.1e}  #pos={npos} #neg={nneg} "
          f"theta={core.P(n,W):.9f}  eigenspaces {obstructed}")

print("\n(iii) WITNESS AGAINST  Plucker-obstructed => theta <= sqrt(3/2)")
def sphere_product(m):
    p = q = m//2
    x, y, z = 1.0/(p*(p-1)), 1.0/(q*(q-1)), -1.0/(p*q)
    lam = np.zeros(m*(m-1)//2)
    for a, (i, j) in enumerate(core.pairs(m)):
        lam[a] = x if (i < p and j < p) else (y if (i >= p and j >= p) else z)
    Wm = np.diag(lam)
    return Wm/np.linalg.norm(Wm)

Wst = sphere_product(n)
print(f"   theta_0(12) = {core.P(n, Wst):.12f}   sqrt(3/2) = {S32:.12f}")
for eps in (1e-1, 3e-2, 1e-2):
    cv = np.random.randn(len(B)); V = np.einsum('k,kab->ab', cv, B); V /= np.linalg.norm(V)
    Wp = Wst + eps*V; Wp /= np.linalg.norm(Wp)
    ric, bia = check_weyl(n, Wp)
    th = core.P(n, Wp)
    # every eigenspace: is any obstructed?
    obs = []
    for lam, sp in eigenspaces(Wp, tol=1e-7):
        mw = min_wedge_over(sp, n, tries=300)
        obs.append(mw)
    obs = np.array(obs)
    print(f"   eps={eps:.0e}: |Ric|={ric:.1e} Bianchi={bia:.1e}  theta={th:.9f} "
          f"(> sqrt(3/2)? {th > S32})  max over eigenspaces of min||w^w|| = {obs.max():.6f} "
          f"-> Plucker-obstructed? {obs.max() > 1e-6}")
