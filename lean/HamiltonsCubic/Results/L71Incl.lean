import HamiltonsCubic.Results.L70Compose

set_option linter.style.longLine false

/-!
# L71's three inclusions from L70's equality case

[findings/bounds.md](../../../findings/bounds.md), Lemma L71: *L70's equality case says `ad(v)` is supported on
`E_min ⊗ E_max` for every `v ∈ 𝔪 = E_min`, which reads `[𝔪, 𝔪] ⊆ 𝔥`, `[𝔪, 𝔥] ⊆ 𝔪`, `[𝔪, 𝔯] = 0`*, with `𝔥 = E_max` and
`𝔯` the other eigenspaces. **In the spectral-theorem eigenframe of a saturating critical point** (`support_of_saturation`
at every frame vector of `E_min`):

- `L71_mm`: for `v_γ, v_a ∈ 𝔪`, every frame component of `[v_γ, v_a]` lies in `𝔥`;
- `L71_mh`: for `v_γ ∈ 𝔪`, `v_a ∈ 𝔥`, every component lies in `𝔪`;
- `L71_mr`: **for `v_γ ∈ 𝔪` and `v_a ∈ 𝔯`, `[v_γ, v_a] = 0`**.
-/

namespace HamiltonsCubic.EigenFrameExist

open Finset Matrix HamiltonsCubic.RealLayer HamiltonsCubic.SecondKind HamiltonsCubic.L41Statement
  HamiltonsCubic.L41Statement.Frame

variable {n : ℕ}

section sat

variable (W : Matrix (Fin n) (Fin n) ℝ → Matrix (Fin n) (Fin n) ℝ) (hW : IsWeylOp W)
    (θ : ℝ) (hc : IsCritical W θ) (lmin lmax : ℝ) (hneg : lmin < 0) (hpos : 0 < lmax)
    (hlo : ∀ j, lmin ≤ (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j)
    (hhi : ∀ j, (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues j ≤ lmax)
    (hsat : θ = lmin + ((n : ℝ) - 2) * lmax)
include hc hneg hpos hlo hhi hsat

/-- **`[𝔪, 𝔪] ⊆ 𝔥`**, componentwise. -/
theorem L71_mm (γ a b : Pairs n)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin)
    (ha : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmin)
    (hb : cst (frameVec W hW.1 hW.2.1 hW.2.2.1) γ a b ≠ 0) :
    (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues b = lmax := by
  rcases support_of_saturation W hW θ hc γ lmin lmax hγ hneg hpos hlo hhi hsat a b hb with ⟨_, h⟩ | ⟨h, _⟩
  · exact h
  · exact absurd (ha.symm.trans h) (by linarith)

/-- **`[𝔪, 𝔥] ⊆ 𝔪`**, componentwise. -/
theorem L71_mh (γ a b : Pairs n)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin)
    (ha : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a = lmax)
    (hb : cst (frameVec W hW.1 hW.2.1 hW.2.2.1) γ a b ≠ 0) :
    (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues b = lmin := by
  rcases support_of_saturation W hW θ hc γ lmin lmax hγ hneg hpos hlo hhi hsat a b hb with ⟨h, _⟩ | ⟨_, h⟩
  · exact absurd (ha.symm.trans h) (by linarith)
  · exact h

/-- **`[𝔪, 𝔯] = 0`**: for `v_γ ∈ 𝔪` and `v_a` in neither extreme eigenspace, `[v_γ, v_a] = 0`. -/
theorem L71_mr (γ a : Pairs n)
    (hγ : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues γ = lmin)
    (ha1 : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a ≠ lmin)
    (ha2 : (Mpair_isHermitian W hW.1 hW.2.1 hW.2.2.1).eigenvalues a ≠ lmax) :
    br (frameVec W hW.1 hW.2.1 hW.2.2.1 γ) (frameVec W hW.1 hW.2.1 hW.2.2.1 a) = 0 := by
  have hf := eigenFrame_exists W hW.1 hW.2.1 hW.2.2.1
  have hzero : ∀ b, cst (frameVec W hW.1 hW.2.1 hW.2.2.1) γ a b = 0 := fun b => by
    by_contra hb
    rcases support_of_saturation W hW θ hc γ lmin lmax hγ hneg hpos hlo hhi hsat a b hb with ⟨h, _⟩ | ⟨h, _⟩
    · exact ha1 h
    · exact ha2 h
  have hsk : IsSkew (br (frameVec W hW.1 hW.2.1 hW.2.2.1 γ) (frameVec W hW.1 hW.2.1 hW.2.2.1 a)) :=
    br_skew (hf.skew γ) (hf.skew a)
  rw [hf.complete _ hsk]
  exact Finset.sum_eq_zero fun b _ => by
    have : inner2 (br (frameVec W hW.1 hW.2.1 hW.2.2.1 γ) (frameVec W hW.1 hW.2.1 hW.2.2.1 a))
        (frameVec W hW.1 hW.2.1 hW.2.2.1 b) = 0 := hzero b
    rw [this, zero_smul]

end sat

end HamiltonsCubic.EigenFrameExist
