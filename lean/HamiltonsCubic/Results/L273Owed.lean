import Mathlib
import HamiltonsCubic.Results.I117Statements

set_option linter.style.longLine false

/-!
# L273: (1)'s equality case and `g ≥ 1/√m`, (2)'s equality at `g = 1/√m` and its failure below `m = 5`

[findings/second-order.md](../../../findings/second-order.md), Lemma L273: *"(1) $F(X)\le3\lVert A\rVert g+T$,
with equality when $A$ is a non-negative multiple of $A_\mu$, and $g\ge1/\sqrt m$. (2) For $m\ge5$,
$\lambda_m(1-g^2)\le\Psi_\kappa(g)$ for every $g\ge1/\sqrt m$, with equality at $g=1/\sqrt m$; at $m=4$ it fails
for $g$ just above $1/\sqrt m$."* Here $\Psi_\kappa(g)=\min_{a\ge0}(\kappa(1+a^2)^{3/2}-3ag)$,
$\kappa=\tfrac{2(m-1)}{\sqrt{m(2m-1)}}$, $\lambda_m=\tfrac{\sqrt{2m}(m-2)}{(m-1)^{3/2}}$, $g=\lVert A_\mu\rVert$ and
$b^2=\tfrac12(\lVert P\rVert^2+\lVert Q\rVert^2)=1$. [I117Statements.lean](I117Statements.lean) proves the bound
in (1) (`L273_F_bound`) and the inequality in (2) (`psi_bound`); the L273 row owes the rest. This file:

* `L273_F_eq`: at `A = s A_μ`, `s ≥ 0`, the bound in (1) is an equality;
* `L273_g_ge`: on the unit root sphere `b = 1`, `1/√m ≤ g`, from `tr A_μ = ∑ d_i = b²` and Cauchy–Schwarz;
* `psi_eq`: for every real `m > 2`, at `g₀ = 1/√m` and `a₀ = √(1/(2(m - 1)))`,
  `3a₀g₀ + λ_m(1 - g₀²) = κ(1 + a₀²)^{3/2}`;
* `psi_min`: for `m ≥ 5`, `λ_m(1 - 1/m)` is the least value of `κ(1 + a²)^{3/2} - 3ag₀` over `a ≥ 0`, so
  `Ψ_κ(1/√m) = λ_m(1 - 1/m)`, the equality in (2);
* `psi_fails`: for every real `2 < m < 5`, and so at `m = 3, 4`, for every `g` strictly between `1/√m` and
  `3a₀/λ_m - 1/√m` (a non-empty interval), `κ(1 + a₀²)^{3/2} - 3a₀g < λ_m(1 - g²)`, so
  `Ψ_κ(g) < λ_m(1 - g²)`: the value at `a₀` is `(g - g₀)(λ_m(g + g₀) - 3a₀)` below the bound, and
  `2λ_m g₀ < 3a₀` is `4(m - 2) < 3(m - 1)`.
-/

namespace HamiltonsCubic.L273Owed

open HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.I117S Matrix Finset

/-- `κ = 2(m - 1)/√(m(2m - 1))`. -/
noncomputable def kap (m : ℝ) : ℝ := 2 * (m - 1) / Real.sqrt (m * (2 * m - 1))

/-- `λ_m = √(2m)(m - 2)/(m - 1)^{3/2}`. -/
noncomputable def lam (m : ℝ) : ℝ := Real.sqrt (2 * m) * (m - 2) / ((m - 1) * Real.sqrt (m - 1))

/-- The minimising `a` at `g = 1/√m`. -/
noncomputable def a0 (m : ℝ) : ℝ := Real.sqrt (1 / (2 * (m - 1)))

variable {m : ℕ}

/-- **L273 (1), the equality case**: at `A = s A_μ`, `s ≥ 0`, `F(C) = 3 ‖A‖ ‖A_μ‖ + ½(tr P³ + tr Q³)`. -/
theorem L273_F_eq (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (s : ℝ)
    (hs : 0 ≤ s) :
    Ftri (torusOp (s • Amu U V) U V) (torusOp (s • Amu U V) U V) (torusOp (s • Amu U V) U V)
      = 3 * Real.sqrt (∑ i, ∑ j, (s • Amu U V) i j ^ 2) * Real.sqrt (∑ i, ∑ j, Amu U V i j ^ 2)
        + (1 / 2) * (Matrix.trace ((U + V) * (U + V) * (U + V)) + Matrix.trace ((U - V) * (U - V) * (U - V))) := by
  set A := s • Amu U V with hAdef
  have hA : Aᵀ = A := by
    ext k l; simp only [hAdef, Matrix.transpose_apply, Matrix.smul_apply, Amu_symm U V hU.1 hV.1]
  rw [Ftri_torus A U V hA hU hV]
  have hpair : 3 * ∑ i, A i i * dvec U V i - 3 * (∑ i, ∑ j, if i = j then 0 else A i j * (U + V) i j * (U - V) i j)
      = 3 * ∑ i, ∑ j, A i j * Amu U V i j := by
    have hpt : ∀ i j, A i j * Amu U V i j = (if i = j then A i i * dvec U V i else 0)
        - (if i = j then 0 else A i j * (U + V) i j * (U - V) i j) := fun i j => by
      by_cases h : i = j
      · subst h; simp [Amu, dvec]
      · simp only [Amu, if_neg h, Matrix.add_apply, Matrix.sub_apply, zero_sub]; ring
    simp only [hpt, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.mem_univ, if_true]
    ring
  set G2 := ∑ i, ∑ j, Amu U V i j ^ 2 with hG2
  have hG20 : 0 ≤ G2 := by rw [hG2]; positivity
  have hAA : ∑ i, ∑ j, A i j * Amu U V i j = s * G2 := by
    rw [hG2, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    simp only [hAdef, Matrix.smul_apply, smul_eq_mul]; ring
  have hA2 : ∑ i, ∑ j, A i j ^ 2 = s ^ 2 * G2 := by
    rw [hG2, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    simp only [hAdef, Matrix.smul_apply, smul_eq_mul]; ring
  have hsq : Real.sqrt (s ^ 2 * G2) * Real.sqrt G2 = s * G2 := by
    rw [Real.sqrt_mul (sq_nonneg s), Real.sqrt_sq hs, mul_assoc, Real.mul_self_sqrt hG20]
  rw [hA2, mul_assoc 3, hsq, ← hAA, ← hpair]
  ring

/-- **L273 (1), `g ≥ 1/√m`**: on the unit root sphere, `1/√m ≤ ‖A_μ‖`. -/
theorem L273_g_ge (U V : Matrix (Fin m) (Fin m) ℝ)
    (hb : (1 / 2 : ℝ) * ((∑ i, ∑ j, (U + V) i j ^ 2) + (∑ i, ∑ j, (U - V) i j ^ 2)) = 1) :
    1 / Real.sqrt m ≤ Real.sqrt (∑ i, ∑ j, Amu U V i j ^ 2) := by
  have hd : ∑ i, dvec U V i = 1 := by rw [sum_dvec]; exact hb
  have hcs := sq_sum_le_card_mul_sum_sq (s := (Finset.univ : Finset (Fin m))) (f := dvec U V)
  rw [hd, Finset.card_univ, Fintype.card_fin, one_pow] at hcs
  have hD0 : 0 ≤ ∑ i, dvec U V i ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
  have hm0 : (0 : ℝ) < m := by
    rcases (Nat.cast_nonneg m : (0 : ℝ) ≤ m).lt_or_eq with h | h
    · exact h
    · rw [← h, zero_mul] at hcs; linarith
  have hrest : 0 ≤ ∑ i, ∑ j, (if i = j then (0 : ℝ) else ((U + V) i j * (U - V) i j) ^ 2) :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => by split_ifs <;> positivity
  have hG : 1 / (m : ℝ) ≤ ∑ i, ∑ j, Amu U V i j ^ 2 := by
    rw [Amu_sq, div_le_iff₀ hm0]
    nlinarith
  rw [show 1 / Real.sqrt m = Real.sqrt (1 / m) by rw [Real.sqrt_div' _ (Nat.cast_nonneg m), Real.sqrt_one]]
  exact Real.sqrt_le_sqrt hG

/-- **L273 (2) at `g = 1/√m`, the value**: `3a₀g₀ + λ_m(1 - g₀²) = κ(1 + a₀²)^{3/2}` for every real `m > 2`. -/
theorem psi_eq (m : ℝ) (hm : 2 < m) :
    3 * a0 m * (1 / Real.sqrt m) + lam m * (1 - (1 / Real.sqrt m) ^ 2)
      = kap m * Real.sqrt (1 + a0 m ^ 2) ^ 3 := by
  obtain ⟨c1, c2, -, c4⟩ := HamiltonsCubic.I117.jh_constants m hm
  have hm1 : 0 < m - 1 := by linarith
  set t0 := Real.sqrt ((2 * m - 1) / (2 * (m - 1))) with ht0
  have ha2 : a0 m ^ 2 = 1 / (2 * (m - 1)) := Real.sq_sqrt (by positivity)
  have ht2 : t0 ^ 2 = (2 * m - 1) / (2 * (m - 1)) := Real.sq_sqrt (div_nonneg (by linarith) (by linarith))
  have hat : a0 m ^ 2 = t0 ^ 2 - 1 := by rw [ha2, ht2]; field_simp; ring
  have hst : Real.sqrt (1 + a0 m ^ 2) = t0 := by
    rw [ht0, ha2]; congr 1; field_simp; ring
  have hg2 : (1 / Real.sqrt m) ^ 2 = 1 / m := by rw [div_pow, Real.sq_sqrt (by linarith)]; ring
  have ht0p : 0 ≤ t0 := Real.sqrt_nonneg _
  have ht1 : 0 ≤ t0 ^ 2 - 1 := by rw [← hat]; exact sq_nonneg _
  have hk0 : 0 ≤ kap m := div_nonneg (by linarith) (Real.sqrt_nonneg _)
  have ha0 : 0 ≤ a0 m := Real.sqrt_nonneg _
  have hg0 : 0 ≤ 1 / Real.sqrt m := by positivity
  -- `κ t₀ (t₀² - 1) = a₀ g₀`, both non-negative with equal squares
  have hx : kap m * t0 * (t0 ^ 2 - 1) = a0 m * (1 / Real.sqrt m) := by
    set x := kap m * t0 * (t0 ^ 2 - 1)
    set y := a0 m * (1 / Real.sqrt m)
    have hx0 : 0 ≤ x := mul_nonneg (mul_nonneg hk0 ht0p) ht1
    have hy0 : 0 ≤ y := by positivity
    have hxy : x ^ 2 = y ^ 2 := by
      have e1 : x ^ 2 = (kap m ^ 2 * t0 ^ 2 * (t0 ^ 2 - 1)) * (t0 ^ 2 - 1) := by ring
      have e2 : y ^ 2 = a0 m ^ 2 * (1 / Real.sqrt m) ^ 2 := by ring
      rw [e1, e2, hg2, hat]
      unfold kap
      rw [c1]; ring
    nlinarith [sq_nonneg (x - y), sq_nonneg (x + y)]
  rw [hst, hg2]
  unfold lam
  rw [← c2]
  unfold kap at hx ⊢
  linear_combination (-3) * hx

/-- **L273 (2), the equality at `g = 1/√m`**: for `m ≥ 5`, `λ_m(1 - 1/m)` is the least value of
`κ(1 + a²)^{3/2} - 3a/√m` over `a ≥ 0`, attained at `a₀`, that is `Ψ_κ(1/√m) = λ_m(1 - g₀²)`. -/
theorem psi_min (m : ℝ) (hm : 5 ≤ m) :
    IsLeast ((fun a => kap m * Real.sqrt (1 + a ^ 2) ^ 3 - 3 * a * (1 / Real.sqrt m)) '' Set.Ici 0)
      (lam m * (1 - (1 / Real.sqrt m) ^ 2)) := by
  constructor
  · refine ⟨a0 m, Real.sqrt_nonneg _, ?_⟩
    show kap m * Real.sqrt (1 + a0 m ^ 2) ^ 3 - 3 * a0 m * (1 / Real.sqrt m) = _
    rw [← psi_eq m (by linarith)]; ring
  · rintro _ ⟨a, ha, rfl⟩
    have := HamiltonsCubic.I117S.psi_bound m hm a (1 / Real.sqrt m) ha le_rfl
    unfold kap lam
    linarith

/-- **L273 (2) fails below `m = 5`**: for every real `2 < m < 5`, and every `g` strictly between `1/√m` and
`3a₀/λ_m - 1/√m` (an interval that is non-empty), `κ(1 + a₀²)^{3/2} - 3a₀g < λ_m(1 - g²)`, so
`Ψ_κ(g) < λ_m(1 - g²)` for `g` just above `1/√m`. -/
theorem psi_fails (m : ℝ) (hm2 : 2 < m) (hm5 : m < 5) :
    1 / Real.sqrt m < 3 * a0 m / lam m - 1 / Real.sqrt m ∧
    ∀ g, 1 / Real.sqrt m < g → g < 3 * a0 m / lam m - 1 / Real.sqrt m →
      kap m * Real.sqrt (1 + a0 m ^ 2) ^ 3 - 3 * a0 m * g < lam m * (1 - g ^ 2) := by
  have hm1 : 0 < m - 1 := by linarith
  have hsm : 0 < Real.sqrt m := Real.sqrt_pos.mpr (by linarith)
  have hs1 : 0 < Real.sqrt (m - 1) := Real.sqrt_pos.mpr hm1
  have hs2 : 0 < Real.sqrt (2 * m) := Real.sqrt_pos.mpr (by linarith)
  have hl0 : 0 < lam m := div_pos (mul_pos hs2 (by linarith)) (mul_pos hm1 hs1)
  have ha0 : 0 < a0 m := Real.sqrt_pos.mpr (by positivity)
  set g0 := 1 / Real.sqrt m with hg0def
  have hg0 : 0 < g0 := by positivity
  -- `2 λ_m g₀ < 3 a₀`, squared: `8(m - 2)²/(m - 1)³ < 9/(2(m - 1))`
  have hkey : 2 * lam m * g0 < 3 * a0 m := by
    have hsq : (2 * lam m * g0) ^ 2 < (3 * a0 m) ^ 2 := by
      have e1 : (2 * lam m * g0) ^ 2 = 8 * (m - 2) ^ 2 / (m - 1) ^ 3 := by
        have hl2 : lam m ^ 2 = 2 * m * (m - 2) ^ 2 / ((m - 1) ^ 2 * (m - 1)) := by
          unfold lam
          rw [div_pow, mul_pow, mul_pow, Real.sq_sqrt (by linarith), Real.sq_sqrt hm1.le]
        have hg2 : g0 ^ 2 = 1 / m := by rw [hg0def, div_pow, Real.sq_sqrt (by linarith)]; ring
        rw [show (2 * lam m * g0) ^ 2 = 4 * lam m ^ 2 * g0 ^ 2 by ring, hl2, hg2]
        field_simp
        ring
      have e2 : (3 * a0 m) ^ 2 = 9 / (2 * (m - 1)) := by
        rw [mul_pow, a0, Real.sq_sqrt (by positivity)]; ring
      rw [e1, e2, div_lt_div_iff₀ (by positivity) (by positivity)]
      have h16 : 16 * (m - 2) ^ 2 < 9 * (m - 1) ^ 2 := by nlinarith
      nlinarith [pow_pos hm1 2]
    by_contra hcon
    have := pow_le_pow_left₀ (by positivity) (not_lt.mp hcon) 2
    linarith
  have hval := psi_eq m hm2
  rw [← hg0def] at hval
  refine ⟨?_, fun g hg1 hg2 => ?_⟩
  · rw [lt_sub_iff_add_lt, lt_div_iff₀ hl0]; linarith
  · have hg2' : lam m * (g + g0) < 3 * a0 m := by
      have := (lt_div_iff₀ hl0).mp (by linarith : g + g0 < 3 * a0 m / lam m)
      linarith
    have hdiff : kap m * Real.sqrt (1 + a0 m ^ 2) ^ 3 - 3 * a0 m * g - lam m * (1 - g ^ 2)
        = (g - g0) * (lam m * (g + g0) - 3 * a0 m) := by
      rw [← hval]; ring
    have : (g - g0) * (lam m * (g + g0) - 3 * a0 m) < 0 :=
      mul_neg_of_pos_of_neg (by linarith) (by linarith)
    linarith

end HamiltonsCubic.L273Owed
