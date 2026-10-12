"""Gate 1 screen for Lemma L216, the isolation radius at a nondegenerate critical orbit.

Along a unit normal H at a sphere-product critical point W, phi(s) = P(cos s W + sin s H). The
lemma needs phi''(0) <= -6 theta gamma for every unit H orthogonal to W and to the orbit tangent,
|phi'''| <= 27 (1 + sqrt(n-2)), and concludes phi'(s) < 0 for 0 < s < r = 4 theta gamma / (9M).

Checked, at S^4xS^4 and S^6xS^6 and at the unbalanced S^3xS^5: criticality, that the 1/2-eigenspace
of L_e has the orbit dimension pq, that the gap equals the corollary's closed form, that the margin
is attained, the Bernstein slack, and that no sampled normal direction turns phi' nonnegative.
Screening only: the lemma is the derivation.
"""
import sys
import numpy as np
sys.path.insert(0, "scripts/lib")
from g1_le_machinery import weyl_basis, Le_matrix


def run(p, q, samples=300, seed=5):
    n = p + q
    _, c, _, _, B = weyl_basis(n)
    B = np.array(B)
    d = len(B)
    idx = [(i, j) for i in range(n) for j in range(i + 1, n)]
    lam = np.zeros(len(idx))
    for a, (i, j) in enumerate(idx):
        if i < p and j < p:
            lam[a] = 1 / (p * (p - 1))
        elif i >= p and j >= p:
            lam[a] = 1 / (q * (q - 1))
        else:
            lam[a] = -1 / (p * q)
    coef = np.array([np.sum(np.diag(lam) * b) for b in B])
    Wm = np.einsum('k,kab->ab', coef, B)
    Wm /= np.linalg.norm(Wm)

    def Qm(M):
        S = np.einsum('amn,np->amp', c, M, optimize=True)
        return M @ M - 0.5 * np.einsum('amp,bpm->ab', S, S, optimize=True)

    def P(v):
        X = np.einsum('k,kab->ab', v, B)
        return float(np.sum(X * Qm(X)))

    th = float(np.sum(Wm * Qm(Wm)))
    res = np.linalg.norm(Qm(Wm) - th * Wm)
    ev, U = np.linalg.eigh(Le_matrix(Wm / th, B, c))
    halves = int(np.sum(np.abs(ev - 0.5) < 1e-8))
    gap = 0.5 - max(x for x in ev if x < 0.5 - 1e-8)
    mu = (n - 2) / (2 * (p - 1) * (q - 1))
    pred = min(1 / (2 * (p - 1)), 1 / (2 * (q - 1)), 0.5 - mu)
    M = 1 + np.sqrt(n - 2)
    r = 4 * th * gap / (9 * M)
    w = np.array([np.sum(Wm * b) for b in B])
    half = U[:, np.abs(ev - 0.5) < 1e-8]
    Proj = np.eye(d) - np.outer(w, w) - half @ half.T
    rng = np.random.default_rng(seed)
    s = np.linspace(1e-4, 0.6, 1200)
    cands = [Proj @ U[:, k] for k in np.argsort(ev)[::-1][:60]]
    cands += [Proj @ rng.standard_normal(d) for _ in range(samples)]
    worst2, worst3, first, used = -np.inf, 0.0, np.inf, 0
    for h in cands:
        nh = np.linalg.norm(h)
        if nh < 1e-9:
            continue
        h = h / nh
        used += 1
        A, Dv = P(w), P(h)
        C = (P(w + h) + P(w - h) - 2 * A) / 6
        Bc = (P(w + h) - P(w - h) - 2 * Dv) / 6
        g = (A * np.cos(s) ** 3 + 3 * Bc * np.cos(s) ** 2 * np.sin(s)
             + 3 * C * np.cos(s) * np.sin(s) ** 2 + Dv * np.sin(s) ** 3)
        dg = np.gradient(g, s)
        pos = np.where(dg >= 0)[0]
        first = min(first, s[pos[0]] if len(pos) else np.inf)
        worst2 = max(worst2, 6 * C - 3 * A)
        worst3 = max(worst3, np.max(np.abs(np.gradient(np.gradient(dg, s), s)[5:-5])))
    print(f"S^{p}xS^{q}, n={n}: theta={th:.9f} residual={res:.1e} "
          f"half-eigs={halves} orbit pq={p*q}")
    print(f"   gap={gap:.6f}  closed form={pred:.6f}   r={r:.6f}")
    print(f"   sup phi''(0) over {used} normal H = {worst2:+.6f}  vs -6 theta gap = {-6*th*gap:+.6f}")
    print(f"   sup |phi'''| sampled = {worst3:.4f}  vs 27M = {27*M:.4f}")
    print(f"   earliest s with phi' >= 0: {first}  "
          f"({'CONSISTENT' if first > r else 'VIOLATED'})")


if __name__ == "__main__":
    run(4, 4)
    run(3, 5)
    run(6, 6)
