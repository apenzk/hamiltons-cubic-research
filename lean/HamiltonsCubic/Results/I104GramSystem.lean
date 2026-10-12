import Mathlib

set_option linter.style.longLine false

/-!
# I104's joint Gram system, as scalar algebra

## What this file is

[I104](../../../plan.md) carries a joint system on the three pattern projections, recorded in its
[working note](../../../reviews/2026-09-14-I104-tau-positive.md) in two forms. A Gate 2 brief named
two steps of it as TYPEABLE AND UNTYPED, and this file closes both rather than recording them as a
debt. *Neither needs a matrix: both are identities and inequalities in nine reals, so they type in the
base layer exactly as they stand.*

The system, as the record states it, with `q_a = α_a e_a + β_a f_a` and `u_a² = α_a² + β_a²`:

  `t ≥ Σ β_a² + (3/2) Σ α_a² - (3/10) (Σ α_a)²`,

equivalently, under `α_i = √3 x_i`,

  `Σ u_i² ≤ t - (3/2) Σ x_i² + (9/10) (Σ x_i)²`.

## What is proved

* `joint_system_substitute`: the first form's right side, rewritten with `β_a² = u_a² - α_a²`, is
  `Σ u_a² + (1/2) Σ α_a² - (3/10) (Σ α_a)²`. *This is the step the note performs in words, and it is
  where a sign or a coefficient would go wrong unnoticed.*
* `alpha_to_x`: the rescaling under `α_i = s x_i` with `s² = 3`, carrying `(1/2, 3/10)` to
  `(3/2, 9/10)`. *Stated against a constant `s` with `s² = 3` rather than `√3`, so the content is
  `ring` rather than a square-root lemma.*
* `sum_sq_three`: `(x₁+x₂+x₃)² ≤ 3(x₁²+x₂²+x₃²)`, the Cauchy-Schwarz step at three terms.
* `forcing`: the consequence the note draws. If the `x`-dependent part must supply at least `d`, then
  `Σ x_i² ≥ (5/6) d`. *The constant is `5/6` and the note writes it as `1/1.2`, which is the same
  number and the reason it is worth typing: `27/10 - 3/2 = 6/5`.*

* `Ge`, `Msys` and their two-sided inverse relation, both spectra, and `λ_max(G_e) = 5/3` with the
  all-ones vector attaining it. *This is the matrix half the record uses, and it is four lines of
  rational arithmetic rather than the blocker a trailer once recorded it as.*

## What is NOT stated

That a configuration's three pattern planes REALISE `G_e`: that each cross-Gram has rank one with
principal cosines `(1/3, 0)`. That is a statement about four-sets and their pattern planes, and the
objects it quantifies over are the ones this layer does not define.
-/

namespace HamiltonsCubic.I104GramSystem

open Matrix

/-- **The substitution the note performs in words.** With `β_a² = u_a² - α_a²`, the first form's
right side becomes `Σ u_a² + (1/2) Σ α_a² - (3/10) (Σ α_a)²`.

*A coefficient or a sign going wrong here is invisible in prose and changes the forcing constant.* -/
theorem joint_system_substitute (a₁ a₂ a₃ u₁ u₂ u₃ : ℝ) :
    (u₁ ^ 2 - a₁ ^ 2) + (u₂ ^ 2 - a₂ ^ 2) + (u₃ ^ 2 - a₃ ^ 2)
        + 3 / 2 * (a₁ ^ 2 + a₂ ^ 2 + a₃ ^ 2) - 3 / 10 * (a₁ + a₂ + a₃) ^ 2
      = (u₁ ^ 2 + u₂ ^ 2 + u₃ ^ 2)
        + 1 / 2 * (a₁ ^ 2 + a₂ ^ 2 + a₃ ^ 2) - 3 / 10 * (a₁ + a₂ + a₃) ^ 2 := by
  ring

/-- **The rescaling under `α_i = s x_i` with `s² = 3`**, carrying `(1/2, 3/10)` to `(3/2, 9/10)`.

*Stated against a constant `s` with `s² = 3` rather than against `√3`, so that the content is the
scaling rather than a square-root lemma.* -/
theorem alpha_to_x (s x₁ x₂ x₃ : ℝ) (hs : s ^ 2 = 3) :
    1 / 2 * ((s * x₁) ^ 2 + (s * x₂) ^ 2 + (s * x₃) ^ 2)
        - 3 / 10 * (s * x₁ + s * x₂ + s * x₃) ^ 2
      = 3 / 2 * (x₁ ^ 2 + x₂ ^ 2 + x₃ ^ 2) - 9 / 10 * (x₁ + x₂ + x₃) ^ 2 := by
  linear_combination (1 / 2 * (x₁ ^ 2 + x₂ ^ 2 + x₃ ^ 2) - 3 / 10 * (x₁ + x₂ + x₃) ^ 2) * hs

/-- **Cauchy-Schwarz at three terms**, which is what caps the `x`-dependent part's contribution. -/
theorem sum_sq_three (x₁ x₂ x₃ : ℝ) :
    (x₁ + x₂ + x₃) ^ 2 ≤ 3 * (x₁ ^ 2 + x₂ ^ 2 + x₃ ^ 2) := by
  nlinarith [sq_nonneg (x₁ - x₂), sq_nonneg (x₁ - x₃), sq_nonneg (x₂ - x₃)]

/-- **The forcing the note draws.** If the `x`-dependent part must supply at least `d`, then
`Σ x_i² ≥ (5/6) d`.

*The constant comes out of `27/10 - 3/2 = 6/5`, and the note writes `5/6` as `1/1.2`, which is why it
is worth typing: the two spellings are the same number and only one of them is checkable by eye.* -/
theorem forcing (x₁ x₂ x₃ d : ℝ)
    (h : d ≤ 9 / 10 * (x₁ + x₂ + x₃) ^ 2 - 3 / 2 * (x₁ ^ 2 + x₂ ^ 2 + x₃ ^ 2)) :
    5 / 6 * d ≤ x₁ ^ 2 + x₂ ^ 2 + x₃ ^ 2 := by
  nlinarith [sq_nonneg (x₁ - x₂), sq_nonneg (x₁ - x₃), sq_nonneg (x₂ - x₃)]

/-- **THE FORCING AT THE SURVIVING CONFIGURATION**, `t = 0.346`, where `S₂ ≥ 0.190268`.

*This is `forcing` at `d = 142701/625000 = 0.2283216`, giving `47567/250000 = 0.190268` exactly.* -/
theorem forcing_at_surviving_config (x₁ x₂ x₃ : ℝ)
    (h : (142701 : ℝ) / 625000 ≤ 9 / 10 * (x₁ + x₂ + x₃) ^ 2
      - 3 / 2 * (x₁ ^ 2 + x₂ ^ 2 + x₃ ^ 2)) :
    (47567 : ℝ) / 250000 ≤ x₁ ^ 2 + x₂ ^ 2 + x₃ ^ 2 := by
  have := forcing x₁ x₂ x₃ ((142701 : ℝ) / 625000) h
  linarith

/-- **THE SAME AT `t = 0.598`, WHICH IS AN EXCLUDED CONFIGURATION**, kept because the record's
`0.116707` is quoted from it and a reader meeting that number needs to find it here.

**[r983](../../../reviews/REVIEW_r983.md) REFUTED THE FIGURE'S PLACEMENT, not its arithmetic.**
*`t = 0.598` is a configuration the Gram bound EXCLUDES; the surviving one is `t = 0.346`, where the
forcing is `0.190268` and is typed above.* The two I104 blocks stand at four different
configurations, and the sentence joining them was never well posed
([LEDGER.md](../../../findings/LEDGER.md)).

*Arithmetically: at `d = 8753/62500 = 0.140048`, the bound is `8753/75000 = 0.1167066…`, and the
record's `0.116707` ROUNDS UP from it.* **Rounding a LOWER bound up is the unsafe direction**, since
it asserts more than the arithmetic delivers, so the record's figure is the one to read with care
and the rational is what the theorem carries. *Two earlier versions of this docstring got this
wrong: one said the record rounded down, and its replacement named rounding down as the unsafe
direction* ([r1042](../../../reviews/REVIEW_r1042.md)). -/
theorem forcing_at_excluded_config (x₁ x₂ x₃ : ℝ)
    (h : (8753 : ℝ) / 62500 ≤ 9 / 10 * (x₁ + x₂ + x₃) ^ 2
      - 3 / 2 * (x₁ ^ 2 + x₂ ^ 2 + x₃ ^ 2)) :
    (8753 : ℝ) / 75000 ≤ x₁ ^ 2 + x₂ ^ 2 + x₃ ^ 2 := by
  have := forcing x₁ x₂ x₃ ((8753 : ℝ) / 62500) h
  linarith

/-! ## The shared-channel Gram matrix and its inverse

**`G_e` IS THREE UNIT VECTORS AT PAIRWISE COSINE `1/3`**, which is what the three overlapping
four-set pattern planes give: each cross-Gram has rank one and the principal cosines are exactly
`(1/3, 0)`. So `G_e = (2/3) I + (1/3) J` on `ℝ³`, and the system's own quadratic form is
`M = (3/2) I - (3/10) J`. *The two are inverse, which is the fact the record uses and the reason a
debt was recorded against this file: it is four lines of rational arithmetic, so it is built here.*

The spectra follow from `J` having eigenvalue `3` on the constants and `0` on the mean-zero plane:
`G_e` carries `5/3` and `2/3`, and `M` carries `3/5` and `3/2`. **`λ_max(G_e) = 5/3` is the constant
the record's `Σ u_i² ≤ (5/3) t` comes from, and `λ_min(M) = 3/5` is the same statement dualised.** -/

/-- `M = (3/2) I - (3/10) J`, the quadratic form the joint system puts on the `α`-part. -/
noncomputable def Msys : Matrix (Fin 3) (Fin 3) ℝ := Matrix.of fun i j => if i = j then 6 / 5 else -(3 / 10)

/-- `G_e = (2/3) I + (1/3) J`, the Gram matrix of three unit vectors at pairwise cosine `1/3`. -/
noncomputable def Ge : Matrix (Fin 3) (Fin 3) ℝ := Matrix.of fun i j => if i = j then 1 else 1 / 3

/-- **`G_e M = 1`.** *The record states this as `G_e(3/2 I - 3/10 J) = I` and it is what the debt
named as missing.* -/
theorem Ge_mul_Msys : Ge * Msys = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Ge, Msys, Matrix.mul_apply, Fin.sum_univ_three] <;> norm_num

/-- **`M G_e = 1`**, so `G_e` is a two-sided inverse and `M` is invertible. -/
theorem Msys_mul_Ge : Msys * Ge = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Ge, Msys, Matrix.mul_apply, Fin.sum_univ_three] <;> norm_num

/-- **The matrix IS the system's form**: `xᵀ M x` is the `(3/2, 3/10)` expression the note writes. -/
theorem Msys_quadForm (x : Fin 3 → ℝ) :
    x ⬝ᵥ (Msys *ᵥ x)
      = 3 / 2 * (x 0 ^ 2 + x 1 ^ 2 + x 2 ^ 2) - 3 / 10 * (x 0 + x 1 + x 2) ^ 2 := by
  simp [Msys, dotProduct, Matrix.mulVec, Fin.sum_univ_three]
  ring

/-- **The same for `G_e`**: `uᵀ G_e u = (2/3)‖u‖² + (1/3)(Σ u)²`. -/
theorem Ge_quadForm (u : Fin 3 → ℝ) :
    u ⬝ᵥ (Ge *ᵥ u)
      = 2 / 3 * (u 0 ^ 2 + u 1 ^ 2 + u 2 ^ 2) + 1 / 3 * (u 0 + u 1 + u 2) ^ 2 := by
  simp [Ge, dotProduct, Matrix.mulVec, Fin.sum_univ_three]
  ring

/-- **The top eigenvector**: `G_e 1 = (5/3) 1`, so `5/3` is attained. -/
theorem Ge_mulVec_ones : Ge *ᵥ (fun _ => 1) = fun _ => (5 / 3 : ℝ) := by
  ext i
  fin_cases i <;> simp [Ge, Matrix.mulVec, dotProduct, Fin.sum_univ_three] <;> norm_num

/-- **The rest of the spectrum**: on the mean-zero plane `G_e` acts as `2/3`. -/
theorem Ge_mulVec_of_sum_zero (u : Fin 3 → ℝ) (h : u 0 + u 1 + u 2 = 0) :
    Ge *ᵥ u = (2 / 3 : ℝ) • u := by
  ext i
  fin_cases i <;> simp [Ge, Matrix.mulVec, dotProduct, Fin.sum_univ_three] <;> linarith

/-- **`λ_max(G_e) = 5/3`**, the constant the record's `Σ u_i² ≤ (5/3) t` rests on. -/
theorem Ge_quadForm_le (u : Fin 3 → ℝ) : u ⬝ᵥ (Ge *ᵥ u) ≤ 5 / 3 * (u ⬝ᵥ u) := by
  rw [Ge_quadForm]
  simp only [dotProduct, Fin.sum_univ_three]
  nlinarith [sq_nonneg (u 0 - u 1), sq_nonneg (u 0 - u 2), sq_nonneg (u 1 - u 2)]

/-- **And `5/3` cannot be improved**, being attained at the all-ones vector. -/
theorem Ge_quadForm_eq_at_ones :
    (fun _ => 1 : Fin 3 → ℝ) ⬝ᵥ (Ge *ᵥ (fun _ => 1 : Fin 3 → ℝ))
      = 5 / 3 * ((fun _ => 1 : Fin 3 → ℝ) ⬝ᵥ (fun _ => 1 : Fin 3 → ℝ)) := by
  simp [Ge, dotProduct, Matrix.mulVec, Fin.sum_univ_three]
  norm_num

/-- **`λ_min(M) = 3/5`, the same statement dualised**, and the form in which the system is used: a
budget `t` on `xᵀ M x` caps `‖x‖²` at `(5/3) t`. -/
theorem Msys_quadForm_ge (x : Fin 3 → ℝ) : 3 / 5 * (x ⬝ᵥ x) ≤ x ⬝ᵥ (Msys *ᵥ x) := by
  rw [Msys_quadForm]
  simp only [dotProduct, Fin.sum_univ_three]
  nlinarith [sq_nonneg (x 0 - x 1), sq_nonneg (x 0 - x 2), sq_nonneg (x 1 - x 2)]

/-- **AND `3/5` CANNOT BE IMPROVED**, being attained at the all-ones vector, where both sides are
`9/5`. *`Ge_quadForm_eq_at_ones` is the same statement on the other side of the inverse*, so the
pair `λ_max(Ge) = 5/3` and `λ_min(Msys) = 3/5` is sharp at both ends and the record's `5/3` is the
best constant its own system admits. *Noted as dropped from the first fold by
[r1045](../../../reviews/REVIEW_r1045.md).* -/
theorem Msys_quadForm_eq_at_ones :
    (fun _ => 1 : Fin 3 → ℝ) ⬝ᵥ (Msys *ᵥ (fun _ => 1 : Fin 3 → ℝ))
      = 3 / 5 * ((fun _ => 1 : Fin 3 → ℝ) ⬝ᵥ (fun _ => 1 : Fin 3 → ℝ)) := by
  simp [Msys, dotProduct, Matrix.mulVec, Fin.sum_univ_three]
  norm_num

/-- **The `α`-part alone**: if the system's form is at most `t`, then `Σ α_a² ≤ (5/3) t`.

**THIS IS NOT THE RECORD'S `Σ u_a² ≤ (5/3) t`**, and an earlier docstring here said it was.
*`Msys` acts on the `α`-part, so this concludes about `Σ α_a²`, which equals `Σ u_a²` only where
`β = 0`.* The record's statement is `sum_u_sq_le_of_joint_system` below, and it needs the `β` term
on the left of the hypothesis where the note puts it ([r1042](../../../reviews/REVIEW_r1042.md)). -/
theorem sum_alpha_sq_le_of_quadForm_le (x : Fin 3 → ℝ) (t : ℝ) (h : x ⬝ᵥ (Msys *ᵥ x) ≤ t) :
    x ⬝ᵥ x ≤ 5 / 3 * t := by
  have := Msys_quadForm_ge x
  linarith

/-- **THE RECORD'S SCALAR BOUND, `Σ u_a² ≤ (5/3) t`**, with `u_a² = α_a² + β_a²` as the note
defines it and the system in the form the note states it.

*The `β` term sits on the SMALL side of the hypothesis and on the LARGE side of the conclusion, so
it cannot be dropped: what makes the bound come out is that `λ_min(Msys) = 3/5` beats `1` on the
`α`-part, and the `β` mass is then carried across at a favourable rate.* -/
theorem sum_u_sq_le_of_joint_system (al be : Fin 3 → ℝ) (t : ℝ)
    (h : (∑ i, be i ^ 2) + al ⬝ᵥ (Msys *ᵥ al) ≤ t) :
    ∑ i, (al i ^ 2 + be i ^ 2) ≤ 5 / 3 * t := by
  have hq := Msys_quadForm_ge al
  have hbe : 0 ≤ ∑ i, be i ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
  have hdot : al ⬝ᵥ al = ∑ i, al i ^ 2 := by simp [dotProduct, sq]
  rw [Finset.sum_add_distrib]
  rw [hdot] at hq
  linarith

/-! ## `joint_system_holds`, typed

**The debt is now a proposition rather than a sentence.** *Reading the note's own statement back,
what it calls the joint system is Bessel's inequality for a NON-ORTHONORMAL frame*: with `q_a` the
projections of `D` onto the three pattern planes, `α_a = ⟪D, e_a⟫` on the shared channels and
`β_a = ⟪D, f_a⟫` on the orthogonal ones, the least `‖D‖²` compatible with those inner products is
`α ᵀ G_e⁻¹ α + Σ β_a²`, and `G_e⁻¹` is `Msys`. **That is why the system carries `Msys` and not
`G_e`**, which reads as a transposition until the minimal-norm reading is written down.

*So the content is a minimum over the vectors with prescribed inner products, which is what the note
means by "minimality of the `e`-part".* -/

/-- **`joint_system_holds`.** Given three unit shared-channel directions whose Gram is `Ge`, and
three further unit directions orthogonal to them and to each other, the squared norm of `D` is at
least the system's right side.

**PROVED, 2026-09-21, and it needed no Bessel.** *An earlier docstring recorded the debt as the
non-orthonormal counterpart of Bessel, which Mathlib carries only for an orthonormal family. That
describes the STATEMENT correctly and the DIFFICULTY wrongly*: the content is one completed square.
Take `u = Σ (Msys ᵥ* al)_a e_a + Σ be_a f_a` and expand `0 ≤ ⟪D - u, D - u⟫`. The cross terms die by
`hef`, `⟪D,u⟫` and `‖u‖²` both collapse to `al ⬝ᵥ (Msys *ᵥ al) + Σ be²` because `Ge_mul_Msys` makes
`Ge *ᵥ (Msys *ᵥ al) = al`, and the inequality is what is left. **No orthogonal projection and no
Bessel**, only that a norm-square is non-negative. -/
theorem joint_system_holds {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E]
    (e f : Fin 3 → E) (D : E) (al be : Fin 3 → ℝ) (t : ℝ)
    (ht : ‖D‖ ^ 2 = t)
    (heGram : ∀ a b, (inner ℝ (e a) (e b) : ℝ) = Ge a b)
    (hfOrthonormal : ∀ a b, (inner ℝ (f a) (f b) : ℝ) = if a = b then 1 else 0)
    (hef : ∀ a b, (inner ℝ (e a) (f b) : ℝ) = 0)
    (hal : ∀ a, (inner ℝ D (e a) : ℝ) = al a)
    (hbe : ∀ a, (inner ℝ D (f a) : ℝ) = be a) :
    (∑ a, be a ^ 2) + al ⬝ᵥ (Msys *ᵥ al) ≤ t := by
  classical
  set c : Fin 3 → ℝ := Msys *ᵥ al with hc
  set P : E := ∑ a, c a • e a with hP
  set F : E := ∑ a, be a • f a with hF
  -- Everything below lands on the SAME scalar, `∑ a, c a * al a`.
  have hGec : ∀ a, (∑ b, Ge a b * c b) = al a := by
    intro a
    have h : Ge *ᵥ c = al := by
      rw [hc, Matrix.mulVec_mulVec, Ge_mul_Msys, Matrix.one_mulVec]
    have := congrFun h a
    simpa [Matrix.mulVec, dotProduct] using this
  have htarget : al ⬝ᵥ (Msys *ᵥ al) = ∑ a, c a * al a := by
    simp only [dotProduct, hc]
    exact Finset.sum_congr rfl fun a _ => mul_comm _ _
  have hDP : (inner ℝ D P : ℝ) = ∑ a, c a * al a := by
    rw [hP, inner_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [real_inner_smul_right, hal]
  have hDF : (inner ℝ D F : ℝ) = ∑ a, be a ^ 2 := by
    rw [hF, inner_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [real_inner_smul_right, hbe, pow_two]
  have hPP : (inner ℝ P P : ℝ) = ∑ a, c a * al a := by
    rw [hP, sum_inner]
    have step : ∀ a, (inner ℝ (c a • e a) (∑ b, c b • e b) : ℝ) = c a * al a := by
      intro a
      rw [inner_sum, ← hGec a, Finset.mul_sum]
      refine Finset.sum_congr rfl fun b _ => ?_
      rw [real_inner_smul_left, real_inner_smul_right, heGram]
      ring
    exact Finset.sum_congr rfl fun a _ => step a
  have hFF : (inner ℝ F F : ℝ) = ∑ a, be a ^ 2 := by
    rw [hF, sum_inner]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [inner_sum]
    rw [Finset.sum_eq_single a]
    · rw [real_inner_smul_left, real_inner_smul_right, hfOrthonormal]
      simp [pow_two]
    · intro b _ hb
      rw [real_inner_smul_left, real_inner_smul_right, hfOrthonormal]
      simp [Ne.symm hb]
    · intro h; exact absurd (Finset.mem_univ a) h
  have hPF : (inner ℝ P F : ℝ) = 0 := by
    rw [hP, sum_inner]
    refine Finset.sum_eq_zero fun a _ => ?_
    rw [inner_sum]
    refine Finset.sum_eq_zero fun b _ => ?_
    rw [real_inner_smul_left, real_inner_smul_right, hef]
    ring
  -- Expanding `0 ≤ ⟪D - (P + F), D - (P + F)⟫` is the whole of it.
  have hnn : (0:ℝ) ≤ (inner ℝ (D - (P + F)) (D - (P + F)) : ℝ) := real_inner_self_nonneg
  have hDD : (inner ℝ D D : ℝ) = t := by rw [real_inner_self_eq_norm_sq, ht]
  have hexp : (inner ℝ (D - (P + F)) (D - (P + F)) : ℝ)
      = (inner ℝ D D : ℝ) - 2 * ((inner ℝ D P : ℝ) + (inner ℝ D F : ℝ))
        + ((inner ℝ P P : ℝ) + 2 * (inner ℝ P F : ℝ) + (inner ℝ F F : ℝ)) := by
    simp only [inner_sub_left, inner_sub_right, inner_add_left, inner_add_right,
      real_inner_comm P D, real_inner_comm F D, real_inner_comm F P]
    ring
  rw [hexp, hDD, hDP, hDF, hPP, hPF, hFF] at hnn
  rw [htarget]
  linarith

/-! ## What is NOT stated, and the debt that names it

**`joint_system_holds` IS PROVED above, and what is missing is the GEOMETRY alone.**
*The algebra it needed is above: `G_e`, its two-sided inverse `M`, both spectra, and the `5/3` the
record's scalar bound comes from.* What remains unstated is that a configuration's three pattern
planes REALISE this `G_e`, that each cross-Gram has rank one with principal cosines `(1/3, 0)`,
which is a statement about four-sets and their pattern planes and needs objects this layer does not
define.

*A `Lean: blocked` trailer once named this `sharedChannelGram` and was closed as void on the
grounds that the forcing is typed. [r1038](../../../reviews/REVIEW_r1038.md) REFUTED that closure:
the debt named the SYSTEM, not the forcing, and this file's own heading said so throughout.* **The
debt now names the part that is genuinely out of reach rather than the part that was four lines of
rational arithmetic.** -/

end HamiltonsCubic.I104GramSystem
