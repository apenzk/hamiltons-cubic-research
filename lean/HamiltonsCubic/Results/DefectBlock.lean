import HamiltonsCubic.Base.AltPart
import HamiltonsCubic.Results.DefectQuarter

set_option linter.style.longLine false

/-!
# The defect of a block sum, and L134(c)'s `c₂` on the padded flat

[findings/route-a.md](../../../findings/route-a.md), Lemma L134(c): *"`H` and `u` have disjoint index support, so
`cos t u + sin t H` is a block sum and the direct-sum rule for the defect gives
`δ²(t) = cos²t · 1/9 + sin²t · δ²(H)` exactly, whence `c₂(H) = δ²(H) − 1/9`. And `δ² ≤ 1/4` unconditionally."*

`Alt` keeps its first index, so two operators whose bivectors have their rows in `S` and outside `S` have Alt parts
that never overlap (`altNormSq_add_disjoint`). Appending their spectral presentations presents the sum
(`specOp_append`), and its negative part is the sum of the negative parts (`negPartOp_append`).

- **`defectSq_append`**: `δ²(s u + t H) = s² δ²(u) + t² δ²(H)` for `s, t ≥ 0`;
- **`defect_arc`**: along the great circle, for `0 ≤ t ≤ π/2`, and `specOp_arc`, the presentation is of the arc point;
- **`c2_padded_le`**: half the second derivative at `0` of the arc form `cos² t · δ²(u) + sin² t · δ²(H)`, which
  `defect_arc` equates with the defect on `[0, π/2]`, is `δ²(H) − δ²(u)`, at most `¼ − δ²(u)` at an orthonormally
  presented unit `H` satisfying first Bianchi ([DefectQuarter.lean](DefectQuarter.lean)'s `defectSq_le_quarter_pres`).

`δ²(u) = 1/9` at the competitor is a separate computation.
-/

namespace HamiltonsCubic.DefectBlock

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.AltLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {r s : ℕ}

/-- **The support of `Alt`'s first index**: if `R` sends every bivector with first index `i` to zero, `Alt(R)`
vanishes at `i`. -/
theorem altCoeff_eq_zero_of (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (i : ι) (h : ∀ j k l, comp R i j k l = 0)
    (j k l : ι) : altCoeff R i j k l = 0 := by
  unfold altCoeff alt4; rw [h, h, h]; ring

/-- A presentation whose bivectors have their rows in `S` gives `comp` zero at every first index outside `S`. -/
theorem comp_specOp_zero (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (hsk : ∀ γ, IsSkew (om γ))
    (S : Finset ι) (hS : ∀ γ a b, a ∉ S → om γ a b = 0) (i : ι) (hi : i ∉ S) (j k l : ι) :
    comp (specOp lam om) i j k l = 0 := by
  unfold comp
  rw [inner2_specOp]
  refine Finset.sum_eq_zero fun γ _ => ?_
  rw [inner2_phi _ (hsk γ) i j, hS γ i j hi]
  ring

/-- **ALT OF A BLOCK SUM**: if `Alt(A)` vanishes at every first index outside `S` and `Alt(B)` at every first
index inside it, `‖Alt(A + B)‖² = ‖Alt(A)‖² + ‖Alt(B)‖²`. -/
theorem altNormSq_add_disjoint (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (S : Finset ι)
    (hA : ∀ i j k l, i ∉ S → altCoeff A i j k l = 0) (hB : ∀ i j k l, i ∈ S → altCoeff B i j k l = 0) :
    altNormSq (fun X => A X + B X) = altNormSq A + altNormSq B := by
  unfold altNormSq fourNormSq fourInner
  rw [← mul_add, ← Finset.sum_add_distrib]
  congr 1
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun l _ => ?_
  rw [altCoeff_add]
  by_cases hi : i ∈ S
  · rw [hB i j k l hi]; ring
  · rw [hA i j k l hi]; ring

/-- `specOp` of an appended presentation is the sum. -/
theorem specOp_append (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (mu : Fin s → ℝ) (eta : Fin s → Matrix ι ι ℝ)
    (X : Matrix ι ι ℝ) :
    specOp (Fin.append lam mu) (Fin.append om eta) X = specOp lam om X + specOp mu eta X := by
  unfold specOp
  rw [Fin.sum_univ_add]
  simp [Fin.append_left, Fin.append_right]

theorem negPartOp_append (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (mu : Fin s → ℝ) (eta : Fin s → Matrix ι ι ℝ)
    (X : Matrix ι ι ℝ) :
    negPartOp (Fin.append lam mu) (Fin.append om eta) X = negPartOp lam om X + negPartOp mu eta X := by
  unfold negPartOp
  rw [show (fun i => negPartScalar (Fin.append lam mu i)) = Fin.append (fun i => negPartScalar (lam i))
      (fun i => negPartScalar (mu i)) by
    funext i; refine Fin.addCases (fun a => ?_) (fun b => ?_) i <;> simp [Fin.append_left, Fin.append_right]]
  exact specOp_append _ _ _ _ X

/-- **THE DEFECT OF A BLOCK SUM**: with `u` presented on bivectors whose rows lie in `S` and `H` on bivectors whose
rows lie outside it, the presentation of `s u + t H` obtained by appending has
`δ²(s u + t H) = s² δ²(u) + t² δ²(H)` for `s, t ≥ 0`. -/
theorem defectSq_append {sc tc : ℝ} (hs : 0 ≤ sc) (ht : 0 ≤ tc) (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ)
    (mu : Fin s → ℝ) (eta : Fin s → Matrix ι ι ℝ) (hom : ∀ γ, IsSkew (om γ)) (heta : ∀ δ, IsSkew (eta δ))
    (S : Finset ι) (hS : ∀ γ a b, a ∉ S → om γ a b = 0) (hSc : ∀ δ a b, a ∈ S → eta δ a b = 0) :
    defectSq (Fin.append (fun γ => sc * lam γ) (fun δ => tc * mu δ)) (Fin.append om eta)
      = sc ^ 2 * defectSq lam om + tc ^ 2 * defectSq mu eta := by
  unfold defectSq
  have hfun : negPartOp (Fin.append (fun γ => sc * lam γ) (fun δ => tc * mu δ)) (Fin.append om eta)
      = fun X => (fun Y => sc • negPartOp lam om Y) X + (fun Y => tc • negPartOp mu eta Y) X := by
    funext X
    rw [negPartOp_append, negPartOp_smul hs, negPartOp_smul ht]
  rw [hfun, altNormSq_add_disjoint _ _ S]
  · have e1 : altNormSq (fun Y => sc • negPartOp lam om Y) = sc ^ 2 * altNormSq (negPartOp lam om) := by
      unfold altNormSq fourNormSq fourInner
      simp only [altCoeff_smul, Finset.mul_sum]
      exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
    have e2 : altNormSq (fun Y => tc • negPartOp mu eta Y) = tc ^ 2 * altNormSq (negPartOp mu eta) := by
      unfold altNormSq fourNormSq fourInner
      simp only [altCoeff_smul, Finset.mul_sum]
      exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring
    rw [e1, e2]
  · intro i j k l hi
    rw [altCoeff_smul, altCoeff_eq_zero_of (negPartOp lam om) i
      (comp_specOp_zero (fun γ => negPartScalar (lam γ)) om hom S hS i hi) j k l, mul_zero]
  · intro i j k l hi
    rw [altCoeff_smul, altCoeff_eq_zero_of (negPartOp mu eta) i
      (comp_specOp_zero (fun δ => negPartScalar (mu δ)) eta heta Sᶜ (fun δ a b ha => hSc δ a b (by simpa using ha)) i (by simpa using hi)) j k l,
      mul_zero]

/-- **The appended presentation presents the arc point** `cos t · u + sin t · H`. -/
theorem specOp_arc (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (mu : Fin s → ℝ) (eta : Fin s → Matrix ι ι ℝ)
    (t : ℝ) (X : Matrix ι ι ℝ) :
    specOp (Fin.append (fun γ => Real.cos t * lam γ) (fun δ => Real.sin t * mu δ)) (Fin.append om eta) X
      = Real.cos t • specOp lam om X + Real.sin t • specOp mu eta X := by
  rw [specOp_append]
  unfold specOp
  rw [Finset.smul_sum, Finset.smul_sum]
  congr 1 <;> refine Finset.sum_congr rfl fun γ _ => ?_ <;> rw [smul_smul, mul_assoc]

/-- **THE DEFECT ALONG THE GREAT CIRCLE THROUGH A BLOCK SUM**: for `0 ≤ t ≤ π/2`,
`δ²(cos t · u + sin t · H) = cos² t · δ²(u) + sin² t · δ²(H)`. -/
theorem defect_arc (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (mu : Fin s → ℝ) (eta : Fin s → Matrix ι ι ℝ)
    (hom : ∀ γ, IsSkew (om γ)) (heta : ∀ δ, IsSkew (eta δ))
    (S : Finset ι) (hS : ∀ γ a b, a ∉ S → om γ a b = 0) (hSc : ∀ δ a b, a ∈ S → eta δ a b = 0)
    (t : ℝ) (ht0 : 0 ≤ t) (ht1 : t ≤ Real.pi / 2) :
    defectSq (Fin.append (fun γ => Real.cos t * lam γ) (fun δ => Real.sin t * mu δ)) (Fin.append om eta)
      = Real.cos t ^ 2 * defectSq lam om + Real.sin t ^ 2 * defectSq mu eta :=
  defectSq_append (Real.cos_nonneg_of_mem_Icc ⟨by linarith [Real.pi_pos], ht1⟩)
    (Real.sin_nonneg_of_nonneg_of_le_pi ht0 (by linarith [Real.pi_pos])) lam om mu eta hom heta S hS hSc

/-- The second derivative at `0` of `cos² t · a + sin² t · b` is `2(b − a)`. -/
theorem arc_deriv2 (a b : ℝ) :
    deriv (deriv fun t => Real.cos t ^ 2 * a + Real.sin t ^ 2 * b) 0 = 2 * (b - a) := by
  have hf : (fun t => Real.cos t ^ 2 * a + Real.sin t ^ 2 * b) = fun t => a + (b - a) * ((1 - Real.cos (2 * t)) / 2) := by
    funext t
    have h1 := Real.cos_sq t
    have h2 := Real.sin_sq t
    rw [Real.cos_sq t] at h2
    rw [h1, h2]; ring
  have hd : deriv (fun t => a + (b - a) * ((1 - Real.cos (2 * t)) / 2)) = fun t => (b - a) * Real.sin (2 * t) := by
    funext t
    have h : HasDerivAt (fun t => a + (b - a) * ((1 - Real.cos (2 * t)) / 2))
        ((b - a) * ((-(-Real.sin (2 * t) * (2 * 1))) / 2)) t := by
      have hc : HasDerivAt (fun t => Real.cos (2 * t)) (-Real.sin (2 * t) * (2 * 1)) t :=
        ((hasDerivAt_id' t).const_mul 2).cos
      exact ((hc.const_sub 1).div_const 2 |>.const_mul (b - a)).const_add a
    rw [h.deriv]; ring
  rw [hf, hd]
  have h : HasDerivAt (fun t => (b - a) * Real.sin (2 * t)) ((b - a) * (Real.cos (2 * 0) * (2 * 1))) 0 := by
    have hs : HasDerivAt (fun t => Real.sin (2 * t)) (Real.cos (2 * 0) * (2 * 1)) 0 :=
      ((hasDerivAt_id' (0 : ℝ)).const_mul 2).sin
    exact hs.const_mul (b - a)
  rw [h.deriv]; simp; ring

/-- **L134(c)'s `c₂` on the padded flat**: by `defect_arc` the defect along the great circle is
`cos² t · δ²(u) + sin² t · δ²(H)` on `[0, π/2]`, and half the second derivative at `0` of that function is
`δ²(H) − δ²(u)`. At an `H` presented orthonormally, satisfying first Bianchi and of unit norm (`Σ μ² = 1`,
`normSq_specOp_orth`), it is at most `¼ − δ²(u)`. *The presentation of `H` is the one `defect_arc` takes, with rows
off `S`, so the two statements compose.* -/
theorem c2_padded_le (lam : Fin r → ℝ) (om : Fin r → Matrix ι ι ℝ) (mu : Fin s → ℝ) (eta : Fin s → Matrix ι ι ℝ)
    (heta : ∀ δ, IsSkew (eta δ)) (horth : ∀ δ ε, inner2 (eta δ) (eta ε) = if δ = ε then 1 else 0)
    (hB : ∀ i j k l, bianchi (specOp mu eta) i j k l = 0) (hn : ∑ δ, mu δ ^ 2 = 1) :
    (1 / 2) * deriv (deriv fun t => Real.cos t ^ 2 * defectSq lam om + Real.sin t ^ 2 * defectSq mu eta) 0
      = defectSq mu eta - defectSq lam om ∧
    defectSq mu eta - defectSq lam om ≤ 1 / 4 - defectSq lam om := by
  refine ⟨by rw [arc_deriv2]; ring, ?_⟩
  have := HamiltonsCubic.DefectQuarter.defectSq_le_quarter_pres mu eta heta horth hB
  rw [hn] at this
  linarith

end HamiltonsCubic.DefectBlock
