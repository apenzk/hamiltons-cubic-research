# REVIEW r790, Gate 2, formalisation fidelity of the six typed Lean statements

Reviewer r790, on the cold brief [BRIEF-g2-leanstmt.md](BRIEF-g2-leanstmt.md), covering L176, L177, L178, L179, L180 and L182. I read the brief in full, then the record's own words for each lemma in [diagonal-half.md](../findings/diagonal-half.md) and [second-order.md](../findings/second-order.md), then the six files on disk under [lean/HamiltonsCubic/Results/](../lean/HamiltonsCubic/Results/) together with the base layer they import, [QPGeneral.lean](../lean/HamiltonsCubic/Base/QPGeneral.lean), [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean), [Bivectors.lean](../lean/HamiltonsCubic/Base/Bivectors.lean). I ran `lake build` on the six modules once, which the brief permits as reading the artefact; it completed successfully with five `sorry` warnings and no errors. I ran no other computation: every claim below is settled by reading the definitions, and the one falsifying witness I give is a two-vertex graph I checked by hand. My log is [agent_logs/g2-leanstmt-r790.log](../agent_logs/g2-leanstmt-r790.log).

## Claim table

| Lemma | Question | Verdict | One line |
|---|---|---|---|
| L176 | Q1 same thing | FAITHFUL | Both halves of the record's conclusion are present, degree in `card_nbr_zero_or_two_le`, four edges in `four_le_card_edges`. |
| L176 | Q2 strengthened/weakened | NEITHER | `IsSectional` + `K ≠ 0` is exactly what the record's proof consumes. |
| L176 | Q3 definitions | FAITHFUL, WITH AN UNFORMALISED BRIDGE | `IsSectional`, `nbr`, `edges` transcribe the record; the identification of `(edges K).card` with the `Λ²`-rank is prose only. |
| L176 | Q4 the sorry | HONEST, INCOMPLETE | The docstring names the handshake count and the triangle exclusion and omits the `K ≠ 0 ⟹ E ≠ ∅` step. |
| L176 | Q5 proved theorems | STEPS | All five are steps of the argument, not arithmetic about it, the only file of the six where this is true throughout. |
| L176 | Q6 outright proof claim | N/A | No part of L176 is claimed proved outright. |
| L176 | Q7 boundary | VACUOUS AND CORRECT | At `n ≤ 3` the hypotheses are unsatisfiable, so the statement is vacuous rather than wrong. |
| L177 | Q1 same thing | REFUTED | The typed conclusion is false at a two-vertex single-edge graph, with all hypotheses satisfied. |
| L177 | Q2 strengthened/weakened | STRENGTHENED TO FALSITY | Natural subtraction turns `&#124;E&#124; - &#124;V&#124; + b` into `b` whenever `&#124;E&#124; < &#124;V&#124;`. |
| L177 | Q3 definitions | UNFAITHFUL | `incidence` admits loops, which the record names as a required and previously unstated hypothesis; `b` is a free natural number, never the count of bipartite components. |
| L177 | Q4 the sorry | MISDESCRIBED | The docstring says the missing piece is Zaslavsky's rank theorem, which is the hypothesis `hrank`; what the `sorry` actually hides is a false goal. |
| L177 | Q5 proved theorems | ARITHMETIC | Three of four are `(1:ℝ) + -1 = 0`, `x = -x → x = 0` and a `ring` identity over `ℤ`, dressed in graph-theoretic docstrings. |
| L177 | Q6 outright proof claim | N/A | Nothing claimed proved. |
| L177 | Q7 boundary | BROKEN | The empty edge set on one vertex already gives `0 = 1`. |
| L178 | Q1 same thing | PARTIAL | The inequality half is proved; the equality clause (half the record's statement), is asserted in a docstring and never typed. |
| L178 | Q2 strengthened/weakened | STRENGTHENED, CORRECTLY | `P² ≤ 3/2` is the sign-closed form the record endorses, and is stronger than `θ ≤ √(3/2)`. |
| L178 | Q3 definitions | NO DEFINITIONS, LARGE QUOTED CHAIN | Steps 1 to 4 (self-duality, `γ² = 2`, padding invariance, `θ = 9e₃`), are all outside the file. |
| L178 | Q4 the sorry | NO SORRY, AND THAT IS THE PROBLEM | The unproved equality clause carries no marker at all, so nothing signals it. |
| L178 | Q5 proved theorems | MIXED | `e3_sq_le`, `p3_eq`, `e2_eq` are genuine steps; `constant_exact` is a numeral. |
| L178 | Q6 outright proof claim | OVERSTATED | What is proved outright is the polynomial core, not the record's conclusion about Weyl tensors. |
| L178 | Q7 boundary | SOUND | `h2` excludes the zero spectrum; the hypotheses are satisfiable and the bound is attained. |
| L179 | Q1 same thing | REFUTED FOR (a) AND (b) | Neither typed statement is the record's part; (b) forces the operator to be zero, (a) states a diagonal identity and never mentions support. |
| L179 | Q2 strengthened/weakened | WEAKENED TO VACUITY | `Fin 1` plus `lam 0 = 0` leaves no spectrum for "the nonzero spectrum" to be about. |
| L179 | Q3 definitions | FAITHFUL BUT UNCONNECTED | `rankOne`, `inner2`, `phi`, `normSqBiv` are sound; `traceOp` exists and is used nowhere, so "traceless" is never the trace. |
| L179 | Q4 the sorries | DISHONEST | Both docstrings name deep missing ingredients; both goals follow from the stated hypotheses in a line. |
| L179 | Q5 proved theorems | ARITHMETIC | `rankOne_of_traceless` is `mul_eq_zero`; `inner2_rankOne'` is a genuine step, imported from the base layer. |
| L179 | Q6 outright proof claim | OVERSTATED | "Part (c) is proved" names a proof of `a·b = 0, b ≠ 0 ⟹ a = 0`. |
| L179 | Q7 boundary | DEGENERATE BY CONSTRUCTION | The `Fin 1` index and `lam 0 = 0` place both statements permanently at the boundary. |
| L180 | Q1 same thing | PARTIAL, FAITHFUL AS FAR AS IT GOES | Parts (1) and (2) are typed and proved; part (3), the support statement, is neither typed nor mentioned. |
| L180 | Q2 strengthened/weakened | STRENGTHENED | Skewness, orthonormality, `λᵢ ≠ 0` and `W ≠ 0` are all dropped, so the theorems are true of arbitrary matrices. |
| L180 | Q3 definitions | FAITHFUL | `ricci` is exactly the record's `Σ_b W_abcb`, index for index. |
| L180 | Q4 the sorry | NONE | Correct: the file carries no `sorry` and claims none. |
| L180 | Q5 proved theorems | STEPS | `ricci_eq_sum_mul_transpose` and `sum_lam_eq_zero` are the record's own two moves. |
| L180 | Q6 outright proof claim | CORRECT, WITH A GAP IN WHAT IT MEANS | Both proofs are valid; `Σ λᵢ` is called tracelessness while nothing links it to a trace, orthonormality being absent. |
| L180 | Q7 boundary | VACUOUS AND CORRECT | `r = 0` and `n = 0` give `True ↔ True` and `0 = 0`. |
| L182 | Q1 same thing | OVERREACHED | The record's evenness restriction and its `> 0.5923` floor are both absent, and `n` is a real. |
| L182 | Q2 strengthened/weakened | STRENGTHENED BEYOND THE CITED INPUTS | The typed range includes odd `n` and non-integers, which the record explicitly declines to cover. |
| L182 | Q3 definitions | FAITHFUL, EVERY ONE | `theta0sq`, `theta0`, `lam`, `cp`, `rhoEff`, `w0`, `s0`, `Cn`, `beta`, `F`, `lamInf` all match L162's formulas symbol for symbol. |
| L182 | Q4 the sorry | HONEST ABOUT ITS INPUTS, SILENT ABOUT THEIR RANGE | It names `λ` decreasing and `F(n) ≥ F(12)` and does not say the second is on file for even `n` alone. |
| L182 | Q5 proved theorems | ARITHMETIC | `theta0sq_eq` touches a definition; `deriv_in_u_neg` and `product_bound` are `linarith` and `nlinarith` on free variables. |
| L182 | Q6 outright proof claim | N/A | Nothing claimed proved. |
| L182 | Q7 boundary | UNGUARDED | `lam` is total and returns `2/0 = 0` below the crossover; `hn : 12 ≤ n` keeps it out of that region, so no harm follows, but nothing in the file records the domain. |

**One-line actionable summary.** [L177Statement.lean](../lean/HamiltonsCubic/Results/L177Statement.lean) states a goal that is false at a two-vertex graph and can never be closed; [L179Statement.lean](../lean/HamiltonsCubic/Results/L179Statement.lean)'s parts (a) and (b) are not the record's parts (a) and (b); L178's equality clause and L180's part (3) are missing with no marker; L182 asserts over a range the record refuses.

## Hypothesis inventory

| Lemma | In the record, absent from Lean | In Lean, absent from the record |
|---|---|---|
| L176 | Orthonormality of the frame; `W` a Weyl tensor; the `Λ²` action and its rank | Nothing, `IsSectional` is the record's own three conditions |
| L177 | Looplessness of `G`; `b` being the count of bipartite components; `E` a set of unordered pairs, so no parallel edges; the identification of the locus with `ker N` | `hrank`, which assumes the classical rank theorem the record quotes; `ends : E → V × V`, an ordered endpoint pair with no distinctness condition |
| L178 | `W ∈ 𝒲ₙ` nonzero; support on a four-dimensional `V`; `Λ²`-rank at most three; the whole chain from those to `θ = 9e₃`; the equality clause | `h1` and `h2`, which are the outputs of that chain rather than its inputs |
| L179 | Real coefficients; a spectrum of size `r`; `λ_α ≠ 0` on the part carrying the identity; the wedge and `Λ⁴`; the span `V` and the claim of support on `Λ²V` | `lam 0 = 0` in (b), which forces the operator to vanish; `hW : IsWeylOf R` in (a), which the typed conclusion never uses; the index type `Fin 1`; the field `ℚ` |
| L180 | `W ≠ 0`; `ωᵢ` orthonormal; every `λᵢ ≠ 0`; skewness of `ωᵢ`; part (3) entirely | `hnorm : trace = 2` as a hypothesis rather than a consequence of unit norm |
| L182 | `n` even; `n` an integer; the floor `> 0.5923`; `λ`'s domain above the crossover | `n : ℝ`, which admits odd integers and non-integers alike |

---

## 1. L176, faithful, and the only file whose proved content is all lemma content

The record's L176 states two conclusions: every vertex has degree `0` or degree at least `2`, and the graph has at least four edges. Both are in the file. The degree half is [card_nbr_zero_or_two_le](../lean/HamiltonsCubic/Results/L176Statement.lean), proved; the edge half is [four_le_card_edges](../lean/HamiltonsCubic/Results/L176Statement.lean), stated with a `sorry`. The record adds *"only the edge bound is equivalent to the rank bound; the degree statement is strictly more than it"*, and the file's split respects exactly that reading.

`IsSectional` carries `symm`, `hollow` and `rowsum`. The record's proof says of the locus that it is *"hollow symmetric with vanishing row sums ... which is the whole of what the proof uses"*. The structure is that sentence, and no more. `nbr K a` filters row `a` for nonzero entries; `edges K` filters ordered pairs `p.1 < p.2` with a nonzero entry, which is the record's edge set counted once each. Both are right.

**The bridge is unformalised and the frame hypothesis is discharged by fiat.** The record's first proof line is that `W` acts on `Λ²` with eigenvalues `K_ab`, so `rank W = |E(G)|`, and it flags orthonormality of the frame as load-bearing precisely because that is what makes the `Λ²` action orthogonal. The Lean file replaces this with a docstring assertion (*"the `Λ²`-rank is the number of nonzero entries above the diagonal"*) and then never mentions `Λ²` again. The statement typed is therefore the matrix half of the lemma, with the geometric half assumed. The docstring is candid that the file is about matrices; it is not candid that the reduction is a step of the record's proof rather than a background fact.

**What the sorry covers.** `card_edges_ne_one` disposes of `|E| = 1`. What remains is `|E| = 0` (excluded by `K ≠ 0` through hollowness and symmetry), `|E| = 2` (the handshake count) and `|E| = 3` (the triangle). The docstring names the last two and omits the first. Small, and worth fixing when the proof lands.

**Boundary.** At `n = 0` and `n = 1` the type `Matrix (Fin n) (Fin n) ℝ` and hollowness force `K = 0`, so `hne` is unsatisfiable and the theorem is vacuous. At `n = 2` and `n = 3` the record's own argument shows the hypotheses are jointly unsatisfiable, so again vacuous. Nothing degenerates wrongly.

**What would break it.** A coordinate-diagonal Weyl tensor in a non-orthonormal frame whose sectional matrix is hollow, symmetric and row-sum-zero while its `Λ²`-rank differs from the edge count. The Lean statement cannot see such an object, because neither the frame nor the `Λ²` action appears in it, which is the precise sense in which the Lean statement and the record's statement are different claims.

## 2. L177, the typed statement is false, and a two-vertex graph shows it

`finrank_ker_incidence` concludes

```
Module.finrank ℝ (LinearMap.ker (Matrix.mulVecLin (incidence ends)))
  = Fintype.card E - Fintype.card V + b
```

with everything on the right a natural number. Lean parses this as `(card E - card V) + b`, and natural subtraction truncates at zero. The record's formula `|E| - |V| + b(G)` is an integer identity, and it is exactly when `|E| < |V|` (every forest, every graph sparser than its vertex count) that the two disagree.

**The witness.** Take `V = Fin 2`, `E = Fin 1`, `ends _ = (0, 1)`: one edge joining two vertices. The graph is connected and bipartite, so `b = 1` and `rank N = |V| - b = 1`, satisfying `hrank`. The matrix is the all-ones `2 × 1` matrix, whose kernel is `{x : x 0 = 0} = 0`, so the left-hand side is `0`. The right-hand side is `1 - 2 + 1 = 0 + 1 = 1`. The goal is `0 = 1`. Every hypothesis is met, so the `sorry` guards a goal no proof can close.

The empty case breaks it identically: `V = Fin 1`, `E` empty, `b = 1`, `rank N = 0 = 1 - 1`; the kernel of a map out of the zero space has dimension `0`, and the right-hand side reads `(0 - 1) + 1 = 1`.

There is an irony in the file that makes the defect hard to miss once seen: [dim_ker_eq](../lean/HamiltonsCubic/Results/L177Statement.lean) states the very identity `nE - (nV - b) = nE - nV + b` **over `ℤ`**, where it holds, immediately above the theorem that needs it over `ℕ`, where it does not.

**`incidence` is not the record's `N`.** `ends : E → V × V` is an ordered pair with no distinctness requirement, so `ends e = (v, v)` is a legal loop and contributes `1` rather than `2` to its vertex's row. The record names looplessness explicitly as one of *"two hypotheses ... used throughout and were unstated"*, alongside characteristic `≠ 2`. The second is honoured, `ℝ` supplying it; the first is dropped. Parallel edges are likewise admitted where the record's `E` is a set of pairs.

**`b` is not `b(G)`.** It is a bare natural number, constrained only through `hrank`. So the graph theory of L177 (that the left kernel is spanned by one sign vector per bipartite component), has no Lean counterpart at all, and cannot be got wrong because it is not there.

**What the sorry covers, against what the docstring says.** The docstring says the proof *"needs `rank N = |V| - b(G)`, which is classical ... and is quoted rather than derived"*. But that is the hypothesis `hrank`. What the `sorry` actually stands in for is rank–nullity, which Mathlib has, plus an arithmetic step that is false. The description inverts the situation: it names as missing the thing that is assumed, and stays silent about the thing that cannot be supplied.

**Parts (2) and (3), and the missing half of (1).** The docstring heads the theorem *"L177(1). The tensors supported inside `G` are exactly `ker N`, of dimension ..."*. The typed statement contains no tensor, no locus and no "exactly", only the dimension. The identification of the coordinate-diagonal locus with `ker N`, which is the mathematical content of part (1), is unstated. Parts (2) and (3) are absent, which the docstring's "L177(1)" label discloses honestly.

**Proved theorems.** `mulVec_apply_eq` is thin but real: it exhibits the mulVec entry as the vertex sum. `bipartite_sign_kills_edge` is `(1 : ℝ) + -1 = 0`. `odd_walk_forces_zero` is `x = -x → x = 0`. `dim_ker_eq` is `ring` over `ℤ`. Three of the four are facts about arithmetic wearing graph-theoretic docstrings, *"a bipartite component's sign vector annihilates every edge"* is the title of a `norm_num` on two numerals. This is the layer-blurring the brief describes, in its purest form.

## 3. L178, the polynomial core is genuinely proved; the record's statement is not

`e3_sq_le` is real mathematics and it is correct: `a + b + c = 0` and `a² + b² + c² = 1` give `ab = (a+b)² - 1/2`, and the certificate `(u - 1/6)²(2/3 - u) ≥ 0` at `u = (a+b)²` closes `(abc)² ≤ 1/54`. `p3_eq` is Newton at `e₁ = 0`, `e2_eq` is `e₂ = -1/2`; both are steps 4 and 5 of the record's proof. `P_sq_le` scales the first by `81`, and `81/54 = 3/2` exactly. Of the six files, this one carries the most mathematical content.

**The equality clause is absent, and nothing marks its absence.** The record's statement is *"`θ(W) ≤ √(3/2)`, **with equality exactly when `W` is `W_{ℂP²}` up to POSITIVE scale and an `O(n)` frame change**"*, and the record spends two further sentences fixing the frame group and the sign. Lean proves the inequality alone. The equality case appears in the docstring (*"the bound is attained precisely when `e₃² = 1/54`) which is the repeated-root case, `(2,-1,-1)/√6`, and is `ℂP²`"*, under a heading that reads **Proved**. Since the file carries no `sorry`, a reader has nothing to warn them that half the record's statement is prose. This is the failure mode the brief names: a statement that reads as verification and is not.

**The chain to `9e₃` is quoted, and it is long.** `(9(abc))² ≤ 3/2` is the record's conclusion only after step 1 (rank `≤ 3` forces one of `W^±` to vanish, consuming the first Bianchi identity), step 2 (`γ² = 2`, hence `⟨W, W#⟩ = 6e₃`), step 3 (padding invariance by total antisymmetry) and step 4 (`θ = 3e₃ + 6e₃`). None is in Lean. The record itself flags that step 2's licensing sentence *"was missing and is supplied by [r771](REVIEW_r771.md) at audit, so it is itself unaudited"*, so the typed statement's link to the lemma rests on a sentence the record marks unaudited. The hypotheses `h1` and `h2` are the outputs of that chain, not the record's hypotheses: the record assumes `W` nonzero, supported on a four-dimensional `V`, of `Λ²`-rank at most three, and none of those three appears.

**A small misstatement.** The docstring says *"the bound `θ ≤ √(3/2)` is `P² ≤ 3/2`"*. It is not: `P² ≤ 3/2` is `|P| ≤ √(3/2)`, strictly stronger, and the record draws that distinction itself when it says *"the sign-closed statement is `|θ| ≤ √(3/2)`"*. The stronger form is the right one to prove, so the defect is in the word "is", not in the choice.

**Boundary.** `h2` rules out the zero spectrum, so there is no degenerate case; the hypotheses are satisfiable at `(2,-1,-1)/√6` and the bound is attained there. Sound.

**What would break it.** For the inequality, nothing, it is true and proved. For the identification with the record's lemma: any rank-`≤3` Weyl tensor on a four-dimensional support for which `θ ≠ 9e₃`, i.e. any failure in the quoted chain, would leave `P_sq_le` true and L178 false. And `(2,-1,-1)/√6` itself is the object showing the equality clause is unproved: it satisfies both hypotheses with equality, and the Lean file records nothing about it.

## 4. L179, parts (a) and (b) are not the record's parts

**Part (b) forces the operator to vanish.** `bianchi_on_nonzero_spectrum` indexes the spectrum by `Fin 1` and hypothesises `hzero : lam 0 = 0`. With `hspec`, `R X = (lam 0 * inner2 (om 0) X) • om 0 = 0` for every `X`, so `R` is the zero map and `bianchiOf R i j k l = 0` follows by unfolding. The `sorry` guards a goal that closes in a line.

The record's part (b) says something else entirely: that first Bianchi is equivalent to `Σ_{λ_α ≠ 0} λ_α ω_α ∧ ω_α = 0` in `Λ⁴`, so that at rank `r` it is a condition on `r` terms. The Lean statement contains no wedge, no `Λ⁴`, no equivalence, and (at `Fin 1` with the sole eigenvalue zero), no nonzero spectrum for the claim to be about. The docstring says the proof *"needs the Bianchi obstruction identified as the map `S²Λ² → Λ⁴`"*. That is what would be needed for the record's part (b); it is not what the typed goal needs, which is `simp`.

**Part (a) states a diagonal identity, not a support claim.** `supported_on_span` concludes

```
∀ i j, inner2 (R (phi i j)) (phi i j) = ∑ k, lam k * (inner2 (om k) (phi i j)) ^ 2
```

which is `hspec` expanded by bilinearity of `inner2`, the base layer's own [inner2_rankOne](../lean/HamiltonsCubic/Base/QPGeneral.lean) summed over `k`. The record's part (a) says that `W` is supported on `Λ²V` for `V` the span of the supports of the image forms with nonzero eigenvalue. The typed conclusion mentions neither `V`, nor a span, nor a support, nor a vanishing of `W_{abcd}` off `V`. The hypothesis `hW : IsWeylOf R` is present and unused; the docstring asserts that the missing ingredient is *"the pair symmetry to carry the second index pair, which the base layer has only as a clause of `IsWeylOf`"*, but the typed goal needs no pair symmetry at all. Again the description belongs to the record's statement and not to the one typed.

**Part (c) is `mul_eq_zero`, and "traceless" is never a trace.** `rankOne_of_traceless` takes `htr : lam * normSqBiv om = 0` and `hnorm : normSqBiv om ≠ 0` and returns `lam = 0`. The `om` argument is inert (it occurs only inside `normSqBiv om`) so the theorem is a substitution instance of `rankOne_traceless_eq_zero` already sitting in [QPGeneral.lean](../lean/HamiltonsCubic/Base/QPGeneral.lean) with a bare rational in place of the norm. The record's part (c) is *"a rank-one self-adjoint `W = λ ω ⊗ ω` has `tr W = λ‖ω‖²`, which tracelessness forces to zero"*, and the load-bearing half of that is the first equation. The base layer defines `traceOp` for exactly this purpose; grepping the whole Lean tree finds `traceOp` at its definition and nowhere else. The identity `traceOp (rankOne lam om) = lam * normSqBiv om`, one `Finset.mul_sum` from `inner2_rankOne`, is not proved anywhere, so `htr` is an assumption about a quantity never shown to be the trace. "Part (c) is proved" therefore names a proof of `a·b = 0` with `b ≠ 0` giving `a = 0`.

**Field.** The whole L179 chain is over `ℚ`, where the record's Weyl tensors are real. For part (c) the arithmetic is field-agnostic, so nothing is wrong; but the statement as typed covers rational operators only, and that narrowing is nowhere recorded in the file. It is systemic to the base layer rather than a choice made here.

**Boundary.** `Fin 1` and `lam 0 = 0` are not boundary cases the statements survive, they are where the statements live. There is no non-degenerate instance of either.

**What would break it.** The zero operator. It satisfies every hypothesis of `bianchi_on_nonzero_spectrum` and carries no spectrum, so the theorem's title (the Bianchi identity carried by the nonzero spectrum alone), has no instance in its own statement. For part (a), a rank-one operator whose image form is non-decomposable, hence of four-dimensional support: the record's part (a) makes a claim about it, the Lean statement makes only the same diagonal identity it makes about every operator.

## 5. L180, parts (1) and (2) are correct; part (3) is not there and is not mentioned

`ricci lam om a c = ∑ i, lam i * ∑ b, om i a b * om i c b` is the record's `Σ_b W_abcb = Σ_i λ_i Σ_b (ω_i)_{ab} (ω_i)_{cb}`, index for index. `ricci_eq_sum_mul_transpose` is the record's own identity, `posSemidef_mul_transpose` is its Gram-matrix observation, `trace_mul_transpose` its `tr A = Σ_{a,b} ω_{ab}²`. `ricci_flat_iff` and `sum_lam_eq_zero` are proved and their proofs are sound. This is the most honest file of the six: it claims two parts, types two parts, proves two parts, and carries no `sorry`.

**Three things are silently dropped.**

- **Skewness.** The record's part (1) is *"Ricci-flatness is exactly `Σ_i λ_i ω_i² = 0`"*, equivalently `Σ λ_i A_i = 0` with `A_i = ω_i ω_iᵀ`. The equivalence is `ωᵀ = -ω`. `ricci_flat_iff` states only the `ωωᵀ` form and takes no skewness hypothesis, so the record's own formula (the one in `ω²`), is not what is proved. `mul_transpose_eq_neg_sq` supplies the missing step but is never applied. Concretely, at `om 0 = 1` and `lam 0 = 1` the two conditions differ in sign, so without skewness they are genuinely different claims.
- **Orthonormality, and hence the meaning of `Σ λᵢ`.** Part (2)'s docstring calls `∑ i, lam i = 0` tracelessness. That reading needs the `ωᵢ` to be an orthonormal eigenbasis, which is where `Σ λᵢ = tr W` comes from. Nothing in the file says so, and `hnorm` supplies only the individual traces. The record derives `tr A = 2` from `‖ω‖ = 1` under the half-trace convention that [Bivectors.lean](../lean/HamiltonsCubic/Base/Bivectors.lean) pins; the Lean file assumes the `2` instead of deriving it. Consistent with the record's convention, but assumed.
- **Part (3) entirely.** The record's third part, that at rank three the support `V` is the support of the minority-sign form, and `dim V` is even and at least four, is the lemma's substantive geometric content, the part that rests on Fillmore–Williams and on three steps the record says *"were unstated and are now named"*. The Lean file does not state it and its header does not mention that L180 has a third part. A reader of the file alone would conclude L180 is fully formalised.

Dropping `W ≠ 0` and `λᵢ ≠ 0` makes parts (1) and (2) more general and still true, so no error follows; but combined with the missing skewness it means the two theorems are about arbitrary square matrices rather than about spectral decompositions of Weyl tensors.

**Boundary.** `r = 0` gives `True ↔ True` in part (1) and `0 = 0` in part (2), with `hnorm` vacuous. `n = 0` is trivial. Both degenerate correctly.

**What would break it.** `r = 1`, `n = 2`, `om 0 = 1` the identity, `lam 0 = 1`: `ricci_flat_iff` holds, `Σ λᵢ ωᵢ ωᵢᵀ = 1 ≠ 0`, and `Σ λᵢ ωᵢ² = 1` too, the two conditions coincide here only by accident of the identity being symmetric. Take instead any non-skew `ω` with `ω² ≠ -ωωᵀ` and the record's condition and Lean's condition separate. That object shows the typed statement is not the record's part (1) without the skewness hypothesis.

## 6. L182, every constant transcribes correctly, and the statement asserts more than the record grants

I checked the constant chain against [L162](../findings/second-order.md) symbol by symbol, since the brief flags it as the place a transcription error would read as verification. It is clean:

| Record (L162 / L182) | Lean | Verdict |
|---|---|---|
| `θ₀(n)² = 2(n-1)(n-2)/n²` | `theta0sq n = 2 * (n - 1) * (n - 2) / n ^ 2` | matches |
| `c_p = 3θ₀/(n-2)` | `cp n = 3 * theta0 n / (n - 2)` | matches |
| `ρ^eff_n = √6 - θ₀(n+16)/(2(n-2))` | `rhoEff n = Real.sqrt 6 - theta0 n * (n + 16) / (2 * (n - 2))` | matches, including the precedence |
| `λ = 2/√(9(θ₀ - √(3/2)))` | `lam n = 2 / Real.sqrt (9 * (theta0 n - Real.sqrt (3 / 2)))` | matches |
| `C(n) = 2(2n-3)/(n-1)` | `Cn n = 2 * (2 * n - 3) / (n - 1)` | matches |
| `β = λ/(2C)` | `beta n = lam n / (2 * Cn n)` | matches |
| `w₀ = (n-4)/n` | `w0 n = (n - 4) / n` | matches |
| `s₀ = √(c_p + ρ^eff w₀²)` | `s0 n = Real.sqrt (cp n + rhoEff n * w0 n ^ 2)` | matches |
| `F(w₀) = 4s₀/(√(4βs₀+1)+1)²` | `F n = 4 * s0 n / (Real.sqrt (4 * beta n * s0 n + 1) + 1) ^ 2` | matches |
| `λ∞ = 2/√(9(√2 - √(3/2)))` | `lamInf = 2 / Real.sqrt (9 * (Real.sqrt 2 - Real.sqrt (3 / 2)))` | matches |

`theta0sq_eq` is also correct: `2(n-1)(n-2)/n² = 2(1 - 3/n + 2/n²)`.

**The evenness restriction is gone, and `n` is a real.** The record says *"at every even `n ≥ 12`"* and then goes out of its way to explain the restriction: *"odd `n ≥ 13` is inside `λ`'s domain and outside the `F` given, so it is unaddressed rather than excluded, **the parity restriction comes from `F` alone**"*. `lam_mul_F_gt (n : ℝ) (hn : 12 ≤ n)` quantifies over every real from `12` up: odd integers the record declines to address, and non-integers where `w₀ = (n-4)/n` has no derivation behind it, L158's minimiser being a statement about a dimension. This is a strengthening in the direction the brief warns about (assuming less and so claiming more) and the claim lies outside what the cited inputs supply. L162's second input is on file as *"`F(n) > F(12)` at every even `n ≥ 14`"*, so the `sorry` as typed cannot be discharged from the sources the docstring names, whatever the truth of the wider claim.

**The floor is gone.** The record's statement is a chain of two inequalities, `λ(n)F(n) > λ∞F(12) > 0.5923`, and the second is the one carrying the lemma's point, that branch 2's constant is bounded away from zero uniformly in `n`. Lean types only the first. As typed, `lamInf * F 12 < lam n * F n` would be satisfied even if `lamInf * F 12` were zero or negative, so the conclusion the lemma exists to draw is not stated. No numeral in the chain, `F(12) = 0.38673`, `λ∞ = 1.531581`, `0.5923`, is asserted anywhere in the file, so the record's own correction of `1.53157` to `1.53158` has no Lean counterpart to get right or wrong.

**The proved theorems are arithmetic, and one of them is presented as the argument it is not.** `deriv_in_u_neg {u : ℝ} (h : u < 3/4) : 2 * (-3 + 4*u) < 0` is `linarith` on a free real. Its docstring says *"so `θ₀²` increases in `n`, the reversal being the step a first draft compressed into 'so'"*. But the theorem mentions neither `theta0sq` nor `n`, and the reversal, `u = 1/n` decreasing in `n`, which the record singles out as *"the step to name ... a sign lost there is how such an argument usually fails"*, is precisely what is absent. Nothing in the file proves `theta0` monotone, `lam` decreasing, or `lam n > lamInf`. `product_bound` is a correct and genuinely relevant real-number lemma (`a < b`, `c ≤ d`, `0 < a`, `0 < c` gives `a·c < b·d`) but it is applied to nothing.

**Boundary and domain.** `lam` is a total function: below the crossover `6 + 2√7` the radicand is negative, `Real.sqrt` returns `0`, and `lam n = 2/0 = 0`, Lean's junk value, not the record's "the claim has no subject". `hn : 12 ≤ n` keeps every instance out of that region, so no false instance arises from it, but the docstring's *"defined where `θ₀(n) > √(3/2)`"* describes an intention the definition does not enforce. At `n = 12` the statement reads `lamInf * F 12 < lam 12 * F 12`, which is the record's own boundary case and needs `lam 12 > lamInf` and `F 12 > 0`; both hold.

**What would break it.** `n = 13`, or `n = 12.5`. Either satisfies `hn` and neither is in the record's range. They are the objects showing the Lean statement and the record's statement are not the same claim.

---

## Overall verdict

**UNSAFE TO READ AS VERIFICATION.** Three of the six files state something other than what the record states, and one of those three states something false.

- **[L177Statement.lean](../lean/HamiltonsCubic/Results/L177Statement.lean) is REFUTED.** Natural subtraction makes the goal false at a two-vertex single-edge graph with all hypotheses satisfied, so the `sorry` guards a goal no proof can close. Compounding it: `incidence` admits the loops the record names as a required hypothesis, `b` is never the count of bipartite components, the "exactly `ker N`" half of part (1) is unstated, and three of the four proved theorems are arithmetic identities with graph-theoretic titles. This is the worst row.
- **[L179Statement.lean](../lean/HamiltonsCubic/Results/L179Statement.lean) is MISFORMALISED.** Parts (a) and (b) as typed are not the record's parts (a) and (b): (b) forces the operator to be zero and (a) states a bilinearity expansion. Both `sorry`s guard one-line goals while their docstrings describe the deep ingredients the record's real statements would need. Part (c), advertised as proved, is `mul_eq_zero` with the trace link (`traceOp`, defined in the base layer and used nowhere in the tree), never established.
- **[L182Statement.lean](../lean/HamiltonsCubic/Results/L182Statement.lean) is OVERREACHED but its constants are CLEAN.** The full ten-symbol chain transcribes L162 faithfully, which is the thing the brief most feared and the thing that is right. Against that: the evenness and integrality of `n` are dropped, the `> 0.5923` floor that carries the lemma's meaning is not typed, and no numeral is checked.
- **[L178Statement.lean](../lean/HamiltonsCubic/Results/L178Statement.lean) is TRUNCATED.** The polynomial core is real mathematics, correctly proved. But the equality clause (half the record's statement, and its rigidity content), lives in a docstring under the word **Proved**, with no `sorry` anywhere to signal it, and the four-step chain from a rank-`≤3` Weyl tensor to `9e₃` is entirely outside the file. Calling this "the conclusion proved outright" overstates it.
- **[L180Statement.lean](../lean/HamiltonsCubic/Results/L180Statement.lean) is SOUND FOR WHAT IT CLAIMS.** Parts (1) and (2) are typed faithfully and proved validly. Part (3) is absent and its absence is unmentioned; skewness and orthonormality are dropped, so the `ω²` form of the record's part (1) and the meaning of `Σ λᵢ` as a trace are both outside the statement.
- **[L176Statement.lean](../lean/HamiltonsCubic/Results/L176Statement.lean) is FAITHFUL.** Both halves of the record's conclusion are present, the definitions are the record's own three conditions, the `sorry` is honestly scoped bar one omitted case, and every proved theorem is a step of the argument. It is the only file of the six where the last is true throughout, and it should be the model the others are held to.

The pattern across the six is not random error. In four of them the docstring describes the record's lemma while the theorem below states something smaller, and in three of those the gap is invisible from the Lean file alone, no `sorry` in L178 and L180, and in L179 `sorry`s that point at the wrong difficulty. The brief's worry that a wrong statement type-checks and reads as verification is met on four rows out of six.
