"""Reviewer 35 / M3, M6, M7: joint Casimir blocks, weights, isomorphism tests,
and whether L_e is really scalar on each block."""
import numpy as np, sys, time, itertools
sys.path.insert(0, 'scripts/lib')
from review_r35_core import *
np.random.seed(35)

def setup(p, q):
    n = p + q
    B = weyl_basis(n); D = len(B)
    Pn, idx = pairs_of(n)
    Pplanes = [(i, j) for (i, j) in Pn if j < p]
    Qplanes = [(i, j) for (i, j) in Pn if i >= p]
    GP = gen_matrices(n, B, Pplanes)
    GQ = gen_matrices(n, B, Qplanes)
    CP = -sum(G @ G for G in GP) if GP else np.zeros((D, D))
    CQ = -sum(G @ G for G in GQ) if GQ else np.zeros((D, D))
    Wn, th, _ = unit_and_theta(n, W_sphere_product(p, q)); e = Wn/th
    L = Le_matrix(n, e, B)
    return dict(n=n, p=p, q=q, B=B, D=D, GP=GP, GQ=GQ, CP=CP, CQ=CQ, L=L, e=e,
                Pplanes=Pplanes, Qplanes=Qplanes)

def joint_blocks(S, tol=1e-7):
    CP, CQ, D = S['CP'], S['CQ'], S['D']
    M = CP + np.sqrt(2.0)*CQ; M = 0.5*(M+M.T)
    w, U = np.linalg.eigh(M)
    blocks = []
    i = 0
    while i < D:
        j = i
        while j+1 < D and abs(w[j+1]-w[i]) < tol*max(1, abs(w[i])) + 1e-8:
            j += 1
        V = U[:, i:j+1]
        cp = float(np.trace(V.T @ CP @ V)/V.shape[1])
        cq = float(np.trace(V.T @ CQ @ V)/V.shape[1])
        blocks.append(dict(cp=round(cp, 6), cq=round(cq, 6), dim=V.shape[1], V=V))
        i = j+1
    return blocks

def weights(S, V):
    """Multiset of joint Cartan weights on the subspace spanned by V (D x d)."""
    p, q, n = S['p'], S['q'], S['n']
    Pn, idx = pairs_of(n)
    cart = [(2*t, 2*t+1) for t in range(p//2)] + [(p+2*t, p+2*t+1) for t in range(q//2)]
    B = S['B']
    Hs = gen_matrices(n, B, cart)
    Hs = [V.T @ H @ V for H in Hs]
    r = len(Hs)
    if r == 0: return tuple()
    coef = np.random.randn(r)
    Hmix = sum(c*H for c, H in zip(coef, Hs))
    # commuting real antisymmetric matrices -> diagonalise i*Hmix (Hermitian)
    ev, U = np.linalg.eigh(1j*Hmix)
    out = []
    for k in range(U.shape[1]):
        u = U[:, k]
        w = tuple(round(float(np.real(np.conj(u) @ (1j*H) @ u)), 6) for H in Hs)
        out.append(w)
    return tuple(sorted(out))

def report(p, q, show_weights=True):
    t0 = time.time()
    S = setup(p, q)
    Wd = lambda m: m*(m+1)*(m+2)*(m-3)//12
    s  = lambda m: (m+2)*(m-1)//2
    c  = lambda m: m*(m-1)//2
    X  = lambda m: m*(m*m-4)//3
    pred = [("<W>",1),("Weyl_p",Wd(p)),("Weyl_q",Wd(q)),("R^p(x)R^q",p*q),
            ("S0_p",s(p)),("S0_q",s(q)),("S0(x)S0",s(p)*s(q)),
            ("L2(x)L2",c(p)*c(q)),("X_p(x)R^q",X(p)*q),("X_q(x)R^p",X(q)*p)]
    pred = [x for x in pred if x[1] > 0]
    bl = joint_blocks(S)
    print(f"\n=== (p,q)=({p},{q}) n={S['n']} D={S['D']} ===")
    print(f"  predicted summands ({len(pred)}): {pred}")
    print(f"  joint Casimir blocks: {len(bl)}   dims {sorted(b['dim'] for b in bl)}")
    print(f"  predicted dims sorted: {sorted(x[1] for x in pred)}")
    ok_dims = sorted(b['dim'] for b in bl) == sorted(x[1] for x in pred)
    print(f"  dim multiset match: {ok_dims}")
    rows = []
    for b in bl:
        V = b['V']
        Lb = V.T @ S['L'] @ V
        lam = np.trace(Lb)/b['dim']
        scalar_dev = np.abs(Lb - lam*np.eye(b['dim'])).max()
        w = weights(S, V) if show_weights else None
        b['lam'] = lam; b['scalar_dev'] = scalar_dev; b['w'] = w
        rows.append(b)
    print(f"  {'dim':>6} {'C_P':>10} {'C_Q':>10} {'L_e eig':>12} {'|L_e-lam I|':>12}")
    for b in sorted(rows, key=lambda z: -z['dim']):
        print(f"  {b['dim']:6d} {b['cp']:10.4f} {b['cq']:10.4f} {b['lam']:+12.8f} {b['scalar_dev']:12.2e}")
    print(f"  MAX |L_e - lam I| over blocks = {max(b['scalar_dev'] for b in rows):.2e}"
          f"   -> L_e scalar on every joint-Casimir block: "
          f"{max(b['scalar_dev'] for b in rows) < 1e-8}")
    if show_weights:
        # isomorphism classes by weight multiset
        seen = {}
        for b in rows:
            seen.setdefault(b['w'], []).append(b['dim'])
        dup = {k: v for k, v in seen.items() if len(v) > 1}
        print(f"  distinct weight multisets: {len(seen)} of {len(rows)} blocks"
              + (f"   ISOMORPHIC BLOCK PAIRS: {list(dup.values())}" if dup else "   (all pairwise non-isomorphic)"))
    print(f"  [{time.time()-t0:.1f}s]", flush=True)
    return S, rows

if __name__ == "__main__":
    for (p, q) in eval(sys.argv[1]):
        report(p, q)
