"""
Proof-support for the two invariant write-ups closing plan.md C8 item (iii):
Jaeger's Lemma 3.4.6 (hence 3.4.3) and Lemma 3.4.8 lift off the diagonal
locus with no Bianchi hypothesis at all.

LEMMA (lifted 3.4.6). Let R >= 0 be ANY symmetric operator on Lambda^2 R^n --
Bianchi or not -- and eps >= (sqrt(10)-3)/2. Then, with Ric := Ric(R),
scal := tr Ric, lam := scal/n, Ric_0 := Ric - lam id,

    <R (Ric ^ Ric), Ric ^ 2id>
        >= n lam^4 + lam^2 (2-eps) ||Ric_0||^2 - lam (1+eps) tr Ric_0^3.

Proof. Take an orthonormal eigenbasis b_1..b_n of Ric. Both Ric^Ric and
Ric^2id are diagonal in the induced basis {b_i ^ b_j} of Lambda^2, so their
product D is diagonal there with D_ijji = eta_i eta_j (eta_i + eta_j).
Hence <R D> = tr(RD) = sum_{i<j} R_ijji D_ijji: ONLY the diagonal entries of
R in this basis enter, so no structural property of R is used yet. Since
R >= 0, R_ijji = <R(b_i ^ b_j), b_i ^ b_j> >= 0 in any orthonormal basis, so
Jaeger's componentwise bound D_ijji >= Rtilde_ijji (his Lemma 3.4.5, a
two-variable calculus fact) may be multiplied through:
sum R_ijji D_ijji >= sum R_ijji Rtilde_ijji = <R, Rtilde>. Finally Rtilde has
vanishing Weyl part (his computation, pure scalar algebra), and under the
orthogonal splitting S^2(Lambda^2) = Weyl (+) Ric_0-type (+) scalar-type (+)
Lambda^4 both the Weyl and the Lambda^4 summands are annihilated by Ric, so
<R, Rtilde> is determined by Ric(R) exactly as in the Bianchi case, and
evaluates to the stated right-hand side. The only inputs are R >= 0 and the
value of Ric(R); the first Bianchi identity is never used. QED

COROLLARY (lifted 3.4.3). Apply with R := 2W_-, which is PSD, and note
Ric(2W_-) = Ric(|W| - W) = Ric(|W|) since Ric(W) = 0 for a Weyl operator.
This is exactly T1 >= n lam^4 + lam^2 (2-eps) r_0^2 - lam (1+eps) tr Ric_0^3.

LEMMA (lifted 3.4.8) is pure trace algebra plus Cauchy-Schwarz, with no
Bianchi, diagonality, or positivity input: from W - |W| = -2W_-,
    T2 = -2<W_- E, K> = tr(WEK) - tr(|W|EK)
       <= e ||WK|| - sq/||Ric^Ric|| <(Ric^Ric)K, E> - <K, E^2> = X - <K, E^2>,
substituting |W| = sq/||Ric^Ric|| (Ric^Ric) + E in the second trace.

Also recorded here: Jaeger's Lemma 3.4.1 <R, A ^ 2id> = <Ric(R), A> needs no
lifting either -- Ric*(h) IS h ^ 2id on the nose (coefficient 1, residual 0
below), and A ^ 2id lies in the Bianchi subspace, whose pairing with R sees
only R's Bianchi part, whose Ricci equals Ric(R) because Ric kills Lambda^4.

This script verifies the three supporting facts numerically.
"""
import numpy as np
from curvature_operator import Lambda2
from weyl_decomposition import norm, frob, mop_from_4tensor, ricci_from_mop
from run_j5_structure import ric_adjoint
from run_bianchi_defect import build_alt_indices, alt_mop

EPS = (np.sqrt(10) - 3) / 2


def wedge2id(L2, h):
    """Jaeger's h ^ 2id."""
    n = L2.n
    I = np.eye(n)
    return mop_from_4tensor(L2, lambda i, j, k, l:
                            h[i, k] * I[j, l] + h[j, l] * I[i, k]
                            - h[i, l] * I[j, k] - h[j, k] * I[i, l])


def ric_wedge_ric(L2, h):
    return mop_from_4tensor(L2, lambda i, j, k, l: h[i, k] * h[j, l] - h[i, l] * h[j, k])


def main(ns=(5, 6, 8), n_samples=200, seed=0):
    rng = np.random.default_rng(seed)
    print("(1) Ric*(h) vs h ^ 2id  -- Lemma 3.4.1 needs no replacement")
    for n in ns:
        L2 = Lambda2(n)
        h = rng.normal(size=(n, n)); h = 0.5 * (h + h.T)
        K = ric_adjoint(L2, h); A = wedge2id(L2, h)
        r = frob(K, A) / frob(A, A)
        print(f"   n={n}: Ric*(h) = {r:.10f} * (h ^ 2id), residual {norm(K - r*A)/norm(K):.1e}")

    print("\n(2) Ric(Alt(A)) = 0  -- why Lambda^4 is invisible to the pairing")
    for n in ns:
        L2 = Lambda2(n); alt_idx = build_alt_indices(L2); N = L2.N
        A = rng.normal(size=(N, N)); A = 0.5 * (A + A.T)
        print(f"   n={n}: ||Ric(Alt(A))|| = {norm(ricci_from_mop(L2, alt_mop(A, alt_idx))):.1e}")

    print("\n(3) lifted Lemma 3.4.6 on random PSD (generically NON-Bianchi) R")
    for n in ns:
        L2 = Lambda2(n); N = L2.N; alt_idx = build_alt_indices(L2)
        worst = np.inf; maxdef = 0.0
        for _ in range(n_samples):
            M = rng.normal(size=(N, N))
            R = M @ M.T
            R = R / norm(R)
            h = ricci_from_mop(L2, R); scal = np.trace(h); lam = scal / n
            h0 = h - lam * np.eye(n)
            lhs = frob(R @ ric_wedge_ric(L2, h), wedge2id(L2, h))
            rhs = (n * lam ** 4 + lam ** 2 * (2 - EPS) * frob(h0, h0)
                   - lam * (1 + EPS) * np.trace(h0 @ h0 @ h0))
            worst = min(worst, lhs - rhs)
            maxdef = max(maxdef, norm(alt_mop(R, alt_idx)) / norm(R))
        print(f"   n={n}: min margin over {n_samples} PSD R = {worst:+.4e}  "
              f"(max Bianchi-defect fraction {maxdef:.3f})")


if __name__ == "__main__":
    main()
