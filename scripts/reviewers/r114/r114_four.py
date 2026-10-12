"""Hunt criticality in each of the four involution-invariant Weyl subspaces at n=6 and test
gradedness.  W is graded  <=>  sign(W) = Lambda^2(g) for some g in O(6) with g^2 = +-I."""
import numpy as np, sys, os, json, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from r114_core import *
from scipy.optimize import least_squares

n = 6
S = Setup(n)
prs, idx = pair_index(n)
B, _, _ = weyl_basis(n)

def lam2(g):
    """action of g in O(n) on Lambda^2 in the e_i^e_j basis"""
    N = len(prs)
    L = np.zeros((N, N))
    for b, (k, l) in enumerate(prs):
        for a, (i, j) in enumerate(prs):
            L[a, b] = g[i, k] * g[j, l] - g[i, l] * g[j, k]
    return L

def invol(name):
    if name.startswith('p'):
        p = int(name[1:])
        g = np.diag([-1.0]*p + [1.0]*(n-p))
    elif name == 'J':
        g = np.zeros((n, n))
        for k in range(0, n, 2):
            g[k, k+1] = 1.0; g[k+1, k] = -1.0
    return lam2(g)

def invariant_basis(D):
    G = np.array([[np.sum(B[k]*(D@B[l]@D.T)) for l in range(84)] for k in range(84)])
    w, U = np.linalg.eigh(G)
    return np.einsum('kj,jab->kab', U[:, w > 0].T, B), G

def hunt(name, NST, seed, theta_target=None):
    D = invol(name)
    assert np.abs(D @ D - np.eye(15)).max() < 1e-10, (name, np.abs(D@D-np.eye(15)).max())
    C, G = invariant_basis(D)
    d = C.shape[0]
    dplus = int((np.linalg.eigvalsh(D) > 0).sum())
    print(f"[{name}] dim Weyl^inv = {d}; Lambda^2 splits {dplus}/{15-dplus}", flush=True)
    M_of = lambda x: np.einsum('k,kab->ab', x, C)
    def resid(x):
        M = M_of(x); th = S.theta(M)
        r = np.einsum('kab,ab->k', C, S.Q(M) - th*M)
        extra = [np.sum(x*x) - 1.0]
        if theta_target is not None:
            extra.append(10.0*(th - theta_target))
            ev, Ph, Pm, Pz, _, _, _ = spectral_projectors(M, 1e-9)
            extra.append(10.0*np.sqrt(max(Tblock(S.c, Pm, Pm, Pm), 0.0)))
        return np.concatenate([r, extra])
    rng = np.random.default_rng(seed)
    out = []
    for t in range(NST):
        x0 = rng.standard_normal(d); x0 /= np.linalg.norm(x0)
        s = least_squares(resid, x0, xtol=1e-15, ftol=1e-15, gtol=1e-15, max_nfev=20000)
        M = M_of(s.x); M /= np.linalg.norm(M)
        th = S.theta(M)
        if th < 0: M, th = -M, -th
        fr = np.linalg.norm(S.Q(M) - th*M)
        if fr > 1e-12: continue
        r = grading_report(S, M, tol=1e-9)
        ev = np.linalg.eigvalsh(M)
        nz = [abs(e) for e in ev if abs(e) > 1e-9]
        # sign-definiteness w.r.t. THIS involution
        Pp = (np.diag(D) > 0)
        out.append(dict(theta=float(th), res=float(fr), S=float(r['S']),
                        Thhm=float(r['T']['hhm']), dh=r['dim_h'], dm=r['dim_m'], dz=r['dim_ker'],
                        gap=float(min(nz)), graded=bool(r['graded_kerfree'])))
        if (t+1) % 100 == 0:
            print(f"[{name}] {t+1}/{NST} conv={len(out)}", flush=True)
    uniq = []
    for z in sorted(out, key=lambda z: z['theta']):
        if not any(abs(z['theta']-u['theta']) < 1e-9 and abs(z['gap']-u['gap']) < 1e-9 for u in uniq):
            uniq.append(z)
    gr = [z for z in uniq if z['graded']]
    print(f"[{name}] converged {len(out)}/{NST}, distinct {len(uniq)}, GRADED {len(gr)}", flush=True)
    for z in gr:
        print(f"[{name}]   GRADED theta={z['theta']:.9f} gap={z['gap']:.6e} dims {z['dh']}/{z['dm']}", flush=True)
    s0 = [z for z in uniq if abs(z['S']) < 1e-8]
    for z in s0:
        print(f"[{name}]   S=0 theta={z['theta']:.9f} gap={z['gap']:.6e} T_hhm={z['Thhm']:.4e} "
              f"dims {z['dh']}/{z['dm']}/{z['dz']} graded={z['graded']}", flush=True)
    print(f"[{name}] theta range [{min(z['theta'] for z in uniq):.6f},{max(z['theta'] for z in uniq):.6f}]", flush=True)
    json.dump(uniq, open(os.path.join(os.path.dirname(os.path.abspath(__file__)), f'uniq_{name}{"_tgt" if theta_target else ""}.json'), 'w'))
    return uniq

if __name__ == '__main__':
    name = sys.argv[1]; NST = int(sys.argv[2]); seed = int(sys.argv[3])
    tt = float(sys.argv[4]) if len(sys.argv) > 4 else None
    hunt(name, NST, seed, tt)
