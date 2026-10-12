import Mathlib
import HamiltonsCubic.Base.SelfDual

/-!
# The Bianchi half of R38, traced, is rows (B) and (C)

[the per-vector note](../../../reviews/2026-09-25-I73c-per-vector-rows.md), the paragraph on the
Bianchi half traced; [post F79](../../../findings/fence-posts.md).

**`wedge_gram`**: for skew `X`, `Y`, `∑_{abcd} (X∧X)_{abcd} (Y∧Y)_{abcd} = 12 tr(XY)² − 24 tr(XYXY)`,
in the layer's `wedgeSelf` convention. Summed over orthonormal bases of two eigenspaces this gives, in
the record's units, `⟨Ω_a, Ω_b⟩ = 2 δ_ab m_a − G_ab + 2 ∑_c t_cab` with `Ω_c = ∑_{ψ ∈ E_c} ψ ∧ ψ`.

**`bianchi_traced`**: on the symmetric family (`G₀₀ = G₀₂ = G₂₂`, `G₀₁ = G₂₁`), the three pairings
`⟨Ω₀ − Ω₂, Ω_c⟩ = 0` are rows (B₀), (B₁), (B₂) of the traced class system, and `‖Ω₀ − Ω₂‖²` is the
sum (C₀) + (C₁) + (C₂), so Bianchi adds nothing to the nine rows in traced form.
-/

open HamiltonsCubic.RealLayer HamiltonsCubic.SelfDualLayer Matrix

namespace HamiltonsCubic.BianchiTraced

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

section WedgeGram

theorem sw0 (f : ι → ι → ι → ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ a, ∑ b, ∑ c, ∑ d, f b a c d := Finset.sum_comm

theorem sw1 (f : ι → ι → ι → ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ a, ∑ b, ∑ c, ∑ d, f a c b d :=
  Finset.sum_congr rfl fun _ _ => Finset.sum_comm

theorem sw2 (f : ι → ι → ι → ι → ℝ) :
    ∑ a, ∑ b, ∑ c, ∑ d, f a b c d = ∑ a, ∑ b, ∑ c, ∑ d, f a b d c :=
  Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => Finset.sum_comm

theorem U11 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d
      = ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d := by
  have sX : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j; simpa [Matrix.transpose_apply] using this
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  calc ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d := by
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
        ring

theorem U12 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a c * Y b d
      = ∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
  have sX : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j; simpa [Matrix.transpose_apply] using this
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  calc ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a c * Y b d
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a c * X b d * Y a b * Y c d := sw1 (fun a b c d => X a b * X c d * Y a c * Y b d)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X b c * X a d * Y b a * Y c d := sw0 (fun a b c d => X a c * X b d * Y a b * Y c d)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
        rw [sX c b, sY d c]; ring

theorem U13 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a d * Y b c
      = -∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
  have sX : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j; simpa [Matrix.transpose_apply] using this
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  calc ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a d * Y b c
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X b a * X c d * Y b d * Y a c := sw0 (fun a b c d => X a b * X c d * Y a d * Y b c)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X c a * X b d * Y c d * Y a b := sw1 (fun a b c d => X b a * X c d * Y b d * Y a c)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X c b * X a d * Y c d * Y b a := sw0 (fun a b c d => X c a * X b d * Y c d * Y a b)
      _ = -∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
        simp only [← Finset.sum_neg_distrib]
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
        rw [sY d c]; ring

theorem U21 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, X a c * X b d * Y a b * Y c d
      = ∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
  have sX : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j; simpa [Matrix.transpose_apply] using this
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  calc ∑ a, ∑ b, ∑ c, ∑ d, X a c * X b d * Y a b * Y c d
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X b c * X a d * Y b a * Y c d := sw0 (fun a b c d => X a c * X b d * Y a b * Y c d)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
        rw [sX c b, sY d c]; ring

theorem U22 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, X a c * X b d * Y a c * Y b d
      = ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d := by
  have sX : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j; simpa [Matrix.transpose_apply] using this
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  calc ∑ a, ∑ b, ∑ c, ∑ d, X a c * X b d * Y a c * Y b d
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d := sw1 (fun a b c d => X a c * X b d * Y a c * Y b d)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d := by
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
        ring

theorem U23 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, X a c * X b d * Y a d * Y b c
      = ∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
  have sX : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j; simpa [Matrix.transpose_apply] using this
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  calc ∑ a, ∑ b, ∑ c, ∑ d, X a c * X b d * Y a d * Y b c
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X b c * X a d * Y b d * Y a c := sw0 (fun a b c d => X a c * X b d * Y a d * Y b c)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X c b * X a d * Y c d * Y a b := sw1 (fun a b c d => X b c * X a d * Y b d * Y a c)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
        rw [sY d c, sY b a]; ring

theorem U31 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, X a d * X b c * Y a b * Y c d
      = -∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
  have sX : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j; simpa [Matrix.transpose_apply] using this
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  calc ∑ a, ∑ b, ∑ c, ∑ d, X a d * X b c * Y a b * Y c d
      _ = -∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
        simp only [← Finset.sum_neg_distrib]
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
        rw [sX c b, sY b a, sY d c]; ring

theorem U32 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, X a d * X b c * Y a c * Y b d
      = ∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
  have sX : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j; simpa [Matrix.transpose_apply] using this
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  calc ∑ a, ∑ b, ∑ c, ∑ d, X a d * X b c * Y a c * Y b d
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a d * X c b * Y a b * Y c d := sw1 (fun a b c d => X a d * X b c * Y a c * Y b d)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
        rw [sY b a, sY d c]; ring

theorem U33 (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, X a d * X b c * Y a d * Y b c
      = ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d := by
  have sX : ∀ i j, X j i = -X i j := fun i j => by
    have := congrFun (congrFun hX i) j; simpa [Matrix.transpose_apply] using this
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  calc ∑ a, ∑ b, ∑ c, ∑ d, X a d * X b c * Y a d * Y b c
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X b d * X a c * Y b d * Y a c := sw0 (fun a b c d => X a d * X b c * Y a d * Y b c)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X c d * X a b * Y c d * Y a b := sw1 (fun a b c d => X b d * X a c * Y b d * Y a c)
      _ = ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d := by
        refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
          Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
        ring

theorem sq_trace (X Y : Matrix ι ι ℝ) (hY : IsSkew Y) :
    (X * Y).trace ^ 2 = ∑ a, ∑ b, ∑ c, ∑ d, X a b * X c d * Y a b * Y c d := by
  have sY : ∀ i j, Y j i = -Y i j := fun i j => by
    have := congrFun (congrFun hY i) j; simpa [Matrix.transpose_apply] using this
  have ht : (X * Y).trace = -∑ a, ∑ b, X a b * Y a b := by
    simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, ← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
    rw [sY b a]; ring
  rw [ht, neg_sq, sq]
  simp only [Finset.sum_mul, Finset.mul_sum]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ =>
    Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
  ring

theorem trace4 (X Y : Matrix ι ι ℝ) :
    (X * Y * X * Y).trace = ∑ a, ∑ b, ∑ c, ∑ d, X a d * Y d c * X c b * Y b a := by
  simp only [Matrix.trace, Matrix.diag, Matrix.mul_apply, Finset.sum_mul]

end WedgeGram

/-- **The Gram identity of wedge squares.** Diagonal pairings of the three terms of `X ∧ X` against
those of `Y ∧ Y` each give `tr(XY)²` and the six cross pairings each give `−tr(XYXY)`, each by
relabelling the four summation indices (`U12` to `U33`) and the skew symmetry. -/
theorem wedge_gram (X Y : Matrix ι ι ℝ) (hX : IsSkew X) (hY : IsSkew Y) :
    ∑ a, ∑ b, ∑ c, ∑ d, wedgeSelf X a b c d * wedgeSelf Y a b c d
      = 12 * (X * Y).trace ^ 2 - 24 * (X * Y * X * Y).trace := by
  have e : ∀ a b c d, wedgeSelf X a b c d * wedgeSelf Y a b c d
      = 4 * (X a b * X c d * Y a b * Y c d - X a b * X c d * Y a c * Y b d
        + X a b * X c d * Y a d * Y b c - X a c * X b d * Y a b * Y c d
        + X a c * X b d * Y a c * Y b d - X a c * X b d * Y a d * Y b c
        + X a d * X b c * Y a b * Y c d - X a d * X b c * Y a c * Y b d
        + X a d * X b c * Y a d * Y b c) := by
    intro a b c d; rw [wedgeSelf_apply, wedgeSelf_apply]; ring
  simp only [e, ← Finset.mul_sum, Finset.sum_add_distrib, Finset.sum_sub_distrib]
  rw [U12 X Y hX hY, U13 X Y hX hY, U21 X Y hX hY, U22 X Y hX hY, U23 X Y hX hY,
    U31 X Y hX hY, U32 X Y hX hY, U33 X Y hX hY, sq_trace X Y hY, trace4 X Y]
  ring

/-- **Traced Bianchi on the symmetric family is in the span of the rows.** With
`⟨Ω_a, Ω_b⟩ = 2 δ_ab m_a − G_ab + 2 T_ab`, `T_ab = ∑_c t_cab` (totally symmetric `t`), and
`G₀₀ = G₀₂ = G₂₂`, `G₀₁ = G₂₁`: the pairings of `Ω₀ − Ω₂` with `Ω₀`, `Ω₁`, `Ω₂` vanish iff rows
(B₀), (B₁), (B₂) hold, and the norm is twice the sum of the (C) rows' residuals, in the normalisation of `ClassTraceTest.Rows`. -/
theorem bianchi_traced (t000 t001 t002 t011 t012 t022 t112 t122 t222 p κ G00 G01 G02 G21 G22 : ℝ)
    (hG0 : G00 = G02) (hG2 : G22 = G02) (hG1 : G01 = G21) :
    let T00 := t000 + t001 + t002
    let T01 := t001 + t011 + t012
    let T02 := t002 + t012 + t022
    let T21 := t012 + t112 + t122
    let T22 := t022 + t122 + t222
    -- ⟨Ω₀ − Ω₂, Ω₀⟩, ⟨Ω₀ − Ω₂, Ω₁⟩, ⟨Ω₀ − Ω₂, Ω₂⟩
    ((2*p - G00 + 2*T00) - (-G02 + 2*T02) = 0 ↔ t022 - t000 + t012 - t001 = p) ∧
    ((-G01 + 2*T01) - (-G21 + 2*T21) = 0 ↔ t122 - t001 + t112 - t011 = 0) ∧
    ((-G02 + 2*T02) - (2*p - G22 + 2*T22) = 0 ↔ t222 - t002 + t122 - t012 = -p) ∧
    -- the norm ‖Ω₀ − Ω₂‖² is the sum of the (C) rows
    ((2*p - G00 + 2*T00) + (2*p - G22 + 2*T22) - 2*(-G02 + 2*T02)
      = 2 * ((t000 - 2*t002 + t022 + (κ+1)*p) + (t001 - 2*t012 + t122)
        + (t002 - 2*t022 + t222 - (κ-1)*p))) := by
  intro T00 T01 T02 T21 T22
  refine ⟨⟨fun h => ?_, fun h => ?_⟩, ⟨fun h => ?_, fun h => ?_⟩, ⟨fun h => ?_, fun h => ?_⟩, ?_⟩ <;>
    simp only [T00, T01, T02, T21, T22] at * <;> linarith

end HamiltonsCubic.BianchiTraced
