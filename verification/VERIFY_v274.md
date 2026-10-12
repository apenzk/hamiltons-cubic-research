# Verifier v274, the second-kind spectrum of the balanced product S^m x S^m (Lemma L67): Passage B's proof, Li's Theorem 1.8 route, the constant A and its sign, and the block's further claims

Cold brief ([BRIEF_L67.md](BRIEF_L67.md)). No numerical work, every value exact, no scripts written or run, no Lean build run. Log: [agent_logs/verify-L67-v274.log](../agent_logs/verify-L67-v274.log). Sources read: [bispectral.md](../findings/bispectral.md) at the cited lines only (172-196, 503, 507, 511-513, 517), [results.md](../results.md) lines 322, 336, 1102, [conventions.md](../findings/conventions.md) lines 96-108, [L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean) in full, and [li-2209.02119.txt](https://arxiv.org/abs/2209.02119) lines 236-640 (Theorem 1.8, section 2 conventions, Lemmas 2.1-2.3, Proposition 2.1, Examples 2.1-2.8). Every quotation in the brief matches its source lines verbatim.

| # | Claim | Verdict |
|---|---|---|
| C1 | Passage B: R = G^(1)+G^(2) is the curvature of the unit S^m x S^m and c = (m-1)/(2m-1) makes W = R - cG trace-free | CONFIRMED (symbols undefined on file, one consistent reading) |
| C2 | Passage B: the operator formula for W̊ on S^2_0 in the iklj order | CONFIRMED |
| C3 | Passage B: the splitting into three invariant summands named as "the two within-factor trace-free parts and the cross block" | GAP (the summand carrying the bottom eigenvalue is unnamed, closed by Li's Lemma 2.3) |
| C4 | The three values in ratio m : -(m-1) : -2m(m-1) with multiplicities (m-1)(m+2), m^2, 1, exhausting S^2_0 | CONFIRMED |
| C5 | Passage D: Li's Theorem 1.8 applies, and "subtracting the Einstein part" reaches W̊ | GAP (subtraction step unwritten in D, written in B as the -ch term) |
| C6 | A > 0 in the iklj order, so the bottom eigenvalue is -2m(m-1)A | CONFIRMED |
| C7 | A = 1/(m sqrt((m-1)(2m-1))) from normalisation to the Frobenius norm 1, "confirmed by Σμ^2 = 1 and by Σω^2 = 3" | HYPOTHESIS-DEBT |
| C8 | Hypothesis m >= 2, and m = 1 | CONFIRMED |
| C9 | p3(ω) = -(4m^2-6m-1)A | CONFIRMED AS ALGEBRA |
| C10 | p3(μ) = 1/(m sqrt((m-1)(2m-1))) | HYPOTHESIS-DEBT |
| C11 | "A is not a new constant": A = 2 sqrt 2/(n sqrt((n-1)(n-2))) at n = 2m | CONFIRMED AS ALGEBRA |
| C12 | Radical sqrt(4m^4-12m^3+13m^2-6m+1) = 2m^2-3m+1 | CONFIRMED AS ALGEBRA |
| C13 | Closure (3/2)p3(μ) - (1/2)p3(ω) = θ_0(2m) identically in m | HYPOTHESIS-DEBT |
| C14 | "p3(μ) is worth 2.7% at m = 6" | CONFIRMED AS ALGEBRA (under the reading "share of θ") |
| C15 | "The unbalanced products have a fourth value" | HYPOTHESIS-DEBT |
| C16 | Corroboration "0.210818511 at S^3 x S^3, this lemma's B-block value" | HYPOTHESIS-DEBT |
| C17 | The Lean file states a fragment of L67 and says so | CONFIRMED (it does not state or prove L67) |

**Summary: the three-value spectrum, its multiplicities and the sign of A are proven by Passage B's operator formula together with Li's Theorem 1.8 read at source, but the explicit value of A, which the block calls the lemma's only real use, rests on a normalisation link (the Frobenius norm 1 on Λ^2 giving Σω^2 = 3) that no passage derives.**

## 0. Conventions, fixed once

- **Curvature sign.** Li's convention, fixed by two derived identities at source: R̊(g) = -Ric (Li, Lemma 2.3 proof) and R̊ = κ·id on S^2_0 for S^n(κ) (Li, Example 2.1). Both hold only when R_{ijij} = +sec, that is R_{ijkl} = κ(δ_ik δ_jl - δ_il δ_jk) on S^n(κ). With the other curvature sign, Example 2.1 would read -κ.
- **Index order.** (W̊h)_ij = Σ_{k,l} W_{iklj} h_kl (Passage G). Li's section 2 writes R̊(φ)(e_i,e_l) = Σ_{j,k} R(e_i,e_j,e_k,e_l) φ(e_j,e_k), which relabels to the same iklj pattern.
- **G, G^(a), P_a, t_a.** Passage B does not define them, and a line-number search of [bispectral.md](../findings/bispectral.md) finds G^{(1)}, P_1, t_1 only at line 507 (and at line 509, not opened). The reading used throughout, the only one under which Passage B's formula is consistent: P_1, P_2 the orthogonal projections onto the two factors (P_1 + P_2 = g, rank m each), G_{ijkl} = g_ik g_jl - g_il g_jk, G^(a)_{ijkl} = (P_a)_ik (P_a)_jl - (P_a)_il (P_a)_jk, t_a = tr(P_a h).
- **Λ^2 normalisation.** μ is the spectrum of the symmetric matrix M_{(ij),(kl)} = W_ijkl over i<j, k<l in the orthonormal basis e_i∧e_j. Then Σμ^2 = ‖M‖_F^2 = (1/4)|W|^2 with |W|^2 = Σ_{ijkl} W_ijkl^2. This is the convention under which the record's two checks Σμ^2 = 1 and Σω^2 = 3 are simultaneously true (Section C7), and the Lean file's "|W|^2 = 4‖M‖_F^2" states it.
- m is an integer, n = 2m, S^m x S^m is the product of unit round spheres (equal radii, with other radii treated in Withdrawn W2).

## 1. Hypothesis inventory

| Hypothesis | Where | Used by | Satisfiable |
|---|---|---|---|
| m >= 2 | Passage A, absent from Passage E | C7 (W ≠ 0 so the normalisation is possible), C4 distinctness of the three values and positivity of (m-1)(m+2) | Yes, m = 2 gives S^2 x S^2 |
| ‖W‖_F = 1 | A, E | C7 only (C1-C6 hold before normalising and scale by a positive constant) | Yes for m >= 2, since W ≠ 0 (Section C8) |
| Equal radii (Einstein product) | Unstated | C1 (R = G^(1)+G^(2)), C5 (Li's Einstein hypothesis) | Yes, and removable (W2) |
| Li Thm 1.8: each factor Einstein, Ric(g_i) = ρ_i g_i, n_i >= 1 | Li p. 5 | C5 | S^m(1) has ρ = m-1, n_i = m >= 1. Met |
| Li's curvature sign R_{ijij} = +sec | Li section 2, implicit in Examples 2.1 | C2, C6 | Adopted by the record via Passage G ("the record's convention is Li's") |
| Λ^2 convention Σμ^2 = (1/4)Σ_{ijkl} W_ijkl^2 | Lean file comment, not in the brief's passages | C7, C10 | Yes |
| Identity Σω^2 = (3/4)Σ_{ijkl} W_ijkl^2 on Weyl_n | Lean file cites "the source's ¾" factor, source unfiled for this brief | C7 | Used but not on file |
| θ_0(n) | Passages D, E | C13, C14 | Undefined in every passage of the brief |
| Lemma L50 | Passage E, F | C13 | L50 itself records "two links are owed" |

Imported: Li's Theorem 1.8 and its algebraic form Proposition 2.1, read at source. Li's proof assembles Lemma 2.1 (cross block E in the kernel), Lemma 2.2 (factor eigenvectors extend by zero), Lemma 2.3 (n_2 g_1 - n_1 g_2 is an eigenvector with eigenvalue -(n_1ρ_2+n_2ρ_1)/(n_1+n_2)). Li's spectrum is that of π∘R̊ on S^2_0.

## C1. R = G^(1) + G^(2) and the constant c

Under the Section 0 reading, G^(a) is the unit-sphere curvature tensor of factor a extended by zero, which is Li's (2.2)-(2.3) for R = R_1 ⊕ R_2 with R_a the unit-sphere tensor. So R = G^(1)+G^(2) is the curvature of S^m(1) x S^m(1).

Ricci, with Ric_ij = Σ_k R_ikjk: Σ_k G^(a)_ikjk = Σ_k [(P_a)_ij (P_a)_kk - (P_a)_ik (P_a)_kj] = m(P_a)_ij - (P_a)_ij = (m-1)(P_a)_ij. So Ric(R) = (m-1)(P_1+P_2) = (m-1)g. Likewise Ric(G) = (2m-1)g. Hence Ric(R - cG) = [(m-1) - c(2m-1)]g, which vanishes exactly at c = (m-1)/(2m-1). R - cG inherits the curvature symmetries and Bianchi from R and G, so it is an algebraic Weyl tensor, and it is the Weyl tensor because R is Einstein (W = R - s/(n(n-1))·G with s = 2m(m-1), n(n-1) = 2m(2m-1), giving the same c). CONFIRMED.

Discrepancy record for the undefined symbols: (1) line 507 uses G^(1), G^(2), G, P_1, P_2, t_1, t_2 with no definition in the block or elsewhere in the file. (2) A reader without the Section 0 reading cannot check the formula. (3) Charitable: the notation is the standard one and exactly one assignment of meanings makes the displayed formula correct, so the symbols are recoverable from the formula itself. Recorded as a presentation defect inside CONFIRMED, not as a separate verdict.

## C2. The operator formula on S^2_0

For G^(a) in the iklj order: (G̊^(a)h)_ij = Σ_kl [(P_a)_il (P_a)_kj - (P_a)_ij (P_a)_kl] h_kl. The first term, summed over k and l, is Σ_{k,l} (P_a)_jk h_kl (P_a)_li = (P_a h P_a)_ji = (P_a h P_a)_ij by symmetry of h. The second term is (P_a)_ij tr(P_a h) = t_a (P_a)_ij. So G̊^(a)h = P_a h P_a - t_a P_a. Setting P_a = g gives G̊h = h - (tr h)g, which is h on S^2_0 (Li's Example 2.1 at κ = 1, as it must be). Therefore on S^2_0

W̊h = P_1hP_1 + P_2hP_2 - t_1P_1 - t_2P_2 - ch,

as Passage B writes. The formula is valid on S^2_0 only: on h = g it returns (1-m-c)g, whereas W̊g = -Ric(W) = 0, the difference being the dropped +c(tr h)g. Passage B applies it on S^2_0 only. W̊ maps S^2_0 into S^2_0 (the trace of the right side is t_1+t_2 - m(t_1+t_2) - c·tr h = 0), so no projection π is needed, unlike Li's R̊. CONFIRMED.

## C3. The named splitting

**Candidate (survives).** (1) Line 507: "splits S^2_0 into three O(m)×O(m)-invariant summands (the two within-factor trace-free parts and the cross block), whose eigenvalues stand in ratio m:-(m-1):-2m(m-1)". (2) The pieces the parenthetical names are T_1 = {h = P_1hP_1, tr h = 0}, T_2 likewise, and X = {h = P_1hP_2 + P_2hP_1}, of dimensions (m-1)(m+2)/2, (m-1)(m+2)/2, m^2. Their total is (m-1)(m+2) + m^2 = 2m^2 + m - 2 = dim S^2_0 - 1. The trace-free tensor h_0 = P_1 - P_2 lies in none of them and is orthogonal to all three, and it is the eigenvector of the bottom eigenvalue: P_1h_0P_1 = P_1, P_2h_0P_2 = -P_2, t_1 = m, t_2 = -m, so W̊h_0 = (1-m-c)h_0 = -2m(m-1)/(2m-1)·h_0. As written, the named summands miss the one-dimensional summand that carries -2m(m-1)A, the value Passage C calls the lemma's only real use, and T_1, T_2 share one eigenvalue, so three named summands cannot carry three distinct values. (3) Charitable reading: "the two within-factor trace-free parts" is one summand T_1 ⊕ T_2 (one eigenvalue), the cross block is the second, and the third summand is meant but not named. Under that reading the splitting is right, but the eigenvector and the eigenvalue computation for the multiplicity-one value are still absent from Passage B. The candidate survives step 3 as a gap in the written proof. It is closed on file by Li's Lemma 2.3 (read at source: n_2g_1 - n_1g_2 = m(P_1 - P_2) is an eigenvector of π∘R̊ with eigenvalue -(n_1ρ_2+n_2ρ_1)/(n_1+n_2) = -(m-1)), combined with the -ch term of C2. GAP.

## C4. The three values and multiplicities

From C2 on each summand, before normalising:

| summand | dimension | t_1, t_2 | R̊ eigenvalue | W̊ eigenvalue |
|---|---|---|---|---|
| T_1 ⊕ T_2 | (m-1)(m+2) | 0, 0 | 1 | 1 - c = m/(2m-1) |
| X (cross block) | m^2 | 0, 0 | 0 | -c = -(m-1)/(2m-1) |
| span(P_1 - P_2) | 1 | m, -m | -(m-1) | -(m-1) - c = -2m(m-1)/(2m-1) |

The R̊ column is Li's Example 2.3 at n_1 = n_2 = m, κ_1 = κ_2 = 1: values 1 (multiplicity (m-1)(m+2)/2 twice), 0 (multiplicity m^2), -(m(m-1)+m(m-1))/(2m) = -(m-1) (multiplicity one). The summands are mutually orthogonal and span S^2_0: any trace-free h decomposes as [P_1hP_1 - (t_1/m)P_1] + [P_2hP_2 - (t_2/m)P_2] + [P_1hP_2 + P_2hP_1] + (t_1/m)(P_1 - P_2), using t_1 + t_2 = 0. The dimensions sum to 2m^2+m-1 = (2m)(2m+1)/2 - 1 = dim S^2_0. So the W̊ spectrum is (1/(2m-1))·{m, -(m-1), -2m(m-1)} with the stated multiplicities, the multiplicities attached to the right summands. At m >= 2 the three values are distinct (-(m-1) = -2m(m-1) forces m = 1 or m = 1/2) and all multiplicities are positive, so "exactly three" holds. CONFIRMED.

## C5. Passage D's route through Li's Theorem 1.8

Li's hypotheses are met (Section 1). Li's theorem gives the spectrum of R̊, not of W̊, and Passage D reaches W̊ by "subtracting the Einstein part" with no argument. The step needed is that the Einstein part cG has G̊ = id on S^2_0, so W̊ = R̊ - c·id there and the spectrum shifts by -c. Passage D writes none of this, and it also writes the value of A without deriving it. Passage A says "the argument is the surrounding material in this file", which is Passage D. Discrepancy record: (1) Passage D line 180, "subtracting the Einstein part to reach the Weyl tensor". (2) Taken alone, D states the table without the shift, so a reader of D alone cannot verify the table. (3) Charitable: the shift is one line, and it is on file in Passage B as the -ch term (C2). GAP in D standalone, closed by B. The brief's attack item 1 answered: neither passage alone establishes the spectrum. B supplies the shift and two summands, Li supplies the third summand and the multiplicity-one eigenvector, and together they do.

D's sentence "verified here to 1.8×10^-15 on six sphere products" is a run and carries no weight here. Li's theorem is read at source and needs no run.

## C6. The sign of A and the bottom eigenvalue

The unnormalised spectrum is (1/(2m-1))·{m, -(m-1), -2m(m-1)}, and 1/(2m-1) > 0. Normalising multiplies by a positive scalar, so the normalised spectrum is A·{m, -(m-1), -2m(m-1)} with A > 0, whatever positive value the normalisation assigns. The bottom eigenvalue is -2m(m-1)A because -2m(m-1) < -(m-1) < 0 < m at m >= 2. The sign is settled by the derived identity R̊ = κ·id on S^n(κ) (Li, Example 2.1), which fixes G̊ = +id on S^2_0 in the record's convention: the ikjl order would negate W̊ (Passage G) and give A < 0 in the same table. CONFIRMED.

"The normalisation fixes A^2, not A": correct, since ‖W‖_F = 1 is invariant under W → -W, and ikjl negates W̊. CONFIRMED as part of C6.

## C7. The value A = 1/(m sqrt((m-1)(2m-1)))

What is on file: Passage C asserts A and "confirmed two independent ways, by Σμ^2 = 1 and by Σω^2 = 3", with neither computation displayed. Passage D asserts "Σω = 0, Σω^2 = 3 identically, the normalisation the identity requires". The Lean file's spec_normalisation proves the one-line sum Σ mult·spec^2 = A^2·3m^2(m-1)(2m-1), so Σω^2 = 3 is equivalent to the stated A. The sum is correct: m^2(m-1)(m+2) + m^2(m-1)^2 + 4m^2(m-1)^2 = m^2(m-1)(6m-3).

What is not on file: the step from the stated hypothesis ‖W‖_F = 1 (the Frobenius norm on Λ^2) to Σω^2 = 3. That step needs the identity Σω^2 = 3‖W‖_F^2 on Weyl_n in the record's Λ^2 convention (equivalently Σω^2 = (3/4)|W|^2 and ‖W‖_F^2 = |W|^2/4). The Lean file attributes the 3/4 to "the source", which is not filed for this brief. The alternative route, Σμ^2 = 1, needs the Λ^2 spectrum of W at S^m x S^m, which no passage derives. The normalisation is load-bearing for the value: under the other common Λ^2 convention, M'(e_i∧e_j) = Σ_{k,l} W_ijkl e_k∧e_l with ‖M'‖_F^2 = |W|^2, the same hypothesis ‖W‖_F = 1 gives Σω^2 = 3/4 and A half the stated value. The record's pairing of Σμ^2 = 1 with Σω^2 = 3 selects the Section 0 convention, but that pairing is itself the unproved identity.

HYPOTHESIS-DEBT. What would have to be proved: Σω^2 = 3Σμ^2 for every algebraic Weyl tensor with the record's Λ^2 normalisation, or the Λ^2 spectrum of W at the balanced product. The value itself survives an exact screen in that convention (reported as a screen, not as a proof): the Λ^2 eigenvalues of R - cG are 1 - c on Λ^2V_1 ⊕ Λ^2V_2 (multiplicity m(m-1)) and -c on the mixed 2-forms (multiplicity m^2), giving unnormalised Σμ^2 = m^2(m-1)/(2m-1), exactly one third of the unnormalised Σω^2 = 3m^2(m-1)/(2m-1), and rescaling to Σμ^2 = 1 returns the stated A. The Passage E detail states the value, and its landscape line ("A the normalising constant") and first clause ("the constant fixed by the normalisation") do not. E's detail does state it in the iklj order, so attack item 6's last question is answered yes, in the detail only.

"Two independent ways": the two checks agree automatically once the owed identity holds, so they are independent checks of the two spectra and one check of the normalisation. Withdrawn as a finding (see W3).

## C8. m >= 2, m = 1, m = 2

- m = 1: S^1 x S^1 is flat. In C1, G^(a) = 0 for rank-one P_a, so R = 0, c = 0, W = 0, and dim Weyl_2 = 0. The hypothesis ‖W‖_F = 1 is unsatisfiable, the table's first multiplicity is 0, and A's radicand vanishes. m >= 2 is needed and sufficient for W ≠ 0 (C4 gives a nonzero eigenvalue m/(2m-1)).
- Passage E omits m >= 2. At m = 1 its hypothesis is unsatisfiable, so the canonical statement is vacuously true there. No finding, recorded in Section 4.
- m = 2 (n = 4): multiplicities 4, 4, 1, sum 9 = dim S^2_0(R^4). Values 2A, -A, -4A with A = 1/(2 sqrt 3). All three summands are nonzero (T_a has dimension 2). No edge failure.
- Kernel: W̊ on S^2_0 is invertible at m >= 2 (all three values nonzero). On S^2, g spans the extra kernel. R̊'s kernel (the cross block, Li's Lemma 2.1) is shifted to -c by the Weyl subtraction.
- The crossover n = 6 + 2 sqrt 7 does not bear: none of L67's quantities changes sign there. p3(ω) vanishes where 4m^2 - 6m - 1 = 0, at m = (3 + sqrt 13)/4 < 2, so p3(ω) < 0 throughout m >= 2 (at m = 2, 4m^2-6m-1 = 3 and the derivative 8m-6 > 0).

CONFIRMED.

## C9. p3(ω)

p3(ω) = A^3[m^3(m-1)(m+2) - m^2(m-1)^3 - 8m^3(m-1)^3] = A^3 m^2(m-1)[m(m+2) - (m-1)^2 - 8m(m-1)^2] = A^3m^2(m-1)(-8m^3+16m^2-4m-1). With A^2 m^2(m-1)(2m-1) = 1 this is -A(8m^3-16m^2+4m+1)/(2m-1), and (2m-1)(4m^2-6m-1) = 8m^3-16m^2+4m+1. So p3(ω) = -(4m^2-6m-1)A, as written. CONFIRMED AS ALGEBRA from the table (inherits C7's debt on the value of A).

## C10. p3(μ)

No passage derives the Λ^2 spectrum of W at S^m x S^m, and Passage D cites a run. HYPOTHESIS-DEBT: the Λ^2 spectrum at the balanced product. Screen (not proof), from the C7 Λ^2 eigenvalues mA (multiplicity m(m-1)) and -(m-1)A (multiplicity m^2): p3(μ) = A^3 m^2(m-1)[m^2 - (m-1)^2] = A^3 m^2(m-1)(2m-1) = A, consistent with the stated value.

## C11. "A is not a new constant"

At n = 2m: 2 sqrt 2/(2m sqrt((2m-1)(2m-2))) = 2 sqrt 2/(2m sqrt 2 sqrt((2m-1)(m-1))) = 1/(m sqrt((m-1)(2m-1))). CONFIRMED AS ALGEBRA. That this expression is "the record's tr(W^3)" at the balanced product is a citation to material outside the brief, not checked.

## C12. The radical

(2m^2-3m+1)^2 = 4m^4 - 12m^3 + (9+4)m^2 - 6m + 1. And 2m^2-3m+1 = (m-1)(2m-1) >= 0 for m >= 1, so the positive root is the one taken. CONFIRMED AS ALGEBRA.

## C13. Closure to θ_0(2m)

From C9 and C10: (3/2)p3(μ) - (1/2)p3(ω) = A[3 + 4m^2 - 6m - 1]/2 = A(2m^2-3m+1) = A(m-1)(2m-1) = sqrt((m-1)(2m-1))/m. θ_0 is defined in no passage of the brief (a line-number search found its first use at [bispectral.md](../findings/bispectral.md) line 37, which uses it without defining it), so the equality with θ_0(2m) cannot be checked, and Passage D rests it on [run_maximiser_closed_form.py](../scripts/runs/run_maximiser_closed_form.py). It also imports L50, which Passage F records as owing two links, and it inherits C10's debt. HYPOTHESIS-DEBT: a definition of θ_0 and a proof that it equals sqrt((m-1)(2m-1))/m at n = 2m, plus L50's owed links. Not used by L67's statement.

## C14. "p3(μ) is worth 2.7% at m = 6"

"Worth" is undefined. Reading it as the share of the (3/2)p3(μ) term in θ = (3/2)p3(μ) - (1/2)p3(ω): the share is (3/2)A/(A(m-1)(2m-1)) = 3/(2(m-1)(2m-1)), which at m = 6 is 3/110. Exactly, 27/1000 <= 3/110 < 275/10000 (3000 >= 2970 and 30000 < 30250), so it rounds to 2.7%. CONFIRMED AS ALGEBRA under that reading, conditional on C10. The share is positive at every m >= 2, so "L50 does not close it alone" holds at every m, not only at m = 6.

## C15. "The unbalanced products have a fourth value"

No argument on file in any passage, and L67 does not use it. HYPOTHESIS-DEBT: the W̊ spectrum of S^p x S^q, p ≠ q, with its four values distinct. Screen (not proof): at Einstein radii, (p-1)κ_1 = (q-1)κ_2 = ρ with p, q >= 2, Li's Example 2.3 and the shift by -ρ/(p+q-1) give κ_1 - c, κ_2 - c, -c, -ρ - c, which are four distinct values since κ_1 ≠ κ_2 when p ≠ q. Whether the claim is meant at other radii, and at q = 1 (S^p x S^1 is conformally flat, so W = 0 and the normalisation fails), is not stated.

## C16. The corroboration 0.210818511

"B-block" is defined in no passage. At m = 3 the table's exact values are 3A = 1/sqrt 10, -2A = -2/(3 sqrt 10), -12A = -4/sqrt 10, with A = 1/(3 sqrt 10). The numeral is positive and the only positive value is 1/sqrt 10, which it is not (0.210818511^2 < 0.09 < 1/10). So it can match a table value only in absolute value, presumably |-(m-1)A| = 2/(3 sqrt 10), and confirming nine digits of that would be decimal evaluation, which this round does not do. A numeral from another file settles no sign and no normalisation. HYPOTHESIS-DEBT: the definition of the B-block in [nondegeneracy.md](../findings/nondegeneracy.md) and an exact identification with a value of L67. Not load-bearing.

## C17. The Lean file

[L67Statement.lean](../lean/HamiltonsCubic/Results/L67Statement.lean) types a list of three reals and three multiplicities as functions of a real m, and proves: A > 0 and A^2 = 1/(m^2(m-1)(2m-1)) at m >= 2; multiplicity sum 2m^2+m-1 for all m; tracelessness; Σ mult·spec^2 = 3 at m >= 2; strict ordering; positive multiplicities; witnesses at m = 1 and m = 2. It does not mention W̊, S^m x S^m, the Weyl tensor or ‖W‖_F, and its docstring says so ("the theorem below is about the tabulated spectrum as a list of values with multiplicities, and not about W̊"). Read by hand, every typed statement is true (C4, C6, C7's sum). The build status was not run. The file's "What fails at m = 1 is A itself ... the denominator of A is 0" proves Aconst 1 = 0 by Lean's division-by-zero convention, which is a fact about the encoding and not about the geometry (at m = 1 what fails is W = 0, C8). No finding against the file's own claims. It neither states nor proves L67, and it types Σω^2 = 3 as a fact about the list, so it does not discharge C7's debt.

## 4. Gap between proven and stated or used

- Proven: the spectrum of W̊ at the unit S^m x S^m is a positive multiple of {m, -(m-1), -2m(m-1)} with multiplicities (m-1)(m+2), m^2, 1, and the bottom eigenvalue is the multiplicity-one value (C1-C6, C8).
- Stated and not proven on file: the numerical value of A (C7), which is what Passage C says every citer takes. A citer using only the ratio and the sign is covered, and a citer using the value is not.
- Passage A's locator ("the argument is the surrounding material in this file") points at Passage D, which has a gap (C5). Passage B's proof has a gap (C3). The union closes the spectrum.
- Passage E omits m >= 2 (vacuous at m = 1, C8) and describes A in its landscape line only as "the normalising constant".
- Passage E attaches C13 (closure), C14 (2.7%) and C15 (fourth value) to the lemma. C13 and C15 are debts, and none is part of L67 proper.
- Canon: Passage E says "the product rule for the second-kind operator of a Riemannian product is Li's Theorem 1.8". Li's theorem requires Einstein factors, so it is the product rule for Einstein products, which covers L67.

## 5. Falsifiers sought

| Claim | Falsifying object | What was done |
|---|---|---|
| C1 | A trace part left in R - cG | Ricci of G^(a) and G computed in closed form |
| C2 | A symmetric trace-free h where the formula and Σ W_iklj h_kl differ | Formula derived from the definitions term by term |
| C3, C4 | A trace-free h outside the named summands, or an eigenvalue mismatch | Found h_0 = P_1 - P_2 outside the named summands (C3). Explicit decomposition of every h (C4) |
| C5 | A hypothesis of Li's Thm 1.8 the factors fail | Hypotheses read at source against S^m(1) |
| C6 | A convention in which A < 0 | ikjl negates (Passage G). Li's Example 2.1 fixes the record's sign |
| C7 | A Λ^2 convention under which the stated A fails | Exhibited: M' with ‖M'‖_F^2 = Σ_{ijkl} W_ijkl^2 halves A |
| C8 | An edge value where the table fails | m = 1 (W = 0), m = 2 checked exactly |
| C9-C14 | Algebraic mismatch | Each identity expanded by hand |
| C15 | Unbalanced product with three values | Screen at Einstein radii only |
| C16 | A table value equal to the signed numeral | Signs compared exactly |

## 6. Withdrawn candidates

- **W1, ‖W‖_F ambiguous by a factor 2.** (1) Brief, "the Frobenius norm of W acting on Λ^2". (2) Under M' (C7) A halves. (3) Charitable: the block pairs Σμ^2 = 1 with Σω^2 = 3, and the Lean file states |W|^2 = 4‖M‖_F^2, which fixes the Section 0 convention. Withdrawn as an ambiguity. The underlying unproved identity is C7's debt.
- **W2, unequal radii.** (1) Passage A and E say "S^m x S^m" without radii, and C1's R = G^(1)+G^(2) needs equal radii. (2) At S^m(κ_1) x S^m(κ_2), κ_1 ≠ κ_2, the product is not Einstein and neither Passage B nor Li applies. (3) Opposite: the Weyl projection of κ_1G^(1)+κ_2G^(2), with Ric = (m-1)(κ_1P_1+κ_2P_2), s = m(m-1)(κ_1+κ_2) and g∧g = 2(G^(1)+G^(2)+X) where X = G - G^(1) - G^(2), is W = ((κ_1+κ_2)/2)·[(m/(2m-1))G - X], a positive multiple of the equal-radii tensor (m/(2m-1))G - X = R - cG. So no falsifier exists at unequal radii, and "S^m x S^m" read as the round product is the standard meaning. Withdrawn.
- **W3, "two independent ways" not independent.** (1) Passage C. (2) Given Σω^2 = 3Σμ^2, one normalisation implies the other. (3) Charitable: the two checks compute two different spectra, which are independent as spectral computations. Withdrawn.
- **W4, the sign convention underdetermined by index order alone.** (1) Passage C, "the two signs are the two index orders". (2) The sign also flips with the curvature sign convention R_{ijji} = +sec. (3) Charitable: Passage G adopts Li's convention wholesale, and Li's Example 2.1 fixes the curvature sign. Withdrawn.

## 7. Overall verdict

**HYPOTHESIS-DEBT.** The three-value spectrum, its multiplicities, the positivity of A and the bottom eigenvalue -2m(m-1)A are proven by Passage B's operator formula combined with Li's Theorem 1.8 (Lemma 2.3 supplying the multiplicity-one eigenvector that Passage B's named splitting omits). The explicit value A = 1/(m sqrt((m-1)(2m-1))) rests on the unwritten identity Σω^2 = 3‖W‖_F^2 in the record's Λ^2 convention (or on the Λ^2 spectrum at the balanced product), which is the debt to discharge. It is true on an exact screen. Passages D and E's further claims p3(μ), the θ_0 closure, the fourth value and the 0.2108 corroboration are debts outside L67 proper.
