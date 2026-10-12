import HamiltonsCubic.Results.L70Weyl

set_option linter.style.longLine false

/-!
# L70's sharp member: the bound with `m₁`, the least product on the support

[findings/bounds.md](../../../findings/bounds.md), Lemma L70, the excluded-index blockquote: the boxed
`θ ≤ λ_min + (n − 2) λ_max` is the **weakened** member of the per-row family, *"the sharp version subtracts
`m₁`, the minimum over the support"*, and its equality condition is that `ad(v)` concentrate on the pairs
achieving `m₁`. **This file types that member.** For any `m₁` at most `λ_a λ_b` on every class pair carrying
mass (`m₁` the minimum over the support being the sharpest):

- `sharp_eq`: `D₁ = ∑ (λ_a λ_b − m₁) b_ab = λ_min θ − λ_min² − (n − 2) m₁`, from rows (A) and (C);
- `sharp_nonneg`, `sharp_bound`: `D₁ ≥ 0`, so `θ ≤ λ_min + (n − 2) m₁ / λ_min` at `λ_min < 0`;
- `sharp_zero_iff`: equality iff every pair carrying mass has `λ_a λ_b = m₁`;
- `sharp_le_boxed`: at `m₁ ≥ λ_min λ_max` (the corner minimum) the sharp bound is at most the boxed one,
  with the two equal at `m₁ = λ_min λ_max`, which is the case whenever a pair `(λ_min, λ_max)` carries mass;
- `L70_sharp_bound`, `L70_sharp_equality`: the same at a critical linear Weyl operator, through
  [L70Weyl.lean](L70Weyl.lean)'s rows.
-/

namespace HamiltonsCubic.L70Identity

variable {k : ℕ}

/-- The sharp deficiency, against a lower bound `m₁` on the products over the support. -/
noncomputable def D1 (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (m1 : ℝ) : ℝ :=
  ∑ i, ∑ j, (lam i * lam j - m1) * b i j

theorem sharp_eq (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (m1 lmin θ n : ℝ)
    (hA : ∑ i, ∑ j, b i j = n - 2)
    (hC : ∑ i, ∑ j, lam i * lam j * b i j = lmin * (θ - lmin)) :
    D1 b lam m1 = lmin * θ - lmin ^ 2 - (n - 2) * m1 := by
  unfold D1
  simp only [sub_mul, Finset.sum_sub_distrib, ← Finset.mul_sum]
  rw [hC, hA]; ring

theorem sharp_nonneg (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (m1 : ℝ) (hb : ∀ i j, 0 ≤ b i j)
    (hm : ∀ i j, b i j ≠ 0 → m1 ≤ lam i * lam j) : 0 ≤ D1 b lam m1 := by
  unfold D1
  refine Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => ?_
  by_cases h : b i j = 0
  · rw [h, mul_zero]
  · exact mul_nonneg (by linarith [hm i j h]) (hb i j)

/-- **The sharp bound**: `θ ≤ λ_min + (n − 2) m₁ / λ_min` at `λ_min < 0`. -/
theorem sharp_bound (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (m1 lmin θ n : ℝ) (hneg : lmin < 0)
    (hb : ∀ i j, 0 ≤ b i j) (hm : ∀ i j, b i j ≠ 0 → m1 ≤ lam i * lam j)
    (hA : ∑ i, ∑ j, b i j = n - 2)
    (hC : ∑ i, ∑ j, lam i * lam j * b i j = lmin * (θ - lmin)) :
    θ ≤ lmin + (n - 2) * m1 / lmin := by
  have h := sharp_nonneg b lam m1 hb hm
  rw [sharp_eq b lam m1 lmin θ n hA hC] at h
  rw [show lmin + (n - 2) * m1 / lmin = (lmin ^ 2 + (n - 2) * m1) / lmin by field_simp,
    le_div_iff_of_neg hneg]
  linarith

theorem sharp_zero_iff (b : Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (m1 : ℝ) (hb : ∀ i j, 0 ≤ b i j)
    (hm : ∀ i j, b i j ≠ 0 → m1 ≤ lam i * lam j) :
    D1 b lam m1 = 0 ↔ ∀ i j, b i j ≠ 0 → lam i * lam j = m1 := by
  have hterm : ∀ i j, 0 ≤ (lam i * lam j - m1) * b i j := fun i j => by
    by_cases h : b i j = 0
    · rw [h, mul_zero]
    · exact mul_nonneg (by linarith [hm i j h]) (hb i j)
  unfold D1
  constructor
  · intro h i j hij
    have h1 := (Finset.sum_eq_zero_iff_of_nonneg (fun i _ =>
      Finset.sum_nonneg fun j _ => hterm i j)).mp h i (Finset.mem_univ i)
    have h2 := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => hterm i j)).mp h1 j (Finset.mem_univ j)
    rcases mul_eq_zero.mp h2 with h3 | h3
    · linarith
    · exact absurd h3 hij
  · intro h
    refine Finset.sum_eq_zero fun i _ => Finset.sum_eq_zero fun j _ => ?_
    by_cases hij : b i j = 0
    · rw [hij, mul_zero]
    · rw [h i j hij, sub_self, zero_mul]

/-- **The sharp bound is at least as strong as the boxed one**: at `λ_min < 0` and `m₁ ≥ λ_min λ_max`,
`λ_min + (n − 2) m₁ / λ_min ≤ λ_min + (n − 2) λ_max`, for `n ≥ 2`. -/
theorem sharp_le_boxed (m1 lmin lmax n : ℝ) (hneg : lmin < 0) (hn : 2 ≤ n) (hm : lmin * lmax ≤ m1) :
    lmin + (n - 2) * m1 / lmin ≤ lmin + (n - 2) * lmax := by
  have h : m1 / lmin ≤ lmax := by
    rw [div_le_iff_of_neg hneg]; linarith
  have h2 : (n - 2) * (m1 / lmin) ≤ (n - 2) * lmax := mul_le_mul_of_nonneg_left h (by linarith)
  rw [mul_div_assoc]; linarith

end HamiltonsCubic.L70Identity

namespace HamiltonsCubic.L70Weyl

open HamiltonsCubic.RealLayer

variable {n r K : ℕ}

/-- **L70's sharp bound at a critical Weyl operator**: for any `m₁` at most `λ_a λ_b` on every class pair
carrying mass at a unit eigenvector `x` of a negative eigenvalue `λ_min` (the least one being the record's case), `θ ≤ λ_min + (n − 2) m₁ / λ_min`. -/
theorem L70_sharp_bound (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • L244RowBMass.Pc ψ cls b X)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1)
    (lmin m1 : ℝ) (hxe : W x = lmin • x) (hneg : lmin < 0)
    (hm : ∀ a b, L244RowA.bAB ψ cls a b x ≠ 0 → m1 ≤ lam a * lam b) :
    θ ≤ lmin + ((n : ℝ) - 2) * m1 / lmin :=
  L70Identity.sharp_bound _ lam m1 lmin θ n hneg (fun a b => bAB_nonneg ψ cls a b x) hm
    (rowA_sum ψ hψS hψ cls x hx hunit) (rowC_sum W hW θ hc ψ hψS cls lam hWP x hx lmin hxe hunit)

/-- **The sharp equality case**: equality iff every class pair carrying mass has `λ_a λ_b = m₁`. -/
theorem L70_sharp_equality (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (ψ : Fin r → Matrix (Fin n) (Fin n) ℝ)
    (hψS : ∀ k, IsSkew (ψ k)) (hψ : ∀ Y, IsSkew Y → Y = ∑ k, inner2 (ψ k) Y • ψ k)
    (cls : Fin r → Fin K) (lam : Fin K → ℝ)
    (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • L244RowBMass.Pc ψ cls b X)
    (x : Matrix (Fin n) (Fin n) ℝ) (hx : IsSkew x) (hunit : inner2 x x = 1)
    (lmin m1 : ℝ) (hxe : W x = lmin • x) (hneg : lmin < 0)
    (hm : ∀ a b, L244RowA.bAB ψ cls a b x ≠ 0 → m1 ≤ lam a * lam b) :
    θ = lmin + ((n : ℝ) - 2) * m1 / lmin ↔
      ∀ a b, L244RowA.bAB ψ cls a b x ≠ 0 → lam a * lam b = m1 := by
  rw [← L70Identity.sharp_zero_iff _ lam m1 (fun a b => bAB_nonneg ψ cls a b x) hm,
    L70Identity.sharp_eq _ lam m1 lmin θ n (rowA_sum ψ hψS hψ cls x hx hunit)
      (rowC_sum W hW θ hc ψ hψS cls lam hWP x hx lmin hxe hunit)]
  have hne : lmin ≠ 0 := hneg.ne
  constructor
  · intro h; rw [h]; field_simp; ring
  · intro h
    have : θ * lmin = lmin ^ 2 + ((n : ℝ) - 2) * m1 := by linarith
    field_simp; linarith

end HamiltonsCubic.L70Weyl
