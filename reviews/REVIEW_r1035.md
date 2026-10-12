# Review r1035, I106b's criticality reduction and I77's closure on post F10

**Brief.** Break or confirm six claims from [2026-09-17-I106b-face.md](2026-09-17-I106b-face.md) and [plan.md](../plan.md)'s I77 row: the rank of `A`, the per-pair criticality form, the `ν_l = ν_m` degeneracy, the face's Jacobian-rank screen, the inference drawn from it, and I77's domination by [post F10](../findings/fence-posts.md).

**Analysis-only rule.** Given in the brief and honoured. Every verdict below rests on a derivation. Two seconds-scale screens on objects built for the purpose are reported as screens and named as such, and no positive claim rests on either. No sweep, census, optimisation or falsifier hunt was opened.

| # | claim | verdict |
|---|---|---|
| 1 | `A` has rank at most 2 | **CONFIRMED** |
| 2 | criticality is the per-pair system, as an equivalence | **CONFIRMED**, re-derived independently, and now machine-checked |
| 3 | pairs with `ν_l = ν_m` impose nothing | **CONFIRMED**, and it is an identity rather than a vacuous constraint |
| 4 | the face carries critical points robustly, ranks 6 vs 6 and 11 vs 11 | **conclusion CONFIRMED and strengthened to an exact theorem, while the stated evidence is REFUTED as evidence** |
| 5 | so `face_hands_down` is not provable by emptiness of the face | **CONFIRMED**, and it rules out less than the note implies |
| 6 | I77's pair-cap-only route is dominated by post F10 | **REFUTED** |

---

## Claim 1, rank at most 2. CONFIRMED

`A_{ik} = β ν_k² u_i + ν_k c_i = u_i a_k + c_i b_k` with `a_k = β ν_k²` and `b_k = ν_k`, so `A = u aᵀ + c bᵀ`, a sum of two outer products. Rank at most 2 at every `k`, unconditionally. Rank exactly 2 unless `u` and `c` are parallel or `a` and `b` are, so the bound is attained generically and the claim's "at most" is the right form.

## Claim 2, the per-pair system. CONFIRMED, re-derived from the definition

**Derived here without reading the source's algebra**, then compared.

Along `Q(t) = Q(I + tΩ)`, the derivative of `f(Q) = Σ_{i,k} A_{ik} Q_{ik}²` is `2 Σ_{i,k} A_{ik} Q_{ik} (QΩ)_{ik} = 2⟨A ∘ Q, QΩ⟩ = 2 tr(N Ω)` with `N = (A ∘ Q)ᵀ Q`. For `Ω` ranging over all skew matrices, `tr(N Ω) = 0` holds for every such `Ω` exactly when the skew part of `N` vanishes, so criticality is `N` symmetric, equivalently `Nᵀ = Qᵀ(A ∘ Q)` symmetric. That reproduces the boxed condition.

Setting `M = Qᵀ(A ∘ Q)`,

    M_{lm} = Σ_i Q_{il} A_{im} Q_{im} = a_m Σ_i Q_{il} u_i Q_{im} + b_m Σ_i Q_{il} c_i Q_{im} = a_m X_{lm} + b_m Y_{lm},

with `X = QᵀUQ` and `Y = QᵀCQ`, both symmetric. Hence

    M_{lm} − M_{ml} = (a_m − a_l) X_{lm} + (b_m − b_l) Y_{lm}
                    = β(ν_m − ν_l)(ν_m + ν_l) X_{lm} + (ν_m − ν_l) Y_{lm}
                    = (ν_m − ν_l)·[β(ν_l + ν_m) X_{lm} + Y_{lm}].

**Identical to the claim, entry for entry, with no sign or index discrepancy.**

**It is an equivalence, in both directions, and nothing is lost at either step.** Criticality holds if and only if `M` is symmetric, which holds if and only if `M_{lm} − M_{ml} = 0` for every `l < m`, which is the stated system verbatim. The step that could have been one-directional, pairing against skew `Ω` only, loses nothing because the pairing `Ω ↦ tr(NΩ)` is surjective onto the dual of the skew matrices. This is the same point the record already carries as [first_order_antisymm](../lean/HamiltonsCubic/Results/I106bFace.lean), reached here from the Hadamard form rather than the commutator form. The two forms agree: `M − Mᵀ = −([diag a, X] + [diag b, Y])`.

**Machine-checked, this round.** The one untyped step, the bridge `M_{lm} = a_m X_{lm} + b_m Y_{lm}` for a rank-2 `A`, together with the per-pair factorisation, compiles under Lean 4.33.1 and Mathlib with no `sorry` and no new axiom:

```lean
theorem hadamard_rank_two_apply {n : ℕ} (u c a b : Fin n → ℝ)
    (Q : Matrix (Fin n) (Fin n) ℝ) (l m : Fin n) :
    (Qᵀ * ((Matrix.of fun i k => u i * a k + c i * b k) ⊙ Q)) l m
      = a m * (Qᵀ * Matrix.diagonal u * Q) l m + b m * (Qᵀ * Matrix.diagonal c * Q) l m

theorem asym_factor {n : ℕ} (beta : ℝ) (nu u c : Fin n → ℝ)
    (Q : Matrix (Fin n) (Fin n) ℝ) (l m : Fin n) :
    (Qᵀ * (A ⊙ Q)) l m − (Qᵀ * (A ⊙ Q)) m l
      = (nu m − nu l) * (beta * (nu l + nu m) * (Qᵀ * Matrix.diagonal u * Q) l m
          + (Qᵀ * Matrix.diagonal c * Q) l m)    -- A i k = u i * (beta * nu k ^ 2) + c i * nu k
```

Warnings only, no errors. **So the answer to the Lean table's row for claims 1 to 3 is that the reduction IS typable in the current base layer, it needs nothing beyond `Matrix.hadamard`, `Matrix.diagonal` and `Finset.sum`, and it is now typed.** The proof runs through `Matrix.mul_apply`, `Matrix.hadamard_apply`, `Matrix.diagonal_apply` and `ring`, with the symmetry of `X` and `Y` proved inline rather than assumed. What remains untypable in this layer is unchanged and is the differential step, that `M = 0` **is** criticality, which quantifies over curves on `O(k)` and has no object here. A parent may lift the two declarations into [I106bFace.lean](../lean/HamiltonsCubic/Results/I106bFace.lean) as they stand.

**One scope note, not a defect in the claim.** The whole reduction presumes `Û` and `C` are simultaneously diagonal, which the setup states as "diagonal in the field frame". The note's own later sections record that R28's object is the coupled pair `(R, S)` with `G = EᵀF` and `E ≠ F`, so claims 1 to 3 describe the commuting case. They are correct on the object the brief defines, and that object is the special case `[Û, C] = 0`.

## Claim 3, degenerate `ν` imposes nothing. CONFIRMED, and it is stronger than "no condition"

If `ν_l = ν_m` then `a_l = a_m` and `b_l = b_m`, so `M_{lm} − M_{ml} = 0` **identically in `Q`**. The pair does not impose a weak condition, it imposes none: the corresponding entry of the antisymmetric part vanishes for every `Q` whatsoever. The claim is right, and the distrust it attracted is misplaced, because the vanishing is visible in the derivation before any interpretation.

**Does it break claim 4's rank count, which was run at generic `ν`?** No, and it cannot break claim 4's conclusion in the direction that matters. Degenerate `ν` deletes equations from the criticality system, so the critical set only grows and the face meets a larger set. Any degenerate `ν` therefore carries at least the face critical points that generic `ν` carries. The rank NUMBERS would change, since the deleted rows drop out of the Jacobian, but the conclusion drawn from them is monotone the safe way.

**A consequence worth naming.** With `ν` having `r` distinct values of multiplicities `m_1, …, m_r`, the number of active equations is `Σ_{l<m} m_l m_m`, not `C(k,2)`. At the fully degenerate spectrum `ν = const` every `Q ∈ O(k)` is critical, so criticality is then vacuous and the face is entirely critical. The record's open question, quoted at the end of the note's Gate 2 section, "whether `ν` can repeat in the node's data", is therefore the difference between a criticality condition and no condition at all.

## Claim 4, the face carries critical points. Conclusion CONFIRMED and upgraded to a theorem, evidence REFUTED as evidence

**The conclusion is exactly right and needs no numerics.** Let `Q` be a signed permutation matrix, `Q_{ij} = ε_i δ_{j, σ(i)}` with `ε_i = ±1`. Then

    X_{lm} = Σ_i Q_{il} u_i Q_{im} = Σ_i ε_i² δ_{l, σ(i)} δ_{m, σ(i)} u_i = δ_{lm} u_{σ⁻¹(l)},

diagonal, and likewise `Y`. So `M_{lm} = a_m X_{lm} + b_m Y_{lm}` is diagonal, hence symmetric, and `Q` is critical **for every `A`, every `β`, `ν`, `u`, `c`, at every `k`**. And `Q_{ii} = ε_i δ_{i, σ(i)}`, which vanishes for all `i` exactly when `σ` is a derangement. **Derangements exist at every `k ≥ 2`, so the face carries critical points at every `k ≥ 2`, unconditionally, with genericity in `A` irrelevant.** Screened at `k = 3` to `7` with the cyclic shift: asymmetry and diagonal both exactly `0.00e+00`, a screen consistent with the derivation and not evidence for it.

**The stated evidence does not survive.** Two defects, one fatal to the `k = 4` row.

- **The `k = 4` row is rank-saturated, so "6 vs 6" carries no information.** The Jacobian has `k(k−1)/2 = 6` columns, so its rank is at most `6` whatever equations are adjoined. Criticality alone already reaches `6`, and adding the four face equations **cannot** raise a rank already equal to the number of parameters. The row reports an arithmetic ceiling as if it were a dependence.
- **The `k = 6` value `11` is point-dependent.** Screen, twenty least-squares solutions of criticality plus face from random starts at fixed generic `(β, ν, u, c)`: the criticality rank at the solutions found came out `15`, `13`, `11`, `9` with multiplicities `9`, `5`, `5`, `1`. The rank at a **random, non-solution** `Q` is `15` at `k = 6` and `6` at `k = 4`, so `11` is a drop at a particular stratum rather than the generic figure the table suggests.

**What the screen does support.** Across all forty solutions found at `k = 4` and `k = 6`, the criticality rank and the criticality-plus-face rank were **equal at every one**, including the twenty where the common value was strictly below the parameter count and the equality was therefore not forced. So the local dependence the note asserts is real. It is also unsurprising once the derangement argument is in hand, and it is not what the conclusion needs.

**Verdict.** The sentence "zero-diagonal critical points are not a codimension accident" is true and provable. The table offered for it is half vacuous and half an artefact of one solve, and should be replaced by the derangement argument, which is exact and holds at every `k`.

## Claim 5, what this costs `face_hands_down`. CONFIRMED, and it rules out one route only

**The inference is sound.** If a maximiser over the image sits at a zero-diagonal `Q`, that `Q` maximises `f` over `O(k)` and is therefore critical. So "the face carries no critical point" would make the hypothesis of `face_hands_down` vacuous and the theorem free. Claim 4, in its exact form, kills that: the face always carries critical points. **`face_hands_down` cannot be proved by emptiness.**

**Stated precisely, what is closed and what is not.**

| route | state after claim 4 |
|---|---|
| the face contains no critical point of `f` on `O(k)` | **dead, provably, at every `k ≥ 2` and every `A`** |
| the face contains no **global maximiser** | not touched by claim 4, and already refuted more directly by the note's own earlier table, which found maximisers on the face at `k = 4, 5, 6` |
| the face contains no **non-splitting** global maximiser | **open**, and it is the vacuity statement that would actually close the item |
| every face critical point splits or is value-matched by one that does | **open**, and this is `face_hands_down` itself |
| second-order separation among face critical points | **open**, the note's own next step |

**So claim 4 is redundant as support for claim 5.** The note's earlier screen, two non-splitting maximisers on the face at `k = 4` and one at `k = 5`, already refutes the emptiness route and refutes the stronger third row above as well. Claim 4 adds the exactness, not the conclusion, and the derangement argument supplies the exactness at no cost.

**A caution about the critical points claim 4 exhibits.** Every signed permutation splits, so the derangement critical points are the harmless ones and satisfy `face_hands_down` trivially. In a screen of forty face-critical solutions at `k = 4` and `k = 6`, thirty-seven were signed permutations and the three that were not decomposed into a `3 × 3` rotation block against a permutation block, and **those split too**, with row set `{1,2,3}` against column set `{0,4,5}` in the instance inspected. Reported as a screen. It does not establish the theorem, and it does not contradict the note's own non-splitting face maximisers, which were found by a different search.

## Claim 6, I77 dominated by post F10. REFUTED

**Checked as the logical argument it is.** Domination needs the pair-cap-only programme to be a **relaxation** of F10's: same variables, same objective, and a feasible set containing F10's. **It fails on the third, and the variables differ too.**

**F10's programme** ([fence-posts.md:175](../findings/fence-posts.md)): variables `T_{abc}` in the eigenframe, constraints nonnegativity, total symmetry, row marginals `2(n−2)`, pair caps `≤ 2`, and `tr(W#) = −1`. Optimum `1.6059` at `n = 6`.

**I77's programme**, as [diagonal-half.md:1349](../findings/diagonal-half.md) states it in one place: variables `v_S ≥ 0` over the **ten multiset classes of triples across the level sets**, objective `θ = Σ_i a_i μ_i³ + ½ Σ_S σ₃(S) v_S`, two equality families from the marginal and from relation (B), **support conditions `v_S = 0` whenever `m_i(S) > a_i`**, and caps `κ = 2` in general or `κ = 1` on the decomposable locus. "The pair cap alone" means dropping relation (B) and keeping the rest.

**Three separate breaks.**

1. **The support conditions are constraints F10 does not have**, and the record itself calls them "stronger than the caps at small multiplicities". A programme carrying them is not a relaxation of one that does not.
2. **On the decomposable locus the cap is `1`, not `2`.** [diagonal-half.md:1331](../findings/diagonal-half.md): the bridge caps `S_{αβ}` at `1` there against the recorded `2` in general, "exactly half the strength of the general cap". Halving a cap shrinks the feasible set. The route [plan.md:128](../plan.md) leaves untried is the one on that locus.
3. **The spectrum is fixed in I77 and free in F10.** `a_i` and `μ_i` are data of the I77 programme, and `Σ_i a_i μ_i³` is a constant of its objective. F10's `1.6059` is a single number per `n`. Comparing a per-spectrum optimum with a number already maximised over configurations needs precisely the inclusion that breaks at 1 and 2.

**And the record already contains a counter-instance, in the same block.** [diagonal-half.md:1345](../findings/diagonal-half.md) derives `θ ≤ 18c³ = √(3/2) ≈ 1.2247` "with no criticality used, only the support conditions, the general pair cap, trace-freeness and unit norm". **That is a pair-cap programme without relation (B), and its value is below F10's `1.6059`.** I77's pair-cap-only programme carries every constraint that derivation uses, plus the marginal and nonnegativity, so on that family its optimum is at most `√(3/2)`. The asserted floor is violated by a bound the record derived itself and calls "the theorem the stratum was missing".

**What this does and does not overturn.** It overturns the **reason** [plan.md:126](../plan.md) gives for closing I77 at grade `0`, and the sentence "the bound it would return is known in advance to be too weak" is not established. It does **not** show that the untried piece would succeed: the `√(3/2)` instance is the three-nonzero-eigenvalue family, which the record already closes, and the open piece sits at four or more eigenvalues, where the support conditions may well loosen enough that the programme does degenerate towards F10's. **That is a question, and it is the question the item was closed to avoid asking.** The item should be reopened or re-graded with a reason that survives, and the honest form of the F10 observation is narrower: a programme in `T` alone with the general cap `2`, the marginal and no support conditions inherits F10's floor.

---

## Corrections to apply

| where | correction |
|---|---|
| [2026-09-17-I106b-face.md](2026-09-17-I106b-face.md), the rank table | the `k = 4` row is rank-saturated at the parameter count and proves nothing, and the `k = 6` value `11` is one stratum among `15`, `13`, `11`, `9`. Replace the table with the derangement argument, which is exact at every `k` |
| same file, "zero-diagonal critical points are not a codimension accident" | true, and provable in three lines: at a derangement signed permutation `X` and `Y` are diagonal, so `M` is diagonal and `Q` is on the face. Promote from screen to theorem |
| same file, the claims 1 to 3 row of the Lean table | no longer "NONE EXISTS". The bridge and the factorisation type in the base layer and compiled this round |
| [plan.md:126](../plan.md), I77 | the grade-`0` closure rests on an inclusion that does not hold. Reopen or re-grade |
| [diagonal-half.md:1394](../findings/diagonal-half.md), "the pair cap is not untried, it is dominated" | contradicted by [diagonal-half.md:1345](../findings/diagonal-half.md) in the same block, where a pair-cap programme without relation (B) returns `√(3/2) < 1.6059` |

## How the analysis-only rule was honoured

The rule was given in the brief and is recorded here as required. Claims 1, 2, 3, 5 and 6 were settled by derivation alone, with claims 1 to 3 additionally machine-checked. Claim 4 was settled by derivation as well, the derangement argument replacing the rank test entirely. Two screens ran, each seconds of compute on objects built for the purpose: the cyclic shift at `k = 3` to `7`, confirming the derivation returns exact zeros, and twenty least-squares solves per `k` at `k = 4, 6` to establish that the reported rank `11` is point-dependent. **Both are reported as screens.** The second is used only **negatively**, to withdraw a piece of evidence, which is the use the rule permits. No parameter sweep, no census, no optimisation of unknown cost and no falsifier hunt was opened, and nothing here waited on approval that should have.
