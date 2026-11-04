# Gate 2 brief, Lemma L222, the pair-block calculus

**Cold brief. Every passage is quoted verbatim from the record with its source. You are asked to break the result.** Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per claim.

## The claim under attack ([findings/second-order.md](../findings/second-order.md) lines 896 and 900-917)

#### Lemma L222, the pair-block calculus: $\nu\circ\nu$, the pinning, the swap parity and the rotation angle on $\mathcal D_n\oplus V_{jk}$

**Statement.** *Let $n\ge5$, $j\ne k$, and $\mathcal S_{jk}=\mathcal D_n\oplus V_{jk}$. Write $\nu\in V_{jk}$ as $\nu=\sum_ax_a\,e_{ja}\odot e_{ka}$ ($a\notin\{j,k\}$, $\sum x=0$, $\lVert\nu\rVert^2=2\lVert x\rVert^2$), $D\in\mathcal D_n$ with sectional matrix $K$, and let $\sigma$ swap $j$ and $k$ with $D=D^++D^-$ its even and odd parts, the odd part having entries $K_{ja}=-K_{ka}$. Let $\xi=E_{jk}$.*
1. *$\mathcal S_{jk}$ is a subalgebra, preserved by rotations in the $(j,k)$-plane.*
2. *$\nu\circ\nu=G_x$, the diagonal tensor with $K_{ja}=K_{ka}=x_a^2$, $K_{jk}=-\lVert x\rVert^2$, $K_{ab}=2x_ax_b$, and $\lVert G_x\rVert^2=3\lVert x\rVert^4$, so $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$.*
3. *If $W=D+\nu$ is a unit critical point with $\nu\ne0$, then $\langle D,\hat g\rangle=\theta/\sqrt3$ for $\hat g=G_x/\lVert G_x\rVert$, and $2L_{D^+}D^-=\theta D^-$.*
4. *On the odd part, identified with $\{y:\sum y=0\}$, $L_{G_x}$ acts as $y\mapsto\tfrac12\lVert x\rVert^2y+x\langle x,y\rangle$.*
5. *$\xi\cdot D\in V_{jk}$ with coordinates $K_{ja}-K_{ka}$, and $\xi\cdot\nu\in\mathcal D_n$ with $\lVert\xi\cdot\nu\rVert^2=4\lVert\nu\rVert^2$. At an angle of the $(j,k)$-rotation minimising $\lVert\nu\rVert^2$: $\langle x,K_{j\cdot}-K_{k\cdot}\rangle=0$, and $\lVert\nu\rVert^2\le\tfrac12\sum_a(K_{ka}-K_{ja})^2$.*
6. *At a unit diagonal critical point $D$ and unit $x\perp\mathbf1$, $\theta\langle K,G_x\rangle=\langle L_{G_x}D,D\rangle$.*

**Proof.**
1. The fixed space of $\ker(\varepsilon_j\varepsilon_k)$: a four-set character $\chi_Q$ is $-1$ on the flip at an index of $Q\setminus\{j,k\}$, a pair character $\varepsilon_a\varepsilon_b\ne\varepsilon_j\varepsilon_k$ on the flip at an index of $\{a,b\}\setminus\{j,k\}$ or on $\varepsilon_a\varepsilon_c$ with $c\notin\{a,b,j,k\}$. A rotation in the $(j,k)$-plane commutes with every flip outside $\{j,k\}$ and with $\varepsilon_j\varepsilon_k$.
2. $Q=W^2+W^\#$ with $(R^\#)_{ab,ab}=\sum_{c,c'}[R_{ac,ac'}R_{bc,bc'}-R_{ac,bc'}R_{bc,ac'}]$, which reduces to $(S^2)_{ab}$ on diagonal tensors. For $\nu$: $(\nu^2)_{ja,ja}=(\nu^2)_{ka,ka}=x_a^2$; $(\nu^\#)_{ab,ab}=2x_ax_b$ from $\{c,c'\}=\{j,k\}$; $(\nu^\#)_{jk,jk}=-\sum_ax_a^2$ from the second term at $c=c'=a$; every other diagonal entry vanishes, and the off-diagonal part vanishes by character. The norm over unordered pairs is $2\sum x^4+\lVert x\rVert^4+4\sum_{a<b}x_a^2x_b^2=3\lVert x\rVert^4$.
3. $V_{jk}$'s equation is $L_D\nu=\tfrac\theta2\nu$, and $\langle L_D\nu,\nu\rangle=\langle D,\nu\circ\nu\rangle$, so $\langle D,G_x\rangle=\tfrac\theta2\lVert\nu\rVert^2$; divide by $\lVert G_x\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$. The $\mathcal D_n$ equation is $D\circ D+G_x=\theta D$, $G_x$ is swap-even, and $(D\circ D)^-=2D^+\circ D^-$.
4. With the diagonal product $(A\circ B)_{ab}=A_{ab}B_{ab}+\tfrac12\sum_c(A_{ac}B_{cb}+B_{ac}A_{cb})$ and $Y_{ja}=y_a$, $Y_{ka}=-y_a$: $(G\circ Y)_{ja}=x_a^2y_a+\tfrac12\big(\lVert x\rVert^2y_a+2x_a(\langle x,y\rangle-x_ay_a)\big)=\tfrac12\lVert x\rVert^2y_a+x_a\langle x,y\rangle$, and the even part of $G\circ Y$ vanishes.
5. $\Lambda^2\xi$ sends $e_{ja}\mapsto e_{ka}$, $e_{ka}\mapsto-e_{ja}$, and $\xi\cdot W=[\Lambda^2\xi,W]$. For diagonal $D$ the commutator has entries $K_{ja}-K_{ka}$ at $(ja,ka)$ and $(ka,ja)$. For $\nu$ it is diagonal with $\mp2x_a$ at $(ja),(ka)$, norm$^2$ $8\lVert x\rVert^2$. Along $e^{\varphi\xi}$ the $V_{jk}$-part is $\nu+\varphi\,\xi\cdot D+\tfrac{\varphi^2}2\xi^2\cdot\nu+O(\varphi^3)$, so $\lVert\nu(\varphi)\rVert^2=\lVert\nu\rVert^2+2\varphi\langle\nu,\xi\cdot D\rangle+\varphi^2(\lVert\xi\cdot D\rVert^2-\lVert\xi\cdot\nu\rVert^2)+O(\varphi^3)$, and a minimum gives both conditions.
6. Pair $Q(D)=\theta D$ with $G_x$ and use total symmetry: $\theta\langle D,G_x\rangle=\langle D\circ D,G_x\rangle=\langle L_{G_x}D,D\rangle$. $\square$

**What it gives.** *The pair-block stratum of the far region reduces, with these identities, to one open inequality: at every diagonal critical point above $\sqrt{3/2}$, the pair-block form off the orbit direction is at most $\theta-2\gamma$, which item 6 and item 4 turn into a bound on the even form of $L_{G_x}$ at $D^+$ ([note](2026-09-14-I104-pair-block.md)).* **No screen is cited as evidence for that inequality.**

## Given 1, Lemma L120's statement ([findings/second-order.md](../findings/second-order.md) lines 624-631)

#### Lemma L120, $L_M$ is block-diagonal over the sign characters at every diagonal critical point

**Let $\Gamma=\{\mathop{\mathrm{diag}}(\varepsilon_1,\dots,\varepsilon_n):\varepsilon_i=\pm1\}\subset O(n)$ be the full diagonal sign group. Then $\mathcal W_n$ decomposes as**
$$\mathcal W_n=\underbrace{\mathcal D_n}_{n(n-3)/2}\ \oplus\ \bigoplus_{\{i,j,k,l\}}\underbrace{V_{ijkl}}_{2}\ \oplus\ \bigoplus_{\{j,k\}}\underbrace{V_{jk}}_{n-3},$$
**and at every diagonal $M$, **criticality is unused; $\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed**, the operator $L_M$ preserves each summand. Hence the Hessian of $P$ on the sphere is block-diagonal in the same way, and [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement)'s criterion is checkable block by block **once $\mathcal D_n$ is cut by $\langle M\rangle$**; the largest block a non-diagonal direction occupies has size $\max(2,n-3)$, and $\binom n4$ of them have size $2$.

> **THE CUT IS NOT OPTIONAL, AND THE SENTENCE ABOVE IS THE ONE EVERY CITATION QUOTES.** $e=M/\theta$ lies in $\mathcal D_n$ and $L_ee=e$, so read without it the criterion gives $\lambda_{\max}(L_e\vert_{\mathcal D_n})\ge1>\tfrac12$ and **no diagonal critical point is a maximiser, vacuously**, the balanced sphere product included. **$W^\perp$ cuts $\mathcal D_n$ and nothing else**, since $M$ spans the trivial character and every other summand lies wholly inside $W^\perp$ by isotypic orthogonality. *And the block size fails at $n=4$ as first printed, where the four-set block is $2$ against $n-3=1$.* *Gate 2, [r507](REVIEW_r507.md) and [r508](REVIEW_r508.md) on identical briefs, both CONFIRMED and agreeing on every repair.***


## Given 2, the conventions: $Q(W)=W^2+W^\#$, the diagonal product and the norms

On the diagonal locus a unit Weyl tensor has sectional matrix $K$ with $\sum_{a<b}K_{ab}^2=1$, and the product of two diagonal tensors has sectional matrix $(A\circ B)_{ab}=A_{ab}B_{ab}+\tfrac12\sum_c(A_{ac}B_{cb}+B_{ac}A_{cb})$ ([references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md](../references/deninger-grundhoefer-kramer-2023-srg-quadratic/notes.md), §2.6). $Q$ maps $\mathcal W_n$ into itself ([findings/curvature-invariants.md](../findings/curvature-invariants.md), Lemma L209). The norm on symmetric operators on $\Lambda^2$ is the Frobenius norm over all entries.

## The Lean declarations, docstrings removed ([L222Statement.lean](../lean/HamiltonsCubic/Results/L222Statement.lean))

```lean
import Mathlib

set_option linter.style.longLine false

namespace HamiltonsCubic.L222Statement

open Finset

variable {ι : Type*} [Fintype ι]

theorem G_rows_zero_outer [DecidableEq ι] (x : ι → ℝ) (hx : ∑ i, x i = 0) (a : ι) :
    2 * x a ^ 2 + ∑ b ∈ univ.erase a, 2 * x a * x b = 0 := by
  have h : ∑ b ∈ univ.erase a, x b = -x a := by
    have := Finset.add_sum_erase univ x (mem_univ a)
    linarith
  rw [← Finset.mul_sum, h]
  ring

theorem G_rows_zero_jk (x : ι → ℝ) : ∑ a, x a ^ 2 - ∑ a, x a ^ 2 = 0 := sub_self _

theorem G_norm_sq (x : ι → ℝ) :
    2 * ∑ a, x a ^ 4 + (∑ a, x a ^ 2) ^ 2 + (∑ a, ∑ b, 2 * x a ^ 2 * x b ^ 2 - ∑ a, 2 * x a ^ 4)
      = 3 * (∑ a, x a ^ 2) ^ 2 := by
  have hsq : (∑ a, x a ^ 2) ^ 2 = ∑ a, ∑ b, x a ^ 2 * x b ^ 2 := by
    rw [sq, Finset.sum_mul_sum]
  have h : ∑ a, ∑ b, 2 * x a ^ 2 * x b ^ 2 = 2 * (∑ a, x a ^ 2) ^ 2 := by
    rw [hsq, Finset.mul_sum]
    refine Finset.sum_congr rfl fun a _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun b _ => ?_
    ring
  have h4 : ∑ a, 2 * x a ^ 4 = 2 * ∑ a, x a ^ 4 := by rw [Finset.mul_sum]
  rw [h, h4]
  ring

theorem odd_action_on_x (x : ι → ℝ) (i : ι) :
    (1 / 2) * (∑ a, x a ^ 2) * x i + x i * (∑ a, x a * x a) = (3 / 2) * (∑ a, x a ^ 2) * x i := by
  have : ∑ a, x a * x a = ∑ a, x a ^ 2 := Finset.sum_congr rfl fun a _ => by ring
  rw [this]
  ring

theorem odd_action_perp (x y : ι → ℝ) (h : ∑ a, x a * y a = 0) (i : ι) :
    (1 / 2) * (∑ a, x a ^ 2) * y i + x i * (∑ a, x a * y a) = (1 / 2) * (∑ a, x a ^ 2) * y i := by
  rw [h]
  ring

theorem pinning (θ N Dg s : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s) (hN : 0 < N) (hDg : Dg = θ / 2 * N) :
    Dg / (s / 2 * N) = θ / s := by
  rw [hDg]
  field_simp

theorem pair_mass_le (A N XD XN : ℝ) (hXD : XD = 2 * A) (hXN : XN = 4 * N) (h : XN ≤ XD) : N ≤ A / 2 := by
  subst hXD hXN
  linarith

example : (1 : ℝ) ≤ 2 / 2 := pair_mass_le 2 1 4 4 (by norm_num) (by norm_num) le_rfl

end HamiltonsCubic.L222Statement
```

**Which claims the kernel settles**: the zero row sums and norm of $G_x$ as polynomial identities, the odd action's two eigenvalues as algebra, the pinning's division, and the pair-mass inequality from its two constants. **Which it does not**: the subalgebra and the rotation's preservation of it (item 1), $\nu\circ\nu=G_x$ from the sharp product (item 2, including the sign convention of the sharp product and every vanishing entry), the two critical equations (item 3), the odd action from the diagonal product (item 4), both commutators, the expansion of $\lVert\nu(\varphi)\rVert^2$ and the constants (item 5), and item 6's pairing. Spend your attention there.

## What to attack

1. **Item 1**: every character witness, and that a $(j,k)$-rotation preserves the fixed space.
2. **Item 2**: the sharp product's diagonal-entry formula and its sign convention against the diagonal case, each entry of $\nu^2$ and $\nu^\#$, the vanishing of the off-diagonal part, and the norm count over unordered pairs.
3. **Item 3**: the pinning's use of $\langle L_D\nu,\nu\rangle=\langle D,\nu\circ\nu\rangle$, and the odd equation's derivation from the swap parity.
4. **Item 4**: the computation of $(G\circ Y)_{ja}$, the vanishing even part, and the identification of the odd part with $\{y:\sum y=0\}$.
5. **Item 5**: the action of $\Lambda^2\xi$, both commutators, that $\xi^2$ preserves each summand, the second-order expansion and its sign $\langle\nu,\xi^2\cdot\nu\rangle=-\lVert\xi\cdot\nu\rVert^2$, and both consequences at a minimum.
6. **Item 6**: the pairing and the symmetry used.
7. **Scope**: $n\ge5$, any hypothesis used and unstated, whether the "What it gives" paragraph claims more than the items, and prior art in [findings/](../findings/) (for instance in Lemma L122's block, which Given 1 names).

**Rules.** Argue from the definitions. No numerical work beyond the smallest check that refutes a claim, and say why an argument could not. Read no other file of the repository except the ones linked above for context, and no other reviewer's output. Analysis only.
