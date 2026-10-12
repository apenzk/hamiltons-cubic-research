import Mathlib
import HamiltonsCubic.Results.I117G2

set_option linter.style.longLine false

/-!
# L263's block relations at `SU(3) ⊂ G₂`, from the bracket

[findings/second-order.md](../../../findings/second-order.md), Lemma L263: *at $SU(3)\subset G_2$ ($\mathfrak p=\mathbb C^3$),
$c=4$, $c_1=3$, $\alpha=\tfrac43$, $x=1$, $y=\tfrac43$*, where $P_{\mathfrak k}\#P_{\mathfrak k}=c_1P_{\mathfrak k}$,
$P_{\mathfrak k}\#P_{\mathfrak p}=\alpha P_{\mathfrak p}$ and $P_{\mathfrak p}\#P_{\mathfrak p}=xP_{\mathfrak k}+yP_{\mathfrak p}$.
The record derives them from Casimir values; [I117LemmaF.lean](I117LemmaF.lean) takes them as data (`IsotropyPair`).
This file proves them in $\mathfrak{so}(7)$'s normalisation from [I117G2.lean](I117G2.lean)'s bracket table:

* `gop lamK` and `gop lamPp` are the orthogonal projections onto $\operatorname{span}\{g_k:k\in\mathfrak{su}(3)\}$ and its
  complement in $\mathfrak g_2$ (`projK_gv`, `projP_gv`), summing to $P_{\mathfrak h}$ (`projK_add_projP`);
* **`L263_blocks`**: $P_{\mathfrak k}\#P_{\mathfrak k}=3P_{\mathfrak k}$, $P_{\mathfrak p}\#P_{\mathfrak p}=P_{\mathfrak k}+\tfrac43P_{\mathfrak p}$
  and $P_{\mathfrak k}\#P_{\mathfrak p}=\tfrac43P_{\mathfrak p}$ (the polarised `sharpB`), the first two by kernel-checked
  integer identities over the structure constants (`coefK`, `coefPP`), the third from $P_{\mathfrak h}\#P_{\mathfrak h}=4P_{\mathfrak h}$.
-/

namespace HamiltonsCubic.I117S

open HamiltonsCubic.RealLayer Matrix Finset

/-- The `𝔰𝔲(3)` weights, over `6`: `3` on the even `gv` up to `12` and `1` on `gv 13`. -/
def gk : Fin 14 → ℤ := ![3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 0, 3, 1]
/-- The `𝔭` weights, over `6`. -/
def gp : Fin 14 → ℤ := ![0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0]

set_option maxRecDepth 100000 in
theorem coefK : ∀ m n : Fin 14, ∑ i, ∑ j, gk i * gk j * gf6 i j m * gf6 i j n = if m = n then 1296 * gk m else 0 := by
  decide

set_option maxRecDepth 100000 in
theorem coefPP : ∀ m n : Fin 14,
    ∑ i, ∑ j, gp i * gp j * gf6 i j m * gf6 i j n = if m = n then 432 * gk m + 576 * gp m else 0 := by
  decide

noncomputable def lamK (k : Fin 14) : ℝ := (gk k : ℝ) / 6
noncomputable def lamPp (k : Fin 14) : ℝ := (gp k : ℝ) / 6

theorem coefK_real (m n : Fin 14) :
    ∑ i, ∑ j, (1 / 2 * lamK i * lamK j) * (((gf6 i j m : ℝ) / 6) * ((gf6 i j n : ℝ) / 6))
      = if m = n then 3 * lamK m else 0 := by
  have h := congrArg (Int.cast : ℤ → ℝ) (coefK m n)
  push_cast at h
  unfold lamK
  calc _ = (1 / 2592) * ∑ i, ∑ j, (gk i : ℝ) * gk j * gf6 i j m * gf6 i j n := by
        rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun j _ => ?_; ring
    _ = _ := by rw [h]; split_ifs <;> ring

theorem coefPP_real (m n : Fin 14) :
    ∑ i, ∑ j, (1 / 2 * lamPp i * lamPp j) * (((gf6 i j m : ℝ) / 6) * ((gf6 i j n : ℝ) / 6))
      = if m = n then lamK m + 4 / 3 * lamPp m else 0 := by
  have h := congrArg (Int.cast : ℤ → ℝ) (coefPP m n)
  push_cast at h
  unfold lamK lamPp
  calc _ = (1 / 2592) * ∑ i, ∑ j, (gp i : ℝ) * gp j * gf6 i j m * gf6 i j n := by
        rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun i _ => ?_
        rw [Finset.mul_sum]; refine Finset.sum_congr rfl fun j _ => ?_; ring
    _ = _ := by rw [h]; split_ifs <;> ring

theorem gop_add (lam mu : Fin 14 → ℝ) : gop lam + gop mu = gop (lam + mu) := by
  unfold gop
  rw [← Finset.sum_add_distrib]
  exact Finset.sum_congr rfl fun i _ => by rw [Pi.add_apply]; exact (add_smul (lam i) (mu i) (rk1 (gv i))).symm

theorem gop_smul (c : ℝ) (lam : Fin 14 → ℝ) : c • gop lam = gop (c • lam) := by
  unfold gop
  rw [Finset.smul_sum]
  exact Finset.sum_congr rfl fun i _ => by rw [smul_smul, Pi.smul_apply, smul_eq_mul]

/-- `P_𝔨 + P_𝔭 = P_𝔥`. -/
theorem projK_add_projP : gop lamK + gop lamPp = gop lamP := by
  rw [gop_add]
  congr 1
  funext k
  fin_cases k <;> simp [lamK, lamPp, lamP, gk, gp, gu] <;> norm_num

/-- `P_𝔨` fixes the `𝔰𝔲(3)` vectors and kills the rest. -/
theorem projK_gv (k : Fin 14) : gop lamK (gv k) = (if k ∈ su3idx then (1 : ℝ) else 0) • gv k := by
  rw [gop_gv]
  congr 1
  fin_cases k <;> simp [lamK, gk, gn, su3idx] <;> try norm_num

/-- `P_𝔭` fixes the `𝔭` vectors and kills the rest. -/
theorem projP_gv (k : Fin 14) : gop lamPp (gv k) = (if k ∈ su3idx then (0 : ℝ) else 1) • gv k := by
  rw [gop_gv]
  congr 1
  fin_cases k <;> simp [lamPp, gp, gn, su3idx] <;> try norm_num

/-- **L263's block relations at `SU(3) ⊂ G₂`**: `c₁ = 3`, `x = 1`, `y = 4/3`, `α = 4/3`, with `c = 4` from
`L263_witness`. -/
theorem L263_blocks :
    sharpMapCL (gop lamK) = (3 : ℝ) • gop lamK ∧
      sharpMapCL (gop lamPp) = gop lamK + (4 / 3 : ℝ) • gop lamPp ∧
      sharpB (gop lamK) (gop lamPp) = (4 / 3 : ℝ) • gop lamPp := by
  have hK : sharpMapCL (gop lamK) = (3 : ℝ) • gop lamK := by
    unfold gop
    rw [sharp_gv lamK (fun i => 3 * lamK i) coefK_real, Finset.smul_sum]
    exact Finset.sum_congr rfl fun i _ => by rw [smul_smul]
  have hP : sharpMapCL (gop lamPp) = gop lamK + (4 / 3 : ℝ) • gop lamPp := by
    rw [gop_smul, gop_add]
    unfold gop
    exact sharp_gv lamPp _ fun m n => by rw [coefPP_real]; simp [Pi.add_apply, Pi.smul_apply]
  have hH : sharpMapCL (gop lamP) = (4 : ℝ) • gop lamP := L263_witness.1
  refine ⟨hK, hP, ?_⟩
  unfold sharpB
  rw [projK_add_projP, hH, hK, hP, ← projK_add_projP]
  module

end HamiltonsCubic.I117S
