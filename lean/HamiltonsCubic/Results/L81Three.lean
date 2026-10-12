import HamiltonsCubic.Results.L160

/-!
# L81 at `m = 3`: the criterion fails there

[L81Proof.lean](L81Proof.lean) proves L81's criterion at every `m ≠ 3`: `dim(𝔷(𝔠) ∩ 𝔠^⊥) > 1` exactly when `x`
is a multiple of a rank-`4` complex structure. **At `m = 3` the criterion fails at every nonzero `x`**:
`𝔷(𝔠) ∩ 𝔠^⊥` is all of `𝔰𝔬(3)`, of dimension `3` (`finrank_eq_three`), while `𝔰𝔬(3)` holds no multiple of a
rank-`4` complex structure ([L81Statement.lean](L81Statement.lean)'s `no_multiple_in_so_three`).

The dimension bound comes from [L160.lean](L160.lean): `x` and a rotation `rot(u, z)` with `z ∈ ker x` both lie
in `𝔷(𝔠) ∩ 𝔠^⊥`, and they are independent because the second moves `z` and the first kills it.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L81Three

open Matrix Module HamiltonsCubic.SkewNormalForm HamiltonsCubic.SkewCentraliser HamiltonsCubic.L81Statement
  HamiltonsCubic.MixedSummand

/-- **At `m = 3`, `dim(𝔷(𝔠) ∩ 𝔠^⊥) ≥ 2`** for every nonzero skew `x`. -/
theorem two_le_finrank {x : Matrix (Fin 3) (Fin 3) ℝ} (hx : Skew x) (hx0 : x ≠ 0) :
    2 ≤ finrank ℝ (zPerp x) := by
  obtain ⟨y, hy, z, hz, hyz⟩ := L160_three hx rfl hx0
  have hxz : x ∈ zPerp x := x_mem_zPerp hx
  let f : Fin 2 → zPerp x := ![⟨x, hxz⟩, ⟨y, hy⟩]
  have hli : LinearIndependent ℝ f := by
    rw [Fintype.linearIndependent_iff]
    intro g hg
    have h := congrArg (fun v : zPerp x => (v : Matrix (Fin 3) (Fin 3) ℝ)) hg
    simp only [Fin.sum_univ_two, f, Matrix.cons_val_zero, Matrix.cons_val_one, Submodule.coe_add,
      Submodule.coe_smul, Submodule.coe_zero] at h
    have hb : g 1 = 0 := by
      have := congrArg (fun M => M *ᵥ z) h
      simp only [Matrix.add_mulVec, Matrix.smul_mulVec, hz, smul_zero, zero_add, Matrix.zero_mulVec] at this
      exact (smul_eq_zero.mp this).resolve_right hyz
    have ha : g 0 = 0 := by
      rw [hb, zero_smul, add_zero] at h
      exact (smul_eq_zero.mp h).resolve_right hx0
    intro i; fin_cases i
    · exact ha
    · exact hb
  simpa using hli.fintype_card_le_finrank

/-- The basis rotation `e_j e_iᵀ - e_i e_jᵀ` of `𝔰𝔬(3)`. -/
noncomputable def E3 (i j : Fin 3) : Matrix (Fin 3) (Fin 3) ℝ := rot (Pi.single i 1) (Pi.single j 1)

/-- **At `m = 3`, `dim(𝔷(𝔠) ∩ 𝔠^⊥) = 3`** for every nonzero skew `x`: `𝔠 = 0` by
[L160.lean](L160.lean)'s `cc_three`, so `𝔷(𝔠) ∩ 𝔠^⊥` is all of `𝔰𝔬(3)`, spanned by three independent
rotations and read off by three coordinates. -/
theorem finrank_eq_three {x : Matrix (Fin 3) (Fin 3) ℝ} (hx : Skew x) (hx0 : x ≠ 0) :
    finrank ℝ (zPerp x) = 3 := by
  have hc : ∀ c ∈ cc x, c = 0 := fun c hc => cc_three hx rfl hx0 hc
  have hmem : ∀ y : Matrix (Fin 3) (Fin 3) ℝ, Skew y → y ∈ zPerp x := fun y hy =>
    ⟨hy, fun c hc' => by rw [hc c hc']; unfold br; simp,
      fun c hc' => by rw [hc c hc']; unfold inner2; simp⟩
  apply le_antisymm
  · let f : zPerp x →ₗ[ℝ] (Fin 3 → ℝ) :=
      { toFun := fun y => ![(y : Matrix (Fin 3) (Fin 3) ℝ) 1 0, (y : Matrix (Fin 3) (Fin 3) ℝ) 2 0,
          (y : Matrix (Fin 3) (Fin 3) ℝ) 2 1]
        map_add' := fun a b => by ext i; fin_cases i <;> simp
        map_smul' := fun c a => by ext i; fin_cases i <;> simp }
    have hinj : Function.Injective f := by
      rw [← LinearMap.ker_eq_bot, LinearMap.ker_eq_bot']
      intro y hy
      have e0 := congrFun hy 0
      have e1 := congrFun hy 1
      have e2 := congrFun hy 2
      simp only [f, LinearMap.coe_mk, AddHom.coe_mk, Matrix.cons_val_zero, Matrix.cons_val_one,
        Matrix.cons_val_two, Matrix.head_cons, Matrix.tail_cons, Pi.zero_apply] at e0 e1 e2
      have hs := y.2.1
      unfold Skew at hs
      have sk : ∀ i j, (y : Matrix (Fin 3) (Fin 3) ℝ) j i = -(y : Matrix (Fin 3) (Fin 3) ℝ) i j := fun i j => by
        have := congrFun (congrFun hs i) j
        simpa [Matrix.transpose_apply] using this
      have s00 := sk 0 0
      have s11 := sk 1 1
      have s22 := sk 2 2
      have s01 := sk 0 1
      have s02 := sk 0 2
      have s12 := sk 1 2
      apply Subtype.ext
      ext i j
      fin_cases i <;> fin_cases j <;> simp only [Submodule.coe_zero, Matrix.zero_apply] <;>
        simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] at * <;> linarith
    simpa using LinearMap.finrank_le_finrank_of_injective hinj
  · let F : Fin 3 → zPerp x := ![⟨E3 0 1, hmem _ (rot_skew _ _)⟩, ⟨E3 0 2, hmem _ (rot_skew _ _)⟩,
      ⟨E3 1 2, hmem _ (rot_skew _ _)⟩]
    have hli : LinearIndependent ℝ F := by
      rw [Fintype.linearIndependent_iff]
      intro g hg
      have h := congrArg (fun v : zPerp x => (v : Matrix (Fin 3) (Fin 3) ℝ)) hg
      simp only [Fin.sum_univ_three, F, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
        Matrix.head_cons, Matrix.tail_cons, Submodule.coe_add, Submodule.coe_smul, Submodule.coe_zero] at h
      have h10 := congrFun (congrFun h 1) 0
      have h20 := congrFun (congrFun h 2) 0
      have h21 := congrFun (congrFun h 2) 1
      simp [E3, rot, vecMulVec, Pi.single_apply] at h10 h20 h21
      intro i; fin_cases i
      · simpa using h10
      · simpa using h20
      · simpa using h21
    simpa using hli.fintype_card_le_finrank

/-- **L81's criterion fails at `m = 3`**: at every nonzero `x ∈ 𝔰𝔬(3)`, `dim(𝔷(𝔠) ∩ 𝔠^⊥) > 1` while `x` is no
multiple of a rank-`4` complex structure. -/
theorem L81_fails_three {x : Matrix (Fin 3) (Fin 3) ℝ} (hx : Skew x) (hx0 : x ≠ 0) :
    1 < finrank ℝ (zPerp x) ∧ ¬ MultipleOfRankFour x :=
  ⟨by have := two_le_finrank hx hx0; omega, no_multiple_in_so_three x⟩

end HamiltonsCubic.L81Three
