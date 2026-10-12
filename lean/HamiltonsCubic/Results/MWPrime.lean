import Mathlib

set_option linter.style.longLine false

/-!
# MW', the decoupled walk inequality of J1, for `m ≥ 7`

[The J1 working note](../../../reviews/2026-09-27-I117-J1.md), batch 11, and its findings block in
[second-order.md](../../../findings/second-order.md). With `n = m − 1`, `κ = λ_m² = 2(n + 1)(n − 1)²/n³`, a symmetric
non-negative zero-diagonal `w` on `m` points with `Σ w = 1`, `π_i = Σ_j w_ij` and `q_ij = w_ij/π_i`, MW' is, for every
`γ ∈ [0, 1]` per ordered pair,
`Σ_{i,j} [w_ij (1 − q_ij)(1 + γ_ij(1 − 2q_ij)) + κ w_ij² (1 − γ_ij²)] ≤ κ (1 − Σ_i π_i²)`,
the maximum over `γ` of the left side being `Σ_i π_i Σ_j F(q_ij, π_i)`. `MWprime` proves it for `m ≥ 7`.

The proof, one declaration per step:
- `row_chord`: a bound on one row, linear in `Σ_j q_j²`, with the slope `β(π) = 2(n − 1)/n − nκπ/(n − 1)`. It is
  affine in `π` at fixed `(q, γ)`, so it is the combination of `R0` (at `π = 0`) and `Rhalf` (at `π = ½`).
- `left_concave`: the equal-variable reduction both rows use. A function concave on `[0, 1/n]` whose value with one
  large entry and `n − 1` equal small ones stays below `n f(1/n)` has `Σ_j f(q_j) ≤ n f(1/n)` on the simplex.
- `L1_nonpos` and `L2_nonneg`: the two polynomial inequalities closing `Rhalf`, the second by its Bernstein
  coefficients, polynomials in `n − 6` with positive coefficients.
- `Hc`: the inequality in `π` alone, by Titu's form, the tangent of a concave function at `π = s`, and
  `(1 − 2s)((n + 1)s − 1) ≥ 0`.
- `MWprime`: the rows, a weighted column Cauchy–Schwarz, and `Hc`.
-/

namespace HamiltonsCubic.MWPrime

open Finset

noncomputable def kap (n : ℝ) : ℝ := 2 * (n + 1) * (n - 1) ^ 2 / n ^ 3

noncomputable def slope (n p : ℝ) : ℝ := 2 * (n - 1) / n - n * kap n * p / (n - 1)

theorem left_concave (n : ℕ) (hn : 2 ≤ n) (f : ℝ → ℝ) (hf : ConcaveOn ℝ (Set.Icc 0 (1 / (n : ℝ))) f)
    (h2 : ∀ x ∈ Set.Icc (1 / (n : ℝ)) 1, f x + ((n : ℝ) - 1) * f ((1 - x) / ((n : ℝ) - 1)) ≤ n * f (1 / n))
    (q : Fin n → ℝ) (hq : ∀ j, 0 ≤ q j) (hs : ∑ j, q j = 1) :
    ∑ j, f (q j) ≤ n * f (1 / n) := by
  have hN : (2 : ℝ) ≤ n := by exact_mod_cast hn
  have hN0 : (0 : ℝ) < n := by linarith
  have hN1 : (0 : ℝ) < (n : ℝ) - 1 := by linarith
  set c : ℝ := 1 / (n : ℝ) with hc
  have hc0 : 0 < c := by positivity
  have hnc : (n : ℝ) * c = 1 := by rw [hc]; field_simp
  have hq1 : ∀ j, q j ≤ 1 := fun j => by
    have := Finset.single_le_sum (fun k _ => hq k) (Finset.mem_univ j); linarith
  set I := Finset.univ.filter (fun j => q j ≤ c) with hI
  set J := Finset.univ.filter (fun j => ¬ q j ≤ c) with hJ
  have hsplit : ∀ g : Fin n → ℝ, ∑ j, g j = ∑ j ∈ I, g j + ∑ j ∈ J, g j := fun g =>
    (Finset.sum_filter_add_sum_filter_not Finset.univ (fun j => q j ≤ c) g).symm
  have hcard : (I.card : ℝ) + J.card = n := by
    have := Finset.card_filter_add_card_filter_not (s := Finset.univ) (fun j : Fin n => q j ≤ c)
    rw [Finset.card_univ, Fintype.card_fin] at this; exact_mod_cast this
  have hIm : ∀ i ∈ I, q i ∈ Set.Icc 0 c := fun i hi => by
    simp only [hI, Finset.mem_filter, Finset.mem_univ, true_and] at hi; exact ⟨hq i, hi⟩
  have hJm : ∀ j ∈ J, c < q j := fun j hj => by
    simp only [hJ, Finset.mem_filter, Finset.mem_univ, true_and] at hj; exact lt_of_not_ge hj
  have hcIcc : c ∈ Set.Icc 0 c := ⟨hc0.le, le_refl c⟩
  -- case J empty: Jensen over all points
  by_cases hJe : J = ∅
  · have hIall : ∀ j, q j ∈ Set.Icc 0 c := fun j => by
      by_contra h
      have : j ∈ J := by
        simp only [hJ, Finset.mem_filter, Finset.mem_univ, true_and]
        intro hle; exact h ⟨hq j, hle⟩
      rw [hJe] at this; simp at this
    have hj := hf.le_map_sum (t := Finset.univ) (w := fun _ => c) (p := q) (fun _ _ => hc0.le)
      (by rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, hnc]) (fun j _ => hIall j)
    simp only [smul_eq_mul] at hj
    rw [← Finset.mul_sum, ← Finset.mul_sum, hs, mul_one] at hj
    have := mul_le_mul_of_nonneg_left hj hN0.le
    rw [← mul_assoc, hnc, one_mul] at this; exact this
  -- case J nonempty
  have hJne : J.Nonempty := Finset.nonempty_iff_ne_empty.2 hJe
  set k : ℝ := (J.card : ℝ) with hk
  set m' : ℝ := (I.card : ℝ) with hm'
  have hk1 : (1 : ℝ) ≤ k := by rw [hk]; exact_mod_cast Finset.card_pos.2 hJne
  have hsJ : k * c < ∑ j ∈ J, q j := by
    have := Finset.sum_lt_sum_of_nonempty hJne (f := fun _ => c) (g := q) (fun j hj => hJm j hj)
    rw [Finset.sum_const, nsmul_eq_mul] at this; exact this
  have hsI : ∑ i ∈ I, q i = 1 - ∑ j ∈ J, q j := by rw [← hs, hsplit q]; ring
  have hm'pos : 0 < m' := by
    by_contra h; push Not at h
    have hm0 : m' = 0 := le_antisymm h (by rw [hm']; positivity)
    have : k = n := by linarith
    rw [this, hnc] at hsJ
    have : ∑ i ∈ I, q i = 0 := by
      rw [hm', Nat.cast_eq_zero, Finset.card_eq_zero] at hm0; rw [hm0, Finset.sum_empty]
    have := Finset.sum_nonneg (s := I) fun i _ => hq i
    linarith
  set z : ℝ := (∑ i ∈ I, q i) / m' with hz
  have hz0 : 0 ≤ z := div_nonneg (Finset.sum_nonneg fun i _ => hq i) hm'pos.le
  have hzc : z < c := by
    rw [hz, div_lt_iff₀ hm'pos, hsI]
    have : m' * c = 1 - k * c := by rw [show m' = (n : ℝ) - k by linarith [hcard], sub_mul, hnc]
    linarith
  -- Jensen over I
  have hjI : ∑ i ∈ I, f (q i) ≤ m' * f z := by
    have hj := hf.le_map_sum (t := I) (w := fun _ => 1 / m') (p := q) (fun _ _ => by positivity)
      (by rw [Finset.sum_const, nsmul_eq_mul, ← hm']; field_simp) hIm
    simp only [smul_eq_mul] at hj
    rw [← Finset.mul_sum, ← Finset.mul_sum] at hj
    have e : 1 / m' * ∑ i ∈ I, q i = z := by rw [hz]; ring
    rw [e] at hj
    have := mul_le_mul_of_nonneg_left hj hm'pos.le
    rwa [← mul_assoc, mul_one_div_cancel hm'pos.ne', one_mul] at this
  -- each y_j lies in [z, c]
  set y : Fin n → ℝ := fun j => (1 - q j) / ((n : ℝ) - 1) with hy
  have hyc : ∀ j ∈ J, y j ≤ c := fun j hj => by
    rw [hy, div_le_iff₀ hN1]
    have := hJm j hj
    have : ((n : ℝ) - 1) * c = 1 - c := by rw [sub_mul, hnc, one_mul]
    nlinarith
  have hyz : ∀ j ∈ J, z ≤ y j := fun j hj => by
    rw [hy, le_div_iff₀ hN1]
    have hrest : 1 - q j = ∑ i ∈ I, q i + ∑ l ∈ J.erase j, q l := by
      rw [hsI]; have := Finset.add_sum_erase J q hj; linarith
    have hJe' : ((k - 1) : ℝ) * c ≤ ∑ l ∈ J.erase j, q l := by
      have := Finset.sum_le_sum (s := J.erase j) (f := fun _ => c) (g := q)
        fun l hl => (hJm l (Finset.mem_of_mem_erase hl)).le
      rw [Finset.sum_const, nsmul_eq_mul, Finset.card_erase_of_mem hj] at this
      rw [hk]; push_cast [Finset.card_pos.2 hJne] at this ⊢
      have : ((J.card - 1 : ℕ) : ℝ) = (J.card : ℝ) - 1 := by
        rw [Nat.cast_sub (Finset.card_pos.2 hJne)]; simp
      linarith
    have hIz : ∑ i ∈ I, q i = m' * z := by rw [hz]; field_simp
    have : ((n : ℝ) - 1) = m' + (k - 1) := by rw [hm', hk]; linarith [hcard]
    rw [hrest, hIz, this]
    nlinarith [mul_le_mul_of_nonneg_left hzc.le (by linarith : (0 : ℝ) ≤ k - 1)]
  -- chord: f(y_j) ≥ θ_j f(z) + (1 − θ_j) f(c)
  set θ : Fin n → ℝ := fun j => (c - y j) / (c - z) with hθ
  have hcz : 0 < c - z := by linarith
  have hchord : ∀ j ∈ J, θ j * f z + (1 - θ j) * f c ≤ f (y j) := fun j hj => by
    have ht0 : 0 ≤ θ j := div_nonneg (by linarith [hyc j hj]) hcz.le
    have ht1 : θ j ≤ 1 := by rw [hθ, div_le_one hcz]; linarith [hyz j hj]
    have hmix : θ j * z + (1 - θ j) * c = y j := by
      rw [hθ]; field_simp; ring
    have := hf.2 ⟨hz0, hzc.le⟩ hcIcc ht0 (by linarith : 0 ≤ 1 - θ j) (by ring)
    simp only [smul_eq_mul] at this
    rwa [hmix] at this
  have hθsum : ((n : ℝ) - 1) * ∑ j ∈ J, θ j = m' := by
    have e1 : ∑ j ∈ J, θ j = (∑ j ∈ J, (c - y j)) / (c - z) := by rw [Finset.sum_div]
    have e2 : ∑ j ∈ J, (c - y j) = k * c - (k - ∑ j ∈ J, q j) / ((n : ℝ) - 1) := by
      rw [Finset.sum_sub_distrib, Finset.sum_const, nsmul_eq_mul, ← hk, hy, ← Finset.sum_div,
        Finset.sum_sub_distrib, Finset.sum_const, nsmul_eq_mul, ← hk, mul_one]
    rw [e1, e2, mul_div_assoc', div_eq_iff hcz.ne']
    have hIz : m' * z = 1 - ∑ j ∈ J, q j := by rw [← hsI, hz]; field_simp
    have hmn : m' = n - k := by linarith [hcard]
    rw [mul_sub m', hIz, mul_sub, mul_div_cancel₀ _ hN1.ne']
    rw [hmn]; have := hnc; field_simp; ring_nf; nlinarith [hnc]
  -- assemble
  have hsum2 : ∑ j ∈ J, f (q j) ≤ ∑ j ∈ J, (n * f c - ((n : ℝ) - 1) * f (y j)) :=
    Finset.sum_le_sum fun j hj => by
      have := h2 (q j) ⟨(hJm j hj).le, hq1 j⟩; linarith
  have hchordsum : ∑ j ∈ J, (θ j * f z + (1 - θ j) * f c) ≤ ∑ j ∈ J, f (y j) := Finset.sum_le_sum hchord
  have e3 : ∑ j ∈ J, (θ j * f z + (1 - θ j) * f c) = (∑ j ∈ J, θ j) * f z + (k - ∑ j ∈ J, θ j) * f c := by
    rw [Finset.sum_add_distrib, ← Finset.sum_mul, ← Finset.sum_mul, Finset.sum_sub_distrib, Finset.sum_const,
      nsmul_eq_mul, ← hk, mul_one]
  have e4 : ∑ j ∈ J, (n * f c - ((n : ℝ) - 1) * f (y j)) = k * (n * f c) - ((n : ℝ) - 1) * ∑ j ∈ J, f (y j) := by
    rw [Finset.sum_sub_distrib, Finset.sum_const, nsmul_eq_mul, ← hk, Finset.mul_sum]
  rw [hsplit (fun j => f (q j))]
  rw [e4] at hsum2; rw [e3] at hchordsum
  have h6 := mul_le_mul_of_nonneg_left hchordsum hN1.le
  have h5 : ((n : ℝ) - 1) * ((∑ j ∈ J, θ j) * f z + (k - ∑ j ∈ J, θ j) * f c)
      = (((n : ℝ) - 1) * ∑ j ∈ J, θ j) * f z + (((n : ℝ) - 1) * k - ((n : ℝ) - 1) * ∑ j ∈ J, θ j) * f c := by ring
  rw [hθsum] at h5
  have h7 : (k + m') * f c = n * f c := by rw [show k + m' = n by linarith [hcard]]
  have h8 : k * (n * f c) - ((n : ℝ) - 1) * ∑ j ∈ J, f (y j) ≤ k * (n * f c) - (m' * f z + (((n : ℝ) - 1) * k - m') * f c) := by
    linarith
  nlinarith


/-- `κ/2`, `β(½)` and `A = 1 − κ/2 − β(½)` in terms of `N = n`. -/
noncomputable def Kt (N : ℝ) : ℝ := (N + 1) * (N - 1) ^ 2 / N ^ 3
noncomputable def sh (N : ℝ) : ℝ := (N - 1) ^ 2 / N ^ 2
noncomputable def Ah (N : ℝ) : ℝ := 1 - Kt N - sh N
/-- The light cubic (`γ = 1`), the unconstrained maximum over `γ`, and R½'s majorant. -/
noncomputable def psiL (N x : ℝ) : ℝ := x * (1 - x) * (1 - 2 * x + Ah N) - Kt N * x ^ 2
noncomputable def psih (N x : ℝ) : ℝ := x * (1 - x) * Ah N + (1 - x) ^ 2 * (1 - 2 * x) ^ 2 / (4 * Kt N)
noncomputable def fh (N x : ℝ) : ℝ :=
  if x ≤ 7 / 32 then psiL N x else if x ≤ 1 / 2 then psih N x else x * (1 - x) * Ah N

/-- `L₂ ≥ 0` on `[7/32, ½]` for `N ≥ 6`, by its Bernstein coefficients, polynomials in `N − 6` with positive coefficients. -/
theorem L2_nonneg (t : ℕ) (x : ℝ) (hx0 : 7 / 32 ≤ x) (hx1 : x ≤ 1 / 2) :
    let N : ℝ := (t : ℝ) + 6
    0 ≤ 4*N^6*x^3-8*N^6*x^2+9*N^6*x-N^6-28*N^5*x-8*N^4*x^2+16*N^4*x+12*N^4-8*N^3*x^2+52*N^3*x-8*N^3-8*N^2*x-24*N^2-8*N*x+4*x+4 := by
  intro N
  set T : ℝ := (t : ℝ) with hT
  set v : ℝ := (x - 7 / 32) * 32 / 9 with hv
  have hv0 : 0 ≤ v := by rw [hv]; nlinarith
  have hw0 : 0 ≤ 1 - v := by rw [hv]; nlinarith
  have hxv : x = 7 / 32 + 9 / 32 * v := by rw [hv]; ring
  have b0 : 0 ≤ 5143*T^6/8192 + 33743*T^5/2048 + 348945*T^4/2048 + 223471*T^3/256 + 1161217*T^2/512 + 342355*T/128 + 123975/128 := by positivity
  have b1 : 0 ≤ 1839*T^6/512 + 13191*T^5/128 + 19215*T^4/16 + 929535*T^3/128 + 1536477*T^2/64 + 1317801*T/32 + 460557/16 := by positivity
  have b2 : 0 ≤ 39*T^6/8 + 1131*T^5/8 + 3321*T^4/2 + 80421*T^3/8 + 65595*T^2/2 + 215547*T/4 + 270963/8 := by positivity
  have b3 : 0 ≤ 2*T^6 + 58*T^5 + 678*T^4 + 4048*T^3 + 12788*T^2 + 19532*T + 10206 := by positivity
  have e : 4*N^6*x^3-8*N^6*x^2+9*N^6*x-N^6-28*N^5*x-8*N^4*x^2+16*N^4*x+12*N^4-8*N^3*x^2+52*N^3*x-8*N^3-8*N^2*x-24*N^2-8*N*x+4*x+4
      = (5143*T^6/8192 + 33743*T^5/2048 + 348945*T^4/2048 + 223471*T^3/256 + 1161217*T^2/512 + 342355*T/128 + 123975/128) * (1 - v) ^ 3
        + (1839*T^6/512 + 13191*T^5/128 + 19215*T^4/16 + 929535*T^3/128 + 1536477*T^2/64 + 1317801*T/32 + 460557/16) * (v * (1 - v) ^ 2)
        + (39*T^6/8 + 1131*T^5/8 + 3321*T^4/2 + 80421*T^3/8 + 65595*T^2/2 + 215547*T/4 + 270963/8) * (v ^ 2 * (1 - v))
        + (2*T^6 + 58*T^5 + 678*T^4 + 4048*T^3 + 12788*T^2 + 19532*T + 10206) * v ^ 3 := by
    rw [hxv]; ring
  rw [e]
  have := mul_nonneg b0 (pow_nonneg hw0 3)
  have := mul_nonneg b1 (mul_nonneg hv0 (pow_nonneg hw0 2))
  have := mul_nonneg b2 (mul_nonneg (pow_nonneg hv0 2) hw0)
  have := mul_nonneg b3 (pow_nonneg hv0 3)
  linarith

/-- `L₁ ≤ 0` on `[½, 1]` for `N ≥ 6`: `L₁` is a convex quadratic in `x`, negative at both ends. -/
theorem L1_nonpos (t : ℕ) (x : ℝ) (hx0 : 1 / 2 ≤ x) (hx1 : x ≤ 1) :
    let N : ℝ := (t : ℝ) + 6
    2*N^3*x^2+(-N^5+8*N^4-12*N^3-N^2+3*N-1)*x-3*N^3+5*N^2+N-1 ≤ 0 := by
  intro N
  set T : ℝ := (t : ℝ) with hT
  have hN0 : 0 ≤ N ^ 3 := by positivity
  have ea : 0 ≤ T^5/2 + 11*T^4 + 185*T^3/2 + 729*T^2/2 + 1291*T/2 + 729/2 := by positivity
  have eb : 0 ≤ T^5 + 22*T^4 + 181*T^3 + 662*T^2 + 920*T + 50 := by positivity
  have e : 2*N^3*x^2+(-N^5+8*N^4-12*N^3-N^2+3*N-1)*x-3*N^3+5*N^2+N-1
      = -(2 - 2 * x) * (T^5/2 + 11*T^4 + 185*T^3/2 + 729*T^2/2 + 1291*T/2 + 729/2)
        - (2 * x - 1) * (T^5 + 22*T^4 + 181*T^3 + 662*T^2 + 920*T + 50) + N ^ 3 * ((x - 1) * (2 * x - 1)) := by
    ring
  rw [e]
  have h1 := mul_nonneg (by linarith : (0:ℝ) ≤ 2 - 2 * x) ea
  have h2 := mul_nonneg (by linarith : (0:ℝ) ≤ 2 * x - 1) eb
  have h3 : N ^ 3 * ((x - 1) * (2 * x - 1)) ≤ 0 :=
    mul_nonpos_of_nonneg_of_nonpos hN0 (mul_nonpos_of_nonpos_of_nonneg (by linarith) (by linarith))
  linarith

theorem id_r0_small (N x : ℝ) (hN : N ≠ 0) (hN1 : N - 1 ≠ 0) :
    x * (1 - x) * ((2 - N) / N + (1 - 2 * x)) + (N - 1) * ((1 - x) / (N - 1) * (1 - (1 - x) / (N - 1)) * (2 * (1 / N) - 2 * ((1 - x) / (N - 1))))
      = -2 * (x - 1 / N) ^ 2 * ((1 - 1 / N - x) + (1 - 1 / N - (1 - x) / (N - 1)) / (N - 1)) := by
  field_simp; ring

theorem id_r0_big (N x : ℝ) (hN : N ≠ 0) (hN1 : N - 1 ≠ 0) :
    x * (1 - x) * ((2 - N) / N + 0) + (N - 1) * ((1 - x) / (N - 1) * (1 - (1 - x) / (N - 1)) * (2 * (1 / N) - 2 * ((1 - x) / (N - 1))))
      = (1 - x) * (2 * N * x ^ 2 - N * (N - 3) ^ 2 * x - 2 * (N - 2)) / (N * (N - 1) ^ 2) := by
  field_simp; ring

theorem id_psiLc (N : ℝ) (hN : N ≠ 0) : psiL N (1 / N) = 0 := by
  simp only [psiL, Ah, Kt, sh]; field_simp; ring

set_option maxHeartbeats 1000000 in
-- `field_simp` and `ring` on rational identities of degree about ten in `N` exceed the default budget.
theorem id_i (N x : ℝ) (hN : N ≠ 0) (hN1 : N - 1 ≠ 0) :
    psiL N x + (N - 1) * psiL N ((1 - x) / (N - 1))
      = 2 * (x - 1 / N) ^ 2 * ((x - (3 * N + 1) * (N - 1) / (2 * N ^ 2)) + ((1 - x) / (N - 1) - (3 * N + 1) * (N - 1) / (2 * N ^ 2)) / (N - 1)) := by
  simp only [psiL, Ah, Kt, sh]; field_simp; ring

set_option maxHeartbeats 1000000 in
-- `field_simp` and `ring` on rational identities of degree about ten in `N` exceed the default budget.
theorem id_ii (N x : ℝ) (hN : N ≠ 0) (hN1 : N - 1 ≠ 0) (hNp : N + 1 ≠ 0) :
    psih N x + (N - 1) * psiL N ((1 - x) / (N - 1))
      = (x - 1) * (4*N^6*x^3-8*N^6*x^2+9*N^6*x-N^6-28*N^5*x-8*N^4*x^2+16*N^4*x+12*N^4-8*N^3*x^2+52*N^3*x-8*N^3-8*N^2*x-24*N^2-8*N*x+4*x+4)
        / (4 * N ^ 3 * (N - 1) ^ 2 * (N + 1)) := by
  simp only [psih, psiL, Ah, Kt, sh]; field_simp; ring

set_option maxHeartbeats 1000000 in
-- `field_simp` and `ring` on rational identities of degree about ten in `N` exceed the default budget.
theorem id_iii (N x : ℝ) (hN : N ≠ 0) (hN1 : N - 1 ≠ 0) :
    x * (1 - x) * Ah N + (N - 1) * psiL N ((1 - x) / (N - 1))
      = (1 - x) * (2*N^3*x^2+(-N^5+8*N^4-12*N^3-N^2+3*N-1)*x-3*N^3+5*N^2+N-1) / (N ^ 3 * (N - 1) ^ 2) := by
  simp only [psiL, Ah, Kt, sh]; field_simp; ring


theorem id_psih_gap (K A x g : ℝ) (hK : K ≠ 0) (hx : x ≠ 0) :
    x * (1 - x) * A + (1 - x) ^ 2 * (1 - 2 * x) ^ 2 / (4 * K) - (x * (1 - x) * (g * (1 - 2 * x) + A) - K * g ^ 2 * x ^ 2)
      = (x * (1 - x) * (1 - 2 * x) - 2 * K * x ^ 2 * g) ^ 2 / (4 * K * x ^ 2) := by
  field_simp; ring


/-- R0's majorant, one entry at a time. -/
noncomputable def f0 (N x : ℝ) : ℝ := x * (1 - x) * ((2 - N) / N + max 0 (1 - 2 * x))

/-- **R0**, the row chord at `π = 0`: `Σ_j q_j(1 − q_j)(1 + γ_j(1 − 2q_j)) ≤ β(0)(1 − Σ_j q_j²)` for `n ≥ 2`. -/
theorem R0 (n : ℕ) (hn : 6 ≤ n) (q γ : Fin n → ℝ) (hq : ∀ j, 0 ≤ q j) (hs : ∑ j, q j = 1)
    (hγ : ∀ j, 0 ≤ γ j ∧ γ j ≤ 1) :
    ∑ j, q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) ≤ slope n 0 * (1 - ∑ j, q j ^ 2) := by
  set N : ℝ := (n : ℝ) with hNdef
  have hN : (6 : ℝ) ≤ N := by rw [hNdef]; exact_mod_cast hn
  have hN0 : (0 : ℝ) < N := by linarith
  have hN1 : (0 : ℝ) < N - 1 := by linarith
  set c : ℝ := 1 / N with hc
  have hc0 : 0 < c := by positivity
  have hc2 : c ≤ 1 / 2 := by rw [hc]; exact div_le_div_of_nonneg_left (by norm_num) (by norm_num) (by linarith)
  have hNc : N * c = 1 := by rw [hc]; field_simp
  have hq1 : ∀ j, q j ≤ 1 := fun j => by
    have := Finset.single_le_sum (fun k _ => hq k) (Finset.mem_univ j); linarith
  have hsl : slope n 0 = 2 * (N - 1) / N := by simp [slope, hNdef]
  -- per entry
  have hper : ∀ j, q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) - 2 * (N - 1) / N * (q j * (1 - q j)) ≤ f0 N (q j) := by
    intro j
    have hqq : 0 ≤ q j * (1 - q j) := mul_nonneg (hq j) (by linarith [hq1 j])
    have hmax : γ j * (1 - 2 * q j) ≤ max 0 (1 - 2 * q j) := by
      rcases le_total 0 (1 - 2 * q j) with h | h
      · rw [max_eq_right h]; nlinarith [(hγ j).2]
      · rw [max_eq_left h]; nlinarith [(hγ j).1]
    have e : q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) - 2 * (N - 1) / N * (q j * (1 - q j))
        = q j * (1 - q j) * ((2 - N) / N + γ j * (1 - 2 * q j)) := by field_simp; ring
    rw [e, f0]; exact mul_le_mul_of_nonneg_left (by linarith) hqq
  -- f0 is concave on [0, c]
  have hmaxc : ∀ x, x ≤ c → max 0 (1 - 2 * x) = 1 - 2 * x := fun x hx => max_eq_right (by linarith)
  have hf0c : ∀ x, x ≤ c → f0 N x = x * (1 - x) * (2 * c - 2 * x) := fun x hx => by
    rw [f0, hmaxc x hx, hc]; field_simp; ring
  have hconc : ConcaveOn ℝ (Set.Icc 0 (1 / N)) (f0 N) := by
    refine ⟨convex_Icc 0 (1 / N), fun u hu v hv a b ha hb hab => ?_⟩
    rw [← hc] at hu hv
    simp only [smul_eq_mul]
    have hw : a * u + b * v ≤ c := by nlinarith [hu.2, hv.2]
    rw [hf0c u hu.2, hf0c v hv.2, hf0c _ hw]
    have hb' : b = 1 - a := by linarith
    subst hb'
    have e : (a * u + (1 - a) * v) * (1 - (a * u + (1 - a) * v)) * (2 * c - 2 * (a * u + (1 - a) * v))
        - (a * (u * (1 - u) * (2 * c - 2 * u)) + (1 - a) * (v * (1 - v) * (2 * c - 2 * v)))
        = a * (1 - a) * (u - v) ^ 2 * (2 + 2 * c - 2 * (a * u - a * v + u + 2 * v)) := by ring
    have hbr : 0 ≤ 2 + 2 * c - 2 * (a * u - a * v + u + 2 * v) := by nlinarith [hu.1, hv.1, hu.2, hv.2]
    have : 0 ≤ a * (1 - a) * (u - v) ^ 2 * (2 + 2 * c - 2 * (a * u - a * v + u + 2 * v)) :=
      mul_nonneg (mul_nonneg (mul_nonneg ha hb) (sq_nonneg _)) hbr
    linarith
  -- the two-value inequality
  have hf0cc : f0 N c = 0 := by rw [hf0c c le_rfl]; ring
  have htwo : ∀ x ∈ Set.Icc (1 / N) 1, f0 N x + (N - 1) * f0 N ((1 - x) / (N - 1)) ≤ N * f0 N (1 / N) := by
    intro x hx
    rw [← hc] at hx ⊢
    rw [hf0cc, mul_zero]
    set y := (1 - x) / (N - 1) with hy
    have hy0 : 0 ≤ y := div_nonneg (by linarith [hx.2]) hN1.le
    have hyc : y ≤ c := by
      rw [hy, div_le_iff₀ hN1]
      have : (N - 1) * c = 1 - c := by rw [sub_mul, hNc, one_mul]
      linarith [hx.1]
    rw [hf0c y hyc]
    rcases le_or_gt x (1 / 2) with hx2 | hx2
    · have hxm : max 0 (1 - 2 * x) = 1 - 2 * x := max_eq_right (by linarith)
      rw [f0, hxm]
      have e : x * (1 - x) * ((2 - N) / N + (1 - 2 * x)) + (N - 1) * (y * (1 - y) * (2 * c - 2 * y))
          = -2 * (x - c) ^ 2 * ((1 - c - x) + (1 - c - y) / (N - 1)) := by
        rw [hy, hc]; exact id_r0_small N x hN0.ne' hN1.ne'
      rw [e]
      have : 0 ≤ (1 - c - x) + (1 - c - y) / (N - 1) :=
        add_nonneg (by linarith) (div_nonneg (by linarith) hN1.le)
      nlinarith [sq_nonneg (x - c)]
    · have hxm : max 0 (1 - 2 * x) = 0 := max_eq_left (by linarith)
      rw [f0, hxm]
      have e : x * (1 - x) * ((2 - N) / N + 0) + (N - 1) * (y * (1 - y) * (2 * c - 2 * y))
          = (1 - x) * (2 * N * x ^ 2 - N * (N - 3) ^ 2 * x - 2 * (N - 2)) / (N * (N - 1) ^ 2) := by
        rw [hy, hc]; exact id_r0_big N x hN0.ne' hN1.ne'
      rw [e]
      apply div_nonpos_of_nonpos_of_nonneg _ (by positivity)
      have hG : 2 * N * x ^ 2 - N * (N - 3) ^ 2 * x - 2 * (N - 2) ≤ 0 := by
        have e2 : 2 * N * x ^ 2 - N * (N - 3) ^ 2 * x - 2 * (N - 2)
            = (2 - 2 * x) * ((-N * (N - 3) ^ 2 - 3 * N + 8) / 2) + (2 * x - 1) * (4 - N * (N - 3) ^ 2)
              + 2 * N * ((x - 1 / 2) * (x - 1)) := by ring
        rw [e2]
        have g1 : (-N * (N - 3) ^ 2 - 3 * N + 8) / 2 ≤ 0 := by nlinarith
        have g2 : 4 - N * (N - 3) ^ 2 ≤ 0 := by nlinarith
        have g3 : (x - 1 / 2) * (x - 1) ≤ 0 := mul_nonpos_of_nonneg_of_nonpos (by linarith) (by linarith [hx.2])
        have k1 := mul_nonpos_of_nonneg_of_nonpos (by linarith [hx.2] : (0:ℝ) ≤ 2 - 2 * x) g1
        have k2 := mul_nonpos_of_nonneg_of_nonpos (by linarith [hx2] : (0:ℝ) ≤ 2 * x - 1) g2
        have k3 := mul_nonpos_of_nonneg_of_nonpos (by linarith : (0:ℝ) ≤ 2 * N) g3
        linarith
      exact mul_nonpos_of_nonneg_of_nonpos (by linarith [hx.2]) hG
  have hsum := left_concave n (by omega) (f0 N) hconc htwo q hq hs
  rw [← hNdef, ← hc, hf0cc, mul_zero] at hsum
  -- assemble
  have hrhs : slope n 0 * (1 - ∑ j, q j ^ 2) = ∑ j, 2 * (N - 1) / N * (q j * (1 - q j)) := by
    rw [hsl, ← Finset.mul_sum]
    congr 1
    have : ∑ j, q j * (1 - q j) = ∑ j, q j - ∑ j, q j ^ 2 := by
      rw [← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun j _ => by ring
    rw [this, hs]
  rw [hrhs]
  have := Finset.sum_le_sum fun j (_ : j ∈ Finset.univ) => hper j
  rw [Finset.sum_sub_distrib] at this
  linarith

set_option maxHeartbeats 1000000 in
-- `field_simp` and `ring` on rational identities of degree about ten in `N` exceed the default budget.
/-- **R½**, the row chord at `π = ½`, for `n ≥ 6`. -/
theorem Rhalf (n : ℕ) (hn : 6 ≤ n) (q γ : Fin n → ℝ) (hq : ∀ j, 0 ≤ q j) (hs : ∑ j, q j = 1)
    (hγ : ∀ j, 0 ≤ γ j ∧ γ j ≤ 1) :
    ∑ j, (q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) + kap n * (1 / 2) * q j ^ 2 * (1 - γ j ^ 2))
      ≤ kap n * (1 / 2) + slope n (1 / 2) * (1 - ∑ j, q j ^ 2) := by
  set N : ℝ := (n : ℝ) with hNdef
  have hN : (6 : ℝ) ≤ N := by rw [hNdef]; exact_mod_cast hn
  have hN0 : (0 : ℝ) < N := by linarith
  have hN1 : (0 : ℝ) < N - 1 := by linarith
  obtain ⟨t, rfl⟩ : ∃ t, n = t + 6 := ⟨n - 6, by omega⟩
  have hNt : N = (t : ℝ) + 6 := by rw [hNdef]; push_cast; ring
  set c : ℝ := 1 / N with hc
  have hc0 : 0 < c := by positivity
  have hc6 : c ≤ 1 / 6 := by rw [hc]; exact div_le_div_of_nonneg_left (by norm_num) (by norm_num) hN
  have hNc : N * c = 1 := by rw [hc]; field_simp
  have hq1 : ∀ j, q j ≤ 1 := fun j => by
    have := Finset.single_le_sum (fun k _ => hq k) (Finset.mem_univ j); linarith
  have hKt : kap N * (1 / 2) = Kt N := by simp only [kap, Kt]; ring
  have hsh : slope N (1 / 2) = sh N := by simp only [slope, sh, kap]; field_simp; ring
  have hKt0 : 0 < Kt N := by simp only [Kt]; positivity
  have hKt1 : Kt N < 1 := by
    simp only [Kt]; rw [div_lt_one (by positivity)]; nlinarith
  have hsh1 : sh N ≤ 1 := by
    simp only [sh]; rw [div_le_one (by positivity)]; nlinarith
  -- per entry
  have hper : ∀ j, q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) + Kt N * q j ^ 2 * (1 - γ j ^ 2)
      - Kt N * q j - sh N * (q j * (1 - q j)) ≤ fh N (q j) := by
    intro j
    set x := q j with hx
    set g := γ j with hg
    have hx0 : 0 ≤ x := hq j
    have hx1 : x ≤ 1 := hq1 j
    have hg0 : 0 ≤ g := (hγ j).1
    have hg1 : g ≤ 1 := (hγ j).2
    have e : x * (1 - x) * (1 + g * (1 - 2 * x)) + Kt N * x ^ 2 * (1 - g ^ 2) - Kt N * x - sh N * (x * (1 - x))
        = x * (1 - x) * (g * (1 - 2 * x) + Ah N) - Kt N * g ^ 2 * x ^ 2 := by simp only [Ah]; ring
    rw [e]
    unfold fh
    split_ifs with h1 h2
    · -- light: γ = 1 is best
      have hlight : Kt N * x * (1 + g) ≤ (1 - x) * (1 - 2 * x) := by
        have a1 : Kt N * x * (1 + g) ≤ 2 * x := by nlinarith [mul_nonneg hx0 hg0, mul_nonneg hKt0.le hx0]
        have a2 : 2 * x ≤ (1 - x) * (1 - 2 * x) := by
          nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ 7 / 32 - x) (by linarith : (0:ℝ) ≤ 73 / 16 - 2 * x)]
        linarith
      have e2 : psiL N x - (x * (1 - x) * (g * (1 - 2 * x) + Ah N) - Kt N * g ^ 2 * x ^ 2)
          = (1 - g) * x * ((1 - x) * (1 - 2 * x) - Kt N * x * (1 + g)) := by simp only [psiL]; ring
      have : 0 ≤ (1 - g) * x * ((1 - x) * (1 - 2 * x) - Kt N * x * (1 + g)) :=
        mul_nonneg (mul_nonneg (by linarith) hx0) (by linarith)
      linarith
    · -- the unconstrained maximum
      have hxp : 0 < x := by linarith
      have e2 : psih N x - (x * (1 - x) * (g * (1 - 2 * x) + Ah N) - Kt N * g ^ 2 * x ^ 2)
          = (x * (1 - x) * (1 - 2 * x) - 2 * Kt N * x ^ 2 * g) ^ 2 / (4 * Kt N * x ^ 2) := by
        simp only [psih]; exact id_psih_gap (Kt N) (Ah N) x g hKt0.ne' hxp.ne'
      have : 0 ≤ (x * (1 - x) * (1 - 2 * x) - 2 * Kt N * x ^ 2 * g) ^ 2 / (4 * Kt N * x ^ 2) := by positivity
      linarith
    · -- x > ½: γ = 0 is best
      have : 0 ≤ -(g * (x * (1 - x) * (1 - 2 * x))) + Kt N * g ^ 2 * x ^ 2 := by
        have : x * (1 - x) * (1 - 2 * x) ≤ 0 :=
          mul_nonpos_of_nonneg_of_nonpos (mul_nonneg hx0 (by linarith)) (by linarith)
        nlinarith [mul_nonneg hg0 (sq_nonneg x), mul_nonneg hKt0.le (mul_nonneg (sq_nonneg g) (sq_nonneg x))]
      nlinarith
  -- fh is psiL on [0, c], and psiL is concave there
  have hfhL : ∀ x, x ≤ 7 / 32 → fh N x = psiL N x := fun x hx => by simp [fh, hx]
  have hconc : ConcaveOn ℝ (Set.Icc 0 (1 / N)) (fh N) := by
    refine ⟨convex_Icc 0 (1 / N), fun u hu v hv a b ha hb hab => ?_⟩
    rw [← hc] at hu hv
    simp only [smul_eq_mul]
    have hw : a * u + b * v ≤ c := by nlinarith [hu.2, hv.2]
    rw [hfhL u (by linarith [hu.2]), hfhL v (by linarith [hv.2]), hfhL _ (by linarith)]
    have hb' : b = 1 - a := by linarith
    subst hb'
    have e : psiL N (a * u + (1 - a) * v) - (a * psiL N u + (1 - a) * psiL N v)
        = a * (1 - a) * (u - v) ^ 2 * ((3 + Ah N + Kt N) - 2 * (a * u - a * v + u + 2 * v)) := by
      simp only [psiL]; ring
    have hA : 3 + Ah N + Kt N = 4 - sh N := by simp only [Ah]; ring
    have hbr : 0 ≤ (3 + Ah N + Kt N) - 2 * (a * u - a * v + u + 2 * v) := by
      rw [hA]; nlinarith [hu.1, hv.1, hu.2, hv.2]
    have : 0 ≤ a * (1 - a) * (u - v) ^ 2 * ((3 + Ah N + Kt N) - 2 * (a * u - a * v + u + 2 * v)) :=
      mul_nonneg (mul_nonneg (mul_nonneg ha hb) (sq_nonneg _)) hbr
    linarith
  -- the two-value inequality
  have hpsiLc : psiL N c = 0 := by rw [hc]; exact id_psiLc N hN0.ne'
  have hfhc : fh N c = 0 := by rw [hfhL c (by linarith), hpsiLc]
  have htwo : ∀ x ∈ Set.Icc (1 / N) 1, fh N x + (N - 1) * fh N ((1 - x) / (N - 1)) ≤ N * fh N (1 / N) := by
    intro x hx
    rw [← hc] at hx ⊢
    rw [hfhc, mul_zero]
    set y := (1 - x) / (N - 1) with hy
    have hy0 : 0 ≤ y := div_nonneg (by linarith [hx.2]) hN1.le
    have hyc : y ≤ c := by
      rw [hy, div_le_iff₀ hN1]
      have : (N - 1) * c = 1 - c := by rw [sub_mul, hNc, one_mul]
      linarith [hx.1]
    rw [hfhL y (by linarith)]
    unfold fh
    split_ifs with h1 h2
    · set r : ℝ := (3 * N + 1) * (N - 1) / (2 * N ^ 2) with hr
      have hr1 : 1 < r := by rw [hr, lt_div_iff₀ (by positivity)]; nlinarith
      have e : psiL N x + (N - 1) * psiL N y = 2 * (x - c) ^ 2 * ((x - r) + (y - r) / (N - 1)) := by
        rw [hy, hc, hr]; exact id_i N x hN0.ne' hN1.ne'
      rw [e]
      have : (x - r) + (y - r) / (N - 1) ≤ 0 := by
        have : (y - r) / (N - 1) ≤ 0 := div_nonpos_of_nonpos_of_nonneg (by linarith) hN1.le
        linarith [hx.2]
      nlinarith [sq_nonneg (x - c)]
    · have e : psih N x + (N - 1) * psiL N y
          = (x - 1) * (4*N^6*x^3-8*N^6*x^2+9*N^6*x-N^6-28*N^5*x-8*N^4*x^2+16*N^4*x+12*N^4-8*N^3*x^2+52*N^3*x-8*N^3-8*N^2*x-24*N^2-8*N*x+4*x+4)
            / (4 * N ^ 3 * (N - 1) ^ 2 * (N + 1)) := by
        rw [hy]; exact id_ii N x hN0.ne' hN1.ne' (by linarith)
      rw [e]
      have hL := L2_nonneg t x (by linarith) h2
      simp only at hL
      rw [← hNt] at hL
      apply div_nonpos_of_nonpos_of_nonneg _ (by positivity)
      exact mul_nonpos_of_nonpos_of_nonneg (by linarith [hx.2]) hL
    · have e : x * (1 - x) * Ah N + (N - 1) * psiL N y
          = (1 - x) * (2*N^3*x^2+(-N^5+8*N^4-12*N^3-N^2+3*N-1)*x-3*N^3+5*N^2+N-1) / (N ^ 3 * (N - 1) ^ 2) := by
        rw [hy]; exact id_iii N x hN0.ne' hN1.ne'
      rw [e]
      have hL := L1_nonpos t x (by linarith) hx.2
      simp only at hL
      rw [← hNt] at hL
      apply div_nonpos_of_nonpos_of_nonneg _ (by positivity)
      exact mul_nonpos_of_nonneg_of_nonpos (by linarith [hx.2]) hL
  have hsum := left_concave (t + 6) (by omega) (fh N) hconc htwo q hq hs
  rw [← hNdef, ← hc, hfhc, mul_zero] at hsum
  -- assemble
  rw [hKt, hsh]
  have hrhs : Kt N + sh N * (1 - ∑ j, q j ^ 2) = ∑ j, (Kt N * q j + sh N * (q j * (1 - q j))) := by
    rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum, hs, mul_one]
    have : ∑ j, q j * (1 - q j) = ∑ j, q j - ∑ j, q j ^ 2 := by
      rw [← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun j _ => by ring
    rw [this, hs]
  rw [hrhs]
  have hle := Finset.sum_le_sum fun j (_ : j ∈ Finset.univ) => hper j
  have e3 : ∑ j, (q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) + Kt N * q j ^ 2 * (1 - γ j ^ 2) - Kt N * q j
      - sh N * (q j * (1 - q j))) = ∑ j, (q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) + Kt N * q j ^ 2 * (1 - γ j ^ 2))
        - ∑ j, (Kt N * q j + sh N * (q j * (1 - q j))) := by
    rw [← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun j _ => by ring
  rw [e3] at hle
  linarith


/-- The tangent line of the concave `φ(x) = (s − x²)/(1 − c x)` at `x = s`, as a pointwise bound. -/
theorem tangent_phi (c s x : ℝ) (hx : c * x < 1) (hs : c * s < 1) (hcs : c ^ 2 * s ≤ 1) :
    (s - x ^ 2) / (1 - c * x) ≤ (s - s ^ 2) / (1 - c * s) + (-2 * s + c * s + c * s ^ 2) / (1 - c * s) ^ 2 * (x - s) := by
  have h1 : 0 < 1 - c * x := by linarith
  have h2 : 0 < 1 - c * s := by linarith
  set e1 := (s - s ^ 2) / (1 - c * s) with he1
  set e2 := (-2 * s + c * s + c * s ^ 2) / (1 - c * s) ^ 2 with he2
  have k1 : e1 * (1 - c * s) = s - s ^ 2 := div_mul_cancel₀ _ h2.ne'
  have k2 : e2 * (1 - c * s) ^ 2 = -2 * s + c * s + c * s ^ 2 := div_mul_cancel₀ _ (pow_ne_zero _ h2.ne')
  have hkey : (1 - c * s) ^ 2 * ((e1 + e2 * (x - s)) * (1 - c * x) - (s - x ^ 2)) = (1 - c ^ 2 * s) * (x - s) ^ 2 := by
    calc (1 - c * s) ^ 2 * ((e1 + e2 * (x - s)) * (1 - c * x) - (s - x ^ 2))
        = (e1 * (1 - c * s)) * (1 - c * s) * (1 - c * x) + (e2 * (1 - c * s) ^ 2) * (x - s) * (1 - c * x)
          - (s - x ^ 2) * (1 - c * s) ^ 2 := by ring
      _ = (s - s ^ 2) * (1 - c * s) * (1 - c * x) + (-2 * s + c * s + c * s ^ 2) * (x - s) * (1 - c * x)
          - (s - x ^ 2) * (1 - c * s) ^ 2 := by rw [k1, k2]
      _ = (1 - c ^ 2 * s) * (x - s) ^ 2 := by ring
  have hbr : 0 ≤ (e1 + e2 * (x - s)) * (1 - c * x) - (s - x ^ 2) := by
    by_contra h
    push Not at h
    have : (1 - c * s) ^ 2 * ((e1 + e2 * (x - s)) * (1 - c * x) - (s - x ^ 2)) < 0 := mul_neg_of_pos_of_neg (by positivity) h
    nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ 1 - c ^ 2 * s) (sq_nonneg (x - s))]
  rw [div_le_iff₀ h1]; linarith

theorem Hc (n : ℕ) (hn : 3 ≤ n) (p : Fin (n + 1) → ℝ) (h0 : ∀ i, 0 ≤ p i) (h1 : ∀ i, p i ≤ 1 / 2)
    (hs : ∑ i, p i = 1) :
    (1 + ((n : ℝ) + 1) * ((n : ℝ) - 2) * ∑ i, p i ^ 2) / (n : ℝ) ^ 2
      ≤ ∑ j, p j ^ 2 / (∑ i, p i / (1 - ((n : ℝ) + 1) / n * p i) - p j / (1 - ((n : ℝ) + 1) / n * p j)) := by
  have hN : (3 : ℝ) ≤ n := by exact_mod_cast hn
  have hN0 : (0 : ℝ) < n := by linarith
  set c : ℝ := ((n : ℝ) + 1) / n with hc
  set g : Fin (n + 1) → ℝ := fun i => p i / (1 - c * p i) with hg
  set B : ℝ := ∑ i, g i with hB
  set s : ℝ := ∑ i, p i ^ 2 with hsdef
  change (1 + ((n : ℝ) + 1) * ((n : ℝ) - 2) * s) / (n : ℝ) ^ 2 ≤ ∑ j, p j ^ 2 / (B - g j)
  have hc1 : c * (1 / 2) < 1 := by rw [hc, div_mul_eq_mul_div, div_lt_one hN0]; linarith
  have hc0 : 0 < c := by positivity
  have hcp : ∀ i, c * p i < 1 := fun i => lt_of_le_of_lt (mul_le_mul_of_nonneg_left (h1 i) hc0.le) hc1
  have hden : ∀ i, 0 < 1 - c * p i := fun i => by linarith [hcp i]
  have hgp : ∀ i, p i ≤ g i := fun i => by
    rw [hg, le_div_iff₀ (hden i)]; nlinarith [h0 i, hcp i, mul_nonneg hc0.le (h0 i)]
  have hg0 : ∀ i, 0 ≤ g i := fun i => le_trans (h0 i) (hgp i)
  -- the range of s
  have hs1 : s ≤ 1 / 2 := by
    have : ∀ i, p i ^ 2 ≤ p i / 2 := fun i => by nlinarith [h0 i, h1 i]
    calc s ≤ ∑ i, p i / 2 := Finset.sum_le_sum fun i _ => this i
      _ = 1 / 2 := by rw [← Finset.sum_div, hs]
  have hs0 : 1 ≤ ((n : ℝ) + 1) * s := by
    have := sq_sum_le_card_mul_sum_sq (s := Finset.univ) (f := p)
    rw [hs, Finset.card_univ, Fintype.card_fin] at this
    push_cast at this; linarith
  have hspos : 0 < s := by
    by_contra h; push Not at h; nlinarith
  have hcs : c * s < 1 := lt_of_le_of_lt (mul_le_mul_of_nonneg_left hs1 hc0.le) hc1
  have hc2s : c ^ 2 * s ≤ 1 := by
    have : c ^ 2 * (1 / 2) ≤ 1 := by
      rw [hc, div_pow, div_mul_eq_mul_div, div_le_one (by positivity)]; nlinarith
    nlinarith [sq_nonneg c]
  -- every denominator is at least 1/2
  have hBg : ∀ j, 1 / 2 ≤ B - g j := fun j => by
    have e : B - g j = ∑ i ∈ Finset.univ.erase j, g i := by
      have := Finset.add_sum_erase Finset.univ g (Finset.mem_univ j); rw [hB]; linarith
    have e2 : ∑ i ∈ Finset.univ.erase j, p i = 1 - p j := by
      have := Finset.add_sum_erase Finset.univ p (Finset.mem_univ j); linarith
    rw [e]
    have := Finset.sum_le_sum (s := Finset.univ.erase j) fun i _ => hgp i
    linarith [h1 j]
  -- U = Σ p_j²(B − g_j) = Σ_i p_i φ(p_i)
  set U : ℝ := ∑ j, p j ^ 2 * (B - g j) with hU
  have hUeq : U = ∑ i, p i * ((s - p i ^ 2) / (1 - c * p i)) := by
    have e1 : U = s * B - ∑ i, p i ^ 2 * g i := by
      rw [hU, hsdef, hB, Finset.sum_mul, ← Finset.sum_sub_distrib]
      exact Finset.sum_congr rfl fun i _ => by ring
    rw [e1, hB, Finset.mul_sum, ← Finset.sum_sub_distrib]
    exact Finset.sum_congr rfl fun i _ => by rw [hg]; field_simp [(hden i).ne']
  have hUle : U ≤ (s - s ^ 2) / (1 - c * s) := by
    set D : ℝ := (-2 * s + c * s + c * s ^ 2) / (1 - c * s) ^ 2
    have hpt : ∀ i, p i * ((s - p i ^ 2) / (1 - c * p i)) ≤ p i * ((s - s ^ 2) / (1 - c * s) + D * (p i - s)) :=
      fun i => mul_le_mul_of_nonneg_left (tangent_phi c s (p i) (hcp i) hcs hc2s) (h0 i)
    rw [hUeq]
    calc _ ≤ ∑ i, p i * ((s - s ^ 2) / (1 - c * s) + D * (p i - s)) := Finset.sum_le_sum fun i _ => hpt i
      _ = (s - s ^ 2) / (1 - c * s) * ∑ i, p i + D * ∑ i, p i ^ 2 - D * s * ∑ i, p i := by
          have e : ∀ i, p i * ((s - s ^ 2) / (1 - c * s) + D * (p i - s))
              = (s - s ^ 2) / (1 - c * s) * p i + D * p i ^ 2 - D * s * p i := fun i => by ring
          rw [Finset.sum_congr rfl fun i _ => e i, Finset.sum_sub_distrib, Finset.sum_add_distrib,
            ← Finset.mul_sum, ← Finset.mul_sum, ← Finset.mul_sum]
      _ = _ := by rw [hs, ← hsdef]; ring
  have hUpos : 0 < U := by
    have : ∀ j, p j ^ 2 * (1 / 2) ≤ p j ^ 2 * (B - g j) := fun j => mul_le_mul_of_nonneg_left (hBg j) (sq_nonneg _)
    have := Finset.sum_le_sum fun j (_ : j ∈ Finset.univ) => this j
    rw [← Finset.sum_mul, ← hsdef] at this; linarith
  -- Titu over the support
  set T := Finset.univ.filter (fun j => 0 < p j) with hT
  have hTpos : ∀ j ∈ T, 0 < p j ^ 2 * (B - g j) := fun j hj => by
    simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hj
    exact mul_pos (pow_pos hj 2) (by linarith [hBg j])
  have htitu := sq_sum_div_le_sum_sq_div T (fun j => p j ^ 2) hTpos
  have hsT : ∑ j ∈ T, p j ^ 2 = s := by
    rw [hsdef, hT, Finset.sum_filter]
    exact Finset.sum_congr rfl fun j _ => by
      split_ifs with h
      · rfl
      · have : p j = 0 := le_antisymm (not_lt.1 h) (h0 j)
        rw [this]; ring
  have hUT : ∑ j ∈ T, p j ^ 2 * (B - g j) = U := by
    rw [hU, hT, Finset.sum_filter]
    exact Finset.sum_congr rfl fun j _ => by
      split_ifs with h
      · rfl
      · have : p j = 0 := le_antisymm (not_lt.1 h) (h0 j)
        rw [this]; ring
  have hterm : ∑ j ∈ T, (p j ^ 2) ^ 2 / (p j ^ 2 * (B - g j)) ≤ ∑ j, p j ^ 2 / (B - g j) := by
    calc ∑ j ∈ T, (p j ^ 2) ^ 2 / (p j ^ 2 * (B - g j)) = ∑ j ∈ T, p j ^ 2 / (B - g j) :=
          Finset.sum_congr rfl fun j hj => by
            simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hj
            have : 0 < B - g j := by linarith [hBg j]
            field_simp
      _ ≤ _ := Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _)
          fun j _ _ => div_nonneg (sq_nonneg _) (by linarith [hBg j])
  rw [hsT, hUT] at htitu
  -- s²/U ≥ s(1 − cs)/(1 − s) ≥ target
  have h1s : 0 < 1 - s := by linarith
  have h1cs : 0 < 1 - c * s := by linarith
  have hstep : s * (1 - c * s) / (1 - s) ≤ s ^ 2 / U := by
    rw [div_le_div_iff₀ h1s hUpos]
    have := mul_le_mul_of_nonneg_left hUle (by positivity : 0 ≤ s * (1 - c * s))
    have e : s * (1 - c * s) * ((s - s ^ 2) / (1 - c * s)) = s ^ 2 * (1 - s) := by
      rw [mul_div_assoc', div_eq_iff h1cs.ne']; ring
    nlinarith
  have hfin : (1 + ((n : ℝ) + 1) * ((n : ℝ) - 2) * s) / (n : ℝ) ^ 2 ≤ s * (1 - c * s) / (1 - s) := by
    rw [div_le_div_iff₀ (by positivity) h1s, hc]
    have e : s * (1 - ((n : ℝ) + 1) / n * s) * (n : ℝ) ^ 2 - (1 + ((n : ℝ) + 1) * ((n : ℝ) - 2) * s) * (1 - s)
        = (1 - 2 * s) * (((n : ℝ) + 1) * s - 1) := by field_simp; ring
    nlinarith [mul_nonneg (by linarith : (0:ℝ) ≤ 1 - 2 * s) (by linarith : (0:ℝ) ≤ ((n : ℝ) + 1) * s - 1)]
  linarith


/-- **The row chord (R)** for `n ≥ 6` and `π ∈ [0, ½]`: the affine combination of `R0` and `Rhalf`. -/
theorem row_chord (n : ℕ) (hn : 6 ≤ n) (p : ℝ) (hp0 : 0 ≤ p) (hp1 : p ≤ 1 / 2) (q γ : Fin n → ℝ)
    (hq : ∀ j, 0 ≤ q j) (hs : ∑ j, q j = 1) (hγ : ∀ j, 0 ≤ γ j ∧ γ j ≤ 1) :
    ∑ j, (q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) + kap n * p * q j ^ 2 * (1 - γ j ^ 2))
      ≤ kap n * p + slope n p * (1 - ∑ j, q j ^ 2) := by
  have h0 := R0 n hn q γ hq hs hγ
  have hh := Rhalf n hn q γ hq hs hγ
  set S0 := ∑ j, q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) with hS0
  set S1 := ∑ j, kap n * q j ^ 2 * (1 - γ j ^ 2) with hS1
  set ρ := ∑ j, q j ^ 2 with hρ
  have eL : ∀ r : ℝ, ∑ j, (q j * (1 - q j) * (1 + γ j * (1 - 2 * q j)) + kap n * r * q j ^ 2 * (1 - γ j ^ 2)) = S0 + r * S1 := by
    intro r
    rw [Finset.sum_add_distrib, hS1, Finset.mul_sum]
    congr 1; exact Finset.sum_congr rfl fun j _ => by ring
  rw [eL] at hh ⊢
  have hsl : slope n p = (1 - 2 * p) * slope n 0 + 2 * p * slope n (1 / 2) := by simp only [slope]; ring
  rw [hsl]
  have hN1 : (0 : ℝ) ≤ 1 - ρ := by
    have : ∀ j, q j ^ 2 ≤ q j := fun j => by
      have := Finset.single_le_sum (fun k _ => hq k) (Finset.mem_univ j); nlinarith [hq j]
    have := Finset.sum_le_sum fun j (_ : j ∈ Finset.univ) => this j
    rw [hs] at this; linarith
  nlinarith [mul_le_mul_of_nonneg_left h0 (by linarith : (0:ℝ) ≤ 1 - 2 * p),
    mul_le_mul_of_nonneg_left hh (by linarith : (0:ℝ) ≤ 2 * p)]

set_option maxHeartbeats 2000000 in
-- `field_simp` and `ring` on rational identities of degree about ten in `N` exceed the default budget.
/-- **MW'** for `m = n + 1 ≥ 7`, with `γ` explicit per ordered pair. -/
theorem MWprime (n : ℕ) (hn : 6 ≤ n) (w : Fin (n + 1) → Fin (n + 1) → ℝ) (hw0 : ∀ i j, 0 ≤ w i j)
    (hsym : ∀ i j, w i j = w j i) (hdiag : ∀ i, w i i = 0) (hS : ∑ i, ∑ j, w i j = 1)
    (γ : Fin (n + 1) → Fin (n + 1) → ℝ) (hγ : ∀ i j, 0 ≤ γ i j ∧ γ i j ≤ 1) :
    ∑ i, ∑ j, (w i j * (1 - w i j / ∑ k, w i k) * (1 + γ i j * (1 - 2 * (w i j / ∑ k, w i k)))
        + kap n * w i j ^ 2 * (1 - γ i j ^ 2))
      ≤ kap n * (1 - ∑ i, (∑ k, w i k) ^ 2) := by
  set N : ℝ := (n : ℝ) with hNdef
  have hN : (6 : ℝ) ≤ N := by rw [hNdef]; exact_mod_cast hn
  have hN0 : (0 : ℝ) < N := by linarith
  set P : Fin (n + 1) → ℝ := fun i => ∑ k, w i k with hP
  change ∑ i, ∑ j, (w i j * (1 - w i j / P i) * (1 + γ i j * (1 - 2 * (w i j / P i))) + kap N * w i j ^ 2 * (1 - γ i j ^ 2))
      ≤ kap N * (1 - ∑ i, P i ^ 2)
  have hP0 : ∀ i, 0 ≤ P i := fun i => Finset.sum_nonneg fun k _ => hw0 i k
  have hPsum : ∑ i, P i = 1 := hS
  have hwP : ∀ i j, w i j ≤ P j := fun i j => by
    rw [hsym i j]; exact Finset.single_le_sum (fun k _ => hw0 j k) (Finset.mem_univ i)
  have hwPi : ∀ i j, w i j ≤ P i := fun i j => Finset.single_le_sum (fun k _ => hw0 i k) (Finset.mem_univ j)
  have hPhalf : ∀ i, P i ≤ 1 / 2 := fun i => by
    have h1 : P i ≤ ∑ j, (P j - if j = i then P j else 0) := Finset.sum_le_sum fun j _ => by
      split_ifs with h
      · rw [h, hdiag]; simp
      · simpa using hwP i j
    rw [Finset.sum_sub_distrib, Finset.sum_ite_eq', if_pos (Finset.mem_univ _), hPsum] at h1
    linarith
  set c' : ℝ := (N + 1) / N with hc'
  set b0 : ℝ := 2 * (N - 1) / N with hb0
  have hb0p : 0 < b0 := by rw [hb0]; apply div_pos <;> linarith
  have hc'P : ∀ i, 0 < 1 - c' * P i := fun i => by
    have : c' * P i ≤ c' * (1 / 2) := mul_le_mul_of_nonneg_left (hPhalf i) (by positivity)
    have : c' * (1 / 2) < 1 := by rw [hc', div_mul_eq_mul_div, div_lt_one hN0]; linarith
    linarith
  set β : Fin (n + 1) → ℝ := fun i => slope N (P i) with hβ
  have hβe : ∀ i, β i = b0 * (1 - c' * P i) := fun i => by
    simp only [hβ, slope, kap, hb0, hc']; field_simp; try ring
  have hβp : ∀ i, 0 < β i := fun i => by rw [hβe]; exact mul_pos hb0p (hc'P i)
  -- (1) the row bound
  have hrow : ∀ i, ∑ j, (w i j * (1 - w i j / P i) * (1 + γ i j * (1 - 2 * (w i j / P i))) + kap N * w i j ^ 2 * (1 - γ i j ^ 2))
      ≤ P i * (kap N * P i + β i * (1 - ∑ j, (w i j / P i) ^ 2)) := by
    intro i
    by_cases hPi : P i = 0
    · have hw : ∀ j, w i j = 0 := fun j => le_antisymm (hPi ▸ hwPi i j) (hw0 i j)
      simp [hw, hPi]
    have hPpos : 0 < P i := lt_of_le_of_ne (hP0 i) (Ne.symm hPi)
    set qq : Fin (n + 1) → ℝ := fun j => w i j / P i with hqq
    have eterm : ∀ j, w i j * (1 - w i j / P i) * (1 + γ i j * (1 - 2 * (w i j / P i))) + kap N * w i j ^ 2 * (1 - γ i j ^ 2)
        = P i * (qq j * (1 - qq j) * (1 + γ i j * (1 - 2 * qq j)) + kap N * P i * qq j ^ 2 * (1 - γ i j ^ 2)) := fun j => by
      simp only [hqq]; field_simp; try ring
    rw [Finset.sum_congr rfl fun j _ => eterm j, ← Finset.mul_sum]
    apply mul_le_mul_of_nonneg_left _ (hP0 i)
    have hqi : qq i = 0 := by simp [hqq, hdiag]
    have hsplit : ∀ f : Fin (n + 1) → ℝ, ∑ j, f j = f i + ∑ k, f (i.succAbove k) := fun f => Fin.sum_univ_succAbove f i
    rw [hsplit (fun j => qq j * (1 - qq j) * (1 + γ i j * (1 - 2 * qq j)) + kap N * P i * qq j ^ 2 * (1 - γ i j ^ 2)),
      hsplit (fun j => qq j ^ 2)]
    simp only [hqi]
    have hsum1 : ∑ k, qq (i.succAbove k) = 1 := by
      have : ∑ j, qq j = 1 := by simp only [hqq]; rw [← Finset.sum_div]; exact div_self hPi
      rw [hsplit qq, hqi, zero_add] at this; exact this
    have := row_chord n hn (P i) (hP0 i) (hPhalf i) (fun k => qq (i.succAbove k)) (fun k => γ i (i.succAbove k))
      (fun k => div_nonneg (hw0 _ _) hPpos.le) hsum1 (fun k => hγ _ _)
    have e0 : (0 : ℝ) * (1 - 0) * (1 + γ i i * (1 - 2 * 0)) + kap N * P i * 0 ^ 2 * (1 - γ i i ^ 2) = 0 := by ring
    rw [e0, zero_add]
    have e1 : (0 : ℝ) ^ 2 = 0 := by ring
    rw [e1, zero_add]
    exact this
  -- sum the rows
  have hrows := Finset.sum_le_sum fun i (_ : i ∈ Finset.univ) => hrow i
  set s : ℝ := ∑ i, P i ^ 2 with hs
  set Q : ℝ := ∑ i, ∑ j, β i * w i j ^ 2 / P i with hQ
  have eRHS : ∑ i, P i * (kap N * P i + β i * (1 - ∑ j, (w i j / P i) ^ 2)) = kap N * s + ∑ i, P i * β i - Q := by
    have : ∀ i, P i * (kap N * P i + β i * (1 - ∑ j, (w i j / P i) ^ 2))
        = kap N * P i ^ 2 + P i * β i - ∑ j, β i * w i j ^ 2 / P i := fun i => by
      by_cases hPi : P i = 0
      · have hw : ∀ j, w i j = 0 := fun j => le_antisymm (hPi ▸ hwPi i j) (hw0 i j)
        simp [hw, hPi]
      have : P i * (β i * ∑ j, (w i j / P i) ^ 2) = ∑ j, β i * w i j ^ 2 / P i := by
        rw [Finset.mul_sum, Finset.mul_sum]; exact Finset.sum_congr rfl fun j _ => by field_simp; try ring
      rw [← this]; ring
    rw [Finset.sum_congr rfl fun i _ => this i, Finset.sum_sub_distrib, Finset.sum_add_distrib, ← Finset.mul_sum]
  -- (2) the weighted column Cauchy–Schwarz
  set g : Fin (n + 1) → ℝ := fun i => P i / (1 - c' * P i) with hg
  set B : ℝ := ∑ i, g i with hB
  have hPβ : ∀ i, P i / β i = g i / b0 := fun i => by
    rw [hβe, hg]; field_simp [(hc'P i).ne']
  have hcol : ∀ j, b0 * (P j ^ 2 / (B - g j)) ≤ ∑ i, β i * w i j ^ 2 / P i := by
    intro j
    have hR : 0 ≤ ∑ i, β i * w i j ^ 2 / P i := Finset.sum_nonneg fun i _ => div_nonneg (mul_nonneg (hβp i).le (sq_nonneg _)) (hP0 i)
    by_cases hPj : P j = 0
    · rw [hPj]; simpa using hR
    have hPjp : 0 < P j := lt_of_le_of_ne (hP0 j) (Ne.symm hPj)
    set T := Finset.univ.filter (fun i => i ≠ j ∧ 0 < P i) with hT
    have hTpos : ∀ i ∈ T, 0 < P i / β i := fun i hi => by
      simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hi; exact div_pos hi.2 (hβp i)
    have hTw : ∑ i ∈ T, w i j = P j := by
      have hcolsum : ∑ i, w i j = P j := by simp only [hP]; exact Finset.sum_congr rfl fun i _ => hsym i j
      rw [← hcolsum, hT, Finset.sum_filter]
      refine Finset.sum_congr rfl fun i _ => ?_
      split_ifs with h
      · rfl
      · push Not at h
        by_cases hij : i = j
        · rw [hij, hdiag]
        · have : P i = 0 := le_antisymm (h hij) (hP0 i)
          exact (le_antisymm (this ▸ hwPi i j) (hw0 i j)).symm
    have hTne : T.Nonempty := by
      by_contra hc; rw [Finset.not_nonempty_iff_eq_empty] at hc
      rw [hc, Finset.sum_empty] at hTw; exact hPj hTw.symm
    have hTg : ∑ i ∈ T, P i / β i ≤ (B - g j) / b0 := by
      have e : (B - g j) / b0 = ∑ i ∈ Finset.univ.erase j, P i / β i := by
        rw [Finset.sum_congr rfl fun i _ => hPβ i, ← Finset.sum_div]
        congr 1; rw [hB]; have := Finset.add_sum_erase Finset.univ g (Finset.mem_univ j); linarith
      rw [e]
      exact Finset.sum_le_sum_of_subset_of_nonneg (fun i hi => by
        simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hi
        exact Finset.mem_erase.2 ⟨hi.1, Finset.mem_univ _⟩)
        (fun i _ _ => div_nonneg (hP0 i) (hβp i).le)
    have hTg0 : 0 < ∑ i ∈ T, P i / β i := Finset.sum_pos hTpos hTne
    have htitu := sq_sum_div_le_sum_sq_div T (fun i => w i j) hTpos
    rw [hTw] at htitu
    have hsub : ∑ i ∈ T, w i j ^ 2 / (P i / β i) ≤ ∑ i, β i * w i j ^ 2 / P i := by
      calc ∑ i ∈ T, w i j ^ 2 / (P i / β i) = ∑ i ∈ T, β i * w i j ^ 2 / P i :=
            Finset.sum_congr rfl fun i hi => by
              simp only [hT, Finset.mem_filter, Finset.mem_univ, true_and] at hi
              field_simp [(hβp i).ne', hi.2.ne']
        _ ≤ _ := Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _)
            fun i _ _ => div_nonneg (mul_nonneg (hβp i).le (sq_nonneg _)) (hP0 i)
    have hBg : 0 < B - g j := by
      have : 0 < (B - g j) / b0 := lt_of_lt_of_le hTg0 hTg
      exact (div_pos_iff_of_pos_right hb0p).1 this
    calc b0 * (P j ^ 2 / (B - g j)) = P j ^ 2 / ((B - g j) / b0) := by field_simp
      _ ≤ P j ^ 2 / ∑ i ∈ T, P i / β i := div_le_div_of_nonneg_left (sq_nonneg _) hTg0 hTg
      _ ≤ _ := le_trans htitu hsub
  have hQge : b0 * ∑ j, P j ^ 2 / (B - g j) ≤ Q := by
    rw [hQ, Finset.sum_comm, Finset.mul_sum]; exact Finset.sum_le_sum fun j _ => hcol j
  -- (3) H_c
  have hHc := Hc n (by omega) P hP0 hPhalf hPsum
  change (1 + (N + 1) * (N - 2) * s) / N ^ 2 ≤ ∑ j, P j ^ 2 / (B - g j) at hHc
  -- assemble
  have hPβsum : ∑ i, P i * β i = b0 * (1 - c' * s) := by
    rw [Finset.sum_congr rfl fun i _ => by rw [hβe i], hs]
    rw [show (∑ i, P i * (b0 * (1 - c' * P i))) = b0 * (∑ i, P i) - b0 * c' * ∑ i, P i ^ 2 by
      rw [Finset.mul_sum, Finset.mul_sum, ← Finset.sum_sub_distrib]; exact Finset.sum_congr rfl fun i _ => by ring]
    rw [hPsum]; ring
  have hfin : kap N * s + b0 * (1 - c' * s) - b0 * ((1 + (N + 1) * (N - 2) * s) / N ^ 2) = kap N * (1 - s) := by
    simp only [kap, hb0, hc']; field_simp; ring
  have hHc' := mul_le_mul_of_nonneg_left hHc hb0p.le
  rw [eRHS] at hrows
  linarith

end HamiltonsCubic.MWPrime
