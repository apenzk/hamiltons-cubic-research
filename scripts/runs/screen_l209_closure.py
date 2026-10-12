"""Screen for L209: Ric(Q(R))_{ab} = sum_{c,d} R_{ac,bd} Ric(R)_{cd} on the Bianchi subspace.

Uses the record's own structure constants and Q_full (rsharp_basis_free), so the check
is in the record's normalisation. A random symmetric R is projected onto the first-Bianchi
subspace; Ric(R) != 0 there generically. A non-Bianchi control shows the identity FAILS
without Bianchi and the defect matches ATTEMPTS.md:872, (3/2) sum Alt(R)_{iklm} Alt(R)_{jklm}.
"""
import os, sys, itertools
import numpy as np
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "lib"))
from weyl import build_structure_constants, R_val, bianchi_constraint_matrix, vec_to_mat, mat_to_vec
from rsharp_basis_free import Q_full

rng = np.random.default_rng(20260913)

def ric(Rmat, pos, n):
    return np.array([[sum(R_val(Rmat, pos, n, a, c, b, c) for c in range(n))
                      for b in range(n)] for a in range(n)])

def rhs(Rmat, Ric, pos, n):
    return np.array([[sum(R_val(Rmat, pos, n, a, c, b, d) * Ric[c, d]
                          for c in range(n) for d in range(n))
                      for b in range(n)] for a in range(n)])

def alt(Rmat, pos, n):
    # totally antisymmetrised part of R_{ijkl}, one number per (i,j,k,l)
    A = np.zeros((n, n, n, n))
    for i, j, k, l in itertools.product(range(n), repeat=4):
        s = 0.0
        for perm in itertools.permutations(range(4)):
            sgn = np.linalg.det(np.eye(4)[list(perm)])
            idx4 = [(i, j, k, l)[p] for p in perm]
            s += sgn * R_val(Rmat, pos, n, *idx4)
        A[i, j, k, l] = s / 24.0
    return A

for n in (4, 5, 6):
    idx, pos, N, c = build_structure_constants(n)
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    # null space of the Bianchi constraint = S^2_B
    _, sv, Vt = np.linalg.svd(Bmat)
    rank = int((sv > 1e-10).sum())
    null = Vt[rank:].T                      # M x (M-rank)
    v = null @ rng.standard_normal(null.shape[1])
    R = vec_to_mat(v, triu_idx, N)
    Ric = ric(R, pos, n)
    Q = Q_full(R, c)
    lhs = ric(Q, pos, n)
    r = rhs(R, Ric, pos, n)
    print(f"n={n}: dim S^2_B={null.shape[1]}, |Ric|={np.linalg.norm(Ric):.3f}, "
          f"|Ric(Q)|={np.linalg.norm(lhs):.3f}, residual={np.abs(lhs - r).max():.2e}")
    # identity anchor
    I = np.eye(N)
    lhsI = ric(Q_full(I, c), pos, n); rI = rhs(I, ric(I, pos, n), pos, n)
    print(f"       anchor Id: Ric(Q(Id))=(n-1)^2 Id residual {np.abs(lhsI-(n-1)**2*np.eye(n)).max():.1e}, "
          f"RHS residual {np.abs(rI-(n-1)**2*np.eye(n)).max():.1e}")
    # control: NOT projected onto Bianchi
    v2 = rng.standard_normal(len(triu_idx))
    R2 = vec_to_mat(v2, triu_idx, N)
    Ric2 = ric(R2, pos, n)
    d = ric(Q_full(R2, c), pos, n) - rhs(R2, Ric2, pos, n)
    if n <= 5:
        A = alt(R2, pos, n)
        pred = 1.5 * np.einsum('iklm,jklm->ij', A, A)
        print(f"       control (no Bianchi): defect {np.abs(d).max():.3f}, "
              f"vs 3/2 sum Alt Alt residual {np.abs(d - pred).max():.2e}")
    else:
        print(f"       control (no Bianchi): defect {np.abs(d).max():.3f} (nonzero)")

# Step 2 check: four-index form (R#)_{ij,kl} = B_{ijkl} - B_{ijlk}, B_{ijkl} = sum_{pq} R_{ip,kq} R_{jp,lq},
# against the record's Rsharp_full at RANDOM symmetric R (Bianchi not needed for this step).
from rsharp_basis_free import Rsharp_full
for n in (4, 5):
    idx, pos, N, c = build_structure_constants(n)
    A = rng.standard_normal((N, N)); R = A + A.T
    S = Rsharp_full(R, c)
    def B(i, j, k, l):
        return sum(R_val(R, pos, n, i, p, k, q) * R_val(R, pos, n, j, p, l, q)
                   for p in range(n) for q in range(n))
    worst = 0.0
    for (i, j) in idx:
        for (k, l) in idx:
            worst = max(worst, abs(R_val(S, pos, n, i, j, k, l) - (B(i, j, k, l) - B(i, j, l, k))))
    # and (R^2)_{ij,kl} = B_{ikjl} - B_{iljk} needs Bianchi: project first
    Bmat, triu_idx, tpos = bianchi_constraint_matrix(idx, pos, n, N)
    _, sv, Vt = np.linalg.svd(Bmat); rank = int((sv > 1e-10).sum()); null = Vt[rank:].T
    RB = vec_to_mat(null @ rng.standard_normal(null.shape[1]), triu_idx, N)
    R2 = RB @ RB
    def BB(i, j, k, l):
        return sum(R_val(RB, pos, n, i, p, k, q) * R_val(RB, pos, n, j, p, l, q)
                   for p in range(n) for q in range(n))
    worst2 = max(abs(R_val(R2, pos, n, i, j, k, l) - (BB(i, k, j, l) - BB(i, l, j, k)))
                 for (i, j) in idx for (k, l) in idx)
    print(f"n={n}: R# four-index form vs Rsharp_full residual {worst:.2e}; "
          f"R^2 = B_ikjl - B_iljk on S^2_B residual {worst2:.2e}")
