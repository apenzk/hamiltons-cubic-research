import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false
set_option linter.unusedSectionVars false

/-!
# `SphereProductValue`: the sphere product's `P`, evaluated

**[Families.lean](Families.lean) states `SphereProductValue` and does not prove it**, naming what it
needs as "`DiagCubicFormula` plus the cube-and-trace arithmetic at the two-block weight".
[SharpDiag.lean](SharpDiag.lean) supplies the first. This file is the second.

**The arithmetic collapses to one identity**, `diagP w = (n-1)‖diagOp w‖²` at the sphere weight.
*Then `P` at the unit-norm member is `t(n-1)` with `t` the normalising scale, and `θ_{p,q}` is what
that is.* **So the square root never has to be expanded**: `(t(n-1))²` and `thetaSplitSq p q` are
the same rational function of `p` and `q`, and both sides are positive.
-/

namespace HamiltonsCubic.FamilyLayer

open Matrix Finset HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ## Sums over a two-block partition -/

/-- **One term of a sum over a block is the special one**, the rest constant. *Every block sum
below is this lemma once per block.* -/
theorem sum_split_at {s : Finset ι} {a : ι} (ha : a ∈ s) (u v : ℝ) :
    ∑ b ∈ s, (if b = a then u else v) = u + ((s.card : ℝ) - 1) * v := by
  rw [← Finset.add_sum_erase s _ ha]
  have h1 : ∑ b ∈ s.erase a, (if b = a then u else v) = ∑ b ∈ s.erase a, v :=
    Finset.sum_congr rfl fun b hb => if_neg (Finset.ne_of_mem_erase hb)
  have hcard : ((s.erase a).card : ℝ) = (s.card : ℝ) - 1 := by
    rw [Finset.card_erase_of_mem ha]
    have : 1 ≤ s.card := Finset.card_pos.mpr ⟨a, ha⟩
    push_cast [Nat.cast_sub this]
    ring
  rw [if_pos rfl, h1, Finset.sum_const, nsmul_eq_mul, hcard]

/-- **Two terms of a sum over a block are the special ones.** *`(w²)_ab` needs this: both `c = a`
and `c = b` meet the hollow diagonal.* -/
theorem sum_split_at_two {s : Finset ι} {a b : ι} (ha : a ∈ s) (hb : b ∈ s) (hab : a ≠ b)
    (u v x : ℝ) :
    ∑ c ∈ s, (if c = a then u else if c = b then v else x)
      = u + v + ((s.card : ℝ) - 2) * x := by
  have hb' : b ∈ s.erase a := Finset.mem_erase.mpr ⟨fun h => hab h.symm, hb⟩
  rw [← Finset.add_sum_erase s _ ha, if_pos rfl, ← Finset.add_sum_erase _ _ hb',
    if_neg (fun h => hab h.symm), if_pos rfl]
  have h1 : ∑ c ∈ (s.erase a).erase b, (if c = a then u else if c = b then v else x)
      = ∑ c ∈ (s.erase a).erase b, x := by
    refine Finset.sum_congr rfl fun c hc => ?_
    rw [if_neg (Finset.ne_of_mem_erase (Finset.mem_of_mem_erase hc)),
      if_neg (Finset.ne_of_mem_erase hc)]
  have hcard : (((s.erase a).erase b).card : ℝ) = (s.card : ℝ) - 2 := by
    rw [Finset.card_erase_of_mem hb', Finset.card_erase_of_mem ha]
    have h2 : 2 ≤ s.card := Finset.one_lt_card.mpr ⟨a, ha, b, hb, hab⟩
    have : ((s.card - 1 - 1 : ℕ) : ℝ) = (s.card : ℝ) - 2 := by
      have e : s.card - 1 - 1 = s.card - 2 := by omega
      rw [e, Nat.cast_sub (by omega)]
      norm_num
    exact this
  rw [h1, Finset.sum_const, nsmul_eq_mul, hcard]
  ring

/-- **A sum over ordered pairs whose summand depends only on the BLOCK PATTERN.** *Every sum this
file takes is one instance: the entrywise square and cube, and the trace of the cube through
`(w²)_ab · w_ba`. The diagonal never contributes because the weight is hollow.* -/
theorem block_pair_sum (S : Finset ι) (g : ι → ι → ℝ) (cS cO cX : ℝ)
    (hdiag : ∀ a : ι, g a a = 0)
    (hS : ∀ a ∈ S, ∀ b ∈ S, a ≠ b → g a b = cS)
    (hO : ∀ a ∉ S, ∀ b ∉ S, a ≠ b → g a b = cO)
    (hX : ∀ a ∈ S, ∀ b ∉ S, g a b = cX)
    (hX' : ∀ a ∉ S, ∀ b ∈ S, g a b = cX) :
    ∑ a : ι, ∑ b : ι, g a b
      = (S.card : ℝ) * ((S.card : ℝ) - 1) * cS + (Sᶜ.card : ℝ) * ((Sᶜ.card : ℝ) - 1) * cO
        + 2 * (S.card : ℝ) * (Sᶜ.card : ℝ) * cX := by
  have hrow : ∀ a ∈ S, ∑ b : ι, g a b = ((S.card : ℝ) - 1) * cS + (Sᶜ.card : ℝ) * cX := by
    intro a ha
    rw [← Finset.sum_add_sum_compl S (fun b => g a b)]
    have h1 : ∑ b ∈ S, g a b = ∑ b ∈ S, (if b = a then (0 : ℝ) else cS) := by
      refine Finset.sum_congr rfl fun b hb => ?_
      by_cases hba : b = a
      · rw [if_pos hba, hba, hdiag]
      · rw [if_neg hba, hS a ha b hb (fun h => hba h.symm)]
    have h2 : ∑ b ∈ Sᶜ, g a b = ∑ b ∈ Sᶜ, cX :=
      Finset.sum_congr rfl fun b hb => hX a ha b (Finset.mem_compl.mp hb)
    rw [h1, h2, sum_split_at ha, Finset.sum_const, nsmul_eq_mul]
    ring
  have hrow' : ∀ a ∈ Sᶜ, ∑ b : ι, g a b = ((Sᶜ.card : ℝ) - 1) * cO + (S.card : ℝ) * cX := by
    intro a ha
    have haS : a ∉ S := Finset.mem_compl.mp ha
    rw [← Finset.sum_add_sum_compl S (fun b => g a b)]
    have h1 : ∑ b ∈ S, g a b = ∑ b ∈ S, cX := Finset.sum_congr rfl fun b hb => hX' a haS b hb
    have h2 : ∑ b ∈ Sᶜ, g a b = ∑ b ∈ Sᶜ, (if b = a then (0 : ℝ) else cO) := by
      refine Finset.sum_congr rfl fun b hb => ?_
      by_cases hba : b = a
      · rw [if_pos hba, hba, hdiag]
      · rw [if_neg hba, hO a haS b (Finset.mem_compl.mp hb) (fun h => hba h.symm)]
    rw [h1, h2, sum_split_at ha, Finset.sum_const, nsmul_eq_mul]
    ring
  rw [← Finset.sum_add_sum_compl S (fun a => ∑ b : ι, g a b), Finset.sum_congr rfl hrow,
    Finset.sum_congr rfl hrow', Finset.sum_const, Finset.sum_const, nsmul_eq_mul, nsmul_eq_mul]
  ring

/-- **Every `f` of the sphere weight sums the same way**, `f` meeting only the three entry values
and `f 0` never contributing because the diagonal is hollow. -/
theorem sphereWeight_pair_sum (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card)
    (f : ℝ → ℝ) (hf : f 0 = 0) :
    ∑ a : ι, ∑ b : ι, f (sphereWeight S a b)
      = (S.card : ℝ) * ((S.card : ℝ) - 1) * f ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1))
        + (Sᶜ.card : ℝ) * ((Sᶜ.card : ℝ) - 1) * f ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1))
        + 2 * (S.card : ℝ) * (Sᶜ.card : ℝ) * f (-1) :=
  block_pair_sum S (fun a b => f (sphereWeight S a b)) _ _ _
    (fun a => by rw [sphereWeight_hollow, hf])
    (fun a ha b hb hab => by rw [sphereWeight_in S ha hb hab])
    (fun a ha b hb hab => by rw [sphereWeight_out S ha hb hab])
    (fun a ha b hb => by rw [sphereWeight_cross S ha hb])
    (fun a ha b hb => by rw [← sphereWeight_symm, sphereWeight_cross S hb ha])


/-! ## The norm and the cube sum

**Both are `sphereWeight_pair_sum` at one `f`.** *`‖diagOp w‖²` takes `f = (·²)` and the entrywise
term of `diagP` takes `f = (·³)`, and the diagonal never contributes because both vanish at `0`.*
-/

/-- **`‖diagOp w‖² = pq(n-1)(n-2)/(2(p-1)(q-1))`** at the sphere weight. -/
theorem sphereWeight_normSq (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    normSq (diagOp (sphereWeight S))
      = (S.card : ℝ) * (Sᶜ.card : ℝ)
          * ((S.card : ℝ) + (Sᶜ.card : ℝ) - 1) * ((S.card : ℝ) + (Sᶜ.card : ℝ) - 2)
          / (2 * ((S.card : ℝ) - 1) * ((Sᶜ.card : ℝ) - 1)) := by
  have hp1 : ((S.card : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
    linarith
  have hq1 : ((Sᶜ.card : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
    linarith
  rw [diagOp_normSq _ (sphereWeight_symm S) (sphereWeight_hollow S),
    sphereWeight_pair_sum S hp hq (fun x => x ^ 2) (by norm_num)]
  field_simp
  ring

/-- **The entrywise cube sum at the sphere weight.** -/
theorem sphereWeight_cube_sum (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    ∑ a : ι, ∑ b : ι, (sphereWeight S a b) ^ 3
      = (S.card : ℝ) * (Sᶜ.card : ℝ) ^ 3 / ((S.card : ℝ) - 1) ^ 2
        + (Sᶜ.card : ℝ) * (S.card : ℝ) ^ 3 / ((Sᶜ.card : ℝ) - 1) ^ 2
        - 2 * (S.card : ℝ) * (Sᶜ.card : ℝ) := by
  have hp1 : ((S.card : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
    linarith
  have hq1 : ((Sᶜ.card : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
    linarith
  rw [sphereWeight_pair_sum S hp hq (fun x => x ^ 3) (by norm_num)]
  field_simp
  ring

/-! ## The trace of the cube, through `w²`

**`tr w³` is read as `∑_{a,b} (w²)_ab · w_ba` rather than as a triple sum.** *A triple sum would
need ordered triples of distinct indices counted per block, and this needs only that `w²` is again
block-constant, which is one application of `sum_split_at_two` per block.*
-/

/-- **`w²` is symmetric**, `w` being so. -/
theorem sphereWeight_sq_symm (S : Finset ι) (a b : ι) :
    (sphereWeight S * sphereWeight S) a b = (sphereWeight S * sphereWeight S) b a := by
  simp only [Matrix.mul_apply]
  refine Finset.sum_congr rfl fun c _ => ?_
  rw [sphereWeight_symm S a c, sphereWeight_symm S c b]
  ring

/-- **`(w²)_ab` inside the `S` block**: the `p-2` indices sharing neither `a` nor `b` contribute
`α²`, and every index outside contributes `(-1)² = 1`. -/
theorem sphereWeight_sq_in (S : Finset ι) {a b : ι} (ha : a ∈ S) (hb : b ∈ S) (hab : a ≠ b) :
    (sphereWeight S * sphereWeight S) a b
      = ((S.card : ℝ) - 2) * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) ^ 2 + (Sᶜ.card : ℝ) := by
  rw [Matrix.mul_apply, ← Finset.sum_add_sum_compl S]
  have h1 : ∑ c ∈ S, sphereWeight S a c * sphereWeight S c b
      = ∑ c ∈ S, (if c = a then (0 : ℝ) else if c = b then 0 else
          ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1))) := by
    refine Finset.sum_congr rfl fun c hc => ?_
    by_cases hca : c = a
    · rw [if_pos hca, hca, sphereWeight_hollow, zero_mul]
    · by_cases hcb : c = b
      · rw [if_neg hca, if_pos hcb, hcb, sphereWeight_hollow, mul_zero]
      · rw [if_neg hca, if_neg hcb, sphereWeight_in S ha hc (fun h => hca h.symm),
          sphereWeight_in S hc hb hcb]
  have h2 : ∑ c ∈ Sᶜ, sphereWeight S a c * sphereWeight S c b = ∑ c ∈ Sᶜ, (1 : ℝ) := by
    refine Finset.sum_congr rfl fun c hc => ?_
    have hcS : c ∉ S := Finset.mem_compl.mp hc
    rw [sphereWeight_cross S ha hcS, ← sphereWeight_symm, sphereWeight_cross S hb hcS]
    norm_num
  rw [h1, h2, sum_split_at_two ha hb hab, Finset.sum_const, nsmul_eq_mul]
  ring

/-- **`(w²)_ab` inside the complement**, the same count with the blocks exchanged. -/
theorem sphereWeight_sq_out (S : Finset ι) {a b : ι} (ha : a ∉ S) (hb : b ∉ S) (hab : a ≠ b) :
    (sphereWeight S * sphereWeight S) a b
      = ((Sᶜ.card : ℝ) - 2) * ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) ^ 2 + (S.card : ℝ) := by
  have ha' : a ∈ Sᶜ := Finset.mem_compl.mpr ha
  have hb' : b ∈ Sᶜ := Finset.mem_compl.mpr hb
  rw [Matrix.mul_apply, ← Finset.sum_compl_add_sum S]
  have h1 : ∑ c ∈ Sᶜ, sphereWeight S a c * sphereWeight S c b
      = ∑ c ∈ Sᶜ, (if c = a then (0 : ℝ) else if c = b then 0 else
          ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) * ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1))) := by
    refine Finset.sum_congr rfl fun c hc => ?_
    have hcS : c ∉ S := Finset.mem_compl.mp hc
    by_cases hca : c = a
    · rw [if_pos hca, hca, sphereWeight_hollow, zero_mul]
    · by_cases hcb : c = b
      · rw [if_neg hca, if_pos hcb, hcb, sphereWeight_hollow, mul_zero]
      · rw [if_neg hca, if_neg hcb, sphereWeight_out S ha hcS (fun h => hca h.symm),
          sphereWeight_out S hcS hb hcb]
  have h2 : ∑ c ∈ S, sphereWeight S a c * sphereWeight S c b = ∑ c ∈ S, (1 : ℝ) := by
    refine Finset.sum_congr rfl fun c hc => ?_
    rw [← sphereWeight_symm, sphereWeight_cross S hc ha, sphereWeight_cross S hc hb]
    norm_num
  rw [h1, h2, sum_split_at_two ha' hb' hab, Finset.sum_const, nsmul_eq_mul]
  ring

/-- **`(w²)_ab` across the blocks is `-(p+q)`**, and it is the one entry with no square in it:
the two row sums `(p-1)α = q` and `(q-1)β = p` are what collapse it. -/
theorem sphereWeight_sq_cross (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card)
    {a b : ι} (ha : a ∈ S) (hb : b ∉ S) :
    (sphereWeight S * sphereWeight S) a b = -((S.card : ℝ) + (Sᶜ.card : ℝ)) := by
  have hp1 : ((S.card : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
    linarith
  have hq1 : ((Sᶜ.card : ℝ) - 1) ≠ 0 := by
    have : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
    linarith
  have hb' : b ∈ Sᶜ := Finset.mem_compl.mpr hb
  rw [Matrix.mul_apply, ← Finset.sum_add_sum_compl S]
  have h1 : ∑ c ∈ S, sphereWeight S a c * sphereWeight S c b
      = ∑ c ∈ S, (if c = a then (0 : ℝ) else
          ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) * (-1)) := by
    refine Finset.sum_congr rfl fun c hc => ?_
    by_cases hca : c = a
    · rw [if_pos hca, hca, sphereWeight_hollow, zero_mul]
    · rw [if_neg hca, sphereWeight_in S ha hc (fun h => hca h.symm), sphereWeight_cross S hc hb]
  have h2 : ∑ c ∈ Sᶜ, sphereWeight S a c * sphereWeight S c b
      = ∑ c ∈ Sᶜ, (if c = b then (0 : ℝ) else
          (-1) * ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1))) := by
    refine Finset.sum_congr rfl fun c hc => ?_
    have hcS : c ∉ S := Finset.mem_compl.mp hc
    by_cases hcb : c = b
    · rw [if_pos hcb, hcb, sphereWeight_hollow, mul_zero]
    · rw [if_neg hcb, sphereWeight_cross S ha hcS, sphereWeight_out S hcS hb hcb]
  rw [h1, h2, sum_split_at ha, sum_split_at hb']
  field_simp
  ring

/-- **`tr w³` at the sphere weight.** -/
theorem sphereWeight_trace_cube (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    (sphereWeight S * sphereWeight S * sphereWeight S).trace
      = (S.card : ℝ) * ((S.card : ℝ) - 1)
          * ((((S.card : ℝ) - 2) * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)) ^ 2 + (Sᶜ.card : ℝ))
              * ((Sᶜ.card : ℝ) / ((S.card : ℝ) - 1)))
        + (Sᶜ.card : ℝ) * ((Sᶜ.card : ℝ) - 1)
          * ((((Sᶜ.card : ℝ) - 2) * ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)) ^ 2 + (S.card : ℝ))
              * ((S.card : ℝ) / ((Sᶜ.card : ℝ) - 1)))
        + 2 * (S.card : ℝ) * (Sᶜ.card : ℝ) * ((S.card : ℝ) + (Sᶜ.card : ℝ)) := by
  have hexp : (sphereWeight S * sphereWeight S * sphereWeight S).trace
      = ∑ a : ι, ∑ b : ι, (sphereWeight S * sphereWeight S) a b * sphereWeight S b a := by
    rw [Matrix.trace]
    exact Finset.sum_congr rfl fun a _ => by rw [Matrix.diag_apply, Matrix.mul_apply]
  rw [hexp]
  exact block_pair_sum S _ _ _ _
    (fun a => by rw [sphereWeight_hollow, mul_zero])
    (fun a ha b hb hab => by
      rw [sphereWeight_sq_in S ha hb hab, sphereWeight_in S hb ha (fun h => hab h.symm)])
    (fun a ha b hb hab => by
      rw [sphereWeight_sq_out S ha hb hab, sphereWeight_out S hb ha (fun h => hab h.symm)])
    (fun a ha b hb => by
      rw [sphereWeight_sq_cross S hp hq ha hb, ← sphereWeight_symm, sphereWeight_cross S ha hb]
      ring)
    (fun a ha b hb => by
      rw [sphereWeight_sq_symm, sphereWeight_sq_cross S hp hq hb ha, sphereWeight_cross S hb ha]
      ring)

/-! ## The identity, and the value

**One identity carries the whole evaluation**: `diagP w = (n-1)‖diagOp w‖²` at the sphere weight.
*Neither side has to be expanded afterwards. `P` at the unit-norm member is `t³·(n-1)·N`, which is
`t(n-1)` once `t²N = 1`, and squaring that against `thetaSplitSq` is a rational identity.*
-/

/-- **`diagP` is homogeneous of degree `3`**, both of its terms being cubic. -/
theorem diagP_smul (t : ℝ) (w : Matrix ι ι ℝ) : diagP (t • w) = t ^ 3 * diagP w := by
  unfold diagP
  have h1 : ∑ a : ι, ∑ b : ι, ((t • w) a b) ^ 3 = t ^ 3 * ∑ a : ι, ∑ b : ι, (w a b) ^ 3 := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun b _ => by simp only [Matrix.smul_apply, smul_eq_mul]; ring
  have h2 : ((t • w) * (t • w) * (t • w)).trace = t ^ 3 * (w * w * w).trace := by
    simp only [Matrix.smul_mul, Matrix.mul_smul, smul_smul, Matrix.trace_smul, smul_eq_mul]
    ring
  rw [h1, h2]
  ring

/-- **THE IDENTITY THE SPHERE PRODUCT TURNS ON**: `diagP w = (n-1)‖diagOp w‖²` at the sphere
weight. *It is not a general fact about weights. What makes it hold is the pair of row sums
`(p-1)α = q` and `(q-1)β = p`, which is `sphereWeight_rowSum` read blockwise.* -/
theorem sphereWeight_diagP (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card) :
    diagP (sphereWeight S)
      = ((S.card : ℝ) + (Sᶜ.card : ℝ) - 1) * normSq (diagOp (sphereWeight S)) := by
  have hp2 : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hq2 : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  have hp1 : ((S.card : ℝ) - 1) ≠ 0 := by linarith
  have hq1 : ((Sᶜ.card : ℝ) - 1) ≠ 0 := by linarith
  unfold diagP
  rw [sphereWeight_cube_sum S hp hq, sphereWeight_trace_cube S hp hq,
    sphereWeight_normSq S hp hq]
  field_simp
  ring

/-- **`SphereProductValue`, PROVED.** *[Families.lean](Families.lean) states it and names what it
needs as `DiagCubicFormula` plus the cube-and-trace arithmetic at the two-block weight.
[SharpDiag.lean](SharpDiag.lean) supplies the first and this file the second.* **With
`theta_sphereProduct` it gives the record's `θ = θ_{p,q}` at every sphere product**, which is the
lower half of `sup ≥ Θₙ`. -/
theorem sphereProductValue : SphereProductValue (ι := ι) := by
  intro S hp hq t ht hunit
  have hp2 : (2 : ℝ) ≤ (S.card : ℝ) := by exact_mod_cast hp
  have hq2 : (2 : ℝ) ≤ (Sᶜ.card : ℝ) := by exact_mod_cast hq
  have hp1 : ((S.card : ℝ) - 1) ≠ 0 := by linarith
  have hq1 : ((Sᶜ.card : ℝ) - 1) ≠ 0 := by linarith
  have hpq : ((S.card : ℝ) * (Sᶜ.card : ℝ)) ≠ 0 := by positivity
  have hn2 : ((S.card : ℝ) + (Sᶜ.card : ℝ) - 2) ≠ 0 := by linarith
  have hn1 : (0 : ℝ) < (S.card : ℝ) + (Sᶜ.card : ℝ) - 1 := by linarith
  set N := normSq (diagOp (sphereWeight S)) with hN
  have hNpos : 0 < N := sphereWeight_normSq_pos S hp hq
  have ht2 : t ^ 2 * N = 1 := by
    rw [hN, ← diagOp_normSq_smul t _ (sphereWeight_symm S) (sphereWeight_hollow S)]
    exact hunit
  have hval : Pcubic (diagOp (t • sphereWeight S))
      = t * ((S.card : ℝ) + (Sᶜ.card : ℝ) - 1) := by
    rw [diagCubicFormula _ ((sphereWeight_isWeight S hp hq).smul t), diagP_smul,
      sphereWeight_diagP S hp hq, ← hN]
    calc t ^ 3 * (((S.card : ℝ) + (Sᶜ.card : ℝ) - 1) * N)
        = ((S.card : ℝ) + (Sᶜ.card : ℝ) - 1) * t * (t ^ 2 * N) := by ring
      _ = t * ((S.card : ℝ) + (Sᶜ.card : ℝ) - 1) := by rw [ht2]; ring
  rw [hval, thetaSplit]
  have hsq : (t * ((S.card : ℝ) + (Sᶜ.card : ℝ) - 1)) ^ 2
      = thetaSplitSq (S.card : ℝ) (Sᶜ.card : ℝ) := by
    have hNval : N = (S.card : ℝ) * (Sᶜ.card : ℝ)
        * ((S.card : ℝ) + (Sᶜ.card : ℝ) - 1) * ((S.card : ℝ) + (Sᶜ.card : ℝ) - 2)
        / (2 * ((S.card : ℝ) - 1) * ((Sᶜ.card : ℝ) - 1)) := by
      rw [hN]; exact sphereWeight_normSq S hp hq
    have ht2' : t ^ 2 = 1 / N := by
      field_simp
      linarith [ht2]
    rw [mul_pow, ht2', hNval, thetaSplitSq]
    field_simp
  rw [← hsq, Real.sqrt_sq (by positivity)]

/-- **`θ = θ_{p,q}` AT EVERY SPHERE PRODUCT**, with no hypothesis left over. *This is the record's
own value at the competitor, and the lower half of `sup ≥ Θₙ`: what remains for that is choosing the
split, which is arithmetic on `thetaSplit` and not on any curvature operator.* -/
theorem theta_sphereProduct_value (S : Finset ι) (hp : 2 ≤ S.card) (hq : 2 ≤ Sᶜ.card)
    (t : ℝ) (ht : 0 < t) (hn : normSq (diagOp (t • sphereWeight S)) = 1) :
    theta (diagOp (t • sphereWeight S)) = thetaSplit (S.card : ℝ) ((Sᶜ.card : ℝ)) :=
  theta_sphereProduct sphereProductValue S hp hq t ht hn

end HamiltonsCubic.FamilyLayer
