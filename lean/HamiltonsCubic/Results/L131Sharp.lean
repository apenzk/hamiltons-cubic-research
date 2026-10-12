import HamiltonsCubic.Results.L41Statement
import HamiltonsCubic.Base.FoxProduct

set_option linter.style.longLine false

/-!
# L131's core: `W # I = -W` for every Weyl operator

[isotropy-cap.md](../../../findings/isotropy-cap.md), Lemma L131, identifies `𝒜 = -2(·#I)`, and its consequence
(ii) is that `Weyl_n` is the `-1` eigenspace of `·#I`, which is Böhm–Wilking's Lemma 2.1 on the Weyl summand.
This file proves the inclusion, that every Weyl operator has eigenvalue `-1`, in the layer's own `#`, the polarised `sharpOp` of
[FoxProduct.lean](../Base/FoxProduct.lean)'s `sharpCross`:

* **`swap_ad`**: `Σ_{ij} ⟨W[η,φ_{ij}], [η,φ_{ij}]⟩ = Σ_{ij} ⟨[η,Wφ_{ij}], [η,φ_{ij}]⟩`, the trace identity
  `tr(W ad²) = tr(ad W ad)` read in the `φ` basis, from the `φ`-expansion and polarised Parseval;
* **`cross_QF`**: the cross term of the quadratic form, `♯(W+I)(η) - ♯W(η) - ♯I(η) = -2⟨Wη, η⟩`, from
  [L41Statement.lean](L41Statement.lean)'s `aW2`, `𝒜(W) = 2W` as a quadratic form;
* **`sharpCross_id`**: **`W # I = -W` on bivectors**, polarising the quadratic statement.
-/

namespace HamiltonsCubic.L41Statement.Frame

open Matrix HamiltonsCubic.RealLayer

variable {ι : Type*} [Fintype ι] [DecidableEq ι] {W : Matrix ι ι ℝ → Matrix ι ι ℝ}

/-- **The trace swap**: `Σ ⟨W[η,φ], [η,φ]⟩ = Σ ⟨[η,Wφ], [η,φ]⟩`. -/
theorem swap_ad (hW : IsWeyl W) (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    ∑ i, ∑ j, inner2 (W (br η (phi i j))) (br η (phi i j))
      = ∑ i, ∑ j, inner2 (br η (W (phi i j))) (br η (phi i j)) := by
  have hA : ∀ i j, IsSkew (br η (phi i j)) := fun i j => br_skew hη (phi_isSkew i j)
  have hWp : ∀ a b, IsSkew (W (phi a b)) := fun a b => hW.1 _ (phi_isSkew a b)
  -- expand `W[η,φ_ij]` in the `φ` basis
  have e : ∀ i j, inner2 (W (br η (phi i j))) (br η (phi i j))
      = ∑ a, ∑ b, (1 / 2) * inner2 (phi i j) (br η (phi a b)) * inner2 (br η (W (phi a b))) (phi i j) := by
    intro i j
    have hexp := congrArg W (phi_expand (br η (phi i j)) (hA i j))
    rw [weyl_lin2 hW _ phi (fun a b => phi_isSkew a b)] at hexp
    rw [hexp, inner2_sum_l]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [inner2_sum_l]
    refine Finset.sum_congr rfl fun b _ => ?_
    rw [inner2_smul_l]
    have h1 : inner2 (br η (phi i j)) (phi a b) = -inner2 (phi i j) (br η (phi a b)) :=
      adinv _ hη (phi_isSkew i j)
    have h2 : inner2 (W (phi a b)) (br η (phi i j)) = -inner2 (br η (W (phi a b))) (phi i j) := by
      rw [adinv _ hη (hWp a b)]; ring
    rw [h1, h2]; ring
  simp only [e]
  have sw : ∀ f : ι → ι → ι → ι → ℝ, ∑ i, ∑ j, ∑ a, ∑ b, f i j a b = ∑ a, ∑ b, ∑ i, ∑ j, f i j a b := by
    intro f
    calc ∑ i, ∑ j, ∑ a, ∑ b, f i j a b = ∑ i, ∑ a, ∑ b, ∑ j, f i j a b := by
          refine Finset.sum_congr rfl fun i _ => ?_
          rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun a _ => Finset.sum_comm
      _ = ∑ a, ∑ b, ∑ i, ∑ j, f i j a b := by
          rw [Finset.sum_comm]; exact Finset.sum_congr rfl fun a _ => Finset.sum_comm
  rw [sw]
  refine Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => ?_
  have hp := parseval _ _ (br_skew hη (phi_isSkew a b)) (br_skew hη (hWp a b))
  rw [inner2_comm, ← hp, Finset.mul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [inner2_comm (phi i j), inner2_comm (br η (W (phi a b)))]; ring

/-- **The cross term of the `#` quadratic form**: `♯(W+I)(η) - ♯W(η) - ♯I(η) = -2⟨Wη, η⟩` at a Weyl `W`. -/
theorem cross_QF (hW : IsWeyl W) (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    sharpQF (fun X => W X + X) η - sharpQF W η - sharpQF (fun X => X) η = -2 * inner2 (W η) η := by
  have hadd : ∀ A B, IsSkew A → IsSkew B → W (A + B) = W A + W B := fun A B hA hB => by
    have h := weyl_lin hW Finset.univ (fun _ : Fin 2 => (1 : ℝ)) ![A, B] (fun k => by fin_cases k <;> simpa)
    simpa [Fin.sum_univ_two] using h
  have hWp : ∀ a b, IsSkew (W (phi a b)) := fun a b => hW.1 _ (phi_isSkew a b)
  have hA : ∀ i j, IsSkew (br η (phi i j)) := fun i j => br_skew hη (phi_isSkew i j)
  have hB : ∀ i j, IsSkew (br η (W (phi i j))) := fun i j => br_skew hη (hWp i j)
  have hterm : ∀ i j, inner2 (br η (W (br η (W (phi i j) + phi i j)) + br η (W (phi i j) + phi i j))) (phi i j)
      - inner2 (br η (W (br η (W (phi i j))))) (phi i j) - inner2 (br η (br η (phi i j))) (phi i j)
      = -inner2 (W (br η (phi i j))) (br η (phi i j)) - inner2 (br η (W (phi i j))) (br η (phi i j)) := by
    intro i j
    have e1 : br η (W (phi i j) + phi i j) = br η (W (phi i j)) + br η (phi i j) := br_add_r' _ _ _
    rw [e1, hadd _ _ (hB i j) (hA i j), br_add_r', br_add_r', br_add_r']
    simp only [inner2_add_l]
    rw [adinv _ hη (hW.1 _ (hA i j)), adinv _ hη (hB i j)]
    ring
  unfold sharpQF
  have hsum : (∑ i, ∑ j, inner2 (br η (W (br η (W (phi i j) + phi i j)) + br η (W (phi i j) + phi i j))) (phi i j))
      - (∑ i, ∑ j, inner2 (br η (W (br η (W (phi i j))))) (phi i j))
      - (∑ i, ∑ j, inner2 (br η (br η (phi i j))) (phi i j))
      = -(∑ i, ∑ j, inner2 (W (br η (phi i j))) (br η (phi i j)))
        - (∑ i, ∑ j, inner2 (br η (W (phi i j))) (br η (phi i j))) := by
    simp only [← Finset.sum_sub_distrib, ← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => hterm i j
  have h2 := aW2 hW η hη
  have hs := swap_ad hW η hη
  have key : -(1 / 4 : ℝ) * (∑ i, ∑ j, inner2 (br η (W (br η (W (phi i j) + phi i j)) + br η (W (phi i j) + phi i j))) (phi i j))
      - -(1 / 4 : ℝ) * (∑ i, ∑ j, inner2 (br η (W (br η (W (phi i j))))) (phi i j))
      - -(1 / 4 : ℝ) * (∑ i, ∑ j, inner2 (br η (br η (phi i j))) (phi i j)) = -2 * inner2 (W η) η := by
    have := hsum
    rw [← hs] at this
    linarith
  convert key using 3

/-- **`W # I = -W` on bivectors**, for every Weyl `W`: Böhm–Wilking's Lemma 2.1 on the Weyl summand, in the
layer's polarised `#`. -/
theorem sharpCross_id (hW : IsWeyl W) (Z : Matrix ι ι ℝ) (hZ : IsSkew Z) :
    sharpCross W (fun X => X) Z = -W Z := by
  have hadd : ∀ A B, IsSkew A → IsSkew B → W (A + B) = W A + W B := fun A B hA hB => by
    have h := weyl_lin hW Finset.univ (fun _ : Fin 2 => (1 : ℝ)) ![A, B] (fun k => by fin_cases k <;> simpa)
    simpa [Fin.sum_univ_two] using h
  have hsum : ∀ A B : Matrix ι ι ℝ, IsSkew A → IsSkew B → IsSkew (A + B) := fun A B hA hB => by
    change (A + B)ᵀ = -(A + B)
    rw [Matrix.transpose_add, hA, hB]; abel
  -- the cross term of `sharpBil`, polarised from `cross_QF`
  have hbil : ∀ i j, sharpBil (W + fun X => X) Z (phi i j) - sharpBil W Z (phi i j)
      - sharpBil (fun X => X) Z (phi i j) = -2 * inner2 (W Z) (phi i j) := by
    intro i j
    have hp := phi_isSkew i j
    have c1 := cross_QF hW (Z + phi i j) (hsum _ _ hZ hp)
    have c2 := cross_QF hW Z hZ
    have c3 := cross_QF hW (phi i j) hp
    have hWZ : W (Z + phi i j) = W Z + W (phi i j) := hadd _ _ hZ hp
    have hsym : inner2 (W (phi i j)) Z = inner2 (W Z) (phi i j) := by
      rw [hW.2.1 _ _ hp hZ, inner2_comm]
    unfold sharpBil
    have e : (W + fun X => X) = fun X => W X + X := rfl
    rw [e]
    rw [hWZ, inner2_add_l, HamiltonsCubic.RealLayer.inner2_add_right, HamiltonsCubic.RealLayer.inner2_add_right,
      hsym] at c1
    linarith
  unfold sharpCross sharpOp
  rw [← smul_sub, ← smul_sub, ← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib]
  simp only [← Finset.sum_sub_distrib, ← sub_smul, hbil]
  have hexp := phi_expand (W Z) (hW.1 _ hZ)
  conv_rhs => rw [hexp]
  rw [← Finset.sum_neg_distrib, Finset.smul_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← Finset.sum_neg_distrib, Finset.smul_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [smul_smul, smul_smul, ← neg_smul]
  congr 1; ring

end HamiltonsCubic.L41Statement.Frame
