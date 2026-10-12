import Mathlib
import HamiltonsCubic.Results.I117G2
import HamiltonsCubic.Results.OddTorus

set_option linter.style.longLine false

/-!
# L263: the witness is no weighted sum of ideal projections

[findings/second-order.md](../../../findings/second-order.md), Lemma L263: *"$C=\tfrac9{28}P_{\mathfrak{su}(3)}+\tfrac3{28}
P_{\mathfrak p}$ is a positive-definite idempotent on $\mathfrak g_2$ other than $I/4$, so U is false"*, U saying the
positive-definite idempotents on a compact semisimple $\mathfrak h$ are exactly $\bigoplus_i\Pi_i/c_i$ over its simple
ideals. [I117G2.lean](I117G2.lean)'s `L263_witness` and `L263_g2` type the idempotent on the fourteen-dimensional
subalgebra $\mathfrak h=\operatorname{span}(g_k)$ of $\mathfrak{so}(7)$ and show it differs from $P_{\mathfrak h}/4$.
This file shows it differs from every $\sum_i\lambda_i\Pi_i$, so U fails on $\mathfrak h$ whatever $\mathfrak h$'s
simple ideals are:

* `br13`: $[g_1,g_3]=3g_4-2g_5$, a bracket of two vectors of $\mathfrak p$ with an $\mathfrak{su}(3)$ component;
* `eigen_bracket`: for projections $\Pi_i$ onto commuting ideals ($\Pi_j\Pi_i=\delta_{ij}\Pi_i$, each range closed
  under the bracket, $[\Pi_iX,\Pi_jY]=0$ for $i\ne j$) and $C=\sum_i\lambda_i\Pi_i$, each eigenspace of $C$ on the
  covered vectors is an ideal of them ($Y$ ranging over every covered vector);
* `L263_not_ideal_sum`: no such family covering $\mathfrak h$ and no weights give `gop lamC`.

* `inner_br`, `center_zero`: $\mathfrak h$ has trivial centre, each coefficient of a central element being isolated
  by one structure constant (`isoK`, `isoP`, `iso_single`).

U's scope is a compact semisimple $\mathfrak h$. Two steps stay with the record: a subalgebra of the compact
$\mathfrak{so}(7)$ with trivial centre is semisimple; and $\mathfrak h$'s own `#` is $\mathfrak{so}(7)$'s restricted to
operators supported on $\mathfrak h$ (exact by `sharp_rk1_sum`, in the restricted Frobenius normalisation giving $c=4$).
-/

namespace HamiltonsCubic.L263Ideal

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S

local notation "S7" => skewSub (Fin 7)
local notation "M7" => Matrix (Fin 7) (Fin 7) ℝ

theorem br13 : brS (gv 1) (gv 3) = (3 : ℝ) • gv 4 + (-2 : ℝ) • gv 5 := by
  rw [gv_br]
  simp only [Fin.sum_univ_succ, Fin.sum_univ_zero, Fin.isValue]
  simp (config := { decide := true }) only [gf6, Fin.reduceFinMk, Fin.isValue, Matrix.cons_val, Matrix.cons_val_zero,
    Matrix.cons_val_one, Fin.succ_zero_eq_one', Fin.reduceSucc, Fin.succ_zero_eq_one, Fin.succ_one_eq_two]
  norm_num

theorem C_gv (k : Fin 14) : gop lamC (gv k) = (if k ∈ su3idx then (9 / 28 : ℝ) else 3 / 28) • gv k :=
  L263_witness.2.2.1 k

/-- **Each eigenspace of a weighted sum of commuting ideal projections is closed under the bracket.** -/
theorem eigen_bracket {r : ℕ} (Pi : Fin r → CurvOp2 (Fin 7)) (lam : Fin r → ℝ) (C : CurvOp2 (Fin 7))
    (hPP : ∀ i j X, Pi j (Pi i X) = if i = j then Pi i X else 0)
    (hsub : ∀ i X Y, Pi i (brS (Pi i X) (Pi i Y)) = brS (Pi i X) (Pi i Y))
    (hcomm : ∀ i j, i ≠ j → ∀ X Y, brS (Pi i X) (Pi j Y) = 0)
    (hC : ∀ X, C X = ∑ i, lam i • Pi i X) (μ : ℝ) (X Y : S7)
    (hXs : ∑ i, Pi i X = X) (hYs : ∑ i, Pi i Y = Y) (hX : C X = μ • X) :
    C (brS X Y) = μ • brS X Y := by
  have hCP : ∀ i Z, C (Pi i Z) = lam i • Pi i Z := fun i Z => by
    rw [hC]
    simp only [hPP, smul_ite, smul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have hPC : ∀ i, Pi i (C X) = lam i • Pi i X := fun i => by
    rw [hC, map_sum]
    simp only [map_smul, hPP, smul_ite, smul_zero, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have hzero : ∀ i, lam i ≠ μ → Pi i X = 0 := fun i hne => by
    have h := hPC i
    rw [hX, map_smul] at h
    have h2 : (lam i - μ) • Pi i X = 0 := by
      calc (lam i - μ) • Pi i X = lam i • Pi i X - μ • Pi i X := by module
        _ = 0 := by rw [← h, sub_self]
    exact (smul_eq_zero.mp h2).resolve_left (sub_ne_zero.mpr hne)
  have hbr : brS X Y = ∑ i, brS (Pi i X) (Pi i Y) := by
    conv_lhs => rw [← hXs, ← hYs]
    rw [brS_sum_left]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [brS_sum_right]
    rw [Finset.sum_eq_single i (fun j _ hj => hcomm i j (Ne.symm hj) X Y) (by simp)]
  rw [hbr, map_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [← hsub, hCP, hsub]
  by_cases h : lam i = μ
  · rw [h]
  · rw [hzero i h, HamiltonsCubic.OddTorus.brS_zero_left, smul_zero, smul_zero]

/-- **U fails on `𝔥 = span gv` for every decomposition into commuting ideals**: the witness
`C = 9/28 P_𝔰𝔲(3) + 3/28 P_𝔭` is `∑ λ_i Π_i` for no family of projections `Π_i` onto commuting ideals covering `𝔥`
and no weights `λ_i`, in particular not `⊕ Π_i / c_i` over `𝔥`'s simple ideals, whatever they are. -/
theorem L263_not_ideal_sum {r : ℕ} (Pi : Fin r → CurvOp2 (Fin 7)) (lam : Fin r → ℝ)
    (hPP : ∀ i j X, Pi j (Pi i X) = if i = j then Pi i X else 0)
    (hsub : ∀ i X Y, Pi i (brS (Pi i X) (Pi i Y)) = brS (Pi i X) (Pi i Y))
    (hcomm : ∀ i j, i ≠ j → ∀ X Y, brS (Pi i X) (Pi j Y) = 0)
    (hcov : ∀ k, ∑ i, Pi i (gv k) = gv k)
    (hC : ∀ X, gop lamC X = ∑ i, lam i • Pi i X) : False := by
  have h1 : gop lamC (gv 1) = (3 / 28 : ℝ) • gv 1 := by rw [C_gv]; simp [su3idx]
  have h := eigen_bracket Pi lam (gop lamC) hPP hsub hcomm hC (3 / 28) (gv 1) (gv 3) (hcov 1) (hcov 3) h1
  rw [br13, map_add, map_smul, map_smul, C_gv, C_gv] at h
  have h4 := congrArg (fun Z : S7 => inner2 (Z : M7) (gv 4 : M7)) h
  simp only [Submodule.coe_add, Submodule.coe_smul, i2_add_l, i2_smul_l, gv_inner, smul_add, smul_smul] at h4
  simp [su3idx, gn] at h4
  norm_num at h4

theorem inner_br (m k p : Fin 14) :
    inner2 ((brS (gv m) (gv k) : S7) : M7) (gv p : M7) = (gf6 m k p : ℝ) / 6 * gn p := by
  rw [gv_br, Submodule.coe_sum, inner2_sum_l7]
  simp only [Submodule.coe_smul, i2_smul_l, gv_inner, mul_ite, mul_zero, Finset.sum_ite_eq', Finset.mem_univ, if_true]

/-- The coefficient pairs isolating each `z_m`: `[Z, g_k]` read at `g_p` is `z_m gf6(m, k, p) gn_p / 6`. -/
def isoK : Fin 14 → Fin 14 := ![2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 5]
def isoP : Fin 14 → Fin 14 := ![4, 5, 4, 5, 2, 3, 8, 9, 6, 7, 12, 12, 6, 7]

set_option maxHeartbeats 4000000 in
theorem iso_single (m q : Fin 14) : (gf6 q (isoK m) (isoP m) : ℝ) = if q = m then (gf6 m (isoK m) (isoP m) : ℝ) else 0 := by
  fin_cases m <;> fin_cases q <;> simp (config := { decide := true }) [gf6, isoK, isoP]

set_option maxHeartbeats 4000000 in
theorem iso_ne (m : Fin 14) : (gf6 m (isoK m) (isoP m) : ℝ) ≠ 0 := by
  fin_cases m <;> simp (config := { decide := true }) [gf6, isoK, isoP]

/-- **`𝔥 = span gv` has trivial centre**: an element commuting with every `g_k` is zero. With `𝔥` a subalgebra of the
compact `𝔰𝔬(7)`, this is its semisimplicity. -/
theorem center_zero (z : Fin 14 → ℝ) (h : ∀ k, brS (∑ m, z m • gv m) (gv k) = 0) : ∀ m, z m = 0 := by
  intro m
  have e := congrArg (fun Z : S7 => inner2 (Z : M7) (gv (isoP m) : M7)) (h (isoK m))
  simp only [brS_sum_left, brS_smul_left, Submodule.coe_sum, Submodule.coe_smul, inner2_sum_l7, i2_smul_l, inner_br,
    Submodule.coe_zero] at e
  have e' : ∑ q, z q * ((gf6 q (isoK m) (isoP m) : ℝ) / 6 * gn (isoP m)) = z m * ((gf6 m (isoK m) (isoP m) : ℝ) / 6 * gn (isoP m)) := by
    rw [Finset.sum_eq_single m (fun q _ hq => by rw [iso_single m q, if_neg hq]; ring) (by simp)]
  have hz : inner2 (0 : M7) (gv (isoP m) : M7) = 0 := by simp [inner2]
  rw [e', hz] at e
  have hg : gn (isoP m) ≠ 0 := by fin_cases m <;> simp [gn, isoP]
  have := iso_ne m
  rcases mul_eq_zero.mp e with h1 | h1
  · exact h1
  · exfalso
    rcases mul_eq_zero.mp h1 with h2 | h2
    · exact this (by linarith [h2])
    · exact hg h2

end HamiltonsCubic.L263Ideal
