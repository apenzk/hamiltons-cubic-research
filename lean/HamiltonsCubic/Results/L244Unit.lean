import Mathlib
import HamiltonsCubic.Results.L244Sym

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false

/-!
# L244 (ii) at every unit vector of the negative eigenspace

[findings/second-order.md](../../../findings/second-order.md), Lemma L244 (ii): *At $x\in E_0$, row (B) divided by $a$ is
$b_{12}+b_{22}-b_{00}-b_{01}=1$, and row (C) divided by $a^2$ is $2b_{02}-b_{00}-b_{22}=K$ … $K\le n-4$.*

[L244Sym.lean](L244Sym.lean)'s `L244_ceiling` takes `x` to be a vector of the spectral frame of
[L244Frame.lean](L244Frame.lean), which is arbitrary inside each eigenspace. Here `x` is any unit bivector with `W x = −a x`. A
Householder reflection of the frame through `v = ψ_{k₀} − x` fixes every frame vector orthogonal to `v`, keeps each frame vector an
eigenvector with its own eigenvalue, and sends `ψ_{k₀}` to `x`, so the reflected frame carries the same labelling and starts its
negative class at `x`:

* `refl`, the reflection `y ↦ y − (2⟨v, y⟩/⟨v, v⟩) v`, linear, with `refl_inner` (an isometry), `refl_refl` (an involution),
  `refl_skew` and **`refl_self`** (`ψ ↦ x` at unit `ψ`, `x`, `v = ψ − x`);
* **`refl_eigen`**: a reflection through a `μ`-eigenvector keeps every `λ`-eigenvector a `λ`-eigenvector, from the symmetry of `W`;
* `hId_gen`, `hWP_gen`, `L244_rows_gen`, `cap_self_gen`, `cap_other_gen`: L244Sym's rows and caps at any orthonormal complete
  skew eigenframe;
* **`L244_ceiling_unit`**: `θ ≤ a(n − 5)`, `θ ≤ a(κ₀ − 1)`, `θ ≤ a(κ₂ − 3)` at every unit `x` with `W x = −a x`.
-/

namespace HamiltonsCubic.L244Unit

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.EigenFrameExist
  HamiltonsCubic.SecondKind HamiltonsCubic.L244RowBMass HamiltonsCubic.L244Frame

variable {n : ℕ}

theorem i_add_l (X Y Z : Matrix (Fin n) (Fin n) ℝ) : inner2 (X + Y) Z = inner2 X Z + inner2 Y Z := by
  unfold inner2; rw [transpose_add, add_mul, trace_add]; ring

theorem i_sub_l (X Y Z : Matrix (Fin n) (Fin n) ℝ) : inner2 (X - Y) Z = inner2 X Z - inner2 Y Z := by
  unfold inner2; rw [transpose_sub, sub_mul, trace_sub]; ring

theorem i_smul_l (c : ℝ) (X Z : Matrix (Fin n) (Fin n) ℝ) : inner2 (c • X) Z = c * inner2 X Z := by
  unfold inner2; rw [transpose_smul, smul_mul, trace_smul, smul_eq_mul]; ring

theorem i_add_r (X Y Z : Matrix (Fin n) (Fin n) ℝ) : inner2 Z (X + Y) = inner2 Z X + inner2 Z Y := by
  rw [inner2_comm, i_add_l, inner2_comm X, inner2_comm Y]

theorem i_sub_r (X Y Z : Matrix (Fin n) (Fin n) ℝ) : inner2 Z (X - Y) = inner2 Z X - inner2 Z Y := by
  rw [inner2_comm, i_sub_l, inner2_comm X, inner2_comm Y]

theorem i_smul_r (c : ℝ) (X Z : Matrix (Fin n) (Fin n) ℝ) : inner2 Z (c • X) = c * inner2 Z X := by
  rw [inner2_comm, i_smul_l, inner2_comm X]

/-- **The reflection through `v`**, as a linear map. -/
noncomputable def refl (v : Matrix (Fin n) (Fin n) ℝ) : Matrix (Fin n) (Fin n) ℝ →ₗ[ℝ] Matrix (Fin n) (Fin n) ℝ where
  toFun y := y - (2 * inner2 v y / inner2 v v) • v
  map_add' y z := by
    rw [i_add_r, mul_add, add_div, add_smul]; abel
  map_smul' c y := by
    simp only [i_smul_r, RingHom.id_apply, smul_sub, smul_smul]
    congr 2; ring

theorem refl_apply (v y : Matrix (Fin n) (Fin n) ℝ) : refl v y = y - (2 * inner2 v y / inner2 v v) • v := rfl

/-- The reflection is an isometry. -/
theorem refl_inner (v y z : Matrix (Fin n) (Fin n) ℝ) : inner2 (refl v y) (refl v z) = inner2 y z := by
  rw [refl_apply, refl_apply, i_sub_l, i_sub_r, i_sub_r, i_smul_l, i_smul_r, i_smul_l, i_smul_r, inner2_comm y v]
  by_cases hN : inner2 v v = 0
  · simp [hN]
  · field_simp; ring

/-- The reflection is an involution. -/
theorem refl_refl (v y : Matrix (Fin n) (Fin n) ℝ) : refl v (refl v y) = y := by
  rw [refl_apply (y := refl v y), refl_apply, i_sub_r, i_smul_r]
  by_cases hN : inner2 v v = 0
  · simp [hN]
  · have e : 2 * (inner2 v y - 2 * inner2 v y / inner2 v v * inner2 v v) / inner2 v v = -(2 * inner2 v y / inner2 v v) := by
      field_simp; ring
    rw [e, neg_smul, sub_neg_eq_add, sub_add_cancel]

theorem refl_skew {v y : Matrix (Fin n) (Fin n) ℝ} (hv : IsSkew v) (hy : IsSkew y) : IsSkew (refl v y) := by
  rw [refl_apply]; unfold IsSkew at *
  rw [transpose_sub, transpose_smul, hv, hy, smul_neg]; abel

/-- **The reflection through `ψ − x` sends `ψ` to `x`** at unit `ψ`, `x`. -/
theorem refl_self {ψ x : Matrix (Fin n) (Fin n) ℝ} (hψ : inner2 ψ ψ = 1) (hx : inner2 x x = 1) : refl (ψ - x) ψ = x := by
  rw [refl_apply]
  have hN : inner2 (ψ - x) (ψ - x) = 2 * inner2 (ψ - x) ψ := by
    simp only [i_sub_l, i_sub_r]
    rw [hψ, hx, inner2_comm x ψ]; ring
  by_cases h0 : inner2 (ψ - x) (ψ - x) = 0
  · have := inner2_self_eq_zero h0
    rw [this, smul_zero, sub_zero]; exact (sub_eq_zero.mp this)
  · have h1 : 2 * inner2 (ψ - x) ψ / inner2 (ψ - x) (ψ - x) = 1 := by
      rw [← hN]; exact div_self h0
    rw [h1, one_smul, sub_sub_cancel]

/-- **The reflection keeps eigenvectors**: through a `μ`-eigenvector `v`, a `λ`-eigenvector `y` goes to a `λ`-eigenvector. -/
theorem refl_eigen {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeylOp W) {v y : Matrix (Fin n) (Fin n) ℝ}
    (hv : IsSkew v) (hy : IsSkew y) {μ l : ℝ} (hWv : W v = μ • v) (hWy : W y = l • y) : W (refl v y) = l • refl v y := by
  have hsym := hW.2.2.1 v y hv hy
  rw [hWv, hWy, i_smul_l, i_smul_r] at hsym
  have hlin : W (y - (2 * inner2 v y / inner2 v v) • v) = W y - (2 * inner2 v y / inner2 v v) • W v := by
    rw [sub_eq_add_neg, hW.1.1, ← neg_smul, hW.1.2, neg_smul, ← sub_eq_add_neg]
  have hc : (2 * inner2 v y / inner2 v v) * μ = (2 * inner2 v y / inner2 v v) * l := by
    have : inner2 v y * (μ - l) = 0 := by linarith
    rcases mul_eq_zero.mp this with h | h
    · rw [h]; ring
    · rw [sub_eq_zero.mp h]
  rw [refl_apply, hlin, hWy, hWv, smul_smul, hc, smul_sub, smul_smul, mul_comm l]

variable {W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ}

/-- The class projections resolve the identity, at any complete family. -/
theorem hId_gen {r K : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hcomp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) : X = ∑ a, Pc ψ cls a X := by
  unfold Pc
  rw [Finset.sum_fiberwise_of_maps_to (g := cls) (fun _ _ => Finset.mem_univ _)]
  exact hcomp X hX

/-- `W = ∑_b λ_b P_b`, at any complete eigenframe. -/
theorem hWP_gen (hW : IsWeylOp W) {r K : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (ev : Fin r → ℝ)
    (hcomp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k) (heig : ∀ k, W (ψ k) = ev k • ψ k)
    (cls : Fin r → Fin K) (lam : Fin K → ℝ) (hcls : ∀ k, ev k = lam (cls k)) (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    W X = ∑ b, lam b • Pc ψ cls b X := by
  have hexp := hcomp X hX
  have hWX : W X = ∑ k, inner2 (ψ k) X • (lam (cls k) • ψ k) := by
    conv_lhs => rw [hexp]
    change CriticalBridge.linOf hW.1 _ = _
    simp only [map_sum, map_smul]
    refine Finset.sum_congr rfl fun k _ => ?_
    change inner2 (ψ k) X • W (ψ k) = _
    rw [heig k, hcls k]
  rw [hWX]
  unfold Pc
  simp only [Finset.smul_sum]
  rw [← Finset.sum_fiberwise_of_maps_to (g := cls) (fun _ _ => Finset.mem_univ _)]
  refine Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun k hk => ?_
  rw [(Finset.mem_filter.mp hk).2, smul_comm]

/-- **L244 (ii)'s rows at any orthonormal complete skew eigenframe**, at a unit frame vector of the negative class. -/
theorem L244_rows_gen (hW : IsWeylOp W) {θ a : ℝ} (ha : 0 < a) (hc : IsCritical W θ) {r : ℕ}
    (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (ev : Fin r → ℝ) (hS : ∀ k, IsSkew (ψ k))
    (hcomp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k) (heig : ∀ k, W (ψ k) = ev k • ψ k)
    (cls : Fin r → Fin 3) (hcls : ∀ k, ev k = (![-a, 0, a] : Fin 3 → ℝ) (cls k)) (k₀ : Fin r) (hk₀ : cls k₀ = 0)
    (hunit : inner2 (ψ k₀) (ψ k₀) = 1) :
    let b := fun i j => HamiltonsCubic.L244RowA.bAB ψ cls i j (ψ k₀)
    b 0 0 + b 1 1 + b 2 2 + 2 * (b 0 1 + b 0 2 + b 1 2) = n - 2 ∧
      b 1 2 + b 2 2 - b 0 0 - b 0 1 = 1 ∧
      2 * b 0 2 - b 0 0 - b 2 2 = θ / a + 1 := by
  intro b
  set x := ψ k₀ with hxdef
  have hx : IsSkew x := hS k₀
  have hWx : W x = (-a) • x := by rw [hxdef, heig k₀, hcls, hk₀]; rfl
  have rA : ∑ i, ∑ j, HamiltonsCubic.L244RowA.bAB ψ cls i j x = ((n : ℝ) - 2) * inner2 x x := by
    rw [← HamiltonsCubic.L244RowA.rowMass_eq_sum_bAB]
    exact HamiltonsCubic.L244RowA.rowMass_total_any ψ hS hcomp ψ hcomp x hx
  have rB := rowB_mass W hW ψ hS cls ![-a, 0, a] (hId_gen ψ hcomp cls) (hWP_gen hW ψ ev hcomp heig cls _ hcls) x hx
  have rC := rowC_mass W hW ψ hS cls ![-a, 0, a] (hWP_gen hW ψ ev hcomp heig cls _ hcls) x hx
  rw [rowC_critical W hW θ hc x hx (-a) hWx hunit] at rC
  rw [hWx, HamiltonsCubic.RealLayer.inner2_smul_left, hunit] at rB
  rw [hunit] at rA
  simp only [Fin.sum_univ_three, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
    Matrix.head_cons, Matrix.tail_cons] at rA rB rC
  have s01 := HamiltonsCubic.L244Sym.bAB_symm ψ cls 0 1 x
  have s02 := HamiltonsCubic.L244Sym.bAB_symm ψ cls 0 2 x
  have s12 := HamiltonsCubic.L244Sym.bAB_symm ψ cls 1 2 x
  simp only [b, ← hxdef]
  refine ⟨by linarith, ?_, ?_⟩
  · have : a * (HamiltonsCubic.L244RowA.bAB ψ cls 1 2 x + HamiltonsCubic.L244RowA.bAB ψ cls 2 2 x
        - HamiltonsCubic.L244RowA.bAB ψ cls 0 0 x - HamiltonsCubic.L244RowA.bAB ψ cls 0 1 x) = a * 1 := by
      linear_combination rB - a * s01 - a * s02
    exact mul_left_cancel₀ ha.ne' this
  · have : a * (2 * HamiltonsCubic.L244RowA.bAB ψ cls 0 2 x - HamiltonsCubic.L244RowA.bAB ψ cls 0 0 x
        - HamiltonsCubic.L244RowA.bAB ψ cls 2 2 x) = a * (θ / a + 1) := by
      have e : a * (θ / a + 1) = θ + a := by field_simp
      rw [e]
      nlinarith
    exact mul_left_cancel₀ ha.ne' this

/-- A class family of an orthonormal frame is orthonormal. -/
theorem class_orth_gen {r K m : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hO : ∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) (cls : Fin r → Fin K) (c : Fin K)
    (e : Fin m ≃ {γ // cls γ = c}) (i j : Fin m) :
    inner2 (ψ (e i).1) (ψ (e j).1) = if i = j then 1 else 0 := by
  rw [hO]
  have hiff : (e i).1 = (e j).1 ↔ i = j := by rw [Subtype.val_inj, Equiv.apply_eq_iff_eq]
  simp only [hiff]

/-- **The `E₀` cap** at any orthonormal complete skew frame. -/
theorem cap_self_gen {r K : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hS : ∀ k, IsSkew (ψ k))
    (hO : ∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) (hcomp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (c : Fin K) (k₀ : Fin r) (hk₀ : cls k₀ = c) (κ₀ : ℝ)
    (htop : ∀ (k : ℕ) (N : L240SlotBasis.NormalForm (Fin n) k) (O : Matrix (Fin n) (Fin n) ℝ),
      O * Oᵀ = 1 → Oᵀ * O = 1 → ψ k₀ = O * N.X * Oᵀ →
      ∀ S : Finset {x : Fin n × Fin n // x.1 < x.2}, S.card ≤ Fintype.card {γ // cls γ = c} - 1 →
        ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ κ₀)
    (hsize : 2 ≤ Fintype.card {γ // cls γ = c}) :
    2 * ∑ b, HamiltonsCubic.L244RowA.bAB ψ cls c b (ψ k₀) ≤ κ₀ := by
  obtain ⟨m, e, he⟩ := HamiltonsCubic.L244Sym.class_equiv cls c k₀ hk₀
  have hcard : Fintype.card {γ // cls γ = c} = m + 1 := by rw [← Fintype.card_fin (m + 1)]; exact (Fintype.card_congr e).symm
  rw [← HamiltonsCubic.L244Bridge.rowMass_class ψ cls c e]
  obtain ⟨k, N, O, hO', hO'', hxO, hdual⟩ := HamiltonsCubic.L244Caps.rowMass_cap_self (fun i => ψ (e i).1)
    (fun i => hS _) (class_orth_gen ψ hO cls c e) ψ hcomp (ψ k₀) (hS k₀) (by rw [he])
  have hm : 0 < m := by omega
  exact HamiltonsCubic.L244Caps.twice_rowMass_le_of_top hm N _ κ₀ hdual
    (fun S hS' => htop k N O hO' hO'' hxO S (by rw [hcard]; simpa using hS'))

/-- **The `E₂` cap** at any orthonormal complete skew frame. -/
theorem cap_other_gen {r K : ℕ} (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ) (hS : ∀ k, IsSkew (ψ k))
    (hO : ∀ i j, inner2 (ψ i) (ψ j) = if i = j then 1 else 0) (hcomp : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (c : Fin K) (x : Matrix (Fin n) (Fin n) ℝ)
    (hx : IsSkew x) (κ₂ : ℝ) (hsize : 0 < Fintype.card {γ // cls γ = c})
    (htop : ∀ (k : ℕ) (N : L240SlotBasis.NormalForm (Fin n) k) (O : Matrix (Fin n) (Fin n) ℝ),
      O * Oᵀ = 1 → Oᵀ * O = 1 → x = O * N.X * Oᵀ →
      ∀ S : Finset {x : Fin n × Fin n // x.1 < x.2}, S.card ≤ Fintype.card {γ // cls γ = c} →
        ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ κ₂) :
    2 * ∑ b, HamiltonsCubic.L244RowA.bAB ψ cls c b x ≤ κ₂ := by
  let e : Fin (Fintype.card {γ // cls γ = c}) ≃ {γ // cls γ = c} := (Fintype.equivFin _).symm
  rw [← HamiltonsCubic.L244Bridge.rowMass_class ψ cls c e]
  obtain ⟨k, N, O, hO', hO'', hxO, hdual⟩ := HamiltonsCubic.L244Caps.rowMass_cap_x (fun i => ψ (e i).1)
    (fun i => hS _) (class_orth_gen ψ hO cls c e) ψ hcomp x hx
  exact HamiltonsCubic.L244Caps.twice_rowMass_le_of_top hsize N _ κ₂ hdual (fun S hS' => htop k N O hO' hO'' hxO S hS')

/-- **The reflected frame**: `W`'s spectral frame reflected through `ψ_{k₀} − x`. -/
noncomputable def ψx (hW : IsWeylOp W) (k₀ : Fin (Fintype.card (Pairs n))) (x : Matrix (Fin n) (Fin n) ℝ) :
    Fin (Fintype.card (Pairs n)) → Matrix (Fin n) (Fin n) ℝ :=
  fun k => refl (ψf W hW k₀ - x) (ψf W hW k)

theorem ψf_orth (hW : IsWeylOp W) (i j : Fin (Fintype.card (Pairs n))) :
    inner2 (ψf W hW i) (ψf W hW j) = if i = j then 1 else 0 := by
  have h := (eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1).orthonormal ((eF n).symm i) ((eF n).symm j)
  have hiff : ((eF n).symm i = (eF n).symm j) ↔ i = j := Equiv.apply_eq_iff_eq _
  simp only [hiff] at h
  exact h

theorem ψx_skew (hW : IsWeylOp W) (k₀ : Fin (Fintype.card (Pairs n))) {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x)
    (k : Fin (Fintype.card (Pairs n))) : IsSkew (ψx hW k₀ x k) := by
  have hv : IsSkew (ψf W hW k₀ - x) := by
    have := ψf_skew W hW k₀; unfold IsSkew at *; rw [transpose_sub, this, hx]; abel
  exact refl_skew hv (ψf_skew W hW k)

theorem ψx_orth (hW : IsWeylOp W) (k₀ : Fin (Fintype.card (Pairs n))) (x : Matrix (Fin n) (Fin n) ℝ)
    (i j : Fin (Fintype.card (Pairs n))) : inner2 (ψx hW k₀ x i) (ψx hW k₀ x j) = if i = j then 1 else 0 := by
  unfold ψx; rw [refl_inner]; exact ψf_orth hW i j

theorem ψx_complete (hW : IsWeylOp W) (k₀ : Fin (Fintype.card (Pairs n))) {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x)
    (Y : Matrix (Fin n) (Fin n) ℝ) (hY : IsSkew Y) : Y = ∑ k, inner2 (ψx hW k₀ x k) Y • ψx hW k₀ x k := by
  have hv : IsSkew (ψf W hW k₀ - x) := by
    have := ψf_skew W hW k₀; unfold IsSkew at *; rw [transpose_sub, this, hx]; abel
  set v := ψf W hW k₀ - x
  have hZ := ψf_complete W hW (refl v Y) (refl_skew hv hY)
  have e1 : Y = refl v (refl v Y) := (refl_refl v Y).symm
  conv_lhs => rw [e1, hZ]
  rw [map_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [map_smul]
  unfold ψx
  congr 1
  rw [← refl_inner v (ψf W hW k) (refl v Y), refl_refl]

theorem ψx_eigen (hW : IsWeylOp W) {a : ℝ} (k₀ : Fin (Fintype.card (Pairs n))) (hk : evf W hW k₀ = -a)
    {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x) (hWx : W x = (-a) • x) (k : Fin (Fintype.card (Pairs n))) :
    W (ψx hW k₀ x k) = evf W hW k • ψx hW k₀ x k := by
  have hv : IsSkew (ψf W hW k₀ - x) := by
    have := ψf_skew W hW k₀; unfold IsSkew at *; rw [transpose_sub, this, hx]; abel
  have hWv : W (ψf W hW k₀ - x) = (-a) • (ψf W hW k₀ - x) := by
    rw [sub_eq_add_neg, hW.1.1, ← neg_one_smul ℝ x, hW.1.2, hWx, ψf_eigen W hW k₀, hk, smul_add, smul_smul, smul_smul,
      mul_comm]
  exact refl_eigen hW hv (ψf_skew W hW k) hWv (ψf_eigen W hW k)

theorem ψx_self (hW : IsWeylOp W) (k₀ : Fin (Fintype.card (Pairs n))) {x : Matrix (Fin n) (Fin n) ℝ}
    (hunit : inner2 x x = 1) : ψx hW k₀ x k₀ = x := by
  unfold ψx
  have h := ψf_orth hW k₀ k₀
  rw [if_pos rfl] at h
  exact refl_self h hunit

/-- **L244 (ii) at every unit `x` of the negative eigenspace**: at a critical linear Weyl `W` whose spectral eigenframe is labelled by
three classes of values `(−a, 0, a)`, `a > 0`, the negative class holding at least two frame vectors and the positive class at least
one, and `x` any unit bivector with `W x = −a x`, with `κ₀` bounding the top `m₀ − 1` and `κ₂` the top `m₂` slot eigenvalues of every
normal form of `x`, `θ ≤ a(n − 5)`, `θ ≤ a(κ₀ − 1)` and `θ ≤ a(κ₂ − 3)`. -/
theorem L244_ceiling_unit (hW : IsWeylOp W) {θ a κ₀ κ₂ : ℝ} (ha : 0 < a) (hc : IsCritical W θ)
    (cls : Fin (Fintype.card (Pairs n)) → Fin 3)
    (hcls : ∀ k, evf W hW k = (![-a, 0, a] : Fin 3 → ℝ) (cls k))
    (h0size : 2 ≤ Fintype.card {γ // cls γ = 0}) (h2size : 0 < Fintype.card {γ // cls γ = 2})
    {x : Matrix (Fin n) (Fin n) ℝ} (hx : IsSkew x) (hunit : inner2 x x = 1) (hWx : W x = (-a) • x)
    (htop0 : ∀ (k : ℕ) (N : L240SlotBasis.NormalForm (Fin n) k) (O : Matrix (Fin n) (Fin n) ℝ),
      O * Oᵀ = 1 → Oᵀ * O = 1 → x = O * N.X * Oᵀ →
      ∀ S : Finset {x : Fin n × Fin n // x.1 < x.2}, S.card ≤ Fintype.card {γ // cls γ = 0} - 1 →
        ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ κ₀)
    (htop2 : ∀ (k : ℕ) (N : L240SlotBasis.NormalForm (Fin n) k) (O : Matrix (Fin n) (Fin n) ℝ),
      O * Oᵀ = 1 → Oᵀ * O = 1 → x = O * N.X * Oᵀ →
      ∀ S : Finset {x : Fin n × Fin n // x.1 < x.2}, S.card ≤ Fintype.card {γ // cls γ = 2} →
        ∑ ij ∈ S, L240SlotBasis.slotμ N ij ≤ κ₂) :
    θ ≤ a * (n - 5) ∧ θ ≤ a * (κ₀ - 1) ∧ θ ≤ a * (κ₂ - 3) := by
  obtain ⟨⟨k₀, hk₀⟩⟩ : Nonempty {γ // cls γ = 0} := Fintype.card_pos_iff.mp (by omega)
  have hk : evf W hW k₀ = -a := by rw [hcls, hk₀]; rfl
  set ψ := ψx hW k₀ x
  have hS := ψx_skew hW k₀ hx
  have hO := ψx_orth hW k₀ x
  have hcomp := ψx_complete hW k₀ hx
  have heig := ψx_eigen hW k₀ hk hx hWx
  have hself : ψ k₀ = x := ψx_self hW k₀ hunit
  have hu : inner2 (ψ k₀) (ψ k₀) = 1 := by rw [hself]; exact hunit
  obtain ⟨hA, hB, hC⟩ := L244_rows_gen hW ha hc ψ (evf W hW) hS hcomp heig cls hcls k₀ hk₀ hu
  have c0 := cap_self_gen ψ hS hO hcomp cls 0 k₀ hk₀ κ₀ (by rw [hself]; exact htop0) h0size
  have c2 := cap_other_gen ψ hS hO hcomp cls 2 (ψ k₀) (hS k₀) κ₂ h2size (by rw [hself]; exact htop2)
  simp only [Fin.sum_univ_three] at c0 c2
  have s02 := HamiltonsCubic.L244Sym.bAB_symm ψ cls 0 2 (ψ k₀)
  have s12 := HamiltonsCubic.L244Sym.bAB_symm ψ cls 1 2 (ψ k₀)
  have hnn : ∀ i j, 0 ≤ HamiltonsCubic.L244RowA.bAB ψ cls i j (ψ k₀) := fun i j => by
    unfold HamiltonsCubic.L244RowA.bAB
    exact mul_nonneg (by norm_num) (Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _)
  have hK := HamiltonsCubic.L244SymmetricPerVector.per_vector_ceiling n (θ / a + 1) κ₀ κ₂ _ _ _ _ _ _
    (hnn 0 0) (hnn 0 1) (hnn 1 1) (hnn 2 2) hA hB hC c0 (by linarith)
  exact HamiltonsCubic.L244SymmetricPerVector.theta_bound n a θ (θ / a + 1) κ₀ κ₂ ha (by field_simp; ring) hK

end HamiltonsCubic.L244Unit
