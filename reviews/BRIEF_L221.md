# Gate 2 brief, Lemma L221, L220 on several four-set blocks

**Cold brief. Every passage is quoted verbatim from the record with its source. You are asked to break the result.** Verdicts: CONFIRMED, PLAUSIBLE or REFUTED with corrections, per claim.

## The claim under attack ([findings/second-order.md](../findings/second-order.md) lines 875 and 879-895)

#### Lemma L221, L220 on several four-set blocks: disjoint families, and two four-sets sharing two indices

**Statement.** *Let $n\ge6$ and $\theta>0$.*
- **(a) Disjoint families.** *If $Q_1,\dots,Q_m$ are pairwise disjoint four-sets, every unit critical point of $P$ in $\mathcal D_n\oplus V_{Q_1}\oplus\cdots\oplus V_{Q_m}$ with some nonzero block component has $\theta\le\sqrt{3/2}$.*
- **(b) Two four-sets sharing two indices.** *If $\lvert Q_1\cap Q_2\rvert=2$ and $Q_3=Q_1\triangle Q_2$, every unit critical point $W=D+\nu_1+\nu_2+\nu_3$ of $P$ in $\mathcal S=\mathcal D_n\oplus V_{Q_1}\oplus V_{Q_2}\oplus V_{Q_3}$ with at least two nonzero $\nu_i$ and $\tau=\langle\nu_1\circ\nu_2,\nu_3\rangle\le0$ has $\theta^2\le\tfrac65$.* (If $\nu_3=0$, then $\tau=0$.)

**Proof of (a).** The characters of L120's decomposition trivial on $\bigcap_i\ker\chi_{Q_i}$ are $1$ and the $\chi_{Q_i}$: a four-set character $\chi_{Q'}$ with $Q'$ not among the $Q_i$ is $-1$ on the flip at an index of $Q'$ outside $\bigcup_iQ_i$ when there is one, and otherwise on $\varepsilon_a\varepsilon_b$ with $a\in Q'\cap Q_i$, $b\in Q_i\setminus Q'$ for an $i$ with $Q'\cap Q_i$ a proper nonempty subset, a pair character $\varepsilon_a\varepsilon_b$ is $-1$ on the flip at $a$ when $a\notin\bigcup_iQ_i$ and on $\varepsilon_a\varepsilon_c$ with $c\in Q_i\setminus\{a,b\}$ when $a\in Q_i$, every such flip lying in each $\ker\chi_{Q_j}$, and $\chi_{Q_i}\chi_{Q_j}$ for $i\ne j$ is the character of an eight-element set, which no block carries. So the space is a subalgebra, $\nu_i\circ\nu_j=0$ for $i\ne j$, and $\nu_i\circ\nu_i\in\Pi_{Q_i}$. Fix $i$ with $\nu_i\ne0$, write $D=q_i+r_i$ with $r_i\perp\Pi_{Q_i}$, and run L220's steps 3 to 9 for the block $V_{Q_i}$: step 4 holds as $\langle r_i\circ\nu_i,\nu'\rangle=\langle r_i,\nu_i\circ\nu'\rangle=0$, step 6 gains the terms $\langle\nu_j\circ\nu_j,q_i\rangle$ for $j\ne i$, which vanish since $\Pi_{Q_j}\perp\Pi_{Q_i}$ by disjoint support, and step 9 runs with $\lVert r_i\rVert^2=1-\tfrac{\theta^2}3-\sum_j\lVert\nu_j\rVert^2\le1-\tfrac{\theta^2}3-\lVert\nu_i\rVert^2$, which only strengthens it. $\square$

**Proof of (b).**
1. **Equations.** The characters trivial on $\ker\chi_{Q_1}\cap\ker\chi_{Q_2}$ are $\{1,\chi_{Q_1},\chi_{Q_2},\chi_{Q_3}\}$, so $\mathcal S$ is a subalgebra and criticality splits into $D\circ D+\sum_i\nu_i\circ\nu_i=\theta D$ and $2D\circ\nu_i+2\nu_j\circ\nu_k=\theta\nu_i$ for $\{i,j,k\}=\{1,2,3\}$. With $\nu_3=0$ the $\chi_{Q_3}$ equation forces $\nu_1\circ\nu_2=0$, so $\tau=0$.
2. **The pinning inequality.** With $q_i$ the projection of $D$ on $\Pi_{Q_i}$, L220's step 4 gives $\langle D\circ\nu_i,\nu_i\rangle=\langle L_{q_i}\nu_i,\nu_i\rangle$, and pairing the $\chi_{Q_i}$ equation with $\nu_i$ gives $\langle L_{q_i}\nu_i,\nu_i\rangle=\tfrac\theta2N_i-\tau$, $N_i=\lVert\nu_i\rVert^2$. With L220's step 5 and $\tau\le0$: $\tfrac{\sqrt3}2u_iN_i\ge\tfrac\theta2N_i$, so $u_i=\lVert q_i\rVert\ge\theta/\sqrt3$ whenever $\nu_i\ne0$.
3. **Two constants.** $\lVert\nu\circ\nu\rVert=\tfrac{\sqrt3}2\lVert\nu\rVert^2$ on each $V_Q$, the identity $2\sum_{\mathrm{cyc}}(2a^2-b^2-c^2)^2=\tfrac34\big(2(a^2+b^2+c^2)\big)^2$ at $a+b+c=0$. And unit patterns on $Q_i$ and $Q_j$ share exactly one pair, whose entry has square at most $\tfrac13$ on each ([L220](../findings/second-order.md#lemma-l220-the-diagonal-theorem-on-a-four-set-subalgebra-a-critical-point-with-a-four-set-component-has-thetalesqrt32)'s step 8), so $\lvert\langle\hat q_i,\hat q_j\rangle\rvert\le\tfrac13$. Hence $\lvert\langle\nu_j\circ\nu_j,q_i\rangle\rvert\le\tfrac{\sqrt3}2N_j\cdot\tfrac13u_i=\tfrac{u_i}{2\sqrt3}N_j$.
4. **The per-block chain.** Pairing the $\mathcal D_n$ equation with $q_i$, $r_i=D-q_i$, $t=\lVert D\rVert^2=1-N$:
$$\theta u_i^2=P(q_i)+\langle L_{q_i}r_i,r_i\rangle+\big(\tfrac\theta2N_i-\tau\big)+\sum_{j\ne i}\langle\nu_j\circ\nu_j,q_i\rangle\le\tfrac{\sqrt3}2u_i^3+\tfrac{u_i}{\sqrt3}(t-u_i^2)+\tfrac{\sqrt3}2u_iN_i+\tfrac{u_i}{2\sqrt3}(N-N_i),$$
using L220's steps 7 and 8 and step 2's upper bound $\tfrac{\sqrt3}2u_iN_i$ on the pinning term. Dividing by $u_i>0$: $\theta u_i-\tfrac{u_i^2}{2\sqrt3}\le\tfrac1{\sqrt3}\big(1-\tfrac N2+N_i\big)$. The left side increases for $u_i\le\sqrt3\theta$, which holds as $u_i\le1<\sqrt3\theta$ at every $\theta>\tfrac1{\sqrt3}$ (and $\theta^2\le\tfrac13<\tfrac65$ otherwise), so $u_i\ge\theta/\sqrt3$ gives $\tfrac56\theta^2\le1-\tfrac N2+N_i$.
5. **Sum.** Over the two or three blocks with $\nu_i\ne0$ (a block with $\nu_i=0$ contributes $N_i=0$ and is not summed): with three, $\tfrac52\theta^2\le3-\tfrac N2\le3$, and with two, $\tfrac53\theta^2\le2-N+N=2$. Either way $\theta^2\le\tfrac65$. $\square$

**What it gives and what remains.** *(a) and (b) settle every stratum of the far region whose block part lies in disjoint four-set blocks, or in two four-sets sharing two indices with $\tau\le0$.* **Open**: (b) with $\tau>0$, where by screen $\lvert\tau\rvert\le\tfrac12\sqrt{N_1N_2N_3}$ and the pinning loses up to $\tfrac12\sqrt{N_i}$, four-sets sharing three indices, and pair blocks. *Gate 1 (screen): restricted ascent and a least-squares search for critical points of every index at $n=8$ found no critical point with two or more block components above $\theta=0.66$, and ascent at $n=8$ and $12$ found every block-carrying maximum at L220's $\sqrt{3/2}$ with one component.*

## Given 1, Lemma L220 in full, Gate 2 passed ([findings/second-order.md](../findings/second-order.md) lines 847-874)

#### Lemma L220, the diagonal theorem on a four-set subalgebra: a critical point with a four-set component has $\theta\le\sqrt{3/2}$

*Gate 2 PASSED ([r939](REVIEW_r939.md), [r940](REVIEW_r940.md), items 1 to 8 CONFIRMED by both). Derived 2026-09-14 as [I101](../plan.md), the single-four-set case of the far region, after four failed attempts recorded in the [I100 derivation](2026-09-14-I100-derivation.md). The scalar chain and both polynomial inequalities are kernel-checked in [L220Statement.lean](../lean/HamiltonsCubic/Results/L220Statement.lean).*

**Statement.** *Let $n\ge5$, $Q=\{i,j,k,l\}$, $V_Q$ the four-set block of character $\chi_Q$ and $\mathcal S_Q=\mathcal D_n\oplus V_Q$. Every unit critical point $W=D+\nu$ of $P$ in $\mathcal S_Q$ with $\nu\in V_Q$, $\nu\ne0$ and $\theta>0$ has*
$$\theta\le\sqrt{3/2},$$
*with equality exactly at padded $W_{\mathbb{CP}^2}$ on $Q$. Hence at $n\ge12$, $\sup P=\Theta_n$ on the unit sphere of $\mathcal S_Q$, attained only on $\mathcal D_n$.*

**Setting.** $\Pi_Q\subset\mathcal D_n$ is the plane of sectional matrices supported on $Q$, $K_{ij}=K_{kl}=x$, $K_{ik}=K_{jl}=y$, $K_{il}=K_{jk}=z$ with $x+y+z=0$, unit when $2(x^2+y^2+z^2)=1$. Write $D=q+r$ with $q\in\Pi_Q$, $r\in\mathcal D_n\ominus\Pi_Q$, and in the pairing basis of $V_Q$ with signed coordinates $\nu=a\,e_{ij}\odot e_{kl}+b\,e_{ik}\odot e_{jl}+c\,e_{il}\odot e_{jk}$, $a+b+c=0$.

**Proof.**

1. **$\mathcal S_Q$ is a subalgebra and its maximum is critical.** $\mathcal S_Q$ is the fixed space of $\ker\chi_Q\subset\Gamma$, since the only characters of [L120](../findings/second-order.md#lemma-l120-l_m-is-block-diagonal-over-the-sign-characters-at-every-diagonal-critical-point)'s decomposition trivial on $\ker\chi_Q$ are $1$ and $\chi_Q$: a four-set character $\chi_{Q'}$, $Q'\ne Q$, is $-1$ on the single flip at an index of $Q'\setminus Q$, which lies in $\ker\chi_Q$, and a pair character $\varepsilon_a\varepsilon_b$ is $-1$ on the flip at $a$ when $a\notin Q$, or on $\varepsilon_a\varepsilon_c$ with $c\in Q\setminus\{a,b\}$ when $a,b\in Q$. A fixed space of automorphisms is a subalgebra, so the maximum of $P$ on its unit sphere satisfies $Q(W)=\theta W$ in $\mathcal W_n$. *Where the maximiser has $\nu=0$ it is diagonal and [L57](../findings/problem.md) bounds it by $\Theta_n$.*
2. **Three products.** $\Pi_Q$ is a subalgebra of $\mathcal D_n$, since a hollow matrix supported on $Q$ with zero row sums has $S^{\circ2}+S^2$ supported on $Q$ off the diagonal with zero row sums. $\nu\circ\nu\in\Pi_Q$, with $x=2a^2-b^2-c^2$ and cyclically: it has character $\chi_Q^2=1$, so it lies in $\mathcal D_n$, in $(\nu\#\nu)_{\alpha\alpha}$ a pair $\alpha$ leaving $Q$ forces a factor of $\nu$ outside its support, and on $Q$ the pattern is $(\nu\#\nu)_{ij,ij}=2bc$ plus $(\nu^2)_{ij,ij}=a^2$. And $D\circ\nu\in V_Q$ by L120.
3. **Split the equation.** $Q(W)=D\circ D+2D\circ\nu+\nu\circ\nu$, so $D\circ D+\nu\circ\nu=\theta D$ and $L_D\nu=\tfrac\theta2\nu$.
4. **$L_r\nu=0$.** $L_r\nu\in V_Q$, and $\langle L_r\nu,\nu'\rangle=\langle r,\nu\circ\nu'\rangle=0$ for $\nu'\in V_Q$, as $\nu\circ\nu'\in\Pi_Q\perp r$. So $L_q\nu=\tfrac\theta2\nu$.
5. **The eigenvalue fixes $\lVert q\rVert$.** By [L121](../findings/second-order.md#lemma-l121-the-4-set-block-its-spectrum-and-one-necessary-condition-per-4-subset) $L_q$ on $V_Q$ has eigenvalues $\pm\tfrac12\sqrt E$ with $A=2x$, $B=2y$, $C=2z$, so $E=4(x^2+y^2+z^2-xy-yz-zx)=6(x^2+y^2+z^2)=3\lVert q\rVert^2$, using $xy+yz+zx=-\tfrac12(x^2+y^2+z^2)$. With $\theta>0$ and $\nu\ne0$, $\lVert q\rVert^2=\theta^2/3$.
6. **Pair the $\mathcal D_n$ equation with $q$.** $\langle D\circ D,q\rangle=P(q)+2\langle q\circ r,q\rangle+\langle r\circ r,q\rangle$ with $\langle q\circ r,q\rangle=\langle r,q\circ q\rangle=0$, $\langle r\circ r,q\rangle=\langle L_qr,r\rangle=:\kappa$, and $\langle\nu\circ\nu,q\rangle=\langle L_q\nu,\nu\rangle=\tfrac\theta2\lVert\nu\rVert^2$, so $P(q)+\kappa+\tfrac\theta2\lVert\nu\rVert^2=\tfrac{\theta^3}3$.
7. **$P$ on $\Pi_Q$.** $P(q)=\sum_{a<b}K_{ab}^3+3\sum_{\text{triangles}}K_{ab}K_{bc}K_{ca}=2(x^3+y^3+z^3)+12xyz=18xyz$, and $x+y+z=0$ gives $(x^2+y^2+z^2)^3\ge54x^2y^2z^2$, so $P(q)\le\tfrac{\sqrt3}2\lVert q\rVert^3=\tfrac{\theta^3}6$, equality at the $S^2\times S^2$ shape.
8. **The coupling.** For unit $\hat q=(x,y,z)$ and $r\perp\Pi_Q$, split $r$ into its $Q$-internal entries $p,p',a',b',c',d'$ on the pairs $ij,kl,ik,jl,il,jk$, its columns $c_m=(r_{am})_{a\in Q}$ for $m\notin Q$, and the rest. Then $2\langle L_{\hat q}r,r\rangle=2[x(p^2+p'^2)+y(a'^2+b'^2)+z(c'^2+d'^2)]+2\Sigma+\sum_mc_m^{\mathsf T}\hat qc_m$ with $\Sigma=z(p+p')(a'+b')+y(p+p')(c'+d')+x(a'+b')(c'+d')$, the entries outside $Q$'s rows not entering. Orthogonality to $\Pi_Q$ is $p+p'=a'+b'=c'+d'=:s$, so $\Sigma=s^2(x+y+z)=0$, and $\hat q$ has spectrum $\{0,2x,2y,2z\}$ on $\mathbb R^Q$. So $\kappa\le\max(x,y,z)\lVert q\rVert\lVert r\rVert^2\le\tfrac1{\sqrt3}\lVert q\rVert\lVert r\rVert^2=\tfrac\theta3\lVert r\rVert^2$.
9. **Arithmetic.** Steps 6 to 8 give $\tfrac{\theta^3}6-\tfrac\theta2\lVert\nu\rVert^2\le\tfrac\theta3\lVert r\rVert^2$. With $\lVert r\rVert^2=1-\tfrac{\theta^2}3-\lVert\nu\rVert^2$ this is $\tfrac5{18}\theta^2\le\tfrac13+\tfrac16\lVert\nu\rVert^2$, and $\lVert\nu\rVert^2\le1-\tfrac{\theta^2}3$ gives $\theta^2\le\tfrac32$. Equality forces $r=0$, $\lVert\nu\rVert^2=\tfrac12$ and the $S^2\times S^2$ shape, and conversely $q=t(2,-1,-1)$, $\nu=\pm t(2,-1,-1)$ with $t^2=\tfrac1{24}$ satisfies both equations of step 3 at $\theta=\sqrt{3/2}$, which is padded $W_{\mathbb{CP}^2}$. At $n\ge12$, $\Theta_n>\sqrt{3/2}$ (and $\Theta_{11}<\sqrt{3/2}$), $\Theta_n$ is attained in $\mathcal D_n$ by the balanced product ([Nienhaus Proposition 2.25](../findings/problem.md)), and L57 bounds $\mathcal D_n$, so every maximiser on $\mathcal S_Q$ has $\nu=0$. $\square$

**Corollary, inequality (J).** *For every unit $d\in\mathcal D_n$, $n\ge12$, with top $V_Q$-eigenvalue $e=e(d)>\Theta_n/2$: $P(d)<3e-4e^3/\Theta_n^2$.* **Proof.** If not, take $\nu$ the unit top eigenvector of $L_d$ on $V_Q$ and $c=\Theta_n/(2e)<1$. Then $P(cd+s\nu)=c^3P(d)+3cs^2e=(P(d)-3e)c^3+3ec\ge-\tfrac{4e^3}{\Theta_n^2}c^3+3ec=\Theta_n$, using $T(d,d,\nu)=0$ and $P(\nu)=0$, a unit point of $\mathcal S_Q$ with $\nu$-component $s\ne0$ at or above $\Theta_n$, which the lemma excludes. $\square$ *Added at the fold: the reviewers found the block claiming (J) without this step.*

**What it gives.** *It closes [I101](../plan.md) and, through the corollary, inequality (J): no global maximiser at $n\ge12$ has a NONZERO off-diagonal part, in any frame, lying inside a single four-set block.* **The lever is step 5**: the eigenvalue condition of the critical point pins $\lVert q\rVert$ to $\theta/\sqrt3$, so both bounds of steps 7 and 8 become functions of $\theta$ with their equality at the same point, and nothing is bounded at two different vectors, which is what [post F67](../findings/fence-posts.md) forbids. *Four whole-sphere attempts failed where this critical-point argument closes.*

**Gate 1** (screen). *Ascent restricted to $\mathcal S_Q$, 60 starts each at $n=8$ and $n=12$: every converged critical point with $\nu\ne0$ sits at $\theta=1.224745=\sqrt{3/2}$ with $\lVert\nu\rVert^2=0.5000$, and every other has $\nu=0$ ($\Theta_{12}$, $S^5\times S^7$ and lower at $n=12$). The whole-sphere screen of (J) found its extreme at the same point.*

## Given 2, Lemma L120's statement ([findings/second-order.md](../findings/second-order.md) lines 624-631)

#### Lemma L120, $L_M$ is block-diagonal over the sign characters at every diagonal critical point

**Let $\Gamma=\{\operatorname{diag}(\varepsilon_1,\dots,\varepsilon_n):\varepsilon_i=\pm1\}\subset O(n)$ be the full diagonal sign group. Then $\mathcal W_n$ decomposes as**
$$\mathcal W_n=\underbrace{\mathcal D_n}_{n(n-3)/2}\ \oplus\ \bigoplus_{\{i,j,k,l\}}\underbrace{V_{ijkl}}_{2}\ \oplus\ \bigoplus_{\{j,k\}}\underbrace{V_{jk}}_{n-3},$$
**and at every diagonal $M$, **criticality is unused; $\Gamma$-equivariance needs only that $M$ is $\Gamma$-fixed**, the operator $L_M$ preserves each summand. Hence the Hessian of $P$ on the sphere is block-diagonal in the same way, and [Lemma L24](../findings/second-order.md#lemma-l24-second-order-optimality-as-an-eigenvalue-bound-the-canonical-statement)'s criterion is checkable block by block **once $\mathcal D_n$ is cut by $\langle M\rangle$**; the largest block a non-diagonal direction occupies has size $\max(2,n-3)$, and $\binom n4$ of them have size $2$.

> **THE CUT IS NOT OPTIONAL, AND THE SENTENCE ABOVE IS THE ONE EVERY CITATION QUOTES.** $e=M/\theta$ lies in $\mathcal D_n$ and $L_ee=e$, so read without it the criterion gives $\lambda_{\max}(L_e\vert_{\mathcal D_n})\ge1>\tfrac12$ and **no diagonal critical point is a maximiser, vacuously**, the balanced sphere product included. **$W^\perp$ cuts $\mathcal D_n$ and nothing else**, since $M$ spans the trivial character and every other summand lies wholly inside $W^\perp$ by isotypic orthogonality. *And the block size fails at $n=4$ as first printed, where the four-set block is $2$ against $n-3=1$.* *Gate 2, [r507](REVIEW_r507.md) and [r508](REVIEW_r508.md) on identical briefs, both CONFIRMED and agreeing on every repair.***


## The Lean declarations, docstrings removed ([L221Statement.lean](../lean/HamiltonsCubic/Results/L221Statement.lean))

```lean
import Mathlib

set_option linter.style.longLine false

namespace HamiltonsCubic.L221Statement

theorem nu_square_norm (a b c : ℝ) (h : a + b + c = 0) :
    2 * ((2 * a ^ 2 - b ^ 2 - c ^ 2) ^ 2 + (2 * b ^ 2 - a ^ 2 - c ^ 2) ^ 2 + (2 * c ^ 2 - a ^ 2 - b ^ 2) ^ 2)
      = 3 / 4 * (2 * (a ^ 2 + b ^ 2 + c ^ 2)) ^ 2 := by
  have hc : c = -a - b := by linarith
  subst hc
  ring

theorem per_block (θ u s N Ni : ℝ) (hs : s ^ 2 = 3) (hs0 : 0 < s) (hθ : 0 < θ)
    (hu : θ ≤ s * u) (hu1 : u ≤ 1) (hθu : 1 ≤ s * θ)
    (hchain : θ * u ≤ u ^ 2 / (2 * s) + (1 - N / 2 + Ni) / s) :
    5 / 6 * θ ^ 2 ≤ 1 - N / 2 + Ni := by
  -- multiply the chain by s: s θ u ≤ u²/2 + (1 - N/2 + Ni)
  have h1 : s * θ * u - u ^ 2 / 2 ≤ 1 - N / 2 + Ni := by
    have := mul_le_mul_of_nonneg_left hchain hs0.le
    have e : s * (u ^ 2 / (2 * s) + (1 - N / 2 + Ni) / s) = u ^ 2 / 2 + (1 - N / 2 + Ni) := by
      field_simp
    nlinarith [this, e]
  -- g(u) = sθu - u²/2 is increasing for u ≤ sθ, and u ≥ θ/s, so g(u) ≥ g(θ/s) = θ² - θ²/6
  have hg : s * θ * (θ / s) - (θ / s) ^ 2 / 2 ≤ s * θ * u - u ^ 2 / 2 := by
    have hlow : θ / s ≤ u := by rw [div_le_iff₀ hs0]; linarith
    have hup : u ≤ s * θ := by nlinarith
    nlinarith [mul_nonneg (sub_nonneg.mpr hlow) (sub_nonneg.mpr hup), hs]
  have hv : s * θ * (θ / s) - (θ / s) ^ 2 / 2 = 5 / 6 * θ ^ 2 := by
    field_simp
    rw [hs]
    ring
  linarith

theorem sum_three (θ N N1 N2 N3 : ℝ) (hN : N = N1 + N2 + N3) (hN0 : 0 ≤ N)
    (h1 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N1) (h2 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N2)
    (h3 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N3) : θ ^ 2 ≤ 6 / 5 := by
  nlinarith

theorem sum_two (θ N N1 N2 : ℝ) (hN : N = N1 + N2)
    (h1 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N1) (h2 : 5 / 6 * θ ^ 2 ≤ 1 - N / 2 + N2) : θ ^ 2 ≤ 6 / 5 := by
  nlinarith

example : True := by
  have := sum_three (Real.sqrt (6 / 5)) 0 0 0 0 (by norm_num) le_rfl
    (by rw [Real.sq_sqrt (by norm_num)]; norm_num) (by rw [Real.sq_sqrt (by norm_num)]; norm_num)
    (by rw [Real.sq_sqrt (by norm_num)]; norm_num)
  trivial

end HamiltonsCubic.L221Statement
```

**Which claims the kernel settles**: the norm identity $\lVert\nu\circ\nu\rVert^2=\tfrac34\lVert\nu\rVert^4$ as a polynomial identity in the pattern, the monotonicity step from the chain's inequality and $u\ge\theta/\sqrt3$ to $\tfrac56\theta^2\le1-\tfrac N2+N_i$, and the two sums. **Which it does not**: the character arguments that make both spaces subalgebras, $\nu_i\circ\nu_j=0$ for disjoint sets, the vanishing of the cross terms in (a), the equations of (b)1, $\tau=0$ when $\nu_3=0$, the pinning inequality and its use of $\tau\le0$, the angle bound $\tfrac13$ between pattern planes, each term of the chain in (b)4 including its signs and which upper bound is used where, and the handling of blocks with $\nu_i=0$ in the sum. Spend your attention there.

## What to attack

1. **(a)'s subalgebra**: every character witness, including $Q'\subset\bigcup_iQ_i$ meeting several $Q_i$, and pair characters with both indices in one $Q_i$ or in two different ones.
2. **(a)'s chain**: that L220's steps 3 to 9 apply to one block with the others present, that the cross terms vanish, and the inequality for $\lVert r_i\rVert^2$.
3. **(b)1**: the four characters, the split equations, and $\tau=0$ at $\nu_3=0$.
4. **(b)2**: the pinning inequality, the sign conventions for $\tau$ in all three equations, and the direction of the conclusion.
5. **(b)3**: the norm identity's normalisation and the angle bound, including whether each pair of the three four-sets shares exactly one pair and whether the bound holds for every shape of the two patterns.
6. **(b)4**: each term of the displayed inequality, which bound is applied to the pinning term, $\lVert r_i\rVert^2=t-u_i^2$, and the monotonicity range.
7. **(b)5**: the sums with two and three nonzero components, and whether a block with $\nu_i=0$ is excluded correctly.
8. **Scope**: any hypothesis used and unstated, claims beyond the proof, the range of $n$, whether $\tau\le0$ is the right split or could be normalised by a symmetry, and prior art in [findings/](../findings/).

**Rules.** Argue from the definitions. No numerical work beyond the smallest check that refutes a claim, and say why an argument could not. Read no other file of the repository except the ones linked above for context, and no other reviewer's output. Analysis only: a screen of seconds on an object you construct is allowed and reported as a screen, never as evidence for a positive claim.
