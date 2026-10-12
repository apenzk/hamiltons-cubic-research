"""Reviewer 110, independent implementation. Fence post 25 audit.

Everything built from the brief's definitions; no repo code reused.
"""
import numpy as np
import itertools

rng = np.random.default_rng(110)


# ---------------------------------------------------------------- Weyl tensors
def kn(A, B, n):
    """Kulkarni-Nomizu product."""
    out = np.zeros((n, n, n, n))
    for i, j, k, l in itertools.product(range(n), repeat=4):
        out[i, j, k, l] = (A[i, k] * B[j, l] + A[j, l] * B[i, k]
                           - A[i, l] * B[j, k] - A[j, k] * B[i, l])
    return out


def random_weyl(n):
    N = n * (n - 1) // 2
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    idx = {p: a for a, p in enumerate(pairs)}
    S = rng.standard_normal((N, N))
    S = 0.5 * (S + S.T)
    R = np.zeros((n, n, n, n))
    for a, (i, j) in enumerate(pairs):
        for b, (k, l) in enumerate(pairs):
            v = S[a, b]
            for si, (p, q) in ((1, (i, j)), (-1, (j, i))):
                for sj, (r, s) in ((1, (k, l)), (-1, (l, k))):
                    R[p, q, r, s] = si * sj * v
    # first Bianchi: subtract the totally antisymmetric (Lambda^4) part
    B = (R + np.transpose(R, (0, 2, 3, 1)) + np.transpose(R, (0, 3, 1, 2))) / 3.0
    R = R - B
    # trace-free part
    g = np.eye(n)
    Ric = np.einsum('ijil->jl', R)
    scal = np.trace(Ric)
    Ric0 = Ric - scal / n * g
    W = R - kn(Ric0, g, n) / (n - 2) - scal / (2 * n * (n - 1)) * kn(g, g, n)
    return W


def checks_weyl(W, n):
    e = []
    e.append(np.abs(W + np.transpose(W, (1, 0, 2, 3))).max())
    e.append(np.abs(W - np.transpose(W, (2, 3, 0, 1))).max())
    e.append(np.abs(W + np.transpose(W, (0, 1, 3, 2))).max())
    e.append(np.abs(W + np.transpose(W, (0, 2, 3, 1)) + np.transpose(W, (0, 3, 1, 2))).max())
    e.append(np.abs(np.einsum('ijil->jl', W)).max())
    return max(e)


# ------------------------------------------------------- Lambda^2 = so(n) data
def build(W, n):
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    N = len(pairs)
    M = np.array([[W[i, j, k, l] for (k, l) in pairs] for (i, j) in pairs])
    M = M / np.linalg.norm(M)                       # ||M||_F = 1
    lam, V = np.linalg.eigh(M)
    # phi_ij = E_ij - E_ji  (unnormalised); <A,B> := (1/2) tr(A^T B) makes them
    # an orthonormal basis, so eigenvectors map to an orthonormal frame of so(n)
    phi = np.zeros((N, n, n))
    for a, (i, j) in enumerate(pairs):
        phi[a, i, j] = 1.0
        phi[a, j, i] = -1.0
    A = np.einsum('av,aij->vij', V, phi)            # A[alpha] = sum_a V[a,alpha] phi_a
    return pairs, M, lam, V, phi, A


def ip(X, Y):
    return 0.5 * np.einsum('...ij,...ij->...', X, Y)


def struct_T(A):
    """T[g,a,b] = <[v_a,v_b],v_g>^2 with <,> = (1/2)tr(A^T B)."""
    comm = np.einsum('aik,bkj->abij', A, A) - np.einsum('bik,akj->abij', A, A)
    C = 0.5 * np.einsum('abij,gij->gab', comm, A)
    return C, C ** 2


def ad_matrix(X, phi):
    """matrix of ad(X) on so(n) in the orthonormal frame {phi_a}."""
    br = X @ phi - phi @ X                          # [X, phi_a]
    return 0.5 * np.einsum('aij,bij->ba', br, phi)  # column a = coords of [X,phi_a]


def g_direct(A, phi, M, V):
    """g_gamma = || [ad(v_gamma), W] ||^2, W acting on Lambda^2."""
    out = []
    for gam in range(len(A)):
        ad = ad_matrix(A[gam], phi)
        # ad is in the phi-frame; M is also in the phi-frame (pairs basis)
        cm = ad @ M - M @ ad
        out.append(np.linalg.norm(cm) ** 2)
    return np.array(out)


def sharp_inner(lam, T):
    """<W^#, W> = (1/2) sum lam_g lam_a lam_b T_{gab}  (Hamilton's sharp,
    R^#_{pq} = (1/2) sum C_{cdp} C_{abq} R_{ca} R_{db})."""
    return 0.5 * np.einsum('g,a,b,gab->', lam, lam, lam, T)


def report(n, trials=3):
    print(f"===== n = {n} =====")
    for t in range(trials):
        W = random_weyl(n)
        sym = checks_weyl(W, n)
        pairs, M, lam, V, phi, A = build(W, n)
        C, T = struct_T(A)
        R = T.sum(axis=2)
        gd = g_direct(A, phi, M, V)
        gpw = np.einsum('a,b,gab->g', np.ones_like(lam), np.ones_like(lam), T) * 0  # placeholder
        gpw = np.einsum('gab->g', (lam[None, :, None] - lam[None, None, :]) ** 2 * T)
        p3 = float(np.einsum('a,a,a->', lam, lam, lam))
        sw = sharp_inner(lam, T)
        theta = p3 + sw
        rows = {}
        rows['weyl symmetry residual'] = sym
        rows['Prop 1.7  vs direct g'] = np.abs(gpw - gd).max()
        rows['sum g - 4(n-1)'] = abs(gd.sum() - 4 * (n - 1))
        rows['sum lam*g + 4 theta'] = abs(float(lam @ gd) + 4 * theta)
        rows['per-row  max|sum_b lam_b R_ab + 2 lam_a|'] = np.abs(R @ lam + 2 * lam).max()
        rows['R symmetric'] = np.abs(R - R.T).max()
        rows['T total symmetry'] = max(np.abs(T - np.transpose(T, (1, 0, 2))).max(),
                                       np.abs(T - np.transpose(T, (0, 2, 1))).max())
        rows['rho_a - 2(n-2)'] = np.abs(T.sum(axis=(1, 2)) - 2 * (n - 2)).max()
        rows['tr M^3 - p3'] = abs(np.trace(M @ M @ M) - p3)
        # the claimed two-term expansion
        term1 = float(np.einsum('g,a,ga->', lam, lam ** 2, R))
        term2 = float(np.einsum('g,a,b,gab->', lam, lam, lam, T))
        rows['expansion: sum lam g - (2 t1 - 2 t2)'] = abs(float(lam @ gpw) - (2 * term1 - 2 * term2))
        rows['t1 + 2 p3'] = abs(term1 + 2 * p3)
        rows['t2 - 2<W#,W>'] = abs(term2 - 2 * sw)
        rows['sum lam^2 - 1'] = abs(float(lam @ lam) - 1)
        print(f" trial {t}: theta={theta: .6f}  p3={p3: .6f}  <W#,W>={sw: .6f} "
              f" lam_min={lam.min(): .4f}")
        for k, v in rows.items():
            print(f"    {k:42s} {v:.3e}")
    print()


if __name__ == '__main__':
    for n in (5, 6, 7):
        report(n, trials=2)


# =====================================================================
#  CONSEQUENCE TEST.  Does information about g beyond {g>=0, sum g=4(n-1)}
#  strictly sharpen the recorded bound?
# =====================================================================
def graded_sphere_product(k):
    """W = a*Pi_k + b*Pi_m for (so(2k), so(k)+so(k)); diagonal in the phi frame."""
    n = 2 * k
    pairs = [(i, j) for i in range(n) for j in range(i + 1, n)]
    p = k * (k - 1)          # dim so(k)+so(k)
    q = k * k                # dim m
    a = np.sqrt(q / (p * (p + q)))
    b = -a * p / q
    lam = np.array([a if (i < k) == (j < k) else b for (i, j) in pairs])
    M = np.diag(lam)
    W = np.zeros((n, n, n, n))
    for a_, (i, j) in enumerate(pairs):
        v = lam[a_]
        W[i, j, i, j] = v; W[j, i, j, i] = v
        W[i, j, j, i] = -v; W[j, i, i, j] = -v
    return W, n


def capped_lp(lam, total, cap, mask):
    """max -1/4 sum lam_g x_g  over  x>=0, x<=cap, sum_{mask} x = total, x=0 off mask."""
    idx = np.where(mask)[0]
    order = idx[np.argsort(lam[idx])]
    rem, val = total, 0.0
    for g in order:
        take = min(cap, rem)
        val += -0.25 * lam[g] * take
        rem -= take
        if rem <= 1e-12:
            break
    if rem > 1e-9:
        return np.nan          # infeasible under the cap
    return val


def consequence(n, trials=3, structured=None):
    print(f"--- consequence tests, n = {n} ---")
    cases = []
    for t in range(trials):
        cases.append(('random', random_weyl(n)))
    if structured is not None:
        cases.append(structured)
    for name, W in cases:
        pairs, M, lam, V, phi, A = build(W, n)
        C, T = struct_T(A)
        R = T.sum(axis=2)
        gd = g_direct(A, phi, M, V)
        p3 = float(np.einsum('a,a,a->', lam, lam, lam))
        theta = p3 + sharp_inner(lam, T)
        tol = 1e-9
        P = lam > tol
        Z = np.abs(lam) <= tol
        Mm = lam < -tol
        Delta = gd[P].sum()
        G0 = gd[Z].sum()
        lmin = lam.min()
        lp_min = lam[P].min() if P.any() else 0.0
        tot = 4 * (n - 1)
        mass_m = tot - Delta - G0
        B_apriori = abs(lmin) * tot / 4
        B_rec = abs(lmin) * mass_m / 4
        B_sharp = (abs(lmin) * mass_m - lp_min * Delta) / 4   # target.md:288 form
        K = 2 * (n - 2) * (lam.max() - lam.min()) ** 2        # Prop 1.7 + rho = 2(n-2)
        cap_valid = gd.max() <= K + 1e-9
        B_cap_apriori = capped_lp(lam, tot, K, np.ones_like(lam, dtype=bool))
        B_cap_rec = capped_lp(lam, mass_m, K, Mm)
        print(f"  [{name}] theta={theta: .6f}  lam_min={lmin: .4f}  Delta={Delta:8.4f} "
              f" G0={G0:7.4f}  K={K:7.3f}  cap valid={cap_valid}")
        print(f"      B_apriori   |lmin|(n-1)                 = {B_apriori: .6f}")
        print(f"      B_capped a priori (cap only)            = {B_cap_apriori: .6f}")
        print(f"      B_rec       |lmin|(4(n-1)-D-G0)/4       = {B_rec: .6f}")
        print(f"      B_rec + cap (same inputs + Prop1.7 cap) = {B_cap_rec: .6f}")
        print(f"      B_sharp (target.md:288, keeps lp_min*D) = {B_sharp: .6f}")
        ok = (theta <= min(B_apriori, B_cap_apriori, B_rec, B_cap_rec, B_sharp) + 1e-9)
        print(f"      all bounds >= theta: {ok}"
              f"   | cap sharpens B_rec by {B_rec - B_cap_rec: .6f}")


if __name__ == '__main__':
    pass


def weight_family(n, trials=2):
    """The collapse is weight-specific: weight 1 gives a USED constraint,
    weight lambda gives the tautology, weight lambda^2 gives neither."""
    print(f"--- weight family, n = {n} ---")
    for t in range(trials):
        W = random_weyl(n)
        pairs, M, lam, V, phi, A = build(W, n)
        C, T = struct_T(A)
        R = T.sum(axis=2)
        gd = g_direct(A, phi, M, V)
        p3 = float(np.einsum('a,a,a->', lam, lam, lam))
        sw = sharp_inner(lam, T)
        theta = p3 + sw
        rho = T.sum(axis=(1, 2))
        m0, m1, m2 = gd.sum(), lam @ gd, (lam ** 2) @ gd
        # weight-1 route: 2 sum_a lam_a^2 rho_a - 2 sum lam_a lam_b R_ab
        w1 = 2 * float((lam ** 2) @ rho) - 2 * float(np.einsum('a,b,ab->', lam, lam, R))
        # weight-lambda route: 2*(-2 p3) - 2*(2 sw)
        wl = 2 * (-2 * p3) - 2 * (2 * sw)
        # weight-lambda^2 route: no per-row collapse available
        t1 = float(np.einsum('g,a,ga->', lam ** 2, lam ** 2, R))
        t2 = float(np.einsum('g,a,b,gab->', lam ** 2, lam, lam, T))
        print(f"  trial {t}:  sum g          = {m0: .8f}   route {w1: .8f}   4(n-1)={4*(n-1)}")
        print(f"            sum lam g      = {m1: .8f}   route {wl: .8f}   -4 theta={-4*theta: .8f}")
        print(f"            sum lam^2 g    = {m2: .8f}   = 2*{t1:.6f} - 2*{t2:.6f}"
              f" = {2*t1-2*t2: .8f}")
        print(f"            trM^4={np.trace(np.linalg.matrix_power(M,4)): .6f}"
              f"  p3={p3: .6f}  theta={theta: .6f}   (m2 matches none)")
