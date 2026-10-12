"""Claim 4: is the GRADED critical set a finite union of O(n)-orbits of
symmetric-pair points?  Test the premise directly.

A Z2-grading of so(n) is Ad(sigma) for an involution sigma in O(n).  Weyl_n^sigma
is a linear subspace, Q preserves it, Pi_Weyl is O(n)-equivariant, so by the
principle of symmetric criticality every critical point of P restricted to
Weyl_n^sigma is critical in Weyl_n.  Gradedness of such a point is the extra
SIGN condition: lambda >= 0 exactly on h, lambda < 0 exactly on m.
Enumerate critical points of P|Weyl^sigma and count the graded ones.
"""
import numpy as np, sys
from core111 import Core
import points111 as P

def sigma_split(C, p):
    n = C.n
    s = np.array([1.0]*p + [-1.0]*(n-p))
    par = np.array([s[i]*s[j] for (i, j) in C.pairs])   # +1 on h, -1 on m
    return par

def sym_basis(C, par):
    """orthonormal basis of the Ad(sigma)-invariant Weyl operators."""
    B = C.weyl_basis()
    Sg = np.outer(par, par)
    k = len(B)
    A = np.array([b.ravel() for b in B])
    Ainv = np.array([(Sg*b).ravel() for b in B])
    Grm = A @ Ainv.T                      # the involution in Weyl coordinates
    Grm = 0.5*(Grm+Grm.T)
    w, V = np.linalg.eigh(Grm)
    keep = w > 0.5
    return V[:, keep], B          # columns: coordinates of an ON basis of Weyl^sigma

def make(C, B, V, y):
    x = V @ y
    return sum(v*b for v, b in zip(x, B)), x

def solve(C, B, V, y0, iters=200):
    y = y0/np.linalg.norm(y0)
    for it in range(iters):
        M, x = make(C, B, V, y)
        th = C.theta(M)
        Fm = C.weyl_project(C.Qop(M)) - th*M
        f = V.T @ np.array([np.sum(Fm*b) for b in B])
        if np.linalg.norm(f) < 1e-13: break
        cols = []
        for j in range(V.shape[1]):
            h = sum(v*b for v, b in zip(V[:, j], B))
            dQ = C.hess_euclid(M, h)/3.0
            dth = 3.0*np.sum((C.weyl_project(C.Qop(M)))*h)
            col = dQ - dth*M - th*h
            cols.append(V.T @ np.array([np.sum(col*b) for b in B]))
        J = np.array(cols).T
        J = J - np.outer(J @ y, y)
        step, *_ = np.linalg.lstsq(J, -f, rcond=1e-9)
        step = step - (step@y)*y
        t = 1.0
        y = y + t*step; y /= np.linalg.norm(y)
    M, x = make(C, B, V, y)
    return y, M, np.linalg.norm(C.weyl_project(C.Qop(M)) - C.theta(M)*M)

def graded_check(C, M, par, tol=1e-9):
    lam, Vv = C.spectral(M)
    # eigenvector parity: each eigenvector lies in h (par=+1) or m (par=-1)
    ok, sgn = True, []
    for a in range(C.D):
        v = Vv[:, a]
        ph = np.linalg.norm(v[par > 0]); pm = np.linalg.norm(v[par < 0])
        if min(ph, pm) > 1e-7: return False, lam, "eigvec not parity-pure"
        inh = ph > pm
        if inh and lam[a] < -tol: return False, lam, "neg eigenvalue on h"
        if (not inh) and lam[a] > tol: return False, lam, "nonneg eigenvalue on m"
    return True, lam, "graded"

if __name__ == '__main__':
    n = int(sys.argv[1]); p = int(sys.argv[2]); ntry = int(sys.argv[3])
    C = Core(n); par = sigma_split(C, p)
    V, B = sym_basis(C, par)
    print("n=%d split %d+%d : dim Weyl_n=%d  dim Weyl^sigma=%d  dim h=%d dim m=%d"
          % (n, p, n-p, len(B), V.shape[1], int((par > 0).sum()), int((par < 0).sum())))
    rng = np.random.default_rng(4242)
    found = []
    for t in range(ntry):
        y0 = rng.standard_normal(V.shape[1])
        y, M, res = solve(C, B, V, y0)
        if res > 1e-10: continue
        th = C.theta(M)
        g, lam, why = graded_check(C, M, par)
        S = C.slack_struct(M)
        key = (round(th, 8), round(S, 6), tuple(np.round(np.sort(lam), 6)))
        found.append((th, S, g, why, key))
    seen = {}
    for th, S, g, why, key in found:
        seen.setdefault(key, [0, th, S, g, why])[0] += 1
    print("  distinct critical points found: %d (from %d converged solves)" % (len(seen), len(found)))
    for key, (cnt, th, S, g, why) in sorted(seen.items(), key=lambda kv: -abs(kv[1][1])):
        print("    theta=%+.9f  S=%.3e  graded=%-5s (%-22s) hits=%d" % (th, S, g, why, cnt))
