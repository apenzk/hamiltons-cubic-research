"""Claim 4: (i) is there a non-orbit critical branch through a genuinely GRADED
degenerate critical point (S^3xS^3 at n=6, kernel 18 vs orbit 9)?
(ii) the u(m) Hermitian point: graded? degenerate?"""
import numpy as np, sys
from core111 import Core
import points111 as P

def machinery(C, W0):
    B = C.weyl_basis(); k = len(B)
    to_x = lambda M: np.array([np.sum(M*b) for b in B])
    to_M = lambda x: sum(v*b for v, b in zip(x, B))
    x0 = to_x(W0); th = C.theta(W0)
    H = np.array([to_x(C.hess_euclid(W0, b)) for b in B]).T; H = 0.5*(H+H.T)
    Pp = np.eye(k) - np.outer(x0, x0)
    ev, EV = np.linalg.eigh(Pp @ (H - 3*th*np.eye(k)) @ Pp)
    K = EV[:, np.abs(ev) < 1e-7*np.abs(H).max()]
    K = K - np.outer(x0, x0 @ K); K = K[:, np.linalg.norm(K, axis=0) > 1e-8]
    Ot = C.orbit_tangent(W0)
    Otb = np.array([[np.sum(b*Ot[:, g].reshape(C.D, C.D)) for g in range(C.D)] for b in B])
    U, s, _ = np.linalg.svd(Otb, full_matrices=False); orb = int((s > 1e-8*s[0]).sum())
    Uo = U[:, :orb]
    Kt = K - Uo @ (Uo.T @ K)
    Uk, sk, _ = np.linalg.svd(Kt, full_matrices=False); exc = int((sk > 1e-8).sum())
    return B, to_x, to_M, x0, th, Uo, orb, K.shape[1], Uk[:, :exc], exc

def run(C, W0, tag, epss=(1e-2, 1e-3, 1e-4), ndir=4, seed=5):
    B, to_x, to_M, x0, th, Uo, orb, nk, Trans, exc = machinery(C, W0)
    a, b = C.slacks(W0)
    print("%s: theta=%.9f orbit=%d ker=%d excess=%d  S_mmm=%.2e S_hhm=%.2e graded=%s"
          % (tag, th, orb, nk, exc, a, b, "YES" if max(a, b) < 1e-8 else "NO"))
    if exc == 0:
        print("   nondegenerate -> Crit(P) is locally exactly the orbit"); return
    Fv = lambda x: to_x(C.weyl_project(C.Qop(to_M(x))) - C.theta(to_M(x))*to_M(x))
    def J(x):
        M = to_M(x); t = C.theta(M); Qw = C.weyl_project(C.Qop(M))
        return np.array([to_x(C.hess_euclid(M, bb)/3.0 - 3*np.sum(Qw*bb)*M - t*bb) for bb in B]).T
    rng = np.random.default_rng(seed)
    for d in range(ndir):
        v = Trans @ rng.standard_normal(exc); v /= np.linalg.norm(v)
        line = []
        for eps in epss:
            x = x0 + eps*v; x /= np.linalg.norm(x)
            A = np.vstack([Uo.T, v[None, :]]); bb = np.concatenate([Uo.T@x0, [x0@v+eps]])
            for it in range(60):
                r = np.concatenate([Fv(x), A@x - bb, [0.5*(x@x-1)]])
                if np.linalg.norm(r) < 1e-14: break
                Jr = np.vstack([J(x), A, x[None, :]])
                st, *_ = np.linalg.lstsq(Jr, -r, rcond=1e-11)
                x = x + st; x /= np.linalg.norm(x)
            res = np.linalg.norm(Fv(x))
            line.append((eps, res, res/eps**2, C.slacks(to_M(x))[0]))
        print("   dir%d: " % d + "  ".join("eps=%.0e |F|=%.2e |F|/eps^2=%.2f S_mmm=%.2e" % t for t in line))

n = 6; C = Core(n)
run(C, P.sphere_product(C, (3, 3)), "S^3xS^3 n=6")
run(C, P.sphere_product(C, (2, 4)), "S^2xS^4 n=6")
# the u(m) Hermitian point at n=8: the unique U(4)-invariant Weyl operator
n = 8; C8 = Core(n); B8 = C8.weyl_basis(); c = C8.struct()
m = n//2; Jc = np.zeros((n, n))
for a in range(m): Jc[2*a, 2*a+1] = 1.0; Jc[2*a+1, 2*a] = -1.0
Ad = np.zeros((C8.D, C8.D))
for a, (i, j) in enumerate(C8.pairs):
    X = np.zeros((n, n)); X[i, j] = 1; X[j, i] = -1; Y = Jc @ X @ Jc.T
    for bq, (k2, l2) in enumerate(C8.pairs): Ad[bq, a] = Y[k2, l2]
w, V = np.linalg.eigh(0.5*(Ad+Ad.T)); hs = [V[:, a] for a in range(C8.D) if w[a] > 0]
rows = []
Bm = np.array([b.ravel() for b in B8])
rng = np.random.default_rng(1)
gens = hs[:4] + [sum(rng.standard_normal()*h for h in hs) for _ in range(3)]
for x in gens:
    A = np.einsum('g,gba->ab', x, c)
    rows.append(np.array([(A@b - b@A).ravel() for b in B8]) @ Bm.T)
Mb = np.vstack(rows)
_, sv, Vt = np.linalg.svd(Mb)
null = Vt[len(sv) - int((sv < 1e-8).sum()):] if (sv < 1e-8).sum() else Vt[-1:]
nvec = Vt[-1]
Wu = sum(v*b for v, b in zip(nvec, B8)); Wu /= np.linalg.norm(Wu)
if C8.theta(Wu) < 0: Wu = -Wu
print("\nSO(8)/U(4) point: theta=%.9f (record 0.986013297) crit-res=%.1e nullity of the invariance system=%d"
      % (C8.theta(Wu), C8.crit_residual(Wu), int((sv < 1e-8).sum())))
run(C8, Wu, "SO(8)/U(4) n=8", ndir=2)
