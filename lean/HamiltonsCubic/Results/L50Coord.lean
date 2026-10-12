import HamiltonsCubic.Results.L50Spectra
import HamiltonsCubic.Results.L50Expand

set_option linter.style.longLine false

/-!
# L50, the collapse on `𝒲ₙ` for `n ≤ 5`: `⟨M#, M⟩ = 2 tr M³` and `P = 3 tr M³`

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L50, link (b). [L50Expand.lean](L50Expand.lean)'s
`collapse` proves `β = α/2` for a coordinate tensor `W` with the Weyl symmetries and zero Ricci trace on at most five
index values. This file carries it to the layer's operators: `W = R4 R` satisfies `WeylC` (`weylC_R4`), its Ricci
trace is the layer's `Ric` (`ricci_R4`), and `alphaC`, `betaC` are [SecondKind.lean](SecondKind.lean)'s `alphaW`,
`betaW` summed over `Fin 6 → ι` rather than six nested sums (`sum6`). With [L50Spectra.lean](L50Spectra.lean)'s
`trCube_eq_alpha` and `sharpPair_eq_beta`:

- `betaW_collapse`: `β = α/2`;
- `sharpPair_collapse`: `⟨M#, M⟩ = 2 tr M³`;
- `Pcubic_collapse`: `P = 3 tr M³`, the record's `P = 3 tr W³` on `𝒲₅`.
-/

namespace HamiltonsCubic.SecondKind

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.Results HamiltonsCubic.L50Lovelock HamiltonsCubic.L50Spectra

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

omit [DecidableEq ι] in
/-- Peeling one coordinate off a sum over `Fin (k+1) → ι`. -/
theorem sum_cons {k : ℕ} (G : (Fin (k + 1) → ι) → ℝ) :
    ∑ x : Fin (k + 1) → ι, G x = ∑ a : ι, ∑ y : Fin k → ι, G (Fin.cons a y) := by
  rw [← Fintype.sum_prod_type']
  exact (Fintype.sum_equiv (Fin.consEquiv fun _ => ι) _ _ fun p => rfl).symm

omit [DecidableEq ι] in
/-- **A sum over `Fin 6 → ι` is six nested sums.** -/
theorem sum6 (F : ι → ι → ι → ι → ι → ι → ℝ) :
    ∑ x : Fin 6 → ι, F (x 0) (x 1) (x 2) (x 3) (x 4) (x 5) = ∑ i, ∑ j, ∑ k, ∑ l, ∑ m, ∑ n, F i j k l m n := by
  simp only [sum_cons (k := 5), sum_cons (k := 4), sum_cons (k := 3), sum_cons (k := 2), sum_cons (k := 1),
    sum_cons (k := 0)]
  simp only [Fintype.sum_unique]
  rfl

variable (R : Matrix ι ι ℝ → Matrix ι ι ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))
    (hB : ∀ i j k l, bianchi R i j k l = 0)

include hR hskew hsym hB in
/-- **`R4 R` carries the Weyl symmetries**: both antisymmetries, pair symmetry and first Bianchi. -/
theorem weylC_R4 : WeylC (R4 R) where
  anti12 a b c d := by linarith [R4_anti1 R hR hskew hsym a b c d]
  anti34 a b c d := by linarith [R4_anti2 R hR a b c d]
  pair a b c d := R4_pair R hR hskew hsym a b c d
  bianchi a b c d := hB a b c d

/-- **The Ricci trace of `R4 R` is the layer's `Ric`.** -/
theorem ricci_R4 (a b : ι) : ∑ c, R4 R a c b c = Ric R a b := rfl

theorem alphaC_R4 : alphaC (R4 R) = alphaW R := by
  unfold alphaC alphaW
  exact sum6 fun i j k l m n => R4 R i j k l * R4 R i j m n * R4 R k l m n

theorem betaC_R4 : betaC (R4 R) = betaW R := by
  unfold betaC betaW
  exact sum6 fun i j k l m n => R4 R i j k l * R4 R i m k n * R4 R j m l n

include hR hskew hsym hB in
/-- **`β = α/2` on a Ricci-flat operator with at most five index values.** -/
theorem betaW_collapse (hRic : ∀ a b, Ric R a b = 0) (hcard : Fintype.card ι ≤ 5) :
    betaW R = alphaW R / 2 := by
  rw [← alphaC_R4, ← betaC_R4]
  exact collapse (weylC_R4 R hR hskew hsym hB) (fun a b => (ricci_R4 R a b).trans (hRic a b)) hcard

include hR hskew hsym hB in
/-- **LINK (b)**: `⟨M#, M⟩ = 2 tr M³` on a Ricci-flat operator with at most five index values. -/
theorem sharpPair_collapse (hRic : ∀ a b, Ric R a b = 0) (hcard : Fintype.card ι ≤ 5) :
    sharpPair R = 2 * trCube R := by
  rw [sharpPair_eq_beta R hR hskew hsym, trCube_eq_alpha R hskew hsym,
    betaW_collapse R hR hskew hsym hB hRic hcard]
  ring

include hR hskew hsym hB in
/-- **L50's COLLAPSE**: `P = 3 tr M³` on a Ricci-flat operator with at most five index values. -/
theorem Pcubic_collapse (hRic : ∀ a b, Ric R a b = 0) (hcard : Fintype.card ι ≤ 5) :
    Pcubic R = 3 * trCube R := by
  rw [Pcubic_eq_alpha_beta R hR hskew hsym, trCube_eq_alpha R hskew hsym,
    betaW_collapse R hR hskew hsym hB hRic hcard]
  ring

end HamiltonsCubic.SecondKind
