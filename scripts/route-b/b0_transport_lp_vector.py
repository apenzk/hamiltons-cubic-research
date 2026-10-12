"""The bracket-transportation LP, re-run with the VECTOR identity fence post 15 lacked.

FENCE POST 15 records that the relaxation carries "every constraint T is known to
satisfy -- row marginal 2(n-2), pair cap 2, tr(W^#) = -1" and still returns 1.6059 at
n = 6 against theta_0(6) = 1.0541, so no marginal-only argument can close B3.

That inventory is incomplete.  Contracting the Weitzenbock identity
sum_a lam_a ad(v_a)^2 = 2W against each eigenvector gives, with
R_{ab} = ||[v_a,v_b]||^2 = sum_g c'^2_{abg},

    R lam = -2 lam        (N equations),

of which the recorded tr(W^#) = -1 is the single lam-contraction, since
tr(W^#) = (1/2) lam^T R lam.  So the LP was missing N-1 equations.

THE PROGRAM.  Variables t_{abg} >= 0 for a<b<g (totally symmetric T, zero whenever two
indices coincide, since c' is antisymmetric).  For fixed lam on the unit sphere with
sum lam = 0:

    maximise   sum_a lam_a^3 + 3 sum_{a<b<g} t_{abg} lam_a lam_b lam_g
    subject to sum_{b<g} t_{abg} = n-2                        (row marginal)
               sum_g t_{abg} <= 2                             (pair cap)
               sum_b R_{ab} lam_b = -2 lam_a,  R_{ab} = sum_g t_{abg}   (NEW)

then maximise over lam.  Linear in t at fixed lam, so each inner solve is exact.

FALSIFIER.  The LP value with the new constraints still exceeding theta_0 leaves fence
post 15 standing; a value at or below theta_0 reopens the route the fence post closed.
"""
import numpy as np, itertools, sys
from scipy.optimize import linprog
sys.path.insert(0, 'scripts/lib')
from b0_psd_identity import rand_weyl, C_gens

np.set_printoptions(precision=6, suppress=True)


def theta_from_T(lam, tri, tvals):
    return float((lam**3).sum() + 3.0 * sum(v * lam[a]*lam[b]*lam[g]
                                            for (a, b, g), v in zip(tri, tvals)))


def gate1_theta_formula(m, rng):
    """check theta = sum lam^3 + 3 sum_{a<b<g} c'^2 lam_a lam_b lam_g on real Weyl tensors"""
    from review_r30_core import P as Pfun
    W = rand_weyl(m, rng); lam, V = np.linalg.eigh(W); C = C_gens(m)
    ad = np.tensordot(V.T, C, axes=([1], [0]))
    cp = np.einsum('aij,jb,ig->abg', ad, V, V)          # c'_{abg} = <[v_a,v_b],v_g>
    T = cp**2
    val = (lam**3).sum() + 0.5*np.einsum('abg,a,b,g->', T, lam, lam, lam)
    return val, Pfun(m, W)


def build_lp(n, lam, use_vector):
    N = n*(n-1)//2
    tri = list(itertools.combinations(range(N), 3))
    idx = {t: k for k, t in enumerate(tri)}
    nv = len(tri)
    c = np.array([-3.0*lam[a]*lam[b]*lam[g] for (a, b, g) in tri])   # maximise
    # row marginals
    Aeq, beq = [], []
    for a in range(N):
        r = np.zeros(nv)
        for t in tri:
            if a in t: r[idx[t]] = 1.0
        Aeq.append(r); beq.append(float(n-2))
    # pair caps
    Aub, bub = [], []
    for a, b in itertools.combinations(range(N), 2):
        r = np.zeros(nv)
        for t in tri:
            if a in t and b in t: r[idx[t]] = 1.0
        Aub.append(r); bub.append(2.0)
    if use_vector:
        # sum_b R_ab lam_b = -2 lam_a ,  R_ab = sum_g t_abg
        for a in range(N):
            r = np.zeros(nv)
            for t in tri:
                if a not in t: continue
                others = [x for x in t if x != a]
                r[idx[t]] += lam[others[0]] + lam[others[1]]
            Aeq.append(r); beq.append(-2.0*lam[a])
    res = linprog(c, A_ub=np.array(Aub), b_ub=np.array(bub),
                  A_eq=np.array(Aeq), b_eq=np.array(beq),
                  bounds=(0, None), method='highs')
    if not res.success: return None
    return -res.fun + float((lam**3).sum())


if __name__ == '__main__':
    rng = np.random.default_rng(2)
    print("=== Gate 1: the theta formula in the eigenframe ===")
    for m in (5, 6, 7):
        a, b = gate1_theta_formula(m, rng)
        print(f"  m={m}: formula {a:+.9f}   P(W) {b:+.9f}   diff {abs(a-b):.1e}")

    n = 6; N = n*(n-1)//2
    theta0 = np.sqrt(2*(n-1)*(n-2))/n
    print(f"\n=== LP at n={n}  (N={N}, {len(list(itertools.combinations(range(N),3)))} vars), "
          f"theta_0={theta0:.6f} ===")
    seeds = {}
    # padded W_CP^2 spectrum, and the balanced sphere product's, and random
    v = np.zeros(N); v[0] = 2; v[1] = -1; v[2] = -1; seeds['padded W_CP2'] = v/np.linalg.norm(v)
    W = rand_weyl(n, rng); seeds['random Weyl spectrum'] = np.linalg.eigvalsh(W)
    for name, lam in seeds.items():
        lam = lam - lam.mean(); lam = lam/np.linalg.norm(lam)
        old = build_lp(n, lam, False)
        new = build_lp(n, lam, True)
        o = f"{old:.6f}" if old is not None else "infeasible"
        nn = f"{new:.6f}" if new is not None else "INFEASIBLE"
        print(f"  {name:24s} marginals only: {o:>12}    + vector identity: {nn:>12}")


def outer_max(n, use_vector, starts=12, seed=0, iters=60):
    """maximise the inner LP over lam on {sum lam = 0, |lam| = 1}."""
    from scipy.optimize import minimize
    N = n*(n-1)//2
    rng = np.random.default_rng(seed)
    def norm(v):
        v = v - v.mean(); nv = np.linalg.norm(v)
        return v/nv if nv > 0 else v
    def neg(v):
        lam = norm(v)
        val = build_lp(n, lam, use_vector)
        return 1e3 if val is None else -val
    best = -np.inf; arg = None
    for s in range(starts):
        if s == 0:
            v = np.zeros(N); v[0] = 2; v[1] = -1; v[2] = -1
        elif s == 1:
            v = np.array([1.0]*(N//2) + [-1.0]*(N - N//2))
        else:
            v = rng.normal(size=N)
        r = minimize(neg, norm(v), method='Nelder-Mead',
                     options={'maxiter': iters*N, 'fatol': 1e-6, 'xatol': 1e-5})
        if -r.fun > best:
            best = -r.fun; arg = norm(r.x)
        print(f"    start {s:2d}: {-r.fun:.6f}", flush=True)
    return best, arg


# ---------------------------------------------------------------------------
# Fast path: the constraint matrices are fixed except for the lam-dependent rows,
# so they are built once as sparse matrices and reused across the outer search.
# Rebuilding them densely per solve is what made the n = 8 run time out.
# ---------------------------------------------------------------------------
import functools
from scipy import sparse


@functools.lru_cache(maxsize=None)
def _skeleton(n):
    N = n*(n-1)//2
    tri = np.array(list(itertools.combinations(range(N), 3)), dtype=np.int64)
    nv = len(tri)
    rows = np.repeat(np.arange(nv), 3)
    marg = sparse.csr_matrix((np.ones(3*nv), (tri.ravel(), rows)), shape=(N, nv))
    pair_id = {}
    pr, pc = [], []
    for k in range(3):
        for l in range(k+1, 3):
            a = np.minimum(tri[:, k], tri[:, l]); b = np.maximum(tri[:, k], tri[:, l])
            key = a*N + b
            for v in np.unique(key):
                pair_id.setdefault(int(v), len(pair_id))
            pr.append(np.array([pair_id[int(v)] for v in key])); pc.append(np.arange(nv))
    P = sparse.csr_matrix((np.ones(sum(len(x) for x in pr)),
                           (np.concatenate(pr), np.concatenate(pc))),
                          shape=(len(pair_id), nv))
    return N, tri, nv, marg, P


def build_lp_fast(n, lam, use_vector):
    N, tri, nv, marg, P = _skeleton(n)
    lt = lam[tri]                                   # (nv, 3)
    c = -3.0 * lt.prod(axis=1)
    Aeq = [marg]; beq = [np.full(N, float(n-2))]
    if use_vector:
        # row a of  sum_b R_ab lam_b = -2 lam_a :  coefficient of t_{abg} is lam_b + lam_g
        data, ri, ci = [], [], []
        for k in range(3):
            others = [j for j in range(3) if j != k]
            data.append(lt[:, others[0]] + lt[:, others[1]])
            ri.append(tri[:, k]); ci.append(np.arange(nv))
        V = sparse.csr_matrix((np.concatenate(data), (np.concatenate(ri), np.concatenate(ci))),
                              shape=(N, nv))
        Aeq.append(V); beq.append(-2.0*lam)
    res = linprog(c, A_ub=P, b_ub=np.full(P.shape[0], 2.0),
                  A_eq=sparse.vstack(Aeq), b_eq=np.concatenate(beq),
                  bounds=(0, None), method='highs')
    return None if not res.success else -res.fun + float((lam**3).sum())
