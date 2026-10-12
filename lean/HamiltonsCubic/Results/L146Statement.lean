import Mathlib

set_option linter.style.longLine false

/-!
# L146, the operator norm on the margin summand, and the direction-blind radius it corrects

The record's statement, quoted verbatim from
[second-order.md](../../../findings/second-order.md):

> **LEMMA L146.** *For `H` the Weyl image of a **single** `h ∈ S²₀(ℝᵐ)` with `‖H‖_F = 1`,
> `n = 2m` and `m ≥ 3`,*
>
> **HYPOTHESES, WRITTEN INTO THE STATEMENT WHERE A CITATION READS THEM.** *`m ≥ 5`, the word
> "margin" in the title needs it, and at `m = 3` the L27 case cited is the excluded `(3,3)` one.
> `ker W* = 0`. The frame chosen **after** `h`. And `h` ranges over the **joint** `λ_m`-eigenspace,
> both `S²₀(ℝᵐ)` copies together, at every norm*, **not one copy at unit norm, which is what the
> box said while all three consumers used the joint form.*
> $$‖H‖_F² = \frac{m(m-2)}{2(m-1)}‖h‖², \qquad ‖H‖_{op} = \frac{m}{2(m-1)}\max_{a≠a'}|h_a+h_{a'}|,$$
> *the in-block branch always winning, with supremum `1/√(m-1)` attained at the pair-concentrated
> `h`. **In order, `‖H‖_op` ranges over `[Θ(n⁻¹), Θ(n^{-1/2})]`.***

and the embedding it is computed against, also verbatim:

> **THE EMBEDDING, CORRECTED.** … Against the record's own projector (`KN(h) = ½(h ⩘ g)`), with
> `α = (m-2)/(2(m-1))` and `β = m/(2(m-1))`, the Weyl image is diagonal on coordinate `2`-planes with
> $$α\,h_a \text{ on } e_a ∧ e_b,\ a ∈ B_1,\ b ∈ B_2;\qquad -β\,(h_a+h_{a'}) \text{ on } e_a ∧ e_{a'},\
> a,a' ∈ B_1;\qquad 0 \text{ inside } B_2.$$

## What this file types

`h` is a traceless real vector on `Fin m` (the diagonal of `h ∈ S²₀(ℝᵐ)` in the frame chosen after
`h`), and the *eigenvalue list of the Weyl image* is taken from the embedding box above as the
definition of `HFsq` and `Hop`: `m²` cross planes carrying `α hₐ`, `C(m,2)` in-block planes carrying
`-β(hₐ + hₐ')`, and `C(m,2)` planes inside `B₂` carrying `0`. The three displayed conclusions are
then proved outright:

* `frobenius`, `‖H‖²_F = (m(m-2)/(2(m-1))) ‖h‖²`;
* `entry_le_pair` and `op_eq_inblock`, the in-block branch always wins, so
  `‖H‖_op = β · maxₐ≠ₐ' |hₐ + hₐ'|`;
* `op_sq_le` and `op_sq_eq_at_witness`, `‖H‖_op ≤ ‖H‖_F/√(m-1)`, with equality at the
  pair-concentrated `h`, which is the supremum `1/√(m-1)` and its attainment.

`witness_traceless` exhibits a nonzero admissible `h`, so nothing here is vacuous.

## What is NOT typed here

* **The embedding itself.** That the Weyl image of `h ⩘ g_q` has exactly the eigenvalue list above
  is the record's own computation against the Kulkarni–Nomizu projector; it enters here as the
  definition of `HFsq`/`Hop` rather than as a proved fact, so this file checks L146's *extremal
  arithmetic* on that list and not the identification of the list with `W(h)`.
* **The joint two-copy eigenspace.** The record's hypotheses box extends `h` to both `S²₀(ℝᵐ)`
  copies, where the equality clause for `‖H‖_op` is **false**, a pair `(h,k)` carries a third,
  cross-plane branch `α(hₐ + k_b)`. Only the single-copy display is typed. What is typed of the
  extension is `cross_branch_below_sup`, the squared form of the record's reason that the supremum
  survives it: the cross branch caps at `√(m-2)/m < 1/√(m-1)`.
* **The order-level conclusion** `‖H‖_op ∈ [Θ(n⁻¹), Θ(n^{-1/2})]` with `n = 2m`, and everything the
  record draws from it about the analyticity disc, `‖A''‖`, and the r446/r447 split.
* **`m ≥ 5`, `ker W* = 0`, and the frame-after-`h` clause**, which are scope conditions on the
  geometric reading and carry no arithmetic here; the displays are typed at the `m ≥ 3` the record
  states them at.
-/

namespace HamiltonsCubic.L146Statement

open Finset

variable {m : ℕ}

/-! ## The embedding's two coefficients -/

/-- `α = (m-2)/(2(m-1))`: the Weyl image's eigenvalue on the cross planes `e_a ∧ e_b`. -/
noncomputable def alphaC (m : ℕ) : ℝ := ((m : ℝ) - 2) / (2 * ((m : ℝ) - 1))

/-- `β = m/(2(m-1))`: the magnitude of the eigenvalue on the in-block planes `e_a ∧ e_{a'}`. -/
noncomputable def betaC (m : ℕ) : ℝ := (m : ℝ) / (2 * ((m : ℝ) - 1))

/-- The in-block coordinate `2`-planes `e_a ∧ e_{a'}` with `a, a' ∈ B₁`. -/
def pairs (m : ℕ) : Finset (Fin m × Fin m) :=
  Finset.univ.filter (fun p : Fin m × Fin m => p.1 < p.2)

/-- `‖h‖²` for `h ∈ S²₀(ℝᵐ)` diagonal with entries `h a`. -/
def nsq (h : Fin m → ℝ) : ℝ := ∑ a, (h a) ^ 2

/-- `‖H‖²_F`: the sum of the squares of the eigenvalues in the embedding box, `m²` cross planes
carrying `α h_a`, `C(m,2)` in-block planes carrying `-β(h_a + h_{a'})`, and the planes inside `B₂`
carrying `0`. -/
noncomputable def HFsq (h : Fin m → ℝ) : ℝ :=
  (m : ℝ) * (alphaC m) ^ 2 * nsq h + (betaC m) ^ 2 * ∑ p ∈ pairs m, (h p.1 + h p.2) ^ 2

/-- `‖H‖_op`: the largest absolute eigenvalue in that same list. The `B₂` planes carry `0` and are
dominated by the in-block branch, so they do not appear. -/
noncomputable def Hop (h : Fin m → ℝ) (hne : (pairs m).Nonempty) : ℝ :=
  max ((Finset.univ : Finset (Fin m)).sup' ⟨hne.choose.1, Finset.mem_univ _⟩
        (fun a => alphaC m * |h a|))
      ((pairs m).sup' hne (fun p => betaC m * |h p.1 + h p.2|))

theorem pairs_nonempty (hm : 2 ≤ m) : (pairs m).Nonempty := by
  refine ⟨(⟨0, by omega⟩, ⟨1, by omega⟩), ?_⟩
  simp only [pairs, Finset.mem_filter, Finset.mem_univ, true_and]
  exact Fin.mk_lt_mk.mpr (by norm_num)

/-! ## The Frobenius identity -/

private lemma trichotomy_split (f : Fin m × Fin m → ℝ) :
    ∑ p ∈ (Finset.univ : Finset (Fin m × Fin m)), f p
      = (∑ p ∈ Finset.univ.filter (fun p : Fin m × Fin m => p.1 < p.2), f p)
        + (∑ p ∈ Finset.univ.filter (fun p : Fin m × Fin m => p.2 < p.1), f p)
        + (∑ p ∈ Finset.univ.filter (fun p : Fin m × Fin m => p.1 = p.2), f p) := by
  simp only [Finset.sum_filter]
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun p _ => ?_
  rcases lt_trichotomy p.1 p.2 with hlt | heq | hgt
  · rw [if_pos hlt, if_neg (asymm hlt), if_neg (ne_of_lt hlt)]; ring
  · rw [if_neg (by omega), if_neg (by omega), if_pos heq]; ring
  · rw [if_neg (asymm hgt), if_pos hgt, if_neg (by omega)]; ring

private lemma gt_eq_lt (f : Fin m → Fin m → ℝ) (hs : ∀ a b, f a b = f b a) :
    ∑ p ∈ Finset.univ.filter (fun p : Fin m × Fin m => p.2 < p.1), f p.1 p.2
      = ∑ p ∈ Finset.univ.filter (fun p : Fin m × Fin m => p.1 < p.2), f p.1 p.2 := by
  refine Finset.sum_equiv (Equiv.prodComm (Fin m) (Fin m)) (fun p => ?_) (fun p _ => ?_)
  · simp [Equiv.prodComm]
  · simpa using hs p.1 p.2

/-- The in-block sum, for traceless `h`: `∑_{a<a'} (h_a + h_{a'})² = (m-2)‖h‖²`. -/
theorem pairs_sum (h : Fin m → ℝ) (htr : ∑ a, h a = 0) :
    ∑ p ∈ pairs m, (h p.1 + h p.2) ^ 2 = ((m : ℝ) - 2) * nsq h := by
  classical
  have hfull : ∑ p ∈ (Finset.univ : Finset (Fin m × Fin m)), (h p.1 + h p.2) ^ 2
      = 2 * (m : ℝ) * nsq h := by
    rw [← Finset.univ_product_univ, Finset.sum_product]
    have key : ∀ a : Fin m, ∑ b, (h a + h b) ^ 2
        = (m : ℝ) * (h a) ^ 2 + 2 * h a * (∑ b, h b) + ∑ b, (h b) ^ 2 := by
      intro a
      simp only [add_sq, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ,
        Fintype.card_fin, nsmul_eq_mul, ← Finset.mul_sum]
    simp only [key, htr, mul_zero, add_zero, nsq]
    rw [Finset.sum_add_distrib, ← Finset.mul_sum, Finset.sum_const, Finset.card_univ,
      Fintype.card_fin, nsmul_eq_mul]
    ring
  have hdiag : ∑ p ∈ Finset.univ.filter (fun p : Fin m × Fin m => p.1 = p.2), (h p.1 + h p.2) ^ 2
      = 4 * nsq h := by
    rw [Finset.sum_filter, ← Finset.univ_product_univ, Finset.sum_product]
    simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true]
    rw [nsq, Finset.mul_sum]
    exact Finset.sum_congr rfl fun a _ => by ring
  have hswap := gt_eq_lt (m := m) (fun a b => (h a + h b) ^ 2) (fun a b => by ring)
  have hsplit := trichotomy_split (m := m) (fun p => (h p.1 + h p.2) ^ 2)
  rw [hfull, hdiag, hswap] at hsplit
  have hpairs : pairs m = Finset.univ.filter (fun p : Fin m × Fin m => p.1 < p.2) := rfl
  rw [hpairs]
  linarith

/-- **The first display.** `‖H‖²_F = (m(m-2)/(2(m-1))) ‖h‖²`. -/
theorem frobenius (hm : 3 ≤ m) (h : Fin m → ℝ) (htr : ∑ a, h a = 0) :
    HFsq h = (m : ℝ) * ((m : ℝ) - 2) / (2 * ((m : ℝ) - 1)) * nsq h := by
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have hm1 : ((m : ℝ) - 1) ≠ 0 := by linarith
  rw [HFsq, pairs_sum h htr, alphaC, betaC]
  field_simp
  ring

/-! ## The in-block branch always wins -/

private lemma exists_pair_nonneg (hm : 3 ≤ m) (h : Fin m → ℝ) (htr : ∑ a, h a = 0)
    (a : Fin m) (ha : 0 ≤ h a) :
    ∃ a' : Fin m, a' ≠ a ∧ ((m : ℝ) - 2) / ((m : ℝ) - 1) * |h a| ≤ |h a + h a'| := by
  classical
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have hpos : (0 : ℝ) < (m : ℝ) - 1 := by linarith
  set s : Finset (Fin m) := Finset.univ.erase a with hs
  have hcardN : s.card = m - 1 := by
    rw [hs, Finset.card_erase_of_mem (Finset.mem_univ a), Finset.card_univ, Fintype.card_fin]
  have hcard : (s.card : ℝ) = (m : ℝ) - 1 := by
    rw [hcardN]
    have h1 : 1 ≤ m := by omega
    push_cast [Nat.cast_sub h1]
    ring
  have hsum : ∑ b ∈ s, h b = - h a := by
    have e1 : ∑ b ∈ s, h b + h a = ∑ b, h b := by
      rw [hs, Finset.sum_erase_add _ _ (Finset.mem_univ a)]
    rw [htr] at e1; linarith
  have hne : s.Nonempty := by
    rw [← Finset.card_pos, hcardN]; omega
  have hle : ∑ _b ∈ s, (- h a / ((m : ℝ) - 1)) ≤ ∑ b ∈ s, h b := by
    rw [Finset.sum_const, nsmul_eq_mul, hcard, hsum]
    have hcan : ((m : ℝ) - 1) * (- h a / ((m : ℝ) - 1)) = - h a := by field_simp
    rw [hcan]
  obtain ⟨a', ha's, hval⟩ := Finset.exists_le_of_sum_le hne hle
  refine ⟨a', (Finset.mem_erase.mp ha's).1, ?_⟩
  have h1 : - h a / ((m : ℝ) - 1) ≤ h a' := hval
  rw [div_le_iff₀ hpos] at h1
  have h2 : ((m : ℝ) - 2) / ((m : ℝ) - 1) * h a ≤ h a + h a' := by
    rw [div_mul_eq_mul_div, div_le_iff₀ hpos]
    nlinarith
  have h3 : 0 ≤ ((m : ℝ) - 2) / ((m : ℝ) - 1) * h a := by
    apply mul_nonneg _ ha
    apply div_nonneg <;> linarith
  rw [abs_of_nonneg ha, abs_of_nonneg (le_trans h3 h2)]
  exact h2

/-- **Tracelessness forces the pair maximum up.** `max_{a≠a'} |h_a + h_{a'}| ≥ ((m-2)/(m-1)) |h_a|`,
sharp at the spike, the record's clause, derived independently at `ROUND_L146`. -/
theorem exists_pair (hm : 3 ≤ m) (h : Fin m → ℝ) (htr : ∑ a, h a = 0) (a : Fin m) :
    ∃ a' : Fin m, a' ≠ a ∧ ((m : ℝ) - 2) / ((m : ℝ) - 1) * |h a| ≤ |h a + h a'| := by
  rcases le_or_gt 0 (h a) with hpos | hneg
  · exact exists_pair_nonneg hm h htr a hpos
  · have htr' : ∑ b, (fun b => - h b) b = 0 := by
      simp only [Finset.sum_neg_distrib, htr, neg_zero]
    obtain ⟨a', hne, hle⟩ :=
      exists_pair_nonneg hm (fun b => - h b) htr' a (by show (0:ℝ) ≤ - h a; linarith)
    refine ⟨a', hne, ?_⟩
    have e : -h a + -h a' = -(h a + h a') := by ring
    rw [abs_neg, e, abs_neg] at hle
    exact hle

/-- **The in-block branch dominates the cross branch, entry by entry**: `β/α = m/(m-2)` covers the
ratio `(m-2)/(m-1)` with room. -/
theorem entry_le_pair (hm : 3 ≤ m) (h : Fin m → ℝ) (htr : ∑ a, h a = 0) (a : Fin m) :
    ∃ a' : Fin m, a' ≠ a ∧ alphaC m * |h a| ≤ betaC m * |h a + h a'| := by
  obtain ⟨a', hne, hle⟩ := exists_pair hm h htr a
  refine ⟨a', hne, ?_⟩
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have hm1 : (0 : ℝ) < (m : ℝ) - 1 := by linarith
  have hb : (0 : ℝ) ≤ betaC m := by
    rw [betaC]; apply div_nonneg <;> linarith
  have habs : (0 : ℝ) ≤ |h a| := abs_nonneg _
  have coeff : alphaC m ≤ betaC m * (((m : ℝ) - 2) / ((m : ℝ) - 1)) := by
    rw [alphaC, betaC, div_mul_div_comm, div_le_div_iff₀ (by linarith) (by nlinarith)]
    nlinarith
  calc alphaC m * |h a| ≤ (betaC m * (((m : ℝ) - 2) / ((m : ℝ) - 1))) * |h a| :=
        mul_le_mul_of_nonneg_right coeff habs
    _ = betaC m * ((((m : ℝ) - 2) / ((m : ℝ) - 1)) * |h a|) := by ring
    _ ≤ betaC m * |h a + h a'| := mul_le_mul_of_nonneg_left hle hb

/-- **The second display.** `‖H‖_op = β · max_{a≠a'} |h_a + h_{a'}|`. -/
theorem op_eq_inblock (hm : 3 ≤ m) (h : Fin m → ℝ) (htr : ∑ a, h a = 0)
    (hne : (pairs m).Nonempty) :
    Hop h hne = (pairs m).sup' hne (fun p => betaC m * |h p.1 + h p.2|) := by
  rw [Hop, max_eq_right]
  refine Finset.sup'_le _ _ fun a _ => ?_
  obtain ⟨a', hne', hle⟩ := entry_le_pair hm h htr a
  rcases lt_or_gt_of_ne (Ne.symm hne') with hlt | hgt
  · refine le_trans hle (Finset.le_sup' (f := fun p : Fin m × Fin m => betaC m * |h p.1 + h p.2|)
      (b := (a, a')) ?_)
    simp only [pairs, Finset.mem_filter, Finset.mem_univ, true_and]
    exact hlt
  · have e : betaC m * |h a + h a'| = betaC m * |h a' + h a| := by rw [add_comm]
    rw [e] at hle
    refine le_trans hle (Finset.le_sup' (f := fun p : Fin m × Fin m => betaC m * |h p.1 + h p.2|)
      (b := (a', a)) ?_)
    simp only [pairs, Finset.mem_filter, Finset.mem_univ, true_and]
    exact hgt

/-! ## The supremum `1/√(m-1)`, and its attainment -/

/-- The sharp scalar bound behind it: for traceless `h` and `a ≠ b`,
`(h_a + h_b)² ≤ (2(m-2)/m)‖h‖²`. -/
theorem pair_sq_le (hm : 3 ≤ m) (h : Fin m → ℝ) (htr : ∑ a, h a = 0) {a b : Fin m} (hab : a ≠ b) :
    (h a + h b) ^ 2 ≤ 2 * ((m : ℝ) - 2) / (m : ℝ) * nsq h := by
  classical
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have hbmem : b ∈ Finset.univ.erase a := Finset.mem_erase.mpr ⟨Ne.symm hab, Finset.mem_univ b⟩
  set t : Finset (Fin m) := (Finset.univ.erase a).erase b with ht
  have hcardN : t.card = m - 2 := by
    rw [ht, Finset.card_erase_of_mem hbmem, Finset.card_erase_of_mem (Finset.mem_univ a),
      Finset.card_univ, Fintype.card_fin]
    omega
  have hcard : (t.card : ℝ) = (m : ℝ) - 2 := by
    rw [hcardN]
    have h2 : 2 ≤ m := by omega
    push_cast [Nat.cast_sub h2]; ring
  have hsum : ∑ c ∈ t, h c = - (h a + h b) := by
    have e1 : ∑ c ∈ t, h c + h b = ∑ c ∈ Finset.univ.erase a, h c := by
      rw [ht, Finset.sum_erase_add _ _ hbmem]
    have e2 : ∑ c ∈ Finset.univ.erase a, h c + h a = ∑ c, h c :=
      Finset.sum_erase_add _ _ (Finset.mem_univ a)
    rw [htr] at e2; linarith
  have hcs : (∑ c ∈ t, h c) ^ 2 ≤ (t.card : ℝ) * ∑ c ∈ t, (h c) ^ 2 :=
    sq_sum_le_card_mul_sum_sq
  rw [hsum, hcard] at hcs
  simp only [neg_sq] at hcs
  have hnsq : nsq h = (h a) ^ 2 + (h b) ^ 2 + ∑ c ∈ t, (h c) ^ 2 := by
    have e1 : ∑ c ∈ t, (h c) ^ 2 + (h b) ^ 2 = ∑ c ∈ Finset.univ.erase a, (h c) ^ 2 := by
      rw [ht, Finset.sum_erase_add _ _ hbmem]
    have e2 : ∑ c ∈ Finset.univ.erase a, (h c) ^ 2 + (h a) ^ 2 = ∑ c, (h c) ^ 2 :=
      Finset.sum_erase_add _ _ (Finset.mem_univ a)
    rw [nsq]; linarith
  have hab2 : (h a + h b) ^ 2 / 2 ≤ (h a) ^ 2 + (h b) ^ 2 := by nlinarith [sq_nonneg (h a - h b)]
  have k1 : ((m : ℝ) - 2) * ((h a + h b) ^ 2 / 2) ≤ ((m : ℝ) - 2) * ((h a) ^ 2 + (h b) ^ 2) :=
    mul_le_mul_of_nonneg_left hab2 (by linarith)
  have hmpos : (0 : ℝ) < (m : ℝ) := by linarith
  rw [div_mul_eq_mul_div, le_div_iff₀ hmpos, hnsq]
  linarith

/-- **The third display, as a bound.** `‖H‖²_op · (m-1) ≤ ‖H‖²_F`, i.e. `‖H‖_op ≤ ‖H‖_F/√(m-1)`. -/
theorem op_sq_le (hm : 3 ≤ m) (h : Fin m → ℝ) (htr : ∑ a, h a = 0) {a b : Fin m} (hab : a ≠ b) :
    (betaC m * |h a + h b|) ^ 2 * ((m : ℝ) - 1) ≤ HFsq h := by
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have hm1 : (0 : ℝ) < (m : ℝ) - 1 := by linarith
  have hbase := pair_sq_le hm h htr hab
  have hc : (0 : ℝ) ≤ betaC m ^ 2 * ((m : ℝ) - 1) :=
    mul_nonneg (sq_nonneg _) (le_of_lt hm1)
  have step : (betaC m ^ 2 * ((m : ℝ) - 1)) * (h a + h b) ^ 2
      ≤ (betaC m ^ 2 * ((m : ℝ) - 1)) * (2 * ((m : ℝ) - 2) / (m : ℝ) * nsq h) :=
    mul_le_mul_of_nonneg_left hbase hc
  have hid : betaC m ^ 2 * ((m : ℝ) - 1) * (2 * ((m : ℝ) - 2) / (m : ℝ))
      = (m : ℝ) * ((m : ℝ) - 2) / (2 * ((m : ℝ) - 1)) := by
    rw [betaC]; field_simp
  rw [frobenius hm h htr, mul_pow, sq_abs]
  calc betaC m ^ 2 * (h a + h b) ^ 2 * ((m : ℝ) - 1)
      = (betaC m ^ 2 * ((m : ℝ) - 1)) * (h a + h b) ^ 2 := by ring
    _ ≤ (betaC m ^ 2 * ((m : ℝ) - 1)) * (2 * ((m : ℝ) - 2) / (m : ℝ) * nsq h) := step
    _ = (betaC m ^ 2 * ((m : ℝ) - 1) * (2 * ((m : ℝ) - 2) / (m : ℝ))) * nsq h := by ring
    _ = (m : ℝ) * ((m : ℝ) - 2) / (2 * ((m : ℝ) - 1)) * nsq h := by rw [hid]

/-! ### The pair-concentrated witness -/

/-- The pair-concentrated `h`: `1` at two coordinates, `-2/(m-2)` at the rest. -/
noncomputable def witness (m : ℕ) : Fin m → ℝ :=
  fun a => if a.val < 2 then 1 else -2 / ((m : ℝ) - 2)

theorem witness_card (hm : 3 ≤ m) :
    ((Finset.univ.filter (fun a : Fin m => a.val < 2)).card : ℝ) = 2 := by
  classical
  have hset : Finset.univ.filter (fun a : Fin m => a.val < 2)
      = {(⟨0, by omega⟩ : Fin m), (⟨1, by omega⟩ : Fin m)} := by
    ext a
    simp only [Finset.mem_filter, Finset.mem_univ, true_and, Finset.mem_insert,
      Finset.mem_singleton]
    constructor
    · intro hlt
      rcases (by omega : a.val = 0 ∨ a.val = 1) with h0 | h1
      · exact Or.inl (Fin.ext (by simpa using h0))
      · exact Or.inr (Fin.ext (by simpa using h1))
    · rintro (rfl | rfl) <;> simp
  have : (Finset.univ.filter (fun a : Fin m => a.val < 2)).card = 2 := by
    rw [hset, Finset.card_insert_of_notMem (by simp [Fin.ext_iff]), Finset.card_singleton]
  rw [this]; norm_num

theorem witness_traceless (hm : 3 ≤ m) : ∑ a, witness m a = 0 := by
  classical
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have hm2 : ((m : ℝ) - 2) ≠ 0 := by linarith
  have hrw : ∀ a : Fin m, witness m a
      = (-2 / ((m : ℝ) - 2)) + (if a.val < 2 then 1 + 2 / ((m : ℝ) - 2) else 0) := by
    intro a
    by_cases hv : a.val < 2
    · simp only [witness, if_pos hv]; field_simp; ring
    · simp only [witness, if_neg hv, add_zero]
  rw [Finset.sum_congr rfl (fun a _ => hrw a), Finset.sum_add_distrib, Finset.sum_const,
    Finset.card_univ, Fintype.card_fin, ← Finset.sum_filter, Finset.sum_const,
    nsmul_eq_mul, nsmul_eq_mul, witness_card hm]
  field_simp
  ring

theorem witness_nsq (hm : 3 ≤ m) : nsq (witness m) = 2 * (m : ℝ) / ((m : ℝ) - 2) := by
  classical
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have hm2 : ((m : ℝ) - 2) ≠ 0 := by linarith
  have hrw : ∀ a : Fin m, (witness m a) ^ 2
      = (-2 / ((m : ℝ) - 2)) ^ 2
        + (if a.val < 2 then 1 - (-2 / ((m : ℝ) - 2)) ^ 2 else 0) := by
    intro a
    by_cases hv : a.val < 2
    · simp only [witness, if_pos hv]; ring
    · simp only [witness, if_neg hv, add_zero]
  rw [nsq, Finset.sum_congr rfl (fun a _ => hrw a), Finset.sum_add_distrib, Finset.sum_const,
    Finset.card_univ, Fintype.card_fin, ← Finset.sum_filter, Finset.sum_const,
    nsmul_eq_mul, nsmul_eq_mul, witness_card hm]
  field_simp
  ring

/-- **The bound is attained**, at the pair-concentrated `h`: equality in `op_sq_le`, so the
supremum of `‖H‖_op/‖H‖_F` is exactly `1/√(m-1)`. -/
theorem op_sq_eq_at_witness (hm : 3 ≤ m) {a b : Fin m} (ha : a.val < 2) (hb : b.val < 2)
    (hab : a ≠ b) :
    (betaC m * |witness m a + witness m b|) ^ 2 * ((m : ℝ) - 1) = HFsq (witness m) := by
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  have hm1 : ((m : ℝ) - 1) ≠ 0 := by linarith
  have hm2 : ((m : ℝ) - 2) ≠ 0 := by linarith
  have wa : witness m a = 1 := by simp only [witness, if_pos ha]
  have wb : witness m b = 1 := by simp only [witness, if_pos hb]
  rw [frobenius hm _ (witness_traceless hm), witness_nsq hm, betaC, wa, wb]
  norm_num
  field_simp

/-- The witness is a genuine element of `S²₀(ℝᵐ)`: traceless and nonzero. -/
example (hm : 3 ≤ m) : ∑ a, witness m a = 0 ∧ nsq (witness m) ≠ 0 := by
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  refine ⟨witness_traceless hm, ?_⟩
  rw [witness_nsq hm]
  have hp : (0 : ℝ) < 2 * (m : ℝ) / ((m : ℝ) - 2) := by
    apply div_pos <;> linarith
  linarith

/-! ## The joint two-copy eigenspace: the one clause of the extension that is typed -/

/-- The record's reason that the supremum survives the two-copy cross branch, in squared form:
`(√(m-2)/m)² < (1/√(m-1))²`, i.e. `(m-1)(m-2) < m²`. -/
theorem cross_branch_below_sup (hm : 3 ≤ m) :
    ((m : ℝ) - 2) / (m : ℝ) ^ 2 < 1 / ((m : ℝ) - 1) := by
  have hmR : (3 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
  rw [div_lt_div_iff₀ (by positivity) (by linarith)]
  nlinarith

end HamiltonsCubic.L146Statement
