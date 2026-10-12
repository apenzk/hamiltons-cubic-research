import Mathlib
import HamiltonsCubic.Results.FourStep5
import HamiltonsCubic.Results.L221Ops
import HamiltonsCubic.Results.L219GenOps
import HamiltonsCubic.Results.ItemFour

set_option linter.style.longLine false
set_option linter.unusedSimpArgs false
set_option linter.unusedSectionVars false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false

/-!
# The rectangle identity on the operators: the character reduction and the matched triple

[reviews/2026-09-28d-I121-smallmass-direct.md](../../../reviews/2026-09-28d-I121-smallmass-direct.md), *The rectangle identity*: for
disjoint edges $e_1,e_2,e_3$, $Q_{ab}=e_a\cup e_b$ and $\nu_{ab}\in V_{Q_{ab}}$ with coordinates $(J_{ab},X_{ab})$ relative to the
pairing $(e_a|e_b)$, $\tau=\langle\nu_{12}\circ\nu_{13},\nu_{23}\rangle=\tfrac32J_{12}J_{13}J_{23}+4X_{12}X_{13}X_{23}$. Proof step 1:
*$T$ is multilinear and invariant under the sign group, and $\nu_Q$ carries the character $\chi_Q$, so
$T(\nu_{Q_1},\nu_{Q_2},\nu_{Q_3})=0$ unless $\chi_{Q_1\triangle Q_2\triangle Q_3}=1$.*

The sandwich of the matched pairing $(e_a|e_b)$ is the pure-`X` direction of $V_{Q_{ab}}$, raw coordinates $(0,1,1)$, and the
three matched sandwiches are diagonalised by one frame, the $45°$ rotation in each of the planes $e_1,e_2,e_3$:

* **`triple_char_zero`**: `⟨A ∘ B, C⟩ = 0` at characters `χ_{Q₁}, χ_{Q₂}, χ_{Q₃}` unless `Q₁ △ Q₂ = Q₃`, which covers a single
  block, `χ_Q³ ≠ 1`;
* `Rot_T`, `Rot_comm`: a rotation's transpose, and rotations in disjoint planes commute;
* `uj_mul_zero`, `w4_mul`, `w4_had`, **`fox_w4`**: `(w4 ij kl) ∘ (w4 ij mp) = w4 kl mp` on the coordinate operators;
* **`fox_matched`**: `σ_{ij|kl} ∘ σ_{ij|mp} = σ_{kl|mp}` for the three matched sandwiches;
* **`tau_matched`**: `⟨σ_{ij|kl} ∘ σ_{ij|mp}, σ_{kl|mp}⟩ = 4`, the identity's `4 X₁₂X₁₃X₂₃` at `X = 1`, `J = 0`.
-/

namespace HamiltonsCubic.RectOp

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.I117S
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.FourSquare HamiltonsCubic.FamilyLayer
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L222Op HamiltonsCubic.L221Ops HamiltonsCubic.L224Rot
  HamiltonsCubic.FrameOp2 HamiltonsCubic.FrameLayer HamiltonsCubic.FourStep5

/-- **Only rectangles couple**: at characters `χ_{Q₁}, χ_{Q₂}, χ_{Q₃}`, `⟨A ∘ B, C⟩ = 0` unless `Q₁ △ Q₂ = Q₃`. -/
theorem triple_char_zero {ι : Type*} [Fintype ι] [DecidableEq ι] {Q₁ Q₂ Q₃ : Finset ι} {A B C : CurvOp2 ι}
    (hA : SignChar (setChar Q₁) A) (hB : SignChar (setChar Q₂) B) (hC : SignChar (setChar Q₃) C)
    (h : symmDiff Q₁ Q₂ ≠ Q₃) : innerOp2 (foxProd2 A B) C = 0 := by
  have hAB : SignChar (setChar (symmDiff Q₁ Q₂)) (foxProd2 A B) :=
    signChar_congr (foxProd2_char2 hA hB) fun ε hε => setChar_symmDiff Q₁ Q₂ ε hε
  obtain ⟨ε, hε, hcc⟩ := setChar_sep h
  exact char_orth hAB hC hε hcc

/-- A single block does not couple to itself: `⟨ν ∘ ν, ν⟩ = 0` at a nonempty character. -/
theorem single_zero {ι : Type*} [Fintype ι] [DecidableEq ι] {Q : Finset ι} (hQ : Q.Nonempty) {A : CurvOp2 ι}
    (hA : SignChar (setChar Q) A) : innerOp2 (foxProd2 A A) A = 0 :=
  triple_char_zero hA hA hA (by rw [symmDiff_self]; exact (Finset.nonempty_iff_ne_empty.mp hQ).symm)

variable {n : ℕ}

theorem isOrth_mul' {A B : Matrix (Fin n) (Fin n) ℝ} (hA : IsOrth A) (hB : IsOrth B) : IsOrth (A * B) := by
  refine ⟨?_, ?_⟩
  · rw [Matrix.transpose_mul, Matrix.mul_assoc, ← Matrix.mul_assoc Aᵀ, hA.1, Matrix.one_mul, hB.1]
  · rw [Matrix.transpose_mul, Matrix.mul_assoc, ← Matrix.mul_assoc B, hB.2, Matrix.one_mul, hA.2]

theorem Rot_T (a b : Fin n) (hab : a ≠ b) (c s : ℝ) : (Rot a b c s)ᵀ = Rot a b c (-s) := by
  ext p q
  simp only [Matrix.transpose_apply, Rot, Matrix.of_apply]
  by_cases hpa : p = a <;> by_cases hpb : p = b <;> by_cases hqa : q = a <;> by_cases hqb : q = b <;>
    by_cases hpq : p = q <;> simp_all [eq_comm]

theorem mulRot (A : Matrix (Fin n) (Fin n) ℝ) (x y : Fin n) (hxy : x ≠ y) (c s : ℝ) (p q : Fin n) :
    (A * Rot x y c s) p q = if q = x then c * A p x + s * A p y else if q = y then -s * A p x + c * A p y
      else A p q := by
  rw [Matrix.mul_apply]
  have hcol : ∀ r, Rot x y c s r q = if q = x then ((if r = x then c else 0) + (if r = y then s else 0))
      else if q = y then ((if r = x then -s else 0) + (if r = y then c else 0)) else (if r = q then 1 else 0) := by
    intro r
    simp only [Rot, Matrix.of_apply]
    by_cases hqx : q = x <;> by_cases hqy : q = y <;> by_cases hrq : r = q <;> by_cases hrx : r = x <;>
      by_cases hry : r = y <;> simp_all [eq_comm]
  simp only [hcol]
  split_ifs with h1 h2
  · simp only [mul_add, mul_ite, mul_zero, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]; ring
  · simp only [mul_add, mul_ite, mul_zero, Finset.sum_add_distrib, Finset.sum_ite_eq', Finset.mem_univ, if_true]; ring
  · simp only [mul_ite, mul_one, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]

/-- **Rotations in disjoint planes commute.** -/
theorem Rot_comm {a b a' b' : Fin n} (hab : a ≠ b) (ha'b' : a' ≠ b') (h1 : a ≠ a') (h2 : a ≠ b') (h3 : b ≠ a')
    (h4 : b ≠ b') (c s c' s' : ℝ) : Rot a b c s * Rot a' b' c' s' = Rot a' b' c' s' * Rot a b c s := by
  ext p q
  rw [mulRot _ a' b' ha'b', mulRot _ a b hab]
  simp only [Rot, Matrix.of_apply]
  by_cases hqa : q = a <;> by_cases hqb : q = b <;> by_cases hqa' : q = a' <;> by_cases hqb' : q = b' <;>
    by_cases hpa : p = a <;> by_cases hpb : p = b <;> by_cases hpa' : p = a' <;> by_cases hpb' : p = b' <;>
    by_cases hpq : p = q <;> simp_all [eq_comm] <;> ring

theorem uj_mul_zero {a b c d : Fin n} (h1 : a ≠ c) (h2 : a ≠ d) (h3 : b ≠ c) (h4 : b ≠ d) (x : Fin n) :
    uj a b x * uj c d x = 0 := by
  unfold uj
  by_cases hxa : x = a <;> by_cases hxb : x = b <;> by_cases hxc : x = c <;> by_cases hxd : x = d <;> simp_all

theorem uj_dot_zero {a b c d : Fin n} (h1 : a ≠ c) (h2 : a ≠ d) (h3 : b ≠ c) (h4 : b ≠ d) :
    ∑ x, uj a b x * uj c d x = 0 :=
  Finset.sum_eq_zero fun x _ => uj_mul_zero h1 h2 h3 h4 x

theorem w4_hollow' {a b c d : Fin n} (h1 : a ≠ c) (h2 : a ≠ d) (h3 : b ≠ c) (h4 : b ≠ d) (x : Fin n) :
    w4 a b c d x x = 0 := by
  simp only [w4, Matrix.add_apply, Matrix.vecMulVec_apply]
  rw [uj_mul_zero h1 h2 h3 h4, mul_comm, uj_mul_zero h1 h2 h3 h4, add_zero]

theorem w4_off {a b c d x y : Fin n} (hx : x ≠ a ∧ x ≠ b ∧ x ≠ c ∧ x ≠ d) (hy : y ≠ a ∧ y ≠ b ∧ y ≠ c ∧ y ≠ d)
    (q r : Fin n) (h : q = x ∨ q = y ∨ r = x ∨ r = y) : w4 a b c d q r = 0 := by
  simp only [w4, Matrix.add_apply, Matrix.vecMulVec_apply, uj]
  rcases h with rfl | rfl | rfl | rfl <;> simp [hx.1, hx.2.1, hx.2.2.1, hx.2.2.2, hy.1, hy.2.1, hy.2.2.1, hy.2.2.2]

section
variable {i j k l m p : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (him : i ≠ m) (hip : i ≠ p) (hjk : j ≠ k)
  (hjl : j ≠ l) (hjm : j ≠ m) (hjp : j ≠ p) (hkl : k ≠ l) (hkm : k ≠ m) (hkp : k ≠ p) (hlm : l ≠ m) (hlp : l ≠ p)
  (hmp : m ≠ p)
include hij hik hil him hip hjk hjl hjm hjp hkl hkm hkp hlm hlp hmp

/-- **The weight product**: `½(w4 ij kl · w4 ij mp + w4 ij mp · w4 ij kl) = w4 kl mp`. -/
theorem w4_mul :
    (1 / 2 : ℝ) • (w4 i j k l * w4 i j m p + w4 i j m p * w4 i j k l) = w4 k l m p := by
  ext a b
  simp only [w4, Matrix.smul_apply, Matrix.add_apply, Matrix.mul_apply, Matrix.vecMulVec_apply, smul_eq_mul]
  have s1 := uj_norm hij
  have d1 := uj_dot_zero hik hil hjk hjl
  have d2 := uj_dot_zero him hip hjm hjp
  have d3 := uj_dot_zero hkm hkp hlm hlp
  have e : ∀ f g h : Fin n → ℝ, ∑ c, (f a * g c + g a * f c) * (f c * h b + h c * f b)
      = f a * h b * ∑ c, g c * f c + f a * f b * ∑ c, g c * h c + g a * h b * ∑ c, f c * f c + g a * f b * ∑ c, f c * h c := by
    intro f g h
    simp only [Finset.mul_sum, ← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun c _ => by ring
  rw [e (uj i j) (uj k l) (uj m p), e (uj i j) (uj m p) (uj k l)]
  have d1' : ∑ c, uj k l c * uj i j c = 0 := by rw [← d1]; exact Finset.sum_congr rfl fun c _ => mul_comm _ _
  have d2' : ∑ c, uj m p c * uj i j c = 0 := by rw [← d2]; exact Finset.sum_congr rfl fun c _ => mul_comm _ _
  have d3' : ∑ c, uj m p c * uj k l c = 0 := by rw [← d3]; exact Finset.sum_congr rfl fun c _ => mul_comm _ _
  rw [d1', d1, d2', d2, d3, d3', s1]
  ring

/-- `w4 ij kl ⊙ w4 ij mp = 0`. -/
theorem w4_had : w4 i j k l ⊙ w4 i j m p = 0 := by
  ext a b
  simp only [w4, Matrix.hadamard_apply, Matrix.add_apply, Matrix.vecMulVec_apply, Matrix.zero_apply]
  have z1 := uj_mul_zero hik hil hjk hjl a
  have z2 := uj_mul_zero hik hil hjk hjl b
  have z3 := uj_mul_zero hkm hkp hlm hlp a
  have z4 := uj_mul_zero hkm hkp hlm hlp b
  have z5 := uj_mul_zero him hip hjm hjp a
  have z6 := uj_mul_zero him hip hjm hjp b
  linear_combination (uj i j a) ^ 2 * z4 + (uj i j a * uj m p a) * z2 + (uj i j b * uj m p b) * z1 + (uj i j b) ^ 2 * z3

omit hik hil him hip hjk hjl hjm hjp hkl hkm hkp hlm hlp hmp in
theorem w4_T' : (w4 i j k l)ᵀ = w4 i j k l := vv_sym _ _

/-- **On the coordinate operators**: `(w4 ij kl) ⊙ · ∘ (w4 ij mp) ⊙ · = (w4 kl mp) ⊙ ·`. -/
theorem fox_w4 : foxProd2 (coordOp (w4 i j k l)) (coordOp (w4 i j m p)) = coordOp (w4 k l m p) := by
  rw [HamiltonsCubic.ItemFour.foxProd2_coordOp (w4 i j k l) (w4 i j m p) (vv_sym _ _) (vv_sym _ _) (w4_hollow' hik hil hjk hjl)
    (w4_hollow' him hip hjm hjp), w4_had hij hik hil him hip hjk hjl hjm hjp hkl hkm hkp hlm hlp hmp, zero_add,
    w4_mul hij hik hil him hip hjk hjl hjm hjp hkl hkm hkp hlm hlp hmp]

/-- **The matched sandwiches**: `σ_{ij|kl} ∘ σ_{ij|mp} = σ_{kl|mp}`, in the frame rotating each of the planes `ij`, `kl`,
`mp` by `45°`. -/
theorem fox_matched : foxProd2 (sig4 i j k l) (sig4 i j m p) = sig4 k l m p := by
  have hcs : c45 ^ 2 + (-c45) ^ 2 = 1 := by have := c45_facts.2.2; nlinarith
  rw [sig_eq hij hkl hik hil hjk hjl, sig_eq hij hmp him hip hjm hjp, sig_eq hkl hmp hkm hkp hlm hlp,
    Rot_T i j hij, Rot_T k l hkl, Rot_T m p hmp]
  set R1 := Rot i j c45 (-c45)
  set R2 := Rot k l c45 (-c45)
  set R3 := Rot m p c45 (-c45)
  have hR1 : IsOrth R1 := Rot_orth hij hcs
  have hR2 : IsOrth R2 := Rot_orth hkl hcs
  have hR3 : IsOrth R3 := Rot_orth hmp hcs
  have c23 : R2 * R3 = R3 * R2 := Rot_comm hkl hmp hkm hkp hlm hlp _ _ _ _
  have c13 : R1 * R3 = R3 * R1 := Rot_comm hij hmp him hip hjm hjp _ _ _ _
  have c12 : R1 * R2 = R2 * R1 := Rot_comm hij hkl hik hil hjk hjl _ _ _ _
  -- insert the missing rotation next to each coordinate operator
  have f12 : rotR R3 (coordOp (w4 i j k l)) = coordOp (w4 i j k l) :=
    rot_out hmp c45 (-c45) _ (vv_sym _ _) (w4_off ⟨Ne.symm him, Ne.symm hjm, Ne.symm hkm, Ne.symm hlm⟩
      ⟨Ne.symm hip, Ne.symm hjp, Ne.symm hkp, Ne.symm hlp⟩)
  have f13 : rotR R2 (coordOp (w4 i j m p)) = coordOp (w4 i j m p) :=
    rot_out hkl c45 (-c45) _ (vv_sym _ _) (w4_off ⟨Ne.symm hik, Ne.symm hjk, hkm, hkp⟩ ⟨Ne.symm hil, Ne.symm hjl, hlm, hlp⟩)
  have f23 : rotR R1 (coordOp (w4 k l m p)) = coordOp (w4 k l m p) :=
    rot_out hij c45 (-c45) _ (vv_sym _ _) (w4_off ⟨hik, hil, him, hip⟩ ⟨hjk, hjl, hjm, hjp⟩)
  set U := R1 * (R2 * R3) with hU
  have hUo : IsOrth U := isOrth_mul' hR1 (isOrth_mul' hR2 hR3)
  have e12 : rotR U (coordOp (w4 i j k l)) = rotR R1 (rotR R2 (coordOp (w4 i j k l))) := by
    rw [hU, ← L219GenOps.rotR_comp, ← L219GenOps.rotR_comp, f12]
  have e13 : rotR U (coordOp (w4 i j m p)) = rotR R1 (rotR R3 (coordOp (w4 i j m p))) := by
    rw [hU, c23, ← L219GenOps.rotR_comp, ← L219GenOps.rotR_comp, f13]
  have e23 : rotR U (coordOp (w4 k l m p)) = rotR R2 (rotR R3 (coordOp (w4 k l m p))) := by
    rw [hU, ← Matrix.mul_assoc, c12, Matrix.mul_assoc, c13, ← L219GenOps.rotR_comp, ← L219GenOps.rotR_comp, f23]
  rw [← e12, ← e13, ← e23, L219GenOps.foxProd2_rotR hUo (w4_weyl hij hkl hik hil hjk hjl) (w4_weyl hij hmp him hip hjm hjp),
    fox_w4 hij hik hil him hip hjk hjl hjm hjp hkl hkm hkp hlm hlp hmp]

/-- **The matched triple**: `⟨σ_{ij|kl} ∘ σ_{ij|mp}, σ_{kl|mp}⟩ = 4`, the identity's `4 X₁₂X₁₃X₂₃` at raw coordinates
`(0, 1, 1)` on each block, where `J = 0` and `X = 1`. -/
theorem tau_matched : innerOp2 (foxProd2 (sig4 i j k l) (sig4 i j m p)) (sig4 k l m p) = 4 := by
  rw [fox_matched hij hik hil him hip hjk hjl hjm hjp hkl hkm hkp hlm hlp hmp]
  exact norm_sig hkl hmp hkm hkp hlm hlp

end

end HamiltonsCubic.RectOp
