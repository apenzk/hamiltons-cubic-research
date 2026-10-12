# r1103: I73(c) section 6, the elimination of the quintic corrections

Log: [agent_logs/r1103-I73c-sec6.log](../agent_logs/r1103-I73c-sec6.log). One of two Gate 2 reviewers of section 6 of [2026-09-23-I73c-summed-pairs.md](2026-09-23-I73c-summed-pairs.md) at bc19f92b, read with `git show`. Sections 1 to 5 are givens. All computation below is a screen of seconds, run from a scratch script that imports the repository's own Phi, Om, to4 and invariants.

**Verdict: the mathematics of section 6 is correct. The Lemma, the signs, the Proposition and the cone all hold as stated, and I found no non-class-level term the note forgot. There are three small defects of writing: the Lemma's proof uses symmetry of F without saying so, the section heading states as fact what the screen only suggests at generic e, and the Lean texts name the weight vectors in a coordinate order that differs from elim_iff's and give a partly wrong reason for what is not typed.**

| # | claim | verdict |
|---|---|---|
| 1 | the screen paragraph and its candidate list | PLAUSIBLE: the paragraph is accurate and hedged, and the list is complete up to redundant members. The section heading overreaches (F3) |
| 2 | the Lemma, bilinear reconstruction and class-level five moments | CONFIRMED, with a gap in the written proof: symmetry of F is used and not stated (F1) |
| 3 | the signs of the three leading products and the two vanishing combinations | CONFIRMED |
| 4 | the Proposition, the expression of S_ab and exactness | CONFIRMED |
| 5 | the cone clause and the shared weights | CONFIRMED, read as a statement about formal coefficients (F2) |
| 6 | the Lean statements and the not-typed reason | PLAUSIBLE: every statement is the note's claim. The weight vectors are labelled in the wrong coordinate order, and the not-typed reason is half right (F4, F5) |

## Claim 1, the screen

- **What the script does.** [screen_I73c_quintic.py](../scripts/misc/screen_I73c_quintic.py) regresses Phi(e;e²,e²) and Om(e;e²,e²) at 40 random unit Weyl e, n=6,7, against 12 candidates: tr e⁵, m311, m221, m320, m410, ⟨Ric e², Ric e³⟩ and the six products of {tr e², m110} with {tr e³, m111, m210}. That is the note's list exactly. Its printed max-norm residuals are 17.2%, 27.8% (n=6) and 13.8%, 21.2% (n=7), and with K they are 12.6%, 26.6%, 12.5% and 9.9%. So "14 to 28%" and "10 to 27%" are what the script prints.
- **The control** fits Phi(e;e,e²) against a degree-4 list (tr e⁴, (tr e²)², m211, m220, m310, |Ric e²|², m110², tr e²·m110) and returns +4, −4, −2 on |Ric e²|², m220, m211 with residual 1e-14. That list is a separate degree-4 list, so "the same regression" means the same method, not the same candidates. This is a wording point only.
- **Completeness.** A formula that stays valid when classes are merged is a polynomial in additive class moments: tr e^k, the T-moments m_ijk (T is totally symmetric, being a squared structure constant), and the Gram moments Σ ε_a^i ε_b^j G_ab. At degree 5 the T-exponent partitions are (5,0,0), (4,1,0), (3,2,0), (3,1,1), (2,2,1). The list omits only m500. The screen shows the row sums Σ_{βγ}T_{αβγ} are constant (8 at n=6, 10 at n=7, which is 2(n−2)), so m500 = 2(n−2) tr e⁵ and is redundant. The Gram moments (0,5) and (1,4) are (n−1)·2 tr e⁵ and 0 (since Ric e = 0). Products with a degree-1 factor vanish because tr e = 0. ⟨e,e^#⟩ is a multiple of m111 and needs no separate entry. So the list is complete. With m500 added the candidate matrix has rank 7 of 13, since tr e², m110 and the three cubic invariants are dependent on a Weyl tensor. The redundancy is harmless to least squares.
- **The conclusion drawn** in the paragraph ("a screen over generic e, establishing nothing at three values", motivating elimination) is correctly hedged. See F3 for the heading.
- **An extra screen the note did not run.** S_ab sees the quintic entries only through the one combination K_S = M^Φ_22/(8(n−2)) + (3/8)M^Ω_22. If that combination alone were class-level, every pair inequality would be exact and the elimination unnecessary. At the same 40-object generic sample it misses the candidate span by 18.3% (n=6) and 16.8% (n=7) in Frobenius norm. The two normalised residual vectors have singular values (0.39, 0.13) and (0.23, 0.14), so no combination of Φ_22 and Ω_22 is class-level at generic e. This supports the note's reason to eliminate. It establishes nothing at three values.

## Claim 2, the Lemma

- **P_a = L_a(e).** L_a(ε_b) = δ_ab, and the x² coefficient of L_a is ℓ_a. The (2,2) term of Σ[L_a]_i[L_b]_j M_ij is ℓ_aℓ_b M_22. Correct.
- **Bilinearity.** The summand Σ e_ijkl H_ik H_jl with H = UV+VU is quadratic in U and quadratic in V. It is therefore a linear function of U⊗U and of V⊗V, and Σ_α x_α Ψ_α⊗Ψ_α is X itself. So Φ(e;X,Y) is well defined and bilinear on symmetric operators, independently of the eigenbases chosen. The same holds for Ω, whose summand is quadratic in each of u and v. The note asserts bilinearity with no argument. The argument is this one line.
- **F1 (gap in the written proof, conclusion true).** The Lemma lists M_01, M_02, M_12 but the double sum also needs M_10, M_20, M_21. Those are equal to the listed ones only because F is symmetric in its last two arguments. That holds: {U,V} = {V,U}, and Alt(u⊗v) = Alt(v⊗u) for 2-forms since u∧v = v∧u in even degree. Screened: |F(e;Id,e²) − F(e;e²,Id)| and |Ω(e;e,e²) − Ω(e;e²,e)| below 4e-16. The proof says only "bilinear". **Repair**: "F is bilinear and symmetric in its last two arguments (H and ω are symmetric in u and v)".
- **The five moments.** M^Φ_00 = 12 tr e = 0, M^Φ_01 = 12‖e‖², M^Φ_02 = 12 tr e³ by section 5's Schur entry. M^Φ_11 = 8 tr e³ − 4⟨e,e^#⟩ = 12 tr e³ − 4‖e‖², using ⟨e, e²+e^#⟩ = ⟨W,Q(W)⟩/θ³ = 1/θ² = ‖e‖², which is the definition θ = ⟨W,Q(W)⟩ at unit W and needs no criticality. The Ω entries are (n−4)(n−5)/9 times the same Schur data, one ninth of M^Φ_11, and section 5's M^Ω_12, whose extra terms tr e⁴ and ‖e‖⁴ are spectral. All class-level.
- **Ric(e²) = Σ ε_a² A_a.** Ric is linear and e² = Σ ε_a² P_a. The script's Ric(X)_ab = Σ_c X_acbc applied to to4(ψ⊗ψ) gives Σ_c Ψ_acΨ_bc = (ΨΨ^T)_ab, the summand of A_a, with the sign that makes A_a positive semidefinite. Screened: ric(to4(Id)) = (n−1)I at n=6,7, matching section 3's Σ_b A_b = (n−1)I. So the normalisation of section 5's |Ric e²|² is the one in which |Ric e²|² = Σ_{a,b} ε_a²ε_b² G_ab. The sign is irrelevant to the square.
- **T-moments.** m22 = Σ_{abc} τ_abc ε_a²ε_b² and m211 = Σ_{abc} τ_abc ε_aε_bε_c², since T_αβγ is summed against functions constant on classes.
- **Class-level in (ε, m, τ_abc, G_12).** G enters only through G_ab, which section 3 fixes from (ε, m) and G_12. Correct.

## Claim 3, the signs

- ℓ_1 = 1/(p(p+q)), ℓ_2 = −1/(pq), ℓ_3 = 1/(q(p+q)).
- ℓ_1ℓ_2 = −1/(p²q(p+q)), ℓ_1ℓ_3 = 1/(pq(p+q)²), ℓ_2ℓ_3 = −1/(pq²(p+q)). All three as quoted.
- p ℓ_1ℓ_2 + (p+q)ℓ_1ℓ_3 = −1/(pq(p+q)) + 1/(pq(p+q)) = 0, and q ℓ_2ℓ_3 + (p+q)ℓ_1ℓ_3 = 0 the same way.

## Claim 4, the Proposition

- **The expression.** [L234](../findings/second-order.md) gives, per pair, ⟨X,e∘X⟩ = ⟨Y_0,e∘Y_0⟩ − (1/(2(n−2)))Σ e h h − (3/8)Σ e ω ω, with the cross terms already disposed of in its proof (steps 1 and 2). With h = −H/2 the Ricci term is (1/(8(n−2)))Σ e H H, whose class sum is Φ(e;P_a,P_b)/(8(n−2)). The Λ⁴ term sums to (3/8)Ω(e;P_a,P_b). Summing ⟨X,e∘X⟩ − ½‖X‖² gives S_ab = U_ab − Φ/(8(n−2)) − (3/8)Ω − ½N_ab. Signs and constants agree with sections 1, 2, 4 and 5, and they reproduce section 5's relaxed inequality when the two bounds are inserted.
- **Nothing else is non-class-level.** U_ab is in (ε, m, τ). N_ab is in (m, G_ab, τ_ab). The hatted parts are in (ε, m, τ, G) by claim 2. The only non-class-level input to S_ab is M_22, through K_S.
- **Exactness.** The weights p, q, p+q are positive and class-level. The combination is the class-level expression with M_22's coefficient identically zero, and it is ≤ 0 because each S_ab is. No relaxation is used.

## Claim 5, the cone and the shared weights

- **Shared weights.** In Σ w_ab S_ab the coefficients of M^Φ_22 and M^Ω_22 are −(1/(8(n−2)))Λ(w) and −(3/8)Λ(w) with Λ(w) = w_12ℓ_1ℓ_2 + w_13ℓ_1ℓ_3 + w_23ℓ_2ℓ_3. The prefactors do not depend on (a,b), so both vanish on one hyperplane Λ(w) = 0. Different prefactors are harmless.
- **The cone.** Multiplying Λ(w) = 0 by pq(p+q)² gives w_13 = (p+q)(w_12/p + w_23/q), and then w = (w_12/p)(p, p+q, 0) + (w_23/q)(0, p+q, q) in the order (w_12, w_13, w_23), with nonnegative coefficients when w ≥ 0. Correct.
- **F2 (scope).** "Free of the quintic entries" is a statement about formal coefficients, M^Φ_22 and M^Ω_22 treated as symbols. That is what the proof proves and what the clause needs. If K_S happened to reduce at three values, more combinations would be exact than the cone contains. The generic screen above says it does not reduce generically and says nothing at three values. **Suggested wording**: "free of the quintic entries as formal symbols".

## Claim 6, Lean

[I73cElimination.lean](../lean/HamiltonsCubic/Results/I73cElimination.lean), statements read, not compiled.

- **lead3 e1 e2 e3** = 1/((e1−e2)(e1−e3)) = ℓ_1. It is symmetric in its last two arguments, so lead3 e2 e1 e3 = ℓ_2 and lead3 e3 e1 e2 = ℓ_3. Correct.
- **lead_signs** is ℓ_1ℓ_2 < 0 < ℓ_1ℓ_3 and ℓ_2ℓ_3 < 0 under e1 < e2 < e3. It types the signs, not the closed forms, which is what the table claims.
- **elim_first** is (e2−e1)ℓ_1ℓ_2 + (e3−e1)ℓ_1ℓ_3 = 0, which is p ℓ_1ℓ_2 + (p+q)ℓ_1ℓ_3 = 0. **elim_second** is (e3−e2)ℓ_2ℓ_3 + (e3−e1)ℓ_1ℓ_3 = 0. Both are the note's identities.
- **elim_iff** is Λ(w) = 0 ⟺ w_13 = (e3−e1)(w_12/(e2−e1) + w_23/(e3−e2)), with no sign hypothesis on w. That is the note's equation and slightly stronger than its docstring's "nonnegative combination". The final step, that this places w in the cone with coefficients w_12/p, w_23/q ≥ 0, is untyped and immediate.
- **F4 (labels).** The docstrings of elim_first and elim_second, and the note's Lean table, call the weight vectors (p, 0, p+q) and (0, q, p+q). That is the order (w_12, w_23, w_13). elim_iff and the note's proof use the order (w_12, w_13, w_23), in which the vectors are (p, p+q, 0) and (0, p+q, q). Read in elim_iff's order the labels are wrong vectors. **Repair**: write (w_12, w_13, w_23) = (p, p+q, 0) and (0, p+q, q) in both places.
- **F5 (the not-typed reason).** A grep of the Lean tree finds no Φ, Ω or equivalent correction contraction, so that half is confirmed. "Defines no eigenspace projections" is loose: [L39Statement.lean](../lean/HamiltonsCubic/Results/L39Statement.lean) line 132 defines proj, the orthogonal projection onto the span of an orthonormal family, which serves as P_a given the eigenframe. The binding absence is Φ and Ω. **Repair**: "the layer defines Φ and Ω nowhere (frame projections exist, as L39Statement's proj)".

## Findings

| # | where | severity | finding | repair |
|---|---|---|---|---|
| F1 | Lemma proof | gap, conclusion true | uses M_10, M_20, M_21 = M_01, M_02, M_12 without stating symmetry of F | add "and symmetric, since {U,V} and Alt(u⊗v) are symmetric in u, v" |
| F2 | Proposition, last clause | scope | "free of the quintic entries" is formal | say "as formal symbols" |
| F3 | section 6 heading | overreach | "The quintic entries are not class-level" states flat what a generic-e screen suggests | "The quintic entries screen as non-class-level at generic e" |
| F4 | Lean docstrings, note's Lean table | notation | weight vectors given in (12,23,13) order against elim_iff's (12,13,23) | use (p, p+q, 0) and (0, p+q, q) |
| F5 | Lean header, note's table | reason half right | frame projections exist in L39Statement, and the blocker is Φ, Ω | reword as above |

No witness against any claim. The screen supporting elimination (K_S not class-level at generic e, 17 to 18%) is a screen only.
