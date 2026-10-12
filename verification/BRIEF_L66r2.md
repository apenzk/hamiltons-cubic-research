# Brief, round L66

**Cold brief. Every passage below is quoted verbatim from the record, with its source lines. No prior verdict on this result is included.**

## Passage A, the section carrying the argument ([findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 1-17)

# Every maximiser is $\circ$-indecomposable, one line

> **Definition.** $W$ is **$\circ$-decomposable** if $W=\sum_{i=1}^k a_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathrm{Weyl}_n$, $\sum a_i^2=1$, all $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$.

> **Theorem.** *For $n\ge4$, no maximiser of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $\circ$-decomposable.* At $n\le3$, $\mathrm{Weyl}_n=0$.

**Proof.** Write $M(n)=\max\{P(A):A\in\mathcal W_n,\lVert A\rVert=1\}$ for the global maximum; $M(n)>0$ at every $n\ge4$, since $S^k\times S^l$ with $k,l\ge2$ has $P(W_{S_{k,l}})=\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}k\cdot\frac{l-1}l\cdot\frac{n-1}{n-2}}>0$ ([Nienhaus, Proposition 2.25](../references/nienhaus-2023-second-best-einstein/notes.md)), and **the final inequality below is strict only because of that**. $A_i\circ A_j=0$ makes $P$ **additive**: $P(W)=\sum_ia_i^3P(A_i)$. *That step uses the **total** symmetry of $T(X,Y,Z)=\langle X,Y\circ Z\rangle$*, the cross term $\langle A_i,Q(A_j)\rangle=T(A_i,A_j,A_j)$ dies only after moving the first slot to $\langle A_j,A_i\circ A_j\rangle=0$. The full symmetry is proved in Lemma L24's argument at [second-order.md](../findings/second-order.md): the $W^2$ part is the symmetrisation of $\operatorname{tr}(XYZ)$, and permuting the arguments of the $\#$ part permutes the slots of both totally antisymmetric structure constants, at sign $(-1)^2$. Hence
$$P(W)=\sum_ia_i^3P(A_i)\;\le\;M(n)\sum_i\lvert a_i\rvert^3\;\le\;M(n)\max_i\lvert a_i\rvert\;<\;M(n),$$
using $\sum_i\lvert a_i\rvert^3\le\max_i\lvert a_i\rvert\cdot\sum_ia_i^2=\max_i\lvert a_i\rvert$, and $\max_i\lvert a_i\rvert<1$ because $\sum a_i^2=1$ with $k\ge2$ and every $a_i\ne0$. $\square$

*The absolute values are load-bearing: with $a_i^3$ in place of $\lvert a_i\rvert^3$ the chain fails at any negative coefficient, and at $(a,b)=(\tfrac35,-\tfrac45)$ with pieces at $\pm M$ it gives $P(W)=\tfrac{91}{125}M$ against a bound of $-\tfrac{37}{125}M$.*

**Criticality of the pieces is not needed.** With $A_i\circ A_j=0$ as the *hypothesis*, as the definition above states it, additivity is immediate and criticality never enters.

**Criticality with ordinary orthogonality is a different hypothesis from $\circ$-orthogonality.** *A run at $n=8$ found two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ with $\lVert A\circ B\rVert\approx0.664$, and a rotated $S^4\times S^4$ pair at $\approx0.273$. No closed-form witness is on file.*

**Nothing else is used.** No padding, no monotonicity of $M$, no harmonic-square law, and (the part that widens the reach), **no criticality of the pieces**. $A_i$ is a unit element of $\mathrm{Weyl}_n$ and $P$ is odd, so $\lvert P(A_i)\rvert\le M(n)$ outright and the pieces' support dimensions never enter.

## Passage B, the result's block in the same file ([findings/support-dichotomy.md](../findings/support-dichotomy.md) lines 33 and 37)

#### Lemma L66, no maximizer is $\circ$-decomposable

Call $W$ *$\circ$-decomposable* if $W=\sum_{i=1}^ka_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathrm{Weyl}_n$, $\sum_ia_i^2=1$, every $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$. Then for $n\ge4$ no maximizer of $P$ on the unit sphere of $\mathrm{Weyl}_n$ is $\circ$-decomposable.

## Passage C, the canonical statement ([results.md](../results.md) line 347, landscape, and lines 1161 and 1163, detail)

- **Lemma L66 (second-order). No maximizer is $\circ$-decomposable.** Call $W=\sum_{i=1}^ka_iA_i$ $\circ$-decomposable if $k\ge2$, each $A_i$ a unit Weyl tensor, $\sum a_i^2=1$, every $a_i\ne0$ and $A_i\circ A_j=0$ for $i\ne j$. Then for $n\ge4$ no maximizer of $P$ on the unit sphere of $\mathcal W_n$ is $\circ$-decomposable. **No criticality of the pieces is needed**, which is what makes the statement reach non-critical splittings and ones sharing coordinates. At a critical point split into two critical pieces with $A\circ B=0$, the harmonic-square law $\frac1{\theta^2}=\frac1{\theta_A^2}+\frac1{\theta_B^2}$ ([nondegeneracy.md](../findings/nondegeneracy.md)) gives the sharper $\lvert\theta\rvert<\min(\lvert\theta_A\rvert,\lvert\theta_B\rvert)$. **That bound needs the criticality this lemma disclaims**: without it, as one coefficient tends to $1$, $P(W)$ tends to that piece's own value.

##### Lemma L66, no maximizer is $\circ$-decomposable

Let $W=\sum_{i=1}^ka_iA_i$ with $k\ge2$, each $A_i$ a unit element of $\mathcal W_n$, $\sum_ia_i^2=1$, every $a_i\ne0$, and $A_i\circ A_j=0$ for $i\ne j$, where $\circ$ is the symmetric product with $\langle x\circ y,z\rangle=T(x,y,z)$. Then for $n\ge4$, $W$ is no maximizer of $P$ on the unit sphere of $\mathcal W_n$: $T$ is fully symmetric and $T(A_i,A_j,\cdot)=\langle A_i\circ A_j,\cdot\rangle$, so every term of $T(W,W,W)$ carrying two distinct indices vanishes, so $P(W)=\sum_ia_i^3P(A_i)$, and with $\lvert a_i\rvert<1$ for every $i$, $\lvert P(W)\rvert\le\sum_i\lvert a_i\rvert^3\lvert P(A_i)\rvert\le M(n)\max_i\lvert a_i\rvert<M(n)$, where $M(n)=\max\{P(A):\lVert A\rVert=1\}$ is the global maximum, positive because $S^k\times S^l$ with $k,l\ge2$ has $P=\theta_{k,l}>0$ (Nienhaus, Proposition 2.25). **The bound runs against $M(n)$ rather than against $\max_i\lvert P(A_i)\rvert$**, which reads $0<0$ at a splitting whose every piece has $P(A_i)=0$. The lemma is a statement about maximizers and bounds nothing about the summands' support dimensions, so it supplies no induction on $n$.

## Passage D, the givens the argument cites

**Lemma L24's argument, which Passage A cites for the total symmetry of $T$** ([findings/second-order.md](../findings/second-order.md) line 67):

**Argument.** $P$ is a cubic form, so $\nabla P=3Q(W)$ and the second differential is $6\,\theta\,L_e$; the constraint $\|W\|^2=1$ contributes $-3\theta\,\mathrm{Id}$ through its multiplier, leaving $6\theta(L_e-\tfrac12\mathrm{Id})$ on the tangent space. Two steps the first version left implicit. **$L_e$ is self-adjoint**, so $\lambda_{\max}$ is defined at all: $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is fully symmetric, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$ and the $\#$ part because permuting the arguments permutes the slots of both totally antisymmetric $c$'s, sign $(-1)^2$ ([r285](../reviews/REVIEW_r285.md) Claim 1). **And $W^\perp$ is $L_e$-invariant**, since $L_ee=e$ by criticality and self-adjointness then carries the complement, so the restriction is a genuine operator rather than a compression, which is [Lemma L125](../findings/second-order.md#lemma-l125-l24-off-wperp-the-same-statement-in-the-form-the-four-set-application-needs) one heading below.

**Nienhaus, Proposition 2.25**, from the text extraction of the paper, [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) lines 1483-1490, with the PDF [nienhaus-2311.02404.pdf](https://arxiv.org/abs/2311.02404) beside it. Read the PDF where the extraction garbles a formula, and nothing else in that folder.

```text
Proposition 2.25. The Weyl curvature of Sk,l satisfies

                                      WS2k,l + WS#k,l = θk,l · WSk,l ,

               √        q
                            k−1 l−1 n−1
where θk,l =       2·        k · l · n−2 . Moreover, P (WSk,l ) = θk,l .

```

**Definitions from the record's conventions** ([findings/conventions.md](../findings/conventions.md) lines 15, 24, 77 and 136):

| $Q(W)$ | Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself | [README.md](../README.md) |
| $T$, third sense | **the fully symmetric trilinear form $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ on $\mathcal W_n$**, whose symmetry is what makes $L_e$ self-adjoint and hence [L24](../findings/second-order.md)'s $\lambda_{\max}$ well defined at all, the $W^2$ part as the symmetrisation of $\operatorname{tr}(XYZ)$, the $\#$ part because permuting the arguments permutes the slots of two totally antisymmetric $c$'s at sign $(-1)^2$. **It was tabled nowhere while the letter already carried the bracket tensor $T_{\alpha\beta\gamma}$ and [L35](../findings/stratum-two-negative.md)'s cap $\tfrac{2\sqrt2}3A$** | [second-order.md](../findings/second-order.md) |

**THE INDEX FORMULA FOR $\#$ CARRIES A $\tfrac12$, AND A DISPLAY WITHOUT IT IS TWICE THE RECORD'S $\#$.** $(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$; dropped, the formula returns $\mathrm{id}^\#=2(n-2)\mathrm{id}$ against the halved Böhm–Wilking product's $(n-2)\mathrm{id}$, which is what $Q(\mathrm{id})=(n-1)\mathrm{id}$ on the round sphere pins. *A step reading only the index support of $W^\#$ is untouched by the factor; a step reading a value off it is out by two.* **Two reviewers derived the clash independently, each from $\mathrm{id}^\#$.**

- **The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$. The whole second-order apparatus rests on it.

## Passage E, the Lean files, declarations with docstrings removed ([L66Statement.lean](../lean/HamiltonsCubic/Results/L66Statement.lean), [L66.lean](../lean/HamiltonsCubic/Results/L66.lean))

```lean
import Mathlib

set_option linter.style.longLine false

namespace HamiltonsCubic.L66Statement

open Finset

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

noncomputable def Pf (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) (X : E) : ℝ := T X X X

def IsCircDecomposable (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) (W : E) : Prop :=
  ∃ (k : ℕ) (a : Fin k → ℝ) (A : Fin k → E),
    2 ≤ k ∧ (∀ i, ‖A i‖ = 1) ∧ (∑ i, a i ^ 2 = 1) ∧ (∀ i, a i ≠ 0) ∧
      (∀ (X : E) (i j : Fin k), i ≠ j → T X (A i) (A j) = 0) ∧
      W = ∑ i, a i • A i

private theorem slot1 (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E)
    (Y Z : E) : T (∑ i, a i • A i) Y Z = ∑ i, a i * T (A i) Y Z := by
  simp [map_sum, LinearMap.sum_apply, LinearMap.smul_apply]

private theorem slot2 (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E)
    (X Z : E) : T X (∑ j, a j • A j) Z = ∑ j, a j * T X (A j) Z := by
  simp [map_sum, LinearMap.sum_apply, LinearMap.smul_apply]

private theorem slot3 (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E)
    (X Y : E) : T X Y (∑ l, a l • A l) = ∑ l, a l * T X Y (A l) := by
  simp [map_sum]

theorem Pf_sum (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ) {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E) :
    Pf T (∑ i, a i • A i)
      = ∑ i, a i * ∑ j, a j * ∑ l, a l * T (A i) (A j) (A l) := by
  rw [Pf, slot1 T a A]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [slot2 T a A]
  refine congrArg (fun x => a i * x) (Finset.sum_congr rfl fun j _ => ?_)
  rw [slot3 T a A]

theorem Pf_additive (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ)
    (hsym12 : ∀ x y z : E, T x y z = T y x z)
    {k : ℕ} (a : Fin k → ℝ) (A : Fin k → E)
    (horth : ∀ (X : E) (i j : Fin k), i ≠ j → T X (A i) (A j) = 0) :
    Pf T (∑ i, a i • A i) = ∑ i, a i ^ 3 * Pf T (A i) := by
  rw [Pf_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  have hinner : ∀ j : Fin k, (∑ l, a l * T (A i) (A j) (A l)) = a j * T (A i) (A j) (A j) := by
    intro j
    refine Finset.sum_eq_single j (fun l _ hl => ?_) (fun h => absurd (Finset.mem_univ j) h)
    rw [horth (A i) j l (fun h => hl h.symm), mul_zero]
  rw [Finset.sum_congr rfl fun j (_ : j ∈ Finset.univ) => congrArg (fun x => a j * x) (hinner j)]
  have hmid : (∑ j, a j * (a j * T (A i) (A j) (A j)))
      = a i * (a i * T (A i) (A i) (A i)) := by
    refine Finset.sum_eq_single i (fun j _ hj => ?_) (fun h => absurd (Finset.mem_univ i) h)
    have hz : T (A i) (A j) (A j) = 0 := by
      rw [hsym12 (A i) (A j) (A j)]
      exact horth (A j) i j (fun h => hj h.symm)
    rw [hz, mul_zero, mul_zero]
  rw [hmid, Pf]
  ring

theorem abs_lt_one {k : ℕ} (hk : 2 ≤ k) (a : Fin k → ℝ) (hsum : ∑ i, a i ^ 2 = 1)
    (hne : ∀ i, a i ≠ 0) (i : Fin k) : |a i| < 1 := by
  obtain ⟨j, hj⟩ : ∃ j : Fin k, j ≠ i :=
    Fintype.exists_ne_of_one_lt_card (by simpa using (by omega : 1 < k)) i
  have hsub : a i ^ 2 + a j ^ 2 ≤ ∑ l, a l ^ 2 := by
    have hpair : ({i, j} : Finset (Fin k)) ⊆ Finset.univ := Finset.subset_univ _
    have := Finset.sum_le_sum_of_subset_of_nonneg hpair (fun l _ _ => sq_nonneg (a l))
    rwa [Finset.sum_pair (Ne.symm hj)] at this
  have hjpos : 0 < a j ^ 2 :=
    lt_of_le_of_ne (sq_nonneg _) (Ne.symm (pow_ne_zero 2 (hne j)))
  have hlt : a i ^ 2 < 1 := by rw [hsum] at hsub; linarith
  have h1 : |a i| ^ 2 < 1 := by rwa [sq_abs]
  nlinarith [abs_nonneg (a i)]

theorem sum_abs_cube_lt_one {k : ℕ} (hk : 2 ≤ k) (a : Fin k → ℝ) (hsum : ∑ i, a i ^ 2 = 1)
    (hne : ∀ i, a i ≠ 0) : ∑ i, |a i| ^ 3 < 1 := by
  have hk0 : 0 < k := by omega
  have hnonempty : (Finset.univ : Finset (Fin k)).Nonempty := ⟨⟨0, hk0⟩, Finset.mem_univ _⟩
  have hlt : ∑ i, |a i| ^ 3 < ∑ i, a i ^ 2 := by
    refine Finset.sum_lt_sum_of_nonempty hnonempty fun i _ => ?_
    have hb := abs_lt_one hk a hsum hne i
    have hpos : 0 < a i ^ 2 :=
      lt_of_le_of_ne (sq_nonneg _) (Ne.symm (pow_ne_zero 2 (hne i)))
    have hrw : |a i| ^ 3 = |a i| * a i ^ 2 := by rw [← sq_abs (a i)]; ring
    rw [hrw]
    nlinarith [abs_nonneg (a i)]
  rwa [hsum] at hlt

theorem Pf_lt_max (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ)
    (hsym12 : ∀ x y z : E, T x y z = T y x z)
    (M : ℝ) (hMpos : 0 < M) (hM : ∀ B : E, ‖B‖ = 1 → Pf T B ≤ M)
    (W : E) (hW : IsCircDecomposable T W) :
    Pf T W < M := by
  obtain ⟨k, a, A, hk, hunit, hsum, hne, horth, hdec⟩ := hW
  have hodd : ∀ B : E, Pf T (-B) = -Pf T B := by intro B; simp [Pf]
  have habs : ∀ i, |Pf T (A i)| ≤ M := by
    intro i
    rw [abs_le]
    refine ⟨?_, hM (A i) (hunit i)⟩
    have hneg : Pf T (-A i) ≤ M := hM (-A i) (by rw [norm_neg]; exact hunit i)
    rw [hodd] at hneg
    linarith
  rw [hdec, Pf_additive T hsym12 a A horth]
  have hterm : ∀ i ∈ (Finset.univ : Finset (Fin k)), a i ^ 3 * Pf T (A i) ≤ M * |a i| ^ 3 := by
    intro i _
    calc a i ^ 3 * Pf T (A i) ≤ |a i ^ 3 * Pf T (A i)| := le_abs_self _
      _ = |a i| ^ 3 * |Pf T (A i)| := by rw [abs_mul, abs_pow]
      _ ≤ |a i| ^ 3 * M := mul_le_mul_of_nonneg_left (habs i) (by positivity)
      _ = M * |a i| ^ 3 := by ring
  calc ∑ i, a i ^ 3 * Pf T (A i) ≤ ∑ i, M * |a i| ^ 3 := Finset.sum_le_sum hterm
    _ = M * ∑ i, |a i| ^ 3 := by rw [Finset.mul_sum]
    _ < M * 1 := mul_lt_mul_of_pos_left (sum_abs_cube_lt_one hk a hsum hne) hMpos
    _ = M := mul_one M

theorem no_maximizer_is_circDecomposable (T : E →ₗ[ℝ] E →ₗ[ℝ] E →ₗ[ℝ] ℝ)
    (hsym12 : ∀ x y z : E, T x y z = T y x z)
    (M : ℝ) (hMpos : 0 < M) (hM : ∀ B : E, ‖B‖ = 1 → Pf T B ≤ M)
    (W : E) (_hWnorm : ‖W‖ = 1) (hmax : Pf T W = M) :
    ¬ IsCircDecomposable T W := fun hdec =>
  absurd hmax (ne_of_lt (Pf_lt_max T hsym12 M hMpos hM W hdec))

example (M : ℝ) (hM : 0 < M) :
    (3/5 : ℝ) ^ 3 * M + (-4/5 : ℝ) ^ 3 * (-M) = (91/125) * M ∧
      ((3/5 : ℝ) ^ 3 + (-4/5 : ℝ) ^ 3) * M = (-37/125) * M ∧
      (-37/125 : ℝ) * M < (91/125) * M := by
  refine ⟨by ring, by ring, by nlinarith⟩

example : IsCircDecomposable (E := EuclideanSpace ℝ (Fin 2)) 0
    ((3/5 : ℝ) • EuclideanSpace.single (0 : Fin 2) (1:ℝ)
      + (4/5 : ℝ) • EuclideanSpace.single (1 : Fin 2) (1:ℝ)) := by
  refine ⟨2, ![3/5, 4/5], fun i => EuclideanSpace.single i (1:ℝ), le_refl 2, ?_, ?_, ?_, ?_, ?_⟩
  · intro i; simp
  · simp [Fin.sum_univ_two]; norm_num
  · intro i; fin_cases i <;> norm_num
  · intro X i j _; simp
  · simp [Fin.sum_univ_two]

end HamiltonsCubic.L66Statement
```

```lean
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace HamiltonsCubic.Decomposable

open Finset

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem sum_abs_cube_le {a : ι → ℝ} {m : ℝ} (hm : ∀ i, |a i| ≤ m) :
    ∑ i, |a i| ^ 3 ≤ m * ∑ i, (a i) ^ 2 := by
  rw [Finset.mul_sum]
  refine Finset.sum_le_sum fun i _ => ?_
  have h1 : |a i| ^ 3 = |a i| * (a i) ^ 2 := by
    rw [pow_succ, sq_abs]; ring
  rw [h1]
  exact mul_le_mul_of_nonneg_right (hm i) (sq_nonneg _)

theorem coeff_lt_one {a : ι → ℝ} (hnorm : ∑ i, (a i) ^ 2 = 1) {j k : ι} (hjk : j ≠ k)
    (hk : a k ≠ 0) : |a j| < 1 := by
  classical
  have hpair : (a j) ^ 2 + (a k) ^ 2 ≤ ∑ i, (a i) ^ 2 := by
    have hsub : ({j, k} : Finset ι) ⊆ univ := subset_univ _
    have hsd := Finset.sum_sdiff (f := fun i => (a i) ^ 2) hsub
    have hrest : 0 ≤ ∑ i ∈ univ \ ({j, k} : Finset ι), (a i) ^ 2 :=
      Finset.sum_nonneg fun i _ => sq_nonneg _
    have hp : ∑ i ∈ ({j, k} : Finset ι), (a i) ^ 2 = (a j) ^ 2 + (a k) ^ 2 :=
      Finset.sum_pair hjk
    linarith [hsd, hrest, hp]
  have hkpos : 0 < (a k) ^ 2 := by positivity
  have : (a j) ^ 2 < 1 := by linarith [hpair, hnorm, hkpos]
  have habs : |a j| ^ 2 < 1 := by rwa [sq_abs]
  nlinarith [habs, abs_nonneg (a j)]

theorem strict_below {a : ι → ℝ} {P : ι → ℝ} {M PW : ℝ}
    (hM : 0 < M) (hPi : ∀ i, |P i| ≤ M)
    (hadd : PW = ∑ i, (a i) ^ 3 * P i)
    (hnorm : ∑ i, (a i) ^ 2 = 1)
    {j k : ι} (hjk : j ≠ k) (hj : a j ≠ 0) (hk : a k ≠ 0)
    (hbound : ∀ i, |a i| ≤ max |a j| |a k|) :
    PW < M := by
  classical
  set m := max |a j| |a k| with hm
  have hmlt : m < 1 := by
    rw [hm]
    exact max_lt (coeff_lt_one hnorm hjk hk) (coeff_lt_one hnorm (Ne.symm hjk) hj)
  have hterm : ∀ i ∈ univ, (a i) ^ 3 * P i ≤ M * |a i| ^ 3 := by
    intro i _
    have h1 : (a i) ^ 3 * P i ≤ |a i| ^ 3 * |P i| := by
      calc (a i) ^ 3 * P i ≤ |(a i) ^ 3 * P i| := le_abs_self _
        _ = |a i| ^ 3 * |P i| := by simp [abs_mul, abs_pow]
    calc (a i) ^ 3 * P i ≤ |a i| ^ 3 * |P i| := h1
      _ ≤ |a i| ^ 3 * M := mul_le_mul_of_nonneg_left (hPi i) (by positivity)
      _ = M * |a i| ^ 3 := by ring
  have hsum : PW ≤ M * ∑ i, |a i| ^ 3 := by
    have h := Finset.sum_le_sum hterm
    rw [hadd]
    calc ∑ i, (a i) ^ 3 * P i ≤ ∑ i, M * |a i| ^ 3 := h
      _ = M * ∑ i, |a i| ^ 3 := by rw [Finset.mul_sum]
  have hcube := sum_abs_cube_le (a := a) (m := m) hbound
  rw [hnorm, mul_one] at hcube
  have : PW ≤ M * m := by
    calc PW ≤ M * ∑ i, |a i| ^ 3 := hsum
      _ ≤ M * m := mul_le_mul_of_nonneg_left hcube (le_of_lt hM)
  nlinarith [this, hmlt, hM]

theorem witness_admissible : ((3 : ℚ) / 5) ^ 2 + (-(4 : ℚ) / 5) ^ 2 = 1 := by norm_num

theorem witness_true_value :
    ((3 : ℚ) / 5) ^ 3 * 1 + (-(4 : ℚ) / 5) ^ 3 * (-1) = 91 / 125 := by norm_num

theorem witness_claimed_bound : ((3 : ℚ) / 5) ^ 3 + (-(4 : ℚ) / 5) ^ 3 = -37 / 125 := by
  norm_num

theorem witness_fails : (-37 : ℚ) / 125 < 91 / 125 := by norm_num

theorem witness_margin : (91 : ℚ) / 125 - (-37 / 125) = 128 / 125 := by norm_num

theorem witness_with_abs : |(3 : ℚ) / 5| ^ 3 + |-(4 : ℚ) / 5| ^ 3 = 91 / 125 := by
  norm_num

theorem theta0_four : 2 * (4 - 1 : ℚ) * (4 - 2) / 4 ^ 2 = 3 / 4 := by norm_num

theorem M4_exceeds : (3 : ℚ) / 4 < 3 / 2 := by norm_num

theorem M4_ratio : (3 : ℚ) / 2 = 2 * (3 / 4) := by norm_num

end HamiltonsCubic.Decomposable
```

## Definitions

- $\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, viewed as symmetric operators on $\Lambda^2\mathbb R^n$, with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$.
- **This loop does no numerical work.** A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim.

## What to attack, beyond the standing list

1. **The definition of $\circ$-decomposable** in Passages A, B and C: every clause, and whether the three agree.
2. **Additivity**, $P(W)=\sum_ia_i^3P(A_i)$: the expansion of $T(W,W,W)$, which terms $A_i\circ A_j=0$ kills and by which slot moves, and whether total symmetry of $T$ is what that needs. Whether Passage D's argument for total symmetry establishes it, for both the $W^2$ part and the $\#$ part, with the index formula and the $\tfrac12$ as defined.
3. **$\lvert P(A_i)\rvert\le M(n)$**: the oddness of $P$, and that each $A_i$ is a unit element of $\mathcal W_n$.
4. **The chain** $\sum_ia_i^3P(A_i)\le M(n)\sum_i\lvert a_i\rvert^3\le M(n)\max_i\lvert a_i\rvert<M(n)$, each inequality, the signs, and the strictness.
5. **$\max_i\lvert a_i\rvert<1$** from $\sum a_i^2=1$, $k\ge2$ and every $a_i\ne0$.
6. **$M(n)>0$ at every $n\ge4$**, against Proposition 2.25 as printed: whether $W_{S_{k,l}}$ is a unit element there, which $k,l$ with $k,l\ge2$ realise each $n\ge4$, and the formula for $\theta_{k,l}$ against the passage's.
7. **The absolute-value remark** at $(a,b)=(\tfrac35,-\tfrac45)$ with pieces at $\pm M$: both numbers, and whether pieces at $\pm M$ can meet the definition.
8. **"Criticality of the pieces is not needed"**, "Nothing else is used", and the paragraph on criticality with ordinary orthogonality, which cites a run.
9. **Passage C's detail**: $\lvert P(W)\rvert$ against Passage A's $P(W)$, "the bound runs against $M(n)$", "reads $0<0$ at a splitting whose every piece has $P(A_i)=0$", and "supplies no induction on $n$". **Passage C's landscape line**: the harmonic-square law's consequence $\lvert\theta\rvert<\min(\lvert\theta_A\rvert,\lvert\theta_B\rvert)$ and "as one coefficient tends to $1$, $P(W)$ tends to that piece's own value".
10. **Passage E against Passages A to C**: the form's symmetry hypothesis against total symmetry, how $A_i\circ A_j=0$ is entered, what is proved and what enters as a hypothesis.
11. **The boundary**: $n=4$, $k=2$ with $a_1^2=a_2^2=\tfrac12$, pieces with $P(A_i)<0$, and whether a $\circ$-decomposable $W$ exists at all at each $n\ge4$.
