import Mathlib
import HamiltonsCubic.Results.L120Support
import HamiltonsCubic.Results.L120PairSign
import HamiltonsCubic.Results.L120Four
import HamiltonsCubic.Results.L120Diag

set_option linter.style.longLine false

/-!
# L120, the blocks on `CurvOp2` are the record's summands

[L120Decomp.lean](L120Decomp.lean) and [L120Support.lean](L120Support.lean) split $W^\perp$ on `CurvOp2` into blocks of
character $\prod_{i\in t}\varepsilon_i$ with $\lvert t\rvert\in\{0,2,4\}$. The record names them: the diagonal locus
$\mathcal D_n$, the pair summands and the four-set summands ([findings/second-order.md](../../../findings/second-order.md),
Lemma L120). Those three are characterised on bivector-level operators by [L120Diag.lean](L120Diag.lean)'s
`diagSummand_iff`, [L120PairSign.lean](L120PairSign.lean)'s `pairSummand_mem_signMat` and
[L120Four.lean](L120Four.lean)'s `fourSummand_mem`. This file carries each across `extendL`:

* `signChar_iff_act`: an operator on $\Lambda^2$ has character $c$ exactly when its extension does under every sign
  matrix;
* `trivial_block_iff`: a Weyl operator on $\Lambda^2$ is sign-fixed exactly when it is `restrict (diagOp w)` for a
  weight $w$, which is $\mathcal D_n$;
* `pair_block_iff` and `four_block_iff`: a Weyl operator on $\Lambda^2$ has the character of $\{j,k\}$, of
  $\{i,j,k,l\}$, exactly when its extension lies in the pair summand, the four-set summand.
-/

namespace HamiltonsCubic.L120Ident

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results
  HamiltonsCubic.L120Hess HamiltonsCubic.L120Blocks HamiltonsCubic.L120Decomp HamiltonsCubic.FamilyLayer HamiltonsCubic.L121Block

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **A character on `Λ²` is the character of the extension.** -/
theorem signChar_iff_act (c : (ι → ℝ) → ℝ) (V : CurvOp2 ι) :
    SignChar c V ↔ ∀ ε : ι → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) (extendL V) = c ε • extendL V := by
  constructor
  · intro h ε hε
    exact act_extendL (h ε hε)
  · intro h ε hε Z _
    have := congrArg (fun L : CurvLin ι => L Z) (h ε hε)
    simp only [act_apply, LinearMap.smul_apply] at this
    exact this

variable {n : ℕ}

/-- **The trivial block is `𝒟ₙ`**: a Weyl operator on `Λ²` is fixed by the sign group exactly when it is the diagonal
operator of a weight. -/
theorem trivial_block_iff (V : CurvOp2 (Fin n)) (hV : IsWeyl2 V) :
    SignChar (fun _ => 1) V ↔ ∃ (w : Matrix (Fin n) (Fin n) ℝ) (hw : IsWeight w), V = RealLayer.restrict (diagOp_isWeyl hw) := by
  constructor
  · intro h
    have hfix : ∀ ε : Fin n → ℝ, (∀ i, ε i * ε i = 1) → act (signMat ε) (extendL V) = extendL V := by
      intro ε hε
      rw [(signChar_iff_act _ V).mp h ε hε, one_smul]
    obtain ⟨w, hw, he⟩ := (diagSummand_iff _ (extendL_mem hV)).mp hfix
    refine ⟨w, hw, ContinuousLinearMap.ext fun X => Subtype.ext ?_⟩
    rw [restrict_diag_eq hw X, ← he]
    exact (extend_apply V X).symm
  · rintro ⟨w, hw, rfl⟩
    exact signChar_diag (diagOp_isWeyl hw)

/-- **A pair block is the pair summand.** -/
theorem pair_block_iff {j k : Fin n} (hjk : j ≠ k) (V : CurvOp2 (Fin n)) (hV : IsWeyl2 V) :
    SignChar (setChar {j, k}) V ↔
      extendL V ∈ (LinearMap.ker (blockSums1 (univ.filter (fun i => j ≠ i ∧ k ≠ i)))).map (pairMap j k) := by
  rw [signChar_iff_act, pairSummand_mem_signMat hjk]
  simp only [setChar_pair hjk]
  exact ⟨fun h => ⟨extendL_mem hV, h⟩, fun h => h.2⟩

/-- **A four-set block is the four-set summand.** -/
theorem four_block_iff {i j k l : Fin n} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (V : CurvOp2 (Fin n)) (hV : IsWeyl2 V) :
    SignChar (setChar {i, j, k, l}) V ↔ extendL V ∈ LinearMap.range (fourMap i j k l) := by
  rw [signChar_iff_act, fourSummand_mem hij hik hil hjk hjl hkl]
  simp only [setChar_four hij hik hil hjk hjl hkl]
  exact ⟨fun h => ⟨extendL_mem hV, h⟩, fun h => h.2⟩

end HamiltonsCubic.L120Ident
