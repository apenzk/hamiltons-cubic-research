# r1030, the variational chain read as mathematics

**Brief**: the same claim as [r1029](REVIEW_r1029.md), attacked from the geometry rather than the tactics. Cold, and the two reviewers did not see each other.

**Verdict.** *The theorem is TRUE as written, and WEAKER than the record says.* The mathematics inside the four files is correct: no error in the curve, the limits, the decomposition, the cone membership, the double Fermat, or the constant. **Both defects are about REACH.**

## DEFECT 1, found independently of r1029 and agreeing with it

**The constraint set is the unit sphere of all of `End(Λ²)`, not the Weyl sphere.** `IsLocalMaxOn` over a LARGER set is a STRONGER hypothesis, and `I36Shape_imp_fullSphere` runs the implication the wrong way for this use. The record's maximiser does not satisfy it.

**The repair is cheap and the curve already supports it.** All three `IsWeyl2` clauses are LINEAR equations, so `IsWeyl2` is a linear subspace and `sphereCurve a y t` stays inside it whenever `a` and `y` do. *What the layer lacks is three closure lemmas (`IsWeyl2` under `+`, `•`, hence the curve), none of which is declared*, plus `Qop2` preserving `IsWeyl2` for the ambient recovery.

## DEFECT 2, `Q(a)` lies along `a` is asserted three times and proved nowhere

`IsCritical2 R θ := Qop2 R = θ • R` exists and **nothing connects it to the theorem**.

**The step needs DEFINITENESS of `innerOp2` and nothing else**: no finite-dimensionality, no orthogonal-complement theory, because the witness is explicit. Put `λ = ⟪a, Q(a)⟫` and `z = Q(a) - λ·a`; then `⟪a,z⟫ = 0`, the theorem applies at `y = z`, and `normSq2 z = ⟪z,Q(a)⟫ - λ⟪z,a⟫ = 0`. *`λ` comes out as `P(a)`, matching `θ = P(W)` in [conventions.md](../findings/conventions.md).*

**Written the same session as `Qop2_eq_smul_of_isLocalMaxOn`.**

## WHAT IS CORRECT

- **The curve is right and `y` is EXACTLY the velocity**, not a multiple: `r(t) = (1+kt²)^{-1/2}` has `r'(0) = 0`, so no scalar is lost. Without orthogonality the curve leaves the sphere at first order; nothing is lost by the hypothesis, since any tangent vector satisfies the linearised constraint anyway.
- **The negation trick is legitimate here and would fail elsewhere**: on a ball's boundary, a sphere cut by a half-space, or any polytope corner, a maximiser gives a variational inequality with a sign and never an equation.
- **The first variation agrees with the prose, constants included.** `PcubicDiffS R S = 3⟪S, Q(R)⟫` matches [second-order.md](../findings/second-order.md)'s boxed formula, re-derived independently as `⟪S,Q(R)⟫ + 2T(R,R,S)` with `T` fully symmetric on self-adjoint arguments. **No factor discrepancy.**

## QUESTIONS

- **`IsSelfAdjoint2` is free on the Weyl sphere and not free on the full one.** `IsWeyl2 → IsSelfAdjoint2` is on file; nothing shows a FULL-sphere maximiser is self-adjoint, so the hypothesis conjunction has no witness. *The restriction that weakens the result is the sphere, not the self-adjointness.*
- **The full-sphere form buys no extra first-order conclusion.** At self-adjoint `a`, `Q(a)` is self-adjoint, and self-adjoint and skew-adjoint operators are `innerOp2`-orthogonal, so the conclusion is VACUOUSLY true for every skew-adjoint `y`. The extra hypothesis purchases content only in non-Weyl self-adjoint directions, which I36 does not use.
- **Whether a Weyl maximiser is a full-sphere maximiser is undecided and was not run.** The trace half of the second-order term is dominated, the `Φ` half is unsigned, and deciding it is a Hessian evaluation on a family rather than an object in hand. *Named and stopped, per the analysis-only rule.*
