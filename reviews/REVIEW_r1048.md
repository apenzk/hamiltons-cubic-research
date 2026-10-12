# r1048, the second-order condition for I106b, derived independently and screened

**Scope.** `cf3fd2cf` and `5cc2ec98`, their additions to [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) and [plan.md](../plan.md), and the 2026-09-21 section of the [working note](2026-09-17-I106b-face.md). Every formula below was rederived from `f(Q) = Σ_{ik} A_{ik} Q_{ik}²` rather than checked against the parent's algebra. Log: [r-secondorder-a.log](../agent_logs/r-secondorder-a.log).

| # | claim | verdict |
|---|---|---|
| 1 | `½f''(0) = ⟨A,(QΩ)∘(QΩ)⟩ + tr(SΩ²)` | **CONFIRMED**, and stronger than the note claims: the `tr(S·)` against `tr(Sᵀ·)` ambiguity is empty because `Ω²` is symmetric, so the formula needs no symmetry of `S` |
| 2 | `f'(0) = 2tr(ΩᵀS)`, vanishing at all skew `Ω` iff `S` symmetric | **CONFIRMED** |
| 3 | `skew_sq_eq_neg_gram`, and `SecondOrderMax` points the right way for a MAXIMUM | **CONFIRMED**. `value` is the Frobenius pairing, so the typed inequality is exactly `½f''(0) ≤ 0` |
| 4 | the three screened numbers `+0.1099`, `−0.2277`, `+0.2595` | **CONFIRMED**, all three reproduced to four places in independent code, with the three values `0.3828`, `1.4688`, `1.2093` and the finite-difference figure `−0.841833` |
| 5 | the second-order condition EXCLUDES r1043's witness | **CONFIRMED for the witness, REFUTED as a reading of the table.** Only the first row carries information. Rows two and three are the value comparison rewritten, by an identity proved below |
| 6 | r1034's refutation "has lost its premise" | **CONFIRMED narrowly, REFUTED as drawn.** The premise is gone at `k ≥ 5`, but the conclusion the commits draw from that does not follow, and `f83e3c8e` falsified it eighteen minutes later |

## 1. The derivation, redone

Write `P(s) = Q exp(sΩ)` with `Ωᵀ = -Ω`, so `P(0) = Q`, `P'(0) = QΩ`, `P''(0) = QΩ²`. With `f(P) = Σ_{ik} A_{ik} P_{ik}²`,

> `f'(s) = 2 Σ A_{ik} P_{ik} P'_{ik}`, `f''(s) = 2 Σ A_{ik} (P'_{ik})² + 2 Σ A_{ik} P_{ik} P''_{ik}`.

At `s = 0`, `½f''(0) = ⟨A, (QΩ)∘(QΩ)⟩ + ⟨A∘Q, QΩ²⟩`, and `⟨A∘Q, QΩ²⟩ = tr((A∘Q)ᵀ Q Ω²) = tr(Sᵀ Ω²)` with `S = Qᵀ(A∘Q)`.

**So the term my derivation produces is `tr(Sᵀ Ω²)`, and the record's `tr(S Ω²)` is the same number.** `tr(SᵀΩ²) = tr((Ω²)ᵀ S)` and `(Ω²)ᵀ = (Ωᵀ)² = Ω²` at skew `Ω`, so the two agree. **This is the trap the brief names and the record clears it**, and it clears it for a better reason than the record gives: the note's justification would have been symmetry of `S` at a critical point, whereas the true reason is symmetry of `Ω²`, which holds at every `Ω` and every `Q`. *So the formula is valid away from criticality as well, which is what a second-variation formula should be.* **There is no factor of two adrift**: the `½` on the left is what absorbs the `2` from both product-rule terms at once.

**Screened against finite differences at a RANDOM `A` and a RANDOM orthogonal `Q`**, deliberately at a point where `S` is NOT symmetric, so that a symmetrisation error would show. Central second difference at `h = 1e-4` gives `-4.1206727`, the closed form `-4.1206728`, and `tr(SᵀΩ²)` the same to every digit printed. *The note's own finite-difference check, `-0.841833`, I located exactly: it is the generator `E_{01}` at the global permutation maximiser, where `S` is diagonal. That point could not have caught a `S` against `Sᵀ` slip, and the check above can.*

## 2. The first-order term

`f'(0) = 2⟨A∘Q, QΩ⟩ = 2 tr((A∘Q)ᵀ Q Ω) = 2 tr(Sᵀ Ω) = 2 tr(Ωᵀ S) = 2⟨S, Ω⟩`, matching the record sign for sign. Finite differences at the same random `(A,Q,Ω)`: `-2.1358939` against `-2.1358939`.

**Vanishing at every skew `Ω` is exactly symmetry of `S`**, since `⟨S,Ω⟩ = 0` for all skew `Ω` says `S` is orthogonal to the skew subspace, whose orthogonal complement under the Frobenius pairing is the symmetric one. That is `asym_factor`'s hypothesis, so the derivation is in the record's conventions. **CONFIRMED.**

## 3. The sign, which is where this record has been wrong before

**`skew_sq_eq_neg_gram` is right and its proof is right.** `Ωᵀ = -Ω` gives `-(ΩᵀΩ) = -((-Ω)Ω) = ΩΩ`, and `rw [hOm, Matrix.neg_mul, neg_neg]` is that chain in order.

**The direction in `SecondOrderMax` is the one a MAXIMUM needs.** A local maximum has `f''(0) ≤ 0` along every one-parameter subgroup, hence `⟨A,(QΩ)∘(QΩ)⟩ + tr(SΩ²) ≤ 0`, and substituting `Ω² = -ΩᵀΩ` gives `⟨A,(QΩ)∘(QΩ)⟩ ≤ tr(S ΩᵀΩ)`.

**The typed predicate says that, and the check runs through `value`.** [value](../lean/HamiltonsCubic/Results/I106bFace.lean) is `(Aᵀ * R).trace = Σ_{ij} A_{ij} R_{ij}`, the Frobenius pairing, so the left side of `SecondOrderMax` is `⟨A,(QΩ)∘(QΩ)⟩` and the right is `tr(Qᵀ(A∘Q) ΩᵀΩ) = tr(S ΩᵀΩ)`. **A minimum would satisfy the reverse inequality**, so the predicate is not one a minimum meets. **CONFIRMED.**

*Two scope remarks, neither a defect.* The predicate carries no criticality, which is harmless because a local maximum of a smooth function on a compact manifold is automatically critical, so "local max ⟹ `SecondOrderMax`" holds as the docstring states it. And quantifying over `Q exp(sΩ)` rather than over all curves is exactly right at a critical point, where the second derivative of the curve contributes `df_Q[QΨ] = 0`. **Both directions of that make the docstring's wording, necessary rather than sufficient, the correct one.**

## 4. The three numbers, recomputed

**All three reproduce, in code written from [r1043](REVIEW_r1043.md)'s published twenty-digit witness with nothing taken from the parent's script.** `β = 1`, `A_{ik} = u_i ν_k² + c_i ν_k`, `f(Q) = Σ A_{ik} Q_{ik}²`, generators `E_{ab}` with `(E_{ab})_{ab} = 1`, `(E_{ab})_{ba} = -1`, ten of them at `k = 5`.

| point | value | `max_{a<b} ½f''(0)` | note's figure |
|---|---|---|---|
| [r1043](REVIEW_r1043.md)'s `k = 5` witness | `0.3828236` | **`+0.1099481`** at `E_{02}` | `+0.1099` ✓ |
| global permutation maximiser `σ = (0,4,3,2,1)` | `1.4688` | `−0.2277` at `E_{13}` | `−0.2277` ✓ |
| best zero-diagonal permutation `σ = (4,0,3,2,1)` | `1.2093` | `+0.2595` at `E_{04}` | `+0.2595` ✓ |

**The subsidiary figures check too.** `max|QQᵀ − I| = 1.1e−16`, `max|S − Sᵀ| = 4.2e−17` at the witness (the note says `5.6e−17`, the same order and the same conclusion, the difference being which norm is taken). The finite-difference figure `−0.841833` is `E_{01}` at the global maximiser, closed form and central difference agreeing to six decimals. **The global maximiser really is `(0,4,3,2,1)` and the best derangement really is `(4,0,3,2,1)`**, by exhaustion over all `120` permutations.

**CONFIRMED**, with one process defect: **the script is not committed.** `5cc2ec98` touches [plan.md](../plan.md) and the [note](2026-09-17-I106b-face.md) and nothing else, so none of this is replayable from the record. *This is the same defect [r1034](REVIEW_r1034.md) recorded against `3b8232ba` in section 4 of its report, repeating.*

## 5. What the screen shows, and what it only appears to show

### The witness: the conclusion is justified

**One positive direction is enough and there is one.** At a critical `Q`, a skew `Ω` with `½f''(0) > 0` gives a curve through `Q` with `f'(0) = 0` and `f''(0) > 0`, so `f` has a strict local minimum along it and `Q` is not a local maximum. `+0.1099` at `E_{02}` does that. **The concern that ten generators might be too few does not bite in this direction**: a maximum over a subset is a lower bound on the maximum over the whole space, and a positive lower bound is all the argument uses.

**I checked the whole space anyway**, by assembling the `10 × 10` matrix of the quadratic form `Ω ↦ ½f''(0)` in the `E_{ab}` basis by polarisation. At the witness its eigenvalues are

> `−1.1520, −0.7716, −0.5246, −0.2789, −0.1589, −0.0000, 0.0000, 0.1113, 0.3692, 0.4915`.

The true maximum is `0.4915`, well above the `0.1099` the generators see, and the form is genuinely non-diagonal there, off-diagonal entries reaching `0.373`. *Two eigenvalues sit at zero, so the witness carries a two-dimensional degenerate direction, which is what a point inside a positive-dimensional family of equal-value critical points looks like and is consistent with r1043's parameter count. Reported as an observation.*

### The two permutation rows carry nothing the value column does not

**At a permutation matrix the second variation is DIAGONAL in the elementary basis, and each diagonal entry is a transposition gain.** Proved, not screened. Let `Q = P_σ` with `P_{i,σ(i)} = 1`. Then `(P_σ Ω)_{ij} = Ω_{σ(i),j}`, and `S = Pᵀ(A∘P)` is the diagonal matrix `S_{ll} = A_{σ⁻¹(l),l}`. Substituting into `½f''(0) = ⟨A,(QΩ)∘(QΩ)⟩ − tr(S ΩᵀΩ)` and reindexing both sums onto `Ω_{pj}²`,

> `½f''(0) = Σ_{p,j} [ A_{σ⁻¹(p), j} − A_{σ⁻¹(j), j} ] Ω_{pj}²`.

**Every term carries `Ω_{pj}²`, so the form is diagonal in the entries of `Ω` and hence in the `E_{ab}`.** At `Ω = E_{ab}`, writing `i = σ⁻¹(a)` and `j = σ⁻¹(b)`, it collapses to

> `½f''(0) = (A_{ib} + A_{ja}) − (A_{ia} + A_{jb}) = f(σ') − f(σ)`, where `σ'` is `σ` with the images of `i` and `j` exchanged.

**Verified numerically at both permutations: the Hessian's off-diagonal is `2.2e−16`, and the identity holds at all ten generators at each point.** The eigenvalue multiset equals the generator-value multiset exactly, at both.

**Three consequences, and they are what the note's table needs.**

1. **The ten generators ARE the whole space at a permutation**, so the note's `−0.2277` is the true maximum over all skew directions there. *The inference "a local maximum, as required" is therefore true. The evidence offered for it, a maximum over ten generators, does not establish it in general and happens to here, which is worth recording because at the witness the same evidence understates the true maximum by a factor of four.*
2. **`−0.2277 < 0` at the global permutation maximiser is automatic and tests almost nothing.** It says only that no transposition improves the best permutation, which is true by construction. *The control is valid as a sign check, since a flipped convention would have returned `+0.2277`, and it is valid as a maximality check because Birkhoff makes that permutation the global maximiser over all of `O(5)`. Its content beyond the sign is nil.*
3. **`+0.2595` at the best zero-diagonal permutation is `1.4688 − 1.2093` exactly**, the gap to the global maximiser, which the note's own value column already prints. *The two permutations differ by one transposition, exchanging the images of `0` and `1`, so the third row of the table is the first and second rows subtracted.*

### The harder question the brief asks

**Row one does carry something the value comparison does not, and it is not what the route needs.** The value comparison, `0.3828` against `1.4688`, says the witness is not the GLOBAL maximiser, which is all the route has to exclude and which [r1043](REVIEW_r1043.md) already recorded. The screen says the witness is not a LOCAL maximiser, which is strictly more. **The worth of that is a go/no-go on the route rather than progress along it**: had the witness been a local maximum, no argument built from the second-order condition alone could ever have excluded it, and the route would have been dead on arrival. *It is not, so the route had a chance. The note's "which is what makes the route worth attempting rather than a hope" is a fair statement of exactly that, and no more should be read into it.*

**Verdict: CONFIRMED for the witness, REFUTED as a reading of the table.** The note should say that rows two and three are the value comparison in other coordinates, and that row one alone is evidence.

## 6. What r1034 refuted, and whether the premise is gone

**[r1034](REVIEW_r1034.md) refuted the sentence "the theorem now needs the second-order condition to do the whole separation", and its ground is stated explicitly**: *"A first-order route survives and is the natural one: every zero-diagonal critical point of `f` is a signed permutation matrix."* It adds that this implies [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) at `P = Q`, and screens it at `118/118` and `109/109`.

**So the refutation does NOT stand independently of a surviving first-order route. It is the route.** [r1043](REVIEW_r1043.md) exhibits a zero-diagonal critical `Q` at `k = 5` that is not a signed permutation, which is the negation of exactly that sentence. **The premise is therefore gone above `k = 4`, and "has lost its premise" is accurate as stated.** *At `k = 4` the premise survives and is proved, which is `zero_diag_critical_is_isSignedPerm_four`. The commits say "closed that route at `k = 5`" and the file says "dead above `k = 4`", both correctly qualified.*

**What does not follow is the conclusion the commits draw from it.** Losing a premise leaves the refuted sentence unproven, not true. *"So the refutation's premise is gone and the second-order condition is the item's open content" needs the first-order and second-order routes to be the only two, and they never were.*

**The record contained the third route at the time the sentence was written, in the same file.** The [note](2026-09-17-I106b-face.md) already carried, before either commit: *"once the commutator vanishes the rung needs no face argument, no tangency exclusion and no second-order condition, only Birkhoff."* **`f83e3c8e`, eighteen minutes after `5cc2ec98`, proved `face_hands_down` from Birkhoff-von Neumann with no second-order input and with `hzero` unused.**

**Verdict: CONFIRMED narrowly, REFUTED as drawn.** The premise is gone. The resurrection does not follow from it.

## 7. The process point, the mis-designed control

**The passage is [note](2026-09-17-I106b-face.md) line 311**: *"A first control was mis-designed and its failure was reported here before being corrected: it tested the best DERANGEMENT rather than the global maximiser, and a non-maximal permutation may perfectly well have `f'' > 0`, so that control could never have passed."*

**The correction is right.** A control for the sign of a maximality condition has to be evaluated at a point known to be a local maximum. The global permutation maximiser is one, and by Birkhoff it is the global maximiser over all of `O(5)`, so `½f''(0) ≤ 0` there is guaranteed and a positive answer would have been a genuine failure. *That warrant rests on the argument proved in `f83e3c8e`, which the note does not cite because it had not been written yet. The control was sound before its warrant was.*

**The best derangement carries no such warrant**, which is the defect, and the note names it correctly.

**One wording correction.** *"That control could never have passed"* is stronger than the facts. The right statement is that it had no warrant: a non-maximal permutation may pass or fail and neither outcome means anything. **By the identity of section 5 it failed here for a reason visible in the value column alone**, the best derangement being one transposition from the global maximiser with a gain of `0.2595`, so its failure was a restatement of its non-maximality and never a test of the formula.

**The episode is otherwise described accurately and the disclosure is the right call.**

**One thing the note leaves for the reader to notice.** *The "third reading", the `+0.2595` row, is the failed control's own number: the best zero-diagonal permutation IS the best derangement, a permutation matrix having zero diagonal exactly when its permutation has no fixed point.* The note says both things in adjacent paragraphs without joining them. **The finding it is repurposed into is correct**: at this `A` the global maximum sits at `σ = (0,4,3,2,1)`, which fixes `0`, so no zero-diagonal `Q` attains the maximum and `face_hands_down`'s `hzero` together with `hmax` is unsatisfiable at this `A`. *That is now moot in a second way, `hzero` having been shown unused.*

## 8. Overreach sweep

**Passages the declarations and the record do not support, at HEAD.**

1. **[I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean), the section heading**: *"The SECOND-ORDER condition, which is what the item needs above `k = 4`"*, and in its body *"so the refutation's premise is gone and the second-order condition is the item's open content"*. **What the item needs, on [plan.md](../plan.md)'s own HEAD text, is the COUPLED PAIR**, and the single-`Q` statement is closed by Birkhoff. *Both sentences were written before `f83e3c8e` and neither was revised by it. Replace with what the declarations do carry: the second-order condition is stated, it is a necessary condition at a maximum, and nothing in the file consumes it.*
2. **[lean/INDEX.md](../lean/INDEX.md), the I106b row, at HEAD**: *"**NOT stated**: that `M = 0` IS criticality ... and the second-order condition."* **`SecondOrderMax` and `skew_sq_eq_neg_gram` have been in the file since `cf3fd2cf`**, which did not touch [lean/INDEX.md](../lean/INDEX.md), and `f83e3c8e` rewrote that row without fixing the clause. *The row understates the file.*
3. **[lean/INDEX.md](../lean/INDEX.md), same row**: *"the file now carries ONE `sorry`, `face_hands_down`"*, against the same row's own status cell, **proved, no `sorry`**. *Collateral from `f83e3c8e` rather than from the commits under review, recorded because it is one row disagreeing with itself.*
4. **[plan.md](../plan.md) at HEAD**: *"**Owed**: the second-order condition, which is now the item's live content"*, six lines after the same bullet says the commuting case is closed and **BIRKHOFF DOES NOT TRANSFER TO THE RUNG**. *The bullet asserts both that the live content is the coupled pair and that it is the second-order condition. The second-order condition is about critical points of the single-`Q` problem, so it is not obviously live for the rung at all, and the bullet should say which.*
5. **[plan.md](../plan.md) at HEAD**: *"`face_hands_down` is untouched by the refutation."* **`face_hands_down` is PROVED**, so the sentence is a survival from before the proof and reads as though the statement were still open.
6. **[plan.md](../plan.md) and the [note](2026-09-17-I106b-face.md)**: *"SCREENED AT THAT WITNESS AND IT IS EXCLUDED"* with `+0.1099` set against `−0.2277`. **The comparison is not between like things.** `+0.1099` is a genuine reading at the witness, and `−0.2277` is a tautology at the global maximiser, by section 5. *The sentence would be better with the witness figure alone.*
7. **`5cc2ec98`'s message**: *"control at the global permutation maximiser `(0,4,3,2,1)`, value `1.4688`, gives `−0.2277`, a local maximum as required"*. **The conclusion is true and the evidence as offered does not reach it**, a maximum over ten basis directions being a lower bound on the maximum over the form. *It reaches it here only because the form is diagonal at a permutation, which section 5 proves and the message does not claim.*

**Passages that DO hold, checked above and worth naming so the sweep is not read as a blanket.** The derivation, both orders, in the record's own conventions; `skew_sq_eq_neg_gram` and its proof; the direction of `SecondOrderMax`; all three screened values and all three function values; the finite-difference agreement at `−0.841833`; the symmetry of `S` at the witness; the description of the mis-designed control; and the observation that the global maximum sits at a permutation with a fixed point, so `face_hands_down`'s hypotheses are unsatisfiable at this `A`.

## 9. What to do

1. **Record the diagonality identity of section 5** in the [note](2026-09-17-I106b-face.md): at a permutation, `½f''(0)` along `E_{ab}` is the gain from the transposition exchanging `σ⁻¹(a)` and `σ⁻¹(b)`. *It makes rows two and three of the table readable, retires the ten-generators worry at permutations, and is the reason `SecondOrderMax` at a permutation is `2`-opt optimality of an assignment problem, which is a fact about the condition rather than about this `A`.*
2. **Rewrite the table's reading**: row one is the evidence, rows two and three are the value comparison in other coordinates.
3. **Fix items 1 to 5 of section 8**, which are all stale-after-Birkhoff text in three files.
4. **Commit the screening script** to `scripts/misc/`, beside the four `screen_I106b_*.py` already there. *The same omission was recorded against this item once before.*
5. **Say what `SecondOrderMax` is FOR**, now that the single-`Q` statement is closed. *Nothing in the file consumes it, and its route to the rung is not stated anywhere.*

## 10. How the analysis-only rule was honoured

**No sweep, no census, no optimisation of unknown cost, no unbounded falsifier hunt.** Every positive statement of this report is a derivation: the second-variation formula, the `tr(Sᵀ·)` against `tr(S·)` identity, the first-order equivalence, the sign of `SecondOrderMax`, and the diagonality-and-transposition identity at a permutation.

**The computation was priced before it ran and all of it finished in under two seconds.** It was: evaluating the closed form and a central difference at one random `(A, Q, Ω)`; evaluating it at the three published points along ten fixed generators; assembling three `10 × 10` quadratic forms by polarisation, `100` evaluations each; and an exhaustion over the `120` permutations of `Fin 5`, which is a fixed finite set rather than a search. **The exhaustion is the only enumeration here and its size was known in advance.**

**No Lean was compiled**, the toolchain being shared and every finding above being a statement about what a docstring says or what an inequality means. The `pgrep` guard was therefore never needed.

*Script, outside the repository: `r1048.py` in this session's scratchpad. Recommendation 4 asks the parent for the committed version, which is the one the record should carry.*
