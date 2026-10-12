import HamiltonsCubic.Results.L127WTop

set_option linter.style.longLine false

/-!
# L127's dimension counts on the operator side

[L127Dim.lean](L127Dim.lean) and [L127WTop.lean](L127WTop.lean) count the coefficient spaces of the pair-block
eigenspaces on the Ricci cut. This file carries each count to the operators themselves. `pairOp j k` sends a coefficient
vector `c` to the operator `Y ↦ ∑_{i ∈ s} c_i f_i(Y)`, `s = {i : i ≠ j, i ≠ k}`, and the image of each coefficient
space under it is the eigenspace, which the `_op_mem` theorems state:

* **`finrank_map_pairOp`**: on a subspace of vectors vanishing off `s`, `pairOp` preserves `finrank`, since it is
  injective there (`pairCoeff_inj`);
* **`cross_kernel_op_finrank`** `= n − 4`, **`cross_top_op_finrank`** `= 1`, **`within_kernel_op_finrank`** `= p − 3`
  at `p ≥ 3`, **`within_neg_op_finrank`** `= q − 1`, **`within_top_op_finrank`** `= 1` at `p ≥ 3`;
* **`cross_kernel_op_mem`**, **`cross_top_op_mem`**, **`within_kernel_op_mem`**, **`within_neg_op_mem`**,
  **`within_top_op_mem`**: an operator lies in the image exactly when it is `pairOp j k c` for a coefficient vector `c`
  vanishing off `s`, on the Ricci cut, and satisfying the block's eigen-equation on every bivector.
-/

namespace HamiltonsCubic.L121Block

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The coefficient map of the pair span: `c ↦ (Y ↦ ∑_{i ∈ s} c_i f_i(Y))`, `f_i = φ_{ji} ⊙ φ_{ki}`. -/
noncomputable def pairOp (j k : ι) : (ι → ℝ) →ₗ[ℝ] (Matrix ι ι ℝ → Matrix ι ι ℝ) where
  toFun c Y := ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) Y
  map_add' c d := by
    funext Y; simp only [Pi.add_apply, add_smul, Finset.sum_add_distrib]
  map_smul' r c := by
    funext Y; simp only [Pi.smul_apply, smul_eq_mul, mul_smul, ← Finset.smul_sum, RingHom.id_apply]

/-- **`pairOp` preserves dimension on vectors vanishing off the pair index set.** -/
theorem finrank_map_pairOp {j k : ι} (hjk : j ≠ k) (V : Submodule ℝ (ι → ℝ))
    (hV : ∀ c ∈ V, ∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0) :
    Module.finrank ℝ (V.map (pairOp j k)) = Module.finrank ℝ V := by
  have hinj : Function.Injective ((pairOp j k).comp V.subtype) := by
    intro c d h
    apply Subtype.ext
    exact pairCoeff_inj hjk c d (hV c c.2) (hV d d.2) fun X _ => congrFun h X
  rw [← LinearMap.finrank_range_of_inj hinj, LinearMap.range_comp, Submodule.range_subtype]

/-- **The cross kernel, as operators, has dimension `n − 4`.** -/
theorem cross_kernel_op_finrank (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hj : j ∈ T)
    (hk : k ∉ T) :
    Module.finrank ℝ ((LinearMap.ker (blockSums2 ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T))
      ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T)))).map (pairOp j k)) = Fintype.card ι - 4 := by
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  rw [finrank_map_pairOp hjk _ fun c hc i hi => ?_, cross_kernel_finrank T hp hq hj hk]
  rw [mem_ker_blockSums2, Finset.filter_union_filter_not_eq] at hc
  exact hc.1 i hi

/-- **The cross `t(n − 1)/2`-eigenspace, as operators, is one line.** -/
theorem cross_top_op_finrank (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hj : j ∈ T)
    (hk : k ∉ T) :
    Module.finrank ℝ ((Submodule.span ℝ {crossTopVec T j k}).map (pairOp j k)) = 1 := by
  have hjk : j ≠ k := fun h => hk (h ▸ hj)
  rw [finrank_map_pairOp hjk _ fun c hc i hi => ?_, cross_top_finrank T hp hq hk]
  obtain ⟨a, rfl⟩ := Submodule.mem_span_singleton.mp hc
  simp only [Pi.smul_apply, smul_eq_mul, crossTopVec, if_neg hi, mul_zero]

/-- **The within kernel, as operators, has dimension `p − 3`**, at `p ≥ 3`. -/
theorem within_kernel_op_finrank (T : Finset ι) (hp : 3 ≤ T.card) {j k : ι} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) :
    Module.finrank ℝ ((LinearMap.ker (blockSums1 ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T)))).map
      (pairOp j k)) = T.card - 3 := by
  rw [finrank_map_pairOp hjk _ fun c hc i hi => ?_, within_kernel_finrank T hp hj hk hjk]
  rw [mem_ker_blockSums1] at hc
  exact hc.1 i fun h => hi (Finset.mem_filter.mp h).1

/-- **The within negative eigenspace, as operators, has dimension `q − 1`.** -/
theorem within_neg_op_finrank (T : Finset ι) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) :
    Module.finrank ℝ ((LinearMap.ker (blockSums1 Tᶜ)).map (pairOp j k)) = Tᶜ.card - 1 := by
  rw [finrank_map_pairOp hjk _ fun c hc i hi => ?_, within_neg_finrank T hq]
  rw [mem_ker_blockSums1] at hc
  refine hc.1 i fun h => hi ?_
  have := Finset.mem_compl.mp h
  exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, fun e => this (e ▸ hj), fun e => this (e ▸ hk)⟩

/-- **The within top, as operators, is one line**, at `p ≥ 3`. -/
theorem within_top_op_finrank (T : Finset ι) (hp : 3 ≤ T.card) (hq : 2 ≤ Tᶜ.card) {j k : ι} (hj : j ∈ T) (hk : k ∈ T)
    (hjk : j ≠ k) :
    Module.finrank ℝ ((Submodule.span ℝ {withinTopVec T j k}).map (pairOp j k)) = 1 := by
  rw [finrank_map_pairOp hjk _ fun c hc i hi => ?_, within_top_finrank T hp hq hj hk]
  obtain ⟨a, rfl⟩ := Submodule.mem_span_singleton.mp hc
  simp only [Pi.smul_apply, smul_eq_mul, withinTopVec, if_neg hi, mul_zero]

/-- The image of a coefficient space is the operators `pairOp j k c`, `c` in it. -/
theorem mem_map_pairOp_iff {j k : ι} (V : Submodule ℝ (ι → ℝ)) (P : (ι → ℝ) → Prop) (hP : ∀ c, P c ↔ c ∈ V)
    (F : Matrix ι ι ℝ → Matrix ι ι ℝ) : F ∈ V.map (pairOp j k) ↔ ∃ c, P c ∧ pairOp j k c = F := by
  rw [Submodule.mem_map]
  exact exists_congr fun c => and_congr_left fun _ => (hP c).symm

/-- **The cross kernel as operators**: exactly the pair-span operators whose coefficients vanish off `s`, lie on the
Ricci cut, and are annihilated by `M ∘`. -/
theorem cross_kernel_op_mem (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∉ T) (F : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    F ∈ (LinearMap.ker (blockSums2 ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T))
      ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∉ T)))).map (pairOp j k)
      ↔ ∃ c : ι → ℝ, ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
        ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
        ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
          foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
            c i • rk2 (phi j i) (phi k i) Y) X = 0) ∧ pairOp j k c = F :=
  mem_map_pairOp_iff _ _ (cross_kernel_mem T hp hq t ht hj hk) F

/-- **The cross `t(n − 1)/2`-eigenspace as operators.** -/
theorem cross_top_op_mem (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∉ T) (F : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    F ∈ (Submodule.span ℝ {crossTopVec T j k}).map (pairOp j k)
      ↔ ∃ c : ι → ℝ, ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
        ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
        ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
          foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
            c i • rk2 (phi j i) (phi k i) Y) X
            = (t * ((T.card : ℝ) + Tᶜ.card - 1) / 2) • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
              c i • rk2 (phi j i) (phi k i) X) ∧ pairOp j k c = F :=
  mem_map_pairOp_iff _ _ (cross_top_mem T hp hq t ht hj hk) F

/-- **The within kernel as operators.** -/
theorem within_kernel_op_mem (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (F : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    F ∈ (LinearMap.ker (blockSums1 ((univ.filter (fun i => j ≠ i ∧ k ≠ i)).filter (· ∈ T)))).map (pairOp j k)
      ↔ ∃ c : ι → ℝ, ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
        ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
        ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
          foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
            c i • rk2 (phi j i) (phi k i) Y) X
            = (0 : ℝ) • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
        ∧ pairOp j k c = F :=
  mem_map_pairOp_iff _ _ (within_kernel_mem T hp hq t ht hj hk hjk) F

/-- **The within negative eigenspace as operators.** -/
theorem within_neg_op_mem (T : Finset ι) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (F : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    F ∈ (LinearMap.ker (blockSums1 Tᶜ)).map (pairOp j k)
      ↔ ∃ c : ι → ℝ, ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
        ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
        ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
          foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
            c i • rk2 (phi j i) (phi k i) Y) X
            = ((1 / 2 : ℝ) * (-2 * t - t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) - t * ((T.card : ℝ) / ((Tᶜ.card : ℝ) - 1))))
              • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
        ∧ pairOp j k c = F :=
  mem_map_pairOp_iff _ _ (within_neg_mem T hp hq t ht hj hk hjk) F

/-- **The within top as operators**, at `p ≥ 3`. -/
theorem within_top_op_mem (T : Finset ι) (hp : 3 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t) {j k : ι}
    (hj : j ∈ T) (hk : k ∈ T) (hjk : j ≠ k) (F : Matrix ι ι ℝ → Matrix ι ι ℝ) :
    F ∈ (Submodule.span ℝ {withinTopVec T j k}).map (pairOp j k)
      ↔ ∃ c : ι → ℝ, ((∀ i ∉ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0)
        ∧ ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i = 0
        ∧ ∀ X : Matrix ι ι ℝ, IsSkew X →
          foxProd (diagOp (t • sphereWeight T)) (fun Y => ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i),
            c i • rk2 (phi j i) (phi k i) Y) X
            = ((1 / 2 : ℝ) * (t * ((Tᶜ.card : ℝ) / ((T.card : ℝ) - 1)) + t) * ((T.card : ℝ) - 2))
              • ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X)
        ∧ pairOp j k c = F :=
  mem_map_pairOp_iff _ _ (within_top_mem T hp hq t ht hj hk hjk) F

end HamiltonsCubic.L121Block
