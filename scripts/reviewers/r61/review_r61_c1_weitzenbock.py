"""Reviewer 61 / C1 attribution: is A(W)=sum W_gh C_g C_h the classical
Weitzenbock term q(R) on 2-forms?  Tests, all from definitions:
 (1) on 1-forms  sum_gh W_gh phi_g phi_h = -Ric(W)   [fixes the sign convention]
 (2) on 2-forms  A(R) = 2R - (Ric.w + w.Ric)  for every Bianchi-satisfying R
 (3) the four Schur constants, on explicitly constructed summands.
"""
import numpy as np, itertools, math
from review_r61_core import (pairs, pair_index, ad_basis, skew_to_vec, comp,
                             weyl_basis, sym_basis)
from review_r61_c1 import A_of_gh, constrained_basis, ric_operator


def phi_mats(m):
    out = []
    for (i, j) in pairs(m):
        E = np.zeros((m, m)); E[i, j] = 1.0; E[j, i] = -1.0
        out.append(E)
    return out


def one_form_action(W, m):
    P = phi_mats(m)
    D = len(P)
    out = np.zeros((m, m))
    for g in range(D):
        for h in range(D):
            if W[g, h] != 0:
                out += W[g, h] * (P[g] @ P[h])
    return out


def ric_matrix(W, m):
    idx = pair_index(m)
    return np.array([[sum(comp(W, m, i, j, k, j, idx) for j in range(m))
                      for k in range(m)] for i in range(m)])


def kn_operator(h, m):
    """Curvature operator of the Kulkarni-Nomizu product h (o) g, in the phi basis:
    R_{ijkl} = h_ik d_jl - h_il d_jk - h_jk d_il + h_jl d_ik, halved to match
    <R phi_ij, phi_kl> = R_{ijkl}."""
    D = m * (m - 1) // 2
    idx = pair_index(m)
    d = np.eye(m)
    R = np.zeros((D, D))
    for a, (i, j) in enumerate(pairs(m)):
        for b, (k, l) in enumerate(pairs(m)):
            R[a, b] = 0.5 * (h[i, k]*d[j, l] - h[i, l]*d[j, k]
                             - h[j, k]*d[i, l] + h[j, l]*d[i, k])
    return R


def lambda4_operator(T, m):
    """symmetric operator on Lambda^2 whose components are a 4-form T."""
    D = m * (m - 1) // 2
    R = np.zeros((D, D))
    for a, (i, j) in enumerate(pairs(m)):
        for b, (k, l) in enumerate(pairs(m)):
            R[a, b] = T[i, j, k, l]
    return R


def rand_4form(m, rng):
    T = np.zeros((m, m, m, m))
    for c in itertools.combinations(range(m), 4):
        v = rng.normal()
        for p in itertools.permutations(c):
            sgn = np.linalg.det(np.eye(4)[list(np.argsort(p))])
            # parity of permutation p relative to sorted c
            perm = [c.index(x) for x in p]
            s = 1
            pp = list(perm)
            for i in range(4):
                for j in range(i+1, 4):
                    if pp[i] > pp[j]:
                        s = -s
            T[p] = s * v
    return T


if __name__ == '__main__':
    rng = np.random.default_rng(3)
    print("(1) 1-form action vs -Ric  (random symmetric W, no conditions)")
    for m in (5, 6):
        D = m*(m-1)//2
        X = rng.normal(size=(D, D)); W = 0.5*(X+X.T)
        B = one_form_action(W, m); R = ric_matrix(W, m)
        print(f"   m={m}: |sym(B) + Ric| = {np.linalg.norm(0.5*(B+B.T)+R):.2e}"
              f"   |Ric| = {np.linalg.norm(R):.2f}")

    print("\n(2) A(R) = 2R - (Ric.w + w.Ric) on Bianchi-satisfying R (Ricci free)")
    for m in (5, 6, 7):
        Bb = constrained_basis(m, use_ricci=False, use_bianchi=True)
        for t in range(2):
            R = np.einsum('k,kij->ij', rng.normal(size=Bb.shape[0]), Bb)
            R = 0.5*(R+R.T); R /= np.linalg.norm(R)
            A = A_of_gh(R, m); L, Ric = ric_operator(R, m)
            print(f"   m={m}: |A - (2R - L)| = {np.linalg.norm(A-(2*R-L)):.2e}"
                  f"   |Ric|={np.linalg.norm(Ric):.3f}")

    print("\n(2b) same on a GENERIC symmetric operator (Bianchi violated)")
    for m in (5, 6):
        D = m*(m-1)//2
        X = rng.normal(size=(D, D)); R = 0.5*(X+X.T); R /= np.linalg.norm(R)
        A = A_of_gh(R, m); L, Ric = ric_operator(R, m)
        print(f"   m={m}: |A - (2R - L)| = {np.linalg.norm(A-(2*R-L)):.2e}  (|A|={np.linalg.norm(A):.2f})")

    print("\n(3) Schur constants on explicit summands")
    for m in (5, 6, 7, 8):
        D = m*(m-1)//2
        h = rng.normal(size=(m, m)); h = 0.5*(h+h.T); h -= np.trace(h)/m*np.eye(m)
        Rh = kn_operator(h, m)
        Aid = A_of_gh(np.eye(D), m)
        Ah = A_of_gh(Rh, m)
        T = rand_4form(m, rng); RT = lambda4_operator(T, m)
        AT = A_of_gh(RT, m)
        print(f"   m={m}: scalar {np.trace(Aid)/D:+.4f} (pred {-2*(m-2):+d}, resid "
              f"{np.linalg.norm(Aid+2*(m-2)*np.eye(D)):.1e});  "
              f"Ric_0 resid {np.linalg.norm(Ah+(m-4)*Rh):.1e} (pred {-(m-4):+d});  "
              f"Lambda^4 resid {np.linalg.norm(AT+4*RT):.1e} (pred -4)")
