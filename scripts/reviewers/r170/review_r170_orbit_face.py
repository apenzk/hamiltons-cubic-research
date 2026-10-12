"""Reviewer 170 -- the SOS Gram spectrahedron at n = 5 is a proper face, and how proper.

RUN:  python3 scripts/review_r170_orbit_face.py        (~2 minutes)

F = (3/2)|W|^6 - <Q(W),W>^2 vanishes on the whole cone over O(5).W_CP2.  For an
invariant Gram G >= 0 with F(W) = v(W)^T G v(W), that forces G v(W) = 0 on the
orbit, so

    rank G  <=  dim Sym^3(Weyl_5) - dim span{ v(W) : W in O(5).W_CP2 }.

This measures that span, then converts the rank drop into a bound on how many of
the 65 block parameters survive, by exact integer search over the block table.

Also verified here: W_CP2 padded into n = 5 is an exact critical point at
theta = sqrt(3/2) with Lambda^2 spectrum (2,-1,-1,0^7)/sqrt6, and S^2 x S^3 is an
exact critical point at theta = 2*sqrt2/3 -- a point 300 gradient ascents never find.
"""
import itertools, sys, os
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(__file__)))
from review_r25_core import pairs, P, Q
from scipy.stats import special_ortho_group

rng = np.random.default_rng(2170)
n = 5
PR = pairs(n)
m = len(PR)

def proj_weyl(A, n):
    R = A - A.transpose(1, 0, 2, 3); R = R - R.transpose(0, 1, 3, 2)
    R = R + R.transpose(2, 3, 0, 1)
    R = R - (R + R.transpose(1, 2, 0, 3) + R.transpose(2, 0, 1, 3)) / 3
    g = np.eye(n); Ric = np.einsum('ikjk->ij', R); s = np.trace(Ric); E = Ric - s / n * g
    KN = lambda A, B: (np.einsum('ik,jl->ijkl', A, B) + np.einsum('jl,ik->ijkl', A, B)
                       - np.einsum('il,jk->ijkl', A, B) - np.einsum('jk,il->ijkl', A, B))
    return R - KN(E, g) / (n - 2) - s / (2 * n * (n - 1)) * KN(g, g)

def to_mat(W):
    M = np.zeros((m, m))
    for a, (i, j) in enumerate(PR):
        for b, (k, l) in enumerate(PR):
            M[a, b] = W[i, j, k, l]
    return M

# --- the padded CP^2 tensor, Fox's S^4(alpha) up to scale
J = np.zeros((n, n)); J[0, 1] = J[2, 3] = 1.0; J[1, 0] = J[3, 2] = -1.0
dl = np.eye(n); W0 = np.zeros((n, n, n, n))
for i, j, k, l in itertools.product(range(4), repeat=4):
    W0[i, j, k, l] = (dl[i, k] * dl[j, l] - dl[i, l] * dl[j, k]) \
        - ((J[i, k] * J[j, l] - J[i, l] * J[j, k]) + 2 * J[i, j] * J[k, l])
W0 = proj_weyl(W0, n)
M0 = to_mat(W0); M0 /= np.linalg.norm(M0)
print("W_CP2 at n=5: |theta| = %.15f   sqrt(3/2) = %.15f" % (abs(P(n, M0)), np.sqrt(1.5)))
print("   criticality residual = %.1e" % np.linalg.norm(Q(n, M0) - P(n, M0) * M0))
print("   Lambda^2 spectrum   =", np.round(np.sort(np.linalg.eigvalsh(M0)), 6))

# --- S^2 x S^3, Einstein-normalised: an exact critical point the ascent misses
p = 2; q = n - p
a, b, c = 1 / (p - 1) - 1 / (n - 1), 1 / (q - 1) - 1 / (n - 1), -1 / (n - 1)
lam = [a if (i < p and j < p) else (b if (i >= p and j >= p) else c) for (i, j) in PR]
MS = np.diag(lam); MS /= np.linalg.norm(MS)
print("S^2 x S^3 at n=5: theta = %.9f = 2*sqrt2/3, criticality residual = %.1e"
      % (P(n, MS), np.linalg.norm(Q(n, MS) - P(n, MS) * MS)))

# --- orthonormal basis of Weyl_5 in Lambda^2 coordinates
V = np.array([to_mat(proj_weyl(rng.standard_normal((n, n, n, n)), n)).ravel() for _ in range(200)])
Qb, Rb = np.linalg.qr(V.T)
r = int(np.sum(np.abs(np.diag(Rb)) > 1e-8)); B = Qb[:, :r]
print("dim Weyl_5 =", r)

mon = [(x, y, z) for x in range(35) for y in range(x, 35) for z in range(y, 35)]
ia = np.array([t[0] for t in mon]); ib = np.array([t[1] for t in mon]); ic = np.array([t[2] for t in mon])
NS = 5200
A = np.empty((NS, len(mon)))
for s in range(NS):
    g = special_ortho_group.rvs(n, random_state=rng.integers(1 << 30))
    Wt = np.einsum('ai,bj,ck,dl,ijkl->abcd', g, g, g, g, W0)
    x = B.T @ to_mat(Wt).ravel(); x /= np.linalg.norm(x)
    v = x[ia] * x[ib] * x[ic]; A[s] = v / np.linalg.norm(v)
ev = np.linalg.eigvalsh(A @ A.T)[::-1]
ranks = {tol: int((ev > ev[0] * tol).sum()) for tol in (1e-8, 1e-10, 1e-12)}
print("orbit-evaluation span, %d samples of %d monomials: rank %s"
      % (NS, len(mon), ranks))
D = ranks[1e-10]
print("   => rank G <= %d - %d = %d, i.e. %.1f%% of Sym^3 lies in ker G"
      % (len(mon), D, len(mon) - D, 100.0 * D / len(mon)))

# --- how many of the 65 block parameters can survive that rank drop
blocks = [(1,810),(1,770),(1,625),(1,455),(1,455),(1,429),(2,390),(1,260),(2,231),(4,220),
          (2,165),(2,154),(1,140),(3,105),(1,91),(1,84),(2,81),(2,55),(4,35),(2,35),(2,30),
          (2,14),(1,5),(1,1)]
assert sum(mm * dd for mm, dd in blocks) == 7770
assert sum(mm * (mm + 1) // 2 for mm, dd in blocks) == 65
def extreme(best):
    cur = {0: 0}
    for mm, dd in blocks:
        nxt = {}
        rs = [1] if (mm, dd) == (1, 1) else range(mm + 1)   # trivial block: tr(W^3) != 0 at W_CP2
        for s0, v0 in cur.items():
            for rr in rs:
                s1 = s0 + rr * dd
                if s1 > D: continue
                v1 = v0 + (mm - rr) * (mm - rr + 1) // 2
                if s1 not in nxt or (v1 > nxt[s1]) == best: nxt[s1] = v1
        cur = nxt
    return cur[D]
print("   surviving free parameters: between %d and %d, against 14 constraints"
      % (extreme(False), extreme(True)))
