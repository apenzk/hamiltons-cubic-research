import Mathlib

set_option linter.style.longLine false

/-!
# L12, stated in the part that does not need the curvature layer: the closed form

## The record's statement, verbatim

> Lemma L7 splits the critical points by whether its inequality is an equality; Lemma L8 settles
> the equality side across the classical families […]. The strict side is measured by its slack,
> $$S(W):=\|\mathrm{Ric}(W_-)\|^2+6\delta^2-\theta\operatorname{tr}(W_-)-\operatorname{tr}(W_-^2)\;\ge\;0.$$
>
> **The slack is not an opaque residual.** Compressing the criticality equation onto the negative
> eigenspace, applying the scalar-curvature identity to $W_-$, and expanding $\#$ bilinearly
> reduces it (on the structured class, under two bracket conditions that hold there), to
> $$S=\operatorname{tr}\bigl(P_{E_-}W_-^\#P_{E_-}\bigr)=\tfrac12\sum_{i,j}\mu_i\mu_j\bigl\|P_{E_-}[v_i,v_j]\bigr\|^2,$$
> where $Wv_i=-\mu_iv_i$ on $E_-$. On that class the slack is exactly the bracket mass $E_-$ fails
> to expel, weighted by the negative spectrum.

with the audit's corrections:

> **The guard is the whole content and the block names none of it.** *"On the structured class,
> under two bracket conditions that hold there"*, the class is **undefined on the record**, and
> the conditions are **(F1) $[E_+,E_+]\perp E_-$ and (F2) $[E_+,E_-]\subseteq E_-$**. These are
> two of the *three* grading conditions, the third being $[E_-,E_-]\perp E_-$, **so the fence
> assumes all of gradedness except the clause the slack exists to measure.**

> **$S\ge0$ is printed with $W$ free and is false off the critical set**, the record's own
> witness gives margin $-0.18$ at $n=6$.

[ungraded-slack.md](../../../findings/ungraded-slack.md), Observation L12.

## What this file states, and what it cannot

**Not stated here: `S(W)` itself, and therefore the first of the two equalities.** `S` is built
from `Ric(W₋)`, `δ² = ‖Alt(W₋)‖²`, `θ` and traces of `W₋`, all of which need the curvature base
layer. *`‖Alt(·)‖²`'s normalisation was recorded here as unsettled and is now settled*:
[conventions.md](../../../findings/conventions.md) carries the `⅓` in `Alt`, and
[AltPart.lean](../Base/AltPart.lean) fixes the `¼` in the norm, two of the record's own values
agreeing on it, `‖⋆‖² = 6` and `δ²(W_{ℂP²}) = 1/9`. **What still blocks `S(W)` is `Ric(W₋)` and
the traces of `W₋`**, not the normalisation. The identity `S = tr(P_{E₋} W₋^# P_{E₋})`
is the conditional half, and the record itself holds it conditional on (F1) and (F2), with generic
critical points violating them.

**Stated and proved here, with no `sorry`:**

* `sharp_compression`, the second equality,
  `tr(P A^# P) = ½ ∑_{i,j} aᵢaⱼ ‖P[vᵢ,vⱼ]‖²`, in a Lie-bracket model of `Λ²ℝⁿ`. This is the
  closed form as such: the slack read as bracket mass weighted by the spectrum.
* `sharp_compression_nonneg`, its sign, which is where "the slack is exactly the bracket mass
  `E₋` fails to expel" becomes `S ≥ 0` *on that class*. The record's `μᵢ ≥ 0` is what carries it.
* `trace_compression_nonneg`, the reason each `T_k` of the record's unconditional decomposition
  `S = T₁ + 2T₂ + T₃` is nonnegative: a compression of a positive semidefinite operator is.
* `F1`, `F2`, `F3`, `Graded` and `graded_imp_guard`, the two bracket conditions written out, and
  the record's correction that they are two of the three grading conditions, the third being the
  clause the slack exists to measure.

*The arithmetic of `S = T₁ + 2T₂ + T₃` and the guard's role in it is already recorded in
[L12.lean](L12.lean); this file adds the closed form, which that one does not carry.*
-/

namespace HamiltonsCubic.L12

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]

/-! ## The two bracket conditions, and the third they leave out -/

/-- **(F1) `[E₊,E₊] ⊥ E₋`.** -/
def F1 (br : V → V → V) (Eplus Eminus : Submodule ℝ V) : Prop :=
  ∀ x ∈ Eplus, ∀ y ∈ Eplus, ∀ z ∈ Eminus, (inner ℝ (br x y) z : ℝ) = 0

/-- **(F2) `[E₊,E₋] ⊆ E₋`.** -/
def F2 (br : V → V → V) (Eplus Eminus : Submodule ℝ V) : Prop :=
  ∀ x ∈ Eplus, ∀ y ∈ Eminus, br x y ∈ Eminus

/-- **(F3) `[E₋,E₋] ⊥ E₋`**, the third grading condition, and the one the slack exists to
measure. -/
def F3 (br : V → V → V) (Eminus : Submodule ℝ V) : Prop :=
  ∀ x ∈ Eminus, ∀ y ∈ Eminus, ∀ z ∈ Eminus, (inner ℝ (br x y) z : ℝ) = 0

/-- Gradedness is the conjunction of the three. -/
def Graded (br : V → V → V) (Eplus Eminus : Submodule ℝ V) : Prop :=
  F1 br Eplus Eminus ∧ F2 br Eplus Eminus ∧ F3 br Eminus

/-- **The guard is two of the three grading conditions.** So the fence assumes all of gradedness
except the clause the slack measures, the record's correction to the block's *"on the structured
class"*. -/
theorem graded_imp_guard (br : V → V → V) (Eplus Eminus : Submodule ℝ V)
    (h : Graded br Eplus Eminus) : F1 br Eplus Eminus ∧ F2 br Eplus Eminus :=
  ⟨h.1, h.2.1⟩

/-! ## The closed form

*`w i j` stands for `[vᵢ,vⱼ]`, the bracket of two eigenvectors of `W₋`; `mu i` for `μᵢ`, with
`W vᵢ = -μᵢ vᵢ` on `E₋`, so that `(-μᵢ)(-μⱼ) = μᵢμⱼ` is the weight `#` attaches to the pair; and
`P` for the orthogonal projection `P_{E₋}`, of which only symmetry is used.* -/

/-- `A^#` written in `A`'s own eigenbasis: `A^#(x) = ½ ∑_{i,j} aᵢaⱼ ⟪x,[vᵢ,vⱼ]⟫ [vᵢ,vⱼ]`.

*This is `#` expanded bilinearly, which is the step the record names, `[A vᵢ, A vⱼ] = aᵢaⱼ
[vᵢ,vⱼ]` on an eigenbasis.* -/
noncomputable def sharpEigen (mu : ι → ℝ) (w : ι → ι → V) (x : V) : V :=
  (1 / 2 : ℝ) • ∑ i, ∑ j, (mu i * mu j * (inner ℝ x (w i j) : ℝ)) • w i j

/-- The trace of the compression `P T P`, taken against an orthonormal basis. -/
noncomputable def traceCompression (b : OrthonormalBasis ι ℝ V) (P : V →ₗ[ℝ] V) (T : V → V) : ℝ :=
  ∑ k, (inner ℝ (b k) (P (T (P (b k)))) : ℝ)

/-- Parseval on an orthonormal basis, in the real form the computation uses. -/
theorem sum_sq_inner (b : OrthonormalBasis ι ℝ V) (x : V) :
    ∑ k, (inner ℝ (b k) x : ℝ) ^ 2 = ‖x‖ ^ 2 := by
  have h := b.sum_inner_mul_inner x x
  rw [real_inner_self_eq_norm_sq] at h
  rw [← h]
  exact Finset.sum_congr rfl fun k _ => by rw [real_inner_comm x (b k)]; ring

/-- **The closed form: `tr(P A^# P) = ½ ∑_{i,j} μᵢμⱼ ‖P[vᵢ,vⱼ]‖²`.**

Only symmetry of `P` is used; idempotence is not needed. -/
theorem sharp_compression (b : OrthonormalBasis ι ℝ V) (P : V →ₗ[ℝ] V)
    (hP : ∀ x y : V, (inner ℝ (P x) y : ℝ) = inner ℝ x (P y))
    (mu : ι → ℝ) (w : ι → ι → V) :
    traceCompression b P (sharpEigen mu w)
      = 1 / 2 * ∑ i, ∑ j, mu i * mu j * ‖P (w i j)‖ ^ 2 := by
  have hterm : ∀ k : ι, (inner ℝ (b k) (P (sharpEigen mu w (P (b k)))) : ℝ)
      = 1 / 2 * ∑ i, ∑ j, mu i * mu j * (inner ℝ (b k) (P (w i j)) : ℝ) ^ 2 := by
    intro k
    simp only [sharpEigen, map_smul, map_sum, inner_smul_right, inner_sum]
    congr 1
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    rw [hP (b k) (w i j)]
    ring
  unfold traceCompression
  rw [Finset.sum_congr rfl fun k _ => hterm k, ← Finset.mul_sum]
  congr 1
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.mul_sum, sum_sq_inner b (P (w i j))]

/-- **The sign of the closed form.** With `μᵢ ≥ 0`, which is what `W vᵢ = -μᵢ vᵢ` on the negative
eigenspace gives, every term is a nonnegative multiple of a squared norm, so the slack is
nonnegative *on the class where the identity holds*.

*The record's `S ≥ 0` printed with `W` free is a different claim, and a false one: its own witness
gives margin `-0.18` at `n = 6`.* -/
theorem sharp_compression_nonneg (mu : ι → ℝ) (w : ι → ι → V) (P : V →ₗ[ℝ] V)
    (hmu : ∀ i, 0 ≤ mu i) :
    0 ≤ 1 / 2 * ∑ i, ∑ j, mu i * mu j * ‖P (w i j)‖ ^ 2 := by
  have : 0 ≤ ∑ i, ∑ j, mu i * mu j * ‖P (w i j)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ =>
      mul_nonneg (mul_nonneg (hmu i) (hmu j)) (sq_nonneg _)
  linarith

/-- **A compression of a positive semidefinite operator is nonnegative.** This is the record's
reason each `T_k` of the unconditional decomposition `S = T₁ + 2T₂ + T₃` is nonnegative, and so
the reason `S ≥ 0` needs no guard at all in that form. -/
theorem trace_compression_nonneg (b : OrthonormalBasis ι ℝ V) (P : V →ₗ[ℝ] V)
    (hP : ∀ x y : V, (inner ℝ (P x) y : ℝ) = inner ℝ x (P y))
    (B : V →ₗ[ℝ] V) (hB : ∀ x : V, 0 ≤ (inner ℝ x (B x) : ℝ)) :
    0 ≤ traceCompression b P (fun x => B x) := by
  unfold traceCompression
  refine Finset.sum_nonneg fun k _ => ?_
  have h : (inner ℝ (b k) (P (B (P (b k)))) : ℝ) = inner ℝ (P (b k)) (B (P (b k))) := by
    rw [hP (b k) (B (P (b k)))]
  rw [h]
  exact hB _

end HamiltonsCubic.L12
