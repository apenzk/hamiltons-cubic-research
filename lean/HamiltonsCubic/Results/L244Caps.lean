import Mathlib
import HamiltonsCubic.Results.L237Cap
import HamiltonsCubic.Results.L209FoxClosure
import HamiltonsCubic.Results.L237SlotCounts

/-!
# L244's caps in eigenspace form

[findings/second-order.md](../../../findings/second-order.md), Lemma L244 takes as hypotheses the
per-vector caps `∑_b b_ab(x) ≤ ½ κ_{m_a}(x)` with `b_ab(x) = ½ ∑_{γ ∈ E_a, δ ∈ E_b} ⟨[ψ_γ, ψ_δ], x⟩²`.
Summing over every `b` is summing `δ` over a complete orthonormal basis of the skew matrices, so the
left side is `½ ∑_γ ‖[ψ_γ, x]‖²` by Parseval (`rowMass_eq`), and `kappa_cap_norm` bounds it
uniformly in `x` (`rowMass_le`), and `bracket_cap` gives the `x`-dependent cap (`rowMass_cap_x`). The eigenspace decomposition itself stays abstract: `ψ` is any orthonormal family
(a basis of `E_a`) and `φ` any complete orthonormal family of skew matrices.
-/

open HamiltonsCubic.RealLayer Matrix

namespace HamiltonsCubic.L244Caps

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `R_a(x) = ∑_b b_ab(x)`, the bracket mass of `x` against the family `ψ`, measured in the basis `φ`. -/
noncomputable def rowMass {r : ℕ} {K : Type*} [Fintype K] (ψ : Fin r → Matrix ι ι ℝ)
    (φ : K → Matrix ι ι ℝ) (x : Matrix ι ι ℝ) : ℝ :=
  (1 / 2) * ∑ γ, ∑ δ, inner2 (br (ψ γ) (φ δ)) x ^ 2

/-- **Parseval**: for `φ` expanding every skew matrix as `Y = ∑ ⟨φ_k, Y⟩ φ_k`, `R_a(x) = ½ ∑_γ ‖[ψ_γ, x]‖²`. -/
theorem rowMass_eq {r : ℕ} {K : Type*} [Fintype K] (ψ : Fin r → Matrix ι ι ℝ)
    (hψ : ∀ γ, IsSkew (ψ γ)) (φ : K → Matrix ι ι ℝ)
    (hexp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k) (x : Matrix ι ι ℝ) (hx : IsSkew x) :
    rowMass ψ φ x = (1 / 2) * ∑ γ, inner2 (br (ψ γ) x) (br (ψ γ) x) := by
  unfold rowMass
  congr 1
  refine Finset.sum_congr rfl fun γ _ => ?_
  set Y := br (ψ γ) x
  have hY : IsSkew Y := by
    unfold IsSkew at *; unfold Y br
    rw [transpose_sub, transpose_mul, transpose_mul, hψ γ, hx]
    simp [Matrix.neg_mul, Matrix.mul_neg]
  have hsq : ∀ δ, inner2 (br (ψ γ) (φ δ)) x ^ 2 = inner2 (φ δ) Y ^ 2 := by
    intro δ
    rw [HamiltonsCubic.Results.inner2_br_skew (ψ γ) (φ δ) x (hψ γ)]; ring
  simp only [hsq]
  have e : ∀ A B : Matrix ι ι ℝ, inner2 A B = KyFanPackaging.inner2Form A B := fun A B =>
    (KyFanPackaging.inner2Form_apply A B).symm
  have hP : inner2 Y Y = ∑ δ, inner2 (φ δ) Y ^ 2 := by
    rw [e]
    nth_rewrite 2 [hexp Y hY]
    rw [map_sum]
    refine Finset.sum_congr rfl fun δ _ => ?_
    rw [map_smul, smul_eq_mul, KyFanPackaging.inner2Form_symm, ← e, sq]
  rw [hP]

/-- **L244's cap, typed**: for orthonormal skew `ψ₁,…,ψ_r` (`r ≥ 1`) and a complete family `φ`,
`R_a(x) = ∑_b b_ab(x) ≤ ½ (r + 2) ⟨x, x⟩`, from `κ_r ≤ r + 2`. -/
theorem rowMass_le [LinearOrder ι] {r : ℕ} (hr : 0 < r) {K : Type*} [Fintype K]
    (ψ : Fin r → Matrix ι ι ℝ) (hψ : ∀ γ, IsSkew (ψ γ))
    (hψo : ∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) (φ : K → Matrix ι ι ℝ)
    (hexp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k) (x : Matrix ι ι ℝ) (hx : IsSkew x) :
    rowMass ψ φ x ≤ (1 / 2) * ((r + 2) * inner2 x x) := by
  rw [rowMass_eq ψ hψ φ hexp x hx]
  have hsw : ∀ γ, inner2 (br (ψ γ) x) (br (ψ γ) x) = inner2 (br x (ψ γ)) (br x (ψ γ)) := by
    intro γ
    have : br (ψ γ) x = -br x (ψ γ) := by unfold br; abel
    rw [this]; simp [inner2, Matrix.neg_mul, Matrix.mul_neg, Matrix.transpose_neg]
  simp only [hsw]
  have := L237SlotCounts.kappa_cap_norm x hx hr ψ hψ hψo
  linarith

/-- **L244's cap in its `x`-dependent form**: for orthonormal skew `ψ` and a complete `φ`, at every
skew `x` there is a normal form `N`, `x = O N.X Oᵀ`, with
`2 R_a(x) ≤ r c + ∑ₖ max(μₖ − c, 0)` for every `c`, the `μ` being `x`'s slot eigenvalues:
`2 R_a(x) ≤ κ_r(x)`: the form of L244's `h2`, and of `h0` one index high (the record's `h0` is
`κ_{p−1}(x)`, since `x`'s own row vanishes). -/
theorem rowMass_cap_x [LinearOrder ι] {r : ℕ} {K : Type*} [Fintype K]
    (ψ : Fin r → Matrix ι ι ℝ) (hψ : ∀ γ, IsSkew (ψ γ))
    (hψo : ∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) (φ : K → Matrix ι ι ℝ)
    (hexp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k) (x : Matrix ι ι ℝ) (hx : IsSkew x) :
    ∃ (k : ℕ) (N : L240SlotBasis.NormalForm ι k) (O : Matrix ι ι ℝ),
      O * Oᵀ = 1 ∧ Oᵀ * O = 1 ∧ x = O * N.X * Oᵀ ∧ ∀ c : ℝ,
      2 * rowMass ψ φ x ≤ r * c + ∑ ij, max (L240SlotBasis.slotμ N ij - c) 0 := by
  obtain ⟨k, N, O, hO, hO', hxO, hN⟩ := L237Cap.bracket_cap x hx
  refine ⟨k, N, O, hO, hO', hxO, fun c => ?_⟩
  rw [rowMass_eq ψ hψ φ hexp x hx]
  have hsw : ∀ γ, inner2 (br (ψ γ) x) (br (ψ γ) x) = inner2 (br x (ψ γ)) (br x (ψ γ)) := by
    intro γ
    have : br (ψ γ) x = -br x (ψ γ) := by unfold br; abel
    rw [this]; simp [inner2, Matrix.neg_mul, Matrix.mul_neg, Matrix.transpose_neg]
  simp only [hsw]
  have := hN ψ hψ hψo c
  linarith

/-- `b_ab(x)`: the part of `R_a(x)` from the basis vectors `φ_δ` of class `b` (the eigenspace `E_b`). -/
noncomputable def bMass {r : ℕ} {K C : Type*} [Fintype K] [DecidableEq C] (ψ : Fin r → Matrix ι ι ℝ)
    (φ : K → Matrix ι ι ℝ) (cls : K → C) (b : C) (x : Matrix ι ι ℝ) : ℝ :=
  (1 / 2) * ∑ γ, ∑ δ ∈ Finset.univ.filter (fun δ => cls δ = b), inner2 (br (ψ γ) (φ δ)) x ^ 2

/-- **The eigenspace split**: `R_a(x) = ∑_b b_ab(x)` for any labelling of the basis by eigenspace. -/
theorem rowMass_split {r : ℕ} {K C : Type*} [Fintype K] [Fintype C] [DecidableEq C]
    (ψ : Fin r → Matrix ι ι ℝ) (φ : K → Matrix ι ι ℝ) (cls : K → C) (x : Matrix ι ι ℝ) :
    rowMass ψ φ x = ∑ b, bMass ψ φ cls b x := by
  unfold rowMass bMass
  simp only [← Finset.mul_sum]
  congr 1
  symm
  rw [Finset.sum_comm]
  exact Finset.sum_congr rfl fun γ _ =>
    Finset.sum_fiberwise Finset.univ cls (fun δ => inner2 (br (ψ γ) (φ δ)) x ^ 2)

/-- **`x`'s own row vanishes**: if the family's first vector is `x`, `R_a(x)` is the same sum over the
remaining `r` vectors, since `⟨[x, φ_δ], x⟩ = −⟨φ_δ, [x, x]⟩ = 0`. -/
theorem rowMass_drop_self {r : ℕ} {K : Type*} [Fintype K] (ψ : Fin (r + 1) → Matrix ι ι ℝ)
    (φ : K → Matrix ι ι ℝ) (x : Matrix ι ι ℝ) (hx : IsSkew x) (h0 : ψ 0 = x) :
    rowMass ψ φ x = rowMass (fun i => ψ i.succ) φ x := by
  unfold rowMass
  rw [Fin.sum_univ_succ, h0]
  have hz : ∀ δ, inner2 (br x (φ δ)) x = 0 := by
    intro δ
    rw [HamiltonsCubic.Results.inner2_br_skew x (φ δ) x hx]
    have : br x x = 0 := by unfold br; simp
    rw [this]; simp [inner2]
  simp [hz]

/-- **L244's `h0` at the record's index**: for `x` a unit vector of `E_a` completed by `ψ₁,…,ψ_r` to
an orthonormal family, `2 R_a(x) ≤ κ_r(x)`, i.e. `κ_{m_a − 1}(x)` with `m_a = r + 1`. -/
theorem rowMass_cap_self [LinearOrder ι] {r : ℕ} {K : Type*} [Fintype K]
    (ψ : Fin (r + 1) → Matrix ι ι ℝ) (hψ : ∀ γ, IsSkew (ψ γ))
    (hψo : ∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) (φ : K → Matrix ι ι ℝ)
    (hexp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (φ k) Y • φ k) (x : Matrix ι ι ℝ) (hx : IsSkew x)
    (h0 : ψ 0 = x) :
    ∃ (k : ℕ) (N : L240SlotBasis.NormalForm ι k) (O : Matrix ι ι ℝ),
      O * Oᵀ = 1 ∧ Oᵀ * O = 1 ∧ x = O * N.X * Oᵀ ∧ ∀ c : ℝ,
      2 * rowMass ψ φ x ≤ r * c + ∑ ij, max (L240SlotBasis.slotμ N ij - c) 0 := by
  rw [rowMass_drop_self ψ φ x hx h0]
  exact rowMass_cap_x (fun i => ψ i.succ) (fun i => hψ _)
    (fun i j => by rw [hψo]; simp [Fin.succ_inj]) φ hexp x hx

/-- **From the dual form to a numeral**: if every set of at most `r` slot eigenvalues of the normal
form sums to at most `κ`, then `2 R_a(x) ≤ κ`. With `κ = κ_r(x)` (the top-`r` sum) this is the numeral
`per_vector_ceiling` takes. -/
theorem twice_rowMass_le_of_top {r : ℕ} (hr : 0 < r) {k : ℕ} (N : L240SlotBasis.NormalForm ι k)
    [LinearOrder ι] (R κ : ℝ)
    (hdual : ∀ c : ℝ, R ≤ r * c + ∑ ij, max (L240SlotBasis.slotμ N ij - c) 0)
    (htop : ∀ S : Finset {x : ι × ι // x.1 < x.2}, S.card ≤ r →
      ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ κ) : R ≤ κ := by
  obtain ⟨c, hc⟩ := L237Cap.exists_c_topSum (L240SlotBasis.slotμ N) hr κ htop
  exact (hdual c).trans hc

/-- **`b_ab(x) ≥ 0`**, the nonnegativity `per_vector_ceiling` takes as `h00`, `h01`, `h11`, `h22`. -/
theorem bMass_nonneg {r : ℕ} {K C : Type*} [Fintype K] [DecidableEq C] (ψ : Fin r → Matrix ι ι ℝ)
    (φ : K → Matrix ι ι ℝ) (cls : K → C) (b : C) (x : Matrix ι ι ℝ) :
    0 ≤ bMass ψ φ cls b x := by
  unfold bMass
  exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun _ _ =>
    Finset.sum_nonneg fun _ _ => sq_nonneg _)

end HamiltonsCubic.L244Caps
