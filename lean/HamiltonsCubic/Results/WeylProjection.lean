import Mathlib.Tactic
import HamiltonsCubic.Results.WeylRicciRemoval
import HamiltonsCubic.Base.AltPart

/-!
# The map onto `𝒲ₙ`: remove `Alt(R)`, then the Kulkarni–Nomizu part

The map L234's split projects with ([lean/INDEX.md](../../INDEX.md), the L234 row), built from
[WeylRicciRemoval.lean](WeylRicciRemoval.lean)'s Ricci removal and AltPart's `altCoeff`.

## What is typed here

* `opOf C`, the bivector operator with four-index array `C`, `X ↦ ¼ Σ ⟨X, φ_ij⟩ C_{ijkl} φ_kl`:
  linear (`opOf_isLinOp`), bivector-valued (`opOf_isSkew`), read back as `C` when `C` is antisymmetric
  in each pair (`comp_opOf`), and self-adjoint when `C` is pair-symmetric (`opOf_sym`).
* `bianchi_sub_alt`: `R − opOf (Alt R)` is first-Bianchi at every linear self-adjoint `R`, since
  `bianchi R = 3 Alt(R)` and `Alt(R)` is cyclic in its last three indices.
* `weylProj R = weylOfBianchi (R − opOf (Alt R))` and `weylProj_isWeylOp`: **for every linear,
  bivector-preserving, self-adjoint `R` at `n ≥ 3`, `weylProj R` is in the record's `𝒲ₙ`.**
* **Orthogonality of the removed parts** is `weylProj_orth` in [WeylOrthogonal.lean](WeylOrthogonal.lean),
  which makes `weylProj` the orthogonal projection.
-/

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

namespace HamiltonsCubic.Results

open Finset RealLayer FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **A bivector operator from its four-index array**, `X ↦ ¼ Σ ⟨X, φ_ij⟩ C_{ijkl} φ_kl`. -/
noncomputable def opOf (C : ι → ι → ι → ι → ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ := fun X =>
  (1/4 : ℝ) • ∑ i, ∑ j, ∑ k, ∑ l, (inner2 X (phi i j) * C i j k l) • phi k l

theorem pair_collapse (a b : ι) (f : ι → ι → ℝ) :
    ∑ i, ∑ j, inner2 (phi a b) (phi i j) * f i j = f a b - f b a := by
  simp only [inner2_phi_phi, sub_mul, ite_mul, one_mul, zero_mul, ite_and, Finset.sum_sub_distrib]
  have e : ∀ u v : ι, ∑ x, ∑ y, (if u = x then if v = y then f x y else 0 else 0) = f u v := by
    intro u v
    rw [Fintype.sum_eq_single u (fun x hx => by simp [Ne.symm hx])]
    simp
  rw [e, e]

theorem pair_collapse' (c d : ι) (f : ι → ι → ℝ) :
    ∑ k, ∑ l, f k l * inner2 (phi k l) (phi c d) = f c d - f d c := by
  simp only [inner2_phi_phi, mul_sub, mul_ite, mul_one, mul_zero, ite_and, Finset.sum_sub_distrib]
  have e : ∀ u v : ι, ∑ x, ∑ y, (if x = u then if y = v then f x y else 0 else 0) = f u v := by
    intro u v
    rw [Fintype.sum_eq_single u (fun x hx => by simp [hx])]
    simp
  have e2 : ∀ u v : ι, ∑ x, ∑ y, (if y = u then if x = v then f x y else 0 else 0) = f v u := by
    intro u v
    rw [Fintype.sum_eq_single v (fun x hx => by simp [hx])]
    simp
  rw [e, e2]

theorem sum4_swap_pairs (f : ι → ι → ι → ι → ℝ) :
    ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := by
  calc ∑ i, ∑ j, ∑ k, ∑ l, f i j k l = ∑ i, ∑ k, ∑ j, ∑ l, f i j k l :=
        Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ k, ∑ i, ∑ j, ∑ l, f i j k l := Finset.sum_comm
    _ = ∑ k, ∑ i, ∑ l, ∑ j, f i j k l :=
        Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun i _ => Finset.sum_comm
    _ = ∑ k, ∑ l, ∑ i, ∑ j, f i j k l := Finset.sum_congr rfl fun k _ => Finset.sum_comm

section opOf
variable (C : ι → ι → ι → ι → ℝ)

theorem opOf_isLinOp : IsLinOp (opOf C) := by
  constructor
  · intro X Y
    simp only [opOf, FamilyLayer.inner2_add_left, add_mul, add_smul, Finset.sum_add_distrib, smul_add]
  · intro c X
    simp only [opOf, FamilyLayer.inner2_smul_left, mul_assoc, ← smul_smul, ← Finset.smul_sum]
    rw [smul_comm]

theorem opOf_isSkew (X : Matrix ι ι ℝ) : IsSkew (opOf C X) := by
  unfold opOf
  exact isSkew_smul _ (isSkew_sum' _ _ fun i _ => isSkew_sum' _ _ fun j _ =>
    isSkew_sum' _ _ fun k _ => isSkew_sum' _ _ fun l _ => isSkew_smul _ (phi_isSkew k l))

theorem inner2_opOf (X Y : Matrix ι ι ℝ) :
    inner2 (opOf C X) Y
      = (1/4) * ∑ i, ∑ j, ∑ k, ∑ l, inner2 X (phi i j) * C i j k l * inner2 (phi k l) Y := by
  unfold opOf
  simp only [FamilyLayer.inner2_smul_left, inner2_sum_left']

theorem comp_opOf (hA1 : ∀ i j k l, C j i k l = - C i j k l) (hA2 : ∀ i j k l, C i j l k = - C i j k l)
    (a b c d : ι) : R4 (opOf C) a b c d = C a b c d := by
  unfold R4
  rw [inner2_opOf]
  have h : ∀ i j, ∑ k, ∑ l, inner2 (phi a b) (phi i j) * C i j k l * inner2 (phi k l) (phi c d)
      = inner2 (phi a b) (phi i j) * (C i j c d - C i j d c) := by
    intro i j
    rw [← pair_collapse' c d (fun k l => C i j k l)]
    simp only [Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    ring
  simp only [h]
  rw [pair_collapse a b (fun i j => C i j c d - C i j d c)]
  linarith [hA2 a b c d, hA1 a b c d, hA2 b a c d]

theorem opOf_sym (hP : ∀ i j k l, C k l i j = C i j k l) (X Y : Matrix ι ι ℝ) :
    inner2 (opOf C X) Y = inner2 X (opOf C Y) := by
  rw [inner2_comm X, inner2_opOf, inner2_opOf, sum4_swap_pairs]
  congr 1
  refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ =>
    Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_comm (phi k l) Y, inner2_comm (phi i j) X, hP i j k l]
  ring

end opOf

open HamiltonsCubic.AltLayer in
/-- **`Λ⁴` removal**: `R − Alt(R)` is first-Bianchi at a linear, self-adjoint `R`. -/
theorem bianchi_sub_alt (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) (i j k l : ι) :
    bianchi (fun X => R X - opOf (altCoeff R) X) i j k l = 0 := by
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = - R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hA1 := altCoeff_antisym_first R hneg hsym
  have hmid := altCoeff_antisym_mid R
  have hcyc : ∀ a b c d, altCoeff R a b c d = altCoeff R a c d b := fun a b c d => by
    unfold altCoeff alt4; ring
  have hA2 : ∀ a b c d, altCoeff R a b d c = - altCoeff R a b c d := fun a b c d => by
    linarith [hcyc a b d c, hmid a c d b, hcyc a b c d]
  have hc : ∀ a b c d, R4 (opOf (altCoeff R)) a b c d = altCoeff R a b c d :=
    comp_opOf (altCoeff R) hA1 hA2
  have h3 : bianchi R i j k l = 3 * altCoeff R i j k l := by
    rw [altCoeff_eq_third_bianchi]; ring
  unfold bianchi at h3 ⊢
  unfold R4 at hc
  simp only [inner2_sub_left', hc]
  linarith [hcyc i j k l, hcyc i k l j]

open HamiltonsCubic.AltLayer in
/-- **The projection onto `𝒲ₙ` lands in `𝒲ₙ`**: remove `Alt(R)`, then the Kulkarni–Nomizu part. -/
noncomputable def weylProj (R : Matrix ι ι ℝ → Matrix ι ι ℝ) : Matrix ι ι ℝ → Matrix ι ι ℝ :=
  weylOfBianchi (fun X => R X - opOf (altCoeff R) X)

open HamiltonsCubic.AltLayer in
theorem weylProj_isWeylOp (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hn : 3 ≤ Fintype.card ι)
    (hR : IsLinOp R) (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y)) :
    IsWeylOp (weylProj R) := by
  have hneg : ∀ Z : Matrix ι ι ℝ, R (-Z) = - R Z := fun Z => by
    have := hR.2 (-1) Z; simpa using this
  have hA1 := altCoeff_antisym_first R hneg hsym
  have hmid := altCoeff_antisym_mid R
  have hcyc : ∀ a b c d, altCoeff R a b c d = altCoeff R a c d b := fun a b c d => by
    unfold altCoeff alt4; ring
  have hA2 : ∀ a b c d, altCoeff R a b d c = - altCoeff R a b c d := fun a b c d => by
    linarith [hcyc a b d c, hmid a c d b, hcyc a b c d]
  have hP : ∀ a b c d, altCoeff R c d a b = altCoeff R a b c d := fun a b c d => by
    linarith [hcyc c d a b, hA1 a c b d, hmid a b c d]
  have hk := opOf_isLinOp (altCoeff R)
  unfold weylProj
  refine weylOfBianchi_isWeylOp _ hn ⟨fun X Y => ?_, fun c X => ?_⟩ (fun X hX => ?_)
    (fun X Y hX hY => ?_) (bianchi_sub_alt R hR hsym)
  · simp only [hR.1, hk.1]; abel
  · simp only [hR.2, hk.2, smul_sub]
  · have h1 := hskew X hX; have h2 := opOf_isSkew (altCoeff R) X
    unfold IsSkew at *
    rw [Matrix.transpose_sub, h1, h2]; abel
  · rw [inner2_sub_left', inner2_sub_right', hsym X Y hX hY, opOf_sym (altCoeff R) hP]

end HamiltonsCubic.Results

#print axioms HamiltonsCubic.Results.comp_opOf           -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.bianchi_sub_alt     -- [propext, Classical.choice, Quot.sound]
#print axioms HamiltonsCubic.Results.weylProj_isWeylOp   -- [propext, Classical.choice, Quot.sound]
