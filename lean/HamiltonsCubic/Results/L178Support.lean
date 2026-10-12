import HamiltonsCubic.Results.L178Reduce
import HamiltonsCubic.Results.FoxBridge
import HamiltonsCubic.Results.L24Sharp

set_option linter.style.longLine false

/-!
# L178 on `ℝⁿ`: a supported Weyl operator is its `W_C`

[L178Reduce.lean](L178Reduce.lean)'s `L178_padded` bounds `θ(W_C)` for the operators written in the basis
`e = (ω⁺, ω⁻)` of the coordinate `Λ²ℝ⁴`. This file identifies every Weyl operator supported there with its
`W_C`:

* **`eF_inner`**: `e` is orthonormal, the self-dual and anti-self-dual halves orthogonal by `J_K_orth`;
* **`supported_eq_WC`**: a Weyl `R` on `ℝⁿ` that kills the bivectors orthogonal to `e` and takes values in
  `span e` is `W_C` on bivectors, for `C_{ij} = ⟨R e_i, e_j⟩`, which is symmetric;
* **`L178_supported`**: **L178 on `ℝⁿ` for `V` the first four coordinates**, stated for the operator: a
  nonzero Weyl `R` supported on `Λ²ℝ⁴` whose coefficient matrix has rank at most three has
  `θ(R) ≤ √(3/2)`.
-/

namespace HamiltonsCubic.CP2Real

open Matrix HamiltonsCubic.RealLayer

variable {n : ℕ}

theorem eF_inl (a : Fin 3) : eF (n := n) (Sum.inl a) = omF stdFrame a := rfl
theorem eF_inr (b : Fin 3) : eF (n := n) (Sum.inr b) = omF asdFrame b := rfl

/-- **`e` is orthonormal.** -/
theorem eF_inner (hn : 4 ≤ n) (i j : Fin 3 ⊕ Fin 3) :
    inner2 (eF (n := n) i) (eF j) = if i = j then 1 else 0 := by
  have mixed : ∀ a b, inner2 (eF (n := n) (Sum.inl a)) (eF (Sum.inr b)) = 0 := fun a b => by
    have h : (eF (n := n) (Sum.inl a))ᵀ * eF (Sum.inr b) = (sq2⁻¹ * sq2⁻¹) • (Emb n * ((J a)ᵀ * K b) * (Emb n)ᵀ) := by
      unfold eF
      rw [Matrix.transpose_smul, conjT, Matrix.smul_mul, Matrix.mul_smul, smul_smul, sandwich hn]; rfl
    unfold inner2
    rw [h, Matrix.trace_smul, Matrix.trace_mul_comm, ← Matrix.mul_assoc, Emb_orth hn, Matrix.one_mul, J_K_orth]
    simp
  rcases i with a | a <;> rcases j with b | b
  · rw [eF_inl, eF_inl, omF_inner _ hn]; simp
  · rw [mixed]; simp
  · rw [inner2_comm, mixed]; simp
  · rw [eF_inr, eF_inr, omF_inner _ hn]; simp

/-- **A supported Weyl operator is its `W_C`**: if `R` is Weyl, kills the bivectors orthogonal to `e`, and
takes every bivector into `span e`, then on bivectors `R = W_C` with `C_{ij} = ⟨R e_i, e_j⟩`. -/
theorem supported_eq_WC (hn : 4 ≤ n) {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R)
    (hker : ∀ X, IsSkew X → (∀ i, inner2 X (eF i) = 0) → R X = 0)
    (hran : ∀ X Y, IsSkew X → IsSkew Y → (∀ i, inner2 Y (eF i) = 0) → inner2 (R X) Y = 0)
    (X : Matrix (Fin n) (Fin n) ℝ) (hX : IsSkew X) :
    R X = WC n (fun i j => inner2 (R (eF i)) (eF j)) X := by
  obtain ⟨r, g, hgs, hgon, hfg, hcomp⟩ :=
    HamiltonsCubic.FrameExtension.extend_frame (eF (n := n)) eF_skew (eF_inner hn)
  have hes : ∀ i, IsSkew (eF (n := n) i) := eF_skew
  have hEs : IsSkew (∑ i, inner2 X (eF i) • eF (n := n) i) :=
    HamiltonsCubic.L41Statement.Frame.isSkew_sum _ _ _ hes
  have hGs : IsSkew (∑ c, inner2 X (g c) • g c) :=
    HamiltonsCubic.L41Statement.Frame.isSkew_sum _ _ _ hgs
  have hG_perp : ∀ i, inner2 (∑ c, inner2 X (g c) • g c) (eF i) = 0 := fun i => by
    rw [HamiltonsCubic.L41Statement.Frame.inner2_sum_l]
    exact Finset.sum_eq_zero fun c _ => by
      rw [HamiltonsCubic.L41Statement.Frame.inner2_smul_l, inner2_comm (g c), hfg i c, mul_zero]
  -- additivity of `R` on bivectors
  have hadd : ∀ A B, IsSkew A → IsSkew B → R (A + B) = R A + R B := fun A B hA hB => by
    have h := HamiltonsCubic.L41Statement.Frame.weyl_lin hW Finset.univ (fun _ : Fin 2 => (1 : ℝ)) ![A, B]
      (fun k => by fin_cases k <;> simpa)
    simpa [Fin.sum_univ_two] using h
  have hRX : R X = ∑ i, inner2 X (eF i) • R (eF i) := by
    conv_lhs => rw [hcomp X hX]
    rw [hadd _ _ hEs hGs, hker _ hGs hG_perp, add_zero]
    exact HamiltonsCubic.L41Statement.Frame.weyl_lin hW Finset.univ _ _ hes
  -- each `R e_i` lies in `span e`
  have hRe : ∀ i, R (eF i) = ∑ j, inner2 (R (eF i)) (eF j) • eF (n := n) j := fun i => by
    have hs := hW.1 _ (hes i)
    conv_lhs => rw [hcomp _ hs]
    have : ∑ c, inner2 (R (eF i)) (g c) • g c = 0 :=
      Finset.sum_eq_zero fun c _ => by
        rw [hran _ _ (hes i) (hgs c) (fun j => by rw [inner2_comm]; exact hfg j c), zero_smul]
    rw [this, add_zero]
  rw [hRX]
  unfold WC
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [hRe i, Finset.smul_sum]
  exact Finset.sum_congr rfl fun j _ => by rw [smul_smul, mul_comm]

/-- The coefficient matrix of a Weyl operator is symmetric. -/
theorem coeff_symm {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R) (i j : Fin 3 ⊕ Fin 3) :
    inner2 (R (eF (n := n) i)) (eF j) = inner2 (R (eF j)) (eF i) := by
  rw [hW.2.1 _ _ (eF_skew i) (eF_skew j), inner2_comm]

/-- **L178 on `ℝⁿ` for `V` the first four coordinates, stated for the operator.** A nonzero Weyl `R`
supported on the coordinate `Λ²ℝ⁴`, killing the bivectors orthogonal to it and taking values in it, whose
coefficient matrix `C_{ij} = ⟨R e_i, e_j⟩` has rank at most three, has `θ(R) ≤ √(3/2)`. -/
theorem L178_supported (hn : 4 ≤ n) {R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ} (hW : IsWeyl R)
    (hker : ∀ X, IsSkew X → (∀ i, inner2 X (eF i) = 0) → R X = 0)
    (hran : ∀ X Y, IsSkew X → IsSkew Y → (∀ i, inner2 Y (eF i) = 0) → inner2 (R X) Y = 0)
    (hrank : (Matrix.of fun i j => inner2 (R (eF (n := n) i)) (eF j)).rank ≤ 3)
    (h0 : (Matrix.of fun i j => inner2 (R (eF (n := n) i)) (eF j)) ≠ 0) :
    theta R ≤ Real.sqrt (3 / 2) := by
  set C : Matrix (Fin 3 ⊕ Fin 3) (Fin 3 ⊕ Fin 3) ℝ := Matrix.of fun i j => inner2 (R (eF (n := n) i)) (eF j)
  have hRC : ∀ X, IsSkew X → R X = WC n C X := fun X hX => supported_eq_WC hn hW hker hran X hX
  have hR := hW.1
  -- `W_C` is Weyl: every clause reads `R` on bivectors only
  have hWC : IsWeyl (WC n C) := by
    refine ⟨fun X hX => by rw [← hRC X hX]; exact hR X hX,
      fun X Y hX hY => by rw [← hRC X hX, ← hRC Y hY]; exact hW.2.1 X Y hX hY,
      fun i j k l => ?_, fun a b => ?_⟩
    · have h := hW.2.2.1 i j k l
      unfold bianchi at h ⊢
      simp only [hRC _ (phi_isSkew _ _)] at h
      exact h
    · have h := hW.2.2.2 a b
      unfold Ric at h ⊢
      simp only [hRC _ (phi_isSkew _ _)] at h
      exact h
  -- `θ` reads `R` only on bivectors
  have hθ : theta R = theta (WC n C) := by
    have hcomp : ∀ X, IsSkew X → compOp R X = compOp (WC n C) X := fun X hX => by
      unfold compOp; rw [hRC X hX, hRC _ (hWC.1 X hX)]
    have hsharp : ∀ X, IsSkew X → sharpOp R X = sharpOp (WC n C) X :=
      HamiltonsCubic.TensorBridge.sharpOp_congr_on_skew hR hRC
    have hN : normSq R = normSq (WC n C) := innerOp_congr_skew hRC hRC
    have hP : Pcubic R = Pcubic (WC n C) := by
      unfold Pcubic trCube sharpPair
      rw [innerOp_congr_skew hcomp hRC, innerOp_congr_skew hRC hsharp]
    unfold theta HamiltonsCubic.RealLayer.norm
    rw [hN, hP]
  rw [hθ]
  exact L178_padded hn C (fun i j => coeff_symm hW i j) hWC hrank h0

end HamiltonsCubic.CP2Real
