import Mathlib
import HamiltonsCubic.Results.L244RowB

/-!
# L244, row (B) split over the eigenspace classes

[findings/second-order.md](../../../findings/second-order.md), Lemma L244 (i), row (B):
`∑_{a,b} λ_b B_ab = I#W = −W`. With linear projections `P_a` resolving the identity and
`W = ∑_b λ_b P_b`, bilinearity of `mixSym` turns `rowB` into
`∑_a ∑_b λ_b · mixSym P_a P_b η = −2 ⟨W η, η⟩` (`rowB_classes`), where
`mixSym P_a P_b η = 2 ⟨(P_a # P_b) η, η⟩ = 2 ⟨B_ab η, η⟩`.

**Not typed here**: the identification of `mixSym P_a P_b x` with the record's
`b_ab(x) = ½ ∑_{γ∈E_a, δ∈E_b} ⟨[ψ_γ, ψ_δ], x⟩²` (`bMass`), which needs `P_a` written through an
orthonormal eigenbasis.
-/

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.L244RowB HamiltonsCubic.Results

namespace HamiltonsCubic.L244RowBClasses

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem mixSym_comm (A B : Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) :
    mixSym A B η = mixSym B A η := by unfold mixSym; ring

theorem mixSym_zero_right (e : Matrix ι ι ℝ → Matrix ι ι ℝ) (he : IsLinOp e) (η : Matrix ι ι ℝ) :
    mixSym e (fun _ => 0) η = 0 := by
  have h := mixSym_smul_right 0 e (fun _ => 0) he η
  simp only [zero_smul, zero_mul] at h
  exact h

theorem mixSym_sum_right {κ : Type*} (e : Matrix ι ι ℝ → Matrix ι ι ℝ) (he : IsLinOp e)
    (s : Finset κ) (f : κ → Matrix ι ι ℝ → Matrix ι ι ℝ) (η : Matrix ι ι ℝ) :
    mixSym e (fun X => ∑ k ∈ s, f k X) η = ∑ k ∈ s, mixSym e (f k) η := by
  classical
  induction s using Finset.induction_on with
  | empty => simpa using mixSym_zero_right e he η
  | insert a s ha ih =>
    have hf : (fun X => ∑ k ∈ insert a s, f k X) = fun X => f a X + ∑ k ∈ s, f k X := by
      funext X; rw [Finset.sum_insert ha]
    rw [hf, mixSym_add_right e (f a) (fun X => ∑ k ∈ s, f k X) he, ih, Finset.sum_insert ha]

/-- `mixQF` sees its operators only on skew inputs. -/
theorem mixQF_congr (A A' B B' : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hA : ∀ X, IsSkew X → A X = A' X) (hB : ∀ X, IsSkew X → B X = B' X)
    (hBs : ∀ X, IsSkew X → IsSkew (B X)) (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    mixQF A B η = mixQF A' B' η := by
  unfold mixQF
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  rw [hA _ (br_isSkew_real _ _ hη (hBs _ (phi_isSkew i j))), hB _ (phi_isSkew i j)]

theorem mixSym_congr (A A' B B' : Matrix ι ι ℝ → Matrix ι ι ℝ)
    (hA : ∀ X, IsSkew X → A X = A' X) (hB : ∀ X, IsSkew X → B X = B' X)
    (hAs : ∀ X, IsSkew X → IsSkew (A X)) (hBs : ∀ X, IsSkew X → IsSkew (B X))
    (η : Matrix ι ι ℝ) (hη : IsSkew η) : mixSym A B η = mixSym A' B' η := by
  unfold mixSym
  rw [mixQF_congr A A' B B' hA hB hBs η hη, mixQF_congr B B' A A' hB hA hAs η hη]

/-- **Row (B) over the classes.** The resolutions are required on bivectors only, which is where
`mixSym` evaluates its operators. -/
theorem rowB_classes {k : ℕ} (W : Matrix ι ι ℝ → Matrix ι ι ℝ) (hW : IsWeylOp W)
    (P : Fin k → Matrix ι ι ℝ → Matrix ι ι ℝ) (hP : ∀ a, IsLinOp (P a))
    (hPs : ∀ a X, IsSkew X → IsSkew (P a X)) (lam : Fin k → ℝ)
    (hId : ∀ X, IsSkew X → X = ∑ a, P a X) (hWP : ∀ X, IsSkew X → W X = ∑ b, lam b • P b X)
    (η : Matrix ι ι ℝ) (hη : IsSkew η) :
    ∑ a, ∑ b, lam b * mixSym (P a) (P b) η = -2 * inner2 (W η) η := by
  have hB := rowB W hW η hη
  rw [mixSym_congr (fun X => X) (fun X => ∑ a, P a X) W W hId (fun _ _ => rfl)
    (fun _ hX => hX) (hW.2.1) η hη, mixSym_comm, mixSym_sum_right W hW.1] at hB
  rw [← hB]
  refine Finset.sum_congr rfl fun a _ => ?_
  rw [mixSym_comm, mixSym_congr (P a) (P a) W (fun X => ∑ b, lam b • P b X) (fun _ _ => rfl) hWP
    (hPs a) hW.2.1 η hη, mixSym_sum_right (P a) (hP a)]
  refine Finset.sum_congr rfl fun b _ => ?_
  rw [mixSym_smul_right _ _ _ (hP a)]

end HamiltonsCubic.L244RowBClasses
