import Mathlib
import HamiltonsCubic.Results.L42Statement

set_option linter.style.longLine false

/-!
# L49, the collapse space, and its dimension

## The record's statement, quoted verbatim from [target.md](../../../findings/target.md)

> Say that $T$ **collapses** when a single $c$ gives $\theta=c\sum_\alpha\lambda_\alpha^3$ for **every**
> spectrum $\lambda$ with $\sum_\alpha\lambda_\alpha=0$, $T$ held fixed. The condition is linear in
> $T$, so the collapsing $T$ form a subspace, and **it is exactly the $T$ constant on distinct
> triples, at every $N\ge3$**.

The block carries as open, and this file does not type: the count of trace conditions against the
irreducible summands under $SO(n)$, non-realisation of constant $T$ by $\mathfrak{so}(n)$, and
whether the cubic is spectral at a critical point.

## What is typed here

* `thetaOf`, the record's eigenframe display `θ = ∑λ³ + 3∑_{α<β<γ} T λ_α λ_β λ_γ`, as a
  definition, so that the collapse condition is stated against it rather than against a surrogate.
* `Collapses`, **the condition with the quantifier the Gate 2 verdict says is load-bearing**:
  `∃ c, ∀ λ` obeying the single trace condition `∑ λ = 0`, `θ(λ) = c ∑ λ³`. *The quantifier over
  `λ` is inside, so this is "collapses on the whole trace-condition subspace"; the same condition
  at one fixed `λ` constrains nothing wherever `∑λ³ ≠ 0`, since `c` is free.*
* `collapse_space_is_the_constants`, **the lemma: the collapse space is exactly the constant
  tensors, hence one-dimensional.** Proved, with no `sorry`.
* `collapse_is_linear_in_T`, the record's "the condition is *linear in `T`*": `Collapses` is
  closed under sums and scalar multiples, which is what makes the collapsing configurations a
  subspace. Proved.
* `zero_collapses`, the collapse space is nonempty, so nothing above is vacuous. Proved.

## The proof

**Both directions are elementary, and neither needs multivariate polynomial machinery.**

* **Collapse forces a constant.** `spike i j k` is the trace-free spectrum `e_i + e_j - 2e_k`.
  Only the triple `(i, j, k)` survives in the cubic sum (`spike_triple`), `∑λ³ = -6`
  (`spike_cube`), so the collapse condition reads `-6 - 6 T_{ijk} = -6c` and forces
  `T_{ijk} = c - 1` on every increasing triple. *This reaches every `N ≥ 3`.*
* **A constant collapses.** On `∑λ = 0`, `3 e₃ = p₃` (`three_e3`): the ordered sum over distinct
  triples is `6 e₃` ([L42Statement.lean](L42Statement.lean)'s `distinctSum_eq_six`), and
  inclusion-exclusion on the coincidences writes it as `p₁³ - 3p₁p₂ + 2p₃ = 2p₃`. So `T ≡ d` gives
  `θ = (1 + d) p₃`.

**`hN` is carried as the canonical statement states it and is not used.**

## What is NOT typed here

**"Constant `T` is not realised by any `𝔰𝔬(n)`" is absent**, because the record itself records it
as unproved: a parity argument closes `n ≡ 2, 3 (mod 4)` and the cases `n = 8, 9, 12` are open.
Typing it would type a claim the record does not hold, and typing only the parity half would type
a different lemma.

**The dimension count is stated as the characterisation, not as a `finrank`.** "Exactly
one-dimensional, `T` constant" is here "the collapsing `T` are exactly the constants"; the
`Submodule` and its `finrank` are not constructed.

**The record states it at `N ≥ 3`** ([results.md](../../../results.md)), and the theorem below carries no
threshold, holding at every `N`: the proof uses none.
-/

namespace HamiltonsCubic.L49Statement

open Finset

variable {N : ℕ}

/-! ## The eigenframe display -/

/-- **`θ = ∑ λ³ + 3 ∑_{α<β<γ} T_{αβγ} λ_α λ_β λ_γ`**, the record's eigenframe display. -/
def thetaOf (T : Fin N → Fin N → Fin N → ℝ) (lam : Fin N → ℝ) : ℝ :=
  (∑ i, lam i ^ 3)
    + 3 * ∑ α : Fin N, ∑ β ∈ Finset.Ioi α, ∑ γ ∈ Finset.Ioi β,
        T α β γ * (lam α * lam β * lam γ)

/-- **The collapse condition**, with the quantifier over spectra inside: `θ` reduces to a multiple
of `∑ λ³` on the whole subspace cut out by the single trace condition `∑ λ = 0`. -/
def Collapses (T : Fin N → Fin N → Fin N → ℝ) : Prop :=
  ∃ c : ℝ, ∀ lam : Fin N → ℝ, (∑ i, lam i) = 0 → thetaOf T lam = c * ∑ i, lam i ^ 3

/-! ## The condition is linear in `T` -/

/-- **`Collapses` is closed under sums**, half of the record's "the condition is linear in `T`, so
the collapsing configurations form a subspace". -/
theorem collapse_add {T S : Fin N → Fin N → Fin N → ℝ} (hT : Collapses T) (hS : Collapses S) :
    Collapses (fun α β γ => T α β γ + S α β γ) := by
  obtain ⟨c, hc⟩ := hT
  obtain ⟨d, hd⟩ := hS
  refine ⟨c + d - 1, fun lam hlam => ?_⟩
  have h1 := hc lam hlam
  have h2 := hd lam hlam
  simp only [thetaOf] at *
  have hsplit : (∑ α : Fin N, ∑ β ∈ Finset.Ioi α, ∑ γ ∈ Finset.Ioi β,
        (T α β γ + S α β γ) * (lam α * lam β * lam γ))
      = (∑ α : Fin N, ∑ β ∈ Finset.Ioi α, ∑ γ ∈ Finset.Ioi β, T α β γ * (lam α * lam β * lam γ))
        + ∑ α : Fin N, ∑ β ∈ Finset.Ioi α, ∑ γ ∈ Finset.Ioi β,
            S α β γ * (lam α * lam β * lam γ) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun α _ => ?_
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun β _ => ?_
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun γ _ => by ring
  rw [hsplit]
  linarith

/-- **`Collapses` is closed under scalar multiples**, the other half. -/
theorem collapse_smul {T : Fin N → Fin N → Fin N → ℝ} (r : ℝ) (hT : Collapses T) :
    Collapses (fun α β γ => r * T α β γ) := by
  obtain ⟨c, hc⟩ := hT
  refine ⟨r * c - r + 1, fun lam hlam => ?_⟩
  have h1 := hc lam hlam
  simp only [thetaOf] at *
  have hsplit : (∑ α : Fin N, ∑ β ∈ Finset.Ioi α, ∑ γ ∈ Finset.Ioi β,
        (r * T α β γ) * (lam α * lam β * lam γ))
      = r * ∑ α : Fin N, ∑ β ∈ Finset.Ioi α, ∑ γ ∈ Finset.Ioi β,
          T α β γ * (lam α * lam β * lam γ) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun α _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun β _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun γ _ => by ring
  have h3 : 3 * (∑ α : Fin N, ∑ β ∈ Finset.Ioi α, ∑ γ ∈ Finset.Ioi β,
      T α β γ * (lam α * lam β * lam γ)) = (c - 1) * ∑ i, lam i ^ 3 := by linarith
  rw [hsplit]
  linear_combination r * h3

/-- **The collapse space is nonempty**: `T = 0` collapses, with `c = 1`. -/
theorem zero_collapses : Collapses (fun _ _ _ : Fin N => (0 : ℝ)) := by
  refine ⟨1, fun lam _ => ?_⟩
  simp [thetaOf]

/-! ## Increasing triples written over all of `Fin N` -/

theorem ioi_sum_eq (F : Fin N → Fin N → Fin N → ℝ) :
    (∑ α : Fin N, ∑ β ∈ Ioi α, ∑ γ ∈ Ioi β, F α β γ)
      = ∑ α : Fin N, ∑ β : Fin N, ∑ γ : Fin N, if α < β ∧ β < γ then F α β γ else 0 := by
  have hIoi : ∀ (a : Fin N) (G : Fin N → ℝ), ∑ j ∈ Ioi a, G j = ∑ j, if a < j then G j else 0 := by
    intro a G
    rw [← Finset.sum_filter]
    congr 1
    ext j
    simp
  simp only [hIoi]
  refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
  by_cases h : α < β
  · simp [h]
  · simp [h]

/-! ## The spike spectrum `e_i + e_j - 2 e_k` -/

/-- **The spike spectrum** `e_i + e_j - 2e_k`, trace-free, supported on one triple. -/
def spike (i j k : Fin N) (m : Fin N) : ℝ :=
  if m = i then 1 else if m = j then 1 else if m = k then -2 else 0

theorem spike_cases {i j k : Fin N} (hij : i < j) (hjk : j < k) (m : Fin N) :
    (m = i ∧ spike i j k m = 1) ∨ (m = j ∧ spike i j k m = 1) ∨ (m = k ∧ spike i j k m = -2)
      ∨ (m ≠ i ∧ m ≠ j ∧ m ≠ k ∧ spike i j k m = 0) := by
  unfold spike
  by_cases h1 : m = i
  · exact Or.inl ⟨h1, by simp [h1]⟩
  by_cases h2 : m = j
  · exact Or.inr (Or.inl ⟨h2, by simp [h2, h1]⟩)
  by_cases h3 : m = k
  · exact Or.inr (Or.inr (Or.inl ⟨h3, by subst h3; simp [h1, h2]⟩))
  exact Or.inr (Or.inr (Or.inr ⟨h1, h2, h3, by simp [h1, h2, h3]⟩))

theorem spike_pointwise {i j k : Fin N} (hij : i < j) (hjk : j < k) (m : Fin N) (e : ℕ) (a b c : ℝ)
    (ha : a = 1 ^ e) (hb : b = 1 ^ e) (hc : c = (-2) ^ e) :
    spike i j k m ^ e
      = (if m = i then a else 0) + (if m = j then b else 0) + (if m = k then c else 0)
        + (if m ≠ i ∧ m ≠ j ∧ m ≠ k then 0 ^ e else 0) := by
  rcases spike_cases hij hjk m with ⟨rfl, h⟩ | ⟨rfl, h⟩ | ⟨rfl, h⟩ | ⟨h1, h2, h3, h⟩
  · have : m ≠ j := ne_of_lt hij
    have : m ≠ k := ne_of_lt (hij.trans hjk)
    simp [h, *]
  · have : m ≠ i := ne_of_gt hij
    have : m ≠ k := ne_of_lt hjk
    simp [h, *]
  · have : m ≠ i := ne_of_gt (hij.trans hjk)
    have : m ≠ j := ne_of_gt hjk
    simp [h, *]
  · simp [h, h1, h2, h3]

theorem spike_sum {i j k : Fin N} (hij : i < j) (hjk : j < k) : (∑ m, spike i j k m) = 0 := by
  have h := fun m => spike_pointwise hij hjk m 1 1 1 (-2) (by norm_num) (by norm_num) (by norm_num)
  simp only [pow_one] at h
  rw [Finset.sum_congr rfl fun m _ => h m]
  simp [Finset.sum_add_distrib]
  norm_num

theorem spike_cube {i j k : Fin N} (hij : i < j) (hjk : j < k) :
    (∑ m, spike i j k m ^ 3) = -6 := by
  rw [Finset.sum_congr rfl fun m _ =>
    spike_pointwise hij hjk m 3 1 1 (-8) (by norm_num) (by norm_num) (by norm_num)]
  simp [Finset.sum_add_distrib]
  norm_num

theorem spike_triple (T : Fin N → Fin N → Fin N → ℝ) {i j k : Fin N} (hij : i < j) (hjk : j < k) :
    (∑ α : Fin N, ∑ β ∈ Ioi α, ∑ γ ∈ Ioi β,
        T α β γ * (spike i j k α * spike i j k β * spike i j k γ)) = -2 * T i j k := by
  rw [ioi_sum_eq]
  have hpt : ∀ α β γ : Fin N,
      (if α < β ∧ β < γ then T α β γ * (spike i j k α * spike i j k β * spike i j k γ) else 0)
        = if α = i then (if β = j then (if γ = k then -2 * T i j k else 0) else 0) else 0 := by
    intro α β γ
    by_cases hord : α < β ∧ β < γ
    · rw [if_pos hord]
      obtain ⟨hab, hbg⟩ := hord
      rcases spike_cases hij hjk α with ⟨rfl, ha⟩ | ⟨rfl, ha⟩ | ⟨rfl, ha⟩ | ⟨a1, a2, a3, ha⟩ <;>
      rcases spike_cases hij hjk β with ⟨rfl, hb⟩ | ⟨rfl, hb⟩ | ⟨rfl, hb⟩ | ⟨b1, b2, b3, hb⟩ <;>
      rcases spike_cases hij hjk γ with ⟨rfl, hc⟩ | ⟨rfl, hc⟩ | ⟨rfl, hc⟩ | ⟨c1, c2, c3, hc⟩ <;>
      first
        | omega
        | (rw [ha, hb, hc]; simp_all; ring)
        | (rw [ha, hb, hc]; simp_all)
    · rw [if_neg hord]
      by_cases h : α = i ∧ β = j ∧ γ = k
      · obtain ⟨rfl, rfl, rfl⟩ := h
        exact absurd ⟨hij, hjk⟩ hord
      · by_cases h1 : α = i
        · by_cases h2 : β = j
          · have h3 : γ ≠ k := fun h3 => h ⟨h1, h2, h3⟩
            simp [h1, h2, h3]
          · simp [h1, h2]
        · simp [h1]
  rw [Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ =>
    Finset.sum_congr rfl fun γ _ => hpt α β γ]
  simp

/-! ## At `e₁ = 0`, `3 e₃ = p₃` -/

theorem three_e3 (lam : Fin N → ℝ) (h : ∑ i, lam i = 0) :
    3 * (∑ α : Fin N, ∑ β ∈ Ioi α, ∑ γ ∈ Ioi β, lam α * lam β * lam γ) = ∑ i, lam i ^ 3 := by
  have hsym12 : ∀ α β γ : Fin N, lam α * lam β * lam γ = lam β * lam α * lam γ :=
    fun _ _ _ => by ring
  have hsym23 : ∀ α β γ : Fin N, lam α * lam β * lam γ = lam α * lam γ * lam β :=
    fun _ _ _ => by ring
  have h6 := HamiltonsCubic.L42Statement.distinctSum_eq_six (fun α β γ => lam α * lam β * lam γ)
    hsym12 hsym23
  have hinc := HamiltonsCubic.L42Statement.objective_eq_increasingSum
    (fun _ _ _ : Fin N => (1 : ℝ)) lam
  simp only [HamiltonsCubic.L42Statement.objective, one_mul] at hinc
  have hind : ∀ (α β γ : Fin N) (x : ℝ), (if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then x else 0)
      = x - (if α = β then x else 0) - (if α = γ then x else 0) - (if β = γ then x else 0)
        + ((if α = β ∧ β = γ then x else 0) + (if α = β ∧ β = γ then x else 0)) := by
    intro α β γ x
    split_ifs <;> first | ring1 | omega
  have hγ : ∀ a b : ℝ, ∑ γ : Fin N, a * b * lam γ = 0 := fun a b => by
    rw [← Finset.mul_sum, h, mul_zero]
  have hβ : ∀ a c : ℝ, ∑ β : Fin N, a * lam β * c = 0 := fun a c => by
    rw [← Finset.sum_mul, ← Finset.mul_sum, h]; ring
  have hα : ∀ b c : ℝ, ∑ α : Fin N, lam α * b * c = 0 := fun b c => by
    rw [← Finset.sum_mul, ← Finset.sum_mul, h]; ring
  have S_all : ∑ α : Fin N, ∑ β : Fin N, ∑ γ : Fin N, lam α * lam β * lam γ = 0 := by
    simp [hγ]
  have S_ab : ∑ α : Fin N, ∑ β : Fin N, ∑ γ : Fin N,
      (if α = β then lam α * lam β * lam γ else 0) = 0 := by
    refine Finset.sum_eq_zero fun α _ => Finset.sum_eq_zero fun β _ => ?_
    by_cases hab : α = β
    · simp only [if_pos hab]; exact hγ _ _
    · simp [hab]
  have S_ag : ∑ α : Fin N, ∑ β : Fin N, ∑ γ : Fin N,
      (if α = γ then lam α * lam β * lam γ else 0) = 0 := by
    refine Finset.sum_eq_zero fun α _ => ?_
    simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true]
    exact hβ _ _
  have S_bg : ∑ α : Fin N, ∑ β : Fin N, ∑ γ : Fin N,
      (if β = γ then lam α * lam β * lam γ else 0) = 0 := by
    simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true]
    rw [Finset.sum_comm]
    exact Finset.sum_eq_zero fun β _ => hα _ _
  have S_eq : ∑ α : Fin N, ∑ β : Fin N, ∑ γ : Fin N,
      (if α = β ∧ β = γ then lam α * lam β * lam γ else 0) = ∑ i, lam i ^ 3 := by
    refine Finset.sum_congr rfl fun α _ => ?_
    have hin : ∀ β : Fin N, (∑ γ : Fin N, if α = β ∧ β = γ then lam α * lam β * lam γ else 0)
        = if α = β then lam α * lam β * lam β else 0 := by
      intro β
      by_cases hab : α = β
      · simp [hab]
      · simp [hab]
    simp only [hin, Finset.sum_ite_eq, Finset.mem_univ, if_true]
    ring
  have hD : HamiltonsCubic.L42Statement.distinctSum (fun α β γ => lam α * lam β * lam γ)
      = 2 * ∑ i, lam i ^ 3 := by
    unfold HamiltonsCubic.L42Statement.distinctSum
    simp only [hind, Finset.sum_add_distrib, Finset.sum_sub_distrib]
    rw [S_all, S_ab, S_ag, S_bg, S_eq]
    ring
  rw [hinc] at *
  linarith

/-! ## The lemma -/

/-- **The collapse space is exactly the constants, hence one-dimensional.**

*The spike spectrum `e_i + e_j - 2e_k` pins each `T_{ijk}` to `c - 1`, and `3e₃ = p₃` at
`e₁ = 0` gives the converse.* -/
theorem collapse_space_is_the_constants (T : Fin N → Fin N → Fin N → ℝ) :
    Collapses T ↔ ∃ d : ℝ, ∀ α β γ : Fin N, α < β → β < γ → T α β γ = d := by
  constructor
  · rintro ⟨c, hc⟩
    refine ⟨c - 1, fun α β γ hab hbg => ?_⟩
    have hθ := hc (spike α β γ) (spike_sum hab hbg)
    simp only [thetaOf, spike_cube hab hbg, spike_triple T hab hbg] at hθ
    linarith
  · rintro ⟨d, hd⟩
    refine ⟨1 + d, fun lam hlam => ?_⟩
    have hT : (∑ α : Fin N, ∑ β ∈ Ioi α, ∑ γ ∈ Ioi β, T α β γ * (lam α * lam β * lam γ))
        = d * ∑ α : Fin N, ∑ β ∈ Ioi α, ∑ γ ∈ Ioi β, lam α * lam β * lam γ := by
      simp only [Finset.mul_sum]
      refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β hβ =>
        Finset.sum_congr rfl fun γ hγ => ?_
      rw [hd α β γ (Finset.mem_Ioi.mp hβ) (Finset.mem_Ioi.mp hγ)]
    have h3 := three_e3 lam hlam
    simp only [thetaOf, hT]
    linear_combination d * h3


end HamiltonsCubic.L49Statement

#print axioms HamiltonsCubic.L49Statement.collapse_space_is_the_constants
