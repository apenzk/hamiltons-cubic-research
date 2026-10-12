import Mathlib
import HamiltonsCubic.Results.L83

set_option linter.style.longLine false

/-!
# L84, Casimir separation is forced, and it is the PAIR `(C₂, C₄)` that does it

**The record's statement, quoted verbatim from [sym3-blocks.md](../../../findings/sym3-blocks.md):**

> #### Lemma L84 (Casimir separation is forced, not measured), the PAIR $(C_2,C_4)$ separates all $24$
>
> **THE FORCING IS A GENUINE THEOREM, WITH NO TABLE AND NO CASE CHECK.** $Z(U(\mathfrak{so}(5)))\cong S(\mathfrak h)^{W(B_2)}=\mathbb R[p_2,p_4]$, and for dominant $\lambda$ the shift $\ell=\lambda+\rho$ is **strictly** dominant automatically ($\rho=(3/2,1/2)$ having strictly positive decreasing entries) so a regular $\ell$ meets the open chamber once and $\chi_\lambda$ separates **all** dominant $B_2$ weights. **Exactly two power sums suffice, degrees $2$ and $4$**; beyond $p_4$ Newton makes everything redundant. **The `Lemma` label is right.**
>
> **BUT "THE QUARTIC GENERATOR" PRESUPPOSES A DISTINGUISHED ELEMENT, AND THERE IS NONE.** $z_4'=z_4+\alpha z_2^2+\beta z_2+\gamma$ generates for **every** choice, and at $\alpha=-\tfrac12$ the image takes only **18** values on the $24$ blocks, *worse than $c_2$'s $21$.* **What is forced is the pair $(C_2,C_4)$**, not any single quartic; and the block's follow-up that *"$C_2^2$ separates nothing"* is also false, it separates the same $21$ classes $C_2$ does.
>
> **THE NUMBERS ALL REPRODUCE BY HAND.** $c_2$ over the $24$ weights gives **$21$ distinct values with exactly the three named collisions** at $30$, $40$ and $60$, and all six $p_4$ rationals match in the printed order. *A free second anchor the block misses: $p_2=c_2+\tfrac52$, so colliding pairs must share $p_2$, and they do, which independently confirms $\rho$.*
>
> For a dominant $B_2$ weight $\ell_1>\ell_2>0$, so $e_1=p_2$ and $e_2=(p_2^2-p_4)/2$ recover $\{\ell_1^2,\ell_2^2\}$ as a multiset and hence recover $\lambda$.

## What this file states

The forcing itself (`pair_separates` and `casimir_pair_separates`), is the theorem the audit says
is genuine, and it is stated **over all dominant `B₂` weights**, with no table and no case check.
Everything is proved; there is no `sorry`.

* `rho_strictly_dominant`, `ρ = (3/2, 1/2)` makes `ℓ = λ + ρ` satisfy `ℓ₁ > ℓ₂ > 0` for every
  dominant `λ`, automatically.
* `pair_separates`, `(p₂, p₄)` is injective on strictly dominant `ℓ`. *This is the Newton step:
  `e₂ = (p₂² - p₄)/2`, and `ℓ₁² > ℓ₂² > 0` orders the recovered multiset.*
* `casimir_pair_separates`, hence `(C₂, C₄)` separates all dominant `B₂` weights, the `24` blocks
  of [L83](L83.lean) among them.
* `p2_eq_c2_add`, the free second anchor `p₂ = c₂ + 5/2`, which is where `ρ` shows in the numbers.
* `three_collisions` and `c2_distinct_21`, `c₂` alone gives `21` values with exactly the three
  named collisions, decided against [L83](L83.lean)'s stored table.
* `quartic_shift_still_separates`, `z₄' = z₄ + α z₂² + β z₂ + γ` serves as the second member for
  **every** `α, β, γ`, so no quartic is distinguished.
* `alpha_half_collides`, and a single quartic is not enough: at `α = -1/2` the blocks `(2,2)` and
  `(1,0)` share the value `18` while `c₂` separates them at `16` against `4`. **So that quartic is
  strictly worse than `c₂`**, which is the audit's count.
* `sq_same_fibres`, squaring is injective on non-negatives, so `C₂²` has exactly `C₂`'s fibres and
  the block's *"`C₂²` separates nothing"* is false.

## What is NOT typed here

* **`Z(U(𝔰𝔬(5))) ≅ S(𝔥)^{W(B₂)} = ℝ[p₂, p₄]`, and the Harish-Chandra isomorphism.** That is the
  imported Lie theory, and Mathlib does not carry it. What is typed is the separation statement
  the isomorphism reduces to (that `(p₂, p₄)` is injective on shifted dominant weights) which is
  the part the audit calls *"a genuine theorem, with no table and no case check"*.
* **That the `24` weights of [L83](L83.lean)'s table are the highest weights of `Sym³ 𝒲₅`.** That
  is L83's imported column; here it is a stored list.
-/

namespace HamiltonsCubic.L84Statement

open HamiltonsCubic.Blocks

/-! ## The shift, and the two power sums -/

/-- `ℓ₁ = λ₁ + 3/2`. -/
def ell1 (a : ℕ) : ℚ := (a : ℚ) + 3 / 2

/-- `ℓ₂ = λ₂ + 1/2`. -/
def ell2 (b : ℕ) : ℚ := (b : ℚ) + 1 / 2

/-- `p₂(ℓ) = ℓ₁² + ℓ₂²`. -/
def p2 (a b : ℕ) : ℚ := ell1 a ^ 2 + ell2 b ^ 2

/-- `p₄(ℓ) = ℓ₁⁴ + ℓ₂⁴`. -/
def p4 (a b : ℕ) : ℚ := ell1 a ^ 4 + ell2 b ^ 4

/-- The quadratic Casimir `c₂(λ) = λ₁(λ₁+3) + λ₂(λ₂+1)`. -/
def c2Q (a b : ℕ) : ℚ := (a : ℚ) * (a + 3) + (b : ℚ) * (b + 1)

/-- **`ρ = (3/2, 1/2)` has strictly positive decreasing entries, so `ℓ = λ + ρ` is STRICTLY
dominant for every dominant `λ`**, automatically, which is the step the forcing turns on. -/
theorem rho_strictly_dominant {a b : ℕ} (hab : b ≤ a) : 0 < ell2 b ∧ ell2 b < ell1 a := by
  have : (b : ℚ) ≤ (a : ℚ) := by exact_mod_cast hab
  constructor
  · unfold ell2; positivity
  · unfold ell1 ell2; linarith

/-- **The free second anchor: `p₂ = c₂ + 5/2`.** Colliding pairs must therefore share `p₂`, which
is what confirms `ρ` from the numbers alone. -/
theorem p2_eq_c2_add (a b : ℕ) : p2 a b = c2Q a b + 5 / 2 := by
  unfold p2 c2Q ell1 ell2; ring

/-! ## The forcing -/

private theorem sq_eq_of_pos {x y : ℚ} (hx : 0 < x) (hy : 0 < y) (h : x ^ 2 = y ^ 2) : x = y := by
  have hfac : (x - y) * (x + y) = 0 := by linear_combination h
  rcases mul_eq_zero.mp hfac with h' | h'
  · linarith
  · linarith

/-- **EXACTLY TWO POWER SUMS SUFFICE.** On strictly dominant `ℓ`, `(p₂, p₄)` determines `ℓ`:
`e₂ = (p₂² - p₄)/2` recovers `{ℓ₁², ℓ₂²}` as a multiset, and `ℓ₁ > ℓ₂ > 0` orders it. *Beyond `p₄`
Newton makes everything redundant.* -/
theorem pair_separates {l1 l2 m1 m2 : ℚ} (hl2 : 0 < l2) (hl : l2 < l1) (hm2 : 0 < m2)
    (hm : m2 < m1) (h2 : l1 ^ 2 + l2 ^ 2 = m1 ^ 2 + m2 ^ 2)
    (h4 : l1 ^ 4 + l2 ^ 4 = m1 ^ 4 + m2 ^ 4) : l1 = m1 ∧ l2 = m2 := by
  have hl1 : 0 < l1 := lt_trans hl2 hl
  have hm1 : 0 < m1 := lt_trans hm2 hm
  have hprod : l1 ^ 2 * l2 ^ 2 = m1 ^ 2 * m2 ^ 2 := by nlinarith [h2, h4]
  have hd1 : 0 < l1 ^ 2 - l2 ^ 2 := by nlinarith
  have hd2 : 0 < m1 ^ 2 - m2 ^ 2 := by nlinarith
  have hdiff : (l1 ^ 2 - l2 ^ 2) ^ 2 = (m1 ^ 2 - m2 ^ 2) ^ 2 := by nlinarith [h2, hprod]
  have hdd : l1 ^ 2 - l2 ^ 2 = m1 ^ 2 - m2 ^ 2 := sq_eq_of_pos hd1 hd2 hdiff
  have hs1 : l1 ^ 2 = m1 ^ 2 := by linarith
  have hs2 : l2 ^ 2 = m2 ^ 2 := by linarith
  exact ⟨sq_eq_of_pos hl1 hm1 hs1, sq_eq_of_pos hl2 hm2 hs2⟩

/-- **So the PAIR `(C₂, C₄)` separates all dominant `B₂` weights**, every one of L83's `24`
blocks among them, with no table and no case check. -/
theorem casimir_pair_separates {a b a' b' : ℕ} (hab : b ≤ a) (hab' : b' ≤ a')
    (h2 : p2 a b = p2 a' b') (h4 : p4 a b = p4 a' b') : a = a' ∧ b = b' := by
  obtain ⟨hl2, hl⟩ := rho_strictly_dominant hab
  obtain ⟨hm2, hm⟩ := rho_strictly_dominant hab'
  obtain ⟨e1, e2⟩ := pair_separates hl2 hl hm2 hm h2 h4
  constructor
  · have : (a : ℚ) = (a' : ℚ) := by unfold ell1 at e1; linarith
    exact_mod_cast this
  · have : (b : ℚ) = (b' : ℚ) := by unfold ell2 at e2; linarith
    exact_mod_cast this

/-! ## No quartic is distinguished -/

/-- **`z₄' = z₄ + α z₂² + β z₂ + γ` serves for EVERY `α, β, γ`.** Paired with `p₂` it separates
exactly what `(p₂, p₄)` separates, so the block's *"the quartic generator"* presupposes a
distinguished element that does not exist. -/
theorem quartic_shift_still_separates (α β γ : ℚ) {a b a' b' : ℕ} (hab : b ≤ a) (hab' : b' ≤ a')
    (h2 : p2 a b = p2 a' b')
    (h4 : p4 a b + α * p2 a b ^ 2 + β * p2 a b + γ
        = p4 a' b' + α * p2 a' b' ^ 2 + β * p2 a' b' + γ) : a = a' ∧ b = b' := by
  refine casimir_pair_separates hab hab' h2 ?_
  rw [h2] at h4
  linarith

/-- **And a single quartic is not enough.** At `α = -1/2` the blocks `(2,2)` and `(1,0)` share the
value `18`, while `c₂` separates them at `16` against `4`, so that quartic is **strictly worse
than `c₂`**, which is the audit's count of `18` values against `21`. -/
theorem alpha_half_collides :
    p4 2 2 + (-1/2 : ℚ) * p2 2 2 ^ 2 = 18 ∧ p4 1 0 + (-1/2 : ℚ) * p2 1 0 ^ 2 = 18 ∧
      c2Q 2 2 = 16 ∧ c2Q 1 0 = 4 := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> · simp only [p4, p2, c2Q, ell1, ell2]; norm_num

/-- **`C₂²` has exactly `C₂`'s fibres**, since squaring is injective on non-negatives. The block's
follow-up that *"`C₂²` separates nothing"* is false. -/
theorem sq_same_fibres {x y : ℚ} (hx : 0 ≤ x) (hy : 0 ≤ y) : x ^ 2 = y ^ 2 ↔ x = y := by
  constructor
  · intro h
    have hfac : (x - y) * (x + y) = 0 := by linear_combination h
    rcases mul_eq_zero.mp hfac with h' | h'
    · linarith
    · nlinarith
  · intro h; rw [h]

/-- `c₂` is non-negative on every dominant weight, which is what makes `sq_same_fibres` apply. -/
theorem c2Q_nonneg (a b : ℕ) : 0 ≤ c2Q a b := by
  unfold c2Q; positivity

/-! ## The numbers, against L83's stored table -/

/-- `c₂` on a stored block. -/
def c2N (B : Block) : ℕ := B.a * (B.a + 3) + B.b * (B.b + 1)

/-- **`c₂` takes `21` distinct values across the `24` blocks**, `24` less three colliding pairs. -/
theorem c2_distinct_21 : (table.map c2N).dedup.length = 21 := by decide

/-- **The three named collisions, and no others**: `(4,1)` with `(3,3)` at `30`, `(4,3)` with
`(5,0)` at `40`, `(5,4)` with `(6,2)` at `60`. -/
theorem three_collisions :
    c2N ⟨4, 1, 2⟩ = 30 ∧ c2N ⟨3, 3, 1⟩ = 30 ∧
      c2N ⟨4, 3, 2⟩ = 40 ∧ c2N ⟨5, 0, 1⟩ = 40 ∧
      c2N ⟨5, 4, 1⟩ = 60 ∧ c2N ⟨6, 2, 1⟩ = 60 := by decide

/-- **And `p₄` separates the three collided pairs**, the six rationals the block prints. -/
theorem p4_splits_the_collisions :
    p4 4 1 ≠ p4 3 3 ∧ p4 4 3 ≠ p4 5 0 ∧ p4 5 4 ≠ p4 6 2 := by
  refine ⟨?_, ?_, ?_⟩ <;> · unfold p4 ell1 ell2; norm_num

/-- The six printed values of `p₄` on the colliding pairs, in the record's order. -/
theorem p4_collision_values :
    p4 4 1 = 7361 / 8 ∧ p4 3 3 = 4481 / 8 ∧ p4 4 3 = 8521 / 8 ∧ p4 5 0 = 14281 / 8 ∧
      p4 5 4 = 17561 / 8 ∧ p4 6 2 = 25625 / 8 := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> · unfold p4 ell1 ell2; norm_num

end HamiltonsCubic.L84Statement
