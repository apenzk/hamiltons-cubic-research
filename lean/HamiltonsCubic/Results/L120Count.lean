import HamiltonsCubic.Results.L120Cut
import Mathlib.Order.Hom.PowersetCard

set_option linter.style.longLine false

/-!
# L120's count: `binom n 4` four-set summands, each of size `2`

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: *"`binom n 4` of them have size `2`"*. The
four-set summands are indexed by the sorted four-sets `i < j < k < l` ([L120Direct.lean](L120Direct.lean)'s
`weyl_direct`), each of dimension `2` ([L120Four.lean](L120Four.lean)'s `fourSummand_finrank`). This file counts the
index set:

* **`sorted4Equiv`**: the sorted four-sets of `Fin n` are the order embeddings `Fin 4 ↪o Fin n`;
* **`card_sorted4`**: there are `binom n 4` of them, through Mathlib's `Set.powersetCard.ofFinEmbEquiv` and
  `Set.powersetCard.card`;
* **`sorted4_summand_finrank`**: each sorted four-set's summand has dimension `2`.

The section's sentence is about the four-set blocks: at `n = 5` the pair blocks have size `n − 3 = 2` as well, so
"`binom n 4` of them have size `2`" is true of the four-set blocks and not of all blocks of size `2`.
-/

namespace HamiltonsCubic.Results

variable {n : ℕ}

/-- The sorted four-sets of `Fin n`. -/
def Sorted4 (n : ℕ) : Type := {t : Fin n × Fin n × Fin n × Fin n // t.1 < t.2.1 ∧ t.2.1 < t.2.2.1 ∧ t.2.2.1 < t.2.2.2}

/-- The strictly increasing map `Fin 4 → Fin n` of a sorted four-set. -/
def sorted4Fun (t : Sorted4 n) : Fin 4 → Fin n := ![t.1.1, t.1.2.1, t.1.2.2.1, t.1.2.2.2]

theorem sorted4Fun_strictMono (t : Sorted4 n) : StrictMono (sorted4Fun t) := by
  obtain ⟨⟨i, j, k, l⟩, h1, h2, h3⟩ := t
  refine Fin.strictMono_iff_lt_succ.mpr fun a => ?_
  fin_cases a
  · exact h1
  · exact h2
  · exact h3

/-- **The sorted four-sets are the order embeddings `Fin 4 ↪o Fin n`.** -/
def sorted4Equiv : Sorted4 n ≃ (Fin 4 ↪o Fin n) where
  toFun t := OrderEmbedding.ofStrictMono (sorted4Fun t) (sorted4Fun_strictMono t)
  invFun f := ⟨(f 0, f 1, f 2, f 3), f.lt_iff_lt.mpr (by decide), f.lt_iff_lt.mpr (by decide),
    f.lt_iff_lt.mpr (by decide)⟩
  left_inv t := by
    obtain ⟨⟨i, j, k, l⟩, _⟩ := t
    rfl
  right_inv f := by
    ext a
    fin_cases a <;> rfl

/-- **There are `binom n 4` sorted four-sets**, so `binom n 4` four-set summands, each of dimension `2`. -/
theorem card_sorted4 : Nat.card (Sorted4 n) = n.choose 4 := by
  rw [Nat.card_congr (sorted4Equiv.trans Set.powersetCard.ofFinEmbEquiv), Set.powersetCard.card, Nat.card_eq_fintype_card,
    Fintype.card_fin]

/-- **Each sorted four-set's summand has dimension `2`**: the count and the dimension joined in one declaration. -/
theorem sorted4_summand_finrank (t : Sorted4 n) :
    Module.finrank ℝ (LinearMap.range (fourMap t.1.1 t.1.2.1 t.1.2.2.1 t.1.2.2.2)) = 2 := by
  obtain ⟨⟨i, j, k, l⟩, h1, h2, h3⟩ := t
  exact fourSummand_finrank (ne_of_lt h1) (ne_of_lt (h1.trans h2)) (ne_of_lt (h1.trans (h2.trans h3))) (ne_of_lt h2)
    (ne_of_lt (h2.trans h3)) (ne_of_lt h3)

end HamiltonsCubic.Results
