"""H1: is L_e scalar on each k-isotypic component of V = span{H_A}?

Method.  V is k-invariant and L_e|_V commutes with k (checked).  By Schur, L_e is
scalar on an isotypic component iff it lies in the CENTRE of the commutant of the
k-action.  So: build the commutant, build its centre, split V into the eigenspaces
of a generic central element -- those ARE the isotypic components -- and read the
spectrum of L_e on each.
"""
import numpy as np, sys, os, itertools
sys.path.insert(0, os.path.dirname(__file__))
import core301 as C, points301 as PT, sym0 as S

def lam2(n, g):
    P, idx = C.pairs(n); N = len(P)
    M = np.zeros((N, N))
    for b, (i, j) in enumerate(P):
        for a, (k, l) in enumerate(P):
            M[a, b] = g[k, i] * g[l, j] - g[l, i] * g[k, j]
    return M

def group_action_on_V(n, g, U):
    G = lam2(n, g); Bs = C.weyl_basis(n); Mw = C.weyl_mat(n)
    A = np.zeros((len(Bs), len(Bs)))
    for i, b in enumerate(Bs):
        A[:, i] = Mw @ C.sym_to_vec(n, G @ b @ G.T)
    return U @ A @ U.T

def analyse(name, n, W, group=(), rng=None):
    rng = rng or np.random.default_rng(7)
    th, _ = PT.theta_and_resid(n, W)
    Ab, H, U, Mc, sv = S.compression(n, W, th)
    kb = C.isotropy(n, W)
    acts = S.k_action_on_V(n, W, kb, U)
    gacts = [group_action_on_V(n, g, U) for g in group]
    allm = acts + [a - np.eye(U.shape[0]) for a in gacts]
    Cm = S.commutant(acts + gacts) if (acts or gacts) else np.array([np.eye(U.shape[0])])
    # centre of the commutant
    d = U.shape[0]
    if len(Cm):
        Z = S.commutant(list(Cm) + acts + gacts) if (acts or gacts) else np.array([np.eye(d)])
    else:
        Z = np.zeros((0, d, d))
    # generic symmetric central element
    if len(Z):
        Y = sum(rng.normal() * (z + z.T) for z in Z)
    else:
        Y = np.eye(d)
    ev, Vv = np.linalg.eigh(Y)
    # cluster eigenvalues of Y -> isotypic components
    comps = []
    for i, e in enumerate(ev):
        if comps and abs(e - comps[-1][0]) < 1e-7 * max(1.0, abs(e)):
            comps[-1][1].append(i)
        else:
            comps.append([e, [i]])
    out = []
    for e, idxs in comps:
        B = Vv[:, idxs]
        sub = B.T @ Mc @ B
        w = np.linalg.eigvalsh(0.5 * (sub + sub.T))
        out.append((len(idxs), w))
    eqres = max([np.abs(a @ Mc - Mc @ a).max() for a in acts + gacts] + [0.0])
    return dict(name=name, n=n, theta=th, dimV=U.shape[0], dimk=kb.shape[0],
                ncomp=len(out), comps=out, commutant=len(Cm), centre=len(Z),
                equivar=eqres, Mc=Mc)

def show(r):
    print(f"== {r['name']}  n={r['n']} theta={r['theta']:.6f} dimV={r['dimV']} "
          f"dim k={r['dimk']} dim(commutant)={r['commutant']} dim(centre)={r['centre']}")
    print(f"   equivariance residual {r['equivar']:.1e};  {r['ncomp']} isotypic components")
    bad = 0
    for dim, w in r['comps']:
        spread = w.max() - w.min()
        flag = ''
        if spread > 1e-7:
            flag = '   <-- NOT SCALAR'
            bad += 1
        vals = ", ".join(f"{x:.6f}" for x in np.unique(np.round(w, 7)))
        print(f"   dim {dim:3d}: L_e = {vals}{flag}")
    print(f"   ==> {bad} of {r['ncomp']} isotypic components carry a non-scalar L_e")
    return bad
