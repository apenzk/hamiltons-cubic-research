# r1029, the variational chain: maximiser implies critical

**Brief**: audit `mem_posTangentConeAt_sphere` ([SphereTangent.lean](../lean/HamiltonsCubic/Results/SphereTangent.lean)) and `innerOp2_Qop2_eq_zero_of_isLocalMaxOn` ([SphereFermat.lean](../lean/HamiltonsCubic/Results/SphereFermat.lean)) against [r1016](REVIEW_r1016.md)'s three pieces. Cold: the definitions alone.

**Verdict.** Both theorems are correct, kernel-clean and `sorry`-free. Every step of the argument, the derivative's identification and the scalar analysis survive intact. **The one substantive finding is a REACH DEFECT.**

## DEFECT, and r1030 found it independently

**The constraint set is the superseded one.** `I36Shape` ranges over `{S | IsWeyl2 S ∧ normSq2 S = 1}`; the theorem hypothesises `{R | normSq2 R = 1}`, the full sphere of `End(Λ²)`. *Maximality on the LARGER set is the STRONGER hypothesis*, so a point known only to maximise on the Weyl sphere, which is every maximiser the programme reasons about, does not satisfy it.

**The record already made and repaired this exact error**, at [plan.md](../plan.md): *"Restricting the constraint set WEAKENS the local-maximality hypothesis, so the new form is the STRONGER statement"*, and the old form *"was implied by this item and did not imply it"*. The same sentence applies verbatim here.

**And the debt is relocated rather than discharged**: assuming full-sphere maximality buys `Q(a) = θa` without `Ric(Q(W)) = 0`, which [second-order.md](../findings/second-order.md) records as not on file and as what turns criticality on the Weyl sphere into `Q(W) = θW` rather than `proj_W Q(W) = θW`.

## NON-VACUOUS, BUT ONLY DEGENERATELY

A witness exists at `ι = Fin 2`: `CurvOp2 (Fin 2) = ℝ·id`, `normSq2 id = 1`, `IsSelfAdjoint2 id` immediate, and the sphere is two isolated points so local maximality is free. **At that witness the conclusion reads `0 = 0`**, since `innerOp2 id y = 0` forces `y = 0` by definiteness.

**At `|ι| ≥ 3` nothing on the record exhibits an object meeting all three hypotheses.** Existence of a full-sphere maximiser is free by compactness; its SELF-ADJOINTNESS is unestablished.

## WHAT IS CORRECT, CHECKED RATHER THAN ASSUMED

- **The third piece IS supplied, and stronger than r1016 asked.** r1016 wanted *"a membership result for `posTangentConeAt {normSq2 = 1} R`"*; the theorem gives the whole orthogonal hyperplane, which is the entire tangent space since `d(normSq2)(a)[y] = 2⟪a,y⟫`.
- **The two-sided Fermat step is honest.** `-y ⊥ a` whenever `y ⊥ a`, and `3x ≤ 0` with `3(-x) ≤ 0` forces `x = 0` rather than bounding it. It would fail on a set whose cone is not symmetric: a ball's boundary, a polytope corner, any KKT setting.
- **The factor 3 is right, cross-checked by Euler homogeneity** independently of the file: `P` is degree 3 so `DP(R)[R] = 3P(R)`, and `3⟪R,Q(R)⟫ = 3·Pcubic2 R`. It matches [second-order.md](../findings/second-order.md)'s boxed derivation.
- **The `u ≤ 3` threshold is exact.** Squaring gives `¼u²(u-3) ≤ 0`, so the polynomial route genuinely cannot cover `u ≥ 0` and the case split is load-bearing rather than tidying. Screened at exact rationals: holds at `u = 0,1,2,5/2,3`, fails at `7/2,4,10`.
- **Axioms**: `[propext, Classical.choice, Quot.sound]` on all six of the chain's theorems.

## STYLE

Mathlib already packages the negation trick as `IsLocalMaxOn.hasFDerivWithinAt_eq_zero`. The file re-derives it with `linarith`.

**Analysis-only**: no long or open-ended run opened. One build of an already-built target, one axiom check, one seconds-long exact screen, reported as a screen.
