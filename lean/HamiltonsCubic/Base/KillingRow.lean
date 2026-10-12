import HamiltonsCubic.Base.Curvature
import HamiltonsCubic.Base.PhiPairing

/-!
# Relation (A), the Killing row mass

The record's first per-index relation: for a unit bivector `v_a`,

`Σ_{b,c} c_{abc}² = 2(n-2)`,

the sum over **ordered** pairs. It is the Killing form in disguise,
`Σ c_{abc}² = ‖ad(v_a)‖²_HS = -tr(ad(v_a)²) = -B(v_a,v_a)`, and
[conventions.md](../../../findings/conventions.md) fixes `B(X,Y) = (n-2)tr(XY)`
with `tr(v²) = -2` at a unit bivector, giving `2(n-2)`.

The record calls the three per-index relations complete, with no fourth; this is
the first of them, and it is checked here at two dimensions, since a claim
linear in `n` checked at one cannot see a wrong slope.
-/

set_option linter.style.longLine false

namespace HamiltonsCubic.Base

open Matrix

/-- The structure constant `c_{abc} = ⟨[φ_a, φ_b], φ_c⟩`, on index *pairs*
rather than a basis enumeration, the sum below runs over all of them. -/
def cc {ι : Type*} [Fintype ι] [DecidableEq ι] (a b c d e f : ι) : ℚ :=
  inner2 (br (phi a b) (phi c d)) (phi e f)

/-- The row mass at the bivector `φ_{a b}`, summed over ordered pairs of basis
bivectors, each unordered pair counted twice, so the `½` from
`Σ_{i<j} = ½ Σ_{i,j}` is applied to each of the two index slots. -/
def rowMass {ι : Type*} [Fintype ι] [DecidableEq ι] (a b : ι) : ℚ :=
  (1/4) * ∑ c : ι, ∑ d : ι, ∑ e : ι, ∑ f : ι, (cc a b c d e f) ^ 2

/-! ## The case analysis the row mass turns on

**EVERY BRACKET `[φ_ab, φ_cd]` IS A UNIT BIVECTOR OR ZERO**, and which it is depends only on how
`{c,d}` meets `{a,b}`. *Four families of size `n-2` give a unit each, everything else vanishes, so
the double sum is `4(n-2)` and the row mass is `2(n-2)`.*

**THE TWO DEGENERATE PAIRS ARE WHERE A PAPER DERIVATION GOES WRONG**, `brNorm_ab` and `brNorm_ba`:
at `(c,d) = (a,b)` and `(b,a)` every delta term collapses to a `φ_ii = 0`, *which is `[v,v] = 0`
and `φ_ba = -φ_ab` respectively.* **Counting them as contributors gives `2(n-2)+2`**, and this
cycle's first pass did exactly that before a screen at `n = 4,5,6,7` caught it. -/

theorem inner2_neg_self {ι : Type*} [Fintype ι] [DecidableEq ι] (X : Matrix ι ι ℚ) : inner2 (-X) (-X) = inner2 X X := by
  unfold inner2; simp

set_option maxHeartbeats 1000000 in
theorem brNorm_f1 {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} (hab : a ≠ b) {d : ι} (hda : d ≠ a) (hdb : d ≠ b) :
    inner2 (br (phi a b) (phi a d)) (br (phi a b) (phi a d)) = 1 := by
  rw [br_phi_phi]
  simp only [if_pos rfl, if_neg (Ne.symm hdb), if_neg (Ne.symm hda), if_neg hab.symm,
    ite_true, one_smul, zero_smul, add_zero, sub_zero, zero_sub, zero_add, neg_zero]
  exact inner2_phi_self (Ne.symm hdb)

set_option maxHeartbeats 1000000 in
theorem brNorm_f2 {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} (hab : a ≠ b) {d : ι} (hda : d ≠ a) (hdb : d ≠ b) :
    inner2 (br (phi a b) (phi b d)) (br (phi a b) (phi b d)) = 1 := by
  rw [br_phi_phi]
  simp only [if_neg hab, if_neg (Ne.symm hdb), if_neg (Ne.symm hda), if_pos rfl,
    ite_true, one_smul, zero_smul, add_zero, sub_zero, zero_sub, zero_add, neg_zero]
  rw [inner2_neg_self]
  exact inner2_phi_self (Ne.symm hda)

set_option maxHeartbeats 1000000 in
theorem brNorm_f3 {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} (hab : a ≠ b) {c : ι} (hca : c ≠ a) (hcb : c ≠ b) :
    inner2 (br (phi a b) (phi c a)) (br (phi a b) (phi c a)) = 1 := by
  rw [br_phi_phi]
  simp only [if_neg (Ne.symm hca), if_neg hab.symm, if_pos rfl, if_neg (Ne.symm hcb),
    ite_true, one_smul, zero_smul, add_zero, sub_zero, zero_sub, zero_add, neg_zero]
  rw [inner2_neg_self]
  exact inner2_phi_self (Ne.symm hcb)

set_option maxHeartbeats 1000000 in
theorem brNorm_f4 {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} (hab : a ≠ b) {c : ι} (hca : c ≠ a) (hcb : c ≠ b) :
    inner2 (br (phi a b) (phi c b)) (br (phi a b) (phi c b)) = 1 := by
  rw [br_phi_phi]
  simp only [if_neg (Ne.symm hca), if_pos rfl, if_neg hab, if_neg (Ne.symm hcb),
    ite_true, one_smul, zero_smul, add_zero, sub_zero, zero_sub, zero_add, neg_zero]
  exact inner2_phi_self (Ne.symm hca)

set_option maxHeartbeats 1000000 in
theorem brNorm_zero {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} {c d : ι} (hca : c ≠ a) (hcb : c ≠ b) (hda : d ≠ a) (hdb : d ≠ b) :
    br (phi a b) (phi c d) = 0 := by
  rw [br_phi_phi]
  simp only [if_neg (Ne.symm hca), if_neg (Ne.symm hdb), if_neg (Ne.symm hda),
    if_neg (Ne.symm hcb), zero_smul, sub_zero, add_zero, zero_add, sub_self]

set_option maxHeartbeats 1000000 in
theorem brNorm_diag {ι : Type*} [Fintype ι] [DecidableEq ι] {a b c : ι} : br (phi a b) (phi c c) = 0 := by
  have : phi (ι := ι) c c = 0 := by unfold phi; simp
  rw [this]; unfold br; simp

set_option maxHeartbeats 1000000 in
theorem brNorm_ab {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} : br (phi a b) (phi a b) = 0 := by
  unfold br; exact sub_self _

set_option maxHeartbeats 1000000 in
theorem brNorm_ba {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} : br (phi a b) (phi b a) = 0 := by
  rw [phi_swap b a]; unfold br; simp

set_option maxHeartbeats 1000000 in
-- One `Finset.sum_congr` per index slot over the doubling identity.
/-- **STEP ONE OF THE ROW MASS: THE `(e,f)` SUM COLLAPSES.** *`sum_inner2_sq` turns the squared
coordinates of `[φ_ab, φ_cd]` into twice its norm, so two of the four index slots go at once and
the `¼` becomes a `½`.* **What remains is a case split on whether `c` or `d` lands in `{a,b}`**,
after which each surviving bracket is a unit bivector. -/
theorem rowMass_eq_half_sum {ι : Type*} [Fintype ι] [DecidableEq ι] (a b : ι) :
    rowMass a b = (1/2 : ℚ) * ∑ c : ι, ∑ d : ι,
      inner2 (br (phi a b) (phi c d)) (br (phi a b) (phi c d)) := by
  unfold rowMass cc
  have hstep : ∀ c d : ι, ∑ e : ι, ∑ f : ι,
      (inner2 (br (phi a b) (phi c d)) (phi e f))^2
      = 2 * inner2 (br (phi a b) (phi c d)) (br (phi a b) (phi c d)) :=
    fun c d => sum_inner2_sq _ (br_isSkew (phi_isSkew a b) (phi_isSkew c d))
  rw [Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => hstep c d]
  simp only [Finset.mul_sum]
  refine Finset.sum_congr rfl fun c _ => Finset.sum_congr rfl fun d _ => ?_
  ring


/-! ## The three inner sums, and the row mass

**FOR A FIXED `c` THE INNER SUM TAKES ONE OF TWO VALUES**: `n-2` when `c` is `a` or `b`, and `2`
otherwise. *The first counts the `d` outside `{a,b}`, the second counts the two `d` inside it.* -/

set_option maxHeartbeats 2000000 in
theorem inner_at_a {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} (hab : a ≠ b) :
    (∑ d : ι, inner2 (br (phi a b) (phi a d)) (br (phi a b) (phi a d)))
      = (Fintype.card ι : ℚ) - 2 := by
  have hd : ∀ d : ι, inner2 (br (phi a b) (phi a d)) (br (phi a b) (phi a d))
      = if d = a ∨ d = b then (0:ℚ) else 1 := by
    intro d
    by_cases h1 : d = a
    · rw [h1, brNorm_diag]; simp [inner2]
    · by_cases h2 : d = b
      · rw [h2, brNorm_ab]; simp [inner2, h1]
      · rw [brNorm_f1 hab h1 h2]; simp [h1, h2]
  rw [Finset.sum_congr rfl fun d _ => hd d]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const]
  simp only [smul_eq_mul, mul_zero, zero_add, mul_one, nsmul_eq_mul]
  have hpos : (Finset.univ.filter fun d : ι => (d = a ∨ d = b)) = {a, b} := by
    ext x; simp
  have hsum := Finset.card_filter_add_card_filter_not (s := (Finset.univ : Finset ι))
    (fun d => d = a ∨ d = b)
  rw [hpos, Finset.card_insert_of_notMem (by simpa using hab), Finset.card_singleton,
    Finset.card_univ] at hsum
  have hcard : (Finset.univ.filter fun d : ι => ¬(d = a ∨ d = b)).card = Fintype.card ι - 2 := by
    omega
  rw [hcard]
  have h2 : 2 ≤ Fintype.card ι := by omega
  push_cast [Nat.cast_sub h2]
  ring

set_option maxHeartbeats 2000000 in
theorem inner_at_b {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} (hab : a ≠ b) :
    (∑ d : ι, inner2 (br (phi a b) (phi b d)) (br (phi a b) (phi b d)))
      = (Fintype.card ι : ℚ) - 2 := by
  have hd : ∀ d : ι, inner2 (br (phi a b) (phi b d)) (br (phi a b) (phi b d))
      = if d = a ∨ d = b then (0:ℚ) else 1 := by
    intro d
    by_cases h1 : d = a
    · rw [h1, brNorm_ba]; simp [inner2]
    · by_cases h2 : d = b
      · rw [h2, brNorm_diag]; simp [inner2, h1]
      · rw [brNorm_f2 hab h1 h2]; simp [h1, h2]
  rw [Finset.sum_congr rfl fun d _ => hd d]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const]
  simp only [smul_eq_mul, mul_zero, zero_add, mul_one, nsmul_eq_mul]
  have hpos : (Finset.univ.filter fun d : ι => (d = a ∨ d = b)) = {a, b} := by
    ext x; simp
  have hsum := Finset.card_filter_add_card_filter_not (s := (Finset.univ : Finset ι))
    (fun d => d = a ∨ d = b)
  rw [hpos, Finset.card_insert_of_notMem (by simpa using hab), Finset.card_singleton,
    Finset.card_univ] at hsum
  have hcard : (Finset.univ.filter fun d : ι => ¬(d = a ∨ d = b)).card = Fintype.card ι - 2 := by
    omega
  rw [hcard]
  have h2 : 2 ≤ Fintype.card ι := by omega
  push_cast [Nat.cast_sub h2]
  ring

set_option maxHeartbeats 2000000 in
theorem inner_at_other {ι : Type*} [Fintype ι] [DecidableEq ι] {a b c : ι}
    (hab : a ≠ b) (hca : c ≠ a) (hcb : c ≠ b) :
    (∑ d : ι, inner2 (br (phi a b) (phi c d)) (br (phi a b) (phi c d))) = 2 := by
  have hd : ∀ d : ι, inner2 (br (phi a b) (phi c d)) (br (phi a b) (phi c d))
      = if d = a ∨ d = b then (1:ℚ) else 0 := by
    intro d
    by_cases h1 : d = a
    · rw [h1, brNorm_f3 hab hca hcb]; simp
    · by_cases h2 : d = b
      · rw [h2, brNorm_f4 hab hca hcb]; simp
      · rw [brNorm_zero hca hcb h1 h2]; simp [inner2, h1, h2]
  rw [Finset.sum_congr rfl fun d _ => hd d]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const]
  simp only [smul_eq_mul, mul_zero, add_zero, mul_one, nsmul_eq_mul]
  have hpos : (Finset.univ.filter fun d : ι => (d = a ∨ d = b)) = {a, b} := by
    ext x; simp
  rw [hpos, Finset.card_insert_of_notMem (by simpa using hab), Finset.card_singleton]
  norm_num

set_option maxHeartbeats 2000000 in
/-- **THE ROW MASS AT EVERY `n`**, `Σ_{c,d} c_{abc}² = 2(n-2)`, which is the record's first
per-index relation. *It was checked at `n = 4, 5, 6` by `native_decide` and is now proved outright.*

**The outer sum has two values**: `c` in `{a,b}` contributes `n-2` and every other `c` contributes
`2`, so the total is `2(n-2) + 2(n-2) = 4(n-2)` and the half makes it `2(n-2)`. -/
theorem rowMass_value {ι : Type*} [Fintype ι] [DecidableEq ι] {a b : ι} (hab : a ≠ b) :
    rowMass a b = 2 * ((Fintype.card ι : ℚ) - 2) := by
  rw [rowMass_eq_half_sum]
  have hc : ∀ c : ι, (∑ d : ι, inner2 (br (phi a b) (phi c d)) (br (phi a b) (phi c d)))
      = if c = a ∨ c = b then (Fintype.card ι : ℚ) - 2 else 2 := by
    intro c
    by_cases h1 : c = a
    · rw [h1, inner_at_a hab]; simp
    · by_cases h2 : c = b
      · rw [h2, inner_at_b hab]; simp [h1]
      · rw [inner_at_other hab h1 h2]; simp [h1, h2]
  rw [Finset.sum_congr rfl fun c _ => hc c]
  rw [Finset.sum_ite, Finset.sum_const, Finset.sum_const]
  simp only [smul_eq_mul, nsmul_eq_mul]
  have hpos : (Finset.univ.filter fun c : ι => (c = a ∨ c = b)) = {a, b} := by
    ext x; simp
  have hsum := Finset.card_filter_add_card_filter_not (s := (Finset.univ : Finset ι))
    (fun c => c = a ∨ c = b)
  rw [hpos, Finset.card_insert_of_notMem (by simpa using hab), Finset.card_singleton,
    Finset.card_univ] at hsum
  have hneg : (Finset.univ.filter fun c : ι => ¬(c = a ∨ c = b)).card = Fintype.card ι - 2 := by
    omega
  have h2 : 2 ≤ Fintype.card ι := by omega
  rw [hpos, Finset.card_insert_of_notMem (by simpa using hab), Finset.card_singleton, hneg]
  push_cast [Nat.cast_sub h2]
  ring

set_option maxHeartbeats 4000000 in
-- Expands one `Λ²` bracket and distributes the pairing over its four terms.
/-- **THE STRUCTURE CONSTANT IN CLOSED FORM, AT EVERY `n`.** *`br_phi_phi` expands the bracket into
four basis bivectors with delta coefficients, and the pairing distributes over them.*

**THIS IS THE PIECE THE THREE CHECKS BELOW WERE MISSING**, and it was missing because
`br_phi_phi` lived only in the real layer until 2026-09-20. *What remains for
`rowMass a b = 2(n-2)` is the four-fold sum of squares of this expression, which is a round of its
own rather than a corollary.* **The three `native_decide` checks stay until that lands**, and they
are `blocked on the row sum` rather than on anything the layer lacks. -/
theorem cc_expand {ι : Type*} [Fintype ι] [DecidableEq ι] (a b c d e f : ι) :
    cc a b c d e f
      = (if a = c then (1:ℚ) else 0) * inner2 (phi b d) (phi e f)
      + (if b = d then (1:ℚ) else 0) * inner2 (phi a c) (phi e f)
      - (if a = d then (1:ℚ) else 0) * inner2 (phi b c) (phi e f)
      - (if b = c then (1:ℚ) else 0) * inner2 (phi a d) (phi e f) := by
  unfold cc
  rw [br_phi_phi]
  simp only [inner2, Matrix.add_mul, Matrix.sub_mul, Matrix.transpose_add, Matrix.transpose_sub,
    Matrix.transpose_smul, Matrix.smul_mul, Matrix.trace_add, Matrix.trace_sub, Matrix.trace_smul,
    smul_eq_mul]
  ring

/-- **`n = 4`: the row mass is `2(n-2) = 4`.** -/
theorem rowMass_four : rowMass (0 : Fin 4) 1 = 4 := by
  rw [rowMass_value (by decide)]; norm_num

/-- **`n = 5`: it is `2(n-2) = 6`**, a claim linear in `n` checked at one
dimension cannot see a wrong slope, so it is checked at two. -/
theorem rowMass_five : rowMass (0 : Fin 5) 1 = 6 := by
  rw [rowMass_value (by decide)]; norm_num

/-- **`n = 6`: `8`.** -/
theorem rowMass_six : rowMass (0 : Fin 6) 1 = 8 := by
  rw [rowMass_value (by decide)]; norm_num

end HamiltonsCubic.Base
