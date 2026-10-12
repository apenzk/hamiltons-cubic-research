import HamiltonsCubic.Results.OddTorus

set_option linter.style.longLine false

/-!
# Every `𝔰𝔬(k)` torus slice with `k ≤ 2M` obeys `𝔰𝔬(2M)`'s bound, `M ≥ 7`

[The R48 working note](../../../reviews/2026-09-27-R48-torus-families.md), batch 14. With `κ_{2M} = 2(M-1)/√(M(2M-1))`
(`kapE M`), every torus-invariant `C` on `𝔰𝔬(2m)` with `m ≤ M` (`H_small_even`) and on `𝔰𝔬(2m + 1)` with
`m + 1 ≤ M` (`H_small_odd`) has `F(C) ≤ κ_{2M} ‖C‖³`.

- `FE`, `NE`: L271's cubic form and norm on `𝔰𝔬(2m)`'s torus slice, in the pair coordinates.
- `FE_bord`, `NE_bord`: bordering `A` by `0` and `U`, `V` by one vector `z` changes them by the short-root terms,
  `d_i ↦ d_i + 2z_i²`, `+ 6 zᵀ P z` and `+ 4‖z‖²`, through L279's `trace_bord`, `dvec_bord_c`, `dvec_bord_l`.
- `FE_bord_zero`, `NE_bord_zero`: at `z = 0` both are unchanged, so `𝔰𝔬(2m)`'s slice sits in `𝔰𝔬(2m + 2)`'s.
- `FE_le`: down from size `M`, where it is L277's `H_torus_slice` (`FE_base`), by induction on `M - m`.
- `H_small_odd`: at `z = w/√2` L271's form and norm at the bordered triple equal L280's form and norm on `𝔰𝔬(2m + 1)`,
  a coordinate identity between the two formulas rather than an inclusion of operators.
-/

namespace HamiltonsCubic.TorusEmbed

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.J1 HamiltonsCubic.OddJ1
  HamiltonsCubic.OddTorus

/-- L271's cubic form on `𝔰𝔬(2m)`'s torus slice. -/
noncomputable def FE {m : ℕ} (A U V : Matrix (Fin m) (Fin m) ℝ) : ℝ :=
  3 * ∑ i, A i i * dvec U V i - 3 * (∑ i, ∑ j, if i = j then 0 else A i j * (U + V) i j * (U - V) i j)
    + (1 / 2) * Matrix.trace ((U + V) * (U + V) * (U + V)) + (1 / 2) * Matrix.trace ((U - V) * (U - V) * (U - V))

/-- L271's norm on `𝔰𝔬(2m)`'s torus slice. -/
noncomputable def NE {m : ℕ} (A U V : Matrix (Fin m) (Fin m) ℝ) : ℝ :=
  (∑ i, ∑ j, A i j ^ 2) + (1 / 2) * (∑ i, ∑ j, (U + V) i j ^ 2) + (1 / 2) * (∑ i, ∑ j, (U - V) i j ^ 2)

/-- The ambient constant `κ_{2M} = 2(M - 1)/√(M(2M - 1))`. -/
noncomputable def kapE (M : ℕ) : ℝ := 2 * ((M : ℝ) - 1) / Real.sqrt ((M : ℝ) * (2 * (M : ℝ) - 1))

theorem FE_bord (n : ℕ) (A U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) :
    FE (bord A 0) (bord U z) (bord V z)
      = 3 * ∑ i, A i i * (dvec U V i + 2 * z i ^ 2)
        - 3 * (∑ i, ∑ j, if i = j then 0 else A i j * (U + V) i j * (U - V) i j)
        + (1 / 2) * Matrix.trace ((U + V) * (U + V) * (U + V)) + (1 / 2) * Matrix.trace ((U - V) * (U - V) * (U - V))
        + 3 * ∑ i, ∑ j, (2 * z i) * (U + V) i j * z j := by
  unfold FE
  rw [bord_add, bord_sub, trace_bord, trace_bord]
  have hz : z - z = 0 := sub_self z
  simp only [hz, Pi.zero_apply, zero_mul, mul_zero, Finset.sum_const_zero, add_zero]
  have e1 : ∑ a, bord A 0 a a * dvec (bord U z) (bord V z) a = ∑ i, A i i * (dvec U V i + 2 * z i ^ 2) := by
    rw [Fin.sum_univ_castSucc (n := n + 1)]
    simp only [bord_cc, bord_ll, zero_mul, add_zero, dvec_bord_c]
    exact Finset.sum_congr rfl fun i _ => by ring
  have e2 : (∑ a, ∑ b, if a = b then (0 : ℝ) else bord A 0 a b * bord (U + V) (z + z) a b * bord (U - V) 0 a b)
      = ∑ i, ∑ j, if i = j then 0 else A i j * (U + V) i j * (U - V) i j := by
    rw [Fin.sum_univ_castSucc (n := n + 1)]
    simp only [Fin.sum_univ_castSucc (n := n + 1), bord_cc, bord_cl, bord_lc, bord_ll, Pi.zero_apply, zero_mul,
      mul_zero, ite_self, Finset.sum_const_zero, add_zero, Fin.castSucc_inj]
  rw [e1, e2]
  simp only [Pi.add_apply]
  have e3 : ∑ i, ∑ j, (z i + z i) * (U + V) i j * (z j + z j) = 2 * ∑ i, ∑ j, 2 * z i * (U + V) i j * z j := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun j _ => by ring
  rw [e3]; ring

theorem NE_bord (n : ℕ) (A U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (z : Fin (n + 1) → ℝ) :
    NE (bord A 0) (bord U z) (bord V z) = NE A U V + 4 * ∑ i, z i ^ 2 := by
  unfold NE
  rw [bord_add, bord_sub, sub_self]
  simp only [Fin.sum_univ_castSucc (n := n + 1), bord_cc, bord_cl, bord_lc, bord_ll, Pi.add_apply, Pi.zero_apply]
  simp only [Finset.sum_add_distrib, Finset.mul_sum]
  ring_nf
  simp only [Finset.sum_add_distrib, ← Finset.sum_mul, Finset.sum_const_zero, zero_mul, add_zero]
  ring

theorem bord_symm (n : ℕ) (A : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (hA : Aᵀ = A) : (bord A 0)ᵀ = bord A 0 := by
  have hs : ∀ i j, A j i = A i j := fun i j => by rw [← Matrix.transpose_apply A i j, hA]
  ext a b
  refine Fin.lastCases ?_ (fun i => ?_) a <;> refine Fin.lastCases ?_ (fun j => ?_) b <;>
    simp [Matrix.transpose_apply, hs]

theorem FE_base (n : ℕ) (hn : 6 ≤ n) (A U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) (hA : Aᵀ = A)
    (hU : IsPairWeights U) (hV : IsPairWeights V) : FE A U V ≤ kapE (n + 1) * NE A U V ^ ((3 : ℝ) / 2) := by
  have h := H_torus_slice n hn A U V hA hU hV
  rw [Ftri_torus A U V hA hU hV, L271_norm A U V hU hV] at h
  exact h

theorem FE_bord_zero (n : ℕ) (A U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) :
    FE (bord A 0) (bord U 0) (bord V 0) = FE A U V := by
  rw [FE_bord]; simp [FE]

theorem NE_bord_zero (n : ℕ) (A U V : Matrix (Fin (n + 1)) (Fin (n + 1)) ℝ) :
    NE (bord A 0) (bord U 0) (bord V 0) = NE A U V := by
  rw [NE_bord]; simp

/-- **Down from size `M`**: L271's form obeys the ambient `κ_{2M}` bound at every size `j + 1 ≤ M`, by zero
bordering up to `M` and [L277](../../../findings/second-order.md) there. -/
theorem FE_le (M : ℕ) (hM : 7 ≤ M) : ∀ d j : ℕ, j + 1 + d = M → ∀ A U V : Matrix (Fin (j + 1)) (Fin (j + 1)) ℝ,
    Aᵀ = A → IsPairWeights U → IsPairWeights V → FE A U V ≤ kapE M * NE A U V ^ ((3 : ℝ) / 2) := by
  intro d
  induction d with
  | zero =>
    intro j hj A U V hA hU hV
    obtain rfl : M = j + 1 := by omega
    exact FE_base j (by omega) A U V hA hU hV
  | succ d ih =>
    intro j hj A U V hA hU hV
    have h := ih (j + 1) (by omega) (bord A 0) (bord U 0) (bord V 0) (bord_symm j A hA) (pairw_bord U 0 hU)
      (pairw_bord V 0 hV)
    rwa [FE_bord_zero, NE_bord_zero] at h

/-- **L282 (1)**: for `M ≥ 7` and `m ≤ M`, every torus-invariant operator on `𝔰𝔬(2m)` has `F(C) ≤ κ_{2M} ‖C‖³`. -/
theorem H_small_even (M : ℕ) (hM : 7 ≤ M) (j : ℕ) (hj : j + 1 ≤ M) (A U V : Matrix (Fin (j + 1)) (Fin (j + 1)) ℝ)
    (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOp A U V) (torusOp A U V) (torusOp A U V) ≤ kapE M * (normSq2 (torusOp A U V)) ^ ((3 : ℝ) / 2) := by
  rw [Ftri_torus A U V hA hU hV, L271_norm A U V hU hV]
  exact FE_le M hM (M - (j + 1)) j (by omega) A U V hA hU hV

/-- **L282 (2)**: for `M ≥ 7` and `m + 1 ≤ M`, every torus-invariant operator on `𝔰𝔬(2m + 1)` has
`F(C) ≤ κ_{2M} ‖C‖³`, through batch 11's border `w/√2` into `𝔰𝔬(2m + 2)`. -/
theorem H_small_odd (M : ℕ) (hM : 7 ≤ M) (j : ℕ) (hj : j + 2 ≤ M) (A U V : Matrix (Fin (j + 1)) (Fin (j + 1)) ℝ)
    (w : Fin (j + 1) → ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    Ftri (torusOpOdd A U V w) (torusOpOdd A U V w) (torusOpOdd A U V w)
      ≤ kapE M * (normSq2 (torusOpOdd A U V w)) ^ ((3 : ℝ) / 2) := by
  set r := Real.sqrt 2 with hr
  have hr2 : r ^ 2 = 2 := Real.sq_sqrt (by norm_num)
  have hr0 : 0 < r := Real.sqrt_pos.2 (by norm_num)
  set z : Fin (j + 1) → ℝ := fun i => w i / r with hzd
  have hz2 : ∀ i, 2 * z i ^ 2 = w i ^ 2 := fun i => by
    simp only [hzd]; rw [div_pow, hr2]; field_simp
  have hzz : ∀ i k, 2 * z i * z k = w i * w k := fun i k => by
    simp only [hzd]; field_simp; rw [hr2]; ring
  have hF : 3 * ∑ i, A i i * (dvec U V i + w i ^ 2)
        - 3 * (∑ i, ∑ k, if i = k then 0 else A i k * (U + V) i k * (U - V) i k)
        + (1 / 2) * Matrix.trace ((U + V) * (U + V) * (U + V)) + (1 / 2) * Matrix.trace ((U - V) * (U - V) * (U - V))
        + 3 * ∑ i, ∑ k, w i * (U + V) i k * w k = FE (bord A 0) (bord U z) (bord V z) := by
    rw [FE_bord]
    have e1 : ∀ i, dvec U V i + 2 * z i ^ 2 = dvec U V i + w i ^ 2 := fun i => by rw [hz2]
    have e2 : ∀ i k, 2 * z i * (U + V) i k * z k = w i * (U + V) i k * w k := fun i k => by
      rw [show 2 * z i * (U + V) i k * z k = (2 * z i * z k) * (U + V) i k by ring, hzz]; ring
    simp only [e1, e2]
  have hN : (∑ i, ∑ k, A i k ^ 2) + (∑ i, ∑ k, U i k ^ 2) + (∑ i, ∑ k, V i k ^ 2) + 2 * ∑ i, w i ^ 2
      = NE (bord A 0) (bord U z) (bord V z) := by
    rw [NE_bord]
    unfold NE
    have e : (1 / 2 : ℝ) * (∑ i, ∑ k, (U + V) i k ^ 2) + (1 / 2) * (∑ i, ∑ k, (U - V) i k ^ 2)
        = (∑ i, ∑ k, U i k ^ 2) + (∑ i, ∑ k, V i k ^ 2) := by
      simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
      exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun k _ => by
        simp only [Matrix.add_apply, Matrix.sub_apply]; ring
    have e' : 4 * ∑ i, z i ^ 2 = 2 * ∑ i, w i ^ 2 := by
      rw [Finset.mul_sum, Finset.mul_sum]
      exact Finset.sum_congr rfl fun i _ => by rw [← hz2 i]; ring
    rw [e']; linarith
  rw [L280_F A U V w hA hU hV, L280_norm A U V w hU hV, hF, hN]
  exact FE_le M hM (M - (j + 2)) (j + 1) (by omega) (bord A 0) (bord U z) (bord V z) (bord_symm j A hA)
    (pairw_bord U z hU) (pairw_bord V z hV)

end HamiltonsCubic.TorusEmbed
