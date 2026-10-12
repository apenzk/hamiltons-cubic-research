"""I73 (c), the open quintic entries of reviews/2026-09-23-I73c-summed-pairs.md section 5.

Regresses Phi(e;e^2,e^2) and Om(e;e^2,e^2) at random Weyl e against every degree-5 class-level
invariant (spectral, T-moments, the isotropy Gram through <Ric e^2, Ric e^3>), with and without the
second-kind contraction K = <Ric e^2, e-ring Ric e^2>, which is not class-level.  A screen: seconds per
object, deciding which invariants a derivation has to produce, never establishing the reduction.
"""
import sys, numpy as np
sys.path.insert(0, __file__.rsplit("/", 1)[0])
from screen_I73_pair_direction import pairs, structure_constants, weyl_projector
from screen_I113_defect_identity import to4
from screen_I73c_corrections import Phi, Om

rng = np.random.default_rng(int(sys.argv[1]) if len(sys.argv) > 1 else 20260923)

def ric(X4):
    return np.einsum('acbc->ab', X4)

def invariants(E, c, n):
    lam, V = np.linalg.eigh(E)
    cp = np.einsum('abc,ax,by,cz->xyz', c, V, V, V, optimize=True)
    T = cp ** 2
    def m(p, q, r):
        return np.einsum('xyz,x,y,z->', T, lam ** p, lam ** q, lam ** r)
    E2, E3 = E @ E, E @ E @ E
    e4 = to4(E, n)
    R2, R3 = ric(to4(E2, n)), ric(to4(E3, n))
    tr = lambda k: np.sum(lam ** k)
    R1_2 = np.sum(R2 * R2)
    d2 = {'tr2': tr(2), 'm110': m(1, 1, 0)}
    d3 = {'tr3': tr(3), 'm111': m(1, 1, 1), 'm210': m(2, 1, 0)}
    cand = {'tr5': tr(5), 'm311': m(3, 1, 1), 'm221': m(2, 2, 1), 'm320': m(3, 2, 0),
            'm410': m(4, 1, 0), 'RicRic23': np.sum(R2 * R3)}
    for a, va in d2.items():
        for b, vb in d3.items():
            cand[a + '*' + b] = va * vb
    ctrl = {'tr4': tr(4), 'tr2sq': tr(2) ** 2, 'm211': m(2, 1, 1), 'm220': m(2, 2, 0),
            'm310': m(3, 1, 0), 'RicRic22': R1_2, 'm110sq': m(1, 1, 0) ** 2, 'tr2m110': tr(2) * m(1, 1, 0)}
    K = np.einsum('ijkl,ik,jl->', e4, R2, R2)
    cand['_ctrl'] = ctrl
    return e4, cand, K

def fit(rows, y, names):
    A = np.array([[r[k] for k in names] for r in rows]); y = np.array(y)
    coef, *_ = np.linalg.lstsq(A, y, rcond=None)
    return coef, np.max(np.abs(A @ coef - y)) / np.max(np.abs(y))

for n in (6, 7):
    N = len(pairs(n)); c = structure_constants(n); Pi, _ = weyl_projector(n)
    rowsP, rowsO, yP, yO, rowsC = [], [], [], [], []
    for s in range(40):
        M = rng.normal(size=(N, N)); M = (M + M.T) / 2
        E = (Pi @ M.ravel()).reshape(N, N); E /= np.sqrt(np.trace(E @ E))
        e4, cand, K = invariants(E, c, n)
        E2_4 = to4(E @ E, n)
        yP.append(Phi(e4, E2_4, E2_4)); yO.append(Om(e4, E2_4, E2_4))
        ctrl = cand.pop('_ctrl'); ctrl['y'] = Phi(e4, e4, E2_4)
        row = dict(cand); row['K'] = K
        rowsP.append(row); rowsO.append(row); rowsC.append(ctrl)
    base = [k for k in rowsP[0] if k != 'K']
    cc, rc = fit(rowsC, [r['y'] for r in rowsC], [k for k in rowsC[0] if k != 'y'])
    print(f"n={n} CONTROL Phi(e;e,e2) against degree-4 class-level set: rel.resid {rc:.2e}")
    print("   ", " ".join(f"{k}={v:+.4f}" for k, v in zip([k for k in rowsC[0] if k != 'y'], cc)))
    yQ = [a / (8 * (n - 2)) + 0.375 * b for a, b in zip(yP, yO)]
    for label, rows, y in (('Phi', rowsP, yP), ('Om', rowsO, yO), ('Q = Phi/(8(n-2)) + 3/8 Om', rowsP, yQ)):
        cb, rb = fit(rows, y, base)
        ck, rk = fit(rows, y, base + ['K'])
        print(f"n={n} {label}(e;e2,e2): {len(base)} class-level candidates, rel.resid {rb:.2e} | with K {rk:.2e}")

# ---- the elimination: at three values the quintic moment enters pair (a,b) only through l_a l_b ----
from screen_I73_pair_blindness import padded_cp2
from screen_I73_pair_direction import sharp_mat
def lagrange(eps):
    L = []
    for a in range(3):
        b, c_ = [x for x in range(3) if x != a]
        la = 1.0 / ((eps[a] - eps[b]) * (eps[a] - eps[c_]))
        L.append(la * np.array([eps[b] * eps[c_], -(eps[b] + eps[c_]), 1.0]))
    return np.array(L)
def three_valued(n, E):
    lam, V = np.linalg.eigh(E); vals = np.unique(np.round(lam, 9))
    assert len(vals) == 3, vals
    P = [V[:, np.abs(lam - v) < 1e-6] @ V[:, np.abs(lam - v) < 1e-6].T for v in vals]
    return vals, P
for label, n, E in (('padded W_CP2', 8, None), ('random three-valued (not Weyl)', 6, 'rand')):
    N = len(pairs(n)); c = structure_constants(n)
    if E is None:
        W = padded_cp2(n); W /= np.sqrt(np.trace(W @ W))
        th = np.trace(W @ W @ W) + np.sum(W * sharp_mat(c, W, W)); E = W / th
    else:
        Q_, _ = np.linalg.qr(rng.normal(size=(N, N))); d = np.repeat([-0.7, 0.2, 1.1], [5, 6, 4])
        E = Q_ @ np.diag(d) @ Q_.T
    eps, P = three_valued(n, E); e4 = to4(E, n)
    pw = [np.eye(N), E, E @ E]
    for name, F in (('Phi', Phi), ('Om', Om)):
        M = np.array([[F(e4, to4(pw[i], n), to4(pw[j], n)) for j in range(3)] for i in range(3)])
        D = np.array([[F(e4, to4(P[a], n), to4(P[b], n)) for b in range(3)] for a in range(3)])
        L = lagrange(eps); rec = L @ M @ L.T
        p_, q_ = eps[1] - eps[0], eps[2] - eps[1]
        c1 = p_ * L[0, 2] * L[1, 2] + (p_ + q_) * L[0, 2] * L[2, 2]
        c2 = q_ * L[1, 2] * L[2, 2] + (p_ + q_) * L[0, 2] * L[2, 2]
        print(f"{label}, n={n}, {name}: |direct - Vandermonde| = {np.max(np.abs(D - rec)):.1e}; "
              f"M22 coefficient in p*X12+(p+q)*X13 = {c1:.1e}, in q*X23+(p+q)*X13 = {c2:.1e}; "
              f"control l1*l2 = {L[0,2]*L[1,2]:+.3f}")
