import Mathlib
import HamiltonsCubic.Results.I117Statements

set_option linter.style.longLine false

/-!
# L268: every torus-invariant symmetric operator is a torus operator, and L268 and L271 (3) at the operator

[findings/second-order.md](../../../findings/second-order.md), Lemma L268: *"A $T$-invariant symmetric operator is
$C=A\oplus\bigoplus_\alpha\mu_\alpha I_{R_\alpha}$, and $C$ is a positive-definite idempotent exactly when
$A=2\sum_\alpha\mu_\alpha^2u_\alpha u_\alpha^{\mathsf T}$ and $\mu>0$ solves
$\mu_\alpha=4\mu_\alpha^3+\mu_\alpha\sum_{\beta\sim\alpha}\mu_\beta^2+\sum_{\beta\pm\gamma=\pm\alpha}\mu_\beta\mu_\gamma$"*, and Lemma
L271 (3): *"the only positive solution with $Q=0$ is $I/c$, and every other torus-invariant positive-definite idempotent
has $\mu_{\varepsilon_i+\varepsilon_j}\ne\mu_{\varepsilon_i-\varepsilon_j}$ for some pair"*. `T`-invariance is `derOp (cartS x) C = 0`
for every `x`, and symmetry is self-adjointness for `inner2`. This file:

* `Aof`, `Uof`, `Vof`: an operator's Gram values on the adapted basis, `A_lk = ⟨C J_k, J_l⟩`, `U_ij = ⟨C r_ij0, r_ij0⟩`,
  `V_ij = ⟨C r_ij2, r_ij2⟩`;
* `plane_const`: `T`-invariance makes `C`'s diagonal equal on the two vectors of each root plane, the rotation by
  `ad_{J_i}` exchanging them;
* `L268_rep`: a `T`-invariant self-adjoint `C` is `torusOp (Aof C) (Uof C) (Vof C)`, with `Aof C` symmetric and
  `Uof C`, `Vof C` pair weights (the difference is zero by `torus_op_zero`);
* `L268_full`: such a `C` is a positive-definite `#`-idempotent exactly when `Aof C = Amu`, the weights solve
  `TorusSystem` and are positive;
* `Amu_roots`: `Amu U V = 2 ∑_α μ_α² u_α u_αᵀ`; `display_iff`: `TorusSystem` is the record's per-root display
  `RootDisplay`, the neighbours `β ∼ α` and the pairs `β ± γ = ± α` indexed by `l ∉ {i, j}`;
* `torusOp_scale`, `L271_Q_zero_op`: a positive-definite torus idempotent with `U = V` is `I/(2(m-1))`;
  `L271_other_idem`: every other `T`-invariant self-adjoint positive-definite idempotent has `U_ij ≠ V_ij` for some pair;
* `L271_four_pos`: at such an idempotent, `‖C_P‖² > 0` and `‖C_Q‖² > 0`, the hypotheses of L271 (4)'s `L271_eigen`.
-/

namespace HamiltonsCubic.L268Rep

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.I117S

variable {m : ℕ}

local notation "SK" => skewSub (Fin m × Fin 2)
local notation "MM" => Matrix (Fin m × Fin 2) (Fin m × Fin 2) ℝ

/-- The Cartan block of `C`. -/
noncomputable def Aof (C : CurvOp2 (Fin m × Fin 2)) : Matrix (Fin m) (Fin m) ℝ :=
  fun l k => inner2 ((C (cartS k) : SK) : MM) ((cartS l : SK) : MM)

/-- The weights of `C` on the root planes of `ε_i - ε_j`. -/
noncomputable def Uof (C : CurvOp2 (Fin m × Fin 2)) : Matrix (Fin m) (Fin m) ℝ :=
  fun i j => if i = j then 0 else inner2 ((C (rootS i j 0) : SK) : MM) ((rootS i j 0 : SK) : MM)

/-- The weights of `C` on the root planes of `ε_i + ε_j`. -/
noncomputable def Vof (C : CurvOp2 (Fin m × Fin 2)) : Matrix (Fin m) (Fin m) ℝ :=
  fun i j => if i = j then 0 else inner2 ((C (rootS i j 2) : SK) : MM) ((rootS i j 2 : SK) : MM)

/-- **`T`-invariance makes the diagonal constant on each root plane.** -/
theorem plane_const (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0) (i j : Fin m) (hij : i ≠ j)
    (t : Fin 4) :
    inner2 ((C (rootS i j (flipT t)) : SK) : MM) ((rootS i j (flipT t) : SK) : MM)
      = inner2 ((C (rootS i j t) : SK) : MM) ((rootS i j t : SK) : MM) := by
  have hσ := sigT_self_sq i j hij t
  set σ := sigT i i j t with hσdef
  have hbr := brS_cartS_rootS i i j hij t
  have hflip : rootS i j (flipT t) = σ • brS (cartS i) (rootS i j t) := by
    rw [hbr, smul_smul, ← sq, hσ, one_smul]
  have hc : C (brS (cartS i) (rootS i j t)) = brS (cartS i) (C (rootS i j t)) := by
    have := congrArg (fun T : CurvOp2 (Fin m × Fin 2) => T (rootS i j t)) (hT i)
    simp only [derOp_apply, _root_.zero_apply] at this
    exact (sub_eq_zero.mp this).symm
  have had := ad2_rootS i i j hij t
  rw [hflip, map_smul, hc]
  simp only [Submodule.coe_smul, HamiltonsCubic.FamilyLayer.inner2_smul_left, HamiltonsCubic.FamilyLayer.inner2_smul_right]
  rw [inner2_brS_skew, had, Submodule.coe_smul, HamiltonsCubic.FamilyLayer.inner2_smul_right]
  rw [← hσdef] at had ⊢
  linear_combination (inner2 ((C (rootS i j t) : SK) : MM) ((rootS i j t : SK) : MM)) * (σ ^ 2 + 1) * hσ

theorem inner2_sub_l (X Y Z : MM) : inner2 (X - Y) Z = inner2 X Z - inner2 Y Z := by
  unfold inner2; rw [Matrix.transpose_sub, Matrix.sub_mul, Matrix.trace_sub]; ring

theorem inner2_symm' (X Y : MM) : inner2 X Y = inner2 Y X := by
  unfold inner2; rw [← Matrix.trace_transpose, Matrix.transpose_mul, Matrix.transpose_transpose]

/-- **L268's representation: a `T`-invariant self-adjoint operator is a torus operator.** -/
theorem L268_rep (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : SK, inner2 ((C X : SK) : MM) (Y : MM) = inner2 (X : MM) ((C Y : SK) : MM)) :
    C = torusOp (Aof C) (Uof C) (Vof C) ∧ (Aof C)ᵀ = Aof C ∧ IsPairWeights (Uof C) ∧ IsPairWeights (Vof C) := by
  have hAs : (Aof C)ᵀ = Aof C := by
    ext l k
    simp only [Matrix.transpose_apply, Aof]
    rw [hsa, inner2_symm']
  have hsym : ∀ t : Fin 4, ∀ i j : Fin m, inner2 ((C (rootS j i t) : SK) : MM) ((rootS j i t : SK) : MM)
      = inner2 ((C (rootS i j t) : SK) : MM) ((rootS i j t : SK) : MM) := fun t i j => by
    rw [rootS_swap i j t, map_smul, Submodule.coe_smul, Submodule.coe_smul,
      HamiltonsCubic.FamilyLayer.inner2_smul_left, HamiltonsCubic.FamilyLayer.inner2_smul_right, ← mul_assoc]
    have : epsT t * epsT t = 1 := by fin_cases t <;> simp [epsT]
    rw [this, one_mul]
  have hU : IsPairWeights (Uof C) := by
    refine ⟨?_, fun i => by simp [Uof]⟩
    ext i j
    simp only [Matrix.transpose_apply, Uof]
    by_cases hij : i = j
    · subst hij; rfl
    · rw [if_neg (Ne.symm hij), if_neg hij, hsym]
  have hV : IsPairWeights (Vof C) := by
    refine ⟨?_, fun i => by simp [Vof]⟩
    ext i j
    simp only [Matrix.transpose_apply, Vof]
    by_cases hij : i = j
    · subst hij; rfl
    · rw [if_neg (Ne.symm hij), if_neg hij, hsym]
  refine ⟨?_, hAs, hU, hV⟩
  set T := torusOp (Aof C) (Uof C) (Vof C) with hTdef
  have hTsa := torusOp_isSelfAdjoint2 (Aof C) (Uof C) (Vof C) hAs
  have hTT := derOp_torusOp (Aof C) (Uof C) (Vof C) hU.1 hV.1
  suffices hD : C - T = 0 from sub_eq_zero.mp hD
  refine torus_op_zero (C - T) (fun x => ?_) (fun X Y => ?_) (fun k l => ?_) (fun i j t hij => ?_)
  · refine ContinuousLinearMap.ext fun Y => ?_
    have h1 := congrArg (fun R : CurvOp2 (Fin m × Fin 2) => R Y) (hT x)
    have h2 := congrArg (fun R : CurvOp2 (Fin m × Fin 2) => R Y) (hTT x)
    simp only [derOp_apply, _root_.zero_apply, _root_.sub_apply] at h1 h2 ⊢
    rw [sub_eq_zero] at h1 h2
    rw [brS_sub_right, h1, h2, sub_self]
  · simp only [_root_.sub_apply, Submodule.coe_sub]
    rw [i2_sub_l, i2_sub_r', hsa X Y, hTsa X Y]
  · simp only [_root_.sub_apply, Submodule.coe_sub]
    rw [i2_sub_l, inner2_torus_cart]
    exact sub_self _
  · simp only [_root_.sub_apply, Submodule.coe_sub]
    rw [i2_sub_l, torusOp_rootS _ _ _ hU.1 hV.1 i j hij t, Submodule.coe_smul, i2_smul_l, rootS_norm i j hij t, mul_one,
      sub_eq_zero]
    have p0 := plane_const C hT i j hij 0
    have p2 := plane_const C hT i j hij 2
    fin_cases t
    · simp [rootW, Uof, hij]
    · simp only [flipT] at p0
      simp [rootW, Uof, hij, p0]
    · simp [rootW, Vof, hij]
    · simp only [flipT] at p2
      simp [rootW, Vof, hij, p2]

theorem torusMat_scale (c : ℝ) (A U V : Matrix (Fin m) (Fin m) ℝ) (X : MM) :
    torusMat (c • A) (c • U) (c • V) X = c • torusMat A U V X := by
  ext p r
  simp only [torusMat, Matrix.smul_apply, smul_eq_mul]
  split_ifs
  · rw [show (∑ k, c * A p.1 k * X (k, 1) (k, 0)) = c * ∑ k, A p.1 k * X (k, 1) (k, 0) by
      rw [Finset.mul_sum]; exact Finset.sum_congr rfl fun _ _ => by ring]
    ring
  · ring

/-- **`torusOp` is homogeneous in its three parameters.** -/
theorem torusOp_scale (c : ℝ) (A U V : Matrix (Fin m) (Fin m) ℝ) :
    torusOp (c • A) (c • U) (c • V) = c • torusOp A U V := by
  refine ContinuousLinearMap.ext fun X => Subtype.ext ?_
  rw [_root_.smul_apply, Submodule.coe_smul]
  show skewPartM _ = c • skewPartM _
  rw [torusMat_scale]
  unfold skewPartM
  rw [Matrix.transpose_smul]
  module

/-- **L271 (3) at the operator: a positive-definite torus idempotent with `U = V` is `I/(2(m-1))`.** -/
theorem L271_Q_zero_op (hm : 3 ≤ m) (A U : Matrix (Fin m) (Fin m) ℝ) (hA : Aᵀ = A) (hU : IsPairWeights U)
    (hidem : IsIdem (torusOp A U U)) (hpd : IsPD2 (torusOp A U U)) :
    torusOp A U U = (1 / (2 * ((m : ℝ) - 1))) • (idOp : CurvOp2 (Fin m × Fin 2)) := by
  obtain ⟨hAmu, hsys⟩ := (L268_torus_idem hm A U U hA hU hU).mp hidem
  have hval := L271_Q_zero hm U hU (fun i j hij => (L268_pd_pos A U U hU hU hpd i j hij).1) hsys
  set c : ℝ := 1 / (2 * ((m : ℝ) - 1)) with hc
  have hm1 : (m : ℝ) - 1 ≠ 0 := by
    have : (3 : ℝ) ≤ m := by exact_mod_cast hm
    linarith
  have hUc : U = c • onesOff m := by
    ext i j
    simp only [Matrix.smul_apply, onesOff, smul_eq_mul]
    by_cases hij : i = j
    · subst hij; rw [hU.2, if_pos rfl, mul_zero]
    · rw [if_neg hij, mul_one, hval i j hij]
  have hsum : ∀ i : Fin m, ∑ l, (U i l ^ 2 + U i l ^ 2) = c := fun i => by
    have h1 : ∀ l, U i l ^ 2 + U i l ^ 2 = 2 * c ^ 2 - (if i = l then 2 * c ^ 2 else 0) := fun l => by
      rw [hUc]; simp only [Matrix.smul_apply, onesOff, smul_eq_mul]; split_ifs <;> ring
    simp only [h1, Finset.sum_sub_distrib, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul,
      Finset.sum_ite_eq, Finset.mem_univ, if_true]
    rw [hc]; field_simp
  have hAc : A = c • (1 : Matrix (Fin m) (Fin m) ℝ) := by
    rw [hAmu]
    ext i j
    simp only [Amu, Matrix.smul_apply, Matrix.one_apply, smul_eq_mul]
    by_cases hij : i = j
    · subst hij; rw [if_pos rfl, if_pos rfl, hsum, mul_one]
    · rw [if_neg hij, if_neg hij, sub_self, mul_zero]
  rw [hAc, hUc, torusOp_scale, ← idOp_eq_torusOp]

/-- **L271 (3)'s contrapositive, for every `T`-invariant operator**: a positive-definite self-adjoint `T`-invariant
`#`-idempotent other than `I/(2(m-1))` has `U_ij ≠ V_ij` on some pair. -/
theorem L271_other_idem (hm : 3 ≤ m) (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : SK, inner2 ((C X : SK) : MM) (Y : MM) = inner2 (X : MM) ((C Y : SK) : MM))
    (hidem : IsIdem C) (hpd : IsPD2 C) (hne : C ≠ (1 / (2 * ((m : ℝ) - 1))) • (idOp : CurvOp2 (Fin m × Fin 2))) :
    ∃ i j, i ≠ j ∧ Uof C i j ≠ Vof C i j := by
  obtain ⟨hrep, hA, hU, hV⟩ := L268_rep C hT hsa
  by_contra h
  simp only [not_exists, not_and, not_not] at h
  have hUV : Uof C = Vof C := by
    ext i j
    by_cases hij : i = j
    · subst hij; rw [hU.2, hV.2]
    · exact h i j hij
  rw [hrep, ← hUV] at hidem hpd
  exact hne (hrep.trans (hUV ▸ L271_Q_zero_op hm (Aof C) (Uof C) hA hU hidem hpd))

/-- **L268 at the operator, for every `T`-invariant symmetric operator**: it is a positive-definite `#`-idempotent
exactly when its Cartan block is `A_μ` and its positive root weights solve the system. -/
theorem L268_full (hm : 3 ≤ m) (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : SK, inner2 ((C X : SK) : MM) (Y : MM) = inner2 (X : MM) ((C Y : SK) : MM)) :
    IsIdem C ∧ IsPD2 C ↔
      Aof C = Amu (Uof C) (Vof C) ∧ TorusSystem (Uof C) (Vof C) ∧ ∀ i j, i ≠ j → 0 < Uof C i j ∧ 0 < Vof C i j := by
  obtain ⟨hrep, hA, hU, hV⟩ := L268_rep C hT hsa
  conv_lhs => rw [hrep]
  constructor
  · rintro ⟨hidem, hpd⟩
    obtain ⟨h1, h2⟩ := (L268_torus_idem hm _ _ _ hA hU hV).mp hidem
    exact ⟨h1, h2, L268_pd_pos _ _ _ hU hV hpd⟩
  · rintro ⟨h1, h2, h3⟩
    refine ⟨(L268_torus_idem hm _ _ _ hA hU hV).mpr ⟨h1, h2⟩, ?_⟩
    rw [h1]
    exact L268_torus_pd hm _ _ hU hV h3

/-- The indices other than `i` and `j`. -/
def others (i j : Fin m) : Finset (Fin m) := Finset.univ.filter fun l => l ≠ i ∧ l ≠ j

theorem sum_split3 (i j : Fin m) (hij : i ≠ j) (f : Fin m → ℝ) : ∑ l, f l = f i + f j + ∑ l ∈ others i j, f l := by
  have hs : (Finset.univ.erase i).erase j = others i j := by
    ext l
    simp only [others, Finset.mem_erase, Finset.mem_filter, Finset.mem_univ, and_true, true_and]
    exact and_comm
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i),
    ← Finset.add_sum_erase _ _ (Finset.mem_erase.mpr ⟨Ne.symm hij, Finset.mem_univ j⟩), hs, add_assoc]

/-- **The record's per-root display of L268's system**: for `α = ε_i - ε_j` (weight `U_ij`) and `α = ε_i + ε_j`
(weight `V_ij`), `μ_α = 4μ_α³ + μ_α ∑_{β∼α} μ_β² + ∑_{β±γ=±α} μ_β μ_γ`, the roots `β ∼ α` being `ε_i ± ε_l`, `ε_j ± ε_l`
for `l ∉ {i, j}`, and the pairs `(ε_i ∓ ε_l, ε_l ∓ ε_j)` for `ε_i - ε_j` and `(ε_i ∓ ε_l, ε_l ± ε_j)` for `ε_i + ε_j`. -/
def RootDisplay (U V : Matrix (Fin m) (Fin m) ℝ) : Prop :=
  ∀ i j : Fin m, i ≠ j →
    U i j = 4 * U i j ^ 3 + U i j * ∑ l ∈ others i j, (U i l ^ 2 + V i l ^ 2 + U j l ^ 2 + V j l ^ 2)
      + ∑ l ∈ others i j, (U i l * U l j + V i l * V l j) ∧
    V i j = 4 * V i j ^ 3 + V i j * ∑ l ∈ others i j, (U i l ^ 2 + V i l ^ 2 + U j l ^ 2 + V j l ^ 2)
      + ∑ l ∈ others i j, (U i l * V l j + V i l * U l j)

/-- **The per-root display is `TorusSystem`.** -/
theorem display_iff (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) :
    TorusSystem U V ↔ RootDisplay U V := by
  refine forall_congr' fun i => forall_congr' fun j => forall_congr' fun hij => ?_
  have hUs : U j i = U i j := by rw [← Matrix.transpose_apply U i j, hU.1]
  have hVs : V j i = V i j := by rw [← Matrix.transpose_apply V i j, hV.1]
  have di : dvec U V i = U i j ^ 2 + V i j ^ 2 + ∑ l ∈ others i j, (U i l ^ 2 + V i l ^ 2) := by
    unfold dvec; rw [sum_split3 i j hij, hU.2, hV.2]; ring
  have dj : dvec U V j = U i j ^ 2 + V i j ^ 2 + ∑ l ∈ others i j, (U j l ^ 2 + V j l ^ 2) := by
    unfold dvec; rw [sum_split3 i j hij, hU.2, hV.2, hUs, hVs]; ring
  have s1 : (U * U + V * V) i j = ∑ l ∈ others i j, (U i l * U l j + V i l * V l j) := by
    rw [Matrix.add_apply, Matrix.mul_apply, Matrix.mul_apply, ← Finset.sum_add_distrib, sum_split3 i j hij,
      hU.2 i, hV.2 i, hU.2 j, hV.2 j]; ring
  have s2 : (U * V + V * U) i j = ∑ l ∈ others i j, (U i l * V l j + V i l * U l j) := by
    rw [Matrix.add_apply, Matrix.mul_apply, Matrix.mul_apply, ← Finset.sum_add_distrib, sum_split3 i j hij,
      hU.2 i, hV.2 i, hU.2 j, hV.2 j]; ring
  have hN : ∑ l ∈ others i j, (U i l ^ 2 + V i l ^ 2 + U j l ^ 2 + V j l ^ 2)
      = ∑ l ∈ others i j, (U i l ^ 2 + V i l ^ 2) + ∑ l ∈ others i j, (U j l ^ 2 + V j l ^ 2) := by
    rw [← Finset.sum_add_distrib]; exact Finset.sum_congr rfl fun _ _ => by ring
  rw [di, dj, s1, s2, hN]
  constructor
  · rintro ⟨h1, h2⟩; constructor
    · linear_combination h1
    · linear_combination h2
  · rintro ⟨h1, h2⟩; constructor
    · linear_combination h1
    · linear_combination h2

/-- `e_i` read at `k`. -/
def ek (i k : Fin m) : ℝ := if i = k then 1 else 0

/-- **`A_μ = 2 ∑_α μ_α² u_α u_αᵀ`**, the record's form of the Cartan block, summed over ordered pairs: `u_α = (e_i ∓ e_j)/√2`
for `α = ε_i ∓ ε_j`, and each positive root appears as `(i, j)` and `(j, i)`, whence the `½`. -/
theorem Amu_roots (U V : Matrix (Fin m) (Fin m) ℝ) (hU : IsPairWeights U) (hV : IsPairWeights V) (k l : Fin m) :
    Amu U V k l = (1 / 2) * ∑ i, ∑ j, (U i j ^ 2 * (ek i k - ek j k) * (ek i l - ek j l)
      + V i j ^ 2 * (ek i k + ek j k) * (ek i l + ek j l)) := by
  have hUs : ∀ i j, U j i = U i j := fun i j => by rw [← Matrix.transpose_apply U i j, hU.1]
  have hVs : ∀ i j, V j i = V i j := fun i j => by rw [← Matrix.transpose_apply V i j, hV.1]
  simp only [ek, mul_add, add_mul, mul_sub, sub_mul, Finset.sum_add_distrib, Finset.sum_sub_distrib, mul_ite, ite_mul,
    mul_one, mul_zero, one_mul, zero_mul, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true,
    Finset.sum_ite_irrel, Finset.sum_const_zero]
  unfold Amu
  by_cases hkl : k = l
  · subst hkl
    simp only [if_true, hU.2, hV.2, hUs k, hVs k, Finset.sum_add_distrib]
    ring
  · simp only [hkl, if_false, hUs k l, hVs k l, Ne.symm hkl]
    ring

/-- A torus operator with a nonzero root weight on some pair has positive norm. -/
theorem normSq2_pos_of_pair (A U V : Matrix (Fin m) (Fin m) ℝ) (hU : Uᵀ = U) (hV : Vᵀ = V) (i j : Fin m) (hij : i ≠ j)
    (hne : U i j ≠ 0) : 0 < normSq2 (torusOp A U V) := by
  rw [normSq2_torusOp A U V hU hV]
  have hA : 0 ≤ ∑ k, ∑ t, A k t ^ 2 := Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => sq_nonneg _
  have hterm : ∀ k l, 0 ≤ (if k = l then (0 : ℝ) else U k l ^ 2 + V k l ^ 2) := fun k l => by
    split_ifs
    · exact le_refl 0
    · positivity
  have h1 : (if i = j then (0 : ℝ) else U i j ^ 2 + V i j ^ 2)
      ≤ ∑ l, (if i = l then (0 : ℝ) else U i l ^ 2 + V i l ^ 2) :=
    Finset.single_le_sum (fun l _ => hterm i l) (Finset.mem_univ j)
  have h2 : ∑ l, (if i = l then (0 : ℝ) else U i l ^ 2 + V i l ^ 2)
      ≤ ∑ k, ∑ l, (if k = l then (0 : ℝ) else U k l ^ 2 + V k l ^ 2) :=
    Finset.single_le_sum (f := fun k => ∑ l, (if k = l then (0 : ℝ) else U k l ^ 2 + V k l ^ 2))
      (fun k _ => Finset.sum_nonneg fun l _ => hterm k l) (Finset.mem_univ i)
  rw [if_neg hij] at h1
  have h3 : 0 < U i j ^ 2 + V i j ^ 2 := by positivity
  linarith

/-- **L271 (4)'s hypotheses at `C ≠ I/(2(m-1))`**: a `T`-invariant self-adjoint positive-definite idempotent other than
`I/(2(m-1))` is `torusOp (Amu U V) U V` at pair weights solving the system, with `‖C_P‖² > 0` and `‖C_Q‖² > 0` for
`C_P = (diag d, ½P, ½P)` and `C_Q = (A_μ - diag d, ½Q, -½Q)`, the hypotheses `L271_eigen` takes. -/
theorem L271_four_pos (hm : 3 ≤ m) (C : CurvOp2 (Fin m × Fin 2)) (hT : ∀ x, derOp (cartS x) C = 0)
    (hsa : ∀ X Y : SK, inner2 ((C X : SK) : MM) (Y : MM) = inner2 (X : MM) ((C Y : SK) : MM))
    (hidem : IsIdem C) (hpd : IsPD2 C) (hne : C ≠ (1 / (2 * ((m : ℝ) - 1))) • (idOp : CurvOp2 (Fin m × Fin 2))) :
    C = torusOp (Amu (Uof C) (Vof C)) (Uof C) (Vof C) ∧ IsPairWeights (Uof C) ∧ IsPairWeights (Vof C) ∧
      TorusSystem (Uof C) (Vof C) ∧ 0 < normSq2 (torusOp (Matrix.diagonal (dvec (Uof C) (Vof C))) ((1 / 2 : ℝ) • (Uof C + Vof C))
        ((1 / 2 : ℝ) • (Uof C + Vof C))) ∧
      0 < normSq2 (torusOp (Amu (Uof C) (Vof C) - Matrix.diagonal (dvec (Uof C) (Vof C)))
        ((1 / 2 : ℝ) • (Uof C - Vof C)) (-((1 / 2 : ℝ) • (Uof C - Vof C)))) := by
  obtain ⟨i, j, hij, hUV⟩ := L271_other_idem hm C hT hsa hidem hpd hne
  obtain ⟨hrep, -, hU, hV⟩ := L268_rep C hT hsa
  obtain ⟨hAmu, hsys, hpos⟩ := (L268_full hm C hT hsa).mp ⟨hidem, hpd⟩
  refine ⟨hAmu ▸ hrep, hU, hV, hsys, ?_, ?_⟩
  · refine normSq2_pos_of_pair _ _ _ ?_ ?_ i j hij ?_
    · rw [Matrix.transpose_smul, Matrix.transpose_add, hU.1, hV.1]
    · rw [Matrix.transpose_smul, Matrix.transpose_add, hU.1, hV.1]
    · have := hpos i j hij
      simp only [Matrix.smul_apply, Matrix.add_apply, smul_eq_mul]
      nlinarith [this.1, this.2]
  · refine normSq2_pos_of_pair _ _ _ ?_ ?_ i j hij ?_
    · rw [Matrix.transpose_smul, Matrix.transpose_sub, hU.1, hV.1]
    · rw [Matrix.transpose_neg, Matrix.transpose_smul, Matrix.transpose_sub, hU.1, hV.1]
    · simp only [Matrix.smul_apply, Matrix.sub_apply, smul_eq_mul]
      intro h
      exact hUV (by linarith)

end HamiltonsCubic.L268Rep
