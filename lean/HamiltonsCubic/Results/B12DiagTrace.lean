import HamiltonsCubic.Results.B12Diag
import HamiltonsCubic.Results.L127DnLam
import HamiltonsCubic.Results.L127DnSpan

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# B12, step 5b: the diagonal sector contributes `θ²[1 + (p−1)λ_p² + (q−1)λ_q² + (p−1)(q−1)μ²]` at the sphere product

[B12Diag.lean](B12Diag.lean) reduces the diagonal sector to `tr((KL w)²|_{𝒟ₙ})`. At `w = t · W_T` with `p, q ≥ 3`, `t ≠ 0`,
[L127DnEig.lean](L127DnEig.lean) and [L127DnLam.lean](L127DnLam.lean) name the eigenspaces of `KL` in `𝒟ₙ` with their
dimensions, and [L127DnSpan.lean](L127DnSpan.lean)'s `dn_decomp` shows they span `𝒟ₙ`:

* **`trace_sq_pieces`**: if `𝒟ₙ` is the join of the pieces `𝒟ₙ ⊓ E(ν_i)` for distinct `ν_i`, then
  `tr((KL w)²|_{𝒟ₙ}) = ∑_i ν_i² dim(𝒟ₙ ⊓ E(ν_i))`, by Mathlib's `trace_eq_sum_trace_restrict_of_eq_biSup` and the
  independence of eigenspaces;
* **`trace_diag_sphere_ne`**, **`trace_diag_sphere_eq`**: the value at `p ≠ q` (five pieces) and at `p = q` (four, the two
  `λ` families sharing one eigenvalue);
* **`trace_diag_sphere`**: `θ²[1 + (p−1)λ_p² + (q−1)λ_q² + (p−1)(q−1)μ²]` in both cases, `θ = dnθ`, `λ = dnLp, dnLq`,
  `−μ = dnMu`.
-/

namespace HamiltonsCubic.B12DiagTrace

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.Results HamiltonsCubic.B12Diag

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The eigen-piece of `KL w` in `𝒟ₙ` at `ν`. -/
noncomputable abbrev piece (w : Matrix ι ι ℝ) (ν : ℝ) : Submodule ℝ (Matrix ι ι ℝ) := dnWeights ι ⊓ (KL w).eigenspace ν

theorem piece_maps {w : Matrix ι ι ℝ} (hw : IsWeight w) (ν : ℝ) :
    Set.MapsTo (KL w ∘ₗ KL w) (piece w ν) (piece w ν) := by
  rintro v ⟨hv, hE⟩
  have e := Module.End.mem_eigenspace_iff.mp hE
  have h2 : (KL w ∘ₗ KL w) v = (ν * ν) • v := by rw [LinearMap.comp_apply, e, map_smul, e, smul_smul]
  refine ⟨KL_mapsTo hw _ (KL_mapsTo hw v hv), ?_⟩
  rw [h2]
  exact Submodule.smul_mem _ _ hE

theorem trace_piece {w : Matrix ι ι ℝ} (hw : IsWeight w) (ν : ℝ) :
    LinearMap.trace ℝ (piece w ν) ((KL w ∘ₗ KL w).restrict (piece_maps hw ν))
      = ν ^ 2 * Module.finrank ℝ (piece w ν) := by
  have h : (KL w ∘ₗ KL w).restrict (piece_maps hw ν) = (ν ^ 2) • LinearMap.id := by
    apply LinearMap.ext; rintro ⟨v, hv, hE⟩
    apply Subtype.ext
    have e := Module.End.mem_eigenspace_iff.mp hE
    show KL w (KL w v) = (ν ^ 2) • v
    rw [e, map_smul, e, smul_smul, sq]
  rw [h, map_smul, LinearMap.trace_id, smul_eq_mul]

/-- **The trace of `(KL w)²` over distinct eigen-pieces that span `𝒟ₙ`.** -/
theorem trace_sq_pieces {m : ℕ} {w : Matrix ι ι ℝ} (hw : IsWeight w) (ν : Fin m → ℝ) (hν : Function.Injective ν)
    (hdn : dnWeights ι = ⨆ i ∈ (Finset.univ : Finset (Fin m)), piece w (ν i)) :
    LinearMap.trace ℝ (dnWeights ι) (KL2 hw) = ∑ i, ν i ^ 2 * Module.finrank ℝ (piece w (ν i)) := by
  have hind : iSupIndep (fun i : (Finset.univ : Finset (Fin m)) => piece w (ν i)) := by
    have h1 : iSupIndep (fun i : Fin m => (KL w).eigenspace (ν i)) :=
      (Module.End.eigenspaces_iSupIndep (KL w)).comp hν
    have h2 : iSupIndep (fun i : Fin m => piece w (ν i)) := h1.mono fun i => inf_le_right
    exact h2.comp Subtype.val_injective
  have h := LinearMap.trace_eq_sum_trace_restrict_of_eq_biSup (Finset.univ : Finset (Fin m)) hind
    (fun i => piece_maps hw (ν i)) (dnWeights ι) hdn (fun v hv => KL_mapsTo hw _ (KL_mapsTo hw v hv))
  rw [show KL2 hw = (KL w ∘ₗ KL w).restrict (fun v hv => KL_mapsTo hw _ (KL_mapsTo hw v hv)) from rfl, h]
  exact Finset.sum_congr rfl fun i _ => trace_piece hw (ν i)

section sphere

variable (T : Finset ι) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card) (t : ℝ) (ht : t ≠ 0)

include hp hq in
theorem sphere_weight : IsWeight (t • sphereWeight T) :=
  (sphereWeight_isWeight T (by omega) (by omega)).smul t

include hp hq ht in
theorem piece_le (ν : ℝ) : piece (t • sphereWeight T) ν ≤ dnWeights ι := inf_le_left

theorem mem_biSup {m : ℕ} (N : Fin m → Submodule ℝ (Matrix ι ι ℝ)) (i : Fin m) {u : Matrix ι ι ℝ} (hu : u ∈ N i) :
    u ∈ ⨆ i ∈ (Finset.univ : Finset (Fin m)), N i :=
  (le_iSup₂ (f := fun i (_ : i ∈ (Finset.univ : Finset (Fin m))) => N i) i (Finset.mem_univ i)) hu

include hp hq ht in
/-- **At `p ≠ q`: five pieces.** -/
theorem trace_diag_sphere_ne (hpq : T.card ≠ Tᶜ.card) :
    LinearMap.trace ℝ (dnWeights ι) (KL2 (sphere_weight T hp hq t))
      = dnθ T t ^ 2 * (1 + ((T.card : ℝ) - 1) * dnLp T ^ 2 + ((Tᶜ.card : ℝ) - 1) * dnLq T ^ 2
          + ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1) * dnMu T ^ 2) := by
  obtain ⟨u1, u2, u3, u4, u5⟩ := dn_units T hp hq
  have hLne : dnLp T ≠ dnLq T := fun e => hpq ((dnLp_eq_dnLq_iff T hp hq).mp e)
  have hθ := dnθ_ne T hp hq t ht
  set ν : Fin 5 → ℝ := ![dnθ T t * 1, dnθ T t * dnLp T, dnθ T t * dnLq T, dnθ T t * dnMu T, 0] with hνdef
  have hne : ∀ a b : ℝ, a ≠ b → dnθ T t * a ≠ dnθ T t * b := fun a b h => dnθ_mul_ne T hp hq t ht h
  have hz : ∀ a : ℝ, a ≠ 0 → dnθ T t * a ≠ 0 := fun a h => mul_ne_zero hθ h
  have hν : Function.Injective ν := by
    intro i j h
    fin_cases i <;> fin_cases j <;> simp only [hνdef, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val,
      Fin.reduceFinMk, Fin.isValue] at h ⊢ <;> first
      | rfl
      | exact absurd h (hne _ _ (by linarith))
      | exact absurd h (hne _ _ hLne)
      | exact absurd h (hne _ _ (Ne.symm hLne))
      | exact absurd h (hz _ (by linarith))
      | exact absurd h.symm (hz _ (by linarith))
  have hw := sphere_weight T hp hq t
  have hdn : dnWeights ι = ⨆ i ∈ (Finset.univ : Finset (Fin 5)), piece (t • sphereWeight T) (ν i) := by
    apply le_antisymm
    · intro u hu
      obtain ⟨c, h, h', X, Z, Z', hh, hh', hX, hZ, hZ', rfl⟩ := dn_decomp T hu hp hq
      have m0 : c • sphereWeight T ∈ piece (t • sphereWeight T) (ν 0) := by
        show _ ∈ dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1)
        rw [dn_eig_line T hp hq t ht]
        exact Submodule.smul_mem _ c (Submodule.subset_span rfl)
      have m1 : lamW T (dnK T) h ∈ piece (t • sphereWeight T) (ν 1) := by
        show _ ∈ dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T)
        rw [dn_eig_lamp T hp hq t ht hpq]
        exact mem_range_lamMap T _ h hh
      have m2 : lamW Tᶜ (dnK Tᶜ) h' ∈ piece (t • sphereWeight T) (ν 2) := by
        show _ ∈ dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLq T)
        rw [dn_eig_lamq T hp hq t ht hpq]
        exact mem_range_lamMap Tᶜ _ h' hh'
      have m3 : X ∈ piece (t • sphereWeight T) (ν 3) := by
        show _ ∈ dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T)
        rw [dn_eig_cross T hp hq t ht]
        exact hX
      have m4 : Z + Z' ∈ piece (t • sphereWeight T) (ν 4) := by
        show _ ∈ dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0
        rw [dn_eig_zero T hp hq t ht]
        exact Submodule.add_mem _ (Submodule.mem_sup_left hZ) (Submodule.mem_sup_right hZ')
      rw [add_assoc (_ + _ + _ + X) Z Z']
      refine Submodule.add_mem _ (Submodule.add_mem _ (Submodule.add_mem _ (Submodule.add_mem _ ?_ ?_) ?_) ?_) ?_
      · exact mem_biSup _ 0 m0
      · exact mem_biSup _ 1 m1
      · exact mem_biSup _ 2 m2
      · exact mem_biSup _ 3 m3
      · exact mem_biSup _ 4 m4
    · exact iSup₂_le fun i _ => inf_le_left
  rw [trace_sq_pieces hw ν hν hdn, Fin.sum_univ_five]
  simp only [hνdef, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val, Fin.reduceFinMk, Fin.isValue]
  have f0 : Module.finrank ℝ (piece (t • sphereWeight T) (ν 0)) = 1 := finrank_eig_line T hp hq t ht
  have f1 : Module.finrank ℝ (piece (t • sphereWeight T) (ν 1)) = T.card - 1 := finrank_eig_lamp T hp hq t ht hpq
  have f2 : Module.finrank ℝ (piece (t • sphereWeight T) (ν 2)) = Tᶜ.card - 1 := finrank_eig_lamq T hp hq t ht hpq
  have f3 : Module.finrank ℝ (piece (t • sphereWeight T) (ν 3)) = (T.card - 1) * (Tᶜ.card - 1) :=
    finrank_eig_cross T hp hq t ht
  rw [f0, f1, f2, f3]
  push_cast [Nat.cast_sub (show 1 ≤ T.card by omega), Nat.cast_sub (show 1 ≤ Tᶜ.card by omega)]
  ring

include hp hq ht in
/-- **At `p = q`: four pieces**, the two `λ` families sharing the eigenvalue. -/
theorem trace_diag_sphere_eq (hpq : T.card = Tᶜ.card) :
    LinearMap.trace ℝ (dnWeights ι) (KL2 (sphere_weight T hp hq t))
      = dnθ T t ^ 2 * (1 + ((T.card : ℝ) - 1) * dnLp T ^ 2 + ((Tᶜ.card : ℝ) - 1) * dnLq T ^ 2
          + ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1) * dnMu T ^ 2) := by
  obtain ⟨u1, u2, u3, u4, u5⟩ := dn_units T hp hq
  have hL : dnLp T = dnLq T := (dnLp_eq_dnLq_iff T hp hq).mpr hpq
  have hθ := dnθ_ne T hp hq t ht
  set ν : Fin 4 → ℝ := ![dnθ T t * 1, dnθ T t * dnLp T, dnθ T t * dnMu T, 0] with hνdef
  have hne : ∀ a b : ℝ, a ≠ b → dnθ T t * a ≠ dnθ T t * b := fun a b h => dnθ_mul_ne T hp hq t ht h
  have hz : ∀ a : ℝ, a ≠ 0 → dnθ T t * a ≠ 0 := fun a h => mul_ne_zero hθ h
  have hν : Function.Injective ν := by
    intro i j h
    fin_cases i <;> fin_cases j <;> simp only [hνdef, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val,
      Fin.reduceFinMk, Fin.isValue] at h ⊢ <;> first
      | rfl
      | exact absurd h (hne _ _ (by linarith))
      | exact absurd h (hz _ (by linarith))
      | exact absurd h.symm (hz _ (by linarith))
  have hw := sphere_weight T hp hq t
  have hdn : dnWeights ι = ⨆ i ∈ (Finset.univ : Finset (Fin 4)), piece (t • sphereWeight T) (ν i) := by
    apply le_antisymm
    · intro u hu
      obtain ⟨c, h, h', X, Z, Z', hh, hh', hX, hZ, hZ', rfl⟩ := dn_decomp T hu hp hq
      have m0 : c • sphereWeight T ∈ piece (t • sphereWeight T) (ν 0) := by
        show _ ∈ dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * 1)
        rw [dn_eig_line T hp hq t ht]
        exact Submodule.smul_mem _ c (Submodule.subset_span rfl)
      have m1 : lamW T (dnK T) h + lamW Tᶜ (dnK Tᶜ) h' ∈ piece (t • sphereWeight T) (ν 1) := by
        show _ ∈ dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnLp T)
        rw [dn_eig_lam_eq T hp hq t ht hpq]
        exact Submodule.add_mem _ (Submodule.mem_sup_left (mem_range_lamMap T _ h hh))
          (Submodule.mem_sup_right (mem_range_lamMap Tᶜ _ h' hh'))
      have m2 : X ∈ piece (t • sphereWeight T) (ν 2) := by
        show _ ∈ dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace (dnθ T t * dnMu T)
        rw [dn_eig_cross T hp hq t ht]
        exact hX
      have m3 : Z + Z' ∈ piece (t • sphereWeight T) (ν 3) := by
        show _ ∈ dnWeights ι ⊓ (KL (t • sphereWeight T)).eigenspace 0
        rw [dn_eig_zero T hp hq t ht]
        exact Submodule.add_mem _ (Submodule.mem_sup_left hZ) (Submodule.mem_sup_right hZ')
      rw [add_assoc (_ + _ + _ + X) Z Z', add_assoc (c • sphereWeight T) (lamW T (dnK T) h) (lamW Tᶜ (dnK Tᶜ) h')]
      refine Submodule.add_mem _ (Submodule.add_mem _ (Submodule.add_mem _ ?_ ?_) ?_) ?_
      · exact mem_biSup _ 0 m0
      · exact mem_biSup _ 1 m1
      · exact mem_biSup _ 2 m2
      · exact mem_biSup _ 3 m3
    · exact iSup₂_le fun i _ => inf_le_left
  rw [trace_sq_pieces hw ν hν hdn, Fin.sum_univ_four]
  simp only [hνdef, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val, Fin.reduceFinMk, Fin.isValue]
  have f0 : Module.finrank ℝ (piece (t • sphereWeight T) (ν 0)) = 1 := finrank_eig_line T hp hq t ht
  have f1 : Module.finrank ℝ (piece (t • sphereWeight T) (ν 1)) = 2 * (T.card - 1) := finrank_eig_lam_eq T hp hq t ht hpq
  have f2 : Module.finrank ℝ (piece (t • sphereWeight T) (ν 2)) = (T.card - 1) * (Tᶜ.card - 1) :=
    finrank_eig_cross T hp hq t ht
  rw [f0, f1, f2, ← hL]
  have hc : (Tᶜ.card : ℝ) = T.card := by exact_mod_cast hpq.symm
  push_cast [Nat.cast_sub (show 1 ≤ T.card by omega), Nat.cast_sub (show 1 ≤ Tᶜ.card by omega)]
  rw [hc]
  ring

include hp hq ht in
/-- **The diagonal sector at the sphere product**, `θ²[1 + (p−1)λ_p² + (q−1)λ_q² + (p−1)(q−1)μ²]`. -/
theorem trace_diag_sphere :
    LinearMap.trace ℝ (dnWeights ι) (KL2 (sphere_weight T hp hq t))
      = dnθ T t ^ 2 * (1 + ((T.card : ℝ) - 1) * dnLp T ^ 2 + ((Tᶜ.card : ℝ) - 1) * dnLq T ^ 2
          + ((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1) * dnMu T ^ 2) := by
  by_cases hpq : T.card = Tᶜ.card
  · exact trace_diag_sphere_eq T hp hq t ht hpq
  · exact trace_diag_sphere_ne T hp hq t ht hpq

end sphere

end HamiltonsCubic.B12DiagTrace
