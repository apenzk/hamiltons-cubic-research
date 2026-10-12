import HamiltonsCubic.Results.L140Abs
import HamiltonsCubic.Results.L141Statement

set_option linter.style.longLine false

/-!
# L141 (a): the defect's derivative is a `½`-contraction at every base point

[findings/second-order.md](../../../findings/second-order.md), Lemma L141 (a): for **any** `V ∈ 𝒲ₙ` and `H ∈ 𝒲ₙ`,
`‖D(Alt W₋)_V[H]‖ ≤ ½‖H‖`, the derivative one-sided where `V` has a kernel. *"Part (a) is Lemma L140's recentring
stated once, for every base point."* **This file proves it in that form**: [L140Statement.lean](L140Statement.lean)'s
`g1_sq_le_quarter_general` at the Daleckii–Krein multipliers of an arbitrary spectrum `λ`:

* **`dkMult`**: the multiplier of `f(x) = ½(|x| - x)`, the divided difference `f^{[1]}(λ_i, λ_j)` at distinct values and
  the slope `f'(λ_i) ∈ {-1, 0}` at a repeated nonzero value;
* **`dkMult_mem`**: every entry lies in `[-1, 0]`, from [L141Statement.lean](L141Statement.lean)'s `divDiff_mem_Icc`;
* **`half_contraction`**: with `Alt` an orthogonal projection, `Alt H = 0`, `H` symmetric, `Z = dkMult ⊙ H` off the
  kernel block `{λ = 0}²` and `Z = ½(|D| - D)` on it (`|D|` symmetric with `|D|² = D²` there), `‖Alt Z‖² ≤ ¼‖H‖²`.

The shape of `Z` is the Daleckii–Krein first-order expansion with the kernel block's exact one-sided value. L141 (a)
asserts it inside its own proof at a general base point, the classical Daleckii–Krein formula not covering a degenerate
`V` ([route-a.md](../../../findings/route-a.md)), and this file takes it as `hE`, `hKK`, as L140Statement does.
-/

namespace HamiltonsCubic.L140Statement

open Finset HamiltonsCubic.L141Statement

variable {N : ℕ}

/-- **The Daleckii–Krein multiplier of `f(x) = ½(|x| - x)`** at the spectrum `λ`. -/
noncomputable def dkMult (lam : Fin N → ℝ) (i j : Fin N) : ℝ :=
  if lam i = lam j then (if lam i < 0 then -1 else 0) else divDiff (lam i) (lam j)

theorem dkMult_mem (lam : Fin N → ℝ) (i j : Fin N) : -1 ≤ dkMult lam i j ∧ dkMult lam i j ≤ 0 := by
  unfold dkMult
  split_ifs with h1 h2
  · norm_num
  · norm_num
  · exact divDiff_mem_Icc h1

/-- **L141 (a)**: `‖Alt Z‖² ≤ ¼‖H‖²` at every base point, degenerate spectrum included. -/
theorem half_contraction (Alt : Mat N →ₗ[ℝ] Mat N) (hidem : ∀ X, Alt (Alt X) = Alt X)
    (hsa : ∀ X Y, fip (Alt X) Y = fip X (Alt Y)) (lam : Fin N → ℝ)
    (H Z absD : Mat N) (haltH : Alt H = 0) (hHs : ∀ i j, H i j = H j i)
    (hE : ∀ i j, ¬(lam i = 0 ∧ lam j = 0) → Z i j = dkMult lam i j * H i j)
    (hKK : ∀ i j, lam i = 0 → lam j = 0 → Z i j = (absD i j - H i j) / 2)
    (hAs : ∀ i, lam i = 0 → ∀ j, lam j = 0 → absD i j = absD j i)
    (hsq : ∀ i, lam i = 0 → ∀ j, lam j = 0 →
      ∑ c ∈ univ.filter (fun c => lam c = 0), absD i c * absD c j
        = ∑ c ∈ univ.filter (fun c => lam c = 0), H i c * H c j) :
    fn2 (Alt Z) ≤ (1 / 4 : ℝ) * fn2 H := by
  set K := univ.filter (fun c => lam c = 0) with hK
  have memK : ∀ c, c ∈ K ↔ lam c = 0 := fun c => by simp [hK]
  refine g1_sq_le_quarter_general Alt hidem hsa H Z absD (dkMult lam) K haltH (dkMult_mem lam)
    (fun i j h => hE i j (by rwa [memK, memK] at h)) (fun i j hi hj => hKK i j ((memK i).mp hi) ((memK j).mp hj))
    (frob_eq_of_sq_eq K absD H (fun i hi j hj => hAs i ((memK i).mp hi) j ((memK j).mp hj))
      (fun i _ j _ => hHs i j) (fun i hi j hj => hsq i ((memK i).mp hi) j ((memK j).mp hj)))

end HamiltonsCubic.L140Statement
