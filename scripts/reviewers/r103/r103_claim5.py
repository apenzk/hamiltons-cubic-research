"""Claim 5: audit the route-closing inference.

Key move: drop the outer max over K. For a FIXED vertex matrix K the relaxation
value F(K) needs only the two inner problems, which are far more reliable than a
joint nonconvex solve, and monotonicity under scaling K is a theorem.
"""
import os as _os
_ROOT = _os.path.abspath(_os.path.join(_os.path.dirname(_os.path.abspath(__file__)), '..', '..', '..'))
import sys, numpy as np
sys.path.insert(0, _os.path.join(_ROOT, 'scripts/reviewers/r103'))
import r103_core as C
from scipy.optimize import minimize
from scipy.linalg import null_space
from itertools import combinations

def theta0(n): return np.sqrt(2.0*(n-1)*(n-2))/n

def inner_max_p3(v, s2, nstart=60, seed=0):
    """max { p3(x) : sum x = 0, ||x||^2 = s2, x majorizes v }, x sorted descending."""
    v = np.sort(np.asarray(v, float))[::-1]
    D = len(v); cv = np.cumsum(v)[:-1]
    rng = np.random.default_rng(seed)
    cons = [dict(type='eq', fun=lambda x: np.array([x.sum(), x@x - s2])),
            dict(type='ineq', fun=lambda x: np.concatenate([x[:-1]-x[1:], np.cumsum(x)[:-1]-cv]))]
    a = np.sqrt(s2/(D*(D-1))); ok = np.full(D, -a); ok[0] = (D-1)*a
    nv = np.linalg.norm(v)
    starts = [ok]
    if nv > 1e-12: starts.append(v*np.sqrt(s2)/nv)
    for k in range(nstart):
        if nv > 1e-12 and k % 3 == 0:
            w = v*np.sqrt(s2)/nv + 0.4*rng.standard_normal(D)
        elif k % 3 == 1:
            w = ok + 0.3*np.sqrt(s2)*rng.standard_normal(D)
        else:
            w = rng.standard_normal(D)
        w = np.sort(w)[::-1]; w -= w.mean()
        nw = np.linalg.norm(w)
        starts.append(w*np.sqrt(s2)/nw)
    best, bx = -9e9, None
    for x0 in starts:
        try:
            r = minimize(lambda x: -np.sum(x**3), x0, constraints=cons, method='SLSQP',
                         options=dict(maxiter=400, ftol=1e-12))
        except Exception:
            continue
        x = r.x
        eq = max(abs(x.sum()), abs(x@x - s2))
        iq = min(np.concatenate([x[:-1]-x[1:], np.cumsum(x)[:-1]-cv]).min(), 0.0)
        if eq < 1e-8 and iq > -1e-8 and np.sum(x**3) > best:
            best, bx = float(np.sum(x**3)), x
    return best, bx

def F_of_K(K, seed=0, nstart=60):
    """The both-sided Schur-Horn relaxation value at a FIXED vertex matrix K."""
    dphi, d, nu = C.diagonals_from_K(K)
    A, _ = inner_max_p3(dphi, 1.0, nstart=nstart, seed=seed)        # max p3(mu)
    Bm, _ = inner_max_p3(-d, 3.0, nstart=nstart, seed=seed+1)       # max p3(-omega)
    return 1.5*A + 0.5*Bm, A, -Bm

def balanced_vertex(m):
    n = 2*m; a = 1.0/np.sqrt((m-1)*(2*m-1)); b = -(m-1)*a/m
    K = np.full((n, n), b); K[:m, :m] = a; K[m:, m:] = a; np.fill_diagonal(K, 0.0); return K

def okumura_val(N, s2): return (N-2)/np.sqrt(N*(N-1))*s2**1.5

print("=== (1) unconstrained ceiling and the analytic omega-side threshold ===")
for n in (6, 8, 12):
    D = n*(n-1)//2; N = n*(n+1)//2 - 1
    unc = 1.5*okumura_val(D, 1.0) + 0.5*okumura_val(N, 3.0)
    tthr = 3.0*(n-1)*(n-2)/(N*(N-1))
    EF = 12.0/((n+1)*(n+2))
    print(f" n={n:>2}: unconstrained R(0)={unc:.4f}  theta0={theta0(n):.4f}  ratio={unc/theta0(n):.3f}"
          f"   omega-threshold t*={tthr:.5f}   E_F||K||^2 = {EF:.5f}  (kappa^2 >= E_F)")

print()
print("=== (2) THE WITNESS: F(c * K_sphere) for c<1, i.e. t = 2c^2 ===")
print("    monotonicity under scaling is a theorem: x > c*v is weaker for smaller c,")
print("    so F(cK) >= F(K) = theta0 for every c<=1. Strictness is what is measured.")
for n in (6, 12):
    Khat = balanced_vertex(n//2)
    print(f"  n={n}, theta0={theta0(n):.6f}")
    for c in (1.0, 0.999, 0.99, 0.95, 0.9, 0.8, 0.7, 0.5):
        K = c*Khat
        t = np.linalg.norm(K)**2
        val, A, B = F_of_K(K, seed=int(1000*c)+n, nstart=45)
        print(f"    c={c:<6} t={t:.4f}  F={val:.6f}  /theta0={val/theta0(n):.4f}   "
              f"[p3max(mu)={A:+.6f} p3min(om)={B:+.6f}]")

print()
print("=== (3) realisability of the witness: a unit Weyl tensor with K(W) = c*K_sphere ===")
rng = np.random.default_rng(4242)
for n in (6, 8, 12):
    # find a Weyl tensor with vanishing vertex matrix, by least squares on random samples
    prs = list(combinations(range(n), 2))
    samples = [C.weyl_from_random(n, rng) for _ in range(max(40, len(prs)+15))]
    A = np.array([[S[i, j, i, j] for S in samples] for (i, j) in prs])   # D x S
    ns = null_space(A)
    if ns.shape[1] == 0:
        print(f"  n={n}: no K=0 direction found in the sampled span"); continue
    coef = ns[:, 0]
    Wp = sum(cc*S for cc, S in zip(coef, samples))
    Mp = C.M_of(Wp, n); Wp = Wp/np.linalg.norm(Mp)
    Kp = C.vertex_matrix(Wp, n)
    chk = C.weyl_checks(Wp, n)
    print(f"  n={n}: found W' with ||M'||=1, max|K(W')| = {np.abs(Kp).max():.2e}, "
          f"Weyl residual {max(chk.values()):.1e}")
    Khat = balanced_vertex(n//2) if n % 2 == 0 else None
    if Khat is None: continue
    Wd = C.weyl_from_vertex(Khat)
    Wd = Wd/np.linalg.norm(C.M_of(Wd, n))
    for c in (0.9, 0.7):
        W = c*Wd + np.sqrt(1-c*c)*Wp
        M = C.M_of(W, n)
        K = C.vertex_matrix(W, n)
        print(f"     c={c}: ||M||={np.linalg.norm(M):.9f}  |K - c*Khat|={np.abs(K-c*Khat).max():.1e}  "
              f"t={np.linalg.norm(K)**2:.5f}  theta={C.theta_bispectral(W,n)[0]:+.6f}")

print()
print("=== (4) is Conjecture A true at n=6?  the padded CP^2 witness ===")
def cpm_weyl(m):
    n = 2*m
    J = np.zeros((n, n))
    for k in range(m): J[2*k, 2*k+1] = 1.0; J[2*k+1, 2*k] = -1.0
    I = np.eye(n)
    R = (np.einsum('ik,jl->ijkl', I, I) - np.einsum('il,jk->ijkl', I, I)
         + np.einsum('ik,jl->ijkl', J, J) - np.einsum('il,jk->ijkl', J, J)
         + 2*np.einsum('ij,kl->ijkl', J, J))
    return C.weyl_part(R, n)
W4 = cpm_weyl(2)
for n in (6, 8, 10, 12):
    W = np.zeros((n, n, n, n)); W[:4, :4, :4, :4] = W4
    print(f"  padded CP^2 into n={n}: Weyl residual={max(C.weyl_checks(W,n).values()):.1e} "
          f"theta={C.theta_bispectral(W,n)[0]:.6f}  theta0({n})={theta0(n):.6f}  "
          f"{'CONJECTURE A FALSE HERE' if C.theta_bispectral(W,n)[0] > theta0(n)+1e-9 else 'below threshold'}"
          f"  t={np.linalg.norm(C.vertex_matrix(C.theta_bispectral(W,n)[3], n))**2:.4f}")
