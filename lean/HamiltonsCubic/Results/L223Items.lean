import HamiltonsCubic.Results.L57Equality

set_option linter.style.longLine false

/-!
# L223, steps 1 and 2: the stability of L57's chain at a near-critical diagonal tensor

[findings/problem.md](../../../findings/problem.md), Lemma L223: *let `n ≥ 4`, `S ∈ 𝒟ₙ` with
`∑_{i<j} s_ij² = 1`, and `S∘S = λS + E` with `E ∈ 𝒟ₙ`. Put `Θ̄ = √(2(n−1)(n−2))/n`, `Z*² = (n−2)/(2(n−1))`,
let `μ` be the top eigenvalue of `S` with unit eigenvector `v`, `e₋ = max(0, −vᵀEv)` and
`Δ = Θ̄ − λ + e₋/μ`. Then (1) `Δ ≥ 0`; (2) with `α` the angle between `S` and `Z(v)` and
`η₁ = ∑_{i<j} s_ij²(v_i − v_j)² − μ²/n`: `1 − cos α ≤ Δ/Θ̄`, `η₁ ≤ μΔ`, and `|Z(v)| ≥ Z*(1 − Δ/Θ̄)`.*

The product `S∘S` on `𝒟ₙ` is `s_ab² + (S²)_ab` off the diagonal, its rows already summing to zero, so the
near-critical equation is `hnear`. Norms are over unordered pairs, so `∑_{a,b} s_ab² = 2`,
`⟨S, Z⟩ = ½ ∑_{a,b} s_ab Z_ab = μ/2` and `|Z|² = ½ ∑_{a,b} Z_ab²`.

- `pairing_near`: **`λμ + vᵀEv = μ² − ½ ∑ s_ab²(v_a − v_b)²`**, L57's pairing with the defect kept;
- `chain_core`: the record's chain on the three scalar facts, `Θ̄(1 − μ/(2Z*)) + η₁/μ ≤ Δ`;
- `L223_items12`: **items 1 and 2** as stated, with `cos α = (μ/2)/|Z(v)|`, at any unit eigenvector of a
  positive eigenvalue `μ` (the record takes the top one, which [L57Critical.lean](L57Critical.lean)'s
  `exists_pos_eigen` supplies);
- `L223_item1_upper`: **item 1's upper bound**, `μ ≥ (λ − |E|)/2` and `Δ ≤ Θ̄ − λ + 2√2|E|/(λ − |E|)` at `|E| < λ`,
  the top property entering as the Rayleigh bound `xᵀSx ≤ μ‖x‖²`, through `prod_pair_le` (`⟨S∘S, S⟩ ≤ 2μ`)
  and `quad_le_fro` (`|vᵀEv| ≤ √(∑ E²)`);
- `L223_item3`: **item 3**, `∑(v_i² − 1/n)² ≤ (2(n−2)²/(n(n−1))) Δ/Θ̄`, the sign vector `w` has
  `‖v − w‖² ≤ (2(n−2)²/(n−1)) Δ/Θ̄`, and its classes have `|p − q| ≤ n‖v − w‖`, through `sq_gap_le` and
  `abs_sub_le`;
- `rayleigh_le_top`, `exists_top_eigen`, `L223_item1`: **item 1 at one eigenpair**, the top eigenpair from Mathlib's
  spectral theorem carrying its Rayleigh bound, so `0 ≤ Δ` and item 1's upper bound hold together.

Item 4 is [L223Item4.lean](L223Item4.lean)'s `L223_item4`.
-/

namespace HamiltonsCubic.L57Critical

open Finset Matrix HamiltonsCubic.FamilyLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

section core

variable (S : Matrix ι ι ℝ) (hS : IsWeight S) (v : ι → ℝ) (μ : ℝ)
  (hv : S *ᵥ v = μ • v)
include hS hv

/-- **The pairing with the defect**: `λμ + vᵀEv = μ² − ½ ∑ s_ab² (v_a − v_b)²`. -/
theorem pairing_near (E : Matrix ι ι ℝ) (hE0 : ∀ a, E a a = 0) (lam : ℝ) (h2 : ∑ a, v a ^ 2 = 1)
    (hnear : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b + E a b) :
    lam * μ + ∑ a, ∑ b, E a b * v a * v b = μ ^ 2 - (1 / 2) * ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2 := by
  have hq := quad_eq S hS v μ hv h2
  have hSS : ∑ a, ∑ b, (S * S) a b * v a * v b = μ ^ 2 := by
    have e : ∀ a, ∑ b, (S * S) a b * v a * v b = v a * ((S * S) *ᵥ v) a := fun a => by
      simp only [Matrix.mulVec, dotProduct, Finset.mul_sum]
      exact Finset.sum_congr rfl fun b _ => by ring
    simp only [e, ← Matrix.mulVec_mulVec, hv, Matrix.mulVec_smul, Pi.smul_apply, smul_eq_mul]
    have e2 : ∀ a, v a * (μ * (μ * v a)) = μ ^ 2 * v a ^ 2 := fun a => by ring
    simp only [e2, ← Finset.mul_sum, h2, mul_one]
  have hsum : ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b - lam * S a b - E a b) * v a * v b
      = ∑ a, (S * S) a a * v a ^ 2 := by
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.sum_eq_single a]
    · rw [hS.hollow a, hE0 a]; ring
    · intro b _ hb
      rw [hnear a b (Ne.symm hb)]; ring
    · intro h; exact absurd (Finset.mem_univ a) h
  have hdiag : ∀ a, (S * S) a a = ∑ c, S a c ^ 2 := fun a => by
    simp only [Matrix.mul_apply, sq, hS.symm _ a]
  have hsplit : ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b - lam * S a b - E a b) * v a * v b
      = ∑ a, ∑ b, S a b ^ 2 * v a * v b + μ ^ 2 - lam * μ - ∑ a, ∑ b, E a b * v a * v b := by
    rw [← hSS, ← hq]
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib, ← Finset.sum_sub_distrib]
    refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  have hT : (1 / 2) * ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2
      = ∑ a, (∑ c, S a c ^ 2) * v a ^ 2 - ∑ a, ∑ b, S a b ^ 2 * v a * v b := by
    have e : ∀ a b, S a b ^ 2 * (v a - v b) ^ 2
        = S a b ^ 2 * v a ^ 2 + S b a ^ 2 * v b ^ 2 - 2 * (S a b ^ 2 * v a * v b) := by
      intro a b; rw [hS.symm b a]; ring
    simp only [e, Finset.sum_add_distrib, Finset.sum_sub_distrib, ← Finset.mul_sum]
    rw [Finset.sum_comm (f := fun a b => S b a ^ 2 * v b ^ 2)]
    simp only [← Finset.sum_mul]
    ring
  have key := hsum
  rw [hsplit] at key
  have : ∑ a, (S * S) a a * v a ^ 2 = ∑ a, (∑ c, S a c ^ 2) * v a ^ 2 := by simp only [hdiag]
  rw [this] at key
  linarith

end core

/-- **The record's chain on three scalar facts**: the pairing with defect, step 1 and steps 2–3. -/
theorem chain_core (n μ T q lam e Θ Zs : ℝ) (hn : 4 ≤ n) (hμ : 0 < μ)
    (hpair : lam * μ + q = μ ^ 2 - T) (hstep1 : μ ^ 2 ≤ n * T)
    (hstep23 : μ ^ 2 ≤ 2 * (n - 2) / (n - 1)) (he : -q ≤ e) (hZs0 : 0 < Zs)
    (hZs : Zs ^ 2 = (n - 2) / (2 * (n - 1))) (hΘ : Θ = (n - 1) / n * (2 * Zs)) :
    0 ≤ T - μ ^ 2 / n ∧ μ ≤ 2 * Zs ∧
      Θ * (1 - μ / (2 * Zs)) + (T - μ ^ 2 / n) / μ ≤ Θ - lam + e / μ := by
  have hn0 : 0 < n := by linarith
  have hn1 : 0 < n - 1 := by linarith
  have h1 : 0 ≤ T - μ ^ 2 / n := by
    rw [sub_nonneg, div_le_iff₀ hn0]; linarith
  have h4 : μ ^ 2 ≤ (2 * Zs) ^ 2 := by
    rw [mul_pow, hZs]
    have : 2 * (n - 2) / (n - 1) = 2 ^ 2 * ((n - 2) / (2 * (n - 1))) := by field_simp
    linarith
  have hμZ : μ ≤ 2 * Zs := by nlinarith
  refine ⟨h1, hμZ, ?_⟩
  -- `λμ ≤ μ²(n−1)/n − η₁ + e`, and `μ(n−1)/n = Θ μ/(2Z*)`
  have hle : lam * μ ≤ μ ^ 2 * ((n - 1) / n) - (T - μ ^ 2 / n) + e := by
    have : μ ^ 2 * ((n - 1) / n) - (T - μ ^ 2 / n) = μ ^ 2 - T := by field_simp; ring
    linarith
  have hkey : Θ * (μ / (2 * Zs)) = μ * ((n - 1) / n) := by
    rw [hΘ]; field_simp
  have hdiv : lam ≤ Θ * (μ / (2 * Zs)) - (T - μ ^ 2 / n) / μ + e / μ := by
    rw [hkey]
    have : lam = lam * μ / μ := by field_simp
    rw [this, div_le_iff₀ hμ]
    have e1 : (μ * ((n - 1) / n) - (T - μ ^ 2 / n) / μ + e / μ) * μ
        = μ ^ 2 * ((n - 1) / n) - (T - μ ^ 2 / n) + e := by field_simp
    rw [e1]; linarith
  nlinarith [hdiv]

/-- **L223, items 1 and 2**, at a near-critical unit diagonal tensor `S∘S = λS + E`. -/
theorem L223_items12 {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 4 ≤ Fintype.card ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (E : Matrix ι ι ℝ) (hE0 : ∀ a, E a a = 0) (lam : ℝ)
    (hnear : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b + E a b)
    (v : ι → ℝ) (μ : ℝ) (hv : S *ᵥ v = μ • v) (h2 : ∑ a, v a ^ 2 = 1) (hμ : 0 < μ) :
    let n : ℝ := Fintype.card ι
    let Θ := Real.sqrt (2 * (n - 1) * (n - 2)) / n
    let Zs := Real.sqrt ((n - 2) / (2 * (n - 1)))
    let Δ := Θ - lam + max 0 (-∑ a, ∑ b, E a b * v a * v b) / μ
    let η₁ := (1 / 2) * ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2 - μ ^ 2 / n
    let Zn := Real.sqrt ((1 / 2) * ∑ a, ∑ b, Zp v n a b ^ 2)
    0 ≤ Δ ∧ 1 - (μ / 2) / Zn ≤ Δ / Θ ∧ η₁ ≤ μ * Δ ∧ Zs * (1 - Δ / Θ) ≤ Zn := by
  intro n Θ Zs Δ η₁ Zn
  have hn4 : (4 : ℝ) ≤ n := by show (4 : ℝ) ≤ (Fintype.card ι : ℝ); exact_mod_cast hn
  have hn1 : 0 < n - 1 := by linarith
  have hn2 : 0 < n - 2 := by linarith
  have h1 : ∑ a, v a = 0 := sum_v_zero S hS v μ hv hμ.ne'
  have hpair := pairing_near S hS v μ hv E hE0 lam h2 hnear
  have hs1 := step1 S hS v μ hv h2 h1
  have hs23 := step23 S hS v μ hv h2 h1 hn hunit
  have hZs0 : 0 < Zs := Real.sqrt_pos.mpr (by positivity)
  have hZs : Zs ^ 2 = (n - 2) / (2 * (n - 1)) := Real.sq_sqrt (by positivity)
  have hΘ : Θ = (n - 1) / n * (2 * Zs) := by
    have h2n : 2 * (n - 1) * Zs = Real.sqrt (2 * (n - 1) * (n - 2)) := by
      rw [← Real.sqrt_sq (show 0 ≤ 2 * (n - 1) * Zs by positivity)]
      congr 1; rw [mul_pow, hZs]; field_simp
    show Real.sqrt (2 * (n - 1) * (n - 2)) / n = (n - 1) / n * (2 * Zs)
    rw [← h2n]; field_simp
  have hΘ0 : 0 < Θ := by rw [hΘ]; positivity
  obtain ⟨hη0, hμZ, hchain⟩ := chain_core n μ ((1 / 2) * ∑ a, ∑ b, S a b ^ 2 * (v a - v b) ^ 2)
    (∑ a, ∑ b, E a b * v a * v b) lam (max 0 (-∑ a, ∑ b, E a b * v a * v b)) Θ Zs hn4 hμ hpair hs1 hs23
    (le_max_right _ _) hZs0 hZs hΘ
  have he0 : 0 ≤ max 0 (-∑ a, ∑ b, E a b * v a * v b) := le_max_left _ _
  -- `|Z| ≤ Z*` and `|Z| ≥ μ/2`
  obtain ⟨hSZ, hZZ⟩ := step23_parts S hS v μ hv h2 h1 hn
  have h4 : 1 / n ≤ ∑ a, v a ^ 4 := by
    have := HamiltonsCubic.L223Statement.fourth_moment_defect v (by linarith) h2
    have hnn : 0 ≤ ∑ a, (v a ^ 2 - 1 / n) ^ 2 := Finset.sum_nonneg fun a _ => sq_nonneg _
    linarith
  have hZn2 : (1 / 2) * ∑ a, ∑ b, Zp v n a b ^ 2 ≤ Zs ^ 2 := by
    rw [hZZ, hZs]
    have hpos : 0 < n / (2 * (n - 2)) := by positivity
    have := mul_le_mul_of_nonneg_left h4 hpos.le
    have e : (n ^ 2 - 3 * n + 3) / (2 * (n - 1) * (n - 2)) - n / (2 * (n - 2)) * (1 / n)
        = (n - 2) / (2 * (n - 1)) := by field_simp; ring
    linarith
  have hZnle : Zn ≤ Zs := by
    show Real.sqrt _ ≤ Zs
    rw [show Zs = Real.sqrt (Zs ^ 2) from (Real.sqrt_sq hZs0.le).symm]
    exact Real.sqrt_le_sqrt hZn2
  have hcs := cs_pairs S (Zp v n)
  rw [hSZ, hunit] at hcs
  have hZnge : μ / 2 ≤ Zn := by
    show μ / 2 ≤ Real.sqrt _
    apply Real.le_sqrt_of_sq_le
    nlinarith [hcs]
  have hZnpos : 0 < Zn := lt_of_lt_of_le (by positivity) hZnge
  -- the four claims
  have hΔ0 : 0 ≤ Δ := by
    have : 0 ≤ Θ * (1 - μ / (2 * Zs)) := by
      apply mul_nonneg hΘ0.le; rw [sub_nonneg, div_le_one (by positivity)]; exact hμZ
    have : 0 ≤ η₁ / μ := div_nonneg hη0 hμ.le
    show 0 ≤ Θ - lam + _ / μ
    linarith
  have hA : Θ * (1 - μ / (2 * Zs)) ≤ Δ := by
    have : 0 ≤ η₁ / μ := div_nonneg hη0 hμ.le
    show _ ≤ Θ - lam + _ / μ
    linarith
  refine ⟨hΔ0, ?_, ?_, ?_⟩
  · -- `cos α = μ/(2|Z|) ≥ μ/(2Z*)`
    have hcos : μ / (2 * Zs) ≤ (μ / 2) / Zn := by
      rw [div_div]; exact div_le_div_of_nonneg_left hμ.le (by positivity) (by linarith)
    rw [le_div_iff₀ hΘ0]
    nlinarith
  · have hmul : μ * (Θ * (1 - μ / (2 * Zs))) + η₁ ≤ μ * Δ := by
      have hc := hchain
      have : μ * (Θ * (1 - μ / (2 * Zs)) + η₁ / μ) ≤ μ * (Θ - lam + max 0 (-∑ a, ∑ b, E a b * v a * v b) / μ) :=
        mul_le_mul_of_nonneg_left hc hμ.le
      have e : μ * (Θ * (1 - μ / (2 * Zs)) + η₁ / μ) = μ * (Θ * (1 - μ / (2 * Zs))) + η₁ := by
        field_simp
      linarith
    have : 0 ≤ μ * (Θ * (1 - μ / (2 * Zs))) := by
      apply mul_nonneg hμ.le; apply mul_nonneg hΘ0.le
      rw [sub_nonneg, div_le_one (by positivity)]; exact hμZ
    linarith
  · -- `Z*(1 − Δ/Θ) ≤ μ/2 ≤ |Z|`
    have : Zs * (1 - Δ / Θ) ≤ μ / 2 := by
      have hA' : 1 - Δ / Θ ≤ μ / (2 * Zs) := by
        rw [sub_le_iff_le_add, ← sub_le_iff_le_add', le_div_iff₀ hΘ0]; linarith
      calc Zs * (1 - Δ / Θ) ≤ Zs * (μ / (2 * Zs)) := mul_le_mul_of_nonneg_left hA' hZs0.le
        _ = μ / 2 := by field_simp
    linarith

omit [DecidableEq ι] in
/-- `|vᵀEv| ≤ √(∑ E²)` at a unit `v`. -/
theorem quad_le_fro (E : Matrix ι ι ℝ) (v : ι → ℝ) (h2 : ∑ a, v a ^ 2 = 1) :
    |∑ a, ∑ b, E a b * v a * v b| ≤ Real.sqrt (∑ a, ∑ b, E a b ^ 2) := by
  have hcs := cs_pairs E (fun a b => v a * v b)
  have hvv : ∑ a, ∑ b, (v a * v b) ^ 2 = 1 := by
    simp only [mul_pow, ← Finset.mul_sum, ← Finset.sum_mul, h2, one_mul]
  rw [hvv, mul_one] at hcs
  have e : ∑ a, ∑ b, E a b * v a * v b = ∑ a, ∑ b, E a b * (v a * v b) :=
    Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  rw [e]
  exact Real.abs_le_sqrt hcs

/-- **At a top eigenvalue, `⟨S∘S, S⟩ ≤ 2μ`** over unordered pairs: `s_ab ≤ μ` off the diagonal and
`tr S³ ≤ μ tr S²`, the top property entering as the Rayleigh bound `xᵀSx ≤ μ‖x‖²`. -/
theorem prod_pair_le {S : Matrix ι ι ℝ} (hS : IsWeight S) (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (μ : ℝ)
    (htop : ∀ x : ι → ℝ, ∑ a, ∑ b, S a b * x a * x b ≤ μ * ∑ a, x a ^ 2) :
    (1 / 2) * ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b) * S a b ≤ 2 * μ := by
  -- `s_ab ≤ μ` at `a ≠ b`, from `x = e_a + e_b`
  have hsab : ∀ a b, a ≠ b → S a b ≤ μ := by
    intro a b hab
    have h := htop (fun c => (if c = a then 1 else 0) + (if c = b then 1 else 0))
    have lhs : ∑ c, ∑ d, S c d * ((if c = a then (1:ℝ) else 0) + (if c = b then 1 else 0))
        * ((if d = a then 1 else 0) + (if d = b then 1 else 0)) = 2 * S a b := by
      simp only [mul_add, mul_ite, mul_one, mul_zero, Finset.sum_add_distrib,
        Finset.sum_ite_eq', Finset.mem_univ, if_true]
      rw [hS.hollow a, hS.hollow b, hS.symm b a]; ring
    have rhs : ∑ c, ((if c = a then (1:ℝ) else 0) + (if c = b then 1 else 0)) ^ 2 = 2 := by
      have e : ∀ c, ((if c = a then (1:ℝ) else 0) + (if c = b then 1 else 0)) ^ 2
          = (if c = a then 1 else 0) + (if c = b then 1 else 0) := by
        intro c
        rcases eq_or_ne c a with h1 | h1 <;> rcases eq_or_ne c b with h2 | h2
        · exact absurd (h1.symm.trans h2) hab
        all_goals simp [h1, h2, hab, Ne.symm hab]
      simp only [e, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]; norm_num
    rw [lhs, rhs] at h; linarith
  -- `∑ s³ ≤ μ ∑ s²`
  have hcube : ∑ a, ∑ b, S a b ^ 2 * S a b ≤ μ * 2 := by
    rw [← hunit, Finset.mul_sum]
    refine Finset.sum_le_sum fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun b _ => ?_
    by_cases hab : a = b
    · subst hab; simp [hS.hollow a]
    · nlinarith [hsab a b hab, sq_nonneg (S a b)]
  -- `tr S³ ≤ μ tr S²`, from the Rayleigh bound at each column of `S`
  have htr : ∑ a, ∑ b, (S * S) a b * S a b ≤ μ * 2 := by
    have hcol : ∀ k, ∑ a, ∑ b, S a b * S a k * S b k ≤ μ * ∑ a, S a k ^ 2 := fun k => htop (fun a => S a k)
    have e1 : ∑ a, ∑ b, (S * S) a b * S a b = ∑ k, ∑ a, ∑ b, S a b * S a k * S b k := by
      simp only [Matrix.mul_apply, Finset.sum_mul]
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun a _ => ?_
      rw [Finset.sum_comm]
      refine Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun k _ => ?_
      rw [hS.symm k b]
    have e2 : ∑ k, ∑ a, S a k ^ 2 = 2 := by rw [Finset.sum_comm]; exact hunit
    rw [e1, ← e2, Finset.mul_sum]
    exact Finset.sum_le_sum fun k _ => hcol k
  simp only [add_mul, Finset.sum_add_distrib]
  linarith

/-- **L223, item 1's upper bound**: at the top eigenvalue, with `|E| < λ` (norms over unordered pairs),
`Δ ≤ Θ̄ − λ + 2√2|E|/(λ − |E|)`. -/
theorem L223_item1_upper {S : Matrix ι ι ℝ} (hS : IsWeight S)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (E : Matrix ι ι ℝ) (hE : IsWeight E) (lam : ℝ)
    (hnear : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b + E a b)
    (v : ι → ℝ) (μ : ℝ) (h2 : ∑ a, v a ^ 2 = 1)
    (htop : ∀ x : ι → ℝ, ∑ a, ∑ b, S a b * x a * x b ≤ μ * ∑ a, x a ^ 2)
    (hlam : Real.sqrt ((1 / 2) * ∑ a, ∑ b, E a b ^ 2) < lam) (Θ : ℝ) :
    let En := Real.sqrt ((1 / 2) * ∑ a, ∑ b, E a b ^ 2)
    (lam - En) / 2 ≤ μ ∧
      Θ - lam + max 0 (-∑ a, ∑ b, E a b * v a * v b) / μ
        ≤ Θ - lam + 2 * Real.sqrt 2 * En / (lam - En) := by
  intro En
  have hEn0 : 0 ≤ En := Real.sqrt_nonneg _
  -- `⟨S∘S, S⟩ = λ + ⟨E, S⟩ ≥ λ − |E|`
  have hpair : (1 / 2) * ∑ a, ∑ b, (S a b ^ 2 + (S * S) a b) * S a b
      = lam + (1 / 2) * ∑ a, ∑ b, E a b * S a b := by
    have e : ∀ a b, (S a b ^ 2 + (S * S) a b) * S a b = lam * S a b ^ 2 + E a b * S a b := by
      intro a b
      by_cases hab : a = b
      · subst hab; rw [hS.hollow a, hE.hollow a]; ring
      · rw [hnear a b hab]; ring
    simp only [e, Finset.sum_add_distrib, ← Finset.mul_sum, hunit]; ring
  have hES : |(1 / 2) * ∑ a, ∑ b, E a b * S a b| ≤ En := by
    have hcs := cs_pairs E S
    rw [hunit] at hcs
    have : ((1 / 2) * ∑ a, ∑ b, E a b * S a b) ^ 2 ≤ (1 / 2) * ∑ a, ∑ b, E a b ^ 2 := by nlinarith
    exact Real.abs_le_sqrt this
  have hμ := prod_pair_le hS hunit μ htop
  have hμlow : (lam - En) / 2 ≤ μ := by
    have := neg_abs_le ((1 / 2) * ∑ a, ∑ b, E a b * S a b)
    linarith
  refine ⟨hμlow, ?_⟩
  have hμpos : 0 < μ := lt_of_lt_of_le (by linarith) hμlow
  -- `e₋ ≤ √(∑ E²) = √2 |E|`
  have he : max 0 (-∑ a, ∑ b, E a b * v a * v b) ≤ Real.sqrt 2 * En := by
    have hq := quad_le_fro E v h2
    have hsq : Real.sqrt (∑ a, ∑ b, E a b ^ 2) = Real.sqrt 2 * En := by
      rw [← Real.sqrt_mul (by norm_num)]; congr 1; ring
    rw [hsq] at hq
    have : 0 ≤ Real.sqrt 2 * En := by positivity
    exact max_le this (le_trans (neg_le_abs _) hq)
  have hd : 0 < lam - En := by linarith
  have : max 0 (-∑ a, ∑ b, E a b * v a * v b) / μ ≤ 2 * Real.sqrt 2 * En / (lam - En) := by
    rw [div_le_div_iff₀ hμpos hd]
    have h0 : 0 ≤ max 0 (-∑ a, ∑ b, E a b * v a * v b) := le_max_left _ _
    have hs2 : 0 ≤ Real.sqrt 2 * En := by positivity
    nlinarith
  linarith

/-- `Zs² − Zn² ≤ 2x Zs²` from `Zn ≥ Zs(1 − x)`, `x ≥ 0`, `Zn ≥ 0`. -/
theorem sq_gap_le {Zs Zn x : ℝ} (hZs : 0 ≤ Zs) (hx : 0 ≤ x) (h : Zs * (1 - x) ≤ Zn) :
    Zs ^ 2 - Zn ^ 2 ≤ 2 * x * Zs ^ 2 := by
  by_cases h1 : x ≤ 1
  · have h0 : 0 ≤ Zs * (1 - x) := mul_nonneg hZs (by linarith)
    have : (Zs * (1 - x)) ^ 2 ≤ Zn ^ 2 := pow_le_pow_left₀ h0 h 2
    nlinarith [sq_nonneg x, sq_nonneg Zs]
  · push Not at h1; nlinarith [sq_nonneg Zn, sq_nonneg Zs]

/-- `||t| − 1/√n| ≤ √n |t² − 1/n|`. -/
theorem abs_sub_le (t s : ℝ) (hs : 0 < s) :
    (|t| - s) ^ 2 ≤ (t ^ 2 - s ^ 2) ^ 2 / s ^ 2 := by
  rw [le_div_iff₀ (by positivity)]
  have e : t ^ 2 - s ^ 2 = (|t| - s) * (|t| + s) := by rw [← sq_abs t]; ring
  rw [e, mul_pow]
  have : s ^ 2 ≤ (|t| + s) ^ 2 := by nlinarith [abs_nonneg t]
  nlinarith [sq_nonneg (|t| - s)]

/-- **L223, item 3**: `∑(v_i² − 1/n)² ≤ (2(n−2)²/(n(n−1))) Δ/Θ̄`; the sign vector `w_i = ±1/√n` (`+` where
`v_i ≥ 0`) has `‖v − w‖² ≤ (2(n−2)²/(n−1)) Δ/Θ̄`; and its classes of sizes `p, q` have `|p − q| ≤ n‖v − w‖`. -/
theorem L223_item3 {S : Matrix ι ι ℝ} (hS : IsWeight S) (hn : 4 ≤ Fintype.card ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (E : Matrix ι ι ℝ) (hE0 : ∀ a, E a a = 0) (lam : ℝ)
    (hnear : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b + E a b)
    (v : ι → ℝ) (μ : ℝ) (hv : S *ᵥ v = μ • v) (h2 : ∑ a, v a ^ 2 = 1) (hμ : 0 < μ) :
    let n : ℝ := Fintype.card ι
    let Θ := Real.sqrt (2 * (n - 1) * (n - 2)) / n
    let Δ := Θ - lam + max 0 (-∑ a, ∑ b, E a b * v a * v b) / μ
    let w : ι → ℝ := fun a => if 0 ≤ v a then 1 / Real.sqrt n else -(1 / Real.sqrt n)
    let p : ℝ := (univ.filter fun a => 0 ≤ v a).card
    let q : ℝ := (univ.filter fun a => v a < 0).card
    ∑ a, (v a ^ 2 - 1 / n) ^ 2 ≤ 2 * (n - 2) ^ 2 / (n * (n - 1)) * (Δ / Θ) ∧
      ∑ a, (v a - w a) ^ 2 ≤ 2 * (n - 2) ^ 2 / (n - 1) * (Δ / Θ) ∧
      |p - q| ≤ n * Real.sqrt (∑ a, (v a - w a) ^ 2) := by
  intro n Θ Δ w p q
  obtain ⟨hΔ0, -, -, hZn⟩ := L223_items12 hS hn hunit E hE0 lam hnear v μ hv h2 hμ
  have hn4 : (4 : ℝ) ≤ n := by show (4 : ℝ) ≤ (Fintype.card ι : ℝ); exact_mod_cast hn
  have hn0 : 0 < n := by linarith
  have hn1 : 0 < n - 1 := by linarith
  have hn2 : 0 < n - 2 := by linarith
  have h1 : ∑ a, v a = 0 := sum_v_zero S hS v μ hv hμ.ne'
  obtain ⟨-, hZZ⟩ := step23_parts S hS v μ hv h2 h1 hn
  have hndef : (Fintype.card ι : ℝ) = n := rfl
  have hfm := HamiltonsCubic.L223Statement.fourth_moment_defect v hn0 h2
  rw [hndef] at hZZ hfm
  set Zs := Real.sqrt ((n - 2) / (2 * (n - 1))) with hZsdef
  set Zn := Real.sqrt ((1 / 2) * ∑ a, ∑ b, Zp v n a b ^ 2) with hZndef
  have hZs2 : Zs ^ 2 = (n - 2) / (2 * (n - 1)) := Real.sq_sqrt (by positivity)
  have hZn2 : Zn ^ 2 = (1 / 2) * ∑ a, ∑ b, Zp v n a b ^ 2 := by
    apply Real.sq_sqrt; positivity
  have hΘ0 : 0 < Θ := by
    show 0 < Real.sqrt (2 * (n - 1) * (n - 2)) / n
    exact div_pos (Real.sqrt_pos.mpr (by positivity)) hn0
  have hx : 0 ≤ Δ / Θ := div_nonneg hΔ0 hΘ0.le
  have hgap := sq_gap_le (Real.sqrt_nonneg _) hx hZn
  -- `η₃ = (2(n−2)/n)(Zs² − Zn²)`
  have hη3 : ∑ a, (v a ^ 2 - 1 / n) ^ 2 = 2 * (n - 2) / n * (Zs ^ 2 - Zn ^ 2) := by
    rw [hfm, hZs2, hZn2, hZZ]
    field_simp; ring
  have item3a : ∑ a, (v a ^ 2 - 1 / n) ^ 2 ≤ 2 * (n - 2) ^ 2 / (n * (n - 1)) * (Δ / Θ) := by
    rw [hη3]
    have hc : 0 ≤ 2 * (n - 2) / n := by positivity
    calc 2 * (n - 2) / n * (Zs ^ 2 - Zn ^ 2) ≤ 2 * (n - 2) / n * (2 * (Δ / Θ) * Zs ^ 2) :=
          mul_le_mul_of_nonneg_left hgap hc
      _ = 2 * (n - 2) ^ 2 / (n * (n - 1)) * (Δ / Θ) := by rw [hZs2]; field_simp
  -- `‖v − w‖² ≤ n η₃`
  have hsn : 0 < Real.sqrt n := Real.sqrt_pos.mpr hn0
  have hsn2 : Real.sqrt n ^ 2 = n := Real.sq_sqrt hn0.le
  have hvw : ∀ a, (v a - w a) ^ 2 = (|v a| - 1 / Real.sqrt n) ^ 2 := by
    intro a
    show (v a - (if 0 ≤ v a then 1 / Real.sqrt n else -(1 / Real.sqrt n))) ^ 2 = _
    split_ifs with h
    · rw [abs_of_nonneg h]
    · rw [abs_of_neg (not_le.mp h)]; ring
  have item3b : ∑ a, (v a - w a) ^ 2 ≤ 2 * (n - 2) ^ 2 / (n - 1) * (Δ / Θ) := by
    have hle : ∑ a, (v a - w a) ^ 2 ≤ n * ∑ a, (v a ^ 2 - 1 / n) ^ 2 := by
      rw [Finset.mul_sum]
      refine Finset.sum_le_sum fun a _ => ?_
      rw [hvw]
      have := abs_sub_le (v a) (1 / Real.sqrt n) (by positivity)
      have e : (1 / Real.sqrt n) ^ 2 = 1 / n := by rw [div_pow, hsn2, one_pow]
      rw [e] at this
      calc (|v a| - 1 / Real.sqrt n) ^ 2 ≤ (v a ^ 2 - 1 / n) ^ 2 / (1 / n) := this
        _ = n * (v a ^ 2 - 1 / n) ^ 2 := by field_simp
    calc ∑ a, (v a - w a) ^ 2 ≤ n * ∑ a, (v a ^ 2 - 1 / n) ^ 2 := hle
      _ ≤ n * (2 * (n - 2) ^ 2 / (n * (n - 1)) * (Δ / Θ)) := mul_le_mul_of_nonneg_left item3a hn0.le
      _ = 2 * (n - 2) ^ 2 / (n - 1) * (Δ / Θ) := by field_simp
  -- `|p − q| ≤ n‖v − w‖`
  have hsumw : ∑ a, w a = (p - q) / Real.sqrt n := by
    show ∑ a, (if 0 ≤ v a then 1 / Real.sqrt n else -(1 / Real.sqrt n)) = _
    rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const, nsmul_eq_mul, nsmul_eq_mul]
    have hq : (univ.filter fun a => ¬ 0 ≤ v a) = univ.filter fun a => v a < 0 := by
      ext a; simp
    rw [hq]; ring
  have item3c : |p - q| ≤ n * Real.sqrt (∑ a, (v a - w a) ^ 2) := by
    have hcs : (∑ a, (w a - v a)) ^ 2 ≤ n * ∑ a, (v a - w a) ^ 2 := by
      have := Finset.sum_mul_sq_le_sq_mul_sq univ (fun _ => (1 : ℝ)) (fun a => w a - v a)
      simp only [one_mul, one_pow, Finset.sum_const, Finset.card_univ, nsmul_eq_mul, mul_one] at this
      have e : ∑ a, (w a - v a) ^ 2 = ∑ a, (v a - w a) ^ 2 :=
        Finset.sum_congr rfl fun a _ => by ring
      rw [e] at this; exact this
    rw [Finset.sum_sub_distrib, h1, sub_zero, hsumw, div_pow, hsn2] at hcs
    have hsq : (p - q) ^ 2 ≤ (n * Real.sqrt (∑ a, (v a - w a) ^ 2)) ^ 2 := by
      rw [mul_pow, Real.sq_sqrt (Finset.sum_nonneg fun a _ => sq_nonneg _)]
      rw [div_le_iff₀ hn0] at hcs; nlinarith
    exact abs_le_of_sq_le_sq' hsq (by positivity) |> fun h => abs_le.mpr h
  exact ⟨item3a, item3b, item3c⟩

/-- **The Rayleigh bound at the top eigenvalue** of a real symmetric matrix: `xᵀSx ≤ λ_max ‖x‖²`. -/
theorem rayleigh_le_top {S : Matrix ι ι ℝ} (hA : S.IsHermitian) (j : ι)
    (hj : ∀ i, hA.eigenvalues i ≤ hA.eigenvalues j) (x : ι → ℝ) :
    ∑ a, ∑ b, S a b * x a * x b ≤ hA.eigenvalues j * ∑ a, x a ^ 2 := by
  set bs := hA.eigenvectorBasis with hbs
  set xE : EuclideanSpace ℝ ι := WithLp.toLp 2 x with hxE
  set c : ι → ℝ := fun k => inner ℝ (bs k) xE with hc
  have hck : ∀ k, c k = x ⬝ᵥ ⇑(bs k) := fun k => by
    simp only [hc, EuclideanSpace.inner_eq_star_dotProduct, star_trivial, hxE]
  have hx : x = ∑ k, c k • ⇑(bs k) := by
    have h := congrArg (WithLp.ofLp) (bs.sum_repr' xE)
    rw [WithLp.ofLp_sum] at h
    simp only [WithLp.ofLp_smul] at h
    exact h.symm
  have hquad : ∑ a, ∑ b, S a b * x a * x b = x ⬝ᵥ (S *ᵥ x) := by
    simp only [dotProduct, Matrix.mulVec, Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring
  have hSx : S *ᵥ x = ∑ k, (c k * hA.eigenvalues k) • ⇑(bs k) := by
    conv_lhs => rw [hx]
    rw [Matrix.mulVec_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [Matrix.mulVec_smul, hA.mulVec_eigenvectorBasis k, smul_smul]
  have hval : x ⬝ᵥ (S *ᵥ x) = ∑ k, hA.eigenvalues k * c k ^ 2 := by
    rw [hSx, dotProduct_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [dotProduct_smul, ← hck, smul_eq_mul]; ring
  have hnorm : ∑ k, c k ^ 2 = ∑ a, x a ^ 2 := by
    have h := bs.sum_sq_inner_right xE
    rw [EuclideanSpace.norm_sq_eq] at h
    simpa [hc, hxE, Real.norm_eq_abs, sq_abs] using h
  rw [hquad, hval, ← hnorm, Finset.mul_sum]
  exact Finset.sum_le_sum fun k _ => mul_le_mul_of_nonneg_right (hj k) (sq_nonneg _)

/-- **A unit weight has a top eigenpair**: `μ > 0`, a unit eigenvector, and the Rayleigh bound. -/
theorem exists_top_eigen {S : Matrix ι ι ℝ} (hS : HamiltonsCubic.FamilyLayer.IsWeight S) (hne : Nonempty ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) :
    ∃ (μ : ℝ) (v : ι → ℝ), 0 < μ ∧ S *ᵥ v = μ • v ∧ ∑ a, v a ^ 2 = 1 ∧
      ∀ x : ι → ℝ, ∑ a, ∑ b, S a b * x a * x b ≤ μ * ∑ a, x a ^ 2 := by
  have hA := isHermitian_of_weight hS
  have hS0 : S ≠ 0 := by
    intro h; rw [h] at hunit; simp at hunit
  obtain ⟨j, -, hj⟩ := Finset.exists_max_image Finset.univ hA.eigenvalues Finset.univ_nonempty
  have htr : ∑ i, hA.eigenvalues i = 0 := by
    have h := hA.trace_eq_sum_eigenvalues
    have h0 : S.trace = 0 := by simp [Matrix.trace, hS.hollow]
    rw [h0] at h
    simpa using h.symm
  have hpos : 0 < hA.eigenvalues j := by
    by_contra hle
    push Not at hle
    have hall : ∀ i, hA.eigenvalues i ≤ 0 := fun i => le_trans (hj i (Finset.mem_univ i)) hle
    have hz := (Finset.sum_eq_zero_iff_of_nonpos fun i _ => hall i).mp htr
    apply hS0
    exact hA.eigenvalues_eq_zero_iff.mp (funext fun i => hz i (Finset.mem_univ i))
  refine ⟨hA.eigenvalues j, ⇑(hA.eigenvectorBasis j), hpos, hA.mulVec_eigenvectorBasis j, ?_,
    rayleigh_le_top hA j (fun i => hj i (Finset.mem_univ i))⟩
  have hn := hA.eigenvectorBasis.orthonormal.1 j
  rw [EuclideanSpace.norm_eq, Real.sqrt_eq_one] at hn
  simpa [Real.norm_eq_abs, sq_abs] using hn

/-- **L223, item 1 at one eigenpair**: at the top eigenpair `(μ, v)` of a near-critical unit `S` with
`|E| < λ`, `0 ≤ Δ ≤ Θ̄ − λ + 2√2|E|/(λ − |E|)`. -/
theorem L223_item1 {S : Matrix ι ι ℝ} (hS : HamiltonsCubic.FamilyLayer.IsWeight S) (hn : 4 ≤ Fintype.card ι)
    (hunit : ∑ a, ∑ b, S a b ^ 2 = 2) (E : Matrix ι ι ℝ) (hE : HamiltonsCubic.FamilyLayer.IsWeight E) (lam : ℝ)
    (hnear : ∀ a b, a ≠ b → S a b ^ 2 + (S * S) a b = lam * S a b + E a b)
    (hlam : Real.sqrt ((1 / 2) * ∑ a, ∑ b, E a b ^ 2) < lam) :
    ∃ (μ : ℝ) (v : ι → ℝ), 0 < μ ∧ S *ᵥ v = μ • v ∧ ∑ a, v a ^ 2 = 1 ∧
      (∀ x : ι → ℝ, ∑ a, ∑ b, S a b * x a * x b ≤ μ * ∑ a, x a ^ 2) ∧
      0 ≤ Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2)) / (Fintype.card ι : ℝ) - lam
          + max 0 (-∑ a, ∑ b, E a b * v a * v b) / μ ∧
      Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2)) / (Fintype.card ι : ℝ) - lam
          + max 0 (-∑ a, ∑ b, E a b * v a * v b) / μ
        ≤ Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2)) / (Fintype.card ι : ℝ) - lam
          + 2 * Real.sqrt 2 * Real.sqrt ((1 / 2) * ∑ a, ∑ b, E a b ^ 2)
            / (lam - Real.sqrt ((1 / 2) * ∑ a, ∑ b, E a b ^ 2)) := by
  have hne : Nonempty ι := Fintype.card_pos_iff.mp (by omega)
  obtain ⟨μ, v, hμ, hv, h2, htop⟩ := exists_top_eigen hS hne hunit
  obtain ⟨h0, -⟩ := L223_items12 hS hn hunit E hE.hollow lam hnear v μ hv h2 hμ
  obtain ⟨-, hup⟩ := L223_item1_upper hS hunit E hE lam hnear v μ h2 htop hlam
    (Real.sqrt (2 * ((Fintype.card ι : ℝ) - 1) * ((Fintype.card ι : ℝ) - 2)) / (Fintype.card ι : ℝ))
  exact ⟨μ, v, hμ, hv, h2, htop, h0, hup⟩

end HamiltonsCubic.L57Critical
