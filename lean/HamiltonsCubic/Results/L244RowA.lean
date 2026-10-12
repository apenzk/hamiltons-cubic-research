import Mathlib
import HamiltonsCubic.Results.L244Caps
import HamiltonsCubic.Results.Casimir

/-!
# L244, row (A) in the record's variables

Summed over all classes, `∑_{a,b} b_ab(x) = (n − 2) ⟨x, x⟩`: row (A) of the per-vector rows. With
`ψ` and `φ` both the full basis `φ_ij` (`i < j`), `rowMass` is `R(x) = ∑_a R_a(x)`, and Parseval
(`rowMass_eq`) with `casimir_skew_lt` gives the value.
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.L244RowA

variable {n : ℕ}

/-- The pairs `i < j`. -/
abbrev Pairs (n : ℕ) := {x : Fin n × Fin n // x.1 < x.2}

/-- The full basis, indexed by `Fin r` through an enumeration of the pairs. -/
noncomputable def basisFam (n : ℕ) : Fin (Fintype.card (Pairs n)) → Matrix (Fin n) (Fin n) ℝ :=
  fun k => phi ((Fintype.equivFin (Pairs n)).symm k).1.1 ((Fintype.equivFin (Pairs n)).symm k).1.2

/-- **Row (A)**: `R(x) = ∑_{a,b} b_ab(x) = (n − 2) ⟨x, x⟩` for skew `x`. -/
theorem rowMass_total (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) :
    L244Caps.rowMass (basisFam n) (fun ij : Pairs n => phi ij.1.1 ij.1.2) x
      = ((n : ℝ) - 2) * inner2 x x := by
  have hψ : ∀ k, IsSkew (basisFam n k) := fun k => phi_isSkew _ _
  have hexp : ∀ Y, IsSkew Y → Y = ∑ ij : Pairs n, inner2 (phi ij.1.1 ij.1.2) Y • phi ij.1.1 ij.1.2 :=
    fun Y hY => L240SlotBasis.phi_expand_ordered Y hY
  rw [L244Caps.rowMass_eq (basisFam n) hψ _ hexp x hx]
  -- reindex the sum over `Fin r` to the pairs, then to the ordered double sum with `i < j`
  have e1 : ∑ k, inner2 (br (basisFam n k) x) (br (basisFam n k) x)
      = ∑ ij : Pairs n, inner2 (br (phi ij.1.1 ij.1.2) x) (br (phi ij.1.1 ij.1.2) x) := by
    unfold basisFam
    exact Equiv.sum_comp (Fintype.equivFin (Pairs n)).symm
      (fun ij : Pairs n => inner2 (br (phi ij.1.1 ij.1.2) x) (br (phi ij.1.1 ij.1.2) x))
  rw [e1]
  set g : Fin n × Fin n → ℝ := fun ij =>
    inner2 (br (phi ij.1 ij.2) x) (br (phi ij.1 ij.2) x) with hg
  have e2 : ∑ ij : Pairs n, inner2 (br (phi ij.1.1 ij.1.2) x) (br (phi ij.1.1 ij.1.2) x)
      = ∑ i, ∑ j, if i < j then g (i, j) else 0 := by
    rw [← Finset.sum_subtype (Finset.univ.filter (fun x : Fin n × Fin n => x.1 < x.2))
      (fun x => by simp) g, Finset.sum_filter, Fintype.sum_prod_type]
  rw [e2]
  have hc := Casimir.casimir_skew_lt x hx
  simp only [Casimir.phi_eq_layer] at hc
  have e3 : ∀ i j : Fin n, g (i, j)
      = (1 / 2) * ((phi i j * x - x * phi i j)ᵀ * (phi i j * x - x * phi i j)).trace := by
    intro i j; simp only [hg, inner2, br]
  simp only [e3]
  have e4 : ∀ i j : Fin n, (if i < j then (1 / 2 : ℝ) *
      ((phi i j * x - x * phi i j)ᵀ * (phi i j * x - x * phi i j)).trace else 0)
      = (1 / 2) * (if i < j then ((phi i j * x - x * phi i j)ᵀ *
        (phi i j * x - x * phi i j)).trace else 0) := by
    intro i j; split_ifs <;> simp
  simp only [e4, ← Finset.mul_sum, hc]
  unfold inner2; ring

section indep
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **Parseval** for a family that expands every skew matrix. -/
theorem parseval {K : Type*} [Fintype K] (φ : K → Matrix ι ι ℝ)
    (hexp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k) (Y : Matrix ι ι ℝ) (hY : IsSkew Y) :
    inner2 Y Y = ∑ k, inner2 (φ k) Y ^ 2 := by
  have e : ∀ A B : Matrix ι ι ℝ, inner2 A B = KyFanPackaging.inner2Form A B := fun A B =>
    (KyFanPackaging.inner2Form_apply A B).symm
  rw [e]
  nth_rewrite 2 [hexp Y hY]
  rw [map_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [map_smul, smul_eq_mul, KyFanPackaging.inner2Form_symm, ← e, sq]

theorem br_isSkew {A B : Matrix ι ι ℝ} (hA : IsSkew A) (hB : IsSkew B) : IsSkew (br A B) := by
  unfold IsSkew at *; unfold br
  rw [transpose_sub, transpose_mul, transpose_mul, hA, hB]
  simp [Matrix.neg_mul, Matrix.mul_neg]

/-- **Basis independence**: `∑ ‖[x, ψ_γ]‖²` is the same over any two families of skew matrices that
expand every skew matrix (it is `tr(−ad_x²)` on the skew matrices). -/
theorem bracket_sum_indep {K K' : Type*} [Fintype K] [Fintype K']
    (ψ : K → Matrix ι ι ℝ) (hψS : ∀ k, IsSkew (ψ k))
    (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (φ : K' → Matrix ι ι ℝ) (hφS : ∀ k, IsSkew (φ k))
    (hφ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k) (x : Matrix ι ι ℝ) (hx : IsSkew x) :
    ∑ γ, inner2 (br x (ψ γ)) (br x (ψ γ)) = ∑ δ, inner2 (br x (φ δ)) (br x (φ δ)) := by
  have step : ∀ γ δ, inner2 (φ δ) (br x (ψ γ)) ^ 2 = inner2 (ψ γ) (br x (φ δ)) ^ 2 := by
    intro γ δ
    have h1 := HamiltonsCubic.Results.inner2_br_skew x (φ δ) (ψ γ) hx
    have h2 : inner2 (br x (φ δ)) (ψ γ) = inner2 (ψ γ) (br x (φ δ)) := by
      unfold inner2; rw [← Matrix.trace_transpose]; simp [Matrix.transpose_mul]
    rw [← h2, h1]; ring
  calc ∑ γ, inner2 (br x (ψ γ)) (br x (ψ γ))
      = ∑ γ, ∑ δ, inner2 (φ δ) (br x (ψ γ)) ^ 2 :=
        Finset.sum_congr rfl fun γ _ => parseval φ hφ _ (br_isSkew hx (hψS γ))
    _ = ∑ δ, ∑ γ, inner2 (ψ γ) (br x (φ δ)) ^ 2 := by
        rw [Finset.sum_comm]; simp only [step]
    _ = _ := Finset.sum_congr rfl fun δ _ => (parseval ψ hψ _ (br_isSkew hx (hφS δ))).symm

end indep

theorem br_sq_swap {m : Type*} [Fintype m] [DecidableEq m] (A B : Matrix m m ℝ) :
    inner2 (br A B) (br A B) = inner2 (br B A) (br B A) := by
  have : br A B = -br B A := by unfold br; abel
  rw [this]; simp [inner2, Matrix.neg_mul, Matrix.mul_neg, Matrix.transpose_neg]

/-- **Row (A) at any complete skew family**: for `ψ` any family of skew matrices expanding every skew
matrix (in particular an orthonormal basis adapted to `W`'s eigenspaces) and `φ` complete,
`R(x) = ∑_{a,b} b_ab(x) = (n − 2) ⟨x, x⟩` for skew `x`. -/
theorem rowMass_total_any {r : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hψS : ∀ k, IsSkew (ψ k))
    (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k) {K : Type*} [Fintype K]
    (φ : K → Matrix (Fin n) (Fin n) ℝ) (hφ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) :
    L244Caps.rowMass ψ φ x = ((n : ℝ) - 2) * inner2 x x := by
  have hexp0 : ∀ Y, IsSkew Y → Y = ∑ ij : Pairs n, inner2 (phi ij.1.1 ij.1.2) Y • phi ij.1.1 ij.1.2 :=
    fun Y hY => L240SlotBasis.phi_expand_ordered Y hY
  have hbS : ∀ k, IsSkew (basisFam n k) := fun k => phi_isSkew _ _
  have hbexp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (basisFam n k) Y • basisFam n k := by
    intro Y hY
    unfold basisFam
    rw [Equiv.sum_comp (Fintype.equivFin (Pairs n)).symm
      (fun ij : Pairs n => inner2 (phi ij.1.1 ij.1.2) Y • phi ij.1.1 ij.1.2)]
    exact hexp0 Y hY
  rw [← rowMass_total x hx, L244Caps.rowMass_eq ψ hψS φ hφ x hx,
    L244Caps.rowMass_eq (basisFam n) hbS _ hexp0 x hx]
  congr 1
  simp only [br_sq_swap _ x]
  exact bracket_sum_indep ψ hψS hψ (basisFam n) hbS hbexp x hx

section hA
variable {r K : ℕ}

/-- `b_ab(x)` with both sides split by class: `½ ∑_{γ ∈ E_a} ∑_{δ ∈ E_b} ⟨[ψ_γ, ψ_δ], x⟩²`. -/
noncomputable def bAB (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K) (a b : Fin K)
    (x : Matrix (Fin n) (Fin n) ℝ) : ℝ :=
  (1 / 2) * ∑ γ ∈ Finset.univ.filter (fun γ => cls γ = a),
    ∑ δ ∈ Finset.univ.filter (fun δ => cls δ = b), inner2 (br (ψ γ) (ψ δ)) x ^ 2

/-- **The full split**: `R(x) = ∑_{a,b} b_ab(x)`. -/
theorem rowMass_eq_sum_bAB (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K)
    (x : Matrix (Fin n) (Fin n) ℝ) :
    L244Caps.rowMass ψ ψ x = ∑ a, ∑ b, bAB ψ cls a b x := by
  unfold L244Caps.rowMass bAB
  simp only [← Finset.mul_sum]
  congr 1
  rw [← Finset.sum_fiberwise Finset.univ cls
    (fun γ => ∑ δ, inner2 (br (ψ γ) (ψ δ)) x ^ 2)]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [← Finset.sum_comm]
  rw [← Finset.sum_fiberwise Finset.univ cls
    (fun δ => ∑ γ ∈ Finset.univ.filter (fun γ => cls γ = a), inner2 (br (ψ γ) (ψ δ)) x ^ 2)]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [Finset.sum_comm]

/-- **Symmetry**: `b_ab = b_ba`. -/
theorem bAB_symm (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (cls : Fin r → Fin K) (a b : Fin K)
    (x : Matrix (Fin n) (Fin n) ℝ) : bAB ψ cls a b x = bAB ψ cls b a x := by
  unfold bAB
  congr 1
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun δ _ => Finset.sum_congr rfl fun γ _ => ?_
  have : br (ψ δ) (ψ γ) = -br (ψ γ) (ψ δ) := by unfold br; abel
  rw [this]; simp [inner2, Matrix.neg_mul, Matrix.transpose_neg]

/-- **L244's `hA`**: at a unit skew `x`, for `ψ` a complete skew family split into three classes,
`b00 + b11 + b22 + 2 (b01 + b02 + b12) = n − 2`. The completeness hypothesis `hψ` is the
Parseval-frame identity, so any tight frame meets it; `W`'s orthonormal eigenbasis is the intended one
(Gate 2: r1174). -/
theorem hA_of_basis (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hψS : ∀ k, IsSkew (ψ k))
    (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k) (cls : Fin r → Fin 3)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1) :
    bAB ψ cls 0 0 x + bAB ψ cls 1 1 x + bAB ψ cls 2 2 x
      + 2 * (bAB ψ cls 0 1 x + bAB ψ cls 0 2 x + bAB ψ cls 1 2 x) = n - 2 := by
  have h := rowMass_total_any ψ hψS hψ ψ hψ x hx
  rw [rowMass_eq_sum_bAB ψ cls x, hunit, mul_one] at h
  simp only [Fin.sum_univ_three] at h
  rw [bAB_symm ψ cls 1 0, bAB_symm ψ cls 2 0, bAB_symm ψ cls 2 1] at h
  linarith

end hA

end HamiltonsCubic.L244RowA
