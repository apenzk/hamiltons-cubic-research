"""Independent solver for diagonal critical points: hollow(Phi(M)) = theta M, tr M^2 = 2."""
import sys; sys.path.insert(0,'scripts/reviewers/r304')
import numpy as np, r304_core as C
from scipy.optimize import least_squares

def make_space(n):
    return C.basis_hollow_zero_rowsum(n)

def M_of(x, Bs):
    M = sum(xi*Bi for xi, Bi in zip(x, Bs))
    nrm = np.sqrt(np.sum(M*M))
    if nrm < 1e-12: return None
    return M*np.sqrt(2)/nrm

def solve(n, Bs, x0, tol=1e-13):
    def res(x):
        M = M_of(x, Bs)
        if M is None: return np.ones(len(Bs))*1e3
        R = C.crit_residual(M)
        return np.array([float(np.sum(B*R)) for B in Bs])
    s = least_squares(res, x0, xtol=3e-16, ftol=3e-16, gtol=3e-16, max_nfev=6000)
    M = M_of(s.x, Bs)
    return M, float(np.abs(C.crit_residual(M)).max())

def find(n, tries=200, seed=0):
    rng = np.random.default_rng(seed); Bs = make_space(n); out = []
    for t in range(tries):
        M, r = solve(n, Bs, rng.normal(size=len(Bs)))
        if r < 1e-12: out.append((M, r))
    return out

def signature(M, dec=6):
    ev = np.sort(np.linalg.eigvalsh(M))
    return tuple(np.round(ev, dec))

if __name__ == '__main__':
    n = int(sys.argv[1]); tries = int(sys.argv[2]) if len(sys.argv) > 2 else 100
    sols = find(n, tries, seed=304+n)
    seen = {}
    for M, r in sols:
        # canonical: sort by |theta| and spectrum
        th = C.theta_of(M); sig = signature(M)
        key = (round(th, 8), sig)
        if key not in seen: seen[key] = (M, r, th)
    print(f"n={n}: {len(sols)}/{tries} converged, {len(seen)} distinct spectra")
    rows = []
    for (th, sig), (M, r, _) in sorted(seen.items(), key=lambda kv: -kv[0][0]):
        d, gs = C.defect_delta(M)
        kerdim = int(np.sum(np.abs(np.linalg.eigvalsh(M)) < 1e-9))
        rows.append((th, d, kerdim, r, M))
        print(f"  theta={th:+.6f} Delta={d:+.6f} dimkerM={kerdim} res={r:.1e}")
    np.save(f'/private/tmp/claude-501/-Users-ap-code-private-hamiltons-cubic/d494340f-1dff-4003-801d-ae0e180c75c5/scratchpad/crit_n{n}.npy',
            np.array([r[4] for r in rows]))
