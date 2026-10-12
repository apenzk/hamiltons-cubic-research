"""
Family B's non-simple isotropy class: (su(m), s(u(j)+u(m-j))) -- the complex
Grassmannians -- built explicitly, the same way the unitary class of family A
was in review_r11_unitary_pairs.py.

These are the next natural defective candidates: the isotropy contains a u(1),
so it carries an invariant 4-form, exactly as u(m) does inside so(2m).  The
two-eigenvalue screen could not reach them (k has three ideals: su(j), su(m-j)
and the central u(1)), so they have never been given a value.

Construction: su(m) sits in so(2m) via C^m = R^{2m}.  Under
k = s(u(j) + u(m-j)) the algebra splits into four invariant summands --
su(j), su(m-j), the central line, and m = the off-diagonal blocks -- so
    W = a1 Pi_su(j) + a2 Pi_su(m-j) + a3 Pi_centre - b Pi_m .
Criticality is solved on that 4-parameter family together with trace-freeness,
which is what enforces Ricci-flatness (h = su(m) acts irreducibly on R^{2m}, so
Ric(W) is a multiple of the identity -- the lesson from the unitary run, where
dropping it produced non-Weyl solutions with |Ric| of order 1).

Every solution is checked for Ricci-flatness and for genuine criticality before
being reported, and Fox is recovered as the case m = 2, j = 1.
"""
import numpy as np
from scipy.optimize import fsolve

from weyl import build_structure_constants
from rsharp_basis_free import Q_full
from curvature_operator import Lambda2
from weyl_decomposition import ricci_from_mop
from run_bianchi_defect import build_alt_indices
from run_bianchi_defect_highp_seed import delta2_and_grad

SQ32 = np.sqrt(1.5)


def su_m_summands(L2, m, j):
    """Projections onto su(j), su(m-j), the centre of k, and m, inside Lambda^2 R^{2m}."""
    n = 2 * m

    def emb(Z):
        """anti-Hermitian m x m complex Z -> real 2m x 2m in so(2m)."""
        A = np.zeros((n, n))
        X, Y = Z.real, Z.imag
        for a in range(m):
            for b in range(m):
                A[2 * a, 2 * b] = X[a, b]
                A[2 * a + 1, 2 * b + 1] = X[a, b]
                A[2 * a, 2 * b + 1] = -Y[a, b]
                A[2 * a + 1, 2 * b] = Y[a, b]
        return A

    blocks = {"su_j": [], "su_mj": [], "centre": [], "m": []}
    idx1, idx2 = list(range(j)), list(range(j, m))

    def tag(a, b):
        if a in idx1 and b in idx1:
            return "su_j"
        if a in idx2 and b in idx2:
            return "su_mj"
        return "m"

    for a in range(m):                      # off-diagonal generators
        for b in range(a + 1, m):
            for Z in (np.zeros((m, m), complex), np.zeros((m, m), complex)):
                pass
            Z1 = np.zeros((m, m), complex); Z1[a, b], Z1[b, a] = 1, -1
            Z2 = np.zeros((m, m), complex); Z2[a, b], Z2[b, a] = 1j, 1j
            blocks[tag(a, b)] += [emb(Z1), emb(Z2)]
    # diagonal (Cartan) directions, split correctly: traceless imaginary
    # diagonals supported inside the first block, inside the second block, and
    # the single central direction diag((m-j) I_j, -j I_{m-j}) * i.
    # (A first version assigned consecutive differences by index, which does not
    # decompose s(u(j)+u(m-j)) into its ideals and made the solver miss solutions.)
    for a in range(j - 1):
        Z = np.zeros((m, m), complex)
        Z[a, a], Z[a + 1, a + 1] = 1j, -1j
        blocks["su_j"].append(emb(Z))
    for a in range(j, m - 1):
        Z = np.zeros((m, m), complex)
        Z[a, a], Z[a + 1, a + 1] = 1j, -1j
        blocks["su_mj"].append(emb(Z))
    Z = np.zeros((m, m), complex)
    for a in range(j):
        Z[a, a] = 1j * (m - j)
    for a in range(j, m):
        Z[a, a] = -1j * j
    blocks["centre"].append(emb(Z))
    out = {}
    for key, mats in blocks.items():
        if not mats:
            out[key] = np.zeros((L2.N, L2.N))
            continue
        V = np.array([L2.matrix_to_vec(A) for A in mats]).T
        Qm, _ = np.linalg.qr(V)
        Qm = Qm[:, np.linalg.norm(Qm, axis=0) > 1e-9]
        out[key] = Qm @ Qm.T
    return out


def solve(L2, c, m, j, alt_idx):
    P = su_m_summands(L2, m, j)
    keys = [k for k in ("su_j", "su_mj", "centre") if np.trace(P[k]) > 0.5]
    Pm = P["m"]
    if np.trace(Pm) < 0.5:
        return None

    def build(z):
        W = -z[-1] * Pm
        for k, coef in zip(keys, z[:-1]):
            W = W + coef * P[k]
        return W

    def resid(z):
        W = build(z)
        nr = np.linalg.norm(W)
        if nr < 1e-12:
            return [1e3] * (len(keys) + 1)
        W = W / nr
        R = Q_full(W, c) - float(np.sum(W * Q_full(W, c))) * W
        out = [float(np.sum(R * P[k])) for k in keys[:-1]] + [float(np.sum(R * Pm))]
        return out + [float(np.trace(W))]

    best, rng = None, np.random.default_rng(1)
    for _ in range(300):
        z0 = np.abs(rng.normal(size=len(keys) + 1)) + 0.2
        try:
            z, _, ier, _ = fsolve(resid, z0, full_output=True)
        except Exception:
            continue
        if ier != 1 or max(abs(np.array(resid(z)))) > 1e-9:
            continue
        W = build(z)
        if np.linalg.norm(W) < 1e-9:
            continue
        W = W / np.linalg.norm(W)
        QW = Q_full(W, c)
        th = float(np.sum(W * QW))
        if th < 0:
            W, th = -W, -th
            QW = Q_full(W, c)
        ric = np.max(np.abs(ricci_from_mop(L2, W)))
        res = np.linalg.norm(QW - th * W) / max(np.linalg.norm(QW), 1e-300)
        if ric > 1e-7 or res > 1e-7 or th < 1e-9:
            continue
        d2 = delta2_and_grad(W, alt_idx)[0]
        if best is None or th > best[0]:
            best = (th, d2, res, ric)
    return best


print(f"{'n':>4} {'m':>3} {'j':>3} {'theta':>13} {'delta^2':>12} "
      f"{'resid':>9} {'maxRic':>9}   vs sqrt(3/2)")
print("-" * 80)
for m in (2, 3, 4, 5, 6):
    n = 2 * m
    idx, pos, N, c = build_structure_constants(n)
    L2 = Lambda2(n)
    alt_idx = build_alt_indices(L2)
    for j in range(1, m // 2 + 1):
        r = solve(L2, c, m, j, alt_idx)
        if r is None:
            print(f"{n:>4} {m:>3} {j:>3}   no Ricci-flat critical point of this shape")
            continue
        th, d2, res, ric = r
        note = "  <-- ABOVE" if th > SQ32 else ""
        tagged = "   (= Fox)" if (m == 2 and j == 1) else ""
        print(f"{n:>4} {m:>3} {j:>3} {th:>13.9f} {d2:>12.9f} {res:>9.1e} {ric:>9.1e}"
              f"   {'above' if th > SQ32 else 'below'}{tagged}")
print("-" * 80)
print(f"sqrt(3/2) = {SQ32:.9f}")
