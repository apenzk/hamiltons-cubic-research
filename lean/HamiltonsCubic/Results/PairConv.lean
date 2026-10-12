import Mathlib
import HamiltonsCubic.Results.PairIdent

set_option linter.style.longLine false

/-!
# `V_jk` is exactly `{ν_x : x zero at j, k, Σ x = 0}`

[findings/second-order.md](../../../findings/second-order.md), Lemma L222: *write $\nu\in V_{jk}$ as $\nu=\sum_ax_a\,e_{ja}\odot e_{ka}$
($a\notin\{j,k\}$, $\sum x=0$)*. [PairIdent.lean](PairIdent.lean)'s `pair_eq_nuX` proves that every Weyl operator of character
$\varepsilon_j\varepsilon_k$ is some $\nu_x$; this file proves the converse, so the Weyl operators of that character are exactly the
$\nu_x$.

* `nuX_weyl`: $\nu_x$ is Weyl at $\sum x=0$, as the $45^\circ$ rotation of the Weyl operator $D^-_x$;
* `extendL_nuX`: on all matrices, $\nu_x$ extended is `pairMap j k x`;
* **`nuX_char`**: $\nu_x$ has character $\varepsilon_j\varepsilon_k$ at $x$ zero at $j,k$ with $\sum x=0$;
* **`pair_iff`**: the Weyl operators of character $\varepsilon_j\varepsilon_k$ are exactly these $\nu_x$.
-/

namespace HamiltonsCubic.PairConv

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare HamiltonsCubic.PairIdent HamiltonsCubic.FrameOp2 HamiltonsCubic.L120Blocks

variable {n : ℕ} {j k : Fin n}

/-- `ν_x` is Weyl at `Σ x = 0` off `{j, k}`. -/
theorem nuX_weyl (hjk : j ≠ k) (x : Fin n → ℝ) (hsum : ∑ c, vy j k x c = 0) : IsWeyl2 (nuX j k x) := by
  have hcs : c45 ^ 2 + c45 ^ 2 = 1 := by rw [c45_sq]; norm_num
  rw [← rot45_Dminus hjk x]
  exact rotR_isWeyl2 (Rot_orth hjk hcs) (Dminus_weyl hjk x hsum)

/-- On all matrices, `ν_x` extended is `pairMap j k x`. -/
theorem extendL_nuX (hjk : j ≠ k) (x : Fin n → ℝ) (hxj : x j = 0) (hxk : x k = 0) :
    HamiltonsCubic.Results.pairMap j k x = extendL (nuX j k x) := by
  apply LinearMap.ext
  intro X
  have hsk : HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) X = TensorBridge.skewProj X := by
    show (1 / 2 : ℝ) • (X - Xᵀ) = (2⁻¹ : ℝ) • (X - Xᵀ)
    norm_num
  show pairLin j k x (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) X) = extend (nuX j k x) X
  rw [hsk]
  unfold extend
  rw [nuX, sandOp_coe]
  exact pairLin_eq_nuX hjk x hxj hxk (skewProj_mem X)

/-- **`ν_x` has character `ε_j ε_k`** at `x` zero at `j, k` with `Σ x = 0`. -/
theorem nuX_char (hjk : j ≠ k) (x : Fin n → ℝ) (hxj : x j = 0) (hxk : x k = 0) (hsum : ∑ i, x i = 0) :
    SignChar (setChar {j, k}) (nuX j k x) := by
  have hs' : ∑ c, vy j k x c = 0 := by rw [vy_of_zero x hxj hxk]; exact hsum
  refine (HamiltonsCubic.L120Ident.pair_block_iff hjk _ (nuX_weyl hjk x hs')).mpr
    (Submodule.mem_map.mpr ⟨x, ?_, extendL_nuX hjk x hxj hxk⟩)
  rw [HamiltonsCubic.L121Block.mem_ker_blockSums1]
  refine ⟨fun i hi => ?_, ?_⟩
  · simp only [Finset.mem_filter, Finset.mem_univ, true_and, not_and_or, not_not] at hi
    rcases hi with h | h
    · rw [← h]; exact hxj
    · rw [← h]; exact hxk
  · rw [Finset.sum_filter]
    refine (Finset.sum_congr rfl fun i _ => ?_).trans hsum
    split_ifs with h
    · rfl
    · simp only [not_and_or, not_not] at h
      rcases h with h | h
      · rw [← h, hxj]
      · rw [← h, hxk]

/-- **`V_jk` as a set**: the Weyl operators of character `ε_j ε_k` are exactly the `ν_x` with `x` zero at `j, k`
and `Σ x = 0`. -/
theorem pair_iff (hjk : j ≠ k) (V : CurvOp2 (Fin n)) :
    (IsWeyl2 V ∧ SignChar (setChar {j, k}) V) ↔
      ∃ x : Fin n → ℝ, x j = 0 ∧ x k = 0 ∧ ∑ i, x i = 0 ∧ V = nuX j k x := by
  constructor
  · rintro ⟨hW, hV⟩
    exact pair_eq_nuX hjk hW hV
  · rintro ⟨x, hxj, hxk, hs, rfl⟩
    have hs' : ∑ c, vy j k x c = 0 := by rw [vy_of_zero x hxj hxk]; exact hs
    exact ⟨nuX_weyl hjk x hs', nuX_char hjk x hxj hxk hs⟩

end HamiltonsCubic.PairConv
