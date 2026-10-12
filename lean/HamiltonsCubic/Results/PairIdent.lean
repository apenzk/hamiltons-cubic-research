import Mathlib
import HamiltonsCubic.Results.PairSquare
import HamiltonsCubic.Results.L120Ident

set_option linter.style.longLine false

/-!
# Every element of `V_jk` is some `ν_x`, so `ν ∘ ν = G_x` on all of `V_jk`

[findings/second-order.md](../../../findings/second-order.md), Lemma L222: *every element of $V_{jk}$ is
$\nu_x=\sum_ax_a\,e_{ja}\odot e_{ka}$ with $\sum x=0$*, and item 2's $\nu\circ\nu=G_x$ is stated for every such $\nu$.
[L120Ident.lean](L120Ident.lean)'s `pair_block_iff` writes a Weyl operator of character $\varepsilon_j\varepsilon_k$ as `pairMap j k c`,
$Y\mapsto\sum_ic_i\,(\langle\varphi_{ki},Y\rangle\varphi_{ji}+\langle\varphi_{ji},Y\rangle\varphi_{ki})$ with $c$ zero at $j,k$ and summing to zero.
[PairSquare.lean](PairSquare.lean)'s `nuX j k c` is the same operator:

* `pairLin_eq_nuX`: on skew matrices `pairLin j k c` is `nuX j k c` at `c` zero at `j` and `k`;
* **`pair_eq_nuX`**: every Weyl operator of character $\varepsilon_j\varepsilon_k$ is `nuX j k c` for a `c` zero at $j,k$ with $\sum c=0$;
* **`Q_pair`**: every Weyl operator $\nu$ of character $\varepsilon_j\varepsilon_k$ has $\nu\circ\nu=G_c$, L222 item 2 on all of $V_{jk}$.
-/

namespace HamiltonsCubic.PairIdent

open Matrix Finset HamiltonsCubic.RealLayer HamiltonsCubic.TensorBridge HamiltonsCubic.Results HamiltonsCubic.L120Hess
  HamiltonsCubic.L120Blocks HamiltonsCubic.L121Block HamiltonsCubic.I117S HamiltonsCubic.FrameOp2
  HamiltonsCubic.DiagSquare HamiltonsCubic.PairSquare

variable {n : ℕ} {j k : Fin n}

theorem vy_of_zero (c : Fin n → ℝ) (hcj : c j = 0) (hck : c k = 0) : vy j k c = c := by
  funext i; unfold vy; split_ifs with h
  · rcases h with h | h <;> subst h <;> simp_all
  · rfl

/-- **On a skew matrix, `pairLin j k c` is `nuX j k c`**, at `c` zero at `j` and `k`. -/
theorem pairLin_eq_nuX (hjk : j ≠ k) (c : Fin n → ℝ) (hcj : c j = 0) (hck : c k = 0) {X : Matrix (Fin n) (Fin n) ℝ}
    (hX : Xᵀ = -X) :
    pairLin j k c X = Smat j k * X * diagonal (vy j k c) + diagonal (vy j k c) * X * Smat j k := by
  have hskew : ∀ a b, X a b = -X b a := fun a b => by
    have := congrFun (congrFun hX b) a; simp only [Matrix.transpose_apply, Matrix.neg_apply] at this; linarith
  rw [vy_of_zero c hcj hck, pairLin_apply]
  have hfilter : ∑ i ∈ univ.filter (fun i => j ≠ i ∧ k ≠ i), c i • rk2 (phi j i) (phi k i) X
      = ∑ i, c i • rk2 (phi j i) (phi k i) X := by
    rw [Finset.sum_filter]
    refine Finset.sum_congr rfl fun i _ => ?_
    split_ifs with h
    · rfl
    · push Not at h
      by_cases hij : j = i
      · subst hij; rw [hcj, zero_smul]
      · obtain rfl := h hij
        rw [hck, zero_smul]
  rw [hfilter]
  ext p q
  simp only [Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul, rk2, Matrix.add_apply, Matrix.mul_diagonal,
    Matrix.diagonal_mul]
  have hin : ∀ a b : Fin n, inner2 (phi a b) X = -X a b := fun a b => by
    rw [inner2_comm]; exact inner2_phi X hX a b
  simp only [hin]
  rw [Matrix.mul_apply, Smat_row hjk, Matrix.mul_apply, Smat_col hjk]
  simp only [phi, Matrix.sub_apply, Matrix.single_apply, mul_sub, mul_ite, mul_one, mul_zero, ite_and,
    Finset.sum_add_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true]
  have hkj := Ne.symm hjk
  by_cases hpj : p = j
  · subst hpj
    have s1 : X p k = -X k p := hskew p k
    have hpp : X p p = 0 := by have := hskew p p; linarith
    by_cases hqj : q = p
    · subst hqj; simp [hjk, hkj, hcj, hck, s1, hpp, mul_add, mul_neg, neg_neg, mul_ite, mul_zero, mul_one, neg_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true] <;> ring
    · by_cases hqk : q = k
      · subst hqk; simp [hjk, hkj, hcj, hck, s1, hpp, hqj, Ne.symm hqj, mul_add, mul_neg, neg_neg, mul_ite, mul_zero, mul_one, neg_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true] <;> ring
      · have s3 : X q p = -X p q := hskew q p
        simp [hjk, hkj, hcj, hck, s1, hpp, hqj, hqk, Ne.symm hqj, Ne.symm hqk, mul_add, mul_neg, neg_neg, mul_ite, mul_zero, mul_one, neg_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true] <;> ring
  · by_cases hpk : p = k
    · subst hpk
      have s2 : X p j = -X j p := hskew p j
      have hpp : X p p = 0 := by have := hskew p p; linarith
      by_cases hqj : q = j
      · subst hqj; simp [hjk, hkj, hcj, hck, s2, hpp, hpj, Ne.symm hpj, mul_add, mul_neg, neg_neg, mul_ite, mul_zero, mul_one, neg_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true] <;> ring
      · by_cases hqk : q = p
        · subst hqk; simp [hjk, hkj, hcj, hck, s2, hpp, hpj, Ne.symm hpj, hqj, Ne.symm hqj, mul_add, mul_neg, neg_neg, mul_ite, mul_zero, mul_one, neg_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true] <;> ring
        · simp [hjk, hkj, hcj, hck, s2, hpp, hpj, Ne.symm hpj, hqj, hqk, Ne.symm hqj, Ne.symm hqk, mul_add, mul_neg, neg_neg, mul_ite, mul_zero, mul_one, neg_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true] <;> ring
    · have s1 : X p k = -X k p := hskew p k
      have s2 : X p j = -X j p := hskew p j
      by_cases hqj : q = j
      · subst hqj; simp [hjk, hkj, hcj, hck, s1, s2, hpj, hpk, Ne.symm hpj, Ne.symm hpk, mul_add, mul_neg, neg_neg, mul_ite, mul_zero, mul_one, neg_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true] <;> ring
      · by_cases hqk : q = k
        · subst hqk
          simp [hjk, hkj, hcj, hck, s1, s2, hpj, hpk, hqj, Ne.symm hpj, Ne.symm hpk, Ne.symm hqj, mul_add, mul_neg, neg_neg, mul_ite, mul_zero, mul_one, neg_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true] <;> ring
        · simp [hjk, hkj, hcj, hck, s1, s2, hpj, hpk, hqj, hqk, Ne.symm hpj, Ne.symm hpk, Ne.symm hqj, Ne.symm hqk, mul_add, mul_neg, neg_neg, mul_ite, mul_zero, mul_one, neg_zero, Finset.sum_add_distrib, Finset.sum_neg_distrib, Finset.sum_sub_distrib, Finset.sum_ite_eq, Finset.sum_ite_eq', Finset.mem_univ, if_true] <;> ring

/-- **Every Weyl operator of character `ε_j ε_k` is some `ν_c`**, `c` zero at `j, k` with `Σ c = 0`. -/
theorem pair_eq_nuX (hjk : j ≠ k) {V : CurvOp2 (Fin n)} (hVW : IsWeyl2 V) (hV : SignChar (setChar {j, k}) V) :
    ∃ c : Fin n → ℝ, c j = 0 ∧ c k = 0 ∧ ∑ i, c i = 0 ∧ V = nuX j k c := by
  obtain ⟨c, hc, he⟩ := Submodule.mem_map.mp ((HamiltonsCubic.L120Ident.pair_block_iff hjk V hVW).mp hV)
  rw [mem_ker_blockSums1] at hc
  have hcj : c j = 0 := hc.1 j (by simp)
  have hck : c k = 0 := hc.1 k (by simp)
  have hsum : ∑ i, c i = 0 := by
    rw [← Finset.sum_filter_add_sum_filter_not Finset.univ (fun i => j ≠ i ∧ k ≠ i), hc.2, zero_add]
    exact Finset.sum_eq_zero fun i hi => hc.1 i (by simpa using (Finset.mem_filter.mp hi).2)
  refine ⟨c, hcj, hck, hsum, ContinuousLinearMap.ext fun X => Subtype.ext ?_⟩
  have e := congrArg (fun L : CurvLin (Fin n) => L (X : Matrix (Fin n) (Fin n) ℝ)) he
  rw [← extend_apply V X]
  show extend V (X : Matrix (Fin n) (Fin n) ℝ) = Smat j k * (X : Matrix (Fin n) (Fin n) ℝ) * diagonal (vy j k c)
    + diagonal (vy j k c) * (X : Matrix (Fin n) (Fin n) ℝ) * Smat j k
  rw [← pairLin_eq_nuX hjk c hcj hck X.2]
  have e2 : pairMap j k c (X : Matrix (Fin n) (Fin n) ℝ) = pairLin j k c (X : Matrix (Fin n) (Fin n) ℝ) := by
    show pairLin j k c (HamiltonsCubic.WeylModuleSNonzero.skewProj (Fin n) (X : Matrix (Fin n) (Fin n) ℝ)) = _
    rw [HamiltonsCubic.WeylModuleSNonzero.skewProj_skew _ X.2]
  rw [← e2, e]
  rfl

/-- **L222 (2) on all of `V_jk`**: every Weyl operator `ν` of character `ε_j ε_k` is `ν_c` for its coefficients `c`
(zero at `j, k`, `Σ c = 0`), and `ν ∘ ν = G_c`. -/
theorem Q_pair (hjk : j ≠ k) {V : CurvOp2 (Fin n)} (hVW : IsWeyl2 V) (hV : SignChar (setChar {j, k}) V) :
    ∃ c : Fin n → ℝ, c j = 0 ∧ c k = 0 ∧ ∑ i, c i = 0 ∧ V = nuX j k c ∧ Qop2 V = coordOp (Gy j k c) := by
  obtain ⟨c, hcj, hck, hsum, rfl⟩ := pair_eq_nuX hjk hVW hV
  refine ⟨c, hcj, hck, hsum, rfl, Q_nuX hjk c ?_⟩
  rw [vy_of_zero c hcj hck]; exact hsum

end HamiltonsCubic.PairIdent
