import HamiltonsCubic.Results.L41Statement

set_option linter.style.longLine false

/-!
# L153, the Killing row marginal

[findings/bounds.md](../../../findings/bounds.md), Lemma L153: for every `v ∈ 𝔰𝔬(n)` and every
orthonormal basis `{v_β}` of `Λ²`, `∑_β ‖[v, v_β]‖² = 2(n−2)‖v‖²`, in the record's half-trace norm.

- `L153`: **the marginal at any skew `v`**, for any orthonormal, complete frame (`EigenFrame` of any
  operator supplies one); the frame sum is the `φ`-basis sum by `innerOp_frame`, and that is
  `killing_phi`, `−tr(ad v)²` computed entrywise;
- `L153_basis`: at `v = v_α` a frame vector, the record's original basis form `2(n−2)`.
-/

namespace HamiltonsCubic.L41Statement.Frame

open HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {Γ : Type*} [Fintype Γ] [DecidableEq Γ]
variable {W : Matrix ι ι ℝ → Matrix ι ι ℝ} {v : Γ → Matrix ι ι ℝ} {lam : Γ → ℝ}

/-- **L153**: `∑_β ‖[X, v_β]‖² = 2(n−2)‖X‖²` for every skew `X`. -/
theorem L153 (hf : EigenFrame W v lam) (X : Matrix ι ι ℝ) (hX : IsSkew X) :
    ∑ β, inner2 (br X (v β)) (br X (v β)) = 2 * ((Fintype.card ι : ℝ) - 2) * inner2 X X := by
  have hlin : ∀ c : Γ → ℝ, (fun Y => br X Y) (∑ α, c α • v α) = ∑ α, c α • (fun Y => br X Y) (v α) :=
    fun c => br_sum_r _ _ _ _
  rw [← innerOp_frame hf (fun Y => br X Y) (fun Y => br X Y) hlin hlin]
  unfold innerOp
  exact killing_phi X hX

/-- **L153 at a basis vector**: `∑_β ‖[v_α, v_β]‖² = 2(n−2)`. -/
theorem L153_basis (hf : EigenFrame W v lam) (α : Γ) :
    ∑ β, inner2 (br (v α) (v β)) (br (v α) (v β)) = 2 * ((Fintype.card ι : ℝ) - 2) := by
  rw [L153 hf (v α) (hf.skew α), hf.orthonormal, if_pos rfl, mul_one]

end HamiltonsCubic.L41Statement.Frame
