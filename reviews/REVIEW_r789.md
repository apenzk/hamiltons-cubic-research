# Gate 2, r789, formalisation fidelity of the six typed Lean statements (L176, L177, L178, L179, L180, L182)

*Reviewer r789, cold brief [BRIEF-g2-leanstmt.md](BRIEF-g2-leanstmt.md), relaunch after the previous pair died without filing. I read the six statement files on disk rather than trusting the brief's quotations (all six match byte for byte), together with the record blocks in [diagonal-half.md](../findings/diagonal-half.md) (L176–L180) and [second-order.md](../findings/second-order.md) (L162, L182), and the definitions the statements import from [QPGeneral.lean](../lean/HamiltonsCubic/Base/QPGeneral.lean), [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean) and [Bivectors.lean](../lean/HamiltonsCubic/Base/Bivectors.lean). I ran `lake build` from [lean/](../lean/) once (exit 0, 9012 jobs, four `sorry` warnings) and one `lake env lean` on a scratch file outside the repository, which the brief permits as reading the artefact. No sweep, no census, no search. Log: [agent_logs/g2-leanstmt-r789.log](../agent_logs/g2-leanstmt-r789.log).*

## Claim table

| Lemma | Q1 same claim? | Q2 strengthened / weakened | Q3 definitions | Q4 what the sorry covers | Q5 proved theorems | Q7 boundary |
|---|---|---|---|---|---|---|
| L176 | **PARTIAL** (degree half typed and proved, edge half typed, rank clause untyped | **NEITHER**), the matrix abstraction is exact on the locus | **FAITHFUL** | the record's edge bound, honestly | **ALL FIVE ARE CONTENT**, none arithmetic | **CORRECT**, vacuous at n ≤ 3 |
| L177 | **REFUTED**, the typed theorem is a **FALSE PROPOSITION** | **BROKEN**, not merely strengthened | **DIVERGENT**, loops and multi-edges admitted | an unprovable goal; the docstring calls it "quoted rather than derived" | **THREE OF FOUR ARE ARITHMETIC**, one a definitional unfold | **THE BOUNDARY IS THE FALSIFIER**, one isolated vertex |
| L178 | **PARTIAL**, step 5 only; the equality clause is absent and the reduction is assumed | **STRENGTHENED, SAFELY** (squared form) but the headline "proved" is **OVERSTATED** | **N/A** (bare reals) | none | **FOUR OF FIVE ARE CONTENT**, `constant_exact` is arithmetic | **CORRECT**, h2 excludes the zero triple |
| L179 | **REFUTED for (a) and (b)** (the typed statements are different claims; **(c) MISLABELLED** | **GUTTED**), `Fin 1` collapses both to triviality | **FAITHFUL but rational**, ℚ not ℝ | two goals that are each trivially provable as typed | **BOTH ARE ARITHMETIC OR RE-EXPORTS** | **THE STATEMENTS LIVE AT THE DEGENERATE BOUNDARY** |
| L180 | **PARTIAL**, (1) and (2) typed faithfully; **(3) ABSENT AND UNMENTIONED** | **STRENGTHENED, LEGITIMATELY** (skewness, orthonormality, λ ≠ 0 all dropped and the claim survives) | **FAITHFUL, with the contraction stipulated** | none | **ALL SIX ARE CONTENT** | **CORRECT**, vacuous at r = 0 |
| L182 | **DIVERGENT**, real n, no parity, and the `> 0.5923` half dropped | **STRENGTHENED BEYOND ITS INPUT**, asserted at odd and non-integer n | **FAITHFUL**, the whole constant chain checks against L162 | a claim wider than the record's, on an input the record supplies only at even n | **ONE STEP, ONE ARITHMETIC, ONE SCHEMA** | **CORRECT** on the range; no positivity guard on F(12) |

**Q6, is L180's claim to prove (1) and (2) outright correct?** **YES AS TYPED, NO AS ADVERTISED.** Both theorems are true, proved, and free of `sorry`. But `ricci` is *defined* to be the contraction formula rather than derived from a curvature tensor, so the curvature content of the record's (1) is stipulated; the record's own `Σ λᵢ ωᵢ² = 0` form and its "every Aᵢ positive semidefinite of trace 2" clause sit outside the iff, in separate theorems that nothing composes; and part (3) (the half the record's lemma title names, "and it names the support"), is missing from the file with no acknowledgement.

## One-line actionable summary

**[finrank_ker_incidence](../lean/HamiltonsCubic/Results/L177Statement.lean) is false as stated, Lean derives `False` from it at the one-vertex graph, because the record's `|E| - |V| + b` was typed with truncated natural subtraction, and [L179Statement.lean](../lean/HamiltonsCubic/Results/L179Statement.lean)'s two `sorry`-bearing theorems are not L179(a) and L179(b) but different, trivial claims over a one-element spectrum.**

## Hypothesis inventory

Present in the record and absent from Lean:

| Record hypothesis | Lemma | Where it went |
|---|---|---|
| orthonormal frame `{f_a}` | L176 | into the untyped W → K bridge; the record calls it "used and unstated", so it is precisely the hypothesis Lean cannot check |
| `W` is a Weyl tensor, rank = number of nonzero entries above the diagonal | L176 | asserted in the docstring, never typed |
| `G` is loopless | L177 | **dropped**, `ends : E → V × V` permits `(v, v)`; the record names looplessness as one of two hypotheses "used throughout and unstated" |
| `G` is simple | L177 | **dropped**, two edges may carry identical endpoints |
| characteristic ≠ 2 | L177 | satisfied by fixing ℝ |
| rank ≤ 3, support on a four-dimensional `V`, `W ≠ 0` | L178 | replaced by three bare reals with `e₁ = 0`, `p₂ = 1`; the reduction (steps 1–4) is outside the file |
| equality exactly at `W_{ℂP²}` up to positive scale and an `O(n)` frame change | L178 | **dropped from the type**, asserted in the docstring |
| `θ = tr W³ + ⟨W, W#⟩ = 9e₃`, resting on `γ² = 2` | L178 | the numeral `9` is hard-coded; step 2's derivation appears nowhere |
| `ωᵢ` orthonormal, skew, every `λᵢ ≠ 0`, `W ≠ 0` | L180 | dropped from `ricci_flat_iff`; the statement survives without them |
| `‖ωᵢ‖ = 1` | L180 | correctly carried, as `hnorm : trace (ωᵢ ωᵢᵀ) = 2` in `sum_lam_eq_zero` |
| `n` even | L182 | **dropped**, `n : ℝ` with `12 ≤ n` |
| `λ∞ F(12) > 0.5923` | L182 | **dropped**, only the relative inequality is typed |
| `W` self-adjoint, spectral over an orthonormal eigenbasis, rank `r` | L179 | replaced by `Fin 1` |

Present in Lean and absent from the record:

| Lean hypothesis | Lemma | Reading |
|---|---|---|
| `hrank : (incidence ends).rank = Fintype.card V - b` | L177 | the record proves this from Zaslavsky; assuming it is legitimate and documented, and it is not what makes the theorem false |
| `hW : IsWeylOf R` | L179 | **unused, and it already contains the conclusion of the sibling theorem**, `IsWeylOf` is defined in [Curvature.lean](../lean/HamiltonsCubic/Base/Curvature.lean) as self-adjointness ∧ `∀ i j k l, bianchiOf R i j k l = 0` ∧ Ricci-flatness |
| `hzero : lam 0 = 0` | L179 | over `Fin 1` this says the whole spectrum vanishes, so `R = 0` |
| `n : ℝ` rather than `n : ℕ` even | L182 | a strict widening of the claim |

## 1. L176, the strongest of the six, and its file undersells it

The abstraction is exact. The record's proof says the locus is "hollow symmetric with vanishing row sums, which is the whole of what the proof uses", and [IsSectional](../lean/HamiltonsCubic/Results/L176Statement.lean) is those three clauses and nothing else. [nbr](../lean/HamiltonsCubic/Results/L176Statement.lean) is the degree set, well defined because hollowness keeps `a` out of its own neighbourhood; [edges](../lean/HamiltonsCubic/Results/L176Statement.lean) filters ordered pairs by `p.1 < p.2`, so its cardinality is the count of nonzero entries above the diagonal, which is the record's `|E(G)|`.

All five proved theorems are mathematical content about the object, not arithmetic. `card_nbr_ne_one` is the record's degree paragraph verbatim; `card_nbr_zero_or_two_le` is **the first of L176's two stated conclusions, proved outright**; `two_le_card_nbr` is its contrapositive; `mem_edges_of_ne` is the orientation bookkeeping the edge count needs; `card_edges_ne_one` is the `|E| = 1` case of the record's edge count. This is the one file of the six in which nothing is dressed up.

The defects are three, and all are of understatement or omission rather than error:

1. **The docstring is wrong in the modest direction.** It says "L176's statement is still not machine-checked; what is machine-checked is its pivot". The record's statement has two conclusions, and one of them (every vertex has degree 0 or degree ≥ 2), is machine-checked here without a `sorry`. The file describes its own best result as a step.
2. **The rank clause is prose.** "The `Λ²`-rank is the number of nonzero entries above the diagonal" is asserted in the module docstring and typed nowhere, so the record's "in particular rank ≥ 4" has no Lean counterpart.
3. **Orthonormality lives entirely in the untyped bridge.** The record went out of its way to restore it after two audits found it missing; the Lean statement, being about `K` alone, can neither carry it nor be wrong about it. That is a defensible abstraction, but it means the one hypothesis the record repaired is the one the formalisation does not see.

**Boundary.** `Fin 0` makes every matrix zero, so `hne` is unsatisfiable and the statement is vacuous; `n = 2` and `n = 3` are the record's own killed cases and are likewise vacuous. Correct degeneration.

**What would break it.** A coordinate-diagonal Weyl tensor whose `Λ²`-rank is not the count of nonzero off-diagonal entries of `K`, that is, a failure in the frame translation, which is exactly the part Lean does not hold.

## 2. L177, the typed theorem is a false proposition, and I have machine-checked that

`Module.finrank`, `Matrix.rank`, `Fintype.card` and `b` are all `ℕ`. The record's dimension `|E| - |V| + b(G)` is an identity over `ℤ`, and it is negative-intermediate whenever `|E| < |V|`. Typed as `Fintype.card E - Fintype.card V + b` over `ℕ`, the subtraction truncates at zero and the formula returns the wrong number on every graph with fewer edges than vertices.

Take the one-vertex graph with no edges: `V = Unit`, `E = Empty`, `b = 1` (a single isolated vertex is one bipartite component). The hypothesis is satisfied, `rank N = 0 = Fintype.card Unit - 1`. The kernel is the whole of `Empty → ℝ`, of finrank 0. The typed conclusion asserts `0 - 1 + 1 = 1`. I checked this in Lean against the built artefact, deriving `False` from `finrank_ker_incidence` alone plus its own hypothesis, and it compiled with no errors:

```lean
example (ends : Empty → Unit × Unit) : False := by
  have hlin : Matrix.mulVecLin (incidence ends) = 0 := by
    ext x v; simp [Matrix.mulVec, dotProduct]
  have hr : (incidence ends).rank = Fintype.card Unit - 1 := by simp [Matrix.rank, hlin]
  have h := finrank_ker_incidence ends 1 hr
  have hrhs : Fintype.card Empty - Fintype.card Unit + 1 = 1 := by decide
  rw [hrhs] at h
  have h0 : Module.finrank ℝ (Empty → ℝ) = 0 := by simp
  have hle := Submodule.finrank_le (LinearMap.ker (Matrix.mulVecLin (incidence ends)))
  omega
```

The single-edge graph on two vertices is a second witness of the same shape (`1 - 2 + 1` reads 1 where the record reads 0). So the `sorry` in this file guards a goal that **cannot be closed**, and the docstring's "The proof is not here… it needs `rank N = |V| - b(G)`, which is classical" misdescribes the situation: no classical input would help, because the target is false.

The irony is internal. `dim_ker_eq` immediately above states the same identity **over `ℤ`**, where it is true and where `ring` proves it, the author typed the arithmetic correctly in the helper and incorrectly in the theorem.

Three further defects:

- **`incidence` is not the record's `N`.** `ends : E → V × V` places no constraint that the two endpoints differ, so loops are admitted, and no injectivity, so parallel edges are admitted. The record names looplessness as a used-and-previously-unstated hypothesis, and its `G` is simple. Under the assumed `hrank` this does not add to the falsity, but the object typed is not the object the record describes.
- **Two of the record's three parts are gone without a word.** Part (2), the full-support criterion, and part (3), `dim = C(n,2) - n` at `K_n` (the count the record says it had been asserting), are absent. The module docstring presents part (1) as the whole of L177.
- **The theorem's own docstring overclaims its type.** It reads "The tensors supported inside `G` are exactly `ker N`, of dimension `|E| - |V| + b(G)`", but the type states only a dimension. The identification of the coordinate-diagonal locus with `ker N` (the half of part (1) that carries the curvature content), is typed nowhere, and `mulVec_apply_eq`, whose docstring says "the kernel condition IS the vanishing row sum", proves only that `mulVec` unfolds to a sum of guarded terms. It does not state a kernel condition at all.

**Q5 for this file is the harshest answer of the six.** `bipartite_sign_kills_edge` is `(1 : ℝ) + -1 = 0`, proved by `norm_num`, carrying a docstring that calls it "the first half of `rank N = |V| - b`". `odd_walk_forces_zero` is `x = -x → x = 0` over ℝ, proved by `linarith`, called "the second half". `dim_ker_eq` is `ring`. Not one of the three mentions a graph, a component, a walk or a matrix. This is the blurring the brief warns about, in its purest form: the graph theory is entirely in the prose and entirely absent from the propositions.

**Boundary.** The empty edge set is not a degenerate case that happens to work, it is the falsifier. The empty vertex set (`V = Empty`, `E = Empty`, `b = 0`) is the one boundary that comes out right, at `0 = 0`.

**What would break it.** Delivered: the one-vertex graph, machine-checked above.

## 3. L178, real content, correctly proved, and not the lemma the file says it proves

`e3_sq_le` is a genuine result: three reals with `e₁ = 0` and `p₂ = 1` satisfy `(abc)² ≤ 1/54`, with an explicit SOS certificate `(u - 1/6)²(2/3 - u) ≥ 0` at `u = (a+b)²`. That is the record's step 5, the discriminant bound, honestly formalised. `p3_eq` is Newton at `e₁ = 0` and `e2_eq` is `e₂ = -1/2`; both are steps of the record's argument. `P_sq_le` follows. Only `constant_exact` (`81 · (1/54) = 3/2` by `norm_num`), is arithmetic.

But the brief calls `P_sq_le` "the conclusion proved outright" and "the session's flagship", and against the record that is **overstated on three counts**:

1. **The reduction is assumed, not proved.** The record's L178 hypothesis is rank ≤ 3 plus support on a four-dimensional `V`. Getting from there to three real numbers with `e₁ = 0` and `p₂ = 1` is steps 1 to 4, the splitting into `W⁺ ⊕ W⁻`, the consumption of the first Bianchi identity to make each summand trace-free on its own three-space, the padding argument, and Newton. None of it is in the file, or in any hypothesis of the file.
2. **The numeral `9` is unbacked.** `θ = tr W³ + ⟨W, W#⟩ = 3e₃ + 6e₃ = 9e₃` rests on `γ² = 2`, which the record derives from `id# = (n-2) id` through an additivity-across-ideals argument the record itself flags as **supplied by a reviewer at audit and therefore itself unaudited**. In Lean that entire step is a literal `9` inside the statement. The theorem is unconditionally true about reals; whether it is L178 depends wholly on an untyped and self-declared-unaudited derivation.
3. **The equality clause (half of L178's statement), is not there.** The record's conclusion is `θ ≤ √(3/2)` "with equality exactly when `W` is `W_{ℂP²}` up to POSITIVE scale and an `O(n)` frame change". `P_sq_le` is an inequality with no equality characterisation, no witness, and no rigidity. The docstring asserts "the bound is attained precisely when `e₃² = 1/54`, which is the repeated-root case, `(2,-1,-1)/√6`, and is `ℂP²`", and `constant_exact` establishes only that two numerals agree. **Attainment is not even typed**, though `a = 2/√6, b = c = -1/√6` would have been a two-line instance.

One thing is strengthened, in the safe direction and in agreement with the record. `(9e₃)² ≤ 3/2` is `|θ| ≤ √(3/2)`, which is strictly more than the record's one-sided `θ ≤ √(3/2)`, and the record separately says "The sign-closed statement is `|θ| ≤ √(3/2)`", so the squared form matches a sentence the record wrote. The file's phrasing "the bound `θ ≤ √(3/2)` **is** `P² ≤ 3/2`" states an equivalence where there is an implication, but the direction is the harmless one.

**Boundary.** `h2` excludes the zero triple, so the statement has a subject everywhere it applies. Nothing degenerates.

**What would break it.** Any error in `γ² = 2`, or in the claim that `⟨W, W#⟩ = 6e₃` on this family. The Lean statement would remain true and would simply stop being about `θ`.

## 4. L179, neither typed part is the record's part, and part (c) is `mul_eq_zero`

This is the file with the widest gap between label and content.

**Part (c) is arithmetic, and a duplicate.** `rankOne_of_traceless` takes `htr : lam * normSqBiv om = 0` and `hnorm : normSqBiv om ≠ 0` and concludes `lam = 0`, by `mul_eq_zero`. The record's (c) is "a rank-one self-adjoint `W = λ ω⊗ω` has `tr W = λ‖ω‖²`, which tracelessness forces to zero". **The mathematical step is the identification of the trace with `λ‖ω‖²`, and here it is the shape of a hypothesis.** Nowhere in this file or in [QPGeneral.lean](../lean/HamiltonsCubic/Base/QPGeneral.lean) is `traceOp (rankOne lam om) = lam * normSqBiv om` stated or proved, that is the summation of `inner2_rankOne` over the pair basis, and it is the whole of (c). Worse, the base layer already contains `rankOne_traceless_eq_zero (lam nrm : ℚ) (hn : nrm ≠ 0) (h : lam * nrm = 0) : lam = 0` with the same two-line proof, itself labelled "L179(c)". The statement file re-derives it verbatim with `nrm` instantiated. The docstring says "**Proved**, from `inner2_rankOne` in the base layer", **the proof does not invoke `inner2_rankOne`**; it invokes `mul_eq_zero.mp`. That attribution is checkably false.

`inner2_rankOne'` is a one-line re-export of a base-layer theorem, proving nothing new.

**Part (b) is a triviality, and the `sorry` sits on it.** `bianchi_on_nonzero_spectrum` fixes the spectrum index type at `Fin 1` and then assumes `hzero : lam 0 = 0`. Together with `hspec` that forces `R X = (0 * inner2 (om 0) X) • om 0 = 0` for every `X`, so `R` is the zero operator and `bianchiOf R i j k l = 0` follows by unfolding. The record's (b) is that "at rank `r` this is a condition on `r` terms and no more", stated as an **iff** between the first Bianchi identity and `Σ_{λ≠0} λ ω ∧ ω = 0`. The typed statement is one direction, at `r = 1`, with that single eigenvalue set to zero. It says the zero operator satisfies Bianchi. The docstring claims "The proof is not here. It needs the Bianchi obstruction identified as the map `S²Λ² → Λ⁴`", it needs no such thing.

**Part (a) is a different claim entirely.** L179(a) says `W` is supported on `Λ²V` for `V` the span of the eigenforms' supports. `supported_on_span` concludes `∀ i j, inner2 (R (phi i j)) (phi i j) = ∑ k, lam k * (inner2 (om k) (phi i j))^2`, a diagonal-entry identity that follows from `hspec` by bilinearity of `inner2` alone. **It mentions no subspace, no span, no support, and no `V`.** It is `inner2_rankOne` summed over a one-element spectrum. Its docstring says "It needs the pair symmetry to carry the second index pair, which the base layer has only as a clause of `IsWeylOf`", and indeed `hW : IsWeylOf R` is assumed, is **not needed for the stated conclusion**, and is flagged unused by nothing because Lean does not lint unused hypotheses of a `sorry`. `IsWeylOf` is moreover defined as self-adjointness ∧ `∀ i j k l, bianchiOf R i j k l = 0` ∧ Ricci-flatness, so this theorem assumes as a hypothesis exactly what its sibling `bianchi_on_nonzero_spectrum` states as a conclusion.

**Two further divergences.** Everything is over `ℚ` while the record's `W` is real, inherited from the base layer, so not this file's choice, but a rational statement does not imply the real one and the docstrings do not say so. And `Fin 1` is not a stated simplification anywhere; a reader of the docstrings would take these for statements at rank `r`.

**Boundary.** These statements *are* the boundary. `Fin 1` with `lam 0 = 0` is the empty spectrum in disguise; an empty `ι` makes both conclusions vacuous.

**What would break each.** Any spectrum with two or more terms: `Fin 1` is what makes both typed claims say nothing about "the nonzero spectrum" or "the span of the supports", so a two-form example is enough to show the Lean statements and the record's parts are different claims. For (c), any `ω` for which `traceOp (rankOne lam om) ≠ lam * normSqBiv om`, a possibility the file neither excludes nor addresses, because it assumes the product form outright.

## 5. L180, the two typed parts are faithful; the part the lemma is named for is gone

`ricci lam om a c = ∑ i, lam i * ∑ b, om i a b * om i c b` matches the record's `Σ_b W_{abcb} = Σ_i λ_i Σ_b (ω_i)_{ab} (ω_i)_{cb}` exactly. `ricci_eq_sum_mul_transpose` is the index-to-matrix identity, `mul_transpose_eq_neg_sq` gives the record's `ω ωᵀ = -ω²` under skewness, `posSemidef_mul_transpose` gives the record's PSD clause, and `trace_mul_transpose` gives `tr(ωωᵀ) = Σ_{a,b} ω_{ab}²`. **Every proved theorem in this file is mathematical content**, and `sum_lam_eq_zero` carries the record's `‖ωᵢ‖ = 1` correctly as `hnorm`. This and L176 are the two files that hold up.

Answering the brief's Q6 precisely:

- **`ricci_flat_iff` is true and proved.** It also assumes strictly less than the record (no skewness, no orthonormality, no `λᵢ ≠ 0`, no `W ≠ 0`) and survives the loss, which is a legitimate strengthening rather than a defect. The record's own text supports this: "it holds for any matrices at all, skewness enters only in reading `ωωᵀ` as `-ω²`".
- **But the curvature content is stipulated.** `ricci` is *defined* to be the contraction formula. That `Σ_b W_{abcb}` of `W_{abcd} = Σ_i λ_i (ω_i)_{ab}(ω_i)_{cd}` equals it is the record's own first proof line and is not derived here. So `ricci_flat_iff` proves the algebraic core of (1) with the tensor-to-matrix step taken as a definition.
- **The record's form is `Σ λᵢ ωᵢ² = 0`; the Lean's is `Σ λᵢ ωᵢ ωᵢᵀ = 0`.** The bridge exists as `mul_transpose_eq_neg_sq` but nothing composes them, so the record's stated identity is never assembled.
- **"Every `Aᵢ` positive semidefinite of trace 2" is a clause of the record's (1)** and is not inside the iff. `trace_mul_transpose` reaches `Σ ω²` and stops; the `= 2` needs `‖ω‖ = 1` under the `a < b` convention, which is asserted in a docstring.
- **Part (3) is missing without acknowledgement.** "At rank three the support `V` is the support of the single form carrying the minority sign, and `dim V` is even and at least four", the record's own lemma title calls this "and it names the support", and the module docstring reproduces the lemma's (1) and (2) as though they were the lemma. Part (3) is where the Fillmore–Williams range-additivity citation and the `dim V ≥ 4` conclusion live; it is what L180 does for I38. None of it is typed and no sentence in the file says so.

**Boundary.** `r = 0` makes both sides of the iff trivially true and `sum_lam_eq_zero` reads `0 = 0`; correct, and the record's `W ≠ 0` is dropped harmlessly because the iff holds anyway. `n = 0` is trivial. Nothing degenerates wrongly.

**What would break it.** A Ricci contraction that differs from the `ricci` definition, the translation is by fiat. And for the untyped part (3), a rank-three Ricci-flat orthonormal triple with `dim V` odd or below four.

## 6. L182, the constant chain checks, the range does not

The constant chain is exactly L162's. I checked each definition against the record's formulas and then evaluated the chain at `n = 12` as a screen (seconds of arithmetic, reported as a screen and not as evidence): `θ₀(12) = 1.23603`, `c_p = 0.37081`, `ρ^eff = 0.71904` (the record's own figure), `w₀ = 2/3`, `s₀ = 0.83091`, `C = 42/11 = 3.81818`, `λ(12) = 6.27427`, `β = 0.82165`, and `F(12) = 0.38672`, against the record's `0.38673`. The product `λ(12) F(12) = 2.4264` against the record's `2.4266`. `theta0sq`, `theta0`, `lam`, `cp`, `rhoEff`, `w0`, `s0`, `Cn`, `beta`, `F` and `lamInf` are each a faithful transcription. **Q3 passes for this file.**

The statement does not.

1. **`n : ℝ` with `12 ≤ n` is not "every even `n ≥ 12`".** The record is emphatic that the range matters, "odd `n` is outside the statement, and the phrase means nothing without the range attached", and "the parity restriction comes from `F` alone". The Lean statement asserts the bound at every real `n ≥ 12`: at `n = 13`, at `n = 12.5`. The input it would need, `F(n) ≥ F(12)`, is on the record **only at even `n ≥ 14`**. This is a silent strengthening onto ground the record explicitly declines to stand on. I am not claiming the widened statement is false (I did not test it and the analysis-only footing forbids the sweep that would), I am claiming it is not the record's claim and has no support on file.
2. **The theorem's own docstring contradicts its type.** "**L182.** At every even `n ≥ 12`" sits directly above `(n : ℝ) (hn : 12 ≤ n)`. A reader checking the doc against the record would find agreement and be wrong.
3. **The `> 0.5923` half is dropped, and with it the lemma's point.** The record's chain is `λ(n) F(n) > λ∞ F(12) > 0.5923`. Lean types only the first inequality, which is *relative*: even once proved it would establish nothing about being bounded away from zero, because `λ∞ F(12) > 0` is asserted nowhere. `F 12 > 0` is not stated, not proved, and not derivable from any theorem in the file. The record's conclusion ("branch 2's constant is bounded away from zero uniformly in `n`"), is therefore not the conclusion typed.

**Q5.** `theta0sq_eq` is real algebra and a step. `product_bound` is a general arithmetic lemma about four reals; it is the schema of the combining step and does not mention `λ` or `F`, so it is a fact about the argument's shape rather than about its subject, defensible, but it is not L182 content. `deriv_in_u_neg {u : ℝ} (h : u < 3/4) : 2 * (-3 + 4*u) < 0` is `linarith` on a linear polynomial, with a docstring calling it "the derivative in `u = 1/n`". **Nothing in the file connects `2*(-3+4*u)` to any derivative of `theta0sq`**, and the reversal from decreasing-in-`u` to increasing-in-`n` (which the record calls "the step to name" and "how such an argument usually fails"), is asserted in the docstring and typed nowhere. That is arithmetic wearing a step's label.

**Boundary.** On `12 ≤ n` the square roots are all of nonnegative quantities, the record's exact margin `θ₀(12)² - 3/2 = 1/36` keeps `lam` away from division by zero, the crossover being `6 + 2√7 ≈ 11.29`, so nothing degenerates through Mathlib's `Real.sqrt` convention on negatives. The file gives no guard on that and does not state it; it happens to be safe.

**What would break it.** An odd or non-integer `n ≥ 12` with `F(n) < F(12)`. That is precisely the class the Lean asserts over and the record refuses to.

## Overall verdict

**The layer is NOT a faithful formalisation of the six lemmas, and the failure is not uniform, it is concentrated in three files while two are sound.**

- **L176 and L180 hold up.** Their definitions match the record's own words, every proved theorem is content rather than arithmetic, and their `sorry` (L176's) or their omission (L180's part 3) is a coverage gap rather than an error. L176's file is too modest about itself; L180's is silent about dropping the part its lemma is named for.
- **L177 is refuted.** Its one typed theorem is a false proposition, and I have machine-checked that against the built artefact. Three of its four "proved" theorems are `norm_num`, `linarith` and `ring` on scalars, each carrying a docstring that names a piece of graph theory it does not contain. The file type-checks and reads as verification, which is the specific harm the brief was written to catch.
- **L179 is refuted for (a) and (b) and mislabelled for (c).** Both `sorry`-bearing theorems are statements the record does not make, each trivially provable as typed, one of them assuming as a hypothesis the very thing the other states as a conclusion. Part (c)'s proof is `mul_eq_zero` and its docstring attributes it to a lemma it does not use.
- **L178's "proved outright" is overstated,** though the mathematics under it is real. The reduction from a rank-≤3 Weyl tensor to three eigenvalues is assumed; the factor `9` is hard-coded from a step the record itself calls unaudited; and the equality clause (half of L178's statement and the half that names `ℂP²`), is claimed in a docstring and typed nowhere.
- **L182's constants are exact and its range is wrong.** Its docstring says "even `n ≥ 12`" over a type that says `n : ℝ`, `12 ≤ n`, and it drops the numerical half that carries the lemma's actual conclusion.

**The pattern across the six is one thing, and it is the pattern the brief predicted.** Where a file had real content to type it typed it (L176, L180, and `e3_sq_le`). Where it did not, it typed the shape of the argument as a scalar identity and gave that scalar identity the docstring of the mathematical step it stands for. `(1 : ℝ) + -1 = 0` is not the first half of `rank N = |V| - b`; `2 * (-3 + 4*u) < 0` is not a derivative; `mul_eq_zero` is not the tracelessness of a rank-one operator. **A reader who trusts the docstrings over the types will conclude that far more of this record is machine-checked than is.**

*Reviewer r789. No repair attempted; every defect named above is left standing.*
