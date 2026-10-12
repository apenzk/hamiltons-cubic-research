import Mathlib
import HamiltonsCubic.Results.L105Op

set_option linter.style.longLine false

/-!
# L105's equality case: `θ = θ₀(n)` forces `u/w = n/(n-2)` and `r = n(n-2)/4`, so odd `n` is strict

[findings/bounds-relaxations.md](../../../findings/bounds-relaxations.md), Lemma L105: *"with equality in the
second inequality exactly at $r=n(n-2)/4$, which forces $u/w=n/(n-2)$ and $n$ even, the balanced sphere
product's spectrum. At odd $n$ the inequality is strict."* [L105Op.lean](L105Op.lean) proves the inequality at
the operator; the L105 row owes the equality case. This file:

* `L105_eq_iff`: for `n ≥ 3`, `u, w > 0` and `uwN = 1`, both branches reach `θ₀(n)`, that is
  `θ₀ ≤ (n-1)w` and `θ₀ w ≤ (n-2)u² - 2uw - w²`, exactly when `(n-2)u = nw`; strictly off it, the Π-branch
  when `(n-2)u > nw` and the tangent branch when `(n-2)u < nw` (through `L105_identity`);
* `L105_mult`: with `ru = sw` and `r + s = N`, `(n-2)u = nw` gives `4r = n(n-2)`, and `L105_mult_conv` the
  converse, so equality sits exactly at `r = n(n-2)/4`;
* `L105_odd`: at odd `n ≥ 3` no natural `r` has `4r = n(n-2)`;
* `L105_op_eq`: at every unit critical linear Weyl operator whose spectrum takes exactly the values `u > 0`
  and `-w < 0`, `θ ≥ θ₀(n)` forces `(n-2)u = nw` and `4r = n(n-2)`, `r` the multiplicity of `u`;
* `L105_op_odd`: at odd `n` such a point has `θ < θ₀(n)`, and `L105_op_odd_min` the stronger form, the two
  branches cannot both reach `θ₀(n)`, so `min{(n-1)w, Q/w} < θ₀(n)`.
-/

namespace HamiltonsCubic.L105Eq

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer HamiltonsCubic.EigenFrameExist
  HamiltonsCubic.SecondKind HamiltonsCubic.L244Frame HamiltonsCubic.L105Op

/-- **Both branches reach `θ₀(n)` exactly at `(n-2)u = nw`.** -/
theorem L105_eq_iff (n u w : ℝ) (hn : 3 ≤ n) (hu : 0 < u) (hw : 0 < w) (huw : u * w * (n * (n - 1) / 2) = 1) :
    (Real.sqrt (2 * (n - 1) * (n - 2)) / n ≤ (n - 1) * w ∧
      Real.sqrt (2 * (n - 1) * (n - 2)) / n * w ≤ (n - 2) * u ^ 2 - 2 * u * w - w ^ 2) ↔
    (n - 2) * u = n * w := by
  have hnpos : 0 < n := by linarith
  have huw' : u * w * (n * (n - 1)) = 2 := by linarith
  set t := Real.sqrt (2 * (n - 1) * (n - 2)) / n with htdef
  have hS : Real.sqrt (2 * (n - 1) * (n - 2)) ^ 2 = 2 * (n - 1) * (n - 2) :=
    Real.sq_sqrt (by nlinarith)
  have htn : t * n = Real.sqrt (2 * (n - 1) * (n - 2)) := by rw [htdef]; field_simp
  have ht2 : (t * n) ^ 2 = 2 * (n - 1) * (n - 2) := by rw [htn, hS]
  have ht0 : 0 < t := div_pos (Real.sqrt_pos.mpr (by nlinarith)) hnpos
  constructor
  · rintro ⟨h1, h2⟩
    rcases lt_trichotomy ((n - 2) * u) (n * w) with hlt | heq | hgt
    · -- the tangent branch is strict
      exfalso
      set Q := (n - 2) * u ^ 2 - 2 * u * w - w ^ 2 with hQ
      have hQpos : 0 < Q := lt_of_lt_of_le (mul_pos ht0 hw) h2
      have hQle : Q ≤ (n - 1) * w ^ 2 := by
        have : ((n - 2) * u - n * w) * (u + w) ≤ 0 :=
          mul_nonpos_of_nonpos_of_nonneg (by linarith) (by linarith)
        nlinarith
      have iden : (n - 1) ^ 2 * (n - 2) * u * w ^ 3 - n * Q ^ 2
          = (n - 1) * w ^ 2 * ((n * w - (n - 2) * u) * (n * u + w)) + n * Q * ((n - 1) * w ^ 2 - Q) := by
        rw [hQ]; ring
      have t1 : 0 < (n - 1) * w ^ 2 * ((n * w - (n - 2) * u) * (n * u + w)) :=
        mul_pos (mul_pos (by linarith) (by positivity)) (mul_pos (by linarith) (by positivity))
      have t2 : 0 ≤ n * Q * ((n - 1) * w ^ 2 - Q) :=
        mul_nonneg (mul_nonneg hnpos.le hQpos.le) (by linarith)
      have e : n * ((n - 1) ^ 2 * (n - 2) * u * w ^ 3) = 2 * (n - 1) * (n - 2) * w ^ 2 := by
        linear_combination ((n - 1) * (n - 2) * w ^ 2) * huw'
      have hlt2 : n * (n * Q ^ 2) < 2 * (n - 1) * (n - 2) * w ^ 2 := by
        have := mul_lt_mul_of_pos_left (show n * Q ^ 2 < (n - 1) ^ 2 * (n - 2) * u * w ^ 3 by linarith) hnpos
        linarith
      have hsq : (t * w) ^ 2 ≤ Q ^ 2 := pow_le_pow_left₀ (by positivity) h2 2
      have : n * (n * Q ^ 2) ≥ 2 * (n - 1) * (n - 2) * w ^ 2 := by
        have e2 : n * (n * (t * w) ^ 2) = (t * n) ^ 2 * w ^ 2 := by ring
        rw [ht2] at e2
        nlinarith [mul_le_mul_of_nonneg_left hsq (by positivity : (0 : ℝ) ≤ n * n)]
      linarith
    · exact heq
    · -- the `Π`-branch is strict
      exfalso
      have hpos : 0 < (n - 1) ^ 2 * w * n := by
        have : 0 < n - 1 := by linarith
        positivity
      have hm := mul_lt_mul_of_pos_right hgt hpos
      have e : (n - 2) * u * ((n - 1) ^ 2 * w * n) = 2 * (n - 1) * (n - 2) := by
        linear_combination ((n - 1) * (n - 2)) * huw'
      have a : ((n - 1) * w) ^ 2 * n ^ 2 < 2 * (n - 1) * (n - 2) := by nlinarith
      have hsq : t ^ 2 ≤ ((n - 1) * w) ^ 2 := pow_le_pow_left₀ ht0.le h1 2
      have b : 2 * (n - 1) * (n - 2) ≤ ((n - 1) * w) ^ 2 * n ^ 2 := by
        rw [← ht2, mul_pow]
        exact mul_le_mul_of_nonneg_right hsq (by positivity)
      linarith
  · intro h
    have hn1 : 0 < n - 1 := by linarith
    have hn2 : 0 < n - 2 := by linarith
    -- `((n-1)w)² = θ₀²`, so `(n-1)w = θ₀`
    have hw2 : ((n - 1) * w) ^ 2 * n ^ 2 = 2 * (n - 1) * (n - 2) := by
      have e : (n - 2) * (u * w * (n * (n - 1))) = n * w ^ 2 * (n * (n - 1)) := by
        rw [show (n - 2) * (u * w * (n * (n - 1))) = (n - 2) * u * (w * (n * (n - 1))) by ring, h]; ring
      rw [huw'] at e
      nlinarith
    have hA : (n - 1) * w = t := by
      have h1 : ((n - 1) * w) ^ 2 = t ^ 2 := by
        have : (t * n) ^ 2 = ((n - 1) * w) ^ 2 * n ^ 2 := by rw [ht2, hw2]
        have hn2' : (0 : ℝ) < n ^ 2 := by positivity
        rw [mul_pow] at this
        exact (mul_right_cancel₀ hn2'.ne' this).symm
      have hx : 0 ≤ (n - 1) * w := by positivity
      nlinarith [sq_nonneg ((n - 1) * w - t), sq_nonneg ((n - 1) * w + t)]
    -- `Q = (n-1)w²`
    have hQ : (n - 2) * u ^ 2 - 2 * u * w - w ^ 2 = (n - 1) * w ^ 2 := by
      have e : (n - 2) * ((n - 2) * u ^ 2 - 2 * u * w - w ^ 2) = (n - 2) * ((n - 1) * w ^ 2) := by
        have hu' : (n - 2) ^ 2 * u ^ 2 = n ^ 2 * w ^ 2 := by rw [← mul_pow, h, mul_pow]
        nlinarith
      exact mul_left_cancel₀ hn2.ne' e
    refine ⟨hA.symm.le, ?_⟩
    rw [hQ, ← hA]; nlinarith

/-- **The multiplicity at equality**: `ru = sw`, `r + s = N` and `(n-2)u = nw` give `4r = n(n-2)`. -/
theorem L105_mult (n r s u w : ℝ) (hn : 3 ≤ n) (hw : 0 < w) (hru : r * u = s * w)
    (hrs : r + s = n * (n - 1) / 2) (h : (n - 2) * u = n * w) : 4 * r = n * (n - 2) := by
  have e1 : r * n * w = s * (n - 2) * w := by linear_combination (n - 2) * hru - r * h
  have e2 : r * n = s * (n - 2) := mul_right_cancel₀ hw.ne' e1
  have e3 : 4 * r * (n - 1) = n * (n - 2) * (n - 1) := by linear_combination 2 * e2 + 2 * (n - 2) * hrs
  exact mul_right_cancel₀ (show n - 1 ≠ 0 by linarith) e3

/-- **The converse**: `ru = sw`, `r + s = N` and `4r = n(n-2)` give `(n-2)u = nw`, so the equality case sits
exactly at `r = n(n-2)/4`. -/
theorem L105_mult_conv (n r s u w : ℝ) (hn : 3 ≤ n) (hru : r * u = s * w) (hrs : r + s = n * (n - 1) / 2)
    (h4 : 4 * r = n * (n - 2)) : (n - 2) * u = n * w := by
  have e : n * ((n - 2) * u - n * w) = 0 := by
    linear_combination 4 * hru - u * h4 + 4 * w * hrs - w * h4
  have hn0 : n ≠ 0 := by linarith
  have := (mul_eq_zero.mp e).resolve_left hn0
  linarith

/-- **Odd `n`**: no natural `r` has `4r = n(n-2)`. -/
theorem L105_odd (n r : ℕ) (hn : 3 ≤ n) (hodd : Odd n) : 4 * (r : ℝ) ≠ (n : ℝ) * ((n : ℝ) - 2) := by
  intro h
  obtain ⟨k, rfl⟩ := hodd
  have h' : ((4 * r + 1 : ℕ) : ℝ) = ((4 * (k * k) : ℕ) : ℝ) := by
    push_cast at h ⊢
    linarith
  have h'' : 4 * r + 1 = 4 * (k * k) := by exact_mod_cast h'
  generalize k * k = K at h''
  omega

variable {n : ℕ}

/-- **L105's equality case at the operator.** -/
theorem L105_op_eq (hn : 3 ≤ n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (hunit : normSq W = 1) (u w : ℝ) (hu : 0 < u) (hw : 0 < w)
    (htwo : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u ∨
      (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w)
    (hexu : ∃ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u)
    (hexw : ∃ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w)
    (hθ : Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n ≤ θ) :
    ((n : ℝ) - 2) * u = n * w ∧
      4 * ((univ.filter fun j => (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u).card : ℝ)
        = (n : ℝ) * ((n : ℝ) - 2) := by
  have hnR : (3 : ℝ) ≤ n := by exact_mod_cast hn
  obtain ⟨hpi, htan⟩ := L105_branches W hW θ hc u w hu hw htwo hexu hexw
  have huw := uwN_one W hW hunit u w hu hw htwo
  have h := (L105_eq_iff (n : ℝ) u w hnR hu hw huw).mp
    ⟨hθ.trans hpi, (mul_le_mul_of_nonneg_right hθ hw.le).trans htan⟩
  obtain ⟨hru, hrs⟩ := mult_rel W hW u w hu hw htwo
  exact ⟨h, L105_mult (n : ℝ) _ _ u w hnR hw hru hrs h⟩

/-- **At odd `n` the inequality is strict.** -/
theorem L105_op_odd (hn : 3 ≤ n) (hodd : Odd n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (θ : ℝ) (hc : IsCritical W θ) (hunit : normSq W = 1) (u w : ℝ) (hu : 0 < u) (hw : 0 < w)
    (htwo : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u ∨
      (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w)
    (hexu : ∃ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u)
    (hexw : ∃ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w) :
    θ < Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n := by
  by_contra hcon
  have h := (L105_op_eq hn W hW θ hc hunit u w hu hw htwo hexu hexw (not_lt.mp hcon)).2
  exact L105_odd n _ hn hodd h

/-- **At odd `n` the second inequality is strict**: the two branches cannot both reach `θ₀(n)`, so
`min{(n-1)w, Q/w} < θ₀(n)`. -/
theorem L105_op_odd_min (hn : 3 ≤ n) (hodd : Odd n) (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ)
    (hW : IsWeylOp W) (hunit : normSq W = 1) (u w : ℝ) (hu : 0 < u) (hw : 0 < w)
    (htwo : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = u ∨
      (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j = -w) :
    ¬ (Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n ≤ ((n : ℝ) - 1) * w ∧
      Real.sqrt (2 * ((n : ℝ) - 1) * ((n : ℝ) - 2)) / n * w ≤ ((n : ℝ) - 2) * u ^ 2 - 2 * u * w - w ^ 2) := by
  intro hboth
  have hnR : (3 : ℝ) ≤ n := by exact_mod_cast hn
  have h := (L105_eq_iff (n : ℝ) u w hnR hu hw (uwN_one W hW hunit u w hu hw htwo)).mp hboth
  obtain ⟨hru, hrs⟩ := mult_rel W hW u w hu hw htwo
  exact L105_odd n _ hn hodd (L105_mult (n : ℝ) _ _ u w hnR hw hru hrs h)

end HamiltonsCubic.L105Eq
