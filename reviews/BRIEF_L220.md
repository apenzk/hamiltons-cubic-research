# Gate 2 brief, Lemma L220, the diagonal theorem on a four-set subalgebra

**Cold brief. Every passage is quoted verbatim from the record with its source. You are asked to break the result.** Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per claim.

## The claim under attack ([findings/second-order.md](../findings/second-order.md) lines 847 and 851-872)

#### Lemma L220, the diagonal theorem on a four-set subalgebra: a critical point with a four-set component has $\theta\le\sqrt{3/2}$

**Statement.** *Let $n\ge5$, $Q=\{i,j,k,l\}$, $V_Q$ the four-set block of character $\chi_Q$ and $\mathcal S_Q=\mathcal D_n\oplus V_Q$. Every unit critical point $W=D+\nu$ of $P$ in $\mathcal S_Q$ with $\nu\in V_Q$, $\nu\ne0$ and $\theta>0$ has*
$$\theta\le\sqrt{3/2},$$
*with equality exactly at padded $W_{\mathbb{CP}^2}$ on $Q$. Hence at $n\ge12$, $\sup P=\Theta_n$ on the unit sphere of $\mathcal S_Q$, attained only on $\mathcal D_n$.*

**Setting.** $\Pi_Q\subset\mathcal D_n$ is the plane of sectional matrices supported on $Q$, $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$ with $x+y+z=0$, unit when $2(x^2+y^2+z^2)=1$. Write $D=q+r$ with $q\in\Pi_Q$, $r\in\mathcal D_n\ominus\Pi_Q$, and in the pairing basis of $V_Q$ with signed coordinates $\nu=a\,e_{ij}\odot e_{kl}+b\,e_{ik}\odot e_{jl}+c\,e_{il}\odot e_{jk}$, $a+b+c=0$.

**Proof.**

1. **$\mathcal S_Q$ is a subalgebra and its maximum is critical.** $\mathcal S_Q$ is the fixed space of $\ker\chi_Q\subset\Gamma$, since the only characters of [L120](../findings/second-order.md#lemma-l120-l_m-is-block-diagonal-over-the-sign-characters-at-every-diagonal-critical-point)'s decomposition trivial on $\ker\chi_Q$ are $1$ and $\chi_Q$ (at $n\ge9$ by a flip outside $Q\cup Q'$, and at every $n\ge5$ for the pair characters). A fixed space of automorphisms is a subalgebra, so the maximum of $P$ on its unit sphere satisfies $Q(W)=\theta W$ in $\mathcal W_n$. *Where the maximiser has $\nu=0$ it is diagonal and [L57](../findings/problem.md) bounds it by $\Theta_n$.*
2. **Three products.** $\Pi_Q$ is a subalgebra of $\mathcal D_n$, since a hollow matrix supported on $Q$ with zero row sums has $S^{\circ2}+S^2$ supported on $Q$ off the diagonal with zero row sums. $\nu\circ\nu\in\Pi_Q$, with $x=2a^2-b^2-c^2$ and cyclically: in $(\nu\#\nu)_{\alpha\alpha}$ a pair $\alpha$ leaving $Q$ forces a factor of $\nu$ outside its support, and the pattern follows from the pairs sharing an index. And $D\circ\nu\in V_Q$ by L120.
3. **Split the equation.** $Q(W)=D\circ D+2D\circ\nu+\nu\circ\nu$, so $D\circ D+\nu\circ\nu=\theta D$ and $L_D\nu=\tfrac\theta2\nu$.
4. **$L_r\nu=0$.** $L_r\nu\in V_Q$, and $\langle L_r\nu,\nu'\rangle=\langle r,\nu\circ\nu'\rangle=0$ for $\nu'\in V_Q$, as $\nu\circ\nu'\in\Pi_Q\perp r$. So $L_q\nu=\tfrac\theta2\nu$.
5. **The eigenvalue fixes $\lVert q\rVert$.** By [L121](../findings/second-order.md#lemma-l121-the-4-set-block-its-spectrum-and-one-necessary-condition-per-4-subset) $L_q$ on $V_Q$ has eigenvalues $\pm\tfrac12\sqrt E$ with $A=2x$, $B=2y$, $C=2z$, so $E=4(x^2+y^2+z^2-xy-yz-zx)=6(x^2+y^2+z^2)=3\lVert q\rVert^2$, using $xy+yz+zx=-\tfrac12(x^2+y^2+z^2)$. With $\theta>0$ and $\nu\ne0$, $\lVert q\rVert^2=\theta^2/3$.
6. **Pair the $\mathcal D_n$ equation with $q$.** $\langle q\circ r,q\rangle=\langle r,q\circ q\rangle=0$, $\langle r\circ r,q\rangle=\langle L_qr,r\rangle=:\kappa$, and $\langle\nu\circ\nu,q\rangle=\langle L_q\nu,\nu\rangle=\tfrac\theta2\lVert\nu\rVert^2$, so $P(q)+\kappa+\tfrac\theta2\lVert\nu\rVert^2=\tfrac{\theta^3}3$.
7. **$P$ on $\Pi_Q$.** $P(q)=\sum_{a<b}K_{ab}^3+3\sum_{\text{triangles}}K_{ab}K_{bc}K_{ca}=2(x^3+y^3+z^3)+12xyz=18xyz$, and $x+y+z=0$ gives $(x^2+y^2+z^2)^3\ge54x^2y^2z^2$, so $P(q)\le\tfrac{\sqrt3}2\lVert q\rVert^3=\tfrac{\theta^3}6$, equality at the $S^2\times S^2$ shape.
8. **The coupling.** For unit $\hat q=(x,y,z)$ and $r\perp\Pi_Q$, split $r$ into its $Q$-internal entries $p,p',a',b',c',d'$ on the pairs $ij,kl,ik,jl,il,jk$, its columns $c_m=(r_{am})_{a\in Q}$ for $m\notin Q$, and the rest. Then $2\langle L_{\hat q}r,r\rangle=2[x(p^2+p'^2)+y(a'^2+b'^2)+z(c'^2+d'^2)]+2\Sigma+\sum_mc_m^{\mathsf T}\hat qc_m$ with $\Sigma=z(p+p')(a'+b')+y(p+p')(c'+d')+x(a'+b')(c'+d')$, the entries outside $Q$'s rows not entering. Orthogonality to $\Pi_Q$ is $p+p'=a'+b'=c'+d'=:s$, so $\Sigma=s^2(x+y+z)=0$, and $\hat q$ has spectrum $\{0,2x,2y,2z\}$ on $\mathbb R^Q$. So $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2\le\tfrac1{\sqrt3}\lVert q\rVert\lVert r\rVert^2=\tfrac\theta3\lVert r\rVert^2$.
9. **Arithmetic.** Steps 6 to 8 give $\tfrac{\theta^3}6-\tfrac\theta2\lVert\nu\rVert^2\le\tfrac\theta3\lVert r\rVert^2$. With $\lVert r\rVert^2=1-\tfrac{\theta^2}3-\lVert\nu\rVert^2$ this is $\tfrac5{18}\theta^2\le\tfrac13+\tfrac16\lVert\nu\rVert^2$, and $\lVert\nu\rVert^2\le1-\tfrac{\theta^2}3$ gives $\theta^2\le\tfrac32$. Equality forces $r=0$, $\lVert\nu\rVert^2=\tfrac12$ and the $S^2\times S^2$ shape, which is padded $W_{\mathbb{CP}^2}$. $\square$

**What it gives.** *It closes [I101](../plan.md) and inequality (J): no global maximiser at $n\ge12$ has its off-diagonal part, in any frame, inside a single four-set block.* **The lever is step 5**: the eigenvalue condition of the critical point pins $\lVert q\rVert$ to $\theta/\sqrt3$, so both bounds of steps 7 and 8 become functions of $\theta$ with their equality at the same point, and nothing is bounded at two different vectors, which is what [post F67](../findings/fence-posts.md) forbids. *Four whole-sphere attempts failed where this critical-point argument closes.*

**Gate 1** (screen). *Ascent restricted to $\mathcal S_Q$, 60 starts each at $n=8$ and $n=12$: every converged critical point with $\nu\ne0$ sits at $\theta=1.224745=\sqrt{3/2}$ with $\lVert\nu\rVert^2=0.5000$, and every other has $\nu=0$ ($\Theta_{12}$, $S^5\times S^7$ and lower at $n=12$). The whole-sphere screen of (J) found its extreme at the same point.*

## Given 1, Lemma L120's statement, the block decomposition ([findings/second-order.md](../findings/second-order.md) lines 624-631)

#### Lemma L120, $L_M$ is block-diagonal over the sign characters at every diagonal critical point

**Let $\Gamma=\{\mathop{\mathrm{diag}}(\varepsilon_1,\dots,\varepsilon_n):\varepsilon_i=\pm1\}\subset O(n)$ be the full diagonal sign group. Then $\mathcal W_n$ decomposes as**
$$\mathcal W_n=\underbrace{\mathcal D_n}_{n(n-3)/2}\ \oplus\ \bigoplus_{\{i,j,k,l\}}\underbrace{V_{ijkl}}_{2}\ \oplus\ \bigoplus_{\{j,k\}}\underbrace{V_{jk}}_{n-3},$$
**and at every diagonal $M$, **criticality is unused; $\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed**, the operator $L_M$ preserves each summand. Hence the Hessian of $P$ on the sphere is block-diagonal in the same way, and [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement)'s criterion is checkable block by block **once $\mathcal D_n$ is cut by $\langle M\rangle$**; the largest block a non-diagonal direction occupies has size $\max(2,n-3)$, and $\binom n4$ of them have size $2$.

> **THE CUT IS NOT OPTIONAL, AND THE SENTENCE ABOVE IS THE ONE EVERY CITATION QUOTES.** $e=M/\theta$ lies in $\mathcal D_n$ and $L_ee=e$, so read without it the criterion gives $\lambda_{\max}(L_e\vert_{\mathcal D_n})\ge1>\tfrac12$ and **no diagonal critical point is a maximiser, vacuously**, the balanced sphere product included. **$W^\perp$ cuts $\mathcal D_n$ and nothing else**, since $M$ spans the trivial character and every other summand lies wholly inside $W^\perp$ by isotypic orthogonality. *And the block size fails at $n=4$ as first printed, where the four-set block is $2$ against $n-3=1$.* *Gate 2, [r507](REVIEW_r507.md) and [r508](REVIEW_r508.md) on identical briefs, both CONFIRMED and agreeing on every repair.***


## Given 2, Lemma L121's statement, the four-set block ([findings/second-order.md](../findings/second-order.md) lines 640-645)

#### Lemma L121, the $4$-set block, its spectrum, and one necessary condition per $4$-subset

**Fix a **pair-diagonal** $M$ and a $4$-subset $\{i,j,k,l\}$, the block and its spectrum need diagonality alone, with no criticality and no row sum entering, which is what makes them applicable to $\mathop{\mathrm{diag}}(M)$ in a frame where $W$ is not diagonal. **The necessary condition below is the part that needs a maximiser**, through [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement). Let $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$ be the three opposite-pair sums. Then in signed coordinates $L_M$ restricted to the $4$-set space is $\tfrac12G$ with $G=\begin{pmatrix}A&C&B\\C&B&A\\B&A&C\end{pmatrix}$; **the Bianchi subspace is $\mathbf 1^\perp$** because $\hat a+\hat b+\hat c=0$ in these signed coordinates, and $G\mathbf 1=(A+B+C)\mathbf 1$ then makes that subspace **invariant**, two joints, not one. **The restriction to $\mathbf 1^\perp$ is traceless**; $\tfrac12G$ itself is not, its trace being $\tfrac12(A+B+C)$. Spectrum**
$$\pm\tfrac12\sqrt{A^2+B^2+C^2-AB-BC-CA}\;=\;\pm\tfrac12\sqrt{\tfrac12\big[(A-B)^2+(B-C)^2+(C-A)^2\big]}.$$

**The list is complete, not short a root.** $G$'s third eigenvalue is $A+B+C$ on the vector $\mathbf 1$, and first Bianchi is exactly $\mathbf 1^\perp$ in these signed coordinates, so that root is removed rather than missing. *And $G$ is symmetric: it is the Latin square with diagonal $(A,B,C)$ whose off-diagonal $(m,m')$ entry is the third letter, so $G_{12}=C=G_{21}$ and likewise for the other two. The signed coordinates are load-bearing, the raw block is $\mathop{\mathrm{diag}}(1,-1,1)$-conjugate to it, and that same flip turns Bianchi's $x_1-x_2+x_3=0$ into $y_1+y_2+y_3=0$.* *Gate 2, [r531](REVIEW_r531.md) and [r532](REVIEW_r532.md) on identical briefs, both CONFIRMED.*

## Given 3, Lemma L57's statement, the diagonal theorem ([findings/problem.md](../findings/problem.md) lines 646-649)

Let $\mathcal D_n=\{S\ \text{symmetric, hollow},\ S\mathbf1=0\}$ be the vertex matrices of coordinate-diagonal Weyl operators. Then
\[
\langle Q(W),W\rangle\;\le\;\Theta_n\,\|W\|^3\qquad\text{for every diagonal }W\text{ at every }n\ge4,
\]

## Given 4, the unit normalisation

On the diagonal locus a unit Weyl tensor has sectional matrix $K$ with $\sum_{a<b}K_{ab}^2=1$, and $P(d)=\sum_{a<b}K_{ab}^3+3\sum_{a<b<c}K_{ab}K_{bc}K_{ca}$ for diagonal $d$ ([findings/conventions.md](../findings/conventions.md), and [scripts/runs/screen_J_fourset.py](../scripts/runs/screen_J_fourset.py), whose controls reproduce $\Theta_n$ at the balanced product and $\sqrt3/2$ at padded $S^2\times S^2$). $Q(\mathcal W_n)\subseteq\mathcal W_n$ ([findings/curvature-invariants.md](../findings/curvature-invariants.md), Lemma L209).

## The Lean declarations, docstrings removed ([L220Statement.lean](../lean/HamiltonsCubic/Results/L220Statement.lean))

```lean
import Mathlib

set_option linter.style.longLine false

namespace HamiltonsCubic.L220Statement

theorem theta_sq_le (θ a R N p κ : ℝ) (hθ : 0 < θ) (hR : 0 ≤ R) (hN : 0 ≤ N)
    (hunit : a + R + N = 1) (ha : 3 * a = θ ^ 2) (hpair : p + κ + θ * N / 2 = θ * a)
    (hp : 6 * p ≤ θ ^ 3) (hκ : 3 * κ ≤ θ * R) :
    θ ^ 2 ≤ 3 / 2 := by
  -- θ³/6 - θN/2 ≤ κ ≤ θR/3, then divide by θ
  have h1 : θ ^ 3 / 6 - θ * N / 2 ≤ θ * R / 3 := by nlinarith
  have h2 : θ ^ 2 / 6 - N / 2 ≤ R / 3 := by
    have := h1
    have hθ' : θ * (θ ^ 2 / 6 - N / 2) ≤ θ * (R / 3) := by nlinarith
    exact le_of_mul_le_mul_left hθ' hθ
  nlinarith

theorem equality_case (θ a R N p κ : ℝ) (hθ : 0 < θ) (hR : 0 ≤ R) (hN : 0 ≤ N)
    (hunit : a + R + N = 1) (ha : 3 * a = θ ^ 2) (hpair : p + κ + θ * N / 2 = θ * a)
    (hp : 6 * p ≤ θ ^ 3) (hκ : 3 * κ ≤ θ * R) (heq : θ ^ 2 = 3 / 2) :
    R = 0 ∧ N = 1 / 2 := by
  have h1 : θ ^ 3 / 6 - θ * N / 2 ≤ θ * R / 3 := by nlinarith
  have h2 : θ ^ 2 / 6 - N / 2 ≤ R / 3 := by
    have hθ' : θ * (θ ^ 2 / 6 - N / 2) ≤ θ * (R / 3) := by nlinarith
    exact le_of_mul_le_mul_left hθ' hθ
  have hR0 : R = 0 := by nlinarith
  refine ⟨hR0, ?_⟩
  nlinarith

theorem pattern_cubic_sq_le (x y z : ℝ) (h : x + y + z = 0) :
    (18 * x * y * z) ^ 2 ≤ 3 / 4 * (2 * (x ^ 2 + y ^ 2 + z ^ 2)) ^ 3 := by
  have hz : z = -x - y := by linarith
  subst hz
  nlinarith [sq_nonneg ((x - y) * (2 * x + y) * (x + 2 * y)), sq_nonneg (x * y), sq_nonneg (x + y),
    sq_nonneg (x - y), mul_self_nonneg (x ^ 2 + x * y + y ^ 2)]

theorem internal_cross_zero (x y z p p' a b c d s : ℝ) (h : x + y + z = 0)
    (h1 : p + p' = s) (h2 : a + b = s) (h3 : c + d = s) :
    z * (p + p') * (a + b) + y * (p + p') * (c + d) + x * (a + b) * (c + d) = 0 := by
  rw [h1, h2, h3]
  linear_combination s ^ 2 * h

theorem pattern_entry_sq_le (x y z : ℝ) (h : x + y + z = 0) : 3 * x ^ 2 ≤ 2 * (x ^ 2 + y ^ 2 + z ^ 2) := by
  have hz : z = -x - y := by linarith
  subst hz
  nlinarith [sq_nonneg (x + 2 * y)]

example : (Real.sqrt (3 / 2)) ^ 2 ≤ 3 / 2 := by
  have hs : Real.sqrt (3 / 2) ^ 2 = 3 / 2 := Real.sq_sqrt (by norm_num)
  have hpos : 0 < Real.sqrt (3 / 2) := Real.sqrt_pos.mpr (by norm_num)
  exact theta_sq_le (Real.sqrt (3 / 2)) (1 / 2) 0 (1 / 2) (Real.sqrt (3 / 2) ^ 3 / 6) 0 hpos le_rfl (by norm_num)
    (by norm_num) (by rw [hs]; norm_num) (by nlinarith [hs]) (by nlinarith) (by simp)

end HamiltonsCubic.L220Statement
```

**Which claims the kernel settles**: the arithmetic of step 9 from its five scalar hypotheses and the equality case, step 7's inequality $(18xyz)^2\le\tfrac34(2\sum x^2)^3$ on $x+y+z=0$, step 8's vanishing cross term, and $3x^2\le2\sum x^2$. **Which it does not**: that $\mathcal S_Q$ is a subalgebra (step 1), the three products of step 2 including $\nu\circ\nu\in\Pi_Q$, $L_r\nu=0$ (step 4), $E=3\lVert q\rVert^2$ and the eigenvalue step (step 5), the pairing of step 6, $P(q)=18xyz$ (step 7), the decomposition of $2\langle L_{\hat q}r,r\rangle$ and the column bound (step 8), and the equality case being padded $W_{\mathbb{CP}^2}$. Spend your attention there.

## What to attack

1. **Step 1**: the characters trivial on $\ker\chi_Q$ at every $n\ge5$, including $5\le n\le8$ where no flip outside $Q\cup Q'$ exists, and whether the maximum on $\mathcal S_Q$ is critical on $\mathcal W_n$.
2. **Step 2**: $\Pi_Q$ closed under the product, and $\nu\circ\nu\in\Pi_Q$ with the stated pattern (derive $(\nu\#\nu)$ on the pairs of $Q$).
3. **Steps 3 and 4**: the parity split of the critical equation and $L_r\nu=0$.
4. **Step 5**: L121's eigenvalues applied to $q$ in the normalisation of Given 4, $E=3\lVert q\rVert^2$, and whether $\tfrac\theta2$ must be the positive eigenvalue.
5. **Step 6**: each pairing and each symmetry used.
6. **Step 7**: $P(q)=18xyz$ from Given 4's formula, and the direction of the inequality.
7. **Step 8**: the decomposition of the form into internal entries, columns and the rest, the claim that entries outside $Q$'s rows do not enter, the vanishing of $\Sigma$, the spectrum of $\hat q$ on $\mathbb R^Q$, and $\max(x,y,z)\le1/\sqrt3$.
8. **Step 9 and the equality case**, and the conclusion $\sup P=\Theta_n$ on $\mathcal S_Q$ at $n\ge12$, including $n=12$ where $\Theta_{12}-\sqrt{3/2}=0.0113$.
9. **Scope**: any hypothesis used and unstated, any claim beyond the proof, whether the result is on the record under another name (search [findings/](../findings/) by the object), and whether "no global maximiser has its off-diagonal part inside a single four-set block, in any frame" follows.

**Rules.** Argue from the definitions. No numerical work beyond the smallest check that refutes a claim, and say why an argument could not. Read no other file of the repository except the ones linked above for context, and no other reviewer's output. Analysis only: a screen of seconds on an object you construct is allowed and reported as a screen, never as evidence for a positive claim.
