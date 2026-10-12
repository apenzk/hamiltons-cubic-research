import HamiltonsCubic.Results.I117Four
import Mathlib.Tactic.IrreducibleDef

set_option linter.style.longLine false
set_option linter.unusedSectionVars false
set_option linter.unusedSimpArgs false

/-!
# L263 on `𝔰𝔬(7)`: `𝔤₂` and its heavy positive definite idempotent

[second-order.md](../../../findings/second-order.md)'s L263 exhibits, at `SU(3) ⊂ G₂`, the positive definite idempotent
`C = (9/28) P_{𝔰𝔲(3)} + (3/28) P_𝔭` on `𝔤₂` other than `I/4`, with `‖C‖² = 351/392 > 7/8 = ‖I/4‖²`. This file builds it
inside `𝔰𝔬(7)`, in the layer's normalisation (`I # I = 5I` on `𝔰𝔬(7)`, `P_{𝔤₂} # P_{𝔤₂} = 4 P_{𝔤₂}`):

* **`gv`**: an orthogonal basis of `𝔤₂`. For each index `a` of the octonion 3-form
  `e₀₁₂ + e₀₃₄ + e₀₅₆ + e₁₃₅ - e₁₄₆ - e₂₃₆ - e₂₄₅`, the three `φ_{bc}` with `φ_{abc} ≠ 0` carry one direction of `Λ²₇` and two
  of `𝔤₂`, the difference `u_a` (squared norm `2`) and `w_a` (squared norm `6`); `𝔰𝔲(3)`, the stabiliser of `e₆`, is the
  eight of them avoiding the index `6`.
* **`gv_br`**: the bracket table `[gv i, gv j] = Σ_m (gf6 i j m / 6) gv m`, from `brS_phiS` with every `φ` put in a
  canonical order (`phiS_canon`); **`gv_inner`**: orthogonality.
* **`sharp_rk1_sum`**: `(Σ λᵢ vᵢvᵢᵀ)# = ½ Σᵢⱼ λᵢλⱼ [vᵢ,vⱼ][vᵢ,vⱼ]ᵀ` on any `Λ²`, from `phiTri_rk1`,
  `Φ(S; vvᵀ, wwᵀ) = -⟨S[v,w], [v,w]⟩`; with the table, `#` on the `gv`-diagonal family is the coefficient identity
  `Σᵢⱼ wᵢwⱼ gf6ᵢⱼₘ gf6ᵢⱼₙ = κ wₘ δₘₙ` over `ℤ`, checked by `decide` (`coefC`, `coefP`).
* **`L263_witness`**: the record's instance at `𝔤₂ ⊂ 𝔰𝔬(7)`, stated explicitly: `P_h # P_h = 4 P_h` for
  `P_h = gop lamP = Σ gvᵢgvᵢᵀ/‖gvᵢ‖²`, `C = gop lamC` idempotent with eigenvalue `9/28` on the eight `𝔰𝔲(3)` vectors and
  `3/28` on the six of `𝔭`, `‖C‖² = 351/392` and `‖P_h/4‖² = 7/8`;
* **`L263_g2`**: the record's statement in existence form, `h = span(gv)`, `c = 4`, from the witness.

What the file leaves to the record: that `h` is simple and is `𝔤₂` (the file exhibits a fourteen-dimensional subalgebra
closed under the bracket and orthogonal to the `Λ²₇` directions of the 3-form), that the eight `9/28` directions are
`𝔰𝔲(3)` (they are the basis vectors avoiding the index `6`, which fix `e₆`), and the Casimir values `c₁ = 3`,
`α = 4/3` and the block relations of the two-component criterion.

The record states L263 as a criterion on two-component families; that criterion is typed in
[I117LemmaF.lean](I117LemmaF.lean) with the block relations as data. This file supplies the instance at `𝔤₂ ⊂ 𝔰𝔬(7)`
from the bracket itself.
-/

namespace HamiltonsCubic.I117S

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge Matrix Finset

section RankOne

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The functional `X ↦ ⟨S X, u⟩`. -/
noncomputable def pairFun (S : CurvOp2 ι) (u : Matrix ι ι ℝ) : skewSub ι →ₗ[ℝ] ℝ where
  toFun X := inner2 ((S X : skewSub ι) : Matrix ι ι ℝ) u
  map_add' X Y := by simp only [map_add, Submodule.coe_add, i2_add_l]
  map_smul' c X := by simp only [map_smul, Submodule.coe_smul, i2_smul_l, RingHom.id_apply, smul_eq_mul]

/-- **`⟨S, u uᵀ⟩ = ⟨S u, u⟩`.** -/
theorem innerOp2_rk1 (S : CurvOp2 ι) (u : skewSub ι) :
    innerOp2 S (rk1 u) = inner2 ((S u : skewSub ι) : Matrix ι ι ℝ) (u : Matrix ι ι ℝ) := by
  have h := sum_phi_inner_sub u (pairFun S (u : Matrix ι ι ℝ))
  simp only [pairFun, LinearMap.coe_mk, AddHom.coe_mk] at h
  rw [← h]
  unfold innerOp2
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  simp only [applyPhi, rk1_apply, Submodule.coe_smul, i2_smul_r, inner2_comm (phi i j : Matrix ι ι ℝ)]

/-- The functional `X ↦ ⟨v, [φ, X]⟩`. -/
noncomputable def brFun (v φ : skewSub ι) : skewSub ι →ₗ[ℝ] ℝ where
  toFun X := inner2 (v : Matrix ι ι ℝ) ((brS φ X : skewSub ι) : Matrix ι ι ℝ)
  map_add' X Y := by simp only [brS_add_right, Submodule.coe_add, i2_add_r]
  map_smul' c X := by simp only [brS_smul_right, Submodule.coe_smul, i2_smul_r, RingHom.id_apply, smul_eq_mul]

/-- **`Φ(S; vvᵀ, wwᵀ) = -⟨S[v,w], [v,w]⟩`.** -/
theorem phiTri_rk1 (S : CurvOp2 ι) (v w : skewSub ι) :
    phiTri S (rk1 v) (rk1 w)
      = - inner2 ((S (brS v w) : skewSub ι) : Matrix ι ι ℝ) ((brS v w : skewSub ι) : Matrix ι ι ℝ) := by
  set u' := brS w v with hu'
  have hk : ∀ i j, ∑ k, ∑ l, inner2 (phi k l) (w : Matrix ι ι ℝ)
        * inner2 (v : Matrix ι ι ℝ) ((brS (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) ⟨phi k l, phi_mem_skewSub k l⟩ :
          skewSub ι) : Matrix ι ι ℝ)
      = 2 * inner2 (v : Matrix ι ι ℝ) ((brS (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) w : skewSub ι) :
          Matrix ι ι ℝ) := by
    intro i j
    have h := sum_phi_inner_sub w (brFun v ⟨phi i j, phi_mem_skewSub i j⟩)
    simp only [brFun, LinearMap.coe_mk, AddHom.coe_mk] at h
    rw [← h]; simp only [Finset.mul_sum, inner2_comm (phi _ _ : Matrix ι ι ℝ) (w : Matrix ι ι ℝ)]; ring
  have hS : ∑ i, ∑ j, inner2 (u' : Matrix ι ι ℝ) (phi i j)
        * inner2 ((S ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) (u' : Matrix ι ι ℝ)
      = 2 * inner2 ((S u' : skewSub ι) : Matrix ι ι ℝ) (u' : Matrix ι ι ℝ) := by
    have h := sum_phi_inner_sub u' (pairFun S (u' : Matrix ι ι ℝ))
    simp only [pairFun, LinearMap.coe_mk, AddHom.coe_mk] at h
    rw [← h]; simp only [Finset.mul_sum]; ring
  unfold phiTri
  have e1 : ∀ i j k l, inner2 ((rk1 v (brS (S ⟨phi i j, phi_mem_skewSub i j⟩) (rk1 w ⟨phi k l, phi_mem_skewSub k l⟩)) :
        skewSub ι) : Matrix ι ι ℝ) ((brS (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) ⟨phi k l, phi_mem_skewSub k l⟩ :
          skewSub ι) : Matrix ι ι ℝ)
      = inner2 ((brS (S ⟨phi i j, phi_mem_skewSub i j⟩) w : skewSub ι) : Matrix ι ι ℝ) (v : Matrix ι ι ℝ)
        * (inner2 (phi k l) (w : Matrix ι ι ℝ)
          * inner2 (v : Matrix ι ι ℝ) ((brS (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) ⟨phi k l, phi_mem_skewSub k l⟩ :
            skewSub ι) : Matrix ι ι ℝ)) := by
    intro i j k l
    simp only [rk1_apply, brS_smul_right, Submodule.coe_smul, i2_smul_l]; ring
  simp only [e1, ← Finset.mul_sum, hk]
  have e2 : ∀ i j, inner2 ((brS (S ⟨phi i j, phi_mem_skewSub i j⟩) w : skewSub ι) : Matrix ι ι ℝ) (v : Matrix ι ι ℝ)
        * (2 * inner2 (v : Matrix ι ι ℝ) ((brS (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) w : skewSub ι) :
          Matrix ι ι ℝ))
      = 2 * (inner2 (u' : Matrix ι ι ℝ) (phi i j)
        * inner2 ((S ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ) (u' : Matrix ι ι ℝ)) := by
    intro i j
    have c1 := inner2_brS_cyc (S ⟨phi i j, phi_mem_skewSub i j⟩) w v
    have c2 := inner2_brS_cyc v (S ⟨phi i j, phi_mem_skewSub i j⟩) w
    have c3 := inner2_brS_cyc (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) w v
    have c4 := inner2_brS_cyc v (⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) w
    rw [c1, c2, inner2_comm (v : Matrix ι ι ℝ), c3, c4,
      inner2_comm ((brS w v : skewSub ι) : Matrix ι ι ℝ) ((S ⟨phi i j, phi_mem_skewSub i j⟩ : skewSub ι) : Matrix ι ι ℝ)]
    simp only [hu']; ring
  simp only [e2, ← Finset.mul_sum, hS]
  rw [hu', brS_neg w v, map_neg, Submodule.coe_neg, Submodule.coe_neg]
  have hn : ∀ A B : Matrix ι ι ℝ, inner2 (-A) (-B) = inner2 A B := fun A B => by
    unfold inner2; rw [Matrix.transpose_neg, Matrix.neg_mul, Matrix.mul_neg, neg_neg]
  rw [hn]; ring

/-- **An operator is determined by its pairings.** -/
theorem op_ext_inner {A B : CurvOp2 ι} (h : ∀ S, innerOp2 S A = innerOp2 S B) : A = B := by
  have h1 := h (A - B)
  have hz : normSq2 (A - B) = 0 := by
    unfold normSq2
    rw [innerOp2_comm, innerOp2_sub_left, innerOp2_comm A, innerOp2_comm B, h1, sub_self]
  exact sub_eq_zero.mp (normSq2_eq_zero hz)

theorem phiTri_sum_mid {κ : Type*} (s : Finset κ) (A C : CurvOp2 ι) (f : κ → CurvOp2 ι) :
    phiTri A (∑ i ∈ s, f i) C = ∑ i ∈ s, phiTri A (f i) C := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    simp only [Finset.sum_empty]; unfold phiTri; simp [inner2]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, phiTri_add_mid, ih]

theorem phiTri_sum_right {κ : Type*} (s : Finset κ) (A B : CurvOp2 ι) (f : κ → CurvOp2 ι) :
    phiTri A B (∑ i ∈ s, f i) = ∑ i ∈ s, phiTri A B (f i) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    have hz : ∀ X, brS X (0 : skewSub ι) = 0 := fun X => Subtype.ext (by simp [brS, br])
    simp only [Finset.sum_empty]; unfold phiTri; simp [hz, inner2]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, phiTri_add_right, ih]

theorem innerOp2_sum_right {κ : Type*} (s : Finset κ) (A : CurvOp2 ι) (f : κ → CurvOp2 ι) :
    innerOp2 A (∑ i ∈ s, f i) = ∑ i ∈ s, innerOp2 A (f i) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
    simp only [Finset.sum_empty]; unfold innerOp2; simp [applyPhi, inner2]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, innerOp2_add_right, ih]

/-- **`#` on a sum of rank-one operators**: `(Σ λᵢ vᵢvᵢᵀ)# = ½ Σᵢⱼ λᵢλⱼ [vᵢ,vⱼ][vᵢ,vⱼ]ᵀ`. -/
theorem sharp_rk1_sum {κ : Type*} (s : Finset κ) (lam : κ → ℝ) (v : κ → skewSub ι) :
    sharpMapCL (∑ i ∈ s, lam i • rk1 (v i))
      = ∑ i ∈ s, ∑ j ∈ s, ((1 / 2) * lam i * lam j) • rk1 (brS (v i) (v j)) := by
  refine op_ext_inner fun S => ?_
  rw [innerOp2_sharpMap_eq_phiTri, phiTri_sum_mid, innerOp2_sum_right]
  simp only [phiTri_smul_mid, phiTri_sum_right, phiTri_smul_right, phiTri_rk1, innerOp2_sum_right,
    innerOp2_smul_right, innerOp2_rk1, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  ring

end RankOne

section G2

irreducible_def e2 (a b : Fin 7) : skewSub (Fin 7) := phiS a b

theorem phiS_canon (a b : Fin 7) :
    phiS a b = if a < b then e2 a b else if b < a then -e2 b a else 0 := by
  split_ifs with h1 h2
  · rw [e2_def]
  · rw [e2_def, phiS_swap]
  · have : a = b := le_antisymm (not_lt.mp h2) (not_lt.mp h1)
    subst this; exact phiS_self a

theorem brS_neg_l7 (X Y : skewSub (Fin 7)) : brS (-X) Y = -brS X Y := Subtype.ext (by simp [brS, br]; abel)
theorem brS_neg_r7 (X Y : skewSub (Fin 7)) : brS X (-Y) = -brS X Y := Subtype.ext (by simp [brS, br]; abel)
theorem brS_sub_l7 (X X' Y : skewSub (Fin 7)) : brS (X - X') Y = brS X Y - brS X' Y :=
  Subtype.ext (by simp [brS, br, Matrix.sub_mul, Matrix.mul_sub]; abel)
theorem brS_sub_r7 (X Y Y' : skewSub (Fin 7)) : brS X (Y - Y') = brS X Y - brS X Y' :=
  Subtype.ext (by simp [brS, br, Matrix.sub_mul, Matrix.mul_sub]; abel)

noncomputable def gv : Fin 14 → skewSub (Fin 7)
  | 0 => phiS (1 : Fin 7) 2 - phiS (3 : Fin 7) 4
  | 1 => phiS (1 : Fin 7) 2 + phiS (3 : Fin 7) 4 - (2 : ℝ) • phiS (5 : Fin 7) 6
  | 2 => - phiS (0 : Fin 7) 2 - phiS (3 : Fin 7) 5
  | 3 => - phiS (0 : Fin 7) 2 + phiS (3 : Fin 7) 5 + (2 : ℝ) • phiS (4 : Fin 7) 6
  | 4 => phiS (0 : Fin 7) 1 + phiS (4 : Fin 7) 5
  | 5 => phiS (0 : Fin 7) 1 - phiS (4 : Fin 7) 5 + (2 : ℝ) • phiS (3 : Fin 7) 6
  | 6 => - phiS (0 : Fin 7) 4 + phiS (1 : Fin 7) 5
  | 7 => - phiS (0 : Fin 7) 4 - phiS (1 : Fin 7) 5 - (2 : ℝ) • phiS (2 : Fin 7) 6
  | 8 => phiS (0 : Fin 7) 3 - phiS (2 : Fin 7) 5
  | 9 => phiS (0 : Fin 7) 3 + phiS (2 : Fin 7) 5 - (2 : ℝ) • phiS (1 : Fin 7) 6
  | 10 => phiS (1 : Fin 7) 3 + phiS (2 : Fin 7) 4
  | 11 => phiS (1 : Fin 7) 3 - phiS (2 : Fin 7) 4 + (2 : ℝ) • phiS (0 : Fin 7) 6
  | 12 => phiS (0 : Fin 7) 5 + phiS (1 : Fin 7) 4
  | 13 => phiS (0 : Fin 7) 5 - phiS (1 : Fin 7) 4 + (2 : ℝ) • phiS (2 : Fin 7) 3

/-- Six times the structure constants of `gv`: `[gv i, gv j] = Σ_m (gf6 i j m / 6) gv m`. -/
def gf6 : Fin 14 → Fin 14 → Fin 14 → ℤ :=
  ![![![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 6], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -18, 0, 0, 0]], ![![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 18, -12, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, -18, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 18, -12, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, -18, 12, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 6], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0]], ![![0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, -6], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0, 0]], ![![0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, -18, 12, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![18, -12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, -12, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, -6], ![0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 18, 12, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0]], ![![0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![-6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -12, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]], ![![0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 18, -12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![-18, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 12, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, -18, -12, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, -12, 0, 0, 0, 0, 0, 0]], ![![0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![-6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, -12, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]], ![![0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, -18, 12, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -18, 12, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -12], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![-18, -12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, -18, -12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0]], ![![0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 6], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0], ![6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, -18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]], ![![0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 18, -12, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -18, 6], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -18, -12, 0, 0], ![0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![18, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 18, 12, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]], ![![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, -6], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0], ![0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![-6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]], ![![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -18, -6], ![0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, -18, -12, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 18, 12, 0, 0, 0, 0], ![0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 18, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, -18, -12, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]], ![![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, -12, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]], ![![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, -18, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, -6, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, -12, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![-18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, -6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], ![0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]]

set_option maxHeartbeats 40000000 in
/-- **The bracket table of `gv`**: `[gv i, gv j] = Σ_m (gf6 i j m / 6) gv m`. -/
theorem gv_br (i j : Fin 14) : brS (gv i) (gv j) = ∑ m, ((gf6 i j m : ℝ) / 6) • gv m := by
  fin_cases i <;> fin_cases j <;>
  · simp only [Fin.sum_univ_succ, Fin.sum_univ_zero, Fin.reduceFinMk, Fin.isValue]
    simp (config := { decide := true }) only [gf6, Fin.reduceFinMk, Fin.succ_zero_eq_one', Fin.reduceSucc, Fin.isValue, Matrix.cons_val, Matrix.cons_val_zero,
      Matrix.cons_val_one, Int.cast_zero, Int.cast_ofNat, Int.cast_neg, Int.cast_one, zero_div, zero_smul,
      add_zero, zero_add, Fin.succ_zero_eq_one, Fin.succ_one_eq_two]
    simp only [gv, brS_add_left, brS_add_right, brS_sub_l7, brS_sub_r7, brS_neg_l7, brS_neg_r7,
      brS_smul_left, brS_smul_right, brS_phiS]
    simp (config := { decide := true }) only [phiS_canon, ite_true, ite_false, one_smul, zero_smul, smul_zero,
      add_zero, zero_add, sub_zero, zero_sub, neg_zero, smul_neg, neg_neg]
    try module


theorem i2_neg_l7 (A B : Matrix (Fin 7) (Fin 7) ℝ) : inner2 (-A) B = - inner2 A B := by
  unfold inner2; rw [Matrix.transpose_neg, Matrix.neg_mul, Matrix.trace_neg]; ring
theorem i2_neg_r7 (A B : Matrix (Fin 7) (Fin 7) ℝ) : inner2 A (-B) = - inner2 A B := by
  unfold inner2; rw [Matrix.mul_neg, Matrix.trace_neg]; ring

/-- The squared norms of `gv`: `2` on the `u`'s, `6` on the `w`'s. -/
noncomputable def gn : Fin 14 → ℝ := ![2, 6, 2, 6, 2, 6, 2, 6, 2, 6, 2, 6, 2, 6]

set_option maxHeartbeats 40000000 in
/-- **`gv` is orthogonal**, with squared norms `gn`. -/
theorem gv_inner (i j : Fin 14) :
    inner2 ((gv i : skewSub (Fin 7)) : Matrix (Fin 7) (Fin 7) ℝ) ((gv j : skewSub (Fin 7)) : Matrix (Fin 7) (Fin 7) ℝ)
      = if i = j then gn i else 0 := by
  fin_cases i <;> fin_cases j <;>
  · simp only [gv, Submodule.coe_add, Submodule.coe_sub, Submodule.coe_neg, Submodule.coe_smul, i2_add_l, i2_add_r,
      i2_sub_r', i2_smul_l, i2_smul_r, i2_neg_l7, i2_neg_r7, inner2_phiS, sub_eq_add_neg, i2_add_l]
    simp (config := { decide := true }) only [gn, Fin.reduceFinMk, Fin.isValue, Matrix.cons_val, ite_true, ite_false,
      and_true, and_false, true_and, false_and]
    norm_num

theorem inner2_sum_r7 {κ : Type*} (s : Finset κ) (X : Matrix (Fin 7) (Fin 7) ℝ) (f : κ → Matrix (Fin 7) (Fin 7) ℝ) :
    inner2 X (∑ i ∈ s, f i) = ∑ i ∈ s, inner2 X (f i) := by
  unfold inner2; rw [Matrix.mul_sum, Matrix.trace_sum, Finset.mul_sum]

theorem inner2_sum_l7 {κ : Type*} (s : Finset κ) (X : Matrix (Fin 7) (Fin 7) ℝ) (f : κ → Matrix (Fin 7) (Fin 7) ℝ) :
    inner2 (∑ i ∈ s, f i) X = ∑ i ∈ s, inner2 (f i) X := by
  rw [inner2_comm, inner2_sum_r7]; exact Finset.sum_congr rfl fun i _ => inner2_comm _ _

/-- The operator `X ↦ ⟨X, u⟩ w`. -/
noncomputable def ot7 (u w : skewSub (Fin 7)) : CurvOp2 (Fin 7) :=
  LinearMap.toContinuousLinearMap
    { toFun := fun X => inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (u : Matrix (Fin 7) (Fin 7) ℝ) • w
      map_add' := fun X Y => by simp only [Submodule.coe_add, i2_add_l, add_smul]
      map_smul' := fun c X => by simp only [Submodule.coe_smul, i2_smul_l, smul_smul, RingHom.id_apply] }

theorem ot7_apply (u w X : skewSub (Fin 7)) : ot7 u w X = inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (u : Matrix (Fin 7) (Fin 7) ℝ) • w := rfl

theorem rk1_eq_ot7 (u : skewSub (Fin 7)) : rk1 u = ot7 u u := rfl

/-- **`rk1` of a combination.** -/
theorem rk1_sum_smul (c : Fin 14 → ℝ) (v : Fin 14 → skewSub (Fin 7)) :
    rk1 (∑ m, c m • v m) = ∑ m, ∑ n, (c m * c n) • ot7 (v m) (v n) := by
  refine ContinuousLinearMap.ext fun X => ?_
  have hL : rk1 (∑ m, c m • v m) X
      = ∑ m, ∑ n, (c m * inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (v m : Matrix (Fin 7) (Fin 7) ℝ) * c n) • v n := by
    rw [rk1_apply, Submodule.coe_sum]
    simp only [Submodule.coe_smul, inner2_sum_r7, i2_smul_r]
    rw [Finset.sum_smul]; simp only [Finset.smul_sum, smul_smul]
  have hR : (∑ m, ∑ n, (c m * c n) • ot7 (v m) (v n)) X
      = ∑ m, ∑ n, (c m * c n * inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (v m : Matrix (Fin 7) (Fin 7) ℝ)) • v n := by
    simp only [_root_.sum_apply, _root_.smul_apply, ot7_apply, smul_smul]
  rw [hL, hR]
  exact Finset.sum_congr rfl fun m _ => Finset.sum_congr rfl fun n _ => by congr 1; ring

theorem sum_swap22 {M : Type*} [AddCommMonoid M] (F : Fin 14 → Fin 14 → Fin 14 → Fin 14 → M) :
    ∑ i, ∑ j, ∑ m, ∑ n, F i j m n = ∑ m, ∑ n, ∑ i, ∑ j, F i j m n := by
  calc ∑ i, ∑ j, ∑ m, ∑ n, F i j m n = ∑ i, ∑ m, ∑ j, ∑ n, F i j m n :=
        Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ i, ∑ m, ∑ n, ∑ j, F i j m n :=
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun m _ => Finset.sum_comm
    _ = ∑ m, ∑ i, ∑ n, ∑ j, F i j m n := Finset.sum_comm
    _ = ∑ m, ∑ n, ∑ i, ∑ j, F i j m n := Finset.sum_congr rfl fun m _ => Finset.sum_comm

/-- **`#` on the `gv`-diagonal family**, from a coefficient identity. -/
theorem sharp_gv (lam tgt : Fin 14 → ℝ)
    (hco : ∀ m n, ∑ i, ∑ j, (1 / 2 * lam i * lam j) * (((gf6 i j m : ℝ) / 6) * ((gf6 i j n : ℝ) / 6))
      = if m = n then tgt m else 0) :
    sharpMapCL (∑ i, lam i • rk1 (gv i)) = ∑ i, tgt i • rk1 (gv i) := by
  rw [sharp_rk1_sum]
  simp only [gv_br, rk1_sum_smul, Finset.smul_sum, smul_smul]
  rw [sum_swap22 (fun i j m n => ((1 / 2 * lam i * lam j) * (((gf6 i j m : ℝ) / 6) * ((gf6 i j n : ℝ) / 6))) •
    ot7 (gv m) (gv n))]
  simp only [← Finset.sum_smul, hco, ite_smul, zero_smul, Finset.sum_ite_eq, Finset.mem_univ, if_true, rk1_eq_ot7]

/-- The weights of `C`, over `168`. -/
def gw : Fin 14 → ℤ := ![27, 3, 27, 3, 27, 3, 27, 3, 27, 3, 27, 3, 27, 9]
/-- The weights of `P_𝔥`, over `6`. -/
def gu : Fin 14 → ℤ := ![3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1]

set_option maxRecDepth 100000 in
theorem coefC : ∀ m n : Fin 14, ∑ i, ∑ j, gw i * gw j * gf6 i j m * gf6 i j n = if m = n then 12096 * gw m else 0 := by
  decide

set_option maxRecDepth 100000 in
theorem coefP : ∀ m n : Fin 14, ∑ i, ∑ j, gu i * gu j * gf6 i j m * gf6 i j n = if m = n then 1728 * gu m else 0 := by
  decide

theorem coefC_real (m n : Fin 14) :
    ∑ i, ∑ j, (1 / 2 * ((gw i : ℝ) / 168) * ((gw j : ℝ) / 168)) * (((gf6 i j m : ℝ) / 6) * ((gf6 i j n : ℝ) / 6))
      = if m = n then (gw m : ℝ) / 168 else 0 := by
  have h := congrArg (Int.cast : ℤ → ℝ) (coefC m n)
  push_cast at h
  calc _ = (1 / 2032128) * ∑ i, ∑ j, (gw i : ℝ) * gw j * gf6 i j m * gf6 i j n := by
        rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun j _ => ?_; ring
    _ = _ := by rw [h]; split_ifs <;> ring

theorem coefP_real (m n : Fin 14) :
    ∑ i, ∑ j, (1 / 2 * ((gu i : ℝ) / 6) * ((gu j : ℝ) / 6)) * (((gf6 i j m : ℝ) / 6) * ((gf6 i j n : ℝ) / 6))
      = if m = n then 4 * ((gu m : ℝ) / 6) else 0 := by
  have h := congrArg (Int.cast : ℤ → ℝ) (coefP m n)
  push_cast at h
  calc _ = (1 / 2592) * ∑ i, ∑ j, (gu i : ℝ) * gu j * gf6 i j m * gf6 i j n := by
        rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun j _ => ?_; ring
    _ = _ := by rw [h]; split_ifs <;> ring

/-- The `gv`-diagonal operator with weights `lam`. -/
noncomputable def gop (lam : Fin 14 → ℝ) : CurvOp2 (Fin 7) := ∑ i, lam i • rk1 (gv i)

theorem gop_expand (lam : Fin 14 → ℝ) (X : skewSub (Fin 7)) :
    gop lam X = ∑ i, (lam i * inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (gv i : Matrix (Fin 7) (Fin 7) ℝ)) • gv i := by
  unfold gop
  rw [_root_.sum_apply]
  simp only [_root_.smul_apply, rk1_apply, smul_smul]

theorem gop_inner (lam : Fin 14 → ℝ) (X : skewSub (Fin 7)) (k : Fin 14) :
    inner2 ((gop lam X : skewSub (Fin 7)) : Matrix (Fin 7) (Fin 7) ℝ) (gv k : Matrix (Fin 7) (Fin 7) ℝ)
      = lam k * gn k * inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (gv k : Matrix (Fin 7) (Fin 7) ℝ) := by
  rw [gop_expand, Submodule.coe_sum, inner2_sum_l7]
  simp only [Submodule.coe_smul, i2_smul_l, gv_inner, mul_ite, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  ring

theorem gop_gv (lam : Fin 14 → ℝ) (k : Fin 14) : gop lam (gv k) = (lam k * gn k) • gv k := by
  rw [gop_expand]
  simp only [gv_inner, mul_ite, mul_zero, ite_smul, zero_smul, Finset.sum_ite_eq, Finset.mem_univ, if_true]

theorem gop_sa (lam : Fin 14 → ℝ) : IsSelfAdjoint2 (gop lam) := by
  intro X Y
  rw [gop_expand, gop_expand, Submodule.coe_sum, Submodule.coe_sum, inner2_sum_l7, inner2_sum_r7]
  refine Finset.sum_congr rfl fun i _ => ?_
  simp only [Submodule.coe_smul, i2_smul_l, i2_smul_r]
  rw [inner2_comm (gv i : Matrix (Fin 7) (Fin 7) ℝ) (Y : Matrix (Fin 7) (Fin 7) ℝ)]; ring

theorem gop_normSq2 (lam : Fin 14 → ℝ) : normSq2 (gop lam) = ∑ i, lam i ^ 2 * gn i ^ 2 := by
  unfold normSq2
  nth_rw 2 [gop]
  rw [innerOp2_sum_right]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [innerOp2_smul_right, innerOp2_rk1, gop_gv, Submodule.coe_smul, i2_smul_l, gv_inner, if_pos rfl]; ring

theorem gv_ne (k : Fin 14) : gv k ≠ 0 := by
  intro h
  have := gv_inner k k
  rw [h, if_pos rfl] at this
  have hg : gn k ≠ 0 := by fin_cases k <;> simp [gn]
  exact hg (by rw [← this]; simp [inner2])

/-- The weights of `C` on the `gv` basis, `gw/168`. -/
noncomputable def lamC (k : Fin 14) : ℝ := (gw k : ℝ) / 168

/-- The weights of `P_𝔥` on the `gv` basis, `gu/6 = 1/‖gv‖²`. -/
noncomputable def lamP (k : Fin 14) : ℝ := (gu k : ℝ) / 6

/-- The eight `gv` avoiding the index `6`: the `𝔰𝔲(3)` stabilising `e₆`. -/
def su3idx : Finset (Fin 14) := {0, 2, 4, 6, 8, 10, 12, 13}

/-- **L263's instance, explicitly**: `P_𝔥 # P_𝔥 = 4 P_𝔥`, the record's `C = (9/28) P_{𝔰𝔲(3)} + (3/28) P_𝔭` is an idempotent
acting by `9/28` on `𝔰𝔲(3)` and `3/28` on `𝔭`, `P_𝔥` fixes `𝔥`, and `‖C‖² = 351/392 > 7/8 = ‖P_𝔥/4‖²`. -/
theorem L263_witness :
    sharpMapCL (gop lamP) = (4 : ℝ) • gop lamP ∧ IsIdem (gop lamC) ∧
      (∀ k, gop lamC (gv k) = (if k ∈ su3idx then (9 / 28 : ℝ) else 3 / 28) • gv k) ∧
      (∀ k, gop lamP (gv k) = gv k) ∧
      normSq2 (gop lamC) = 351 / 392 ∧ normSq2 ((1 / 4 : ℝ) • gop lamP) = 7 / 8 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · unfold gop
    rw [sharp_gv lamP (fun i => 4 * lamP i) coefP_real, Finset.smul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [smul_smul]
  · show sharpMapCL (gop lamC) = gop lamC
    unfold gop; exact sharp_gv lamC lamC coefC_real
  · intro k; rw [gop_gv]; congr 1
    fin_cases k <;> simp [lamC, gw, gn, su3idx] <;> norm_num
  · intro k
    have : lamP k * gn k = 1 := by fin_cases k <;> simp [lamP, gu, gn] <;> norm_num
    rw [gop_gv, this, one_smul]
  · rw [gop_normSq2]; simp [Fin.sum_univ_succ, lamC, gw, gn]; norm_num
  · have e : (1 / (4 : ℝ)) • gop lamP = gop (fun i => 1 / 4 * lamP i) := by
      unfold gop; rw [Finset.smul_sum]; exact Finset.sum_congr rfl fun i _ => by rw [smul_smul]
    rw [e, gop_normSq2]; simp [Fin.sum_univ_succ, lamP, gu, gn]; norm_num

/-- **L263.** `𝔰𝔬(7)` contains a fourteen-dimensional subalgebra (`𝔤₂`) carrying a positive definite idempotent
other than its own `I/c`, and heavier than it. -/
theorem L263_g2 :
    ∃ (h : Submodule ℝ (skewSub (Fin 7))) (C Ph : CurvOp2 (Fin 7)) (c : ℝ),
      Module.finrank ℝ h = 14 ∧ (∀ X ∈ h, ∀ Y ∈ h, brS X Y ∈ h) ∧
      IsSelfAdjoint2 Ph ∧ Ph.comp Ph = Ph ∧ LinearMap.range (Ph : skewSub (Fin 7) →ₗ[ℝ] skewSub (Fin 7)) = h ∧
      sharpMapCL Ph = c • Ph ∧ 0 < c ∧
      IsSelfAdjoint2 C ∧ IsIdem C ∧ LinearMap.range (C : skewSub (Fin 7) →ₗ[ℝ] skewSub (Fin 7)) = h ∧
      (∀ X ∈ h, X ≠ 0 → 0 < inner2 ((C X : skewSub (Fin 7)) : Matrix (Fin 7) (Fin 7) ℝ)
        ((X : skewSub (Fin 7)) : Matrix (Fin 7) (Fin 7) ℝ)) ∧
      C ≠ (1 / c) • Ph ∧ normSq2 ((1 / c) • Ph) < normSq2 C := by
  set lP : Fin 14 → ℝ := fun i => (gu i : ℝ) / 6 with hlP
  set lC : Fin 14 → ℝ := fun i => (gw i : ℝ) / 168 with hlC
  have hPg : ∀ k, lP k * gn k = 1 := by intro k; fin_cases k <;> simp [hlP, gu, gn] <;> norm_num
  have hCg : ∀ k, 0 < lC k * gn k := by intro k; fin_cases k <;> simp [hlC, gw, gn] <;> norm_num
  have hC0 : ∀ k, 0 < lC k := by intro k; fin_cases k <;> simp [hlC, gw] <;> norm_num
  set h : Submodule ℝ (skewSub (Fin 7)) := Submodule.span ℝ (Set.range gv) with hh
  -- linear independence and the dimension
  have hli : LinearIndependent ℝ gv := by
    refine Fintype.linearIndependent_iff.mpr fun g hg k => ?_
    have := congrArg (fun Z : skewSub (Fin 7) => inner2 (Z : Matrix (Fin 7) (Fin 7) ℝ) (gv k : Matrix (Fin 7) (Fin 7) ℝ)) hg
    simp only [Submodule.coe_sum, Submodule.coe_smul, inner2_sum_l7, i2_smul_l, gv_inner, mul_ite, mul_zero,
      Finset.sum_ite_eq', Finset.mem_univ, if_true, ZeroMemClass.coe_zero] at this
    have hz : inner2 (0 : Matrix (Fin 7) (Fin 7) ℝ) (gv k : Matrix (Fin 7) (Fin 7) ℝ) = 0 := by simp [inner2]
    rw [hz] at this
    have hg0 : gn k ≠ 0 := by fin_cases k <;> simp [gn]
    exact (mul_eq_zero.mp this).resolve_right hg0
  have hdim : Module.finrank ℝ h = 14 := by rw [hh, finrank_span_eq_card hli]; simp
  -- closure under the bracket
  have hzl : ∀ Y : skewSub (Fin 7), brS 0 Y = 0 := fun Y => Subtype.ext (by simp [brS, br])
  have hzr : ∀ X : skewSub (Fin 7), brS X 0 = 0 := fun X => Subtype.ext (by simp [brS, br])
  have hgen : ∀ i j, brS (gv i) (gv j) ∈ h := fun i j => by
    rw [gv_br]; exact Submodule.sum_mem _ fun m _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨m, rfl⟩)
  have hclose : ∀ X ∈ h, ∀ Y ∈ h, brS X Y ∈ h := by
    have key : ∀ i, ∀ Y ∈ h, brS (gv i) Y ∈ h := by
      intro i Y hY
      induction hY using Submodule.span_induction with
      | mem y hy => obtain ⟨j, rfl⟩ := hy; exact hgen i j
      | zero => rw [hzr]; exact h.zero_mem
      | add y z _ _ hy hz => rw [brS_add_right]; exact h.add_mem hy hz
      | smul a y _ hy => rw [brS_smul_right]; exact h.smul_mem a hy
    intro X hX Y hY
    induction hX using Submodule.span_induction with
    | mem x hx => obtain ⟨i, rfl⟩ := hx; exact key i Y hY
    | zero => rw [hzl]; exact h.zero_mem
    | add x z _ _ hx hz => rw [brS_add_left]; exact h.add_mem hx hz
    | smul a x _ hx => rw [brS_smul_left]; exact h.smul_mem a hx
  -- range of a positive gv-diagonal operator
  have hrange : ∀ lam : Fin 14 → ℝ, (∀ k, lam k * gn k ≠ 0) →
      LinearMap.range (gop lam : skewSub (Fin 7) →ₗ[ℝ] skewSub (Fin 7)) = h := by
    intro lam hlam
    apply le_antisymm
    · rintro _ ⟨X, rfl⟩
      change gop lam X ∈ h
      rw [gop_expand]; exact Submodule.sum_mem _ fun m _ => Submodule.smul_mem _ _ (Submodule.subset_span ⟨m, rfl⟩)
    · rw [hh, Submodule.span_le]
      rintro _ ⟨k, rfl⟩
      refine ⟨(lam k * gn k)⁻¹ • gv k, ?_⟩
      change gop lam ((lam k * gn k)⁻¹ • gv k) = gv k
      rw [map_smul, gop_gv, smul_smul, inv_mul_cancel₀ (hlam k), one_smul]
  -- the projection
  have hPsharp : sharpMapCL (gop lP) = (4 : ℝ) • gop lP := by
    unfold gop
    rw [sharp_gv lP (fun i => 4 * lP i) coefP_real, Finset.smul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [smul_smul]
  have hPidem : (gop lP).comp (gop lP) = gop lP := by
    refine ContinuousLinearMap.ext fun X => ?_
    rw [ContinuousLinearMap.comp_apply, gop_expand lP (gop lP X)]
    simp only [gop_inner, hPg, one_mul]
    rw [gop_expand lP X]
  have hCidem : IsIdem (gop lC) := by
    show sharpMapCL (gop lC) = gop lC
    unfold gop; exact sharp_gv lC lC coefC_real
  refine ⟨h, gop lC, gop lP, 4, hdim, hclose, gop_sa lP, hPidem, hrange lP (fun k => by rw [hPg]; exact one_ne_zero),
    hPsharp, by norm_num, gop_sa lC, hCidem, hrange lC (fun k => (hCg k).ne'), ?_, ?_, ?_⟩
  · -- positive definite on h
    intro X hX hX0
    have hPX : gop lP X = X := by
      have hr := hrange lP (fun k => by rw [hPg]; exact one_ne_zero)
      rw [← hr] at hX
      obtain ⟨Y, rfl⟩ := hX
      change gop lP (gop lP Y) = gop lP Y
      rw [← ContinuousLinearMap.comp_apply, hPidem]
    rw [gop_expand, Submodule.coe_sum, inner2_sum_l7]
    simp only [Submodule.coe_smul, i2_smul_l]
    have hterm : ∀ i, lC i * inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (gv i : Matrix (Fin 7) (Fin 7) ℝ)
        * inner2 (gv i : Matrix (Fin 7) (Fin 7) ℝ) (X : Matrix (Fin 7) (Fin 7) ℝ)
        = lC i * inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (gv i : Matrix (Fin 7) (Fin 7) ℝ) ^ 2 := fun i => by
      rw [inner2_comm (gv i : Matrix (Fin 7) (Fin 7) ℝ)]; ring
    simp only [hterm]
    by_contra hneg
    push Not at hneg
    have hall : ∀ i, inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (gv i : Matrix (Fin 7) (Fin 7) ℝ) = 0 := by
      intro i
      have hnn : ∀ j ∈ Finset.univ, 0 ≤ lC j * inner2 (X : Matrix (Fin 7) (Fin 7) ℝ) (gv j : Matrix (Fin 7) (Fin 7) ℝ) ^ 2 :=
        fun j _ => mul_nonneg (hC0 j).le (sq_nonneg _)
      have hs := le_antisymm hneg (Finset.sum_nonneg hnn)
      have := (Finset.sum_eq_zero_iff_of_nonneg hnn).mp hs i (Finset.mem_univ _)
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp ((mul_eq_zero.mp this).resolve_left (hC0 i).ne')
    apply hX0
    rw [← hPX, gop_expand]
    simp only [hall, mul_zero, zero_smul, Finset.sum_const_zero]
  · -- other than I/c
    intro heq
    have h1 := congrArg (fun T : CurvOp2 (Fin 7) => T (gv 0)) heq
    simp only [_root_.smul_apply, gop_gv, hPg, one_smul] at h1
    have h3 := congrArg (fun Z : skewSub (Fin 7) => inner2 (Z : Matrix (Fin 7) (Fin 7) ℝ) (gv 0 : Matrix (Fin 7) (Fin 7) ℝ)) h1
    simp only [Submodule.coe_smul, i2_smul_l, gv_inner, if_pos rfl] at h3
    simp [hlC, gw, gn] at h3
    norm_num at h3
  · -- heavier than I/c
    have e : (1 / (4 : ℝ)) • gop lP = gop (fun i => 1 / 4 * lP i) := by
      unfold gop; rw [Finset.smul_sum]; exact Finset.sum_congr rfl fun i _ => by rw [smul_smul]
    rw [e, gop_normSq2, gop_normSq2]
    simp [Fin.sum_univ_succ, hlP, hlC, gu, gw, gn]
    norm_num

end G2

end HamiltonsCubic.I117S
