# Review r110, fence post F25, the $g$-weighted reformulation

**Split verdict. The algebra is CONFIRMED; the consequence drawn from it is REFUTED.**

| part of post F25 | verdict |
|---|---|
| The expansion of $(\lambda_\alpha-\lambda_\beta)^2$, its factors of $2$, the index roles in the per-row substitution, the collapse to $\theta=p_3+\langle W^\#,W\rangle$ | **CONFIRMED**, every step to $\le6\times10^{-15}$ at $n=5,6,7$ |
| "The reformulation $\theta=-(n-1)\mathbb E_g[\lambda]$ is inert" | **CONFIRMED but already on record** since 2026-08-23, and near-vacuous |
| "Exploiting $g$'s internal structure cannot sharpen the recorded bound" | **REFUTED**, over-reach from one weight to a class |
| "The bound already uses everything $g$ offers, namely $g\ge0$ and $\sum g=4(n-1)$" | **REFUTED**, false about the record's own bound, two days before post F25 was written |

Independent implementation: [r110_g_collapse.py](../scripts/reviewers/r110/r110_g_collapse.py). Conventions were fixed from the brief alone ($\phi_{ij}=E_{ij}-E_{ji}$ with $\langle A,B\rangle=\tfrac12\operatorname{tr}(A^{\mathsf T}B)$, so the eigenframe is orthonormal in $\mathfrak{so}(n)$), and $g_\gamma$ was computed **directly** as $\lVert[\mathrm{ad}(v_\gamma),W]\rVert^2$ rather than through Prop 1.7, so the Prop 1.7 check is a real check.

## 1. The algebra: confirmed, with one scope correction

Random $\mathrm{Weyl}_n$ points, $n=5,6,7$, worst residual over all trials:

| quantity | residual |
|---|---|
| Weyl symmetries + first Bianchi + trace-free | $6.7\times10^{-16}$ |
| Prop 1.7 vs. $g$ computed directly from $\mathrm{ad}$ | $4.2\times10^{-15}$ |
| $\sum_\gamma g_\gamma-4(n-1)$ | $3.6\times10^{-15}$ |
| $\sum_\gamma\lambda_\gamma g_\gamma+4\theta$ | $4.4\times10^{-15}$ |
| per-row $\max_\alpha\lvert\sum_\beta\lambda_\beta R_{\alpha\beta}+2\lambda_\alpha\rvert$ | $2.9\times10^{-15}$ |
| $T$ total symmetry, $R$ symmetry | $9.0\times10^{-16}$ |
| $\sum\lambda_\gamma g_\gamma-\big(2\sum\lambda_\gamma\lambda_\alpha^2R_{\gamma\alpha}-2\sum\lambda_\gamma\lambda_\alpha\lambda_\beta T_{\gamma\alpha\beta}\big)$ | $6.1\times10^{-15}$ |
| first term $+2p_3$ | $8.2\times10^{-16}$ |
| second term $-2\langle W^\#,W\rangle$ | $0$ |

Both factors of $2$ are right, and the assembly is right: $2(-2p_3)-2(2\langle W^\#,W\rangle)=-4\theta$. The per-row substitution is applied in the legal direction, $R$ is symmetric, so $\sum_\gamma\lambda_\gamma R_{\gamma\alpha}=-2\lambda_\alpha$ follows from the recorded form with $\gamma$ and $\beta$ interchanged, and the numerics confirm it at every $\alpha$.

**Scope correction, minor.** The post says the expansion needs $T$ *totally* symmetric. It does not. Merging $\lambda_\alpha^2$ and $\lambda_\beta^2$ into the factor $2$ needs only symmetry in the **last two slots**. Total symmetry is needed one step later, to know $R$ is symmetric so the per-row identity fires with $\gamma$ summed. Both hold, $\langle[X,Y],Z\rangle$ is totally antisymmetric by invariance of the trace form, so its square is totally symmetric, so nothing breaks; the stated prerequisite is simply stronger than the step uses.

**One further ingredient the post leaves implicit.** The row marginal $\rho_\alpha=\sum_{\beta\gamma}T_{\alpha\beta\gamma}=2(n-2)$ (residual $3.6\times10^{-14}$), the Killing constant of fence post F18. It is not needed at weight $\lambda$, but it is the whole content at weight $1$, see below, where it decides the consequence.

## 2. The reformulation is inert, and that was already the record

$\theta=-(n-1)\mathbb E_g[\lambda]$ is $\sum\lambda g=-4\theta$ divided by $\sum g=4(n-1)$. A rearrangement of two identities carries the information of those two identities; expecting otherwise would be an error nobody in the record made. And [findings/bounds.md](../findings/bounds.md) already said the sharper thing on **2026-08-23**, three days before post F25 (commit `096a02d`):

> any contraction of Prop 1.7 against a $\gamma$-independent weight recovers only Lemma L30/31, and **the very next weight returns $\theta$ itself**

That entry also scoped itself correctly (*"Only the **unweighted** sum is inert"*) which is exactly the discipline post F25 drops.

## 3. The consequence is over-reach, on four independent grounds

### 3a. The collapse is a fact about ONE weight, and the neighbouring weight is a constraint the bound actually uses

Prop 1.7 is $N=\binom n2$ equations, one per $\gamma$. Post F25 contracts them against $\lambda_\gamma$ and gets a tautology. Contract the *same* three ingredients, Prop 1.7, the per-row identity, $\rho=2(n-2)$, against the weight $1$ instead:

$$\sum_\gamma g_\gamma=2\sum_\alpha\lambda_\alpha^2\rho_\alpha-2\sum_{\alpha\beta}\lambda_\alpha\lambda_\beta R_{\alpha\beta}=4(n-2)+4=4(n-1),$$

which is **not** $\theta$'s definition and **is** one of the two facts the recorded bound runs on. Against $\lambda_\gamma^2$ one gets a third quantity matching neither ($\sum\lambda^2g=1.099$, $1.206$ at two $n=6$ points, against $\theta$, $p_3$, $\operatorname{tr}M^4$, no match). So the same substitution is *productive* at weight $0$, *tautological* at weight $1$, and *neither* at weight $2$. A tautology at one weight of a family is no obstruction at the others; the post generalises from one to all with no argument.

### 3b. The premise about the recorded bound is false, and the record refutes it two days earlier

"The bound uses only $g\ge0$ and $\sum g=4(n-1)$" is wrong. $\Delta:=\sum_{\gamma\in\mathfrak p}g_\gamma$ and $G_0:=\sum_{\gamma\in\ker W}g_\gamma$ are **the distribution of $g$ across the eigenvalues**, binned by sign, strictly more than the total. And the record's own strengthening ([findings/target.md](../findings/target.md), commit `1c0f1d2`, **2026-08-24**) goes further still:

$$\theta\le\frac{|\lambda_{\min}|M-\lambda_{\mathfrak p}^{\min}\Delta}{4},\qquad M=4(n-1)-\Delta-G_0,$$

which retains the $\mathfrak p$-part of $\sum\lambda g$ instead of discarding it, and is strictly sharper whenever $\Delta>0$ (measured: $0.776\to0.768$ and $1.265\to1.164$ at $n=6,8$ random points). **That is a sharpening of the recorded bound obtained by exploiting more of $g$'s distribution (the exact thing post F25 declares impossible), recorded two days before post F25 and living three paragraphs from the bound post F25 cites.**

### 3c. A constructive counterexample: a strictly sharper bound, from $g$'s internal structure, still exact at the conjectured maximiser

From Prop 1.7 with $T\ge0$ and $\rho_\gamma=2(n-2)$, in one line,

$$g_\gamma\le(\lambda_{\max}-\lambda_{\min})^2\rho_\gamma=2(n-2)(\lambda_{\max}-\lambda_{\min})^2=:K .$$

This is a per-coordinate **cap**, provably outside $\{g\ge0,\ \sum g=4(n-1)\}$, and it is not $\theta$'s definition. Feeding it into the same LP that produces the recorded bound (verified valid at every point, $g_{\max}\le K$ throughout):

| point | $\theta$ | $\lvert\lambda_{\min}\rvert(n-1)$ | with the cap | $B_{\text{rec}}$ | $B_{\text{rec}}$ + cap |
|---|---|---|---|---|---|
| random $n=6$ | $-0.080$ | $2.163$ | $\mathbf{1.847}$ | $0.776$ | $\mathbf{0.754}$ |
| random $n=6$ | $-0.083$ | $2.104$ | $\mathbf{1.722}$ | $0.913$ | $\mathbf{0.888}$ |
| random $n=7$ | $\ \ 0.081$ | $2.146$ | $\mathbf{1.754}$ | $1.220$ | $\mathbf{1.113}$ |
| random $n=8$ | $-0.035$ | $2.409$ | $\mathbf{1.948}$ | $1.265$ | $\mathbf{1.155}$ |
| $S^6\times S^6$ | $\ \ 1.236033$ | $1.236033$ | $1.236033$ | $1.236033$ | $1.236033$ |

The a priori form sharpens by $15$–$25\%$ and the $\Delta$-aware form by $2$–$12\%$, and **the sharpening costs nothing at the conjectured maximiser**: on the whole balanced family $S^k\times S^k$, $k=3,4,5,6,8,10$, the cap is saturated exactly ($g_{\max}/K=1.000000$) and the capped bound returns $\theta_0(2k)$, $1.054093$, $1.145644$, $1.200000$, $1.236033$, $1.280869$, $1.307670$, to machine precision. A bound that is strictly better off the family and exactly tight on it is a sharpening by any reading of the word.

### 3d. The post's own carve-out contradicts its fence

Post F25 closes by exempting *"the per-row identity used directly"*. But the per-row identity is a statement about $T$, and $g$ **is** $T$ contracted against $\lambda$, Prop 1.7 is the definition that makes "$g$'s internal structure" mean anything at all. So the exempted item is a member of the fenced class. The record already cashed that exemption: $\lambda_{\max}\le(n-2)|\lambda_{\min}|$ ([findings/target.md](../findings/target.md)) is derived from the per-row identity plus $\rho=2(n-2)$, i.e. from $g$'s internal structure, and it constrains $|\lambda_{\min}|$, *the one uncontrolled input of the very bound post F25 says cannot be sharpened*. Likewise the entire $\Delta$ programme, the record's best discriminator, is a statement about the **support** of $g$. Read literally, the fence closes the live lead.

## 4. What is actually true, and how the post should read

There **is** a real obstruction near here, and it is not the collapse. It is Reviewers 67/68's LP ceiling: relaxing over $T$ subject to its marginals and pair caps has a global ceiling of $1.60/2.29/2.49$ at $n=6,8,12$, above $\sqrt{3/2}$. The cap of §3c lives inside that class, so it sharpens pointwise and cannot close. Post F25 borrows that conclusion and attributes it to the collapse, which supports nothing of the kind. **"Cannot sharpen" and "cannot close" are different claims; the collapse proves neither.**

Suggested replacement wording:

> The $\lambda$-weighted contraction of Prop 1.7 returns $\theta$'s definition, so the reformulation $\theta=-(n-1)\mathbb E_g[\lambda]$ carries no information beyond the two identities it is built from. **This is specific to the weight $\lambda_\gamma$**: weight $1$ returns $\sum g=4(n-1)$, which the bound uses, and weight $\lambda^2$ returns a third quantity. Sharpenings from $g$'s distribution, support and per-coordinate caps remain available and some are already on record; what they cannot do is *close* Conjecture A, because they sit inside the spectrum-plus-$T$-marginals class whose ceiling Reviewers 67/68 fixed at $1.60/2.29/2.49$.

## 5. Cosmetic

- The post names the first term as $\sum_{\gamma\alpha}\lambda_\gamma\lambda_\alpha^2R_{\gamma\alpha}$ without the coefficient $2$ the expansion carries, then quotes its collapsed value $-2p_3$ consistently without it. Internally consistent, but a reader reassembling $-4\theta$ has to restore the factor.
- $p_3(\mu)$ in the post is $p_3(\lambda)=\operatorname{tr}(M^3)$ elsewhere; one symbol, two names.
