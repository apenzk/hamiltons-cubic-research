import HamiltonsCubic.Results.L54Schur
import HamiltonsCubic.Results.L50Spectra

set_option linter.style.longLine false

/-!
# The spectrum of `M`: `∑ μ² = ‖R‖²` and `∑ μ³ = tr M³`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L50 reads its two traces as power
sums of spectra, `tr M³ = p₃(μ)` with `‖M‖_F² = ∑ μ²`. [L50Spectra.lean](L50Spectra.lean) proves
the identity in trace form. **This file proves the spectral reading on the `Λ²` side**:

- `trace_pow_eq_sum_eigenvalues`: `tr Aᵏ = ∑ λⱼᵏ` for a real symmetric `A`, from Mathlib's spectral
  theorem (Mathlib carries the case `k = 1`);
- `sum_pairs`: over `Fin n`, a symmetric function vanishing on the diagonal has
  `∑_{i,j} g i j = 2 ∑_{a<b} g a b`;
- `sum_mu_sq`: `∑ μ² = normSq R` and `sum_mu_cube`: `∑ μ³ = trCube R`, for `μ` the spectrum of
  `Mpair R`, `M` in the pair basis;
- `L50_mu_spectral`: `P = (3/2) ∑ μ³ − (1/2) tr_{S²} W̊³`, L50 with the `Λ²` side spectral.
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

/-- **`tr Aᵏ = ∑ λⱼᵏ`** for a real symmetric matrix. -/
theorem trace_pow_eq_sum_eigenvalues {N : Type*} [Fintype N] [DecidableEq N]
    (A : Matrix N N ℝ) (hA : A.IsHermitian) (k : ℕ) :
    (A ^ k).trace = ∑ j, hA.eigenvalues j ^ k := by
  set U := (hA.eigenvectorUnitary : Matrix N N ℝ)
  have hU' : star U * U = 1 := Matrix.mem_unitaryGroup_iff'.mp hA.eigenvectorUnitary.2
  set D := Matrix.diagonal (RCLike.ofReal ∘ hA.eigenvalues : N → ℝ)
  have hAD : A = U * D * star U := by
    have h := hA.spectral_theorem
    rw [Unitary.conjStarAlgAut_apply] at h
    exact h
  have hpow : ∀ m : ℕ, A ^ m = U * D ^ m * star U := by
    intro m
    induction m with
    | zero =>
      simp only [pow_zero, Matrix.mul_one]
      exact (Matrix.mem_unitaryGroup_iff.mp hA.eigenvectorUnitary.2).symm
    | succ m ih =>
      rw [pow_succ, ih, hAD, pow_succ]
      calc U * D ^ m * star U * (U * D * star U)
          = U * D ^ m * (star U * U) * D * star U := by simp only [Matrix.mul_assoc]
        _ = U * (D ^ m * D) * star U := by rw [hU']; simp only [Matrix.mul_one, Matrix.mul_assoc]
  rw [hpow, Matrix.trace_mul_cycle, hU', Matrix.one_mul, Matrix.diagonal_pow, Matrix.trace_diagonal]
  simp

variable {n : ℕ}

/-- **An ordered-pair sum is twice the `a < b` sum** for a symmetric function vanishing on the
diagonal. -/
theorem sum_pairs (g : Fin n → Fin n → ℝ) (hdiag : ∀ i, g i i = 0) (hsym : ∀ i j, g i j = g j i) :
    ∑ i, ∑ j, g i j = 2 * ∑ p : Pairs n, g p.1.1 p.1.2 := by
  rw [← Finset.sum_product', Finset.univ_product_univ]
  have hsplit : (Finset.univ : Finset (Fin n × Fin n))
      = (Finset.univ.filter fun p : Fin n × Fin n => p.1 < p.2)
        ∪ ((Finset.univ.filter fun p : Fin n × Fin n => p.2 < p.1)
          ∪ (Finset.univ.filter fun p : Fin n × Fin n => p.1 = p.2)) := by
    ext p; simp only [Finset.mem_univ, Finset.mem_union, Finset.mem_filter, true_and, true_iff]
    rcases lt_trichotomy p.1 p.2 with h | h | h <;> tauto
  have hd1 : Disjoint (Finset.univ.filter fun p : Fin n × Fin n => p.1 < p.2)
      ((Finset.univ.filter fun p : Fin n × Fin n => p.2 < p.1)
        ∪ (Finset.univ.filter fun p : Fin n × Fin n => p.1 = p.2)) := by
    rw [Finset.disjoint_left]; intro p hp hq
    simp only [Finset.mem_filter, Finset.mem_union, Finset.mem_univ, true_and] at hp hq
    rcases hq with h | h
    · exact lt_asymm hp h
    · exact (ne_of_lt hp) h
  have hd2 : Disjoint (Finset.univ.filter fun p : Fin n × Fin n => p.2 < p.1)
      (Finset.univ.filter fun p : Fin n × Fin n => p.1 = p.2) := by
    rw [Finset.disjoint_left]; intro p hp hq
    simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hp hq
    exact (ne_of_lt hp) hq.symm
  rw [hsplit, Finset.sum_union hd1, Finset.sum_union hd2]
  have hzero : ∑ p ∈ (Finset.univ.filter fun p : Fin n × Fin n => p.1 = p.2), g p.1 p.2 = 0 :=
    Finset.sum_eq_zero fun p hp => by
      simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hp
      rw [hp, hdiag]
  have hswap : ∑ p ∈ (Finset.univ.filter fun p : Fin n × Fin n => p.2 < p.1), g p.1 p.2
      = ∑ p ∈ (Finset.univ.filter fun p : Fin n × Fin n => p.1 < p.2), g p.1 p.2 := by
    refine Finset.sum_nbij' Prod.swap Prod.swap ?_ ?_ ?_ ?_ ?_ <;> simp [hsym]
  have hsub : ∑ p ∈ (Finset.univ.filter fun p : Fin n × Fin n => p.1 < p.2), g p.1 p.2
      = ∑ p : Pairs n, g p.1.1 p.1.2 := by
    rw [Finset.sum_subtype (p := fun p : Fin n × Fin n => p.1 < p.2)]
    intro p; simp
  rw [hzero, hswap, hsub]; ring

/-- `sum_pairs` over the product type: `∑_x g x = 2 ∑_{a<b} g (a,b)` when `g` vanishes on the
diagonal and is invariant under `swap`. -/
theorem sum_pairs' (g : Fin n × Fin n → ℝ) (hdiag : ∀ i, g (i, i) = 0)
    (hsym : ∀ x, g x.swap = g x) : ∑ x, g x = 2 * ∑ p : Pairs n, g p.1 := by
  rw [Fintype.sum_prod_type]
  exact sum_pairs (fun i j => g (i, j)) hdiag (fun i j => (hsym (j, i)).symm ▸ rfl)

section spec

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
include hR

/-- `W` on ordered pairs. -/
noncomputable def A2 (x y : Fin n × Fin n) : ℝ := R4 R x.1 x.2 y.1 y.2

theorem A2_swap_right (x y : Fin n × Fin n) : A2 R x y.swap = -A2 R x y := by
  unfold A2; exact R4_anti2 R hR x.1 x.2 y.1 y.2

theorem A2_diag_right (x : Fin n × Fin n) (i : Fin n) : A2 R x (i, i) = 0 := by
  unfold A2
  have h := R4_anti2 R hR x.1 x.2 i i
  linarith

include hskew hsym

theorem A2_swap_left (x y : Fin n × Fin n) : A2 R x.swap y = -A2 R x y := by
  unfold A2; exact R4_anti1 R hR hskew hsym x.1 x.2 y.1 y.2

omit hskew hsym in
theorem A2_diag_left (y : Fin n × Fin n) (i : Fin n) : A2 R (i, i) y = 0 := by
  unfold A2; exact R4_self_left R hR i y.1 y.2

theorem A2_symm (x y : Fin n × Fin n) : A2 R x y = A2 R y x := by
  unfold A2; exact R4_pair R hR hskew hsym x.1 x.2 y.1 y.2

/-- **`∑ μ² = ‖R‖²`** for `μ` the spectrum of `M` in the pair basis. -/
theorem sum_mu_sq :
    ∑ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ^ 2 = normSq R := by
  rw [← trace_pow_eq_sum_eigenvalues, normSq, L50Spectra.innerOp_R4 R R hskew]
  have hall : ∑ i, ∑ j, ∑ k, ∑ l, R4 R i j k l * R4 R i j k l
      = ∑ x : Fin n × Fin n, ∑ y : Fin n × Fin n, A2 R x y ^ 2 := by
    rw [Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    rw [Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    unfold A2; ring
  have hin : ∀ x, ∑ y, A2 R x y ^ 2 = 2 * ∑ q : Pairs n, A2 R x q.1 ^ 2 := fun x =>
    sum_pairs' (fun y => A2 R x y ^ 2) (fun i => by rw [A2_diag_right R hR]; ring)
      (fun y => by rw [A2_swap_right R hR]; ring)
  have hout : ∑ x, ∑ q : Pairs n, A2 R x q.1 ^ 2
      = 2 * ∑ p : Pairs n, ∑ q : Pairs n, A2 R p.1 q.1 ^ 2 :=
    sum_pairs' (fun x => ∑ q : Pairs n, A2 R x q.1 ^ 2)
      (fun i => Finset.sum_eq_zero fun q _ => by rw [A2_diag_left R hR]; ring)
      (fun x => Finset.sum_congr rfl fun q _ => by rw [A2_swap_left R hR hskew hsym]; ring)
  rw [hall, Finset.sum_congr rfl fun x _ => hin x, ← Finset.mul_sum, hout, pow_two,
    Matrix.trace]
  simp only [Matrix.diag, Matrix.mul_apply]
  have e : ∀ p q : Pairs n, Mpair R p q * Mpair R q p = A2 R p.1 q.1 ^ 2 := fun p q => by
    unfold Mpair A2; rw [R4_pair R hR hskew hsym q.1.1 q.1.2 p.1.1 p.1.2]; ring
  simp only [e]
  ring

/-- **`∑ μ³ = tr M³`** for `μ` the spectrum of `M` in the pair basis. -/
theorem sum_mu_cube :
    ∑ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ^ 3 = trCube R := by
  rw [← trace_pow_eq_sum_eigenvalues, L50Spectra.trCube_eq_alpha R hskew hsym, alphaW]
  set F : (Fin n × Fin n) → (Fin n × Fin n) → (Fin n × Fin n) → ℝ :=
    fun x y z => A2 R x y * A2 R x z * A2 R y z with hF
  have hall : ∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ o, R4 R i j k l * R4 R i j m o * R4 R k l m o
      = ∑ x, ∑ y, ∑ z, F x y z := by
    rw [Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
    rw [Fintype.sum_prod_type]
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    rw [Fintype.sum_prod_type]
    rfl
  -- the three pair variables, innermost first
  have h1 : ∀ x y, ∑ z, F x y z = 2 * ∑ r : Pairs n, F x y r.1 := fun x y =>
    sum_pairs' (F x y) (fun i => by simp only [hF, A2_diag_right R hR]; ring)
      (fun z => by simp only [hF, A2_swap_right R hR]; ring)
  have h2 : ∀ x (r : Pairs n), ∑ y, F x y r.1 = 2 * ∑ q : Pairs n, F x q.1 r.1 := fun x r =>
    sum_pairs' (fun y => F x y r.1) (fun i => by simp only [hF, A2_diag_right R hR]; ring)
      (fun y => by simp only [hF, A2_swap_right R hR, A2_swap_left R hR hskew hsym]; ring)
  have h3 : ∀ (q r : Pairs n), ∑ x, F x q.1 r.1 = 2 * ∑ p : Pairs n, F p.1 q.1 r.1 := fun q r =>
    sum_pairs' (fun x => F x q.1 r.1)
      (fun i => by simp only [hF, A2_diag_left R hR]; ring)
      (fun x => by simp only [hF, A2_swap_left R hR hskew hsym]; ring)
  have hstep : ∑ x, ∑ y, ∑ z, F x y z
      = 8 * ∑ p : Pairs n, ∑ q : Pairs n, ∑ r : Pairs n, F p.1 q.1 r.1 := by
    calc ∑ x, ∑ y, ∑ z, F x y z
        = ∑ x, ∑ y, 2 * ∑ r : Pairs n, F x y r.1 :=
          Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun y _ => h1 x y
      _ = 2 * ∑ x, ∑ r : Pairs n, ∑ y, F x y r.1 := by
          rw [Finset.mul_sum]
          refine Finset.sum_congr rfl fun x _ => ?_
          simp only [Finset.mul_sum]
          exact Finset.sum_comm
      _ = 2 * ∑ x, ∑ r : Pairs n, 2 * ∑ q : Pairs n, F x q.1 r.1 := by
          congr 1
          exact Finset.sum_congr rfl fun x _ => Finset.sum_congr rfl fun r _ => h2 x r
      _ = 4 * ∑ q : Pairs n, ∑ r : Pairs n, ∑ x, F x q.1 r.1 := by
          simp only [← Finset.mul_sum]
          rw [Finset.sum_comm]
          rw [Finset.sum_congr rfl fun r _ => Finset.sum_comm]
          rw [Finset.sum_comm]
          ring
      _ = 4 * ∑ q : Pairs n, ∑ r : Pairs n, 2 * ∑ p : Pairs n, F p.1 q.1 r.1 := by
          congr 1
          exact Finset.sum_congr rfl fun q _ => Finset.sum_congr rfl fun r _ => h3 q r
      _ = 8 * ∑ p : Pairs n, ∑ q : Pairs n, ∑ r : Pairs n, F p.1 q.1 r.1 := by
          simp only [← Finset.mul_sum]
          rw [Finset.sum_comm]
          rw [Finset.sum_congr rfl fun r _ => Finset.sum_comm]
          rw [Finset.sum_comm]
          rw [Finset.sum_congr rfl fun p _ => Finset.sum_comm]
          ring
  rw [hall, hstep, pow_three, Matrix.trace]
  simp only [Matrix.diag, Matrix.mul_apply]
  have e : ∀ p q r : Pairs n, Mpair R p q * Mpair R q r * Mpair R r p = F p.1 q.1 r.1 := by
    intro p q r
    simp only [hF]
    unfold Mpair A2
    rw [R4_pair R hR hskew hsym r.1.1 r.1.2 p.1.1 p.1.2]
    ring
  have lhs : ∑ p : Pairs n, ∑ q : Pairs n, Mpair R p q * ∑ r : Pairs n, Mpair R q r * Mpair R r p
      = ∑ p : Pairs n, ∑ q : Pairs n, ∑ r : Pairs n, F p.1 q.1 r.1 := by
    refine Finset.sum_congr rfl fun p _ => Finset.sum_congr rfl fun q _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun r _ => by rw [← mul_assoc, e]
  rw [lhs]; ring

/-- **L50 with `μ` read as a spectrum**: `P = (3/2) ∑ μ³ − (1/2) tr_{S²} W̊³`, `μ` the spectrum of
`M` in the pair basis. -/
theorem L50_mu_spectral (hB : ∀ i j k l, bianchi R i j k l = 0) :
    Pcubic R = (3 / 2) * ∑ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j ^ 3
      - (1 / 2) * trS2 (fun h => ringW R (ringW R (ringW R h))) := by
  rw [sum_mu_cube R hR hskew hsym]
  exact L50Spectra.L50_bispectral R hR hskew hsym hB

end spec

end HamiltonsCubic.SecondKind
