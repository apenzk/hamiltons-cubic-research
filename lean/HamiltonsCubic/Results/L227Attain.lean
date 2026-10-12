import Mathlib
import HamiltonsCubic.Results.L227Full
import HamiltonsCubic.Results.L130Statement

set_option linter.style.longLine false

/-!
# L227's attainment: `Θ₅` is attained in the block family at commuting blocks

[findings/second-order.md](../../../findings/second-order.md), Lemma L227: *"the value $\Theta_5$ is attained at a
unit $W$ whose blocks $M_a$ and $S$ commute, a coordinate-diagonal tensor in a frame of $\mathbb R^5$ rotated inside
$\mathbb R^J$"*, and L228: *"In items 3 and 4 the value $\Theta_n$ is attained in $\mathcal D_n\subseteq\mathcal S_J$."*
Every weight on `Fin 3 ⊕ Fin m` is the diagonal tensor of a block operator with diagonal blocks. This file:

* `Sw`, `Mw`, `Kw`: the blocks of a weight, `(S_w)_xx` the weight of the `J`-pair complementary to `x`;
* `wOf_blocks`: `wOf (Sw w) (Mw w) (Kw w) = w` at a symmetric hollow `w`;
* `ricci_blocks`: at a weight the block operator is Ricci-flat;
* `Pcubic_blocks`, `normSq_blocks`: it has the diagonal tensor's `P` and norm;
* `sphere_unit_block`, `L227_attained`: the unit sphere product `S² × S³` on `Fin 3 ⊕ Fin 2`, the `S²` factor on the
  coordinates `inl 0, inl 1` of `J`, gives a unit Ricci-flat block operator with diagonal, hence commuting, blocks
  and `P = Θ₅ = 2√2/3`; membership in `𝒲₅` enters as Ricci-flatness, Bianchi and self-adjointness being L226's.
-/

namespace HamiltonsCubic.L227Attain

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.L226Statement HamiltonsCubic.L226Mixed
  HamiltonsCubic.L57Block

variable {m : ℕ}

/-- The `J` block of a weight: `(S_w)_xx = w_{x+1, x+2}`, the pair complementary to `x`. -/
noncomputable def Sw (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) : Matrix (Fin 3) (Fin 3) ℝ :=
  diagonal fun x => w (.inl (x + 1)) (.inl (x + 2))

/-- The mixed blocks. -/
noncomputable def Mw (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) (a : Fin m) : Matrix (Fin 3) (Fin 3) ℝ :=
  diagonal fun p => w (.inl p) (.inr a)

/-- The outer block. -/
def Kw (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) (a b : Fin m) : ℝ := w (.inr a) (.inr b)

theorem Sw_diag (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) : ∀ x y, x ≠ y → Sw w x y = 0 :=
  fun x y h => Matrix.diagonal_apply_ne _ h

theorem Mw_diag (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) : ∀ a x y, x ≠ y → Mw w a x y = 0 :=
  fun a x y h => Matrix.diagonal_apply_ne _ h

/-- **The blocks recover the weight.** -/
theorem wOf_blocks (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) (hs : ∀ i j, w i j = w j i)
    (hh : ∀ i, w i i = 0) : wOf (Sw w) (Mw w) (Kw w) = w := by
  ext i j
  rcases i with p | a <;> rcases j with q | b
  · simp only [wOf, Sw, Matrix.diagonal_apply_eq]
    have h0 := hh (.inl 0)
    have h1 := hh (.inl 1)
    have h2 := hh (.inl 2)
    fin_cases p <;> fin_cases q <;>
      simp [Fin.sum_univ_three, eps, Matrix.det_fin_three, Pi.single_apply, h0, h1, h2] <;>
      first | rfl | exact hs _ _
  · simp [wOf, Mw]
  · simp [wOf, Mw, hs (.inr a) (.inl q)]
  · simp [wOf, Kw]

theorem diag_isSymm (d : Fin 3 → ℝ) : (diagonal d).IsSymm := Matrix.diagonal_transpose d

/-- **A weight's block operator is Ricci-flat.** -/
theorem ricci_blocks (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) (hw : HamiltonsCubic.FamilyLayer.IsWeight w) :
    ∀ i j, Ric (blockOp (Sw w) (Mw w) (Kw w)) i j = 0 := by
  refine (ricciFlat_iff _ (diag_isSymm _) _ (fun a => diag_isSymm _) _ (fun a b => hw.symm _ _)
    (fun a => hw.hollow _)).mpr ⟨?_, fun a => ?_⟩
  · ext p q
    simp only [Sw, Mw, Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply, Matrix.sum_apply, Matrix.zero_apply,
      smul_eq_mul, Matrix.trace_diagonal, Fin.sum_univ_three]
    by_cases hpq : p = q
    · subst hpq
      have hr := hw.rowSum (.inl p)
      rw [Fintype.sum_sum_type, Fin.sum_univ_three] at hr
      have hs01 := hw.symm (.inl 0) (.inl 1)
      have hs02 := hw.symm (.inl 0) (.inl 2)
      have hs12 := hw.symm (.inl 1) (.inl 2)
      have h0 := hw.hollow (.inl 0)
      have h1 := hw.hollow (.inl 1)
      have h2 := hw.hollow (.inl 2)
      fin_cases p <;> simp [Matrix.diagonal_apply_eq] at hr ⊢ <;> linarith
    · simp [Matrix.diagonal_apply_ne _ hpq, Matrix.one_apply_ne hpq]
  · have hr := hw.rowSum (.inr a)
    rw [Fintype.sum_sum_type] at hr
    simp only [Mw, Kw, Matrix.trace_diagonal]
    have e : ∑ p : Fin 3, w (.inl p) (.inr a) = ∑ p : Fin 3, w (.inr a) (.inl p) :=
      Finset.sum_congr rfl fun p _ => hw.symm _ _
    rw [e]
    exact hr

/-- **The block operator of a weight has the diagonal tensor's `P` and norm.** -/
theorem Pcubic_norm_blocks (w : Matrix (Fin 3 ⊕ Fin m) (Fin 3 ⊕ Fin m) ℝ) (hw : HamiltonsCubic.FamilyLayer.IsWeight w) :
    Pcubic (blockOp (Sw w) (Mw w) (Kw w)) = Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) ∧
      normSq (blockOp (Sw w) (Mw w) (Kw w)) = normSq (HamiltonsCubic.FamilyLayer.diagOp w) := by
  have hK : ∀ a b, Kw w a b = Kw w b a := fun a b => hw.symm _ _
  have hK0 : ∀ a, Kw w a a = 0 := fun a => hw.hollow _
  have hwo := wOf_blocks w hw.symm hw.hollow
  have hlB := blockOp_isLinOp (Sw w) (Mw w) (Kw w)
  have hsB : ∀ X, IsSkew X → IsSkew (blockOp (Sw w) (Mw w) (Kw w) X) := fun X _ => opOf_isSkew _ X
  have hlD := HamiltonsCubic.RealLayer.isLinOp_diagOp w
  have hsD : ∀ X, IsSkew X → IsSkew (HamiltonsCubic.FamilyLayer.diagOp w X) :=
    fun X hX => HamiltonsCubic.FamilyLayer.diagOp_skew _ hw.symm X hX
  have hEq : HamiltonsCubic.TensorBridge.restrictLin hlB hsB = HamiltonsCubic.TensorBridge.restrictLin hlD hsD :=
    ContinuousLinearMap.ext fun X => Subtype.ext (by
      have := blockOp_diag_eq (Sw w) (Sw_diag w) (Mw w) (Mw_diag w) (Kw w) hK hK0 X X.2
      rw [hwo] at this
      exact this)
  refine ⟨?_, ?_⟩
  · rw [Pcubic_eq_restrictLin hlB hsB, Pcubic_eq_restrictLin hlD hsD, hEq]
  · rw [normSq_eq_restrictLin hlB hsB, normSq_eq_restrictLin hlD hsD, hEq]

/-- A unit multiple of a sphere-product weight, on any index type. -/
theorem sphere_unit_block {ι : Type*} [Fintype ι] [DecidableEq ι] (T : Finset ι) (hp : 2 ≤ T.card)
    (hq : 2 ≤ Tᶜ.card) :
    ∃ t : ℝ, 0 < t ∧ normSq (HamiltonsCubic.FamilyLayer.diagOp (t • HamiltonsCubic.FamilyLayer.sphereWeight T)) = 1 := by
  have hpR : (2 : ℝ) ≤ (T.card : ℝ) := by exact_mod_cast hp
  have hqR : (2 : ℝ) ≤ (Tᶜ.card : ℝ) := by exact_mod_cast hq
  set N := normSq (HamiltonsCubic.FamilyLayer.diagOp (HamiltonsCubic.FamilyLayer.sphereWeight T)) with hN
  have hNpos : 0 < N := by
    rw [hN, HamiltonsCubic.FamilyLayer.diagOp_normSq _ (HamiltonsCubic.FamilyLayer.sphereWeight_symm T)
      (HamiltonsCubic.FamilyLayer.sphereWeight_hollow T), HamiltonsCubic.L130Statement.sphereWeight_sumSq T hp hq]
    have h1 : (0 : ℝ) < (T.card : ℝ) - 1 := by linarith
    have h2 : (0 : ℝ) < (Tᶜ.card : ℝ) - 1 := by linarith
    apply mul_pos (by norm_num)
    apply div_pos _ (mul_pos h1 h2)
    have : (0 : ℝ) < (T.card : ℝ) + (Tᶜ.card : ℝ) - 2 := by linarith
    have : (0 : ℝ) < (T.card : ℝ) + (Tᶜ.card : ℝ) - 1 := by linarith
    positivity
  refine ⟨1 / Real.sqrt N, by positivity, ?_⟩
  rw [HamiltonsCubic.FamilyLayer.diagOp_normSq_smul _ _ (HamiltonsCubic.FamilyLayer.sphereWeight_symm T)
    (HamiltonsCubic.FamilyLayer.sphereWeight_hollow T), ← hN, div_pow, Real.sq_sqrt hNpos.le]
  field_simp

/-- **L227's attainment**: a unit Ricci-flat block operator at `n = 5` with diagonal, hence commuting, blocks has
`P = Θ₅ = 2√2/3`, the sphere product `S² × S³` read in the block family. -/
theorem L227_attained :
    ∃ (S : Matrix (Fin 3) (Fin 3) ℝ) (M : Fin 2 → Matrix (Fin 3) (Fin 3) ℝ) (K : Fin 2 → Fin 2 → ℝ),
      S.IsSymm ∧ (∀ a, (M a).IsSymm) ∧ (∀ a b, K a b = K b a) ∧ (∀ a, K a a = 0) ∧
      (∀ i j, Ric (blockOp S M K) i j = 0) ∧ (∀ a, S * M a = M a * S) ∧ (∀ a b, M a * M b = M b * M a) ∧
      normSq (blockOp S M K) = 1 ∧ Pcubic (blockOp S M K) = 2 * Real.sqrt 2 / 3 := by
  set T : Finset (Fin 3 ⊕ Fin 2) := {.inl 0, .inl 1} with hT
  have hTc : T.card = 2 := by rw [hT]; decide
  have hTcc : Tᶜ.card = 3 := by rw [Finset.card_compl, hTc]; simp
  have hp : 2 ≤ T.card := by rw [hTc]
  have hq : 2 ≤ Tᶜ.card := by rw [hTcc]; norm_num
  obtain ⟨t, ht, hn⟩ := sphere_unit_block T hp hq
  set w := t • HamiltonsCubic.FamilyLayer.sphereWeight T with hwdef
  have hw : HamiltonsCubic.FamilyLayer.IsWeight w := (HamiltonsCubic.FamilyLayer.sphereWeight_isWeight T hp hq).smul t
  have hθ := HamiltonsCubic.FamilyLayer.theta_sphereProduct_value T hp hq t ht hn
  rw [hTc, hTcc] at hθ
  have hval : HamiltonsCubic.FamilyLayer.thetaSplit ((2 : ℕ) : ℝ) ((3 : ℕ) : ℝ) = 2 * Real.sqrt 2 / 3 := by
    unfold HamiltonsCubic.FamilyLayer.thetaSplit
    have h := HamiltonsCubic.FamilyLayer.thetaSplitSq_odd (2 : ℝ) (by norm_num) (by norm_num) (by norm_num)
    rw [show ((3 : ℕ) : ℝ) = 2 + 1 by norm_num, show ((2 : ℕ) : ℝ) = 2 by norm_num, h]
    have h8 : HamiltonsCubic.FamilyLayer.ThetaSqOdd (2 * 2 + 1) = (2 * Real.sqrt 2 / 3) ^ 2 := by
      unfold HamiltonsCubic.FamilyLayer.ThetaSqOdd
      rw [div_pow, mul_pow, Real.sq_sqrt (by norm_num)]
      norm_num
    rw [h8, Real.sqrt_sq (by positivity)]
  rw [hval] at hθ
  have hnorm1 : HamiltonsCubic.RealLayer.norm (HamiltonsCubic.FamilyLayer.diagOp w) = 1 := by
    unfold HamiltonsCubic.RealLayer.norm; rw [hn, Real.sqrt_one]
  have hP : Pcubic (HamiltonsCubic.FamilyLayer.diagOp w) = 2 * Real.sqrt 2 / 3 := by
    unfold HamiltonsCubic.RealLayer.theta at hθ
    rw [hnorm1, one_pow, div_one] at hθ
    exact hθ
  obtain ⟨hPB, hNB⟩ := Pcubic_norm_blocks w hw
  refine ⟨Sw w, Mw w, Kw w, diag_isSymm _, fun a => diag_isSymm _, fun a b => hw.symm _ _, fun a => hw.hollow _,
    ricci_blocks w hw, fun a => ?_, fun a b => ?_, by rw [hNB, hn], by rw [hPB, hP]⟩
  · simp only [Sw, Mw, Matrix.diagonal_mul_diagonal, mul_comm]
  · simp only [Mw, Matrix.diagonal_mul_diagonal, mul_comm]

end HamiltonsCubic.L227Attain
