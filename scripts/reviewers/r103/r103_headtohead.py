"""Head-to-head against Claim 4's n=6 table, using ONE structured K (no outer search)."""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r103'))
import r103_core as C
from r103_claim5 import F_of_K, balanced_vertex, theta0, inner_max_p3
from itertools import combinations
from scipy.optimize import minimize
from scipy.linalg import null_space

recorded6 = {0.25: 3.586, 0.5: 3.247, 1.0: 2.519, 1.5: 1.660, 1.9: -0.144, 2.0: -0.146}
print("=== Claim 4's n=6 table vs a SINGLE fixed K = c*K_sphere (c = sqrt(t/2)) ===")
print(f" {'t':>5} {'recorded R(t)':>14} {'F(c*Ksph)':>11} {'better by':>10}   theta0(6)=%.6f" % theta0(6))
Khat6 = balanced_vertex(3)
mine6 = {}
for t, rec in recorded6.items():
    c = np.sqrt(t/2.0)
    v, A, B = F_of_K(c*Khat6, seed=int(t*997), nstart=90)
    mine6[t] = v
    print(f" {t:>5} {rec:>14.3f} {v:>11.4f} {v-rec:>+10.4f}")

print()
print("=== the same at n=12 (Claim 4 never ran it) ===")
Khat12 = balanced_vertex(6)
for t in (0.25, 0.5, 1.0, 1.5, 1.9, 2.0):
    c = np.sqrt(t/2.0)
    v, A, B = F_of_K(c*Khat12, seed=int(t*991)+7, nstart=60)
    print(f" t={t:<5} F(c*Ksph)={v:.4f}  /theta0(12)={v/theta0(12):.4f}")

print()
print("=== kappa^2 of the witness W = c*W_sphere + sqrt(1-c^2)*W'  (K(W')=0) ===")
def frame_kappa2(W, n, nstart=6, seed=0):
    """max over orthonormal frames F of ||K(F)||_F^2, by ascent on so(n) coordinates."""
    rng = np.random.default_rng(seed)
    idx = list(combinations(range(n), 2))
    def rot(p):
        A = np.zeros((n, n))
        for k, (i, j) in enumerate(idx): A[i, j] = p[k]; A[j, i] = -p[k]
        from scipy.linalg import expm
        return expm(A)
    def neg(p):
        Q = rot(p)
        Wr = np.einsum('ai,bj,ck,dl,ijkl->abcd', Q, Q, Q, Q, W)
        K = C.vertex_matrix(Wr, n)
        return -np.linalg.norm(K)**2
    best = -9e9; bp = None
    for s in range(nstart):
        p0 = 0.0*rng.standard_normal(len(idx)) if s == 0 else rng.standard_normal(len(idx))
        r = minimize(neg, p0, method='L-BFGS-B', options=dict(maxiter=800))
        if -r.fun > best: best, bp = -r.fun, r.x
    return best, rot(bp)

rng = np.random.default_rng(4242)
n = 6
prs = list(combinations(range(n), 2))
samples = [C.weyl_from_random(n, rng) for _ in range(40)]
A = np.array([[S[i, j, i, j] for S in samples] for (i, j) in prs])
Wp = sum(cc*S for cc, S in zip(null_space(A)[:, 0], samples))
Wp = Wp/np.linalg.norm(C.M_of(Wp, n))
Wd = C.weyl_from_vertex(balanced_vertex(3)); Wd = Wd/np.linalg.norm(C.M_of(Wd, n))
for c in (0.95, 0.9, 0.8, 0.7):
    W = c*Wd + np.sqrt(1-c*c)*Wp
    t_coord = np.linalg.norm(C.vertex_matrix(W, n))**2
    k2, Q = frame_kappa2(W, n, nstart=5, seed=int(100*c))
    Wr = np.einsum('ai,bj,ck,dl,ijkl->abcd', Q, Q, Q, Q, W)
    Kbest = C.vertex_matrix(Wr, n)
    Fbest, _, _ = F_of_K(Kbest, seed=17, nstart=60)
    Fcoord, _, _ = F_of_K(C.vertex_matrix(W, n), seed=19, nstart=60)
    th = C.theta_bispectral(W, n)[0]
    print(f" c={c}: theta(W)={th:+.5f}  t_coord={t_coord:.4f} kappa^2={k2:.4f}  "
          f"F(best frame)={Fbest:.4f}  F(coord frame)={Fcoord:.4f}  theta0(6)={theta0(6):.4f}")
