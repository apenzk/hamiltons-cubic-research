# r1049: the second-order condition for I106b, derived independently and screened again

**Scope.** `cf3fd2cf` and `5cc2ec98`, their additions to [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) and [plan.md](../plan.md), and the 2026-09-21 section of the [working note](2026-09-17-I106b-face.md).

**Log.** [agent_logs/r-secondorder-b.log](../agent_logs/r-secondorder-b.log)

**Every formula below was differentiated from the definitions before the parent's algebra was read for anything but its statement.** The three screen numbers were recomputed from [r1043](REVIEW_r1043.md)'s published witness in code written here.

| # | claim | verdict |
|---|---|---|
| 1 | `½f''(0) = ⟨A,(QΩ)∘(QΩ)⟩ + tr(SΩ²)` | **CONFIRMED**, and the ambiguity the brief names is empty: `tr(SΩ²) = tr(SᵀΩ²)` for skewness of `Ω` alone, with no hypothesis on `S` |
| 2 | `f'(0) = 2tr(ΩᵀS)`, vanishing at all skew `Ω` iff `S` symmetric | **CONFIRMED** |
| 3 | `skew_sq_eq_neg_gram`, and the direction of `SecondOrderMax` | **CONFIRMED.** The lemma is right, its four-rewrite proof is right, and the predicate is the MAXIMUM condition, not the minimum one |
| 4 | `+0.1099`, `−0.2277`, `+0.2595` | **CONFIRMED**, all three, to four decimals, along with the values `0.3828`, `1.4688`, `1.2093` and the `−0.841833` finite-difference number, which is `E_{01}` at the permutation |
| 5 | the second-order condition excludes r1043's witness | **CONFIRMED as a fact about the witness**, with three corrections to the framing it is carried with, section 5 |
| 6 | r1034's refutation "has lost its premise" | **PLAUSIBLE, and the conclusion drawn from it does not follow.** The ground r1034 named is gone. The sentence r1034 refuted is still false, and is now false for a stronger reason |

**One finding that is a derivation rather than a verdict.** At a permutation matrix the second variation is DIAGONAL in the elementary skew basis, and its `E_{ab}` entry is exactly the assignment-value change under one transposition. Section 3 has the proof and section 6 the consequence, which is that the screen's negative row is complete rather than a sample, and that the third row has a one-line explanation.

## 1. Claim 1, differentiated here

**`Q(s) = Q exp(sΩ)` gives `Q'(s) = Q(s)Ω` and `Q''(s) = Q(s)Ω²`, so `Q'(0) = QΩ` and `Q''(0) = QΩ²`.** With `f(Q) = Σ_{il} A_{il} Q_{il}²`,

```
f'(s)  = 2 Σ_{il} A_il Q(s)_il Q'(s)_il
f''(s) = 2 Σ_{il} A_il [ Q'(s)_il² + Q(s)_il Q''(s)_il ]
```

so `½f''(0) = ⟨A, (QΩ)∘(QΩ)⟩ + ⟨A∘Q, QΩ²⟩`, and `⟨A∘Q, QΩ²⟩ = tr((A∘Q)ᵀ Q Ω²) = tr(Sᵀ Ω²)` with `S = Qᵀ(A∘Q)`.

**The brief's question is whether that last trace is `tr(SΩ²)` or `tr(SᵀΩ²)`, and the answer is that the two are equal and symmetry of `S` is irrelevant to it.** `Ω` skew makes `Ω²` SYMMETRIC, since `(ΩΩ)ᵀ = ΩᵀΩᵀ = (−Ω)(−Ω) = Ω²`. Hence `tr(SᵀΩ²) = tr((Ω²)ᵀS) = tr(Ω²S) = tr(SΩ²)`. **So the parent's form is right, the factor of two is right, and the identity holds at every `Q`, critical or not.** That matters, because the parent evaluates it at points where it has not separately established criticality.

**Screened against fourth-order central differences** at three independent random `(A, Q)` at `k = 5`, `Q` from a QR of a Gaussian and `Ω` a random skew, none of them critical (`‖S − Sᵀ‖_∞` between `0.71` and `1.46`):

| trial | `f'(0)` closed / finite difference | `½f''(0)` closed / finite difference |
|---|---|---|
| 0 | `2.50420155` / `2.50420155` | `5.15464141` / `5.15464142` |
| 1 | `−7.52978241` / `−7.52978241` | `−3.24095465` / `−3.24095453` |
| 2 | `−3.73013273` / `−3.73013273` | `−3.84098495` / `−3.84098489` |

`tr(SΩ²)` and `tr(SᵀΩ²)` agreed to printed precision in every trial, as section 1 predicts.

## 2. Claim 2, the first-order term

`f'(0) = 2 Σ_{il} A_{il} Q_{il} (QΩ)_{il} = 2⟨A∘Q, QΩ⟩ = 2 tr((A∘Q)ᵀQΩ) = 2 tr(SᵀΩ) = 2 tr(ΩᵀS)`.

**`tr(ΩᵀS) = ⟨Ω, S⟩` in the Frobenius pairing, and a fixed matrix pairs to zero against every skew matrix exactly when its skew part vanishes**, which is `S = Sᵀ`. This is [first_order_antisymm](../lean/HamiltonsCubic/Results/I106bFace.lean)'s reading and agrees index for index with [r1034](REVIEW_r1034.md)'s independent derivation of the same step. **CONFIRMED.**

**One wording correction.** The commit message, the note and the Lean docstring all say that `S` symmetric "is [asym_factor](../lean/HamiltonsCubic/Results/I106bFace.lean)'s hypothesis". [asym_factor](../lean/HamiltonsCubic/Results/I106bFace.lean) is an unconditional identity with no hypothesis on `Q` at all: it computes the antisymmetric part of `S` and factors it. The condition is the VANISHING of that identity's left-hand side. Say "which is what [asym_factor](../lean/HamiltonsCubic/Results/I106bFace.lean) factors" and the sentence is right.

## 3. Claim 3, the lemma and the sign

**[skew_sq_eq_neg_gram](../lean/HamiltonsCubic/Results/I106bFace.lean) is correct**: `ΩᵀΩ = (−Ω)Ω = −Ω²`, so `Ω² = −ΩᵀΩ`. The Lean proof is right as a rewriting: `rw [hOm]` turns the goal into `Om*Om = -((-Om)*Om)`, `Matrix.neg_mul` turns the inner product into `-(Om*Om)`, and `neg_neg` closes it by `rfl`. No hypothesis beyond skewness is used, and none is needed.

**The direction of the inequality is the one a MAXIMUM requires.** Substituting the lemma,

```
½f''(0) = ⟨A, (QΩ)∘(QΩ)⟩ − tr(S ΩᵀΩ).
```

At a local maximum `f''(0) ≤ 0` along every curve, so the necessary condition is `⟨A,(QΩ)∘(QΩ)⟩ ≤ tr(S ΩᵀΩ)`. [SecondOrderMax](../lean/HamiltonsCubic/Results/I106bFace.lean) reads

```
∀ Om, Omᵀ = -Om → value A ((Q * Om) ⊙ (Q * Om)) ≤ (Qᵀ * (A ⊙ Q) * (Omᵀ * Om)).trace
```

and with [value](../lean/HamiltonsCubic/Results/I106bFace.lean) `A R = (Aᵀ * R).trace = Σ_{ij} A_ij R_ij`, the left side is `⟨A,(QΩ)∘(QΩ)⟩` and the right side is `tr(S ΩᵀΩ)`. **That is the maximum condition, term for term. A minimum would require the reverse inequality, and the predicate does not state it.** CONFIRMED.

**Two limits on what the predicate says, neither a defect and both worth naming.** It is the NON-STRICT second-order necessary condition, so it is satisfied at degenerate points that are not maxima, and satisfying it is not sufficient for local maximality. And it is a predicate rather than a theorem: nothing in the file derives it from maximality, because the layer has no differential structure on `O(k)`. The docstring says both, in those words.

## 4. Claim 4, the numbers recomputed

**Built from [r1043](REVIEW_r1043.md)'s published `β, ν, u, c, Q` in code written here**, `A_{ik} = u_i(βν_k²) + c_iν_k` as [asym_factor](../lean/HamiltonsCubic/Results/I106bFace.lean) writes it, `f = Σ A_{ik}Q_{ik}²`, and `½f''(0)` maximised over the ten `E_{ab} = e_ae_bᵀ − e_be_aᵀ`. The witness reproduces orthogonal to `1.1e−16`.

| point | value | `max_S − S^T` | `max ½f''(0)` over the ten | at |
|---|---|---|---|---|
| [r1043](REVIEW_r1043.md)'s `k = 5` witness | `0.3828` | `4.2e−17` | **`+0.1099`** | `E_{02}` |
| global permutation maximiser `(0,4,3,2,1)` | `1.4688` | `0` | `−0.2277` | `E_{13}` |
| best zero-diagonal permutation `(4,0,3,2,1)` | `1.2093` | `0` | `+0.2595` | `E_{04}` |

**All three numbers, all three values and the identification of the two permutations reproduce exactly.** The global maximiser over all `120` permutations is `(0,4,3,2,1)` and the best derangement is `(4,0,3,2,1)`, as recorded. The note's `5.6e−17` for the asymmetry of `S` at the witness is `4.2e−17` here, which is the same statement at a different norm or rounding and is not a discrepancy.

**The `−0.841833` finite-difference number is traceable.** It is `½f''(0)` along `E_{01}` at the global permutation maximiser, `−0.8418` here. Recording the direction would let a successor replay it without searching.

## 5. Claim 5, the exclusion, and what the screen does and does not add

**The literal claim is CONFIRMED.** `½f''(0) = +0.1099 > 0` in a genuine tangent direction at a point where `S` is symmetric to `4.2e−17`, so the witness is a critical point that fails [SecondOrderMax](../lean/HamiltonsCubic/Results/I106bFace.lean) and is not a local maximum. One positive direction suffices for that, so restricting to ten generators costs the POSITIVE rows nothing.

**Correction 1: the screen understates the witness's second variation, and the note should not be read as reporting a maximum over directions.** The quadratic form at the witness is NOT diagonal in the elementary basis: its largest off-diagonal entry is `0.373`, and its top eigenvalue is `+0.4915`, attained at a combination of generators and more than four times the reported `+0.1099`. **`+0.1099` is a lower bound on `max ½f''(0)` over unit-norm skew directions, not that maximum.** Nothing in the conclusion changes, and the number should be labelled for what it is.

**Correction 2: the NEGATIVE row survives the same objection, for a reason the note does not give, and that reason is the review's main derivation.** At a permutation matrix `P` with `P_{iσ(i)} = 1`, write `(PΩ)_{il} = Ω_{σ(i)l}` and note `S = Pᵀ(A∘P)` is diagonal with `S_{ll} = A_{σ⁻¹(l),l}`. Then

```
⟨A,(PΩ)∘(PΩ)⟩ = Σ_{a,l} A_{σ⁻¹(a),l} Ω_{al}²,    tr(SΩ²) = − Σ_{l,m} A_{σ⁻¹(l),l} Ω_{ml}²,
```

both of which are weighted sums of the SQUARES of individual entries of `Ω`. **So the second variation at a permutation is diagonal in the elementary basis**, and collecting `Ω_{ab}² = Ω_{ba}²`,

```
½f''(0)[E_ab] = ( A_{σ⁻¹(a),b} + A_{σ⁻¹(b),a} ) − ( A_{σ⁻¹(a),a} + A_{σ⁻¹(b),b} ),
```

**which is exactly the change in the assignment value `Σ_i A_{i,σ(i)}` when the images of rows `σ⁻¹(a)` and `σ⁻¹(b)` are transposed.** Verified to `0.0` absolute error over all ten pairs at twenty-two permutations, the two in the table and twenty random ones. Off-diagonal mass of the form at the permutation is `2.2e−16`. **Consequences**: the ten numbers at a permutation ARE the full spectrum, so `−0.2277` certifies a strict local maximum rather than merely failing to refute one, and [SecondOrderMax](../lean/HamiltonsCubic/Results/I106bFace.lean) at a permutation IS 2-opt optimality for the linear assignment problem on `A`. The control is therefore sound, and the brief's worry about basis-only maximisation in the negative cases is answered rather than merely not triggered.

**Correction 3, the one the brief expects: the screen shows strictly more than the value comparison, and the extra is worth less than the note implies.**

- *The value comparison* `0.3828` against `1.4688` shows the witness is not the GLOBAL maximum. [r1043](REVIEW_r1043.md) already recorded it, in those numbers.
- *The screen* shows the witness is not a LOCAL maximum. That is a strictly stronger fact and is unobtainable from the values, so the screen is not redundant.
- *What it is worth.* [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) hypothesises GLOBAL maximality, so for that theorem the value comparison is already sufficient and the local fact is surplus. The extra fact pays only under a route of the form "criticality plus a second-order condition implies signed permutation", and what it establishes there is one non-falsification at one `(β,ν,u,c)`. **"Which is what makes the route worth attempting rather than a hope" overstates that.** A single witness surviving a strengthened hypothesis is the weakest possible positive evidence for a route, and the note's own "What this is NOT" paragraph says so two lines later, which leaves the section carrying both readings.

**A fourth point, on the third row, which is correct and shallower than the framing suggests.** The claim that at this `A` the hypotheses of [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) are jointly unmet is TRUE, and it is provable rather than merely screened: `Q∘Q` for a zero-diagonal orthogonal `Q` lies in the face of the Birkhoff polytope cut out by `M_ii = 0`, whose vertices are the derangement permutation matrices, so every zero-diagonal orthogonal `Q` has `f(Q) ≤ 1.2093 < 1.4688`. **Record that argument rather than the screen, since it settles the question at this `A` outright.** And the `+0.2595` at the best derangement has a one-line explanation from correction 2: `1.2093 + 0.2595 = 1.4688` exactly, so the single improving transposition carries `(4,0,3,2,1)` to `(0,4,3,2,1)`, which is the global maximiser. The row is a restatement of the value comparison rather than an independent finding.

## 6. Claim 6, what r1034 refuted and whether the premise is gone

**What [r1034](REVIEW_r1034.md) refuted, exactly.** Its claim 5 CONFIRMS that the face is not critical-point-free, and separately REFUTES the sentence carried beside that finding: *"the theorem now needs the second-order condition to do the whole separation"*. The ground it gives is a surviving first-order route, stated as *every zero-diagonal critical point of `f` is a signed permutation matrix*, together with the observation that this implies [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) at once with `P = Q`, since a permutation matrix satisfies the file's own `Splits`.

**That ground is gone, and the parent is right about it.** [r1043](REVIEW_r1043.md) exhibits a `k = 5` zero-diagonal critical point that is not a signed permutation, which is the negation of the statement r1034 offered. So the premise of r1034's claim-5 refutation has indeed failed. **PLAUSIBLE, narrowly, and I have no correction to make to it as a statement about r1034's ground.**

**What does NOT follow, and it is the inference both commits are built on.** Losing the premise of a refutation does not restore the refuted sentence, and the refuted sentence is still false, now for a stronger reason than r1034 had.

- **[face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) was proved eighteen minutes later, in `f83e3c8e`, from Birkhoff-von Neumann alone**, with `hzero` renamed `_hzero` because it is never used. That proof uses neither first-order nor second-order information. So "the second-order condition must do the whole separation" is false a second time, independently of whether any first-order route survives.
- **The note already said so, in the file the new section was appended to.** Its 2026-09-17 block carries, verbatim: *"once the commutator vanishes the rung needs no face argument, no tangency exclusion and no second-order condition, only Birkhoff"*, and *"Any effort spent on the face, on the coupled convex hull, or on transporting batch 21 is spent on a problem that `[Û,C] = 0` dissolves."*
- **The authority the new section cites for "live" is the note's SUPERSEDED status table.** The row *"The second-order condition, and whether it is batch 21 transported | open, and the first thing to attempt"* sits above that block, in the 2026-09-17 material the block revises. Citing it as *"which the working note already listed as open, the first thing to attempt"* reads the earlier status past the later one.

**So claim 6's sentence is defensible and the conclusion it is used to draw, that the second-order condition is the item's live content, is not.** That conclusion is now contradicted by the record's own HEAD.

## 7. The process point, on the mis-designed first control

**The correction is right, and for the right reason.** The first control tested the best DERANGEMENT. A derangement is not in general a maximiser, and [SecondOrderMax](../lean/HamiltonsCubic/Results/I106bFace.lean) is a necessary condition at maxima only, so a derangement failing it is not evidence against the formula. Here the best derangement fails it by `+0.2595` and correction 2 above says exactly why. **The replacement control, the global permutation maximiser, is the right object**: by Birkhoff the maximum of `f` over `O(k)` equals the maximum over permutation matrices, so `(0,4,3,2,1)` is the GLOBAL maximiser over `O(5)` and `½f''(0) ≤ 0` there is forced. A control that must pass if the formula is right, and that fails if a sign is wrong, is what a control is for. The note's account of why the first version "could never have passed" is accurate.

**The episode's description is inaccurate in one particular.** The note says the failure *"was reported HERE before being corrected"*. The note never carried it. `5cc2ec98` added the whole 2026-09-21 section in one commit, already containing the corrected table, and the note's only trace of the first control is the retrospective sentence itself. The commit message's own phrasing, *"Recorded in the note rather than quietly dropped"*, is the accurate one. **Replace "reported here before being corrected" with "reported in the session before being corrected, and recorded here".** The distinction matters because the file's neighbouring confession, the screen bug at 2026-09-17 that printed `6.089` under the words "0 expected", IS a case where a failing output reached the record, and the two should not read as the same kind of event.

## 8. Overreach sweep

**Each quotation below is one the declarations and the record do not carry.**

1. **[I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean), the section heading**: *"The SECOND-ORDER condition, which is what the item needs above `k = 4`"*, and in its body *"so the refutation's premise is gone and the second-order condition is the item's open content"*. **Stale at HEAD and contested when written.** [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) is proved without it, and the note's own later block says the rung needs no second-order condition. The heading should say what the declaration IS, for instance "the second-order necessary condition at a maximum, stated", and the "live content" sentence should go.
2. **[plan.md](../plan.md), the I106b row at HEAD, is internally inconsistent.** The same row now opens *"the COMMUTING CASE IS CLOSED and what remains is the COUPLED PAIR"* and reports [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean) proved, then states **"Owed**: the second-order condition, which is now the item's live content". Those cannot both hold. What is owed by that row's own headline is the coupled pair, which is `[Û,C] = 0`.
3. **[plan.md](../plan.md) and the note**: *"`face_hands_down` is untouched by the refutation"*. True and now dead text, the theorem being proved.
4. **The note and the commit message**: *"which is `asym_factor`'s hypothesis"*. [asym_factor](../lean/HamiltonsCubic/Results/I106bFace.lean) has no such hypothesis. Section 2.
5. **The note**: *"a local maximum, as required"* for the `−0.2277` row. TRUE, and not established by the ten numbers as the note presents them. It is established either by correction 2's diagonality, or independently by Birkhoff, and the note gives neither. One clause fixes it.
6. **The note**: *"which is what makes the route worth attempting rather than a hope"*. Section 5, correction 3.
7. **The note**: *"A first control was mis-designed and its failure was reported HERE"*. Section 7.

**What the sweep leaves standing.** The derivation itself, every number in the table, the identification of the two permutations, the symmetry of `S` at the witness, the statement that one witness at one `(β,ν,u,c)` constrains nothing positively, the `Deliverable: none` trailer on the screening commit, and the observation that [face_hands_down](../lean/HamiltonsCubic/Results/I106bFace.lean)'s hypotheses are jointly unmet at this `A`. The trailer choice in particular is right: the screen disproves no recorded claim, and calling it `none` is the honest reading.

## 9. What to do

1. **Rewrite the Lean section heading and its first paragraph** to state the necessary condition and drop "what the item needs" and "the item's open content". Item 1 of the sweep.
2. **Repair the [plan.md](../plan.md) row's Owed clause** so it names the coupled pair, and move the second-order derivation into the row's history rather than its obligations. Item 2.
3. **Record the permutation closed form** `½f''(0)[E_ab] = (A_{σ⁻¹(a),b} + A_{σ⁻¹(b),a}) − (A_{σ⁻¹(a),a} + A_{σ⁻¹(b),b})`, which is a derivation and typeable in the current layer: it says [SecondOrderMax](../lean/HamiltonsCubic/Results/I106bFace.lean) at a permutation is 2-opt optimality for the assignment problem on `A`, and it is what makes the note's negative row complete.
4. **Replace the third row's screen with the Birkhoff-face argument**, section 5, which settles at this `A` that no zero-diagonal orthogonal `Q` is a global maximiser, rather than reporting one number about one derangement.
5. **Label `+0.1099` as a lower bound** on the second variation's maximum over directions, and record `E_{01}` at the permutation as the direction the `−0.841833` finite-difference check used.
6. **Correct the two wordings**, "asym_factor's hypothesis" and "reported here before being corrected".

## 10. How the analysis-only rule was honoured

**No sweep, no census, no optimisation of unknown cost, no unbounded falsifier hunt.** The positive content of this review is analytical: the two differentiations of section 1, the symmetry of `Ω²` that collapses the brief's `tr(SΩ²)` versus `tr(SᵀΩ²)` question, the sign argument of section 3, the permutation closed form of section 5, and the Birkhoff-face bound `1.2093` there. Every one is a derivation and none rests on a number.

**Three runs, each priced before it started and each finishing in under two seconds on objects already in hand.**

- Fourth-order central differences at three random `(A,Q)` at `k = 5`, to screen the formula I had derived. A fixed three trials, reported as a screen.
- The three table points of [r1043](REVIEW_r1043.md)'s witness, evaluated on the ten elementary generators, plus the `10 × 10` Gram matrix of the second variation at each. Fixed size, no search.
- An enumeration of the `120` permutations of `Fin 5` at one fixed `A`, to reproduce the global maximiser and the best derangement. **This is a complete enumeration of a set of fixed, known size at a single parameter point, which is "solve the system in hand" rather than a census of a family**, and it reproduces two numbers the parent published rather than producing a new claim.
- A verification of the permutation closed form at twenty-two permutations, screening an identity I had already proved. It returned `0.0`, and the proof is what the finding rests on.

**No Lean was compiled.** Nothing in this review needed a build, the verdicts on [skew_sq_eq_neg_gram](../lean/HamiltonsCubic/Results/I106bFace.lean) and [SecondOrderMax](../lean/HamiltonsCubic/Results/I106bFace.lean) being statements about what the source says and about the rewriting steps, both readable from the file.
