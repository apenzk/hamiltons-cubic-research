import Mathlib
import HamiltonsCubic.Results.I117Statements
import HamiltonsCubic.Results.CompactSemisimple

set_option linter.style.longLine false

/-!
# L260 (4) on the range of any positive semidefinite idempotent, and (2)'s semisimple clause

[findings/second-order.md](../../../findings/second-order.md), Lemma L260 (4): *"Every positive-definite idempotent
satisfies $\operatorname{tr}(CK)\le d$, $K=\bigoplus_ic_i\Pi_i$"*, $C$ positive definite on the semisimple
$\mathfrak h$ it is supported on and $K$ its Casimir. [I117Statements.lean](I117Statements.lean)'s `L260_trace_bound`
proves it at $\mathfrak h=\mathfrak{so}(n)$, where the Casimir rows are constant. This file:

* `pairing_gen`: the pairing inequality with varying rows and a support, $\sum_k\lambda_k\cdot\tfrac12\sum_{i,j}c_{ijk}
  \le\tfrac12\sum c_{ijk}\lambda_i\lambda_j/\lambda_k$ for cyclic $c\ge0$ vanishing unless all three $\lambda$'s are
  positive;
* `wB`, `Kh`, `L260_four_sub`: in an eigenbasis $b$ of a positive semidefinite `#`-idempotent $C$,
  $\sum_k\lambda_kK_k\le\#\{k:\lambda_k>0\}$ with $K_k=\tfrac12\sum_{i,j:\lambda>0}\langle b_i,[b_k,b_j]\rangle^2$, which
  is $\operatorname{tr}(CK)\le d$ for $\mathfrak h=\operatorname{range}C$, $d=\dim\mathfrak h$ and $K$ its Casimir;
* `Kh_eq_sharp`, `L260_four`: $K_k=\langle(P_{\mathfrak h}\#P_{\mathfrak h})b_k,b_k\rangle$ on the positive
  eigenvectors, and the inequality for every self-adjoint positive semidefinite idempotent, the eigenbasis supplied;
* `L260_two_semisimple`: the range of every self-adjoint positive semidefinite idempotent is semisimple, through
  [CompactSemisimple.lean](CompactSemisimple.lean).

(4)'s equality case at a proper $\mathfrak h$ stays with the record.
-/

namespace HamiltonsCubic.L260Sub

open Finset HamiltonsCubic.I117PsdReduction

/-- **The pairing inequality with varying rows and a support**: for cyclic `c ≥ 0` vanishing unless all three
`λ`'s are positive, `∑_k λ_k · ½ ∑_{i,j} c_{ijk} ≤ ½ ∑ c_{ijk} λ_iλ_j/λ_k`. -/
theorem pairing_gen {d : ℕ} (c : Fin d → Fin d → Fin d → ℝ) (lam : Fin d → ℝ) (D : ℝ)
    (hc : ∀ i j k, 0 ≤ c i j k) (hcyc : ∀ i j k, c i j k = c j k i)
    (hlam : ∀ i j k, c i j k ≠ 0 → 0 < lam i ∧ 0 < lam j ∧ 0 < lam k)
    (hpair : D = (1 / 2) * ∑ i, ∑ j, ∑ k, c i j k * (lam i * lam j / lam k)) :
    ∑ k, lam k * ((1 / 2) * ∑ i, ∑ j, c i j k) ≤ D := by
  set g : Fin d → Fin d → Fin d → ℝ := fun i j k => c i j k * (lam i * lam j / lam k) with hg
  have e2 : ∑ i, ∑ j, ∑ k, c i j k * (lam j * lam k / lam i) = ∑ i, ∑ j, ∑ k, g i j k := by
    rw [← cyc_sum g]
    apply sum_congr rfl; intro i _; apply sum_congr rfl; intro j _; apply sum_congr rfl; intro k _
    simp only [hg]; rw [hcyc i j k]
  have e3 : ∑ i, ∑ j, ∑ k, c i j k * (lam k * lam i / lam j) = ∑ i, ∑ j, ∑ k, g i j k := by
    rw [← e2, ← cyc_sum (fun i j k => c i j k * (lam j * lam k / lam i))]
    apply sum_congr rfl; intro i _; apply sum_congr rfl; intro j _; apply sum_congr rfl; intro k _
    rw [hcyc i j k]
  have m3 : ∑ i, ∑ j, ∑ k, c i j k * lam k = ∑ k, lam k * ∑ i, ∑ j, c i j k := by
    calc ∑ i, ∑ j, ∑ k, c i j k * lam k = ∑ i, ∑ k, ∑ j, c i j k * lam k :=
          Finset.sum_congr rfl fun i _ => Finset.sum_comm
      _ = ∑ k, ∑ i, ∑ j, c i j k * lam k := Finset.sum_comm
      _ = ∑ k, lam k * ∑ i, ∑ j, c i j k := Finset.sum_congr rfl fun k _ => by
          rw [Finset.mul_sum]
          exact Finset.sum_congr rfl fun i _ => by
            rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun j _ => by ring
  have hA : ∑ i, ∑ j, ∑ k, c i j k * lam j = ∑ i, ∑ j, ∑ k, c i j k * lam i := by
    rw [← cyc_sum (fun i j k => c i j k * lam i)]
    apply sum_congr rfl; intro i _; apply sum_congr rfl; intro j _; apply sum_congr rfl; intro k _
    rw [hcyc i j k]
  have hB : ∑ i, ∑ j, ∑ k, c i j k * lam k = ∑ i, ∑ j, ∑ k, c i j k * lam j := by
    rw [← cyc_sum (fun i j k => c i j k * lam j)]
    apply sum_congr rfl; intro i _; apply sum_congr rfl; intro j _; apply sum_congr rfl; intro k _
    rw [hcyc i j k]
  have pt : ∑ i, ∑ j, ∑ k, (c i j k * lam i + c i j k * lam j + c i j k * lam k) ≤
      ∑ i, ∑ j, ∑ k, (g i j k + c i j k * (lam j * lam k / lam i) + c i j k * (lam k * lam i / lam j)) := by
    apply sum_le_sum; intro i _; apply sum_le_sum; intro j _; apply sum_le_sum; intro k _
    by_cases h0 : c i j k = 0
    · simp only [hg, h0, zero_mul]; norm_num
    obtain ⟨hi, hj, hk⟩ := hlam i j k h0
    have h := three_ratio (lam i) (lam j) (lam k) hi hj hk
    have hck := hc i j k
    simp only [hg]
    nlinarith [mul_le_mul_of_nonneg_left h hck]
  simp only [sum_add_distrib] at pt
  rw [← hA, ← hB, e2, e3] at pt
  rw [hpair]
  have : ∑ k, lam k * ((1 / 2) * ∑ i, ∑ j, c i j k) = (1 / 2) * ∑ k, lam k * ∑ i, ∑ j, c i j k := by
    rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun k _ => by ring
  rw [this, ← m3]
  simp only [hg] at pt ⊢
  linarith

section Op

open HamiltonsCubic.RealLayer HamiltonsCubic.I117S

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The squared bracket coefficients `⟨b_i, [b_k, b_j]⟩²` of an orthonormal basis. -/
noncomputable def wB {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (HamiltonsCubic.FrameExtension.SkewSp ι))
    (i j k : Fin N) : ℝ := inner ℝ (b i) (toSk (brS (ofSk (b k)) (ofSk (b j)))) ^ 2

/-- The Casimir diagonal of `𝔥 = span{b_k : λ_k > 0}`: `K_k = ½ ∑_{i,j : λ > 0} ⟨b_i, [b_k, b_j]⟩²`. -/
noncomputable def Kh {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (HamiltonsCubic.FrameExtension.SkewSp ι))
    (lam : Fin N → ℝ) (k : Fin N) : ℝ :=
  (1 / 2) * ∑ i, ∑ j, if 0 < lam i ∧ 0 < lam j ∧ 0 < lam k then wB b i j k else 0

/-- **L260 (4) on the range of any positive semidefinite idempotent.** In an eigenbasis `b` of `C` with eigenvalues
`λ ≥ 0`, `∑_k λ_k K_k ≤ #{k : λ_k > 0}`, which is `tr(C K) ≤ d` for `𝔥 = range C`, `d = dim 𝔥` and `K` its Casimir. -/
theorem L260_four_sub {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (HamiltonsCubic.FrameExtension.SkewSp ι))
    (C : CurvOp2 ι) (hidem : IsIdem C) (lam : Fin N → ℝ)
    (hCb : ∀ β, C (ofSk (b β)) = lam β • ofSk (b β)) (hlam : ∀ β, 0 ≤ lam β) :
    ∑ k, lam k * Kh b lam k ≤ ((Finset.univ.filter fun k => 0 < lam k).card : ℝ) := by
  have hunit : ∀ β, inner2 (HamiltonsCubic.FrameExtension.toM (b β)) (HamiltonsCubic.FrameExtension.toM (b β)) = 1 :=
    fun β => by rw [← HamiltonsCubic.FrameExtension.inner_def, real_inner_self_eq_norm_sq, b.orthonormal.1 β]; norm_num
  have hid : ∀ X Y : skewSub ι, inner2 ((C X : skewSub ι) : Matrix ι ι ℝ) (Y : Matrix ι ι ℝ) = sharpBil2 C X Y := by
    intro X Y
    have : C X = sharpMapCL C X := by rw [hidem]
    rw [this, sharpMapCL_apply, inner2_sharpMap]
  have hcyc0 : ∀ β δ γ, inner ℝ (b δ) (toSk (brS (ofSk (b β)) (ofSk (b γ))))
      = inner ℝ (b γ) (toSk (brS (ofSk (b δ)) (ofSk (b β)))) := by
    intro β δ γ
    show inner2 (HamiltonsCubic.FrameExtension.toM (b δ)) (br (HamiltonsCubic.FrameExtension.toM (b β)) (HamiltonsCubic.FrameExtension.toM (b γ)))
      = inner2 (HamiltonsCubic.FrameExtension.toM (b γ)) (br (HamiltonsCubic.FrameExtension.toM (b δ)) (HamiltonsCubic.FrameExtension.toM (b β)))
    have adj := HamiltonsCubic.L33Statement.ad_skewAdjoint (HamiltonsCubic.FrameExtension.toM_skew (b γ))
      (HamiltonsCubic.FrameExtension.toM_skew (b β)) (HamiltonsCubic.FrameExtension.toM_skew (b δ))
    rw [inner2_comm, adj]
    have e : br (HamiltonsCubic.FrameExtension.toM (b β)) (HamiltonsCubic.FrameExtension.toM (b δ))
        = -br (HamiltonsCubic.FrameExtension.toM (b δ)) (HamiltonsCubic.FrameExtension.toM (b β)) := by simp [br]
    rw [e]; unfold inner2; rw [Matrix.mul_neg, Matrix.trace_neg]; ring
  have hwcyc : ∀ i j k, wB b i j k = wB b j k i := fun i j k => by simp only [wB]; rw [hcyc0 k i j]
  have hdiag : ∀ k, lam k = (1 / 2) * ∑ i, ∑ j, wB b i j k * (lam i * lam j) := by
    intro k
    have h := hid (ofSk (b k)) (ofSk (b k))
    rw [hCb, Submodule.coe_smul, i2_smul_l, ofSk_coe, hunit, mul_one, sharpBil2_eigen b C lam hCb] at h
    rw [h]; congr 1
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by simp only [wB]; ring
  set c : Fin N → Fin N → Fin N → ℝ := fun i j k => if 0 < lam i ∧ 0 < lam j ∧ 0 < lam k then wB b i j k else 0
    with hcdef
  have hc0 : ∀ i j k, 0 ≤ c i j k := fun i j k => by
    simp only [hcdef]; split_ifs
    · exact sq_nonneg _
    · exact le_refl 0
  have hccyc : ∀ i j k, c i j k = c j k i := fun i j k => by
    simp only [hcdef, hwcyc i j k]
    by_cases h : 0 < lam i ∧ 0 < lam j ∧ 0 < lam k
    · rw [if_pos h, if_pos ⟨h.2.1, h.2.2, h.1⟩]
    · rw [if_neg h, if_neg (fun h' => h ⟨h'.2.2, h'.1, h'.2.1⟩)]
  have hsupp : ∀ i j k, c i j k ≠ 0 → 0 < lam i ∧ 0 < lam j ∧ 0 < lam k := fun i j k h => by
    by_contra hn; exact h (by simp only [hcdef, if_neg hn])
  -- the masked diagonal equals the full one
  have hmask : ∀ k, 0 < lam k → ∑ i, ∑ j, c i j k * (lam i * lam j) = ∑ i, ∑ j, wB b i j k * (lam i * lam j) :=
    fun k hk => Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
      simp only [hcdef]
      by_cases hi : 0 < lam i
      · by_cases hj : 0 < lam j
        · rw [if_pos ⟨hi, hj, hk⟩]
        · rw [if_neg (fun h => hj h.2.1), (le_antisymm (not_lt.mp hj) (hlam j))]; ring
      · rw [if_neg (fun h => hi h.1), (le_antisymm (not_lt.mp hi) (hlam i))]; ring
  have hone : ∀ k, (if 0 < lam k then (1 : ℝ) else 0) = (1 / 2) * ∑ i, ∑ j, c i j k * (lam i * lam j / lam k) := by
    intro k
    by_cases hk : 0 < lam k
    · rw [if_pos hk]
      have e : ∑ i, ∑ j, c i j k * (lam i * lam j / lam k) = (∑ i, ∑ j, c i j k * (lam i * lam j)) / lam k := by
        rw [Finset.sum_div]
        exact Finset.sum_congr rfl fun i _ => by rw [Finset.sum_div]; exact Finset.sum_congr rfl fun j _ => by ring
      rw [e, hmask k hk]
      have := hdiag k
      rw [show ∑ i, ∑ j, wB b i j k * (lam i * lam j) = 2 * lam k by linarith, mul_div_assoc, div_self hk.ne']
      norm_num
    · rw [if_neg hk]
      have : ∀ i j, c i j k = 0 := fun i j => by simp only [hcdef]; rw [if_neg (fun h => hk h.2.2)]
      simp [this]
  have hpair : ((Finset.univ.filter fun k => 0 < lam k).card : ℝ)
      = (1 / 2) * ∑ i, ∑ j, ∑ k, c i j k * (lam i * lam j / lam k) := by
    rw [Finset.card_filter, Nat.cast_sum]
    simp only [Nat.cast_ite, Nat.cast_one, Nat.cast_zero, hone, ← Finset.mul_sum]
    congr 1
    rw [Finset.sum_comm, Finset.sum_congr rfl fun i _ => Finset.sum_comm]
  have key := pairing_gen c lam _ hc0 hccyc hsupp hpair
  simpa only [Kh, hcdef] using key

/-- **`K` is `P_𝔥 # P_𝔥`** read on `b_k`: with `P_𝔥` the projection onto the positive eigenvectors (`diagOp` of their
indicator), `K_k = ⟨(P_𝔥 # P_𝔥) b_k, b_k⟩` at every `k` with `λ_k > 0`. -/
theorem Kh_eq_sharp {N : ℕ} (b : OrthonormalBasis (Fin N) ℝ (HamiltonsCubic.FrameExtension.SkewSp ι))
    (lam : Fin N → ℝ) (k : Fin N) (hk : 0 < lam k) :
    Kh b lam k = sharpBil2 (diagOp b fun β => if 0 < lam β then 1 else 0) (ofSk (b k)) (ofSk (b k)) := by
  rw [sharpBil2_eigen b _ _ (diagOp_basis b _), Kh]
  congr 1
  refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => ?_
  simp only [wB]
  by_cases hi : 0 < lam i
  · by_cases hj : 0 < lam j
    · rw [if_pos ⟨hi, hj, hk⟩, if_pos hi, if_pos hj]; ring
    · rw [if_neg (fun h => hj h.2.1), if_neg hj]; ring
  · rw [if_neg (fun h => hi h.1), if_neg hi]; ring

/-- **L260 (4)'s inequality for every positive semidefinite idempotent**, the eigenbasis supplied by the spectral
theorem. -/
theorem L260_four (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hpsd : IsPSD2 C) (hidem : IsIdem C) :
    ∃ (b : OrthonormalBasis (Fin (Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι))) ℝ
        (HamiltonsCubic.FrameExtension.SkewSp ι)) (lam : _ → ℝ),
      (∀ β, C (ofSk (b β)) = lam β • ofSk (b β)) ∧ (∀ β, 0 ≤ lam β) ∧
      ∑ k, lam k * Kh b lam k ≤ ((Finset.univ.filter fun k => 0 < lam k).card : ℝ) := by
  have hs := opSk_symm hC
  let b := hs.eigenvectorBasis (n := Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) rfl
  let lam := hs.eigenvalues (n := Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) rfl
  have hCb : ∀ β, C (ofSk (b β)) = lam β • ofSk (b β) := fun β => by
    have h := hs.apply_eigenvectorBasis (n := Module.finrank ℝ (HamiltonsCubic.FrameExtension.SkewSp ι)) rfl β
    have h2 : C (ofSk (b β)) = ofSk (opSk C (b β)) := rfl
    rw [h2, h, ofSk_smul]; rfl
  have hlam : ∀ β, 0 ≤ lam β := fun β => by
    have h := hpsd (ofSk (b β))
    rw [hCb, Submodule.coe_smul, i2_smul_l, ofSk_coe, ← HamiltonsCubic.FrameExtension.inner_def,
      real_inner_self_eq_norm_sq, b.orthonormal.1 β] at h
    simpa using h
  exact ⟨b, lam, hCb, hlam, L260_four_sub b C hidem lam hCb hlam⟩

end Op

section Two

open HamiltonsCubic.RealLayer HamiltonsCubic.I117S HamiltonsCubic.CompactSemisimple

attribute [local instance] LieRing.ofAssociativeRing LieAlgebra.ofAssociativeAlgebra

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- **L260 (2)'s semisimple clause**: the range of every self-adjoint positive semidefinite `#`-idempotent is a
semisimple Lie algebra, being closed under the bracket and spanned by brackets (`L260_range_subalgebra`). -/
theorem L260_two_semisimple (C : CurvOp2 ι) (hC : IsSelfAdjoint2 C) (hpsd : IsPSD2 C) (hidem : IsIdem C) :
    ∃ hbr : ∀ A ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι), ∀ B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι),
        brS A B ∈ LinearMap.range (C : skewSub ι →ₗ[ℝ] skewSub ι),
      LieAlgebra.IsSemisimple ℝ (lieOf _ hbr) := by
  obtain ⟨hcl, hspan, -⟩ := L260_range_subalgebra C hC hpsd hidem
  exact ⟨fun A hA B hB => hcl A B hA hB, isSemisimple_perfect _ _ hspan.le⟩

end Two

end HamiltonsCubic.L260Sub
