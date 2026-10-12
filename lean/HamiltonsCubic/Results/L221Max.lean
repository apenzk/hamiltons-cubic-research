import Mathlib
import HamiltonsCubic.Results.L221bChain
import HamiltonsCubic.Results.L221Crit
import HamiltonsCubic.Results.CompChar

set_option linter.style.longLine false

/-!
# L221 at a local maximiser: both parts with criticality derived rather than assumed

[findings/second-order.md](../../../findings/second-order.md), Lemma L221: *A unit critical point in $\mathcal S$ means $Q(W)=\theta W$
with $W\in\mathcal S\cap\mathcal W_n$ … since $\mathcal S\cap\mathcal W_n$ is closed under $Q$, it is equivalent to criticality of $P$ on that
space's unit sphere, which the Lean derives only at a local maximiser (`L221a_crit`, `L221b_step1`).*
[L221aChain.lean](L221aChain.lean)'s `L221a_bound` and [L221bChain.lean](L221bChain.lean)'s `L221b_bound` take `Q(W) = θW` and the
components' Weyl property as hypotheses (r1870 O3). Here both are derived at a local maximiser of `P` on the unit sphere of the
space:

* **`L221a_at_max`**: at pairwise disjoint four-sets, a local maximiser `W = D + Σ ν_i` of `P` on the unit sphere of
  `(𝒟ₙ ⊕ V_{Q_1} ⊕ ⋯ ⊕ V_{Q_m}) ∩ 𝒲ₙ` with `P(W) > 0` and some `ν_i ≠ 0` has `P(W)² ≤ 3/2`;
* **`L221b_at_max`**: at `Q₁ = {a,b,c,d}`, `Q₂ = {a,b,e,f}`, a local maximiser `W = D + ν₁ + ν₂ + ν₃` of `P` on the unit sphere of
  `𝒮 ∩ 𝒲ₙ` with `P(W) > 0`, two nonzero `ν_i` and `τ ≤ 0` has `P(W)² ≤ 6/5`.
-/

namespace HamiltonsCubic.L221Max

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.CompChar

variable {n : ℕ}

/-- **L221 (a) at a local maximiser.** -/
theorem L221a_at_max {m : ℕ} {Q : Fin m → Finset (Fin n)} (hdis : ∀ a b, a ≠ b → Disjoint (Q a) (Q b))
    (hcard : ∀ a, (Q a).card = 4) {W : CurvOp2 (Fin n)} (hW1 : normSq2 W = 1) (hWS : W ∈ HamiltonsCubic.L221a.SM Q)
    (hmax : IsLocalMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ HamiltonsCubic.L221a.SM Q} W) (hθ : 0 < Pcubic2 W)
    {D : CurvOp2 (Fin n)} {ν : Fin m → CurvOp2 (Fin n)} (hD : SignChar (fun _ => 1) D)
    (hν : ∀ a, SignChar (setChar (Q a)) (ν a)) (hWeq : W = D + ∑ a, ν a) (i0 : Fin m) (hi0 : ν i0 ≠ 0) :
    Pcubic2 W ^ 2 ≤ 3 / 2 := by
  have hne : ∀ a, (Q a).Nonempty := fun a => Finset.card_pos.mp (by rw [hcard a]; norm_num)
  have hinj : ∀ a b, a ≠ b → Q a ≠ Q b := fun a b hab h => by
    obtain ⟨p, hp⟩ := hne a
    exact Finset.disjoint_left.mp (hdis a b hab) hp (h ▸ hp)
  obtain ⟨hDW, hνW⟩ := split_weyl hne hinj hWS.1 hD hν hWeq
  have hcrit := (HamiltonsCubic.L221a.L221a_crit hdis hcard hW1 hWS hmax).1
  rw [hWeq] at hcrit hW1
  have e : Pcubic2 W = Pcubic2 (D + ∑ a, ν a) := by rw [hWeq]
  rw [e] at hθ ⊢
  exact HamiltonsCubic.L221aChain.L221a_bound hdis hcard hDW hD hνW hν hθ hcrit hW1 i0 hi0

section Final
variable {a b c d e f : Fin n} (hab : a ≠ b) (hac : a ≠ c) (had : a ≠ d) (hae : a ≠ e) (haf : a ≠ f)
  (hbc : b ≠ c) (hbd : b ≠ d) (hbe : b ≠ e) (hbf : b ≠ f) (hcd : c ≠ d) (hce : c ≠ e) (hcf : c ≠ f)
  (hde : d ≠ e) (hdf : d ≠ f) (hef : e ≠ f)
include hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef

/-- **L221 (b) at a local maximiser.** -/
theorem L221b_at_max {W : CurvOp2 (Fin n)} (hW1 : normSq2 W = 1)
    (hWS : W ∈ HamiltonsCubic.L221Crit.SK ({a, b, c, d} : Finset (Fin n)) {a, b, e, f})
    (hmax : IsLocalMaxOn Pcubic2 {R | normSq2 R = 1 ∧ R ∈ HamiltonsCubic.L221Crit.SK ({a, b, c, d} : Finset (Fin n)) {a, b, e, f}} W)
    (hθ : 0 < Pcubic2 W) {D ν₁ ν₂ ν₃ : CurvOp2 (Fin n)} (hD : SignChar (fun _ => 1) D)
    (h1 : SignChar (setChar {a, b, c, d}) ν₁) (h2 : SignChar (setChar {a, b, e, f}) ν₂)
    (h3 : SignChar (setChar {c, d, e, f}) ν₃) (hWeq : W = D + ν₁ + ν₂ + ν₃)
    (hτ : innerOp2 (foxProd2 ν₁ ν₂) ν₃ ≤ 0)
    (htwo : (ν₁ ≠ 0 ∧ ν₂ ≠ 0) ∨ (ν₁ ≠ 0 ∧ ν₃ ≠ 0) ∨ (ν₂ ≠ 0 ∧ ν₃ ≠ 0)) : Pcubic2 W ^ 2 ≤ 6 / 5 := by
  have hc1 : c ∈ ({a, b, c, d} : Finset (Fin n)) := by simp
  have hc2 : c ∉ ({a, b, e, f} : Finset (Fin n)) := by simp [Ne.symm hac, Ne.symm hbc, hce, hcf]
  have he2 : e ∈ ({a, b, e, f} : Finset (Fin n)) := by simp
  have he1 : e ∉ ({a, b, c, d} : Finset (Fin n)) := by simp [Ne.symm hae, Ne.symm hbe, Ne.symm hce, Ne.symm hde]
  -- the components are Weyl
  set t : Fin 3 → Finset (Fin n) := ![{a, b, c, d}, {a, b, e, f}, {c, d, e, f}] with htdef
  set A : Fin 3 → CurvOp2 (Fin n) := ![ν₁, ν₂, ν₃] with hAdef
  have hne : ∀ i, (t i).Nonempty := by
    intro i; fin_cases i
    · exact ⟨c, hc1⟩
    · exact ⟨e, he2⟩
    · exact ⟨c, by simp [htdef]⟩
  have n12 : ({a, b, c, d} : Finset (Fin n)) ≠ {a, b, e, f} := fun h => hc2 (h ▸ hc1)
  have n13 : ({a, b, c, d} : Finset (Fin n)) ≠ {c, d, e, f} := fun h => he1 (h ▸ (by simp : e ∈ ({c, d, e, f} : Finset (Fin n))))
  have n23 : ({a, b, e, f} : Finset (Fin n)) ≠ {c, d, e, f} := fun h => hc2 (h ▸ (by simp : c ∈ ({c, d, e, f} : Finset (Fin n))))
  have hinj : ∀ i j, i ≠ j → t i ≠ t j := by
    intro i j hij
    fin_cases i <;> fin_cases j <;> first | exact absurd rfl hij | exact n12 | exact n13 | exact n23 | exact Ne.symm n12 | exact Ne.symm n13 | exact Ne.symm n23
  have hA : ∀ i, SignChar (setChar (t i)) (A i) := by
    intro i; fin_cases i
    · exact h1
    · exact h2
    · exact h3
  have hsum : W = D + ∑ i, A i := by
    rw [hWeq, Fin.sum_univ_three]
    simp only [hAdef, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_two]
    abel
  obtain ⟨hDW, hAW⟩ := split_weyl hne hinj hWS.1 hD hA hsum
  have hcrit := (HamiltonsCubic.L221Crit.L221b_step1 hc1 hc2 he2 he1 hW1 hWS hmax).1
  rw [hWeq] at hcrit hW1
  have eP : Pcubic2 W = Pcubic2 (D + ν₁ + ν₂ + ν₃) := by rw [hWeq]
  rw [eP] at hθ ⊢
  exact HamiltonsCubic.L221bChain.L221b_bound hab hac had hae haf hbc hbd hbe hbf hcd hce hcf hde hdf hef hDW hD
    (hAW 0) h1 (hAW 1) h2 (hAW 2) h3 hθ hcrit hW1 hτ htwo

end Final

end HamiltonsCubic.L221Max
