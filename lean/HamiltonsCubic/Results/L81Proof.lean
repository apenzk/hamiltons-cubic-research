import HamiltonsCubic.Results.SkewCentraliser

/-!
# L81, proved

[L81Statement.lean](L81Statement.lean) states the criterion and carries its definitions;
[SkewCentraliser.lean](SkewCentraliser.lean) carries the computation. **`L81` is proved here**, in the
statement's namespace, because the computation imports the definitions.

For nonzero skew `x` at `m ≠ 3`, take its normal form `x = Σ a_j R_j`:

* **two planes of equal singular value**: `𝔷(𝔠) ∩ 𝔠^⊥ = span{x, Y₁, Y₂}`, of dimension `3`, and `x` is a
  multiple of the rank-`4` complex structure `R₁ + R₂`;
* **otherwise**: `𝔷(𝔠) ∩ 𝔠^⊥ = ℝx`, of dimension `1`, and `x` is no such multiple, since a multiple of a
  rank-`4` complex structure has rank `4` and cube `-c²x`, which forces two planes of equal value.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.L81Statement

open Matrix Module HamiltonsCubic.SkewNormalForm HamiltonsCubic.SkewCentraliser

variable {m : ℕ}

theorem co_zero_mat' (p q : Fin m → ℝ) : co (0 : Matrix (Fin m) (Fin m) ℝ) p q = 0 := by
  unfold co; rw [Matrix.zero_mulVec, dotProduct_zero]

/-- **L81.** For every nonzero `x ∈ 𝔰𝔬(m)` with `m ≠ 3`: `dim(𝔷(𝔠) ∩ 𝔠^⊥) > 1` exactly when `x`
is a multiple of a rank-`4` complex structure, and the dimension is always `1` or `3`.

**Proved** by the normal form and an entry-by-entry reading of the centraliser, the elementary
counterpart of the record's root argument; `m ≠ 3` enters once, at rank two, where a third direction
orthogonal to the plane and to a kernel vector is needed. -/
theorem L81 (hm : m ≠ 3) (x : Matrix (Fin m) (Fin m) ℝ) (hxskew : Skew x) (hx0 : x ≠ 0) :
    (1 < finrank ℝ (zPerp x) ↔ MultipleOfRankFour x) ∧
      (finrank ℝ (zPerp x) = 1 ∨ finrank ℝ (zPerp x) = 3) := by
  obtain ⟨N⟩ := nf_exists hxskew
  have hk : 0 < N.k := by
    by_contra h
    apply hx0
    rw [N.eq]
    exact Finset.sum_eq_zero fun l _ => absurd l.2 (by omega)
  have hmul := mult_iff N hxskew
  have hxz : x ∈ zPerp x := x_mem_zPerp hxskew
  by_cases hE : N.k = 2 ∧ ∀ i j, N.a i = N.a j
  · obtain ⟨hk2, heq⟩ := hE
    set i : Fin N.k := ⟨0, by omega⟩ with hi
    set j : Fin N.k := ⟨1, by omega⟩ with hj
    have hij : i ≠ j := by simp [hi, hj, Fin.ext_iff]
    have hall : ∀ l : Fin N.k, l = i ∨ l = j := fun l => by
      have := l.2
      by_cases h : l.val = 0
      · left; exact Fin.ext h
      · right; exact Fin.ext (by simp [hj]; omega)
    have heq' := heq i j
    let F : Fin 3 → Matrix (Fin m) (Fin m) ℝ := ![x, Y1 N i j, Y2 N i j]
    have hspan : zPerp x = Submodule.span ℝ (Set.range F) := by
      apply le_antisymm
      · intro y hy
        obtain ⟨s, α, γ, rfl⟩ := upper_exc N hy hxskew hij hall heq'
        refine Submodule.add_mem _ (Submodule.add_mem _ ?_ ?_) ?_ <;>
          refine Submodule.smul_mem _ _ (Submodule.subset_span ?_)
        exacts [⟨0, rfl⟩, ⟨1, rfl⟩, ⟨2, rfl⟩]
      · rw [Submodule.span_le]
        rintro _ ⟨t, rfl⟩
        fin_cases t
        exacts [hxz, Y1_mem N hxskew hij hall heq', Y2_mem N hxskew hij hall heq']
    have hli : LinearIndependent ℝ F := by
      rw [Fintype.linearIndependent_iff]
      intro g hg
      have e : ∀ p q, ∑ t, g t * co (F t) p q = 0 := fun p q => by
        have := congrArg (fun M => co M p q) hg
        simpa [co_matsum, co_matsmul, co_zero_mat'] using this
      have h1 := e (N.u i) (N.w i)
      have h2 := e (N.u i) (N.u j)
      have h3 := e (N.u i) (N.w j)
      simp only [Fin.sum_univ_three, F, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two,
        Matrix.head_cons, Matrix.tail_cons, co_x_uu, co_x_uw, coY1_wi N hij, coY2_wi N hij, coY1_uj N hij,
        coY2_uj N hij, coY1_wj N hij, coY2_wj N hij, uu_one, uu_ne N hij, N.uw, if_pos, if_neg hij,
        mul_zero, mul_one, neg_zero, add_zero, zero_add] at h1 h2 h3
      have ha := N.apos i
      have g0 : g 0 = 0 := by
        have : g 0 * N.a i = 0 := by linarith
        exact (mul_eq_zero.mp this).resolve_right ha.ne'
      intro t
      fin_cases t
      · exact g0
      · simpa using h2
      · simpa using h3
    have hfin : finrank ℝ (zPerp x) = 3 := by
      rw [hspan, finrank_span_eq_card hli]; simp
    exact ⟨⟨fun _ => hmul.mpr ⟨hk2, heq⟩, fun _ => by omega⟩, Or.inr hfin⟩
  · have hexc : N.k = 2 → ∀ j l : Fin N.k, j ≠ l → N.a j ≠ N.a l := by
      intro hk2 j l hjl hjla
      apply hE
      refine ⟨hk2, fun p q => ?_⟩
      have hjl' : j.val ≠ l.val := fun h => hjl (Fin.ext h)
      have hall : ∀ r : Fin N.k, N.a r = N.a j := fun r => by
        have := r.2; have := j.2; have := l.2
        by_cases h : r.val = j.val
        · rw [Fin.ext h]
        · rw [show r = l from Fin.ext (by omega), hjla]
      rw [hall p, hall q]
    have hspan : zPerp x = Submodule.span ℝ {x} := by
      apply le_antisymm
      · intro y hy
        obtain ⟨s, rfl⟩ := upper_general N hy hxskew hm hk hexc
        exact Submodule.smul_mem _ _ (Submodule.mem_span_singleton_self x)
      · rw [Submodule.span_le, Set.singleton_subset_iff]; exact hxz
    have hfin : finrank ℝ (zPerp x) = 1 := by rw [hspan, finrank_span_singleton hx0]
    exact ⟨⟨fun h => by omega, fun h => absurd (hmul.mp h) hE⟩, Or.inl hfin⟩

end HamiltonsCubic.L81Statement
