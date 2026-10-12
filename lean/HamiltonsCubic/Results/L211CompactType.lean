import Mathlib.Tactic
import Mathlib.Algebra.Lie.TraceForm

/-!
# Lemma L211's sign step, typed: the type of an irreducible factor is the sign of its curvature

[findings/problem.md](../../../findings/problem.md), the L211 block, step 2.

**What the block needs.** On an irreducible factor of a symmetric space, Gorodski's
Corollary 3.1.4 gives `K X Y = lam * β ⁅X, Y⁆ ⁅X, Y⁆` where `β` is the Killing form and
`B = lam • β` restricted to `p` is the metric. Since `⁅X, Y⁆` lies in `k` and Lemma 2.1.2(b)
makes `β` negative definite there, the curvature has the sign OPPOSITE to `lam`, and that sign
is what distinguishes compact type from noncompact type. **A single global Einstein constant
then forces one type across every factor at once**, which is the step the whole lemma turns on.

**Why this file exists at all.** The L211 commit twice recorded `Lean: blocked` on the ground
that the layer carries no Killing form. **That was wrong**: Mathlib's `killingForm` is at
`Mathlib/Algebra/Lie/TraceForm.lean`, and the commit gate refusing a third consecutive blocked
trailer is what forced the check. *The same mistake had already been made about `LieIdeal` one
lemma earlier, so this is the second absence asserted without looking.*

## What is typed, and what is not

`curvOfKilling` is Corollary 3.1.4's right-hand side, and the two theorems are the sign
statement in both directions. **Not typed**: that `β` really is negative definite on `k`, which
is Lemma 2.1.2(b) about a specific algebra rather than a general fact; that `B = lam • β` is an
inner product, which forces the sign of `lam` by type; and the whole of step 4, which is
topological and needs a Lie group the layer does not carry.
-/

namespace HamiltonsCubic.Results

open LieAlgebra

variable {L : Type*} [LieRing L] [LieAlgebra ℝ L] [Module.Finite ℝ L] [Module.Free ℝ L]

/-- **Corollary 3.1.4's right-hand side**, the sectional curvature of the plane spanned by `x`
and `y` on an irreducible factor, with `lam` the scaling between the metric and the Killing
form. -/
noncomputable def curvOfKilling (lam : ℝ) (x y : L) : ℝ :=
  lam * killingForm ℝ L ⁅x, y⁆ ⁅x, y⁆

/-- **COMPACT TYPE: a negative scaling gives nonnegative curvature.** *`lam < 0` is what
`B = lam • β` being an inner product forces when `β` is negative definite on `p`, and
`β ⁅x,y⁆ ⁅x,y⁆ ≤ 0` is Lemma 2.1.2(b) at `⁅x,y⁆ ∈ k`. So the curvature is `≥ 0`, which is
compact type.* -/
theorem curvOfKilling_nonneg {lam : ℝ} (hlam : lam < 0) {x y : L}
    (hk : killingForm ℝ L ⁅x, y⁆ ⁅x, y⁆ ≤ 0) :
    0 ≤ curvOfKilling lam x y := by
  unfold curvOfKilling
  nlinarith [hlam.le, hk]

/-- **NONCOMPACT TYPE: a positive scaling gives nonpositive curvature.** *The other half, and
together with the first it is why the sign of the Einstein constant determines the type and one
global constant forces one type on every factor.* -/
theorem curvOfKilling_nonpos {lam : ℝ} (hlam : 0 < lam) {x y : L}
    (hk : killingForm ℝ L ⁅x, y⁆ ⁅x, y⁆ ≤ 0) :
    curvOfKilling lam x y ≤ 0 :=
  mul_nonpos_of_nonneg_of_nonpos hlam.le hk

/-- **The two types are exclusive where the curvature is nonzero**, which is what lets one
global Einstein constant rule out a mixed decomposition rather than merely constrain it. -/
theorem curvOfKilling_sign_determines {lam₁ lam₂ : ℝ} (h₁ : lam₁ < 0) (h₂ : 0 < lam₂)
    {x y u v : L}
    (hk₁ : killingForm ℝ L ⁅x, y⁆ ⁅x, y⁆ ≤ 0) (hk₂ : killingForm ℝ L ⁅u, v⁆ ⁅u, v⁆ ≤ 0)
    (hne : curvOfKilling lam₁ x y ≠ 0) :
    curvOfKilling lam₂ u v ≤ 0 ∧ 0 < curvOfKilling lam₁ x y :=
  ⟨curvOfKilling_nonpos h₂ hk₂,
    lt_of_le_of_ne (curvOfKilling_nonneg h₁ hk₁) (Ne.symm hne)⟩

/-- **L211'S CONCLUSION, WITH STEP 4 AS A NAMED HYPOTHESIS SO THE GAP IS A BINDER RATHER THAN
PROSE.** *`einstein` is the Einstein constant $\lambda$ and `scaling` is Corollary 3.1.4's
$\lambda_i$, the factor between the metric and the Killing form, which the block is careful to
keep apart.*

- `hsign` is **step 2**: the two have opposite signs, since the curvature carries the sign
  opposite to `scaling` and the Einstein constant follows it by tracing.
- `hcompactType` is **step 4**, that a compact globally symmetric space cannot be of noncompact
  type, hence `scaling < 0`. **It is a hypothesis here and not a theorem**, because proving it
  needs the transvection group, the quotient `G / K` and compactness, none of which this layer
  carries. *That is the whole of what L211 still owes Lean, and it is visible as a binder.*

Given both, the Einstein constant is positive, which is the lemma. -/
theorem einsteinConst_pos (einstein scaling : ℝ)
    (hsign : einstein * scaling < 0) (hcompactType : scaling < 0) :
    0 < einstein := by
  nlinarith

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.curvOfKilling_nonneg
#print axioms HamiltonsCubic.Results.curvOfKilling_nonpos
#print axioms HamiltonsCubic.Results.curvOfKilling_sign_determines
#print axioms HamiltonsCubic.Results.einsteinConst_pos
