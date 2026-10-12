import Mathlib

set_option linter.style.longLine false

/-!
# L42, the sharp dual weight

## The record's statement, quoted verbatim from [stratum-two-negative.md](../../../findings/stratum-two-negative.md)

> #### Lemma L42, the sharp dual weight

> Let $\lambda_P$ be at least three positive eigenvalues and let
> \[
> M(\lambda_P)\;=\;\max\Big\{\textstyle\sum_{\alpha<\beta<\gamma}t_{\alpha\beta\gamma}\lambda_\alpha\lambda_\beta\lambda_\gamma\;:\;t\ge0,\ \sum_{\gamma\notin\{\alpha,\beta\}}t_{\alpha\beta\gamma}\le2\ \text{for every pair}\Big\}.
> \]
> Then $3M(\lambda_P)\le h\,(s^2-u)$, with $h$ the harmonic mean of the three largest positives,
> $s=\sum\lambda$ and $u=\sum\lambda^2$. **The constant cannot be improved.**

and, from the derivation in the same file, the route and the hypothesis the statement owes:

> **Its dual** is $\min\ 2\sum_{\alpha<\beta}z_{\alpha\beta}$ subject to
> $z_{\alpha\beta}+z_{\beta\gamma}+z_{\alpha\gamma}\ge\lambda_\alpha\lambda_\beta\lambda_\gamma$ on
> every triple, $z\ge0$.

> Put $z_{\alpha\beta}=c\,\lambda_\alpha\lambda_\beta$. Dividing the triple constraint by
> $\lambda_\alpha\lambda_\beta\lambda_\gamma>0$ turns it into
> $$c\Big(\tfrac1{\lambda_\alpha}+\tfrac1{\lambda_\beta}+\tfrac1{\lambda_\gamma}\Big)\ \ge\ 1,\qquad\text{i.e.}\qquad c\ \ge\ \tfrac13H(\alpha,\beta,\gamma),$$
> with $H$ the **harmonic mean** of the triple […] The harmonic mean is increasing in each argument,
> so the binding triple is the **three largest positives** and $c=h/3$ is feasible.

> #### Hypothesis: at least three positives
> At $k\le2$ there are no triples, $M=0$, and $h$ is undefined; those cases are closed elsewhere.

## What is typed here

* `Feasible`, the primal's feasible set: `t ≥ 0`, totally symmetric, and the pair cap
  `∑_{γ ∉ {α,β}} t_{αβγ} ≤ 2` for every pair.
* `objective`, `∑_{α<β<γ} t_{αβγ} λ_α λ_β λ_γ`, over the strictly ordered triples.
* `ThreeLargest`, the record's "the three largest positives", as three distinct indices no other
  index beats, and `harmonicMean` for the `h` built from them.
* `sharp_dual_weight`, **the lemma, `3 · objective ≤ h(s² - u)` for every feasible `t`.**
  *`M` is a maximum, so bounding it is bounding every feasible value; the universally quantified
  form is the same statement and does not need attainment, which is what a `max` in the binder
  would.* **It is proved, with no `sorry`.**
* `triple_constraint`, the dual feasibility step, proved: with `c = h/3` and `h` at least the
  harmonic mean of the triple, `λ_α λ_β λ_γ ≤ c(λ_αλ_β + λ_βλ_γ + λ_αλ_γ)`.

## The proof

**Weak duality, summed over ordered triples of distinct indices** (`distinctSum`), where the
symmetry of `t` does the bookkeeping:

* `distinctSum_eq_six`: a totally symmetric summand counts each increasing triple six times, so
  the ordered sum of `t λλλ` is `6 · objective`.
* `recip_le` and `triple_bound`: the three largest have the smallest reciprocal sum, ties
  included, so `h` dominates the harmonic mean of every distinct triple and `triple_constraint`
  gives `3 t λ_αλ_βλ_γ ≤ h t (λ_αλ_β + λ_βλ_γ + λ_αλ_γ)` there.
* `distinctSum_rel23`, `distinctSum_rel13`: the three pair terms are one sum relabelled.
* `distinctSum_pair_le` and `offDiag_eq`: that sum is at most `2 ∑_{α≠β} λ_αλ_β = 2(s² - u)`, by
  the pair cap.

**`hk` is carried as the record states it and is not used**: `ThreeLargest` already names three
distinct indices.

## What is NOT typed here

**Sharpness is typed in [L42Sharp.lean](L42Sharp.lean)**, `sharp_witness`: the record's witness,
`k` equal positives with `t_{αβγ} = 2/(k-2)` on every triple, pair marginal `2`, total
`k(k-1)/3`, meets the bound with equality at every `k ≥ 3`, so no constant in the lemma can be
improved. *The equality at exactly three positives is [L42.lean](L42.lean)'s `sharp_at_three`.*

**`M` is not defined as a maximum**, for the reason given above: attainment is a separate fact and
the lemma does not depend on it.
-/

namespace HamiltonsCubic.L42Statement

open Finset

variable {k : ℕ}

/-! ## The primal -/

/-- **The feasible set of the primal**: `t ≥ 0`, totally symmetric, and the pair cap. -/
structure Feasible (t : Fin k → Fin k → Fin k → ℝ) : Prop where
  nonneg : ∀ α β γ, 0 ≤ t α β γ
  symm12 : ∀ α β γ, t α β γ = t β α γ
  symm23 : ∀ α β γ, t α β γ = t α γ β
  pairCap : ∀ α β, α ≠ β → (∑ γ ∈ univ.filter fun γ => γ ≠ α ∧ γ ≠ β, t α β γ) ≤ 2

/-- **`∑_{α<β<γ} t_{αβγ} λ_α λ_β λ_γ`**, the primal objective. -/
def objective (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ) : ℝ :=
  ∑ α : Fin k, ∑ β ∈ Finset.Ioi α, ∑ γ ∈ Finset.Ioi β, t α β γ * (lam α * lam β * lam γ)

/-! ## The three largest positives, and their harmonic mean -/

/-- **The three largest positives**: three distinct indices that no other index exceeds. -/
structure ThreeLargest (lam : Fin k → ℝ) (a b c : Fin k) : Prop where
  ab : a ≠ b
  bc : b ≠ c
  ac : a ≠ c
  largest : ∀ γ, γ ≠ a → γ ≠ b → γ ≠ c → lam γ ≤ min (lam a) (min (lam b) (lam c))

/-- **`h`, the harmonic mean of three values.** -/
noncomputable def harmonicMean (x y z : ℝ) : ℝ := 3 / (1 / x + 1 / y + 1 / z)

/-! ## The dual feasibility step -/

/-- **The dual constraint on one triple**, which is the whole of the record's "feasibility of the
product weight": with `z_{αβ} = c λ_α λ_β` and `c ≥ H(α,β,γ)/3`, the triple constraint
`z_{αβ} + z_{βγ} + z_{αγ} ≥ λ_αλ_βλ_γ` holds. -/
theorem triple_constraint (x y z c : ℝ) (hx : 0 < x) (hy : 0 < y) (hz : 0 < z)
    (hc : harmonicMean x y z / 3 ≤ c) :
    x * y * z ≤ c * (x * y + y * z + x * z) := by
  have hsum : 0 < 1 / x + 1 / y + 1 / z := by positivity
  have hH : harmonicMean x y z / 3 = 1 / (1 / x + 1 / y + 1 / z) := by
    rw [harmonicMean]; field_simp
  rw [hH] at hc
  have hkey : (1 / (1 / x + 1 / y + 1 / z)) * (x * y + y * z + x * z) = x * y * z := by
    field_simp
    ring
  have hpos : 0 < x * y + y * z + x * z := by positivity
  nlinarith [mul_le_mul_of_nonneg_right hc hpos.le]

/-! ## Sums over ordered triples of distinct indices -/

/-- **The sum over ordered triples of distinct indices.** -/
def distinctSum (F : Fin k → Fin k → Fin k → ℝ) : ℝ :=
  ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k, if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then F α β γ else 0

/-- **The sum over strictly increasing triples**, written over all of `Fin k`. -/
def increasingSum (F : Fin k → Fin k → Fin k → ℝ) : ℝ :=
  ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k, if α < β ∧ β < γ then F α β γ else 0

theorem objective_eq_increasingSum (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ) :
    objective t lam = increasingSum fun α β γ => t α β γ * (lam α * lam β * lam γ) := by
  have hIoi : ∀ (a : Fin k) (F : Fin k → ℝ), ∑ j ∈ Ioi a, F j = ∑ j, if a < j then F j else 0 := by
    intro a F
    rw [← Finset.sum_filter]
    congr 1
    ext j
    simp
  simp only [objective, increasingSum, hIoi]
  refine Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ => ?_
  by_cases h : α < β
  · simp [h]
  · simp [h]

/-- **Six orderings of a distinct triple**, for a totally symmetric summand. -/
theorem distinctSum_eq_six (g : Fin k → Fin k → Fin k → ℝ)
    (s12 : ∀ α β γ, g α β γ = g β α γ) (s23 : ∀ α β γ, g α β γ = g α γ β) :
    distinctSum g = 6 * increasingSum g := by
  set O : Fin k → Fin k → Fin k → ℝ := fun x y z => if x < y ∧ y < z then g x y z else 0 with hO
  have hpt : ∀ α β γ : Fin k, (if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then g α β γ else 0)
      = O α β γ + O α γ β + O β α γ + O β γ α + O γ α β + O γ β α := by
    intro α β γ
    have e1 : g α γ β = g α β γ := (s23 α β γ).symm
    have e2 : g β α γ = g α β γ := (s12 α β γ).symm
    have e3 : g β γ α = g α β γ := by rw [s12 α β γ, s23 β α γ]
    have e4 : g γ α β = g α β γ := by rw [s23 α β γ, s12 α γ β]
    have e5 : g γ β α = g α β γ := by rw [s23 α β γ, s12 α γ β, s23 γ α β]
    simp only [hO, e1, e2, e3, e4, e5]
    split_ifs <;> first | ring1 | omega
  have hsum : distinctSum g = ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k,
      (O α β γ + O α γ β + O β α γ + O β γ α + O γ α β + O γ β α) := by
    simp only [distinctSum, hpt]
  simp only [Finset.sum_add_distrib] at hsum
  have c1 : ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k, O α γ β = increasingSum g :=
    Finset.sum_congr rfl fun _ _ => Finset.sum_comm
  have c2 : ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k, O β α γ = increasingSum g :=
    Finset.sum_comm
  have c3 : ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k, O β γ α = increasingSum g := by
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun _ _ => Finset.sum_comm
  have c4 : ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k, O γ α β = increasingSum g := by
    rw [show (∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k, O γ α β)
        = ∑ α : Fin k, ∑ γ : Fin k, ∑ β : Fin k, O γ α β from
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm]
    exact Finset.sum_comm
  have c5 : ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k, O γ β α = increasingSum g := by
    rw [Finset.sum_comm]
    rw [show (∑ β : Fin k, ∑ α : Fin k, ∑ γ : Fin k, O γ β α)
        = ∑ β : Fin k, ∑ γ : Fin k, ∑ α : Fin k, O γ β α from
        Finset.sum_congr rfl fun _ _ => Finset.sum_comm]
    exact Finset.sum_comm
  have c0 : ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k, O α β γ = increasingSum g := rfl
  rw [hsum, c0, c1, c2, c3, c4, c5]
  ring

/-- **The pair cap, summed**: over ordered distinct triples, `t_{αβγ} λ_α λ_β` totals at most
`2 ∑_{α ≠ β} λ_α λ_β`. -/
theorem distinctSum_pair_le (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ)
    (hpos : ∀ i, 0 < lam i) (hft : Feasible t) :
    distinctSum (fun α β γ => t α β γ * (lam α * lam β))
      ≤ 2 * ∑ α : Fin k, ∑ β : Fin k, if α ≠ β then lam α * lam β else 0 := by
  simp only [distinctSum, Finset.mul_sum]
  refine Finset.sum_le_sum fun α _ => Finset.sum_le_sum fun β _ => ?_
  by_cases hab : α ≠ β
  · have hrw : (∑ γ : Fin k, if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then t α β γ * (lam α * lam β) else 0)
        = (lam α * lam β) * ∑ γ ∈ univ.filter (fun γ => γ ≠ α ∧ γ ≠ β), t α β γ := by
      rw [Finset.sum_filter, Finset.mul_sum]
      refine Finset.sum_congr rfl fun γ _ => ?_
      by_cases h1 : γ = α
      · subst h1; simp
      · by_cases h2 : γ = β
        · subst h2; simp
        · have h1' : α ≠ γ := fun h => h1 h.symm
          have h2' : β ≠ γ := fun h => h2 h.symm
          simp [hab, h1, h2, h1', h2', mul_comm]
    rw [hrw, if_pos hab]
    have hp : 0 < lam α * lam β := mul_pos (hpos α) (hpos β)
    nlinarith [hft.pairCap α β hab]
  · have hz : (∑ γ : Fin k, if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then t α β γ * (lam α * lam β) else 0) = 0 :=
      Finset.sum_eq_zero fun γ _ => if_neg fun h => hab h.1
    rw [hz, if_neg hab]
    norm_num

/-- **`s² - u` is the off-diagonal sum.** -/
theorem offDiag_eq (lam : Fin k → ℝ) :
    (∑ α : Fin k, ∑ β : Fin k, if α ≠ β then lam α * lam β else 0)
      = (∑ i, lam i) ^ 2 - ∑ i, lam i ^ 2 := by
  have hsplit : ∀ α β : Fin k, lam α * lam β
      = (if α ≠ β then lam α * lam β else 0) + (if α = β then lam α * lam β else 0) := by
    intro α β
    by_cases h : α = β <;> simp [h]
  have hsq : (∑ i, lam i) ^ 2 = ∑ α : Fin k, ∑ β : Fin k, lam α * lam β := by
    rw [sq, Finset.sum_mul_sum]
  have hrow : ∀ α : Fin k, ∑ β : Fin k, lam α * lam β
      = (∑ β : Fin k, if α ≠ β then lam α * lam β else 0) + lam α ^ 2 := by
    intro α
    rw [Finset.sum_congr rfl fun β _ => hsplit α β, Finset.sum_add_distrib, Finset.sum_ite_eq]
    simp [sq]
  rw [hsq]
  simp only [hrow, Finset.sum_add_distrib]
  ring

/-! ## The dual constraint at every triple -/

/-- **The three largest have the smallest reciprocal sum**, ties included. -/
theorem recip_le (lam : Fin k → ℝ) (hpos : ∀ i, 0 < lam i) {a b c : Fin k}
    (h3 : ThreeLargest lam a b c) {α β γ : Fin k} (h1 : α ≠ β) (h2 : α ≠ γ) (h3' : β ≠ γ) :
    1 / lam a + 1 / lam b + 1 / lam c ≤ 1 / lam α + 1 / lam β + 1 / lam γ := by
  have key : ∀ x, x = a ∨ x = b ∨ x = c ∨
      (1 / lam a ≤ 1 / lam x ∧ 1 / lam b ≤ 1 / lam x ∧ 1 / lam c ≤ 1 / lam x) := by
    intro x
    by_cases ha : x = a
    · exact Or.inl ha
    by_cases hb : x = b
    · exact Or.inr (Or.inl hb)
    by_cases hc : x = c
    · exact Or.inr (Or.inr (Or.inl hc))
    have hl := h3.largest x ha hb hc
    refine Or.inr (Or.inr (Or.inr ⟨?_, ?_, ?_⟩))
    · exact one_div_le_one_div_of_le (hpos x) (hl.trans (min_le_left _ _))
    · exact one_div_le_one_div_of_le (hpos x)
        (hl.trans ((min_le_right _ _).trans (min_le_left _ _)))
    · exact one_div_le_one_div_of_le (hpos x)
        (hl.trans ((min_le_right _ _).trans (min_le_right _ _)))
  rcases key α with rfl | rfl | rfl | ⟨p1, p2, p3⟩ <;>
  rcases key β with rfl | rfl | rfl | ⟨q1, q2, q3⟩ <;>
  rcases key γ with rfl | rfl | rfl | ⟨r1, r2, r3⟩ <;>
  first | contradiction | linarith

/-- **The per-triple inequality weak duality sums**: the dual weight `h/3` covers every
distinct triple, `t` being nonnegative. -/
theorem triple_bound (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ)
    (hpos : ∀ i, 0 < lam i) (hft : Feasible t) {a b c : Fin k} (h3 : ThreeLargest lam a b c)
    {α β γ : Fin k} (hP : α ≠ β ∧ α ≠ γ ∧ β ≠ γ) :
    3 * (t α β γ * (lam α * lam β * lam γ))
      ≤ harmonicMean (lam a) (lam b) (lam c)
          * (t α β γ * (lam α * lam β) + t α β γ * (lam β * lam γ)
              + t α β γ * (lam α * lam γ)) := by
  obtain ⟨h1, h2, h3'⟩ := hP
  have hr := recip_le lam hpos h3 h1 h2 h3'
  have hHle : harmonicMean (lam α) (lam β) (lam γ) ≤ harmonicMean (lam a) (lam b) (lam c) := by
    unfold harmonicMean
    have ha := hpos a
    have hb := hpos b
    have hc := hpos c
    have hs : 0 < 1 / lam a + 1 / lam b + 1 / lam c := by positivity
    exact div_le_div_of_nonneg_left (by norm_num) hs hr
  have hc := triple_constraint (lam α) (lam β) (lam γ) (harmonicMean (lam a) (lam b) (lam c) / 3)
    (hpos α) (hpos β) (hpos γ) (by linarith)
  have hm := mul_le_mul_of_nonneg_left hc (hft.nonneg α β γ)
  have e : harmonicMean (lam a) (lam b) (lam c)
      * (t α β γ * (lam α * lam β) + t α β γ * (lam β * lam γ) + t α β γ * (lam α * lam γ))
      = 3 * (t α β γ * (harmonicMean (lam a) (lam b) (lam c) / 3
          * (lam α * lam β + lam β * lam γ + lam α * lam γ))) := by ring
  rw [e]
  linarith

/-! ## Relabelling the three pair terms -/

theorem distinctSum_rel23 (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (hft : Feasible t) :
    distinctSum (fun α β γ => t α β γ * (lam β * lam γ))
      = distinctSum (fun α β γ => t α β γ * (lam α * lam β)) := by
  have hpt : ∀ α β γ : Fin k,
      (if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then t α β γ * (lam β * lam γ) else 0)
        = (if β ≠ γ ∧ β ≠ α ∧ γ ≠ α then t β γ α * (lam β * lam γ) else 0) := by
    intro α β γ
    have e : t β γ α = t α β γ := by rw [hft.symm12 α β γ, hft.symm23 β α γ]
    rw [e]
    by_cases h : α ≠ β ∧ α ≠ γ ∧ β ≠ γ
    · rw [if_pos h, if_pos ⟨h.2.2, fun h' => h.1 h'.symm, fun h' => h.2.1 h'.symm⟩]
    · rw [if_neg h, if_neg]
      intro h'
      exact h ⟨fun e => h'.2.1 e.symm, fun e => h'.2.2 e.symm, h'.1⟩
  have hs : distinctSum (fun α β γ => t α β γ * (lam β * lam γ))
      = ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k,
          (if β ≠ γ ∧ β ≠ α ∧ γ ≠ α then t β γ α * (lam β * lam γ) else 0) :=
    Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ =>
      Finset.sum_congr rfl fun γ _ => hpt α β γ
  rw [hs, Finset.sum_comm]
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_comm

theorem distinctSum_rel13 (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ) (hft : Feasible t) :
    distinctSum (fun α β γ => t α β γ * (lam α * lam γ))
      = distinctSum (fun α β γ => t α β γ * (lam α * lam β)) := by
  have hpt : ∀ α β γ : Fin k,
      (if α ≠ β ∧ α ≠ γ ∧ β ≠ γ then t α β γ * (lam α * lam γ) else 0)
        = (if α ≠ γ ∧ α ≠ β ∧ γ ≠ β then t α γ β * (lam α * lam γ) else 0) := by
    intro α β γ
    rw [← hft.symm23 α β γ]
    by_cases h : α ≠ β ∧ α ≠ γ ∧ β ≠ γ
    · rw [if_pos h, if_pos ⟨h.2.1, h.1, fun h' => h.2.2 h'.symm⟩]
    · rw [if_neg h, if_neg]
      intro h'
      exact h ⟨h'.2.1, h'.1, fun e => h'.2.2 e.symm⟩
  have hs : distinctSum (fun α β γ => t α β γ * (lam α * lam γ))
      = ∑ α : Fin k, ∑ β : Fin k, ∑ γ : Fin k,
          (if α ≠ γ ∧ α ≠ β ∧ γ ≠ β then t α γ β * (lam α * lam γ) else 0) :=
    Finset.sum_congr rfl fun α _ => Finset.sum_congr rfl fun β _ =>
      Finset.sum_congr rfl fun γ _ => hpt α β γ
  rw [hs]
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_comm

/-! ## The lemma -/

/-- **The sharp dual weight.** For every feasible `t`,
`3 ∑_{α<β<γ} t_{αβγ} λ_α λ_β λ_γ ≤ h (s² - u)`, with `h` the harmonic mean of the three largest
positives, `s = ∑ λ` and `u = ∑ λ²`.

*Weak duality: the per-triple dual constraint, summed over ordered distinct triples against the
pair cap.* -/
theorem sharp_dual_weight (t : Fin k → Fin k → Fin k → ℝ) (lam : Fin k → ℝ)
    (a b c : Fin k) (hk : 3 ≤ k) (hpos : ∀ i, 0 < lam i)
    (hft : Feasible t) (h3 : ThreeLargest lam a b c) :
    3 * objective t lam
      ≤ harmonicMean (lam a) (lam b) (lam c)
          * ((∑ i, lam i) ^ 2 - ∑ i, lam i ^ 2) := by
  have hhpos : 0 < harmonicMean (lam a) (lam b) (lam c) := by
    have ha := hpos a
    have hb := hpos b
    have hc := hpos c
    unfold harmonicMean
    positivity
  have h6 : distinctSum (fun α β γ => t α β γ * (lam α * lam β * lam γ)) = 6 * objective t lam := by
    rw [distinctSum_eq_six, objective_eq_increasingSum]
    · intro α β γ
      rw [hft.symm12 α β γ]
      ring
    · intro α β γ
      rw [hft.symm23 α β γ]
      ring
  have hpt : 3 * distinctSum (fun α β γ => t α β γ * (lam α * lam β * lam γ))
      ≤ harmonicMean (lam a) (lam b) (lam c) * distinctSum (fun α β γ => t α β γ * (lam α * lam β))
        + harmonicMean (lam a) (lam b) (lam c)
            * distinctSum (fun α β γ => t α β γ * (lam β * lam γ))
        + harmonicMean (lam a) (lam b) (lam c)
            * distinctSum (fun α β γ => t α β γ * (lam α * lam γ)) := by
    simp only [distinctSum, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_le_sum fun α _ => Finset.sum_le_sum fun β _ =>
      Finset.sum_le_sum fun γ _ => ?_
    by_cases hP : α ≠ β ∧ α ≠ γ ∧ β ≠ γ
    · simp only [if_pos hP]
      have := triple_bound t lam hpos hft h3 hP
      linarith
    · simp only [if_neg hP]
      norm_num
  rw [distinctSum_rel23 t lam hft, distinctSum_rel13 t lam hft, h6] at hpt
  have hA := distinctSum_pair_le t lam hpos hft
  rw [offDiag_eq] at hA
  have hm := mul_le_mul_of_nonneg_left hA hhpos.le
  nlinarith


/-! ## Non-vacuity -/

/-- **A witness for `Feasible`**, so `sharp_dual_weight` is not vacuous: `t = 0`. -/
example : Feasible (fun _ _ _ : Fin k => (0 : ℝ)) where
  nonneg := by intro α β γ; norm_num
  symm12 := by intro α β γ; rfl
  symm23 := by intro α β γ; rfl
  pairCap := by intro α β _; simp

/-- **A witness for `ThreeLargest`**, so the hypothesis pair is jointly satisfiable: at `k = 3`
with `λ ≡ 1`, the three indices are all of them. -/
example : ThreeLargest (fun _ : Fin 3 => (1 : ℝ)) 0 1 2 where
  ab := by decide
  bc := by decide
  ac := by decide
  largest := by decide

end HamiltonsCubic.L42Statement

#print axioms HamiltonsCubic.L42Statement.sharp_dual_weight
