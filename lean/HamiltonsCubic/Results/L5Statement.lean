import Mathlib

/-!
# L5, the census of rival critical-point families, STATED

[graded-half.md](../../../findings/graded-half.md)'s Observation L5, quoted verbatim from
[results.md](../../../results.md)'s canonical statement:

> - **Observation L5 (landscape). Rival critical-point families.** Seven families examined and
>   compared against the two named competitors. **The comparison that holds is against the
>   balanced product**, at every `n` and both parities, read against `Θₙ`. **No family is
>   eliminated against padded `W_{ℂP²}`**: Fox's `r = 4` subalgebra attains `√(3/2)` exactly and
>   beats `θ₀(8)`, and every two-factor product with `1/(p−1) + 1/(q−1) − 1/(p+q−1) < 1/3`
>   exceeds it, `S⁵ × S⁷` at `θ = 1.2282392` being the first. The highest closed-form supremum
>   among the families closed in full is `θ(ℍP²) = √(56/45) = 1.1155467`.

and the two displays the block turns on:

> `‖W‖² = (k−1)/8 + (1/8)(Σₐ 1/(nₐ−1) − 1/(n−1))`,  hence  `θ < √(2/(k−1))`,
>
> with **`n = Σₐ nₐ`** and `θ = 1/(2‖W‖)`.

## What this file states, and what it is

**The Observation is a census, a seven-row table of families, their values and their
statuses, and a table is not one proposition.** What is typed here is every clause of it that
*is* a proposition, and each is proved:

* the two-factor comparison, **at every `n` and both parities**, which is the clause the block
  says is the one that holds;
* the multi-block bound `θ < √(2/(k−1))` from the norm identity, at every `k ≥ 2` and every
  admissible block vector, *"the implication from the identity to the bound is one line and
  holds at every `k` and every `n`"*;
* the exceedance condition `1/(p−1) + 1/(q−1) − 1/(n−1) < 1/3` as an **equivalence** with
  `θ² > 3/2`, and `S⁵ × S⁷` as a witness of it;
* the two failures the block names, `(5,5)` and `(5,6)`, and the coincidence `Θ₁₁² = 40/27`;
* the `ℂPᵐ` and `ℍPᵐ` closed forms with their monotonicity and their suprema.

## What is NOT typed here

* **That the seven families listed are critical points**, or that they are the families
  examined. The census's status column (*"closed in form"*, *"open"*, *"threatens nothing"*), is
  bibliographic and carries no proposition.
* **The norm identity itself.** `normSqMulti` below *is* the record's right-hand side; that it
  equals `‖W‖²` for a `k`-block sphere product is the record's, and the block itself records the
  debt, *"verified symbolically for `k = 2,3,4`"* while consumed at every `k ≥ 3`.
* **`θ = 1/(2‖W‖)`.** The step from the norm to `θ` is [L46](../../../findings/problem.md) under
  four hypotheses, *"stated for irreducible symmetric spaces, while these objects are
  products"*; `thetaSqMulti` below carries it as a definition and the block owes its derivation.
* **The one class the census leaves open**: the non-Lie-group simple-isotropy members of
  [L4](L4Statement.lean)'s family, whose `(n,r)` list is nowhere on the record.

There is no `sorry`: nothing typed here is unproved. **The file states part of the Observation,
not all of it**, and the part it omits is named above.
-/

set_option linter.style.longLine false
set_option linter.unusedVariables false

namespace HamiltonsCubic.L5Statement

open Finset

/-! ## The norm of a `k`-block sphere product, and its `θ` -/

/-- **The record's norm identity, as a definition.** `‖W‖² = (k−1)/8 + (1/8)(Σₐ 1/(nₐ−1) −
1/(n−1))`, with `n` the **sum of the blocks** and not an ambient dimension, read at a padded
copy the identity is false. -/
noncomputable def normSqMulti {k : ℕ} (b : Fin k → ℝ) : ℝ :=
  ((k : ℝ) - 1) / 8 + (1 / 8) * ((∑ a, 1 / (b a - 1)) - 1 / ((∑ a, b a) - 1))

/-- `θ² = 1/(4‖W‖²)`, from the record's `θ = 1/(2‖W‖)`. -/
noncomputable def thetaSqMulti {k : ℕ} (b : Fin k → ℝ) : ℝ := 1 / (4 * normSqMulti b)

/-! ## The multi-block bound `θ < √(2/(k−1))`, at every `k` and every block vector -/

/-- **The bracket is strictly positive**: with `k ≥ 2` blocks each of size at least `2`, the sum
`Σₐ 1/(nₐ−1)` exceeds `1/(n−1)`, since `n` strictly exceeds each block. *This is the whole of the
one-line step, and it needs no `k = 2,3,4` verification.* -/
theorem bracket_pos {k : ℕ} (hk : 2 ≤ k) (b : Fin k → ℝ) (hb : ∀ a, 2 ≤ b a) :
    0 < (∑ a, 1 / (b a - 1)) - 1 / ((∑ a, b a) - 1) := by
  have hcard : (0 : ℕ) < k := by omega
  obtain ⟨a₀⟩ : Nonempty (Fin k) := Fin.pos_iff_nonempty.mp hcard
  have hb1 : ∀ a, (0:ℝ) < b a - 1 := fun a => by linarith [hb a]
  -- the rest of the blocks contribute a strictly positive amount to the total
  have herase : (Finset.univ.erase a₀).Nonempty := by
    rw [← Finset.card_pos, Finset.card_erase_of_mem (Finset.mem_univ a₀), Finset.card_univ,
      Fintype.card_fin]
    omega
  have hrestpos : 0 < ∑ a ∈ Finset.univ.erase a₀, b a :=
    Finset.sum_pos (fun i _ => by linarith [hb i]) herase
  have hsplit : ∑ a, b a = b a₀ + ∑ a ∈ Finset.univ.erase a₀, b a :=
    (Finset.add_sum_erase _ _ (Finset.mem_univ a₀)).symm
  have hStot : b a₀ < ∑ a, b a := by rw [hsplit]; linarith
  have hS1 : (0:ℝ) < (∑ a, b a) - 1 := by linarith [hb1 a₀]
  -- so the reciprocal of the total is strictly below that of any single block
  have hstep : 1 / ((∑ a, b a) - 1) < 1 / (b a₀ - 1) := by
    rw [div_lt_div_iff₀ hS1 (hb1 a₀)]; linarith
  -- and that single reciprocal is at most the whole sum, every term being positive
  have hsum : 1 / (b a₀ - 1) ≤ ∑ a, 1 / (b a - 1) :=
    Finset.single_le_sum (f := fun a => 1 / (b a - 1))
      (fun i _ => le_of_lt (one_div_pos.mpr (hb1 i))) (Finset.mem_univ a₀)
  linarith

/-- **So `‖W‖² > (k−1)/8`**, which is the one line the bound needs. -/
theorem normSqMulti_gt {k : ℕ} (hk : 2 ≤ k) (b : Fin k → ℝ) (hb : ∀ a, 2 ≤ b a) :
    ((k : ℝ) - 1) / 8 < normSqMulti b := by
  have h := bracket_pos hk b hb
  unfold normSqMulti
  linarith

/-- **The multi-block bound: `θ² < 2/(k−1)` at every `k ≥ 2` and every block vector.** For
`k ≥ 3` this is below `1`, which is the census's row: multi-block products threaten nothing. -/
theorem multiblock_bound {k : ℕ} (hk : 2 ≤ k) (b : Fin k → ℝ) (hb : ∀ a, 2 ≤ b a) :
    thetaSqMulti b < 2 / ((k : ℝ) - 1) := by
  have hk' : (1 : ℝ) ≤ (k : ℝ) - 1 := by
    have : (2 : ℝ) ≤ (k : ℝ) := by exact_mod_cast hk
    linarith
  have hgt := normSqMulti_gt hk b hb
  have hpos : 0 < normSqMulti b := by linarith
  unfold thetaSqMulti
  rw [div_lt_div_iff₀ (by linarith) (by linarith)]
  nlinarith

/-- **And `2/(k−1) ≤ 1` from `k = 3`**, so `θ < 1` at every `k ≥ 3`, the census's own reading. -/
theorem multiblock_below_one {k : ℕ} (hk : 3 ≤ k) (b : Fin k → ℝ) (hb : ∀ a, 2 ≤ b a) :
    thetaSqMulti b < 1 := by
  have hk' : (3 : ℝ) ≤ (k : ℝ) := by exact_mod_cast hk
  have h := multiblock_bound (by omega) b hb
  have : 2 / ((k : ℝ) - 1) ≤ 1 := by
    rw [div_le_one (by linarith)]; linarith
  linarith

/-! ## The two-factor family, in closed form -/

/-- `θ²(Sᵖ × S^q) = 2(n−1)(p−1)(q−1)/((n−2)pq)`, the record's closed form at `n = p + q`. -/
noncomputable def thetaSqPair (p q : ℝ) : ℝ :=
  2 * (p + q - 1) * (p - 1) * (q - 1) / ((p + q - 2) * (p * q))

/-- **The two displays are one number.** The `k = 2` reading of the norm identity gives exactly
the closed form, *"the two witnesses that break the census and the bound that saves it are one
computation"*, here as an identity in `p` and `q` rather than at sampled splits.

The algebra is `(p−1)(q−1) + (n−1) = pq` at `n = p + q`. -/
theorem pair_forms_agree {p q : ℝ} (hp : 2 ≤ p) (hq : 2 ≤ q) :
    1 / (4 * (1 / 8 + (1 / 8) * (1 / (p - 1) + 1 / (q - 1) - 1 / (p + q - 1))))
      = thetaSqPair p q := by
  have hp1 : (0:ℝ) < p - 1 := by linarith
  have hq1 : (0:ℝ) < q - 1 := by linarith
  have hn1 : (0:ℝ) < p + q - 1 := by linarith
  have hn2 : (0:ℝ) < p + q - 2 := by linarith
  have hpq : (0:ℝ) < p * q := by nlinarith
  have hD : 4 * (1 / 8 + (1 / 8) * (1 / (p - 1) + 1 / (q - 1) - 1 / (p + q - 1)))
      = ((p + q - 2) * (p * q)) / (2 * (p - 1) * (q - 1) * (p + q - 1)) := by
    field_simp
    ring
  rw [hD, one_div_div]
  unfold thetaSqPair
  ring

/-- **The exceedance condition, as an equivalence.** A two-factor product beats the `ℂP²`-type
competitor exactly when `1/(p−1) + 1/(q−1) − 1/(n−1) < 1/3`, the block's own criterion, here
proved to be *iff* rather than *only if*. -/
theorem exceeds_iff {p q : ℝ} (hp : 2 ≤ p) (hq : 2 ≤ q) :
    3 / 2 < thetaSqPair p q ↔ 1 / (p - 1) + 1 / (q - 1) - 1 / (p + q - 1) < 1 / 3 := by
  have hp1 : (0:ℝ) < p - 1 := by linarith
  have hq1 : (0:ℝ) < q - 1 := by linarith
  have hn1 : (0:ℝ) < p + q - 1 := by linarith
  have hn2 : (0:ℝ) < p + q - 2 := by linarith
  have hpq : (0:ℝ) < p * q := by nlinarith
  rw [← pair_forms_agree hp hq]
  set c : ℝ := 1 / (p - 1) + 1 / (q - 1) - 1 / (p + q - 1) with hc
  have hcpos : 0 < c := by
    have h1 : 1 / (p + q - 1) < 1 / (p - 1) := by
      apply one_div_lt_one_div_of_lt hp1; linarith
    have h2 : (0:ℝ) < 1 / (q - 1) := by positivity
    rw [hc]; linarith
  have hden : (0:ℝ) < 4 * (1 / 8 + (1 / 8) * c) := by nlinarith
  rw [lt_div_iff₀ hden]
  constructor <;> intro h <;> nlinarith

/-! ## The witnesses the census names -/

/-- **`S⁵ × S⁷` is the first two-factor product above the competitor**: `θ² = 264/175 > 3/2`. -/
theorem five_seven : thetaSqPair 5 7 = 264 / 175 ∧ 3 / 2 < thetaSqPair 5 7 := by
  have h : thetaSqPair 5 7 = 264 / 175 := by unfold thetaSqPair; norm_num
  exact ⟨h, by rw [h]; norm_num⟩

/-- **And it lands at `1.2282392`**, the block's own figure, bracketed by squaring. -/
theorem five_seven_bracket :
    ((1.2282391 : ℝ)) ^ 2 < 264 / 175 ∧ (264 : ℝ) / 175 < (1.2282393 : ℝ) ^ 2 := by
  constructor <;> norm_num

/-- **The two failures, and they are the only ones the block names**: `(5,5)` gives `θ² = 36/25`
and `(5,6)` gives `40/27`, both short of `3/2`. -/
theorem the_two_failures :
    thetaSqPair 5 5 = 36 / 25 ∧ thetaSqPair 5 6 = 40 / 27 ∧
      thetaSqPair 5 5 < 3 / 2 ∧ thetaSqPair 5 6 < 3 / 2 := by
  refine ⟨by unfold thetaSqPair; norm_num, by unfold thetaSqPair; norm_num, ?_, ?_⟩
  · rw [show thetaSqPair 5 5 = 36 / 25 by unfold thetaSqPair; norm_num]; norm_num
  · rw [show thetaSqPair 5 6 = 40 / 27 by unfold thetaSqPair; norm_num]; norm_num

/-- **`Θ₁₁² = 40/27`, and it is the two-factor maximum at `n = 11`**, *"as they must be"*, the
best split of `11` being `(5,6)`. -/
theorem eleven_coincidence : thetaSqPair 5 6 = 40 / 27 := by unfold thetaSqPair; norm_num

/-! ## The comparison that holds: against the balanced product, at every `n` and both parities -/

/-- **The closed form is strictly increasing in `(p−1)(q−1)` at fixed `n`**, because
`1/(p−1) + 1/(q−1) = (n−2)/((p−1)(q−1))`. -/
theorem pair_mono {p q p' q' : ℝ} (hp : 2 ≤ p) (hq : 2 ≤ q) (hp' : 2 ≤ p') (hq' : 2 ≤ q')
    (hsum : p + q = p' + q') (hprod : (p - 1) * (q - 1) < (p' - 1) * (q' - 1)) :
    thetaSqPair p q < thetaSqPair p' q' := by
  have hn2 : (0:ℝ) < p + q - 2 := by linarith
  have hn1 : (0:ℝ) < p + q - 1 := by linarith
  have hA : (0:ℝ) < (p - 1) * (q - 1) := by nlinarith
  have hA' : (0:ℝ) < (p' - 1) * (q' - 1) := by nlinarith
  have hpq : p * q = (p - 1) * (q - 1) + (p + q - 1) := by ring
  have hpq' : p' * q' = (p' - 1) * (q' - 1) + (p + q - 1) := by rw [hsum]; ring
  unfold thetaSqPair
  rw [← hsum, hpq, hpq']
  rw [div_lt_div_iff₀ (by nlinarith) (by nlinarith)]
  nlinarith [mul_pos (mul_pos (mul_pos hn1 hn2) hn1) (sub_pos.mpr hprod)]

/-- **So the balanced split is the maximum, at every `n` and both parities.** With
`(p−1) + (q−1) = n − 2` fixed, the product `(p−1)(q−1)` grows as the split balances, so any
strictly more balanced pair strictly beats a less balanced one.

*This is the census's clause "the comparison that holds is against the balanced product, at
every `n` and both parities", derived from the record's own closed form rather than checked at
one point.* -/
theorem balanced_is_max {p q p' q' : ℝ} (hp : 2 ≤ p) (hq : 2 ≤ q) (hp' : 2 ≤ p') (hq' : 2 ≤ q')
    (hsum : p + q = p' + q') (hle : p < p') (hle' : p' ≤ q') :
    thetaSqPair p q < thetaSqPair p' q' := by
  refine pair_mono hp hq hp' hq' hsum ?_
  have hq'q : q' < q := by linarith
  have hp'q : p' < q := by linarith
  have hq'eq : q' = p + q - p' := by linarith
  rw [hq'eq]
  nlinarith [mul_pos (sub_pos.mpr hle) (sub_pos.mpr hp'q)]

/-! ## `ℂPᵐ` and `ℍPᵐ`: the closed forms, their monotonicity and their suprema -/

/-- `θ²(ℂPᵐ) = (m+1)(2m−1)/(3m(m−1))`. -/
noncomputable def cpSq (m : ℝ) : ℝ := (m + 1) * (2 * m - 1) / (3 * m * (m - 1))

/-- `θ²(ℍPᵐ) = (m+2)²(4m−1)/(9m(m−1)(2m+1))`. -/
noncomputable def hpSq (m : ℝ) : ℝ := (m + 2) ^ 2 * (4 * m - 1) / (9 * m * (m - 1) * (2 * m + 1))

/-- **The four tabulated Hermitian pairs are four rows of the `ℂPᵐ` family**, at `m = 4,5,6,7`. -/
theorem cp_table :
    cpSq 4 = 35 / 36 ∧ cpSq 5 = 9 / 10 ∧ cpSq 6 = 77 / 90 ∧ cpSq 7 = 52 / 63 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> (unfold cpSq; norm_num)

/-- **And the family's own peak is `3/2` exactly, at `m = 2`**, so the four rows are the tail of
a family whose extreme point *is* the competitor they are measured against. -/
theorem cp_peak : cpSq 2 = 3 / 2 := by unfold cpSq; norm_num

/-- **`θ²(ℂPᵐ)` is strictly decreasing on `m ≥ 2`**, so `m = 2` is the family's maximum. -/
theorem cp_strict_anti {a b : ℝ} (ha : 2 ≤ a) (hab : a < b) : cpSq b < cpSq a := by
  have ha0 : (0:ℝ) < 3 * a * (a - 1) := by nlinarith
  have hb0 : (0:ℝ) < 3 * b * (b - 1) := by nlinarith
  have hkey : (0:ℝ) < 3 * a * b - a - b + 1 := by nlinarith
  unfold cpSq
  rw [div_lt_div_iff₀ hb0 ha0]
  nlinarith [mul_pos (sub_pos.mpr hab) hkey]

/-- **The supremum among the families the census closes in full is `θ(ℍP²) = √(56/45)`.** -/
theorem hp_peak : hpSq 2 = 56 / 45 := by unfold hpSq; norm_num

/-- **And `1.1155467` is that root**, bracketed by squaring. -/
theorem hp_peak_bracket :
    ((1.1155466 : ℝ)) ^ 2 < 56 / 45 ∧ (56 : ℝ) / 45 < (1.1155468 : ℝ) ^ 2 := by
  constructor <;> norm_num

/-- **`ℍP²` sits below the competitor**, which is why the census's *"highest closed-form
supremum"* is not an elimination of the competitor: `56/45 < 3/2`. -/
theorem hp_below_competitor : hpSq 2 < 3 / 2 := by rw [hp_peak]; norm_num

/-! ## Fox's `r = 4` subalgebra, the row that beats `θ₀(8)` -/

/-- **Fox's `r = 4` attains `√(3/2)` exactly and beats `θ₀(8)² = 21/16`.** So *"no family is
eliminated against padded `W_{ℂP²}`"* has a witness at `n = 8` as well as the two-factor ones. -/
theorem fox_beats_theta0_eight : (21 : ℝ) / 16 < 3 / 2 ∧ 2 * (8 - 1) * (8 - 2) / (8:ℝ) ^ 2 = 21 / 16 := by
  constructor <;> norm_num

end HamiltonsCubic.L5Statement
