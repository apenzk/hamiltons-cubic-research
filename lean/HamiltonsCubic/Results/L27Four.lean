import Mathlib
import HamiltonsCubic.Results.L27Sector
import HamiltonsCubic.Results.FourL220
import HamiltonsCubic.Results.L126Sphere

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false
set_option linter.unnecessarySeqFocus false
set_option linter.unreachableTactic false

/-!
# L27's four-set sector: `M ∘` on `V_Q` at a diagonal `M`, and its bound at a sphere product

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L27: *$+\mu$ on $\Lambda^2\otimes\Lambda^2$ … and $-\mu$ on
$S^2_0\otimes S^2_0$ … Then $\tfrac12-\mu=\frac{(p-2)(q-2)-1}{2(p-1)(q-1)}>0$ for $p,q\ge3$, $(p,q)\ne(3,3)$.* In the sign-group
route these are the four-set blocks $V_Q$ of [L121](../../../findings/second-order.md).

At a weight `w`, `coordOp w ∘` on `V_Q` sees only the projection of `w` on `Π_Q` ([FourL220.lean](FourL220.lean)'s
`proj_PiQ`, [FourStep4.lean](FourStep4.lean)'s `Lq_eigen`), and [FourStep5.lean](FourStep5.lean)'s `step5` turns the
eigen-equation into a norm:

* **`four_eigen_sq`**: `coordOp w ∘ ν = c ν` with `0 ≠ ν ∈ V_Q` gives `4c² = A² + B² + C² − AB − BC − CA`, the opposite-pair
  sums `A = w_ij + w_kl`, `B = w_ik + w_jl`, `C = w_il + w_jk`;
* `sig22`: [L126Sphere.lean](L126Sphere.lean)'s `fourSet_sigma` without its `let`s;
* **`sig_le_sphere`**: at a unit sphere product `w = t · sphereWeight T`, that quantity is at most
  `((p + q − 2)/((p − 1)(q − 1)))² θ²` for every four distinct indices, equal at a `(2,2)` split and `0` at every other;
* **`four_sphere`**: every eigenvalue `c` of `coordOp w ∘` on `V_Q` at a unit sphere product has `c² ≤ (μθ)²`,
  `μ = (p + q − 2)/(2(p − 1)(q − 1))`;
* **`four_sphere_lt`**: at `p, q ≥ 3`, `(p, q) ≠ (3, 3)`, `|c| < θ/2`, so no four-set block reaches `L_e = 1/2`.
-/

namespace HamiltonsCubic.L27Four

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.FourIdent HamiltonsCubic.FourProd
  HamiltonsCubic.L222Op HamiltonsCubic.FourPi HamiltonsCubic.FourStep4 HamiltonsCubic.FourStep5 HamiltonsCubic.L224Rank
  HamiltonsCubic.PairNorm HamiltonsCubic.FourL220 HamiltonsCubic.L57Critical

variable {n : ℕ} {i j k l : Fin n}

/-- The opposite-pair discriminant. -/
def sig (A B C : ℝ) : ℝ := A ^ 2 + B ^ 2 + C ^ 2 - A * B - B * C - C * A

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **`M ∘` on `V_Q` at a weight**: an eigenvalue `c` has `4c² = sig(A, B, C)`. -/
theorem four_eigen_sq {w : Matrix (Fin n) (Fin n) ℝ} (hw : IsWeight w) {ν : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {c : ℝ} (heig : foxProd2 (coordOp w) ν = c • ν) :
    4 * c ^ 2 = sig (w i j + w k l) (w i k + w j l) (w i l + w j k) := by
  set s1 := w i j + w k l
  set s2 := w i k + w j l
  set s3 := w i l + w j k
  set m := (s1 + s2 + s3) / 3
  have hs : (s1 - m) / 2 + (s2 - m) / 2 + (s3 - m) / 2 = 0 := by ring
  set P := PiQ i j k l ((s1 - m) / 2) ((s2 - m) / 2) ((s3 - m) / 2) with hPdef
  have hP : IsWeight P := PiQ_weight hij hik hil hjk hjl hkl hs
  have hwP : IsWeight (w - P) := by
    refine ⟨fun a b => ?_, fun a => ?_, fun a => ?_⟩
    · rw [Matrix.sub_apply, Matrix.sub_apply, hw.symm, hP.symm]
    · rw [Matrix.sub_apply, hw.hollow, hP.hollow, sub_zero]
    · simp only [Matrix.sub_apply, Finset.sum_sub_distrib, hw.rowSum, hP.rowSum, sub_zero]
  have hT : (w - P)ᵀ = w - P := by ext a b; rw [Matrix.transpose_apply, hwP.symm]
  set r := coordOp (w - P) with hrdef
  have hrW : IsWeyl2 r := by rw [hrdef, coordOp_eq_restrict hwP]; exact isWeyl2_restrict _
  have hr : SignChar (fun _ => 1) r := by
    rw [hrdef, coordOp_eq_restrict hwP]
    exact (L120Ident.trivial_block_iff _ (isWeyl2_restrict _)).mpr ⟨_, hwP, rfl⟩
  have hperp : ∀ a b c : ℝ, a + b + c = 0 → innerOp2 r (coordOp (PiQ i j k l a b c)) = 0 := by
    intro a b c habc
    rw [hrdef, innerOp2_comm, inner_PiQ hij hik hil hjk hjl hkl a b c _ hT]
    obtain ⟨e1, e2, e3, e4, e5, e6⟩ := PiQ_entries hij hik hil hjk hjl hkl ((s1 - m) / 2) ((s2 - m) / 2) ((s3 - m) / 2)
    simp only [Matrix.sub_apply, hPdef, e1, e2, e3, e4, e5, e6]
    linear_combination m * habc
  have hD : coordOp w = coordOp P + r := by rw [hrdef, ← coordOp_add]; congr 1; abel
  have h2 : (2 : ℝ) • foxProd2 (coordOp P + r) ν = (2 * c) • ν := by rw [← hD, heig, smul_smul]
  have heig' := Lq_eigen hij hik hil hjk hjl hkl hrW hr hperp hνW hν h2
  have h5 := step5 hij hik hil hjk hjl hkl hs hνW hν hν0 heig'
  rw [normSq2_PiQ hij hik hil hjk hjl hkl] at h5
  simp only [sig]
  linear_combination h5

end

/-- `fourSet_sigma` without its `let`s. -/
theorem sig22 (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) (a b c d : Fin n) (ha : a ∈ T) (hb : b ∈ T) (hc : c ∉ T) (hd : d ∉ T)
    (hab : a ≠ b) (hcd : c ≠ d) :
    sig ((t • sphereWeight T) a b + (t • sphereWeight T) c d) ((t • sphereWeight T) a c + (t • sphereWeight T) b d)
        ((t • sphereWeight T) a d + (t • sphereWeight T) b c)
      = (((T.card : ℝ) + (Tᶜ.card : ℝ) - 2) / (((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))) ^ 2
        * theta (diagOp (t • sphereWeight T)) ^ 2 :=
  fourSet_sigma T hp hq t ht hn a b c d ha hb hc hd hab hcd

section
variable (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l) (hkl : k ≠ l)
include hij hik hil hjk hjl hkl

/-- **The discriminant at a sphere product**: at most `((p+q−2)/((p−1)(q−1)))² θ²` on every four distinct indices. -/
theorem sig_le_sphere (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) :
    sig ((t • sphereWeight T) i j + (t • sphereWeight T) k l) ((t • sphereWeight T) i k + (t • sphereWeight T) j l)
        ((t • sphereWeight T) i l + (t • sphereWeight T) j k)
      ≤ (((T.card : ℝ) + (Tᶜ.card : ℝ) - 2) / (((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))) ^ 2
        * theta (diagOp (t • sphereWeight T)) ^ 2 := by
  set w := t • sphereWeight T with hwdef
  have hs : ∀ a b, w a b = w b a := fun a b => by
    simp only [w, Matrix.smul_apply, smul_eq_mul, sphereWeight_symm T a b]
  by_cases hi : i ∈ T
  · by_cases hj : j ∈ T
    · by_cases hk : k ∈ T
      · by_cases hl : l ∈ T
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity
      · by_cases hl : l ∈ T
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity
        · have h := sig22 T hp hq t ht hn i j k l hi hj hk hl hij hkl
          rw [← hwdef] at h
          try simp only [hs j i, hs k i, hs l i, hs k j, hs l j, hs l k] at h
          first | exact le_of_eq h | exact le_of_eq (by rw [← h]; unfold sig; ring)
    · by_cases hk : k ∈ T
      · by_cases hl : l ∈ T
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity
        · have h := sig22 T hp hq t ht hn i k j l hi hk hj hl hik hjl
          rw [← hwdef] at h
          try simp only [hs j i, hs k i, hs l i, hs k j, hs l j, hs l k] at h
          first | exact le_of_eq h | exact le_of_eq (by rw [← h]; unfold sig; ring)
      · by_cases hl : l ∈ T
        · have h := sig22 T hp hq t ht hn i l j k hi hl hj hk hil hjk
          rw [← hwdef] at h
          try simp only [hs j i, hs k i, hs l i, hs k j, hs l j, hs l k] at h
          first | exact le_of_eq h | exact le_of_eq (by rw [← h]; unfold sig; ring)
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity
  · by_cases hj : j ∈ T
    · by_cases hk : k ∈ T
      · by_cases hl : l ∈ T
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity
        · have h := sig22 T hp hq t ht hn j k i l hj hk hi hl hjk hil
          rw [← hwdef] at h
          try simp only [hs j i, hs k i, hs l i, hs k j, hs l j, hs l k] at h
          first | exact le_of_eq h | exact le_of_eq (by rw [← h]; unfold sig; ring)
      · by_cases hl : l ∈ T
        · have h := sig22 T hp hq t ht hn j l i k hj hl hi hk hjl hik
          rw [← hwdef] at h
          try simp only [hs j i, hs k i, hs l i, hs k j, hs l j, hs l k] at h
          first | exact le_of_eq h | exact le_of_eq (by rw [← h]; unfold sig; ring)
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity
    · by_cases hk : k ∈ T
      · by_cases hl : l ∈ T
        · have h := sig22 T hp hq t ht hn k l i j hk hl hi hj hkl hij
          rw [← hwdef] at h
          try simp only [hs j i, hs k i, hs l i, hs k j, hs l j, hs l k] at h
          first | exact le_of_eq h | exact le_of_eq (by rw [← h]; unfold sig; ring)
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity
      · by_cases hl : l ∈ T
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity
        · rw [show sig (w i j + w k l) (w i k + w j l) (w i l + w j k) = 0 by
            simp [sig, hwdef, sphereWeight, hi, hj, hk, hl,
              hij, hik, hil, hjk, hjl, hkl, Ne.symm hij, Ne.symm hik, Ne.symm hil, Ne.symm hjk, Ne.symm hjl, Ne.symm hkl] <;>
            ring]
          positivity

/-- **L27's four-set sector at a sphere product**: an eigenvalue `c` of `M ∘` on `V_Q`, `M = coordOp (t · sphereWeight T)` unit,
has `4c² ≤ ((p+q−2)/((p−1)(q−1)))² θ²`, that is `c² ≤ (μθ)²`. -/
theorem four_sphere (T : Finset (Fin n)) (hp : 2 ≤ T.card) (hq : 2 ≤ Tᶜ.card) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) {ν : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν)
    (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {c : ℝ}
    (heig : foxProd2 (coordOp (t • sphereWeight T)) ν = c • ν) :
    4 * c ^ 2 ≤ (((T.card : ℝ) + (Tᶜ.card : ℝ) - 2) / (((T.card : ℝ) - 1) * ((Tᶜ.card : ℝ) - 1))) ^ 2
      * theta (diagOp (t • sphereWeight T)) ^ 2 := by
  rw [four_eigen_sq hij hik hil hjk hjl hkl ((sphereWeight_isWeight T hp hq).smul t) hνW hν hν0 heig]
  exact sig_le_sphere hij hik hil hjk hjl hkl T hp hq t ht hn

/-- **No four-set block reaches `L_e = 1/2`** at `p, q ≥ 3`, `(p, q) ≠ (3, 3)`: `4c² < θ²`. -/
theorem four_sphere_lt (T : Finset (Fin n)) (hp : 3 ≤ T.card) (hq : 3 ≤ Tᶜ.card)
    (hne : ¬ (T.card = 3 ∧ Tᶜ.card = 3)) (t : ℝ) (ht : 0 < t)
    (hn : normSq (diagOp (t • sphereWeight T)) = 1) (hθ : 0 < theta (diagOp (t • sphereWeight T)))
    {ν : CurvOp2 (Fin n)} (hνW : IsWeyl2 ν) (hν : SignChar (setChar {i, j, k, l}) ν) (hν0 : ν ≠ 0) {c : ℝ}
    (heig : foxProd2 (coordOp (t • sphereWeight T)) ν = c • ν) :
    4 * c ^ 2 < theta (diagOp (t • sphereWeight T)) ^ 2 := by
  have h := four_sphere hij hik hil hjk hjl hkl T (by omega) (by omega) t ht hn hνW hν hν0 heig
  have hp3 : (3 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hq3 : (3 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  set p : ℝ := (T.card : ℝ)
  set q : ℝ := (Tᶜ.card : ℝ)
  -- `(p - 2)(q - 2) ≥ 2` off `(3, 3)`
  have hprod : 2 ≤ (p - 2) * (q - 2) := by
    have h' : 2 ≤ ((T.card : ℤ) - 2) * ((Tᶜ.card : ℤ) - 2) := by
      have a1 : (1 : ℤ) ≤ (T.card : ℤ) - 2 := by omega
      have a2 : (1 : ℤ) ≤ (Tᶜ.card : ℤ) - 2 := by omega
      rcases lt_or_eq_of_le a1 with h1 | h1
      · nlinarith
      · rcases lt_or_eq_of_le a2 with h2 | h2
        · nlinarith
        · exfalso; exact hne ⟨by omega, by omega⟩
    have := (Int.cast_le (R := ℝ)).mpr h'
    push_cast at this
    exact this
  have hden : 0 < (p - 1) * (q - 1) := by nlinarith
  have hlt : (p + q - 2) / ((p - 1) * (q - 1)) < 1 := by rw [div_lt_one hden]; nlinarith
  have hpos : 0 ≤ (p + q - 2) / ((p - 1) * (q - 1)) := by apply div_nonneg <;> nlinarith
  have hsq : ((p + q - 2) / ((p - 1) * (q - 1))) ^ 2 < 1 := by nlinarith
  have hθ2 : 0 < theta (diagOp (t • sphereWeight T)) ^ 2 := by positivity
  nlinarith

end

end HamiltonsCubic.L27Four
