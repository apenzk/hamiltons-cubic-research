# Reviewer 324, Lemma L70, the deficiency identity, its Hilbert–Schmidt twin, and route R14

**Cold brief, independent build.** Everything below is computed from `so(n)`, the structure constants, `#` and `Weyl_n` rebuilt from their definitions in [scripts/reviewers/r324/](../scripts/reviewers/r324/); no script of the record was read or run. The build is validated by returning $\dim\mathcal W_n=35,84,168,300$ at $n=5,\dots,8$, and by producing the balanced sphere products as genuine Weyl tensors (residual $\le3\times10^{-15}$), critical to $\le3.3\times10^{-16}$, at $\theta=\theta_0(n)$ exactly: $1.054092553$, $1.145643924$, $1.200000000$, $1.236033081$ at $n=6,8,10,12$.

| claim | verdict |
| --- | --- |
| **L4** route R14, reduction or tautology | **REFUTED AS STATED**, the equivalence is an exact rewrite of one scalar equation, and T3's own named raw material has a computed ceiling $1.5$–$3.7\times$ above $\theta_0$. The repair: R14's value is entirely in T4 |
| **L5** the Hilbert–Schmidt form | **CONFIRMED as an identity, REFUTED as new information**, it is L1's own sum re-partitioned by polarisation. The "control that says the two statements are different" is a category error |
| **L1** the deficiency identity | **CONFIRMED**, and its hypothesis list is *over-stated*: it needs neither Weyl membership, nor $\lVert W\rVert=1$, nor $\theta>0$, nor $n\ge5$ |
| **L2** equality for every $v$ | **CONFIRMED, and trivially so**, at a critical point $W^{\#}=\theta W-W^2$ is a polynomial in $W$, so $D(v)$ is constant on each eigenspace |
| **L3** the saturation set | **CONFIRMED on Lemma L23's family** (every reported number reproduced). **The generalisation is REFUTED**: $W_{\mathbb{CP}^2}$ at $n=4$ is a saturating critical Weyl tensor with three eigenvalues, so plan.md's **T4 as written is false without a dimension hypothesis** |

**New theorem delivered (proved, not sampled): saturation forces $\theta\ge\theta_0(n)$.** Stated in §5. It closes the "$\ge$" half of T4 with the two-eigenvalue hypothesis dropped, and it answers L3's hunt analytically, no catalogued point below $\theta_0(n)$ can saturate, so the $C_5$ blow-up, the $n=8$ witness at $1.088948$, the $S=0$ ceiling at $0.716134$, $S^5\times S^7$ and every padded $W_{\mathbb{CP}^2}$ at $n\ge5$ are excluded without a search.

---

## 1. L4, the one that matters. Verdict: REFUTED AS STATED

**R14's equivalence is a change of letters, not a reduction, and this is provable rather than an impression.**

### 1.1 The two sides are the same number, pointwise

At every critical point and every unit $v\in E_{\min}$, Lemma L70 gives

$$\frac{D(v)}{\lvert\lambda_{\min}\rvert}\;=\;\lambda_{\min}+(n-2)\lambda_{\max}-\theta \qquad\text{identically.}$$

So the deficiency statement $D(v)/\lvert\lambda_{\min}\rvert\ge\lambda_{\min}+(n-2)\lambda_{\max}-\theta_0(n)$ is the string $\theta\le\theta_0(n)$ with $\theta$ replaced by its own definition. There is no inequality between the two sides to be proved, only a substitution. **This is a stricter failure than the one [Reviewer 118 closed](../findings/bounds.md).** The $\Pi$ route was *tight* on $\{\Delta=0\}$ and *strictly harder* off it; R14 is exactly the target everywhere, with neither loss nor gain. A reformulation of that kind earns its place only if a technique attaches to the new variable. Section 1.2 shows the technique the plan names does not.

### 1.2 T3's own raw material has a computed ceiling, and it is far above $\theta_0$

[plan.md](../plan.md) grades T3 a 9 on the ground that "the raw material is on the record: $D$'s weights $\lambda_a\lambda_b-\lambda_{\min}\lambda_{\max}$ are spectral, its masses $c_{v\alpha\beta}^2$ carry the proved row cap $\sup\lVert[v,\varphi]\rVert^2=2$ and total $2(n-2)$". That is a *finite* list, so it has an exact optimum. I computed it.

$D(v)$ depends on the spectrum and on one row $t_{ab}=c_{vab}^2$ of the bracket tensor. Relax to everything that list knows:

- $\sum_a\lambda_a=0$, $\sum_a\lambda_a^2=1$;
- $t\ge0$ symmetric, $t_{aa}=0$, $\sum_{ab}t_{ab}=2(n-2)$;
- the per-row identity $\sum_{ab}\lambda_a t_{ab}=-2\lambda_{\min}$ (the one Weyl-specific input, §5.1);
- optionally the row cap $\sum_b t_{ab}\le2$, which I re-derived independently, $\sup_{\lVert v\rVert=\lVert\varphi\rVert=1}\lVert[v,\varphi]\rVert^2=2.000000000$ at $n=5,6,8$, confirming the record.

With two equality constraints the inner problem is a lower convex envelope and is solved exactly; with the row cap it is an LP. Maximising the resulting $\theta$ over spectra ([t_lp.py](../scripts/reviewers/r324/t_lp.py), [t_lp2.py](../scripts/reviewers/r324/t_lp2.py)):

| | $n=5$ | $n=6$ | $n=8$ |
| --- | --- | --- | --- |
| $\theta_0(n)$ | $0.979796$ | $1.054093$ | $1.145644$ |
| ceiling, mass + first moment | $2.043016$ | $2.764097$ | $4.190852$ |
| ratio to $\theta_0$ | $2.09$ | $2.62$ | $3.66$ |
| ceiling, **with** the row cap | $1.492723$ | $1.932629$ |, |
| ratio to $\theta_0$ | $1.52$ | $1.83$ |, |

Both relaxations return **$\theta_0(n)$ exactly** at the balanced-product spectrum, $1.054092553$, $1.145643924$, $1.200000000$, $1.236033081$ at $n=6,8,10,12$, so they are sharp where the record wants sharpness and still 1.5–3.7× over everywhere else, with the ratio **growing in $n$**. That is the same shape and the same magnitude as the class [fence post F10](../findings/fence-posts.md) already closed ($1.60$/$2.29$/$2.49$, later $1.4136$/$2.2585$). **T3's stated raw material provably cannot close the conjecture.**

### 1.3 Does $D$ carry information the spectrum and the marginals do not? Yes, and that is the problem

$D(v)$ is a functional of the *full* row measure $t$, not of its marginals, so it sits strictly outside the LP class. But that extra information is exactly $\theta$: at a critical point $D(v)=\lvert\lambda_{\min}\rvert(\lambda_{\min}+(n-2)\lambda_{\max}-\theta)$. So the dichotomy is sharp and complete:

- a lower bound on $D$ using only spectrum and marginals is the class ceilinged in §1.2, **cannot close**;
- a lower bound on $D$ using more must use the alignment of the row measure against the spectrum, which is what determines $\theta$, **it is the target**.

There is no third option, because those two exhaust what $D$ is built from. **Every route to $D$ passes back through $\theta$.**

### 1.4 What survives, and it is not nothing

R14 is not sterile. Applied to the **equality case** rather than to the bound it produces a real theorem in five lines (§5), which is exactly T4, and T4 is graded 6. **The repair is to move R14's weight from T3 to T4 and to re-grade T3 down**: its "attackable 3" rested on raw material that now has a measured ceiling.

---

## 2. L5, the Hilbert–Schmidt form. CONFIRMED as an identity, REFUTED as new information

### 2.1 The unboxed identity is true, and much more general than claimed

$$\langle v,W^{\#}v\rangle=-\tfrac14\lVert[\mathop{\mathrm{ad}}(v),W]\rVert^2-\tfrac12\mathop{\mathrm{tr}}\big((\mathop{\mathrm{ad}}v)^2W^2\big)$$

holds to $\le2\times10^{-16}$ for **every symmetric operator on $\Lambda^2$** (random non-Weyl, Weyl, kernel-forced) for **every** $v$, unit or not ($\lVert v\rVert=2.3$ tested), eigenvector or not ([t_hyp.py](../scripts/reviewers/r324/t_hyp.py), $n=5,6,7$). The record's "an identity on all of $\mathcal W_n$" understates it: $\mathcal W_n$ plays no role. Both terms behave as stated, $-\tfrac12\mathop{\mathrm{tr}}((\mathop{\mathrm{ad}}v)^2W^2)=\tfrac12\lVert\mathop{\mathrm{ad}}(v)W\rVert^2\ge0$, reproduced to $10^{-9}$ at every point tested.

### 2.2 It is L1's own sum, re-partitioned. There is no second statement

Write $t_{ab}=T_{vab}=c_{vab}^2$. Then $g_v=\sum(\lambda_a-\lambda_b)^2t_{ab}=2\sum\lambda_a^2t_{ab}-2\sum\lambda_a\lambda_bt_{ab}$ and $\lVert\mathop{\mathrm{ad}}(v)W\rVert^2=\sum\lambda_a^2t_{ab}$, so

$$-\tfrac14g_v+\tfrac12\lVert\mathop{\mathrm{ad}}(v)W\rVert^2=\tfrac12\sum_{ab}\lambda_a\lambda_bt_{ab}=\langle v,W^{\#}v\rangle .$$

That is the polarisation identity $(\lambda_a-\lambda_b)^2=\lambda_a^2+\lambda_b^2-2\lambda_a\lambda_b$ applied to the same measure L1 already sums. The bridge to L1 is explicit and hypothesis-free:

$$D(v)+(n-2)\lambda_{\min}\lambda_{\max}+\tfrac14g_v-\tfrac12\lVert\mathop{\mathrm{ad}}(v)W\rVert^2=0,$$

residual $\le1.7\times10^{-15}$ at $S^3\times S^3$, the $n=8$ torus, $W_{\mathbb{CP}^2}$ at $n=4$ **and at random non-Weyl symmetric operators**. So L1 and L5 are one equation (criticality evaluated at $v$), recorded in two commits.

### 2.3 The stated control is a category error

The record argues: L5's boxed form fails by $0.46$ off criticality "so criticality is load-bearing here in a way it is not in the line above, **which is the control that says the two statements are different**". That compares L5's *unboxed* identity with L1's *boxed* one. L1 has the same criticality-free core, I verified $\langle v,W^{\#}v\rangle-\big[D(v)+(n-2)\lambda_{\min}\lambda_{\max}\big]=0$ to $\le2\times10^{-14}$ at random non-critical, non-Weyl, non-unit, non-eigenvector data. Both statements have a criticality-free algebraic core and a criticality-dependent box, and the boxes are the same equation. **The control does not distinguish them, and the sentence should be withdrawn.**

### 2.4 Is $g_v$ the same $g$? Yes

$\lVert[\mathop{\mathrm{ad}}(v),W]\rVert^2$ and $\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{v\alpha\beta}$ agree to $\le3.6\times10^{-15}$ ($S^3\times S^3$: $2.222222222222$; $n=8$ torus: $1.166666666667$; $W_{\mathbb{CP}^2}$ at $n=4$: $6.000000000000$), so it is [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) Prop 1.7's quantity and the record's $\Delta$ ingredient. Both known contractions reproduce independently: $\sum_\gamma g_\gamma=4(n-1)$ ($20.000000000$ at $n=6$, $28.000000000$ at $n=8$) and $\sum_\gamma\lambda_\gamma g_\gamma=-4\theta$ ($-4.216370214$ at $S^3\times S^3$, $-2.160246899$ at the $n=8$ torus).

### 2.5 Consequence of, or stronger than, the two contractions? **Neither**

- It is **not a consequence** of $\sum g_\gamma=4(n-1)$ and $\sum\lambda_\gamma g_\gamma=-4\theta$: those are two linear functionals of the vector $(g_\gamma)$, and the per-$v$ statement involves one index plus a second quantity $\lVert\mathop{\mathrm{ad}}(v)W\rVert^2$ that neither contraction sees. The record's sentence "no contraction against a $\gamma$-independent or $\lambda$-weight recovers it" is correct.
- It is **not new information** either, because it is L1 (§2.2), and L1 is criticality applied to $v$. The correct framing is that *both* are elementary: at a critical point $W^{\#}=\theta W-W^2$, so $\langle\varphi_\gamma,W^{\#}\varphi_\gamma\rangle=\theta\lambda_\gamma-\lambda_\gamma^2$ for **every** eigenvector, and the per-$v$ form is that one line with $\langle v,W^{\#}v\rangle$ expanded. The distinguished status of $v\in E_{\min}$ is a choice of which eigenvalue to divide by, not extra content.

*Reproduced en route:* $g_v=16(n-1)/n^2$ at the balanced products, $2.222222$, $1.750000$, $1.440000$ at $n=6,8,10$.

---

## 3. L1, the deficiency identity. CONFIRMED, with the hypothesis list corrected

**Exactness.** $\theta-\big[\lambda_{\min}+(n-2)\lambda_{\max}-D(v)/\lvert\lambda_{\min}\rvert\big]$ is $\le1.1\times10^{-15}$ at every critical point I built: balanced products $n=6,8,10,12$; maximal tori $n=6,8,10,12$; $\mathop{\mathrm{ad}}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$; $\mathbb{CP}^m$ Weyl parts $m=2,\dots,5$; padded $W_{\mathbb{CP}^2}$ at $n=4,5,6,7,9,11,12$; and 90 critical points found by Newton on $Q(W)=W$ at $n=6$.

**Which hypotheses it actually needs.** The identity is $\lambda_{\min}^2+\langle v,W^{\#}v\rangle=\theta\lambda_{\min}$ with the left side re-expressed, so it needs exactly:

| hypothesis | needed? | evidence |
| --- | --- | --- |
| $Q(W)=\theta W$ | **yes** | slack $-0.29$ to $-0.43$ at the non-critical two-eigenvalue points |
| $v$ a unit $\lambda_{\min}$-eigenvector, $\lambda_{\min}\ne0$ | **yes** | $\lVert v\rVert=1$ is what fixes $\sum t_{ab}=2(n-2)$ |
| $W\in\mathcal W_n$ | **no** | the algebraic core holds at random symmetric non-Weyl $W$, residual $\le2\times10^{-14}$ |
| $\lVert W\rVert=1$ | **no** | the identity is homogeneous of degree 1 in $W$; residual $0.0$ at $\lVert W\rVert=2.7$ |
| $\theta>0$ | **no** | residual $2.2\times10^{-16}$ at $-W$, $\theta=-1.054092553$ |
| $n\ge5$ | **no** | residual $2.2\times10^{-16}$ at $W_{\mathbb{CP}^2}$, $n=4$ |
| $\ker W=0$ | **no** | $W_{\mathbb{CP}^2}$ has a 3-dimensional kernel at $n=4$ and a large one at every padding |

*Weyl membership does become load-bearing one step later*, the rigidity of §5 needs it, and that is where the record should place it.

**$D\ge0$, termwise, kernel included.** For $\lambda_{\min}<0<\lambda_{\max}$ and any $\lambda_a,\lambda_b$ in $[\lambda_{\min},\lambda_{\max}]$: like signs give $\lambda_a\lambda_b\ge0>\lambda_{\min}\lambda_{\max}$; a zero gives $0>\lambda_{\min}\lambda_{\max}$; opposite signs give $\lambda_a\lambda_b=-\lvert\lambda_a\rvert\lambda_b\ge-\lvert\lambda_{\min}\rvert\lambda_{\max}$. **And the minimiser is unique**: equality in the last line forces $\lambda_a=\lambda_{\min}$ and $\lambda_b=\lambda_{\max}$. So "$\lambda_{\min}\lambda_{\max}$ is not the unique minimiser" cannot happen, and $D=0$ really is equivalent to support on $E_{\min}\otimes E_{\max}$. $\lambda_{\min}<0<\lambda_{\max}$ itself follows from $\mathop{\mathrm{tr}}W=0$, $W\ne0$, the one place Weyl membership enters L1, and only through the trace.

---

## 4. L2, "for every $v$". CONFIRMED, and the proof is one line

**"For every $v$" follows; it is not an extra hypothesis and not a coincidence.** At a critical point $W^{\#}=\theta W-W^2$ is a *polynomial in $W$*. Hence $W^{\#}$ acts on the $\lambda$-eigenspace as the scalar $\theta\lambda-\lambda^2$, so $\langle v,W^{\#}v\rangle$ (and therefore $D(v)$), is **constant on the unit sphere of every eigenspace**, not merely of $E_{\min}$. Equality for one $v\in E_{\min}$ is equality for all.

Measured: $D(v)$ over three random unit $v\in E_{\min}$ agrees to $\le10^{-16}$ at every point with $\dim E_{\min}>1$, $9,16,25$ at the balanced products, $12,24,40,60$ at the tori, $20$ at $\mathop{\mathrm{ad}}(\mathfrak{su}(3))$, $2$ at $W_{\mathbb{CP}^2}$. **No search for a one-$v$/other-$v$ split is warranted**, and this discharges the record's own eigenspace-constancy obligation for this statistic.

---

## 5. L3, the saturation set. Family CONFIRMED, generalisation REFUTED

### 5.1 A rigidity theorem, replacing the search

> **Theorem (r324).** Let $W\in\mathcal W_n$, $\lVert W\rVert=1$, $Q(W)=\theta W$, and suppose $D(v)=0$ for one unit $v\in E_{\min}$. Then
> **(a)** $\lambda_{\max}=\dfrac{n\lvert\lambda_{\min}\rvert}{n-2}$ and $\theta=(n-1)\lvert\lambda_{\min}\rvert>0$;
> **(b)** $\theta\ge\theta_0(n)$, with equality **iff** $W$ has exactly two eigenvalues, in which case $n$ is even and the multiplicities are forced: $\dim E_{\min}=n^2/4$, $\dim E_{\max}=n(n-2)/4$, the balanced sphere product's own data.

*Proof.* Saturation puts the whole mass $2(n-2)$ on $E_{\min}\times E_{\max}$ (§3, uniqueness of the minimiser), split $(n-2)/(n-2)$ by the symmetry of $t$. Its first moment is therefore $(n-2)(\lambda_{\min}+\lambda_{\max})$. The Weyl input is $\mathop{\mathrm{tr}}\!\big(W\mathop{\mathrm{ad}}(v)^2\big)=2\langle Wv,v\rangle$, i.e. $\sum_{ab}\lambda_at_{ab}=-2\lambda_{\min}$; **derived, not sampled**: with $A$ the matrix of $v$, the $\Lambda^2$ derivation gives $\mathop{\mathrm{tr}}(W\mathop{\mathrm{ad}}(v)^2)=\mathop{\mathrm{tr}}(A^2\mathrm{Ric})+\sum_{ijkl}R_{ijkl}A_{ik}A_{jl}$, the first term dies on $\mathrm{Ric}=0$ and the first Bianchi identity gives $\sum R_{ijkl}A_{ik}A_{jl}=\tfrac12\sum R_{ijkl}A_{ij}A_{kl}=2\langle Wv,v\rangle$. Equating, $(n-2)\lambda_{\max}=-n\lambda_{\min}$, whence (a) via $\theta=\lambda_{\min}+(n-2)\lambda_{\max}$. For (b), $(\lambda_a-\lambda_{\min})(\lambda_{\max}-\lambda_a)\ge0$ summed over the spectrum with $\mathop{\mathrm{tr}}W=0$ gives $1=\sum\lambda_a^2\le-N\lambda_{\min}\lambda_{\max}=\frac{Nn}{n-2}\lambda_{\min}^2=\frac{n^2\theta^2}{2(n-1)(n-2)}$, i.e. $\theta^2\ge\theta_0(n)^2$. Equality forces every $\lambda_a\in\{\lambda_{\min},\lambda_{\max}\}$; $\mathop{\mathrm{tr}}W=0$ with $\lambda_{\max}=n\lvert\lambda_{\min}\rvert/(n-2)$ then pins $d_{\max}=n(n-2)/4$ and $d_{\min}=n^2/4$. $\square$

*Independent checks.* The per-row identity holds to $10^{-9}$ for **arbitrary** unit $v$ on $\mathcal W_n$ at $n=5,6,7$ (eigenvector or not, critical or not) and **fails off $\mathcal W_n$** by $0.19$–$2.0$, which is the control that Weyl membership is what carries it. $\lambda_{\max}(n-2)/(n\lvert\lambda_{\min}\rvert)=1.000000$ at every saturating point and $0.77$–$6.40$ at every non-saturating one. $\theta=(n-1)\lvert\lambda_{\min}\rvert$ is **not** an identity at critical points, ratio $0.31$–$0.42$ at random $n=6$ critical points, so (a) is content, not a rewrite.

### 5.2 What this does to L3's hunt

**Any critical point with $\theta<\theta_0(n)$ cannot saturate; nor can one at $\theta=\theta_0(n)$ with more than two eigenvalues.** That disposes of the whole list the brief asks about, analytically: the $C_5$ blow-up ($0.670820$, $n=10$), the $n=8$ non-diagonal witness ($1.088948<1.145644$) and its siblings, the diagonal $S=0$ ceiling ($0.716134$, $n=12$), $S^3\times S^5$, $S^5\times S^7$ ($1.228239<1.236033$), $\mathbb{CP}^4$ and $\mathbb{CP}^5$, $\mathop{\mathrm{ad}}(\mathfrak{su}(3))$, every maximal torus, and $S^{11}\times S^{13}$ ($1.324617<1.325498$). $\mathbb{CP}^3$ sits *at* $\theta_0(6)=1.054092553$ and is excluded by the equality clause instead, it has three eigenvalues (measured slack $2.108185107$). Corroborated by search: 90 genuine critical points at $n=6$ (criticality $\le8.5\times10^{-16}$, Weyl $\le1.2\times10^{-15}$), $\theta\in[0.390895,0.742003]$, slack $\in[0.577346,1.089611]$, none saturating.

**Consequence worth recording.** On the saturating set, Conjecture A is *equivalent* to "saturation forces exactly two eigenvalues", and the $\ge$ half is now proved.

### 5.3 The refutation: $W_{\mathbb{CP}^2}$ at $n=4$ saturates

Built independently from the Fubini–Study curvature operator and Weyl-projected: Weyl residual $2.3\times10^{-16}$, **criticality residual $5.8\times10^{-16}$**, $\theta=1.224744871=\sqrt{3/2}$, spectrum $(2,-1,-1,0,0,0)/\sqrt6$ (**three** distinct eigenvalues, kernel of dimension 3) and

$$D(v)/\lvert\lambda_{\min}\rvert=0.000000000,\qquad \lambda_{\max}(n-2)/(n\lvert\lambda_{\min}\rvert)=1.000000 .$$

It is a genuine critical Weyl tensor, it saturates Lemma L70, it is not a sphere product and not in the two-eigenvalue family. So **[plan.md](../plan.md)'s T4 as written, "a critical point saturating Lemma L70 is a balanced sphere product, dropping Lemma L23's two-eigenvalue hypothesis", is false**, and the missing hypothesis is a dimension bound, not a spectral one. My theorem explains it exactly: $\theta_0(4)=0.866025<\sqrt{3/2}$, so $n=4$ has room for a saturating point above $\theta_0$, and (b) then permits three eigenvalues. The structural reason is visible: $\Lambda^2\mathbb R^4=\mathfrak{su}(2)\oplus\mathfrak{su}(2)$, $E_{\min}\oplus E_{\max}$ is one $\mathfrak{su}(2)$ split $2+1$, and the other $\mathfrak{su}(2)$ is the kernel and centralises it.

*Also at $n=4$*: the balanced point saturates at $\theta=\theta_0(4)=0.866025404$ with spectrum $(-1,-1,-1,-1,2,2)/(2\sqrt3)$, multiplicities $4=n^2/4$ and $2=n(n-2)/4$, the equality case of (b), exactly. Every padded $W_{\mathbb{CP}^2}$ at $n\ge5$ **stops** saturating: slack $0.816497$, $1.632993$, $2.449490$, $4.082483$, $5.715476$, $6.531973$ at $n=5,6,7,9,11,12$.

### 5.4 Lemma L23's family, every reported number reproduced, and one scoping correction

| point | criticality residual | slack $D/\lvert\lambda_{\min}\rvert$ | mass off $E_{\min}\times E_{\max}$ |
| --- | --- | --- | --- |
| $\mathfrak{so}(m)\oplus\mathfrak{so}(m)$, $n=6,8,10,12$ | $\le3.1\times10^{-16}$ | $0.000000000$ | $0$ of $72,192,400,720$ |
| maximal torus, $n=6,8,10,12$ | $\le1.7\times10^{-16}$ | $1.290994449$, $2.160246899$, $2.846049894$, $3.425395354$ | $\tfrac12,\tfrac23,\tfrac34,\tfrac45=\tfrac{m-2}{m-1}$ |
| $\mathop{\mathrm{ad}}(\mathfrak{su}(3))\subset\mathfrak{so}(8)$ | $2.1\times10^{-16}$ | $0.836660027$ | $80$ of $240$ |

All independently reproduced, digit for digit, including the $\mathbb{CP}^3$ overshoot $2.108185107$. The reduction of saturation on the family to $[\mathfrak m,\mathfrak m]\perp\mathfrak m$ is correct: $\langle v,[\mathfrak h,\mathfrak h]\rangle=0$ because $\mathfrak h$ is a subalgebra and $\mathfrak m\perp\mathfrak h$, and with two eigenvalues the only remaining block is $\mathfrak m\times\mathfrak m$.

**Scoping correction.** The record disqualifies the unbalanced $\mathfrak{so}(p)\oplus\mathfrak{so}(q)$ and $\mathfrak u(m)$ rows as "not critical points" (residuals $5\times10^{-2}$ to $5\times10^{-1}$; I measure $1.1\times10^{-1}$ to $5.7\times10^{-1}$, consistent). **They are further out than that: they are not Weyl tensors at all**, $\lVert W-\Pi_{\mathcal W}W\rVert$ is $0.42$ at $\mathfrak{so}(3)\oplus\mathfrak{so}(5)$, $0.76$ at $\mathfrak{so}(2)\oplus\mathfrak{so}(6)$ and $\mathfrak u(4)$, $1.00$ at $\mathfrak{so}(1)\oplus\mathfrak{so}(7)$. They do have $D=0$ (they are symmetric pairs) and they violate the per-row identity by $0.19$–$2.0$, which is exactly why they escape the theorem of §5.1. Writing them as members of a family inside $\mathcal W_n$ is the misleading part; $\Pi_{\mathfrak h}-\tfrac rNI$ lands in $\mathcal W_n$ only for particular $\mathfrak h$.

---

## 6. What I would put in the record

1. **The theorem of §5.1**, which is T4's $\ge$ half with the two-eigenvalue hypothesis dropped, plus the $n=4$ counterexample that fixes T4's statement.
2. **Withdraw the "control" sentence** in the Hilbert–Schmidt section (§2.3) and record L5 as L1 re-partitioned, with the bridge identity of §2.2.
3. **Re-grade T3.** Its attackability rested on raw material with a measured ceiling of $1.49$/$1.93$ at $n=5,6$ (capped) and $2.04$/$2.76$/$4.19$ at $n=5,6,8$ (uncapped) against $\theta_0$.
4. **Correct L1's hypothesis list** (§3): Weyl membership enters only through $\mathop{\mathrm{tr}}W=0$; unit norm, $\theta>0$, $n\ge5$ and $\ker W=0$ are not needed.
5. **L2 needs no check**, $W^{\#}=\theta W-W^2$ makes it immediate on every eigenspace.

**Scripts:** [scripts/reviewers/r324/](../scripts/reviewers/r324/), [core.py](../scripts/reviewers/r324/core.py), [points.py](../scripts/reviewers/r324/points.py), [kahler.py](../scripts/reviewers/r324/kahler.py), [t_l1_l5.py](../scripts/reviewers/r324/t_l1_l5.py), [t_hyp.py](../scripts/reviewers/r324/t_hyp.py), [t_moment.py](../scripts/reviewers/r324/t_moment.py), [t_sat.py](../scripts/reviewers/r324/t_sat.py), [t_search.py](../scripts/reviewers/r324/t_search.py), [t_lp.py](../scripts/reviewers/r324/t_lp.py), [t_lp2.py](../scripts/reviewers/r324/t_lp2.py). Log: [agent_logs/r324-lemma70.log](../agent_logs/r324-lemma70.log).
