import Mathlib
import HamiltonsCubic.Results.L120Blocks
import HamiltonsCubic.Results.L120HessPair

set_option linter.style.longLine false

/-!
# L120, the decomposition of $W^\perp$ into sign-isotypic blocks, and second order block by block

[findings/second-order.md](../../../findings/second-order.md), Lemma L120: $\mathcal W_n$ splits over the characters of
the sign group $\Gamma$, and at a $\Gamma$-fixed critical point the Hessian is block-diagonal, so second-order optimality
is checkable block by block. [L120Blocks.lean](L120Blocks.lean) removes the cross terms between separated characters.
This file supplies the covering, on `CurvOp2`:

* `proj t`, the isotypic projector $2^{-n}\sum_u\chi_t(u)\,g_u\cdot$ over the sign elements $g_u$ flipping the
  coordinates in $u$, with $\chi_t(u)=(-1)^{\lvert t\cap u\rvert}$; `proj_signMat`, its image has character
  $\varepsilon\mapsto\prod_{i\in t}\varepsilon_i$; `sum_proj`, the projectors sum to the identity, since
  $\sum_t\chi_t(u)=\prod_i(1+\chi_{\{i\}}(u))$ vanishes unless $u=\varnothing$;
* `weylPerp_decomp`: at a $\Gamma$-fixed $a$, every $v\in W^\perp$ is $\sum_tV_t$ with $V_t\in W^\perp$ of character
  $\prod_{i\in t}\varepsilon_i$, the components off $t=\varnothing$ being orthogonal to $a$ by `char_orth` and the
  $t=\varnothing$ component by difference;
* **`hess_blocks`**: at a $\Gamma$-fixed unit critical Weyl $a$ with $P(a)\ne0$, the Hessian form is nonpositive on
  $W^\perp$ exactly when it is nonpositive on every isotypic block, and `hess_sum_blocks` gives the form as the sum of
  the blocks' forms.

The blocks are indexed by all subsets $t$. [L120Support.lean](L120Support.lean) shows that only
$\lvert t\rvert\in\{0,2,4\}$ carries a nonzero block, and [L120Ident.lean](L120Ident.lean) identifies the blocks at
$t=\varnothing$, $\{j,k\}$ and $\{i,j,k,l\}$ with $\mathcal D_n$, the pair summands and the four-set summands, carrying
[L120Diag.lean](L120Diag.lean), [L120PairSign.lean](L120PairSign.lean) and [L120Four.lean](L120Four.lean)'s
characterisations from bivector-level operators to `CurvOp2`.
-/

namespace HamiltonsCubic.L120Decomp

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results
  HamiltonsCubic.L120Hess HamiltonsCubic.L120HessPair HamiltonsCubic.L120Blocks

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- The character of `t` at the sign element flipping `u`, `(-1)^{|t ∩ u|}`. -/
def chi (t u : Finset ι) : ℝ := ∏ i ∈ t, (if i ∈ u then -1 else 1)

theorem diagSet_orth (u : Finset ι) : (diagSet u)ᵀ * diagSet u = 1 := by
  unfold diagSet
  rw [diagonal_transpose, diagonal_mul_diagonal, ← diagonal_one]
  congr 1
  funext i
  split_ifs <;> norm_num

theorem diagSet_empty : diagSet (∅ : Finset ι) = 1 := by
  unfold diagSet
  simp [Matrix.diagonal_one]

/-- **The isotypic projector** of the character of `t`. -/
noncomputable def proj (t : Finset ι) (B : CurvLin ι) : CurvLin ι :=
  ((2 : ℝ) ^ Fintype.card ι)⁻¹ • ∑ u : Finset ι, chi t u • act (diagSet u) B

theorem proj_mem (t : Finset ι) {B : CurvLin ι} (hB : B ∈ weylModuleS ι) : proj t B ∈ weylModuleS ι :=
  Submodule.smul_mem _ _ (Submodule.sum_mem _ fun u _ =>
    Submodule.smul_mem _ _ (act_mem _ (diagSet_orth u) B hB))

theorem flip_diagSet (m : ι) (u : Finset ι) : Results.flip m * diagSet u = diagSet (symmDiff u {m}) := by
  unfold Results.flip diagSet
  rw [diagonal_mul_diagonal]
  congr 1
  funext i
  by_cases hi : i = m
  · subst hi
    by_cases hu : i ∈ u <;> simp [hu, Finset.mem_symmDiff]
  · by_cases hu : i ∈ u <;> simp [hi, hu, Finset.mem_symmDiff]

theorem chi_symmDiff (t u : Finset ι) (m : ι) :
    chi t (symmDiff u {m}) = (if m ∈ t then -1 else 1) * chi t u := by
  unfold chi
  by_cases hm : m ∈ t
  · rw [if_pos hm, ← Finset.mul_prod_erase t _ hm,
      ← Finset.mul_prod_erase t (fun i => if i ∈ u then (-1 : ℝ) else 1) hm]
    have hrest : ∏ x ∈ t.erase m, (if x ∈ symmDiff u {m} then (-1 : ℝ) else 1)
        = ∏ x ∈ t.erase m, (if x ∈ u then (-1 : ℝ) else 1) := by
      refine Finset.prod_congr rfl fun x hx => ?_
      have hxm : x ≠ m := Finset.ne_of_mem_erase hx
      simp [Finset.mem_symmDiff, hxm]
    rw [hrest]
    by_cases hu : m ∈ u <;> simp [Finset.mem_symmDiff, hu]
  · rw [if_neg hm, one_mul]
    refine Finset.prod_congr rfl fun x hx => ?_
    have hxm : x ≠ m := fun h => hm (h ▸ hx)
    simp [Finset.mem_symmDiff, hxm]

/-- **The projector's image transforms under every flip** by the character of `t`. -/
theorem proj_flip (t : Finset ι) (B : CurvLin ι) (m : ι) :
    act (Results.flip m) (proj t B) = (∏ i ∈ t, Results.sgn i m) • proj t B := by
  rw [prod_sgn]
  unfold proj
  rw [act_smul', act_sum, smul_comm]
  congr 1
  simp_rw [act_smul', act_comp, flip_diagSet]
  rw [Finset.smul_sum]
  let e : Finset ι ≃ Finset ι :=
    Function.Involutive.toPerm (fun u => symmDiff u {m}) (fun u => symmDiff_symmDiff_cancel_right {m} u)
  refine Fintype.sum_equiv e _ _ fun u => ?_
  show chi t u • act (diagSet (symmDiff u {m})) B
    = (if m ∈ t then -1 else 1) • (chi t (symmDiff u {m}) • act (diagSet (symmDiff u {m})) B)
  rw [smul_smul, chi_symmDiff, ← mul_assoc]
  congr 1
  split_ifs <;> ring

/-- **The projector's image has character `∏_{i∈t} εᵢ` under every sign matrix.** -/
theorem proj_signMat (t : Finset ι) (B : CurvLin ι) (ε : ι → ℝ) (hε : ∀ i, ε i * ε i = 1) :
    act (signMat ε) (proj t B) = setChar t ε • proj t B := by
  rw [signMat_eq_diag_set ε hε, act_diag_set _ _ (proj_flip t B)]
  congr 1
  rw [Finset.prod_comm]
  unfold setChar
  refine Finset.prod_congr rfl fun i _ => ?_
  simp only [Results.sgn, Finset.prod_ite_eq']
  exact sign_of_set ε hε i

theorem sum_chi (u : Finset ι) :
    ∑ t : Finset ι, chi t u = if u = ∅ then (2 : ℝ) ^ Fintype.card ι else 0 := by
  have h := Finset.prod_one_add (f := fun i => if i ∈ u then (-1 : ℝ) else 1) (Finset.univ : Finset ι)
  rw [Finset.powerset_univ] at h
  unfold chi
  rw [← h]
  split_ifs with hu
  · subst hu
    norm_num [Finset.prod_const, Finset.card_univ]
  · obtain ⟨x, hx⟩ := Finset.nonempty_iff_ne_empty.mpr hu
    exact Finset.prod_eq_zero (Finset.mem_univ x) (by simp [hx])

/-- **The projectors sum to the identity.** -/
theorem sum_proj (B : CurvLin ι) : ∑ t : Finset ι, proj t B = B := by
  unfold proj
  rw [← Finset.smul_sum, Finset.sum_comm]
  simp_rw [← Finset.sum_smul, sum_chi]
  rw [Finset.sum_eq_single ∅]
  · rw [if_pos rfl, smul_smul, inv_mul_cancel₀ (by positivity), one_smul, diagSet_empty, act_one]
  · intro u _ hu
    rw [if_neg hu, zero_smul]
  · intro h
    exact absurd (Finset.mem_univ _) h

/-- The extension of a Weyl operator on `Λ²` lies in `weylModuleS`. -/
theorem extendL_mem {R : CurvOp2 ι} (h : IsWeyl2 R) : extendL R ∈ weylModuleS ι := by
  refine ⟨isWeyl_extend h, fun Z hZ => ?_⟩
  show extend R Z = 0
  unfold extend
  have h0 : (⟨skewProj Z, skewProj_mem Z⟩ : skewSub ι) = 0 := Subtype.ext (by
    show skewProj Z = 0
    unfold skewProj
    rw [hZ, sub_self, smul_zero])
  rw [h0, map_zero]
  rfl

/-- **The `t`-isotypic component** of a Weyl operator on `Λ²`. -/
noncomputable def comp (t : Finset ι) (R : CurvOp2 ι) (h : IsWeyl2 R) : CurvOp2 ι :=
  restrict (show IsWeyl (fun X => proj t (extendL R) X) from (proj_mem t (extendL_mem h)).1)

theorem comp_isWeyl2 (t : Finset ι) (R : CurvOp2 ι) (h : IsWeyl2 R) : IsWeyl2 (comp t R h) :=
  isWeyl2_restrict _

theorem comp_char (t : Finset ι) (R : CurvOp2 ι) (h : IsWeyl2 R) : SignChar (setChar t) (comp t R h) := by
  intro ε hε
  refine hasChar_restrict _ fun Z _ => ?_
  have := congrArg (fun L : CurvLin ι => L Z) (proj_signMat t (extendL R) ε hε)
  simpa only [act_apply, LinearMap.smul_apply] using this

/-- **The components sum to the operator.** -/
theorem sum_comp (R : CurvOp2 ι) (h : IsWeyl2 R) : ∑ t : Finset ι, comp t R h = R := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [ContinuousLinearMap.sum_apply, Submodule.coe_sum]
  show ∑ t : Finset ι, proj t (extendL R) (X : Matrix ι ι ℝ) = _
  rw [← LinearMap.sum_apply, sum_proj]
  exact extend_apply R X

theorem innerOp2_sum' {κ : Type*} (s : Finset κ) (A : CurvOp2 ι) (f : κ → CurvOp2 ι) :
    innerOp2 A (∑ k ∈ s, f k) = ∑ k ∈ s, innerOp2 A (f k) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
      simp only [Finset.sum_empty]
      have h := innerOp2_add_right A 0 0
      have h00 : (0 : CurvOp2 ι) + 0 = 0 := add_zero (0 : CurvOp2 ι)
      rw [h00] at h
      linarith
  | insert k s hk ih => rw [Finset.sum_insert hk, Finset.sum_insert hk, innerOp2_add_right, ih]

theorem comp_perp_ne {a : CurvOp2 ι} (hfix : SignChar (fun _ => 1) a) {t : Finset ι} (ht : t ≠ ∅)
    (R : CurvOp2 ι) (h : IsWeyl2 R) : innerOp2 a (comp t R h) = 0 := by
  obtain ⟨ε, hε, hcc⟩ := setChar_sep (Ne.symm ht)
  have h1 : setChar (∅ : Finset ι) ε = 1 := by simp [setChar]
  rw [h1, one_mul] at hcc
  exact char_orth hfix (comp_char t R h) hε (by show (1 : ℝ) * setChar t ε = -1; rw [one_mul]; exact hcc)

theorem comp_perp {a : CurvOp2 ι} (hfix : SignChar (fun _ => 1) a) (t : Finset ι) {R : CurvOp2 ι}
    (hW : IsWeyl2 R) (h0 : innerOp2 a R = 0) : comp t R hW ∈ weylPerp a := by
  refine ⟨comp_isWeyl2 t R hW, ?_⟩
  by_cases ht : t = ∅
  · subst ht
    have e := congrArg (innerOp2 a) (sum_comp R hW)
    rw [innerOp2_sum', h0, ← Finset.add_sum_erase _ _ (Finset.mem_univ ∅),
      Finset.sum_eq_zero (fun t ht => comp_perp_ne hfix (Finset.ne_of_mem_erase ht) R hW), add_zero] at e
    exact e
  · exact comp_perp_ne hfix ht R hW

/-- **L120's decomposition of `W^⊥`**: at a `Γ`-fixed `a`, every tangent vector is the sum over index sets `t` of
components in `W^⊥` with character `∏_{i∈t} εᵢ`. -/
theorem weylPerp_decomp {a : CurvOp2 ι} (hfix : SignChar (fun _ => 1) a) (v : weylPerpR a) :
    ∃ V : Finset ι → weylPerpR a, (∀ t, SignChar (setChar t) (tanV (V t))) ∧ ∑ t, V t = v := by
  have hv : IsWeyl2 (tanV v) ∧ innerOp2 a (tanV v) = 0 := v.2
  refine ⟨fun t => ⟨comp t (tanV v) hv.1, comp_perp hfix t hv.1 hv.2⟩, fun t => comp_char t (tanV v) hv.1, ?_⟩
  apply Subtype.ext
  rw [Submodule.coe_sum]
  exact sum_comp (tanV v) hv.1

/-- **The Hessian form is the sum of its isotypic blocks' forms.** -/
theorem hess_sum_blocks {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (hfix : SignChar (fun _ => 1) a) (v : weylPerpR a) :
    ∃ V : Finset ι → weylPerpR a, (∀ t, SignChar (setChar t) (tanV (V t))) ∧ ∑ t, V t = v ∧
      hessQ a (tanV v) = ∑ t, hessQ a (tanV (V t)) := by
  obtain ⟨V, hV, hsum⟩ := weylPerp_decomp hfix v
  refine ⟨V, hV, hsum, ?_⟩
  rw [← hsum]
  exact hess_blockwise ha hWa hcrit hθ hfix univ V (fun t => setChar t) (fun t _ => hV t)
    (fun t _ u _ htu => setChar_sep htu)

/-- **L120, second order block by block.** At a `Γ`-fixed unit critical Weyl `a` with `P(a) ≠ 0`, the Hessian form is
nonpositive on `W^⊥` exactly when it is nonpositive on every sign-isotypic block of `W^⊥`. -/
theorem hess_blocks {a : CurvOp2 ι} {lam : ℝ} (ha : normSq2 a = 1) (hWa : IsWeyl2 a)
    (hcrit : Qop2 a = lam • a) (hθ : Pcubic2 a ≠ 0) (hfix : SignChar (fun _ => 1) a) :
    (∀ v : weylPerpR a, hessQ a (tanV v) ≤ 0) ↔
      ∀ t : Finset ι, ∀ v : weylPerpR a, SignChar (setChar t) (tanV v) → hessQ a (tanV v) ≤ 0 := by
  constructor
  · intro h t v _
    exact h v
  · intro h v
    obtain ⟨V, hV, hsum, heq⟩ := hess_sum_blocks ha hWa hcrit hθ hfix v
    rw [heq]
    exact Finset.sum_nonpos fun t _ => h t (V t) (hV t)

omit [Fintype ι] in
/-- The four-set character. -/
theorem setChar_four {i j k l : ι} (hij : i ≠ j) (hik : i ≠ k) (hil : i ≠ l) (hjk : j ≠ k) (hjl : j ≠ l)
    (hkl : k ≠ l) (ε : ι → ℝ) : setChar {i, j, k, l} ε = ε i * ε j * ε k * ε l := by
  unfold setChar
  rw [Finset.prod_insert (by simp [hij, hik, hil]), Finset.prod_insert (by simp [hjk, hjl]),
    Finset.prod_pair hkl]
  ring

end HamiltonsCubic.L120Decomp
