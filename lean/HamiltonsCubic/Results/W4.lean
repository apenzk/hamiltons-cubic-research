import HamiltonsCubic.Base.Spectrum

/-!
# Warning W4, the gradedness screen goes vacuous on a large kernel

> The screen traces only over `E_±`, so a point whose kernel carries most of
> `𝔰𝔬(n)` reports `S = 0` while admitting no grading; **padded `W_{ℂP²}` has
> kernel `63` of `66` at `n = 12`.** Trust it only at `ker W = 0`.

**The figure is `N - 3`, and that is why the warning bites at large `n`.**
Padded `W_{ℂP²}` is supported on one 4-plane's `Λ⁺`, so it has rank `3` at every
`n`, the rank is set by the tensor and the ambient dimension only grows the
kernel. At `n = 12`, `N = 66` and the kernel is `63`; the fraction the screen
misses tends to `1`.

Two exact statements here: the rank at `n = 4`, read off [B7](../Base/Spectrum.lean)'s
complete spectrum, and the arithmetic that turns it into the recorded `63`.

**BOTH COUNTS ARE KERNEL-CHECKED, WHERE BOTH WERE `native_decide`.** *This was the ONE row the index
marks `proved` whose proof rested on the compiler, so its state and its warrant disagreed.* The
recipe is [B7](../Base/Spectrum.lean)'s own `WCP2_signature`: expanding the filter turns a question
about `ℚ` into arithmetic on a `ℕ` cardinality, which `decide` settles. *`decide` walls on `ℚ`
directly, which is what sent the original to the compiler.*
-/

namespace HamiltonsCubic.W4

open HamiltonsCubic.Base

/-- **The rank is `3`**: three of the six eigenvalues are nonzero, so at `n = 4`
the kernel is already half of `Λ²`. -/
theorem rank_three :
    (Finset.univ.filter fun i => (![2, -1, -1, 0, 0, 0] : Fin 6 → ℚ) i ≠ 0).card = 3 := by
  simp [Finset.filter, Fin.sum_univ_six, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  decide

theorem kernel_three_at_four :
    (Finset.univ.filter fun i => (![2, -1, -1, 0, 0, 0] : Fin 6 → ℚ) i = 0).card = 3 := by
  simp [Finset.filter, Fin.sum_univ_six, Matrix.cons_val_zero, Matrix.cons_val_one,
    Matrix.cons_val_two, Matrix.cons_val_three, Matrix.cons_val_four, cons_val_five,
    Matrix.vecHead, Matrix.vecTail]
  decide

/-- `N = n(n-1)/2`, the dimension of `Λ²ℝⁿ`. -/
def N (n : ℕ) : ℕ := n * (n - 1) / 2

theorem N_twelve : N 12 = 66 := by norm_num [N]

theorem N_four : N 4 = 6 := by norm_num [N]

/-- **The recorded `63 of 66` is `N - 3`.** -/
theorem kernel_at_twelve : N 12 - 3 = 63 := by norm_num [N]

/-- And the kernel is a majority from `n = 5` on, which is where the warning
starts to bite: `N n > 6` gives `N n - 3 > N n / 2`. -/
theorem kernel_majority {n : ℕ} (h : 7 ≤ N n) : N n / 2 < N n - 3 := by omega

end HamiltonsCubic.W4
