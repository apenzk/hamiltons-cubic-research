# REVIEW r1914: L196Step3.lean against the record's Lemma L196 step 3

Gate 2 review of [L196Step3.lean](../lean/HamiltonsCubic/Results/L196Step3.lean) at commit e8ad1e30, claimed as the paragraph *"Both degenerate at once is impossible"* of [diagonal-half.md](../findings/diagonal-half.md), Lemma L196. Every item of the brief was checked by hand from the definitions in [SelfDual.lean](../lean/HamiltonsCubic/Base/SelfDual.lean) and [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), and the axiom audit was run. The module proves what the record's step 3 asserts, under hypotheses equivalent to the record's, and the one scope sentence that overreaches ("odd dimensions too") is true but vacuous.

| # | Claim | Verdict |
|---|---|---|
| 1 | `L196_step3` and `L196_step3_wedgeSelf` state the record's step 3 | CONFIRMED WITH OBSERVATIONS |
| 2 | `wedge2` is the record's wedge of 2-forms | CONFIRMED |
| 3 | `ev`, `ev_halfw` and the value 4\|u\|²\|w\|² | CONFIRMED |
| 4 | `ker_sub_iff`, `ker_add_iff` identify ker α, ker β with E₊, E₋ | CONFIRMED |
| 5 | "any finite index type, so every m and odd dimensions too" | CONFIRMED WITH OBSERVATIONS |
| 6 | Axiom audit | CONFIRMED |
| 7 | Witness and falsifier | CONFIRMED |
| 8 | The L196 row of lean/INDEX.md | CONFIRMED WITH OBSERVATIONS |

**Summary: the module is a faithful formalisation of the record's step 3, with two scope remarks to tighten and no defect.**

## 1. Statement fidelity

- The record's claim is that α and β cannot both be degenerate when α ∧ β = 0. `L196_step3` reads degenerate as "has a nonzero vector in the kernel of the matrix", which is right for a 2-form on a finite-dimensional space: the form X(p,q) = p·Xq is degenerate exactly when X has nontrivial kernel. The conclusion `u = 0 ∨ w = 0` for arbitrary `u ∈ ker α`, `w ∈ ker β` is the contrapositive of "both kernels nonzero", so the statement is exactly the record's.
- `L196_step3_wedgeSelf` routes the lemma's own hypothesis ω₁ ∧ ω₁ = ω₂ ∧ ω₂ through step 1, `wedgeSelf_eq_iff` in [L196Statement.lean](../lean/HamiltonsCubic/Results/L196Statement.lean), whose forward direction yields `wedge2 (J₁ - J₂) (J₁ + J₂) = 0`. The direction used (`.mp`) is the right one.
- Hypotheses: `IsSkew Jᵢ` and `Jᵢ * Jᵢ = -1`. The record says "orthogonal complex structures". These are EQUIVALENT, since skew with J² = -1 gives JᵀJ = -J·J = I, and orthogonal with J² = -1 gives Jᵀ = J⁻¹ = -J. So the Lean hypotheses are the record's, neither weaker nor stronger.
- Observation: the docstring's "Orthogonality of `T` never enters" is true of the proof route (no step invokes TᵀT = I), but orthogonality of each Jᵢ, and hence of T, is implied by the hypotheses. The sentence should say the proof uses skewness and J² = -1 directly rather than suggest a weakening of the record.
- Nothing is used that the record does not state. The record's intermediate claims (E± are J₁-invariant, J₂ = ±J₁ on them) appear as `hu'`, `hw'`, `hu2`, `hw2` in `ev_cross`, derived rather than assumed.

## 2. `wedge2` against the record's wedge

- `halfw X Y a b c d = X_ab Y_cd - X_ac Y_bd + X_ad Y_bc`, and `wedge2 X Y = halfw X Y + halfw Y X` expands to X_ab Y_cd - X_ac Y_bd + X_ad Y_bc + X_cd Y_ab - X_bd Y_ac + X_bc Y_ad.
- For skew X, Y this is the (2,2)-shuffle sum giving (X ∧ Y)(e_a, e_b, e_c, e_d) with constant 1: the six shuffles (ab|cd), (ac|bd), (ad|bc), (bc|ad), (bd|ac), (cd|ab) with signs +, -, +, +, -, +. The index convention matches the form X(p,q) = pᵀXq used by `bil`.
- So `wedge2 α β = 0` is α ∧ β = 0, with no normalising constant at all. Off skew matrices the four-index object is not alternating, which is harmless here because α and β are skew (`hα`, `hβ` in `ev_cross`).

## 3. `ev`, `ev_halfw` and the value

- `ev F p q r s = Σ p_a q_b r_c s_d F_abcd` is the multilinear evaluation of a 4-tensor on four vectors. `t1`, `t2`, `t3` pair indices (ab)(cd), (ac)(bd), (ad)(bc) correctly, so `ev_halfw` gives X(p,q)Y(r,s) - X(p,r)Y(q,s) + X(p,s)Y(q,r), as claimed.
- By hand at p = u, q = J₁u, r = w, s = J₁w with αu = 0, βw = 0. `halfw α β` has α(u, ·) as a factor in all three terms, zero by skewness (`bil_left_zero`). In `halfw β α` the second and third terms carry α(J₁u, ·), zero since αJ₁u = 0. The surviving term is β(u, J₁u)·α(w, J₁w).
- J₂u = J₁u gives J₂J₁u = J₂J₂u = -u, so β(u, J₁u) = u·(J₁J₁u + J₂J₁u) = -2|u|². J₂w = -J₁w gives J₂J₁w = w, so α(w, J₁w) = w·(J₁J₁w - J₂J₁w) = -2|w|². The product is 4|u|²|w|². CONFIRMED.
- This is the record's Λ²E₋ ⊗ Λ²E₊ component read on one tuple: β|E₊ = 2ω₁|E₊ and α|E₋ = 2ω₁|E₋, both nondegenerate, which is the record's "both restrictions are nondegenerate on their own pieces".

## 4. Kernel identification

- With T = -J₁J₂, J₁ - J₂ = J₁(I - T) and J₁ + J₂ = J₁(I + T), and J₁ is invertible. So ker α = ker(T - I) = E₊ and ker β = ker(T + I) = E₋, which is the record's assignment ("α annihilates E₊ and β annihilates E₋").
- `ker_sub_iff` and `ker_add_iff` prove exactly these two equivalences at J₁² = -1 alone, and the Lean code matches (T written as `-(J₁ * J₂)`). They are not used by `L196_step3` itself, which works with the kernels directly. They serve as the dictionary to the record, which is their stated purpose.

## 5. Scope: every finite index type

- The theorem is stated over any `Fintype ι` with `DecidableEq ι`, so it holds at every m, m = 2 included. CONFIRMED.
- Observation: "odd dimensions too" is vacuous. A real matrix with J² = -1 has (det J)² = (-1)^n, impossible at odd n, so no hypothesis set exists there. The empty index type is likewise degenerate (every matrix equals every other, so -1 = 0 and u = 0). The sentence should say "every even dimension, the odd case being empty".
- Consistency with the record: the full lemma fails at m = 2 because step 2 (injectivity of L on Λ²) fails there. The record's m = 2 witness has T² = -I, so T has neither eigenvalue ±1 and both α and β are nondegenerate. Step 3 is vacuous on that witness and holds at m = 2 as the Lean shows. No contradiction.

## 6. Axiom audit

- `python3 scripts/misc/axiom_audit.py --only L196Step3` reports "auditing 14 declarations across 1 files" and "14/14 clean -- resting on the standard three alone" (propext, Classical.choice, Quot.sound). No sorry, no custom axiom. CONFIRMED.

## 7. Witness and falsifier

- Witness: J₁ = J₂ = `stdJ6`. Then α = 0, so ker α is all of ℝ⁶, and β = 2J is nondegenerate, so ker β = 0 and the conclusion holds through its right disjunct. The file's `example` checks only the hypotheses, which is the right thing for a witness. A second witness with both kernels relevant is J₂ = -J₁, the mirror case.
- Falsifier: two skew complex structures J₁, J₂ on ℝⁿ with (J₁ - J₂) ∧ (J₁ + J₂) = 0 and nonzero u, w with J₂u = J₁u and J₂w = -J₁w. By `ev_cross` any such pair would give 0 = 4|u|²|w|² > 0, so the only route to a falsifier is a defect in `ev_cross`, and the hand computation in section 3 finds none.

## 8. The L196 row in lean/INDEX.md

- The step 3 sentence is accurate: theorem names, hypotheses, the evaluation tuple, the value 4|u|²|w|², and the role of `ker_sub_iff`, `ker_add_iff` all match the file.
- "It uses skewness and Jᵢ² = -1 only" is accurate but, as in section 1, these are equivalent to the record's orthogonal complex structures. The row does not claim a weakening, so no change is required.
- "over any finite index type" is accurate. The closing scope sentence ("`IsComplexStructure` exists at `Fin 6` only") concerns the statement file and step 1 routing, and is correct as written, since L196Step3 avoids `IsComplexStructure`. Observation: the row could say explicitly that step 3 holds at m = 2 as well, so that "m = 2 being a genuine counterexample" is read as a counterexample to step 2 and the conclusion, not to step 3.

## Overall verdict

**CONFIRMED WITH OBSERVATIONS.** The module formalises the record's step 3 faithfully under hypotheses equivalent to the record's, the wedge convention is exact with constant 1, and the key value 4|u|²|w|² checks by hand. The observations are two wording fixes: "odd dimensions too" is vacuous, and "orthogonality of T never enters" describes the proof route while the hypotheses already imply it.
