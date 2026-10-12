import Mathlib
import HamiltonsCubic.Results.L97
import HamiltonsCubic.Base.Families
import HamiltonsCubic.Base.SharpDiag

set_option linter.style.longLine false

/-!
# L97, the vertex Laplacian is PSD at a diagonal critical point, `K² - λK ⪰ 0`

**The record's statement, quoted verbatim from [diagonal-half.md](../../../findings/diagonal-half.md):**

> #### Lemma L97, the vertex Laplacian is PSD at a diagonal critical point, $K^2-\lambda K\succeq0$
>
> On the diagonal locus the criticality equation is $K^{\circ2}+K^2=\lambda K+D$ with $D=\operatorname{diag}(\operatorname{diag}K^2)$. Pairing with an **arbitrary** $v$ rather than an eigenvector,
>
> $$v^{\mathsf T}Dv-v^{\mathsf T}K^{\circ2}v=\sum_{ab}K_{ab}^2\big(v_a^2-v_av_b\big)=\tfrac12\sum_{ab}K_{ab}^2(v_a-v_b)^2\ \ge0,$$
>
> so $v^{\mathsf T}(K^2-\lambda K)v\ge0$ for every $v$, i.e.
>
> $$\boxed{\ K^2-\lambda K\succeq0\ }\qquad\text{equivalently}\qquad\textbf{$K$ has no eigenvalue in }(0,\lambda].$$
>
> **That quantity has a standard name, and naming it makes the proof one line.** $K^2-\lambda K$ is exactly the **weighted graph Laplacian** $L(w)$ on $n$ vertices with edge weights $w_{ab}=K_{ab}^2$.
>
> **A counting corollary, immediate.** Positive eigenvalues of $K$ are each $\ge\lambda$, and $\sum\kappa^2=\lVert K\rVert_F^2=t\le2$, so their number is $r\ \le\ \frac{2}{\lambda^2}$.
>
> What arbitrary $v$ genuinely buys is non-spectral, $v=\mathbf 1_S$ gives the **cut identity** $\lVert K\mathbf1_S\rVert^2-\lambda\,\mathbf1_S^{\mathsf T}K\mathbf1_S=\sum_{a\in S,\,b\notin S}K_{ab}^2$.

## What this file states

The lemma as a statement about the **matrix** `K² - λ•K`, using Mathlib's `Matrix.PosSemidef`,
rather than about a sum of products, which is the form [L97.lean](L97.lean) carries and the form
the boxed display is written in.

* `laplacian_identity`, `K² - λ•K` **is** the weighted Laplacian `L(w)`, `w_ab = K_ab²`, entrywise.
* `quadratic_form`, `xᵀ(K² - λK)x = ½ Σ_{a,b} K_ab²(x_a - x_b)²`, for an arbitrary `x`.
* `posSemidef`, the boxed statement.
* `no_eigenvalue_in_open_interval` and `endpoint_permitted`, PSD is equivalent to the **open**
  interval `(0, λ)` being empty; the audit's correction of the block's *"equivalently"*, which
  reads the interval as closed. Closing the endpoint is L129's, and consumes `K1 = 0` and `λ > 0`.
* `counting_corollary`, `r ≤ t/λ²` from *"each positive eigenvalue is ≥ λ"* and `Σκ² ≤ t`.
* `cut_identity`, the non-spectral consequence at `x = 1_S`.
* `witness`, a nonzero `K` satisfying every hypothesis, so nothing here is vacuous.

**The hypotheses are exactly three**: symmetry, hollowness, and the off-diagonal criticality row.
Ricci-flatness, maximality and `λ > 0` are absent from every signature, as the audit insists.

**The convention.** The sums below run over **ordered** pairs throughout, so the `½` in
`quadratic_form` is the double-count price the block leaves unstated rather than a choice made
here.

* `diagCriticalRow` and `posSemidef_at_critical`, the same lemma at **a critical point of `P` on
  [Families.lean](../Base/Families.lean)'s diagonal locus** rather than at an assumed row, so
  `IsDiagCritical` now has a carrier. `critical_isWeyl` puts that point in `𝒲ₙ`.
* `frobenius_eq_two_normSq` and `counting_at_unit_norm`, the block's `t` identified as
  `‖K‖_F² = 2‖W‖²`, which is `2` at a unit-norm point, so the counting corollary reads `r ≤ 2/λ²`
  with its `t` discharged rather than quoted.

**`diagCriticalRow` is proved** (2026-09-24): criticality of `diagOp w` gives the row
`w^{∘2} + w² = θw + D`, through `sharpOp_diagOp` in [SharpDiag.lean](../Base/SharpDiag.lean), which
evaluates `Qop` at a diagonal operator on the `φ` basis. The file carries no `sorry`.

## What is NOT typed here

**The spectral half of the counting corollary.** `∑κ² = ‖K‖_F²` needs a spectral decomposition of
`w`, which this layer does not carry, so `counting_at_unit_norm` takes it as a hypothesis and
discharges only the `t ≤ 2` half from the record's normalisation.

**That the endpoint is excluded.** `endpoint_permitted` shows PSD alone permits `κ = λ`; closing
the interval is L129's, and consumes `K1 = 0` and `λ > 0`, neither of which is used here.
-/

namespace HamiltonsCubic.L97Statement

open Finset Matrix HamiltonsCubic.VertexLaplacian

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **The diagonal criticality hypothesis, in full**: `K` symmetric, hollow, and
`K^{∘2} + K² = λK + D` off the diagonal, `D` being diagonal. *The `a = b` row is a tautology,
which is `D`'s whole role, so it is not part of the hypothesis.* -/
def IsDiagCritical (K : Matrix ι ι ℝ) (lam : ℝ) : Prop :=
  (∀ a b, K a b = K b a) ∧ (∀ a, K a a = 0) ∧
    (∀ a b, a ≠ b → K a b ^ 2 + (∑ c, K a c * K c b) = lam * K a b)

/-- The weighted graph Laplacian `L(w)` with `w_ab = K_ab²`. -/
def lap (K : Matrix ι ι ℝ) : Matrix ι ι ℝ :=
  Matrix.of fun a b => if a = b then ∑ c, K a c ^ 2 else -(K a b ^ 2)

/-! ## `K² - λK` is the Laplacian, entrywise -/

/-- **The identity the block calls *"a standard name"***: `K² - λ•K = L(K_ab²)` entrywise, with
nothing dropped. -/
theorem laplacian_identity {K : Matrix ι ι ℝ} {lam : ℝ} (h : IsDiagCritical K lam) :
    K * K - lam • K = lap K := by
  obtain ⟨hs, hh, hc⟩ := h
  ext a b
  by_cases hab : a = b
  · subst hab
    simp only [Matrix.sub_apply, Matrix.mul_apply, Matrix.smul_apply, smul_eq_mul, lap,
      Matrix.of_apply, hh a, mul_zero, sub_zero]
    exact Finset.sum_congr rfl fun c _ => by rw [hs c a]; ring
  · simp only [Matrix.sub_apply, Matrix.mul_apply, Matrix.smul_apply, smul_eq_mul, lap,
      Matrix.of_apply, if_neg hab]
    linarith [hc a b hab]

/-! ## The quadratic form against an arbitrary vector -/

/-- `xᵀ M x` written out. -/
theorem dot_mulVec (M : Matrix ι ι ℝ) (x : ι → ℝ) :
    x ⬝ᵥ (M *ᵥ x) = ∑ a, ∑ b, M a b * (x a * x b) := by
  simp only [dotProduct, Matrix.mulVec, Finset.mul_sum]
  exact Finset.sum_congr rfl fun a _ => Finset.sum_congr rfl fun b _ => by ring

/-- **`xᵀ(K² - λK)x = ½ Σ_{a,b} K_ab²(x_a - x_b)²`**, the block's display, for an arbitrary `x`.
The sums are over ordered pairs, which is what forces the `½`. -/
theorem quadratic_form {K : Matrix ι ι ℝ} {lam : ℝ} (h : IsDiagCritical K lam) (x : ι → ℝ) :
    x ⬝ᵥ ((K * K - lam • K) *ᵥ x) = (1 / 2) * ∑ a, ∑ b, K a b ^ 2 * (x a - x b) ^ 2 := by
  obtain ⟨hs, hh, hc⟩ := h
  have hcrit : ∀ a b, a ≠ b → (∑ c, K a c * K c b) + K a b ^ 2 = lam * K a b := by
    intro a b hab; linarith [hc a b hab]
  have hid := quad_identity (K := fun a b => K a b) (lam := lam) hh hs hcrit x
  rw [dot_mulVec]
  have hentry : ∀ a b, (K * K - lam • K) a b
      = HamiltonsCubic.VertexLaplacian.Q (fun a b => K a b) lam a b := by
    intro a b
    simp [HamiltonsCubic.VertexLaplacian.Q, Matrix.mul_apply]
  simp only [hentry]
  simp only [HamiltonsCubic.VertexLaplacian.wt] at hid
  linarith [hid]

/-! ## The boxed statement -/

/-- **`K² - λK ⪰ 0`**, the lemma, at every diagonal critical point, saddles included. -/
theorem posSemidef {K : Matrix ι ι ℝ} {lam : ℝ} (h : IsDiagCritical K lam) :
    (K * K - lam • K).PosSemidef := by
  have hs := h.1
  refine Matrix.PosSemidef.of_dotProduct_mulVec_nonneg ?_ ?_
  · ext a b
    simp only [Matrix.conjTranspose_apply, Matrix.sub_apply, Matrix.mul_apply, Matrix.smul_apply,
      smul_eq_mul, star_trivial]
    rw [hs b a]
    congr 1
    exact Finset.sum_congr rfl fun c _ => by rw [hs b c, hs c a]; ring
  · intro x
    have hst : star x = x := rfl
    rw [hst, quadratic_form h x]
    have : 0 ≤ ∑ a, ∑ b, K a b ^ 2 * (x a - x b) ^ 2 :=
      Finset.sum_nonneg fun a _ => Finset.sum_nonneg fun b _ =>
        mul_nonneg (sq_nonneg _) (sq_nonneg _)
    linarith

/-! ## PSD gives the OPEN interval, and permits the endpoint -/

/-- **The open interval `(0, λ)` is empty**: no eigenvalue of `K` lies strictly between. -/
theorem no_eigenvalue_in_open_interval {K : Matrix ι ι ℝ} {lam κ : ℝ} (h : IsDiagCritical K lam)
    {x : ι → ℝ} (hx : x ≠ 0) (heig : K *ᵥ x = κ • x) (hpos : 0 < κ) : lam ≤ κ := by
  by_contra hlt
  push_neg at hlt
  have hq : x ⬝ᵥ ((K * K - lam • K) *ᵥ x) = (κ * κ - lam * κ) * (x ⬝ᵥ x) := by
    have h1 : (K * K - lam • K) *ᵥ x = (κ * κ - lam * κ) • x := by
      rw [Matrix.sub_mulVec, ← Matrix.mulVec_mulVec, heig, Matrix.mulVec_smul, heig,
        Matrix.smul_mulVec, heig]
      rw [smul_smul, smul_smul, ← sub_smul]
    rw [h1, dotProduct_smul, smul_eq_mul]
  have hnn := (posSemidef h).dotProduct_mulVec_nonneg x
  have hstar : star x = x := rfl
  rw [hstar, hq] at hnn
  have hxx : 0 < x ⬝ᵥ x := by
    rcases Function.ne_iff.mp hx with ⟨a, ha⟩
    have hane : x a ≠ 0 := by simpa using ha
    refine Finset.sum_pos' (fun i _ => mul_self_nonneg (x i)) ⟨a, Finset.mem_univ a, ?_⟩
    exact mul_self_pos.mpr hane
  have hneg : κ * κ - lam * κ < 0 := by nlinarith
  have := mul_neg_of_neg_of_pos hneg hxx
  linarith

/-- **And PSD permits the endpoint `κ = λ`**: there the form vanishes identically, so PSD alone
cannot exclude it. *This is the audit's correction of the word "equivalently", the closed
interval `(0, λ]` is strictly stronger, and comes from L129.* -/
theorem endpoint_permitted {K : Matrix ι ι ℝ} {lam : ℝ} {x : ι → ℝ}
    (heig : K *ᵥ x = lam • x) : x ⬝ᵥ ((K * K - lam • K) *ᵥ x) = 0 := by
  have h1 : (K * K - lam • K) *ᵥ x = (0 : ℝ) • x := by
    rw [Matrix.sub_mulVec, ← Matrix.mulVec_mulVec, heig, Matrix.mulVec_smul, heig,
      Matrix.smul_mulVec, heig, smul_smul]
    simp
  rw [h1, dotProduct_smul, smul_eq_mul, zero_mul]

/-! ## The counting corollary -/

/-- **`r λ² ≤ t`**, hence `r ≤ t/λ²`, with `t = ‖K‖_F² ≤ 2` on the diagonal locus this is the
block's `r ≤ 2/λ²`. *Stated over an arbitrary index set of positive eigenvalues, each `≥ λ`,
which is what the matrix form of the lemma delivers.* -/
theorem counting_corollary {r : Type*} [Fintype r] (κ : r → ℝ) (lam t : ℝ) (hlam : 0 < lam)
    (hge : ∀ i, lam ≤ κ i) (ht : ∑ i, κ i ^ 2 ≤ t) :
    (Fintype.card r : ℝ) * lam ^ 2 ≤ t := by
  have hb : ∀ i ∈ (Finset.univ : Finset r), lam ^ 2 ≤ κ i ^ 2 := by
    intro i _
    nlinarith [hge i, hlam]
  have := Finset.sum_le_sum hb
  simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul] at this
  linarith

/-! ## The cut identity -/

/-- **`x = 1_S` turns the display into a cut**: `1_Sᵀ(K² - λK)1_S = Σ_{a ∈ S, b ∉ S} K_ab²`.
This is what an arbitrary `v` buys beyond the spectrum, and the block records it uncomputed. -/
theorem cut_identity {K : Matrix ι ι ℝ} {lam : ℝ} (h : IsDiagCritical K lam) (S : Finset ι) :
    (fun a => if a ∈ S then (1 : ℝ) else 0) ⬝ᵥ
        ((K * K - lam • K) *ᵥ fun a => if a ∈ S then (1 : ℝ) else 0)
      = ∑ a ∈ S, ∑ b ∈ Sᶜ, K a b ^ 2 := by
  classical
  set x : ι → ℝ := fun a => if a ∈ S then (1 : ℝ) else 0 with hxdef
  rw [quadratic_form h x]
  have hterm : ∀ a b : ι, K a b ^ 2 * (x a - x b) ^ 2
      = (if a ∈ S ∧ b ∈ Sᶜ then K a b ^ 2 else 0)
        + (if a ∈ Sᶜ ∧ b ∈ S then K a b ^ 2 else 0) := by
    intro a b
    by_cases ha : a ∈ S <;> by_cases hb : b ∈ S <;>
      simp [hxdef, ha, hb, Finset.mem_compl]
  have hsplit : ∑ a, ∑ b, K a b ^ 2 * (x a - x b) ^ 2
      = (∑ a, ∑ b, (if a ∈ S ∧ b ∈ Sᶜ then K a b ^ 2 else 0))
        + ∑ a, ∑ b, (if a ∈ Sᶜ ∧ b ∈ S then K a b ^ 2 else 0) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun b _ => hterm a b
  have hA : ∑ a, ∑ b, (if a ∈ S ∧ b ∈ Sᶜ then K a b ^ 2 else 0)
      = ∑ a ∈ S, ∑ b ∈ Sᶜ, K a b ^ 2 := by
    rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (· ∈ S)]
    have h1 : ∀ a ∈ Finset.univ.filter (· ∈ S),
        ∑ b, (if a ∈ S ∧ b ∈ Sᶜ then K a b ^ 2 else 0) = ∑ b ∈ Sᶜ, K a b ^ 2 := by
      intro a ha
      simp only [Finset.mem_filter] at ha
      simp only [ha.2, true_and]
      rw [Finset.sum_ite_mem]
      simp
    have h2 : ∀ a ∈ Finset.univ.filter (fun a => ¬ a ∈ S),
        ∑ b, (if a ∈ S ∧ b ∈ Sᶜ then K a b ^ 2 else 0) = 0 := by
      intro a ha
      simp only [Finset.mem_filter] at ha
      simp [ha.2]
    rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2, Finset.sum_const_zero, add_zero]
    congr 1
    ext a
    simp
  have hB : ∑ a, ∑ b, (if a ∈ Sᶜ ∧ b ∈ S then K a b ^ 2 else 0)
      = ∑ a ∈ S, ∑ b ∈ Sᶜ, K a b ^ 2 := by
    rw [Finset.sum_comm]
    have : ∀ b : ι, ∀ a : ι, (if a ∈ Sᶜ ∧ b ∈ S then K a b ^ 2 else 0)
        = (if b ∈ S ∧ a ∈ Sᶜ then K b a ^ 2 else 0) := by
      intro b a
      by_cases ha : a ∈ Sᶜ <;> by_cases hb : b ∈ S <;> simp [ha, hb, h.1 a b]
    rw [Finset.sum_congr rfl fun b _ => Finset.sum_congr rfl fun a _ => this b a]
    rw [← hA]
  rw [hsplit, hA, hB]
  ring

/-! ## The hypotheses are satisfiable -/

/-- **A witness, so nothing above is vacuous.** `K = φ` on two vertices with `λ = 1`: hollow,
symmetric, and the off-diagonal row reads `1 + 0 = 1`. -/
theorem witness : IsDiagCritical (Matrix.of fun a b : Fin 2 => if a = b then (0:ℝ) else 1) 1 := by
  refine ⟨?_, ?_, ?_⟩
  · intro a b; fin_cases a <;> fin_cases b <;> norm_num
  · intro a; fin_cases a <;> norm_num
  · intro a b hab
    fin_cases a <;> fin_cases b <;> simp_all [Fin.sum_univ_two]

/-! ## The hypothesis, at an actual critical point of the diagonal locus

*[Families.lean](../Base/Families.lean) builds the locus `𝒟ₙ` (`diagOp`, `IsWeight`) so
"a diagonal critical point" is nameable, and `IsDiagCritical` stops being a hypothesis with no
carrier.*
-/

section Locus

open HamiltonsCubic.RealLayer HamiltonsCubic.FamilyLayer

/-- **THE CRITICALITY ROW, FROM CRITICALITY.** At a weight `w` whose operator `diagOp w` is a
critical point of `P` with multiplier `θ`, the record reads the equation off as
`M^{∘2} + M² = θM + D` with `D = diag(diag M²)`, which is exactly `IsDiagCritical w θ`.

**PROVED from `sharpOp_diagOp`** ([SharpDiag.lean](../Base/SharpDiag.lean)): `Q` acts on `φ_ab` by
`w_ab² + (w w)_ab`, and the `(b,a)` entry of the eigen-equation reads the row off. What was owed was `Qop`
evaluated at a diagonal operator. [Families.lean](../Base/Families.lean) records the same gap one degree up, as the owed
`DiagCubicFormula` for `Pcubic`, now PROVED in [SharpDiag.lean](../Base/SharpDiag.lean); here what is owed is `sharpOp (diagOp w) (φ_{ab})` as an OPERATOR, which no
layer computes. Symmetry and hollowness come from `IsWeight` and are not part of the gap. -/
theorem diagCriticalRow {w : Matrix ι ι ℝ} {θ : ℝ} (hw : IsWeight w)
    (hc : IsCritical (diagOp w) θ) : IsDiagCritical w θ := by
  refine ⟨hw.symm, hw.hollow, fun a b hab => ?_⟩
  have h := hc a b
  have hR : diagOp w (phi a b) = w a b • phi a b := diagOp_phi w hw.symm a b
  have hQ : Qop (diagOp w) (phi a b) = (w a b * w a b + (w * w) a b) • phi a b := by
    show compOp (diagOp w) (phi a b) + sharpOp (diagOp w) (phi a b) = _
    unfold compOp
    rw [hR, diagOp_smul_arg, hR, sharpOp_diagOp w hw.symm hw.hollow, smul_smul, ← add_smul]
  rw [hQ, hR, smul_smul] at h
  have he := congrFun (congrFun h b) a
  simp [phi, Matrix.smul_apply, Matrix.sub_apply, Matrix.single_apply, hab, Ne.symm hab] at he
  simp only [Matrix.mul_apply] at he
  nlinarith [he]

/-- **THE LEMMA, AT A CRITICAL POINT OF `P` ON THE DIAGONAL LOCUS**: `M² - θM ⪰ 0`. *This is
`posSemidef` with its hypothesis discharged from criticality rather than assumed.* -/
theorem posSemidef_at_critical {w : Matrix ι ι ℝ} {θ : ℝ} (hw : IsWeight w)
    (hc : IsCritical (diagOp w) θ) : (w * w - θ • w).PosSemidef :=
  posSemidef (diagCriticalRow hw hc)

/-- **AND THE POINT IS IN `𝒲ₙ`**, so the statement is about the record's object and not about an
arbitrary symmetric matrix. -/
theorem critical_isWeyl {w : Matrix ι ι ℝ} (hw : IsWeight w) : IsWeyl (diagOp w) :=
  diagOp_isWeyl hw

/-! ### The record's `t`, in the layer's normalisation -/

/-- **`t = ‖K‖_F² = 2‖W‖²`.** *The block's `t ≤ 2` is the record's `tr M² = 2` normalisation, which
under `innerOp`'s `½` is `‖diagOp w‖² = 1`; the factor of two is the ordered-pair doubling and not
a second choice.* -/
theorem frobenius_eq_two_normSq {w : Matrix ι ι ℝ} (hw : IsWeight w) :
    ∑ a : ι, ∑ b : ι, (w a b) ^ 2 = 2 * normSq (diagOp w) := by
  rw [diagOp_normSq w hw.symm hw.hollow]
  ring

/-- **`r ≤ 2/λ²` AT UNIT NORM**, the block's counting corollary with its `t` discharged: at a
unit-norm point of the diagonal locus the Frobenius square is exactly `2`, so `r λ² ≤ 2`.
*The Frobenius identity `∑κ² = ‖K‖_F²` enters as the hypothesis `hsum`, since this layer carries
no spectral decomposition of `w`.* -/
theorem counting_at_unit_norm {r : Type*} [Fintype r] {w : Matrix ι ι ℝ} {κ : r → ℝ} {lam : ℝ}
    (hw : IsWeight w) (hunit : normSq (diagOp w) = 1) (hlam : 0 < lam)
    (hge : ∀ i, lam ≤ κ i) (hsum : ∑ i, κ i ^ 2 ≤ ∑ a : ι, ∑ b : ι, (w a b) ^ 2) :
    (Fintype.card r : ℝ) * lam ^ 2 ≤ 2 := by
  refine counting_corollary κ lam 2 hlam hge ?_
  rw [frobenius_eq_two_normSq hw, hunit] at hsum
  linarith

end Locus

end HamiltonsCubic.L97Statement
