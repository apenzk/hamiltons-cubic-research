import Mathlib
import HamiltonsCubic.Results.CompChar

set_option linter.style.longLine false

/-!
# L27's sector reduction: an `L_e`-eigenvector splits into eigenvectors, one per sign character

[findings/nondegeneracy.md](../../../findings/nondegeneracy.md), Lemma L207: *$L_e$ commutes with the diagonal sign group
$(\mathbb Z_2)^n$, which fixes every coordinate-diagonal $e$, and the isotypic components are exactly the coordinate-diagonal
sector, the $\binom n2$ pair blocks of [Lemma L122] and the $\binom n4$ four-set blocks of [Lemma L121].* That is the route
to [Lemma L27](../../../findings/nondegeneracy.md)'s conclusion, $\lambda_{\max}(L_e|_{W^\perp})=\tfrac12$ on the orbit tangent
alone, that uses the sign group in place of Nienhaus's $O(p)\times O(q)$ decomposition.

At a Weyl `M` of character `1`, the components `comp t H` of [L120Decomp.lean](L120Decomp.lean) (which sum to `H`, and vanish
off `|t| ∈ {0, 2, 4}` by [L120Support.lean](L120Support.lean)'s `comp_zero`) carry an eigen-equation `M ∘ H = c H` each:

* `extendL_sum'`, `proj_sum'`, `eq_zero_of_extendL`: the extension and the isotypic projector are additive over any sum, and
  the extension is injective;
* **`split_unique`**: a vanishing sum `∑_s A_s` with `A_s` of character `χ_s` has every `A_s = 0`;
* `foxProd2_sum_right`: `M ∘` is additive over sums;
* **`comp_eigen`**: `M ∘ H = c H` gives `M ∘ comp t H = c · comp t H` for every `t`.
-/

namespace HamiltonsCubic.L27Sector

open Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L120Decomp HamiltonsCubic.L120HessPair HamiltonsCubic.L222Op
  HamiltonsCubic.BlockSub HamiltonsCubic.L221Ops HamiltonsCubic.L221Crit HamiltonsCubic.L221a HamiltonsCubic.CompChar

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem extendL_sum' {κ : Type*} (s : Finset κ) (f : κ → CurvOp2 ι) :
    extendL (∑ k ∈ s, f k) = ∑ k ∈ s, extendL (f k) := by
  classical
  induction s using Finset.induction_on with
  | empty => rw [Finset.sum_empty, Finset.sum_empty, extendL_zero]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, extendL_add, ih]

theorem proj_sum' {κ : Type*} (t : Finset ι) (s : Finset κ) (f : κ → CurvLin ι) :
    proj t (∑ k ∈ s, f k) = ∑ k ∈ s, proj t (f k) := by
  classical
  induction s using Finset.induction_on with
  | empty => rw [Finset.sum_empty, Finset.sum_empty, proj_zero]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, proj_add, ih]

theorem eq_zero_of_extendL {A : CurvOp2 ι} (h : extendL A = 0) : A = 0 := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [← extend_apply A X]
  show extendL A (X : Matrix ι ι ℝ) = _
  rw [h]
  rfl

/-- **The character split is unique**: a vanishing sum of operators of pairwise distinct characters has every term zero. -/
theorem split_unique {A : Finset ι → CurvOp2 ι} (hA : ∀ s, SignChar (setChar s) (A s)) (hsum : ∑ s, A s = 0)
    (t : Finset ι) : A t = 0 := by
  have h := congrArg (fun R => proj t (extendL R)) hsum
  rw [extendL_sum', proj_sum', ← Finset.add_sum_erase _ _ (Finset.mem_univ t),
    proj_of_char (act_char (hA t)) t, if_pos rfl,
    Finset.sum_eq_zero fun s hs => by rw [proj_of_char (act_char (hA s)) t, if_neg (Ne.symm (Finset.ne_of_mem_erase hs))],
    add_zero, extendL_zero, proj_zero] at h
  exact eq_zero_of_extendL h

theorem foxProd2_sum_right {κ : Type*} (M : CurvOp2 ι) (s : Finset κ) (f : κ → CurvOp2 ι) :
    foxProd2 M (∑ k ∈ s, f k) = ∑ k ∈ s, foxProd2 M (f k) := by
  classical
  induction s using Finset.induction_on with
  | empty => rw [Finset.sum_empty, Finset.sum_empty, foxProd2_zero_right]
  | insert a s ha ih => rw [Finset.sum_insert ha, Finset.sum_insert ha, foxProd2_add_right, ih]

/-- **The eigen-equation passes to every sign-character component**: at `M` of character `1`, `M ∘ H = c H` gives
`M ∘ comp t H = c · comp t H`. -/
theorem comp_eigen {M H : CurvOp2 ι} (hM : SignChar (fun _ => 1) M) (hH : IsWeyl2 H) {c : ℝ}
    (heig : foxProd2 M H = c • H) (t : Finset ι) : foxProd2 M (comp t H hH) = c • comp t H hH := by
  set A : Finset ι → CurvOp2 ι := fun s => foxProd2 M (comp s H hH) + (-c) • comp s H hH with hAdef
  have hA : ∀ s, SignChar (setChar s) (A s) := fun s =>
    signChar_add (signChar_congr (foxProd2_char2 hM (comp_char s H hH)) fun _ _ => one_mul _)
      (signChar_smul (comp_char s H hH) _)
  have hsum : ∑ s, A s = 0 := by
    simp only [hAdef, Finset.sum_add_distrib, ← Finset.smul_sum, ← foxProd2_sum_right, sum_comp H hH, heig]
    module
  have h0 := split_unique hA hsum t
  simp only [hAdef] at h0
  calc foxProd2 M (comp t H hH) = foxProd2 M (comp t H hH) + (-c) • comp t H hH + c • comp t H hH := by module
    _ = c • comp t H hH := by rw [h0]; exact zero_add (c • comp t H hH)

end HamiltonsCubic.L27Sector
