import HamiltonsCubic.Results.SecondKindMatrix
import HamiltonsCubic.Results.L54Basis

set_option linter.style.longLine false

/-!
# L50's two traces vanish, and `W̊` lives on `S²₀` with `g` in its kernel

[findings/bispectral.md](../../../findings/bispectral.md), Lemma L50, reads
`P = (3/2) ∑ μ³ − (1/2) ∑ ω³` with `μ` the spectrum of `M` on `Λ²` and `ω` that of `W̊` on `S²₀`.
[SecondKindMatrix.lean](SecondKindMatrix.lean)'s `L50_spectral` proves it with `ω` the spectrum of
`Bmat (ringW R)` on all of `S²`. **This file proves, at a Ricci-flat `R`**:

- `ringW_one_zero`: `W̊ g = 0`, so the metric `g` is in the kernel of `W̊` on `S²`;
- `trace_ringW_zero`: `tr W̊ h = 0` for every `h`, so the image of `W̊` lies in `S²₀`;
- `sum_mu_zero`: `∑ μ = tr M = 0`;
- `sum_omega_zero`: `∑ ω = tr W̊ = 0`.

*The first two are what the splitting `S² = S²₀ ⊕ ℝg` needs: `W̊` preserves `S²₀` and kills `g`.
The splitting itself, that `S²₀ = g^⊥` in the Frobenius pairing so the spectrum of `Bmat` is its
spectrum on `S²₀` with one extra `0`, is [L50Split.lean](L50Split.lean)'s `Bmat_compress` in block form, the spectrum
read off it.*
-/

namespace HamiltonsCubic.SecondKind

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.Results

variable {n : ℕ}

section W

variable (R : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hR : IsLinOp R)
    (hskew : ∀ X, IsSkew X → IsSkew (R X))
    (hsym : ∀ X Y, IsSkew X → IsSkew Y → inner2 (R X) Y = inner2 X (R Y))

/-- `∑_{a,b} R_{abab} = ∑_a Ric_{aa}`. -/
theorem sum_R4_diag : ∑ a, ∑ b, R4 R a b a b = ∑ a, Ric R a a := rfl

include hR in
/-- **`W̊ g = 0` at a Ricci-flat `R`.** -/
theorem ringW_one_zero (hRic : ∀ a b, Ric R a b = 0) : ringW R 1 = 0 := by
  ext i j; rw [ringW_one R hR, hRic, neg_zero]; rfl

include hR hskew hsym in
/-- **`tr W̊ h = 0` at a Ricci-flat `R`**, so `W̊` maps into `S²₀`. -/
theorem trace_ringW_zero (hRic : ∀ a b, Ric R a b = 0) (h : Matrix (Fin n) (Fin n) ℝ) :
    (ringW R h).trace = 0 := by
  rw [trace_ringW R hR hskew hsym]; simp [frob, hRic]

include hR hskew hsym in
/-- **`∑ μ = 0` at a Ricci-flat `R`**: `tr M = ∑_{a<b} R_{abab} = ½ ∑_a Ric_{aa}`. -/
theorem sum_mu_zero (hRic : ∀ a b, Ric R a b = 0) :
    ∑ j, (Mpair_isHermitian R hR hskew hsym).eigenvalues j = 0 := by
  have h1 := trace_pow_eq_sum_eigenvalues (Mpair R) (Mpair_isHermitian R hR hskew hsym) 1
  simp only [pow_one] at h1
  rw [← h1]
  have htr : (Mpair R).trace = ∑ p : Pairs n, R4 R p.1.1 p.1.2 p.1.1 p.1.2 := by
    unfold Matrix.trace; rfl
  have hpairs := sum_pairs (fun i j => R4 R i j i j) (fun i => R4_self_left R hR i i i)
    (fun i j => by rw [R4_anti1 R hR hskew hsym j i i j, R4_anti2 R hR j i i j])
  have hs : ∑ i, ∑ j, R4 R i j i j = 0 := by
    rw [sum_R4_diag]; simp [hRic]
  rw [htr]; linarith

include hR hskew hsym in
/-- **`∑ ω = 0` at a Ricci-flat `R`**: `tr W̊ = ½ ∑_{a,b} R_{abab}`. -/
theorem sum_omega_zero (hRic : ∀ a b, Ric R a b = 0) :
    ∑ j, (Bmat_isHermitian R hR hskew hsym).eigenvalues j = 0 := by
  have h1 := trace_pow_eq_sum_eigenvalues (Bmat (ringW R)) (Bmat_isHermitian R hR hskew hsym) 1
  simp only [pow_one] at h1
  rw [← h1, trace_Bmat _ (fun a b => ringW_isSymm_of R hR hskew hsym _ (symB_isSymm a b))
    (fun c X => ringW_smul R c X)]
  unfold trS2
  simp only [ringW_symB, R4_self_left R hR, zero_add]
  have hs : ∑ a, ∑ b, R4 R a b a b = 0 := by
    rw [sum_R4_diag]; simp [hRic]
  simp only [← Finset.mul_sum]
  rw [hs, mul_zero]

end W

end HamiltonsCubic.SecondKind
