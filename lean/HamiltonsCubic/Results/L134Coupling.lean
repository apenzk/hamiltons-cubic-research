import HamiltonsCubic.Results.DefectCP2
import HamiltonsCubic.Results.L50Spectra
import HamiltonsCubic.Results.L209BianchiHalf

set_option linter.style.longLine false

/-!
# L134(c)'s margin half: the trilinear coupling `T(u, H, H) = ⟨u, Q(H)⟩` vanishes on disjoint blocks

[findings/route-a.md](../../../findings/route-a.md), Lemma L134(c): *"The same disjointness kills the trilinear
coupling `T(u, H, H)`, so `⟨L_eH, H⟩ = 0`"*, where `T(u, H, H) = ⟨u, Q(H)⟩`. The passage to `⟨L_eH, H⟩ = θ⁻¹⟨u, Q(H)⟩` in
this layer is [FoxBridge.lean](FoxBridge.lean)'s `foxTri_symm_right`, which needs the padded competitor to be a Weyl
operator here, and is owed.

Both halves of `Q(H) = H² + H#` keep the first index inside `H`'s block: `(H²)_{ijkl} = ½ ∑ H_{ijmn} H_{klmn}` and
`(H#)_{ijkl} = B_{ijkl} − B_{ijlk}` with `B_{ijkl} = ∑ H_{ipkq} H_{jplq}`. So `⟨u, Q(H)⟩ = ¼ ∑ u_{ijkl} Q(H)_{ijkl}`
is a sum of products each with a vanishing factor.

- `innerOp_eq_R4`: `⟨A, B⟩ = ¼ ∑ R4(A) R4(B)` for operators mapping bivectors to bivectors;
- `R4_Qop_zero`: `Q(H)` vanishes at every first index where `H` does;
- **`coupling_zero`** and **`L134c_coupling`**: `⟨u, Q(H)⟩ = 0` at the padded competitor.
-/

namespace HamiltonsCubic.L134Coupling

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.AltLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- `⟨A, B⟩ = ¼ ∑ R4(A)_{ijkl} R4(B)_{ijkl}`. -/
theorem innerOp_eq_R4 (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (hA : ∀ i j, IsSkew (A (phi i j)))
    (hB : ∀ i j, IsSkew (B (phi i j))) :
    innerOp A B = (1 / 4) * ∑ i, ∑ j, ∑ k, ∑ l, R4 A i j k l * R4 B i j k l := by
  unfold innerOp
  have e : ∀ i j, inner2 (A (phi i j)) (B (phi i j)) = (1 / 2) * ∑ k, ∑ l, R4 A i j k l * R4 B i j k l := by
    intro i j
    rw [inner2_eq_sum]
    congr 1
    refine Finset.sum_congr rfl fun k _ => Finset.sum_congr rfl fun l _ => ?_
    rw [R4, R4, inner2_phi _ (hA i j), inner2_phi _ (hB i j)]; ring
  simp only [e, Finset.mul_sum]
  exact Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ =>
    Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => by ring

/-- **`Q(H)` vanishes at every first index where `H` does.** -/
theorem R4_Qop_zero (H : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeylOp H) (i : ι)
    (hH : ∀ j k l, R4 H i j k l = 0) (j k l : ι) : R4 (Qop H) i j k l = 0 := by
  have hsplit : R4 (Qop H) i j k l = R4 (compOp H) i j k l + R4 (sharpOp H) i j k l := by
    unfold R4 Qop; exact FamilyLayer.inner2_add_left _ _ _
  rw [hsplit, HamiltonsCubic.L50Spectra.R4_compOp_sum H hW.2.1 hW.2.2.1, R4_sharpOp _ hW.1,
    sharpBil_phi_B _ hW.1 hW.2.1 hW.2.2.1]
  simp [B4, hH]

/-- **THE COUPLING VANISHES ON DISJOINT BLOCKS**: if `U` vanishes at every first index outside `S` and the Weyl
operator `H` at every first index inside it, `⟨U, Q(H)⟩ = 0`. -/
theorem coupling_zero (U H : Matrix ι ι ℝ → Matrix ι ι ℝ) (hU : ∀ i j, IsSkew (U (phi i j))) (hW : IsWeylOp H)
    (S : Finset ι) (hUS : ∀ i j k l, i ∉ S → R4 U i j k l = 0) (hHS : ∀ i j k l, i ∈ S → R4 H i j k l = 0) :
    innerOp U (Qop H) = 0 := by
  have hQ := HamiltonsCubic.Results.Qop_isWeylOp H hW
  rw [innerOp_eq_R4 U (Qop H) hU fun i j => hQ.2.1 _ (phi_isSkew i j)]
  have : ∀ i j k l, R4 U i j k l * R4 (Qop H) i j k l = 0 := by
    intro i j k l
    by_cases hi : i ∈ S
    · rw [R4_Qop_zero H hW i (hHS i · · · hi) j k l, mul_zero]
    · rw [hUS i j k l hi, zero_mul]
  simp [this]

open HamiltonsCubic.DefectCP2 in
/-- **L134(c)'s MARGIN HALF**: at the padded competitor `u` and a Weyl `H` presented by bivectors on the complementary
`ℝⁿ⁻⁴`, the trilinear coupling `⟨u, Q(H)⟩` vanishes. -/
theorem L134c_coupling {n s : ℕ} (mu : Fin s → ℝ) (eta : Fin s → Matrix (Fin n) (Fin n) ℝ)
    (heta : ∀ δ, IsSkew (eta δ)) (hB : ∀ i j k l, bianchi (specOp mu eta) i j k l = 0)
    (hRic : ∀ a b, Ric (specOp mu eta) a b = 0) (hoff : ∀ δ (a b : Fin n), a.val < 4 → eta δ a b = 0) :
    innerOp (specOp lamU (omU (n := n))) (Qop (specOp mu eta)) = 0 := by
  have hWH : IsWeylOp (specOp mu eta) :=
    ⟨⟨specOp_add mu eta, fun c X => specOp_smul c mu eta X⟩, fun X _ => specOp_isSkew mu eta heta X,
      fun X Y _ _ => specOp_symmetric mu eta X Y, hB, hRic⟩
  have hsku : ∀ γ, IsSkew (omU (n := n) γ) := fun γ => pad_skew _ (omCP2_skew γ)
  refine coupling_zero _ _ (fun i j => specOp_isSkew _ _ hsku _) hWH (Finset.univ.filter fun x : Fin n => x.val < 4)
    (fun i j k l hi => ?_) (fun i j k l hi => ?_)
  · have : comp (specOp lamU (omU (n := n))) i j k l = 0 := by
      rw [comp_specOp_apply _ _ hsku]
      refine Finset.sum_eq_zero fun γ _ => ?_
      simp at hi
      rw [show omU (n := n) γ i j = 0 from pad_zero _ i j (by omega)]; ring
    exact this
  · have : comp (specOp mu eta) i j k l = 0 := by
      rw [comp_specOp_apply _ _ heta]
      refine Finset.sum_eq_zero fun δ _ => ?_
      simp at hi
      rw [hoff δ i j hi]; ring
    exact this

end HamiltonsCubic.L134Coupling
