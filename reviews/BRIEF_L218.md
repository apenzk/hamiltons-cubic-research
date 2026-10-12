# Gate 2 brief, Lemma L218, the off-diagonal coupling at a diagonal point

**Cold brief. Every passage is quoted verbatim from the record with its source. You are asked to break the result.** Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per claim.

## The claim under attack ([findings/second-order.md](../findings/second-order.md) lines 802 and 806-821)

#### Lemma L218, the off-diagonal coupling at a diagonal point is at most $\sqrt5/2$, so Banach's form of the maximum does not refute Conjecture A through it

**Statement.** *Let $n\ge5$ and $\Lambda_n=\sup\{\langle L_DN,N\rangle:D\in\mathcal D_n,\ N\in\mathcal D_n^\perp\cap\mathcal W_n,\ \lVert D\rVert=\lVert N\rVert=1\}$. Then*
$$\tfrac{\sqrt3}2\ \le\ \Lambda_n\ \le\ \tfrac{\sqrt5}2,$$
*and $\tfrac{\sqrt5}2<\theta_0(n)$ at every $n\ge8$.* **So the falsifier $\Lambda_n>\Theta_n$, which by Banach's theorem $\sup_{\lVert x\rVert=1}P(x)=\sup_{\lVert x\rVert=\lVert y\rVert=\lVert z\rVert=1}T(x,y,z)$ would refute Conjecture A, does not fire at any even $n\ge8$.**

**Proof.** Write $K$ for $D$'s sectional matrix, hollow and symmetric, with $\sum_{a<b}K_{ab}^2=1$ at unit norm ([conventions.md](../findings/conventions.md)). By [Lemma L120](../findings/second-order.md#lemma-l120-l_m-is-block-diagonal-over-the-sign-characters-at-every-diagonal-critical-point), $\mathcal D_n^\perp\cap\mathcal W_n$ is the orthogonal sum of the four-set blocks $V_{ijkl}$ and the pair blocks $V_{jk}$, and $L_D$ preserves each, a support argument needing diagonality alone. So $\langle L_DN,N\rangle$ is a convex combination of the blocks' Rayleigh quotients, and $\Lambda_n$ is at most the largest block eigenvalue.

*The four-set block.* By [Lemma L121](../findings/second-order.md#lemma-l121-the-4-set-block-its-spectrum-and-one-necessary-condition-per-4-subset), its eigenvalues are $\pm\tfrac12\sqrt{E}$ with $E=A^2+B^2+C^2-AB-BC-CA$, $A=K_{ij}+K_{kl}$, $B=K_{ik}+K_{jl}$, $C=K_{il}+K_{jk}$. Since $E=\tfrac32(A^2+B^2+C^2)-\tfrac12(A+B+C)^2$ and $(x+y)^2\le2(x^2+y^2)$, $E\le3(K_{ij}^2+K_{kl}^2+K_{ik}^2+K_{jl}^2+K_{il}^2+K_{jk}^2)\le3$, so the top eigenvalue is at most $\tfrac{\sqrt3}2$.

*The pair block.* By [Lemma L122](../findings/second-order.md#lemma-l122-the-pair-block-is-a-graph-laplacian-of-the-sectional-matrix), in an orthogonal basis of common norm it is $\tfrac12\big[\operatorname{diag}(d)-\kappa\,\mathrm{Id}+S\big]$ with $d_i=K_{ji}+K_{ki}$, $\kappa=K_{jk}$ and $S$ the hollow submatrix off $\{j,k\}$. For a vector $x$, $\sum_id_ix_i^2\le\max_i\lvert d_i\rvert\,\lVert x\rVert^2$, $-\kappa\lVert x\rVert^2\le\lvert\kappa\rvert\lVert x\rVert^2$, and $x^{\mathsf T}Sx\le\lVert S\rVert_F\lVert x\rVert^2$ by Cauchy--Schwarz over the index pairs. With $X=K_{ji}^2+K_{ki}^2$ at the maximising $i$, $Z=K_{jk}^2$ and $Y$ the unordered mass off $\{j,k\}$, disjoint sets of entries give $X+Y+Z\le1$, while $d_i^2\le2X$ and $\lVert S\rVert_F^2=2Y$. Hence the bracket's Rayleigh quotient is at most $\sqrt{2X}+\sqrt Z+\sqrt{2Y}\le\sqrt{(2+1+2)(X+Z+Y)}\le\sqrt5$, and the block's top eigenvalue is at most $\tfrac{\sqrt5}2$.

*The lower bound.* At padded $S^2\times S^2$, $K_{12}=K_{34}=-2/\sqrt{12}$ and the four cross entries are $1/\sqrt{12}$, so $A=-4/\sqrt{12}$, $B=C=2/\sqrt{12}$ and $E=3$, attaining $\tfrac{\sqrt3}2$ on the four-set block, the value [post F67](../findings/fence-posts.md) records.

*Against $\theta_0(n)$.* $\theta_0(n)^2>\tfrac54$ is $3n^2-24n+16>0$, which holds from $n=8$. $\square$

**What it does and does not give.** *It closes [I99](../plan.md) as a falsifier: through this coupling, Banach's operator form of the maximum reaches no value above $\sqrt5/2$, well below $\theta_0(n)$.* **It is not a route input**: [post F67](../findings/fence-posts.md) shows that bounding $\langle L_d\nu,\nu\rangle$ independently of $P(d)$ cannot beat $\Theta_n$ whatever the constant, and $\sqrt5/2\ge\Theta_n/2$ leaves that ceiling where it was. *Whether $\sqrt5/2$ is attained, or the pair block's true supremum lies nearer $\sqrt3/2$, is not settled here, and nothing downstream needs it.*

## Given 1, Lemma L120's statement, the block decomposition ([findings/second-order.md](../findings/second-order.md) lines 624-631)

#### Lemma L120, $L_M$ is block-diagonal over the sign characters at every diagonal critical point

**Let $\Gamma=\{\operatorname{diag}(\varepsilon_1,\dots,\varepsilon_n):\varepsilon_i=\pm1\}\subset O(n)$ be the full diagonal sign group. Then $\mathcal W_n$ decomposes as**
$$\mathcal W_n=\underbrace{\mathcal D_n}_{n(n-3)/2}\ \oplus\ \bigoplus_{\{i,j,k,l\}}\underbrace{V_{ijkl}}_{2}\ \oplus\ \bigoplus_{\{j,k\}}\underbrace{V_{jk}}_{n-3},$$
**and at every diagonal $M$, **criticality is unused; $\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed**, the operator $L_M$ preserves each summand. Hence the Hessian of $P$ on the sphere is block-diagonal in the same way, and [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement)'s criterion is checkable block by block **once $\mathcal D_n$ is cut by $\langle M\rangle$**; the largest block a non-diagonal direction occupies has size $\max(2,n-3)$, and $\binom n4$ of them have size $2$.

> **THE CUT IS NOT OPTIONAL, AND THE SENTENCE ABOVE IS THE ONE EVERY CITATION QUOTES.** $e=M/\theta$ lies in $\mathcal D_n$ and $L_ee=e$, so read without it the criterion gives $\lambda_{\max}(L_e\vert_{\mathcal D_n})\ge1>\tfrac12$ and **no diagonal critical point is a maximiser, vacuously**, the balanced sphere product included. **$W^\perp$ cuts $\mathcal D_n$ and nothing else**, since $M$ spans the trivial character and every other summand lies wholly inside $W^\perp$ by isotypic orthogonality. *And the block size fails at $n=4$ as first printed, where the four-set block is $2$ against $n-3=1$.* *Gate 2, [r507](REVIEW_r507.md) and [r508](REVIEW_r508.md) on identical briefs, both CONFIRMED and agreeing on every repair.***


## Given 2, Lemma L121's statement, the four-set block ([findings/second-order.md](../findings/second-order.md) lines 640-645)

#### Lemma L121, the $4$-set block, its spectrum, and one necessary condition per $4$-subset

**Fix a **pair-diagonal** $M$ and a $4$-subset $\{i,j,k,l\}$, the block and its spectrum need diagonality alone, with no criticality and no row sum entering, which is what makes them applicable to $\operatorname{diag}(M)$ in a frame where $W$ is not diagonal. **The necessary condition below is the part that needs a maximiser**, through [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement). Let $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$ be the three opposite-pair sums. Then in signed coordinates $L_M$ restricted to the $4$-set space is $\tfrac12G$ with $G=\begin{pmatrix}A&C&B\\C&B&A\\B&A&C\end{pmatrix}$; **the Bianchi subspace is $\mathbf 1^\perp$** because $\hat a+\hat b+\hat c=0$ in these signed coordinates, and $G\mathbf 1=(A+B+C)\mathbf 1$ then makes that subspace **invariant**, two joints, not one. **The restriction to $\mathbf 1^\perp$ is traceless**; $\tfrac12G$ itself is not, its trace being $\tfrac12(A+B+C)$. Spectrum**
$$\pm\tfrac12\sqrt{A^2+B^2+C^2-AB-BC-CA}\;=\;\pm\tfrac12\sqrt{\tfrac12\big[(A-B)^2+(B-C)^2+(C-A)^2\big]}.$$

**The list is complete, not short a root.** $G$'s third eigenvalue is $A+B+C$ on the vector $\mathbf 1$, and first Bianchi is exactly $\mathbf 1^\perp$ in these signed coordinates, so that root is removed rather than missing. *And $G$ is symmetric: it is the Latin square with diagonal $(A,B,C)$ whose off-diagonal $(m,m')$ entry is the third letter, so $G_{12}=C=G_{21}$ and likewise for the other two. The signed coordinates are load-bearing, the raw block is $\operatorname{diag}(1,-1,1)$-conjugate to it, and that same flip turns Bianchi's $x_1-x_2+x_3=0$ into $y_1+y_2+y_3=0$.* *Gate 2, [r531](REVIEW_r531.md) and [r532](REVIEW_r532.md) on identical briefs, both CONFIRMED.*

## Given 3, Lemma L122's statement, the pair block ([findings/second-order.md](../findings/second-order.md) lines 654-659)

#### Lemma L122, the pair block is a graph Laplacian of the sectional matrix

**Let $M$ be a coordinate-diagonal Weyl operator with sectional matrix $M_{ab}$, and fix a pair $\{j,k\}$. In the basis $f_i=e_{ji}\odot e_{ki}$, $i\notin\{j,k\}$, the pair block of $L_M$ is**
$$L\big|_{\{j,k\}}\;=\;\tfrac12\Big[\operatorname{diag}\big(M_{ji}+M_{ki}\big)-M_{jk}\,\mathrm{Id}+M^{(jk)}\Big]\;=\;-\tfrac12\Delta^{(jk)}-\tfrac12M_{jk}\,\mathrm{Id},$$
**where $M^{(jk)}$ is the hollow submatrix of $M$ on the indices other than $j,k$, and $\Delta^{(jk)}$ is the Kirchhoff matrix of *that deleted matrix*, $\operatorname{diag}(\text{its row sums})-M^{(jk)}$, with degrees $-(M_{ij}+M_{ik})$. The Ricci cut on this block is exactly $\sum_ix_i=0$, that matrix's own $\mathbf 1^\perp$.**


## Given 4, the sectional matrix's normalisation ([findings/conventions.md](../findings/conventions.md) line 157)

- **The letter $M$ carries two objects, and their norms differ by $\sqrt2$ ON THE DIAGONAL LOCUS AND BY LESS OFF IT.** $M$ (or $K$) is the $n\times n$ **sectional** matrix in [diagonal-half.md](../findings/diagonal-half.md), where $\lVert K\rVert_F^2=2$ at a unit Weyl tensor **that is coordinate-diagonal in the frame**, *and $\lVert K\rVert_F^2\le2$ otherwise.* **The right clause is that those entries EXHAUST $W$'s mass, not that they determine $W$**: $t=2\lVert\operatorname{diag}W\rVert^2\le2\lVert M\rVert_F^2$ with equality iff $M$ is diagonal in the pair basis. *Determination is refuted, $W\mapsto K$ lands in $\mathcal D_n$, so at $n=4$ ten dimensions map to two and the fibre is at least eight-dimensional, the equality case included.* **The unqualified reading is refuted by [L94](../findings/bispectral.md)'s own equality clause and by $\kappa^2(\mathbb{CP}^2)=1$**, *not by disagreeing with a numeral in this table, which would be circular.* Read at the sectional matrix, L94's bound reads $\kappa^2\le4$: **slack rather than false**, and the hazard is a silently weakened bound; $W$ is the operator on $\Lambda^2$, where $\sum_\alpha\lambda_\alpha^2=\operatorname{tr}(W^2)=1$. **On the diagonal locus the $\Lambda^2$ spectrum is the multiset of ENTRIES of $K$, not its eigenvalues**, so a statement about $\operatorname{spec}(K)$ transfers to $\Lambda^2$ through nothing at all. *Quoting $\sum\lambda^2=2$ for the operator against $\operatorname{tr}W^\#=-1$ produced [post F53](../findings/second-order.md) and cost a cycle; [r405](REVIEW_r405.md) and [r406](REVIEW_r406.md) both traced it here.*

## Given 5, post F67's constant ([findings/fence-posts.md](../findings/fence-posts.md) line 520)

**The proof, which needs no witness.** At the balanced product $W_0$, the orbit direction $\mathrm{ad}_{E_{kl}}W_0$ is an exact $\tfrac12$-eigenvector of $L_e$, which is [L24](../findings/second-order.md)'s sharpness clause, and it lies in $\mathcal D_n^\perp$ because $E_{kl}$ carries a nontrivial character of the sign group. Taking $d=W_0$ and $\nu$ that direction gives $\Lambda_n\ge\Theta_n/2$. Then with $u=\sqrt t$,

## The Lean declarations, docstrings removed ([L218.lean](../lean/HamiltonsCubic/Results/L218.lean), [L218Statement.lean](../lean/HamiltonsCubic/Results/L218Statement.lean))

```lean
import Mathlib

set_option linter.style.longLine false

namespace HamiltonsCubic.L218

open Finset

theorem fourset_disc_le {a b c d e f : ℝ} (h : a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2 + f ^ 2 ≤ 1) :
    (a + b) ^ 2 + (c + d) ^ 2 + (e + f) ^ 2 - (a + b) * (c + d) - (c + d) * (e + f) - (e + f) * (a + b) ≤ 3 := by
  nlinarith [sq_nonneg (a - b), sq_nonneg (c - d), sq_nonneg (e - f), sq_nonneg (a + b + c + d + e + f)]

theorem fourset_top_le {a b c d e f : ℝ} (h : a ^ 2 + b ^ 2 + c ^ 2 + d ^ 2 + e ^ 2 + f ^ 2 ≤ 1) :
    (1 / 2) * Real.sqrt ((a + b) ^ 2 + (c + d) ^ 2 + (e + f) ^ 2 - (a + b) * (c + d) - (c + d) * (e + f) - (e + f) * (a + b))
      ≤ Real.sqrt 3 / 2 := by
  have h1 := Real.sqrt_le_sqrt (fourset_disc_le h)
  linarith

theorem three_term_cs {p q r : ℝ} (h : p ^ 2 / 2 + q ^ 2 + r ^ 2 / 2 ≤ 1) : p + q + r ≤ Real.sqrt 5 := by
  have hsq : (p + q + r) ^ 2 ≤ 5 := by
    nlinarith [sq_nonneg (p - 2 * q), sq_nonneg (r - 2 * q), sq_nonneg (p - r)]
  calc p + q + r ≤ |p + q + r| := le_abs_self _
    _ = Real.sqrt ((p + q + r) ^ 2) := (Real.sqrt_sq_eq_abs _).symm
    _ ≤ Real.sqrt 5 := Real.sqrt_le_sqrt hsq

variable {ι : Type*} [Fintype ι]

theorem quad_le_frob (S : ι → ι → ℝ) (x : ι → ℝ) :
    ∑ i, ∑ l, S i l * x i * x l ≤ Real.sqrt (∑ i, ∑ l, S i l ^ 2) * ∑ i, x i ^ 2 := by
  have hcs := Finset.sum_mul_sq_le_sq_mul_sq (univ : Finset (ι × ι))
    (fun p => S p.1 p.2) (fun p => x p.1 * x p.2)
  simp only [← Finset.univ_product_univ, Finset.sum_product] at hcs
  have hxx : ∑ i, ∑ l, (x i * x l) ^ 2 = (∑ i, x i ^ 2) ^ 2 := by
    rw [sq, Finset.sum_mul_sum]
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => ?_
    ring
  have hlhs : ∑ i, ∑ l, S i l * (x i * x l) = ∑ i, ∑ l, S i l * x i * x l := by
    refine Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => ?_
    ring
  rw [hxx, hlhs] at hcs
  have hN : 0 ≤ ∑ i, x i ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
  have hF : 0 ≤ ∑ i, ∑ l, S i l ^ 2 := Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun l _ => sq_nonneg _
  set t := ∑ i, ∑ l, S i l * x i * x l
  calc t ≤ |t| := le_abs_self _
    _ = Real.sqrt (t ^ 2) := (Real.sqrt_sq_eq_abs _).symm
    _ ≤ Real.sqrt ((∑ i, ∑ l, S i l ^ 2) * (∑ i, x i ^ 2) ^ 2) := Real.sqrt_le_sqrt hcs
    _ = Real.sqrt (∑ i, ∑ l, S i l ^ 2) * ∑ i, x i ^ 2 := by
      rw [Real.sqrt_mul hF, Real.sqrt_sq hN]

theorem pair_block_rayleigh (d : ι → ℝ) (κ : ℝ) (S : ι → ι → ℝ) (x : ι → ℝ) {X Y Z : ℝ}
    (hX : 0 ≤ X) (hY : 0 ≤ Y) (hZ : 0 ≤ Z)
    (hd : ∀ i, d i ^ 2 ≤ 2 * X) (hS : ∑ i, ∑ l, S i l ^ 2 ≤ 2 * Y) (hκ : κ ^ 2 ≤ Z)
    (hsum : X + Y + Z ≤ 1) :
    ∑ i, d i * x i ^ 2 - κ * ∑ i, x i ^ 2 + ∑ i, ∑ l, S i l * x i * x l ≤ Real.sqrt 5 * ∑ i, x i ^ 2 := by
  have hN : 0 ≤ ∑ i, x i ^ 2 := Finset.sum_nonneg fun i _ => sq_nonneg _
  have hdi : ∀ i, d i ≤ Real.sqrt (2 * X) := fun i =>
    (le_abs_self _).trans ((Real.sqrt_sq_eq_abs _).symm ▸ Real.sqrt_le_sqrt (hd i))
  have hdiag : ∑ i, d i * x i ^ 2 ≤ Real.sqrt (2 * X) * ∑ i, x i ^ 2 := by
    rw [Finset.mul_sum]
    exact Finset.sum_le_sum fun i _ => mul_le_mul_of_nonneg_right (hdi i) (sq_nonneg _)
  have hk : -κ ≤ Real.sqrt Z :=
    (neg_le_abs κ).trans ((Real.sqrt_sq_eq_abs _).symm ▸ Real.sqrt_le_sqrt hκ)
  have hkap : -κ * ∑ i, x i ^ 2 ≤ Real.sqrt Z * ∑ i, x i ^ 2 := mul_le_mul_of_nonneg_right hk hN
  have hquad : ∑ i, ∑ l, S i l * x i * x l ≤ Real.sqrt (2 * Y) * ∑ i, x i ^ 2 :=
    (quad_le_frob S x).trans (mul_le_mul_of_nonneg_right (Real.sqrt_le_sqrt hS) hN)
  have hcs : Real.sqrt (2 * X) + Real.sqrt Z + Real.sqrt (2 * Y) ≤ Real.sqrt 5 := by
    apply three_term_cs
    rw [Real.sq_sqrt (by linarith), Real.sq_sqrt hZ, Real.sq_sqrt (by linarith)]
    linarith
  nlinarith [hdiag, hkap, hquad, mul_le_mul_of_nonneg_right hcs hN]

theorem theta_sq_gt_five_quarters {n : ℝ} (hn : 8 ≤ n) : (5 : ℝ) / 4 < 2 * (n - 1) * (n - 2) / n ^ 2 := by
  have hpos : 0 < n ^ 2 := by positivity
  rw [lt_div_iff₀ hpos]
  nlinarith

example : ((-2 : ℝ) + -2) ^ 2 + (1 + 1) ^ 2 + (1 + 1) ^ 2 - (-2 + -2) * (1 + 1) - (1 + 1) * (1 + 1) - (1 + 1) * (-2 + -2) = 3 * 12 := by
  norm_num

end HamiltonsCubic.L218
```

```lean
import Mathlib
import HamiltonsCubic.Results.L218

set_option linter.style.longLine false

namespace HamiltonsCubic.L218Statement

open Finset

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℝ E] {β : Type*}

theorem coupling_le_of_blocks (L : E →ₗ[ℝ] E) (s : Finset β) (n : β → E) (c : ℝ)
    (horth : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → inner ℝ (n i) (n j) = 0)
    (hcross : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → inner ℝ (L (n i)) (n j) = 0)
    (hblock : ∀ i ∈ s, inner ℝ (L (n i)) (n i) ≤ c * ‖n i‖ ^ 2) :
    inner ℝ (L (∑ i ∈ s, n i)) (∑ i ∈ s, n i) ≤ c * ‖∑ i ∈ s, n i‖ ^ 2 := by
  classical
  have hq : inner ℝ (L (∑ i ∈ s, n i)) (∑ i ∈ s, n i) = ∑ i ∈ s, inner ℝ (L (n i)) (n i) := by
    rw [map_sum, sum_inner]
    refine Finset.sum_congr rfl fun i hi => ?_
    rw [inner_sum]
    rw [Finset.sum_eq_single_of_mem i hi (fun j hj hji => hcross i hi j hj (Ne.symm hji))]
  have hn : ‖∑ i ∈ s, n i‖ ^ 2 = ∑ i ∈ s, ‖n i‖ ^ 2 := by
    rw [← real_inner_self_eq_norm_sq, sum_inner]
    refine Finset.sum_congr rfl fun i hi => ?_
    rw [inner_sum, Finset.sum_eq_single_of_mem i hi (fun j hj hji => horth i hi j hj (Ne.symm hji)),
      real_inner_self_eq_norm_sq]
  rw [hq, hn, Finset.mul_sum]
  exact Finset.sum_le_sum hblock

theorem coupling_le_sqrt5_half (L : E →ₗ[ℝ] E) (s : Finset β) (n : β → E)
    (horth : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → inner ℝ (n i) (n j) = 0)
    (hcross : ∀ i ∈ s, ∀ j ∈ s, i ≠ j → inner ℝ (L (n i)) (n j) = 0)
    (hblock : ∀ i ∈ s, inner ℝ (L (n i)) (n i) ≤ Real.sqrt 5 / 2 * ‖n i‖ ^ 2) :
    inner ℝ (L (∑ i ∈ s, n i)) (∑ i ∈ s, n i) ≤ Real.sqrt 5 / 2 * ‖∑ i ∈ s, n i‖ ^ 2 :=
  coupling_le_of_blocks L s n _ horth hcross hblock

example : inner ℝ ((LinearMap.id : ℝ →ₗ[ℝ] ℝ) (∑ i ∈ ({0} : Finset ℕ), (fun _ => (1 : ℝ)) i)) (∑ i ∈ ({0} : Finset ℕ), (fun _ => (1 : ℝ)) i)
    ≤ 1 * ‖∑ i ∈ ({0} : Finset ℕ), (fun _ => (1 : ℝ)) i‖ ^ 2 :=
  coupling_le_of_blocks LinearMap.id {0} (fun _ => (1 : ℝ)) 1
    (by intro i hi j hj hij; simp at hi hj; omega)
    (by intro i hi j hj hij; simp at hi hj; omega)
    (by intro i _; simp)

end HamiltonsCubic.L218Statement
```

**Which claims the kernel settles**: the four-set discriminant bound, the three-term Cauchy--Schwarz, the Frobenius bound on a quadratic form, the pair block's Rayleigh bound from its hypotheses, $\theta_0(n)^2>\tfrac54$ at $n\ge8$, and the convex-combination step from blocks to the whole. **Which it does not**: that $L_D$ on $\mathcal D_n^\perp\cap\mathcal W_n$ is exactly those blocks with exactly those matrices, the normalisation $\sum_{a<b}K_{ab}^2=1$, and the hypotheses $d_i^2\le2X$, $\lVert S\rVert_F^2\le2Y$, $X+Y+Z\le1$ as instantiated. Spend your attention there.

## What to attack

1. **The reduction to blocks**: that $\mathcal D_n^\perp\cap\mathcal W_n$ is exactly the orthogonal sum of the four-set and pair blocks, that $L_D$ preserves each at every unit diagonal $D$ with no criticality, and that the cross terms vanish.
2. **The four-set bound**: the identity $E=\tfrac32(A^2+B^2+C^2)-\tfrac12(A+B+C)^2$, that the six entries are distinct, and whether the block's basis normalisation in Given 2 matches the eigenvalue formula used.
3. **The pair bound**: Given 3's matrix, whether its basis of common norm $\sqrt2$ affects eigenvalues, whether the block acts on $\mathbf 1^\perp$ only, and each of the three estimates and the disjointness giving $X+Y+Z\le1$, including whether $\lVert S\rVert_F^2=2Y$ counts ordered entries.
4. **The normalisation**: Given 4's $\lVert K\rVert_F^2=2$ against $\sum_{a<b}K_{ab}^2=1$, at a unit coordinate-diagonal $D$.
5. **The lower bound** at padded $S^2\times S^2$: the entries, that it is a unit Weyl tensor, and $E=3$.
6. **Banach's theorem** as used: that $\langle L_DN,N\rangle=T(D,N,N)$ with $T$ the polarisation, and that $\Lambda_n>\Theta_n$ would refute Conjecture A.
7. **$\theta_0(n)^2>\tfrac54$ from $n=8$**, and whether odd $n$ with $\Theta_n$ needs stating.
8. **"Not a route input"** against Given 5.
9. **The range $n\ge5$**: whether the blocks exist and the bounds hold at $n=5,6,7$, and at $n=4$.
10. **Sharpness**: whether the pair bound can be improved by an argument the proof overlooks, and whether any claim in the block says more than the proof shows.

**Rules.** Argue from the definitions. No numerical work beyond the smallest check that refutes a claim, and say why an argument could not. Read no other file of the repository except the ones linked above for context, and no other reviewer's output.
