# Reviewer 125, the vertex equation, the top-eigenvector pairing, and fence post F29

Adversarial audit of the three claims recorded in [target.md](../findings/target.md) under "The diagonal proof's ENGINE lifts to any critical point", indexed as fence post F29 in [findings/INDEX.md](../findings/INDEX.md). Derivations first, numerics second, and the numerics were produced from a library written from scratch for this review ([r125_lib.py](../scripts/reviewers/r125_lib.py)) rather than from the repo's own machinery.

| Claim | Verdict |
|---|---|
| 1. The vertex equation, and its identification with $S^{\circ2}+S^2=\lambda S+D$ | **CONFIRMED**, including the $D$ term |
| 2. The $(W^\#)_{abab}$ formula and the $v\otimes v$ pairing | **CONFIRMED**, derived independently and exact to $1.1\times10^{-16}$ at eight points |
| 3. The closure, "both corrections are non-negative and add" | **REFUTED as stated.** The conclusion survives, on a different and much stronger mechanism |
| Method claim: $N_{ik}=\lvert W\rvert^2\delta_{ik}/n$ at $n=4$, failing from $n\ge5$ | **CONFIRMED** independently |

---

## Claim 1, the vertex equation. Confirmed, and the $D$ term is the row-norm diagonal

Reading the $((ab),(ab))$ entry of $Q(W)=\lambda W$ is immediate: $(W^2)_{(ab)(ab)}=\sum_{(cd)}W_{abcd}^2=K_{ab}^2+R_{ab}$ splits off the diagonal square by definition, so

$$K_{ab}^2+R_{ab}+(W^\#)_{abab}=\lambda K_{ab},\qquad R_{ab}=\sum_{(cd)\ne(ab)}W_{abcd}^2\ge0 .$$

The bookkeeping $\sum_{a<b}R_{ab}=1-t/2$ is $\lVert W\rVert_F^2$ minus the diagonal, since $\sum_{a<b}K_{ab}^2=t/2$. **Both are correct.** Maximum residual over $\mathbb{CP}^3$, $\mathbb{CP}^4$, $S^3\times S^3$, $S^4\times S^4$ and $S^3\times S^5$: $3.7\times10^{-16}$. At three numerically located non-diagonal critical points it is $1.5\times10^{-14}$, tracking the $10^{-13}$ criticality tolerance of the search rather than the identity.

**The identification with the record's diagonal equation is correct, and $D$ is forced.** At a diagonal point $A^a=\mathop{\mathrm{diag}}(K_{a\cdot})$ gives $(W^\#)_{abab}=(K^2)_{ab}$, so for $a\ne b$ the vertex equation is exactly $(K^{\circ2})_{ab}+(K^2)_{ab}=\lambda K_{ab}$. The matrix statement $S^{\circ2}+S^2=\lambda S+D$ then holds with

$$D=\mathop{\mathrm{diag}}\big(\mathop{\mathrm{diag}}(K^2)\big),\qquad D_{aa}=\sum_pK_{ap}^2,$$

because $\Lambda^2$ has no $(aa)$ index: the vertex equation says nothing at $a=b$, and $D$ is precisely the slack that makes the off-diagonal system into a matrix identity. **This matters for claim 3**, see below, where $D$ turns out to be half of the engine.

## Claim 2, the $\#$-formula and the pairing. Confirmed, derived from the structure constants

$\mathop{\mathrm{ad}}_{\phi_{ab}}$ is the infinitesimal rotation of the $(a,b)$-plane: it exchanges $\phi_{ap}\leftrightarrow\phi_{bp}$ for $p\ne a,b$ and annihilates everything else, so $c_{(ab)\mu\nu}$ is supported on those pairs with coefficient $\mp1$. Feeding that into $(R^\#)_{\alpha\beta}=\tfrac12c_{\alpha\mu\nu}c_{\beta\rho\sigma}R_{\mu\rho}R_{\nu\sigma}$ gives four terms that collapse in pairs to

$$(W^\#)_{abab}=\sum_{p,q\ne a,b}\big(W_{apaq}W_{bpbq}-W_{apbq}W_{bpaq}\big)=\langle A^a,A^b\rangle-\mathop{\mathrm{tr}}\big((B^{ab})^2\big),$$

the last step using $B^{ba}=(B^{ab})^{\!\top}$, which is pair symmetry. **The restriction $p,q\ne a,b$ can be dropped for free**: every excluded term has a factor $W_{aaaq}$, $W_{bbbq}$, $W_{apba}$ or $W_{bpab}$ and vanishes. So the record's unrestricted sums are right.

**The pairing is right, and there is a subtlety in it worth naming.** The vertex equation exists only for $a\ne b$, yet the record sums $v_av_b$ over all $a,b$. This is legitimate: at $a=b$ every term is zero or cancels, $K_{aa}=0$, $R_{aa}=0$, and $\langle A^a,A^a\rangle-\mathop{\mathrm{tr}}((B^{aa})^2)=\lVert A^a\rVert_F^2-\lVert A^a\rVert_F^2=0$ since $B^{aa}=A^a$ is symmetric. **The formal $a=b$ equation is $0=0$**, so extending the sum is harmless. It is also not free of consequence, and that is the crux of claim 3.

$\mathop{\mathrm{diag}}(G)_p=\sum_av_aW_{apap}=(Kv)_p$ holds for every $W$, with no criticality and no eigenvector assumption; with $Kv=\mu_Kv$ and $\lvert v\rvert=1$ it gives $\lVert G\rVert_F^2=\mu_K^2+\lVert G_{\text{off}}\rVert_F^2$. **Confirmed**, residual $\le7.7\times10^{-16}$ over eight points and both eigenvector choices.

---

## Claim 3, REFUTED as stated. There are five corrections, not two, and neither named term does the work

### The identity, decomposed so that the signs are visible

Split the bracket of claim 2 into its $a=b$ and $a\ne b$ parts and use $\lVert A^a\rVert_F^2=\sum_pK_{ap}^2+\lVert A^a_{\text{off}}\rVert_F^2$. What comes out is

$$\boxed{\ \lambda\mu_K-\mu_K^2=\underbrace{\lVert G_{\text{off}}\rVert_F^2}_{\ \ge0}+\underbrace{v^{\!\top}\!Rv}_{\text{unsigned}}-\underbrace{\mathrm{Dir}}_{\ \ge0}-\underbrace{\Sigma_A}_{\ \ge0}-\underbrace{\Sigma_B}_{\text{unsigned}}\ }$$

$$\mathrm{Dir}=\tfrac12\sum_{a,b}K_{ab}^2(v_a-v_b)^2=v^{\!\top}Lv,\quad L=D-K^{\circ2}\succeq0,\qquad \Sigma_A=\sum_av_a^2\lVert A^a_{\text{off}}\rVert_F^2,\qquad \Sigma_B=\sum_{a\ne b}v_av_b\mathop{\mathrm{tr}}\big((B^{ab})^2\big).$$

Three things follow at once.

- **$D$ is a graph Laplacian and that is the whole diagonal proof.** On the diagonal locus $\lVert G_{\text{off}}\rVert^2=v^{\!\top}Rv=\Sigma_A=\Sigma_B=0$ and the identity is $\lambda\mu_K=\mu_K^2-v^{\!\top}Lv$ with $L\succeq0$. Since this holds for *every* unit $v$ with $\mu_K$ read as $v^{\!\top}Kv$ and $\mu_K^2$ as $\lVert Kv\rVert^2$, the diagonal statement is really the matrix inequality $K^2-\lambda K\succeq0$: **$K$ has no eigenvalue in $(0,\lambda)$.** The statement has content: at $S^3\times S^3$ the spectrum of $K$ is $(-0.316228^{\times4},\,0,\,1.264911)$ against $\lambda=1.054093$, so the gap $(0,\lambda)$ is genuinely straddled and $\min\mathop{\mathrm{eig}}(K^2-\lambda K)=0$ is attained on the kernel direction $\mathbf1$. The general-$v$ identity is verified to $2.2\times10^{-16}$ at $S^3\times S^3$ and $1.8\times10^{-14}$ at a non-diagonal critical point, over eight random non-eigenvector directions each, and $K^2-\lambda K\succeq0$ holds to $2.6\times10^{-16}$ at seven sphere products, where in addition $\lambda=\frac{n-1}n\mu_K$ holds *exactly*, ratio $1.000000$ at $S^3\times S^3$, $S^4\times S^4$, $S^5\times S^5$, $S^6\times S^6$, $S^3\times S^4$, $S^4\times S^5$ and $S^2\times S^4$.
- **$\Sigma_A$ is the term the record loses.** [target.md](../findings/target.md) *does* carry $\mathrm{Dir}$, but only inside the diagonal collapse $\lambda\mu=\mu^2-\mathrm{Dir}$; when the general identity is written out, $\mathrm{Dir}$ is dropped and $\Sigma_A$ (its partner, the off-diagonal excess of $A^a$ over its diagonal, $\ge0$ and subtracted), never appears at all. Off the diagonal locus $\mathrm{Dir}$ does not vanish and $\Sigma_A$ switches on, so the general identity has *more* negative content than the diagonal one, not less.
- **$v^{\!\top}Rv$ is not signed.** $R_{ab}\ge0$ entrywise, but $v$ is an eigenvector of a hollow trace-zero matrix and therefore sign-mixed. The record's "$R\ge0$" is a statement about the entries and is silently promoted to a statement about the quadratic form.

### The measurements, and they contradict the fence post at its own evidence points

| point | $n$ | $\lambda$ | $\mu_K$ | $\lambda\mu_K-\mu_K^2$ | $\lVert G_{\text{off}}\rVert^2$ | $v^{\!\top}Rv$ | $-\mathrm{Dir}$ | $-\Sigma_A$ | $-\Sigma_B$ | $t$ |
|---|---|---|---|---|---|---|---|---|---|---|
| $\mathbb{CP}^3$ | 6 | 1.054093 | +0.474342 | **+0.275000** | **0** | +0.104167 | −0.037500 | **0** | **+0.208333** | 0.750 |
| $\mathbb{CP}^4$ | 8 | 0.986013 | +0.338062 | **+0.219048** | **0** | +0.097222 | −0.014286 | **0** | **+0.136111** | 0.600 |
| crit, random start | 6 | 1.224745 | +0.222647 | +0.223114 | +0.260859 | **−0.013884** | −0.032508 | −0.138775 | +0.147422 | 0.103 |
| crit, random start | 8 | 1.224745 | +0.299649 | +0.277204 | +0.177078 | +0.046109 | −0.026244 | −0.077824 | +0.158085 | 0.152 |
| crit, random start | 8 | 1.145644 | +0.193037 | +0.183889 | +0.205613 | **−0.025135** | −0.009623 | −0.065212 | +0.078245 | 0.064 |
| $S^3\times S^3$ | 6 | 1.054093 | +1.264911 | −0.266667 | 0 | 0 | −0.266667 | 0 | 0 | 2.000 |
| $S^4\times S^4$ | 8 | 1.145644 | +1.309307 | −0.214286 | 0 | 0 | −0.214286 | 0 | 0 | 2.000 |

Every row closes to $\le3.4\times10^{-15}$. Read the two bolded columns.

- **At $\mathbb{CP}^3$ and $\mathbb{CP}^4$ (the fence post's only two cited data points), $\lVert G_{\text{off}}\rVert^2$ is exactly $0$, and $\Sigma_A$ is exactly $0$.** The excess is carried by $-\Sigma_B$ (76% at $\mathbb{CP}^3$, 62% at $\mathbb{CP}^4$), a term the fence post never names, with $v^{\!\top}Rv$ supplying the rest. So the first of the two "corrections that add" contributes nothing at either point offered as evidence for it. The record already knows this, the very next paragraph of [target.md](../findings/target.md) calls $\lVert G\rVert^2=\mu_K^2$ "a symmetric-sample artefact", so **the file contradicts itself two paragraphs apart**, and the fence post is on the wrong side of its own correction.
- **At genuine non-diagonal critical points, $v^{\!\top}Rv$ is negative** ($-0.0139$ at $n=6$, $-0.0251$ at $n=8$), i.e. the second of the two named corrections runs the *other* way. At those points $\lVert G_{\text{off}}\rVert^2$ does the work and $\Sigma_A$ eats a third of it back.
- **At random Weyl tensors the claimed direction is the minority outcome.** Over 200 draws per dimension, with $v$ the top eigenvector of $K$: $v^{\!\top}Rv<0$ in 198/200 at $n=5$ and 200/200 at $n=6,7,8$; the *net* correction $\lambda\mu_K-\mu_K^2$ is negative in 72%, 79%, 84%, 78% of draws at $n=5,6,7,8$.

**So the mechanism as written ("both corrections are non-negative and both add"), is false in every regime tested.** The conclusion it supports happens to be true, which is why the error survived.

### What actually closes the route, and it is stronger and sign-free

Two facts, neither of which needs any correction to be signed.

**(i) $t\le2$, with equality exactly on the diagonal locus.** $t=2\sum_{a<b}M_{(ab)(ab)}^2\le2\lVert M\rVert_F^2=2$, and $\sum_{a<b}R_{ab}=1-t/2$ makes $t=2-2\sum R$ a direct measure of off-diagonality. Since $\mu_{\max}(K)\le\lVert K\rVert_F=\sqrt t$, **the vertex bound $\lambda\le\mu_{\max}(K)$ requires $t\ge\lambda^2$, i.e. $\sum_{a<b}R_{ab}\le1-\lambda^2/2$.** At $\lambda=\sqrt{3/2}$ that is $\sum R\le0.25$; the measured value is $0.9483$, $0.9241$ and $0.9678$ at the three located non-diagonal critical points, and $0.625$ and $0.700$ at $\mathbb{CP}^3$ and $\mathbb{CP}^4$, against $0$ at every sphere product. The route does not fail by a sign, it fails because $K$ stops carrying $W$'s norm.

**(ii) $\lambda$ is $O(n)$-invariant and $\mu_{\max}(K)$ is not.** $K$ is the coordinate diagonal of $W$, so $\lambda\le\mu_{\max}(K)$, if it were a theorem about critical points, would have to hold in every frame. It does not hold in almost any frame, **even at the conjectured maximiser**: at $S^3\times S^3$, where the bound holds comfortably in the canonical frame ($\mu_{\max}=1.264911$ against $\lambda=1.054093$), 3000 random frames give $\mu_{\max}(K)$ with median $0.303$ and range $[0.073,1.063]$ (the bound fails in every one of them) and a crude anneal drives $\mu_{\max}(K)$ to $0.0123$ and $t$ to $0.017$. At $S^4\times S^4$: median $0.252$, annealed minimum $0.035$.

*So the diagonal argument is a statement about the distinguished frame in which $W$ is diagonal, and off the diagonal locus that frame does not exist.* There is nothing to lift, and the obstruction is neither looseness nor orientation but the absence of the object the argument is about. The measured failures of the conclusion itself confirm this: $\lambda/\mu_{\max}(K)$ is $2.22$ at $\mathbb{CP}^3$, $2.92$ at $\mathbb{CP}^4$, $5.50$ and $4.09$ and $5.94$ at the three located non-diagonal critical points. Against the record's sharper diagonal form $\lambda\le\frac{n-1}n\mu_K$ the $\mathbb{CP}^3$ factor is $2.667$, confirming the recorded $2.7$.

---

## The questions the brief poses

**(a) Is the bracketed third term signed? No, and neither is the $R$ term.** The bracket decomposes as $-\mathrm{Dir}-\Sigma_A-\Sigma_B$ with $\mathrm{Dir},\Sigma_A\ge0$ and $\Sigma_B$ of either sign, so it carries a structurally negative part that fence post F29 omits entirely. Measured: the bracket is negative at both $\mathbb{CP}^3$-type points via $\Sigma_B$ favourably ($-\Sigma_B=+0.208$, +0.136) and negative overall at random Weyl tensors in 59/60 draws at $n=6$ and 60/60 at $n=8$. **The "both corrections add" reading is wrong and the post is over-broad about its own mechanism.** It is not, however, wrong about the outcome, the corrections happen to sum positive at the catalogued critical points, for reasons the post does not identify.

**(b) Is the top eigenvector load-bearing? Yes, and the bottom gives nothing.** The top is needed at the division step: $\lambda\mu_K\le\mu_K^2$ yields $\lambda\le\mu_K$ only when $\mu_K>0$. At the bottom eigenvector $\mu_{\min}<0<\lambda$, so $\lambda\mu_{\min}<0<\mu_{\min}^2$ **forces** the corrections to sum negative, no computation needed, and this alone refutes "both corrections are non-negative", since $\lVert G_{\text{off}}\rVert^2\ge0$ always. The resulting inequality $\lambda\ge\mu_{\min}$ is vacuous. A **general** unit $v$ is the most informative choice and is not used: $\mathop{\mathrm{diag}}(G)=Kv$ without any eigenvector hypothesis, so the identity reads $\lambda\,v^{\!\top}Kv=\lVert Kv\rVert^2+\lVert G_{\text{off}}\rVert^2+v^{\!\top}Rv-\mathrm{Dir}-\Sigma_A-\Sigma_B$, which on the diagonal locus is the full matrix statement $K^2-\lambda K\succeq0$ rather than one scalar. **That generalisation is free and the record does not record it.**

**(c) Does the argument need $\mu_{\max}(K)>0$? Yes, and it is guaranteed but worthless.** $K$ is hollow, so $\mathop{\mathrm{tr}}K=0$, so $\mu_{\max}>0>\mu_{\min}$ whenever $K\ne0$, this comes from hollowness, not from Ricci-flatness, which supplies the separate fact $K\mathbf1=0$. The guarantee is empty because there is no frame-independent floor: the anneal above pushes $\mu_{\max}(K)$ to $1.2\times10^{-2}$ and $t$ to $1.7\times10^{-2}$ at a point where $\lambda=1.054$. **Positivity holds; usable positivity does not.**

**(d) Is fence post F29 too strong? Yes, it closes one pairing, not the vertex equation.** What is genuinely closed is the target $\lambda\le\mu_{\max}(K)$ (and a fortiori $\lambda\le\frac{n-1}n\mu_K$), which is *false* at $\mathbb{CP}^3$, $\mathbb{CP}^4$ and three located non-diagonal critical points, by factors $2.2$ to $5.9$. That is a refutation of the conclusion and no argument can reach it. What is **not** closed:

- the same equation paired with a **general** test vector or test matrix, which on the diagonal locus gives strictly more ($K^2\succeq\lambda K$) than the top-eigenvector scalar;
- other contractions of the vertex equation entirely, e.g. summing it over $a<b$, which recovers $\mathop{\mathrm{tr}}(W^\#)=-\lVert W\rVert^2$.

The **frame-optimised** version, $\lambda\le\sup_{O\in O(n)}\mu_{\max}(K_{O\cdot W})$, is the one crack worth naming and it is shut at $\mathbb{CP}^3$: annealing *upward* over $O(6)$ returns $\mu_{\max}(K)=0.474339$ and $t=0.749957$, i.e. the canonical frame already maximises both, leaving the gap factor at $2.222$. That is one point, not a proof, but the crack is not open in the obvious place.

**Fence post F29 should be rewritten, not deleted.** Its verdict stands; its stated reason should be replaced by (i) and (ii) above, its scope narrowed to the top-eigenvector pairing in a fixed frame, and its evidence changed, $\mathbb{CP}^3$ and $\mathbb{CP}^4$ are the two worst possible witnesses for the mechanism it names, since $\lVert G_{\text{off}}\rVert^2$ and $\Sigma_A$ both vanish there identically.

---

## Method-claim audit: $N_{ik}=\lvert W\rvert^2\delta_{ik}/n$

**Confirmed, independently.** With $N_{ik}=\sum_{mpq}W_{impq}W_{kmpq}$ and $\lvert W\rvert^2=\sum_{ijkl}W_{ijkl}^2=4\lVert W\rVert_F^2$:

| $n$ | 4 | 5 | 6 | 7 |
|---|---|---|---|---|
| worst relative deviation of $N$ from $\lvert W\rvert^2I/n$, 5 random Weyl | $3.5\times10^{-16}$ | $0.327$ | $0.360$ | $0.322$ |

$\mathop{\mathrm{tr}}N=\lvert W\rvert^2$ identically at every $n$, so the trace is not the content and the claim is entirely about isotropy. The $n=4$ case is the classical $C_{ipqr}C_{jpqr}=\tfrac14\delta_{ij}\lvert C\rvert^2$ identity and the identification is right. Figures agree with [random_control.py](../scripts/random_control.py) ($0.343$, $0.326$, $0.272$ at $n=5,6,8$) to within sampling.

One wording note on the same file: its claim that "$G$'s off-diagonal part carries 86–95% of the norm" is a **worst case over 20 draws**, not typical. Over 200 draws per dimension the mean of $\lVert G_{\text{off}}\rVert^2/\lVert G\rVert^2$ is $0.537$, $0.547$, $0.561$, $0.593$ at $n=5,6,7,8$, a norm ratio near $0.75$, with the maximum norm ratio reaching $0.97$. The conclusion is unaffected; the number should be labelled as a maximum.

---

## Scripts

[r125_lib.py](../scripts/reviewers/r125_lib.py) (structure constants, $\#$ two ways, Weyl basis by nullspace, dimensions $10,35,84,300$ at $n=4,5,6,8$ match $(n+2)(n+1)n(n-3)/12$), [r125_core.py](../scripts/reviewers/r125_core.py) (claims 1 and 2 at $\mathbb{CP}^m$), [r125_probe.py](../scripts/reviewers/r125_probe.py) (sign census, critical-point search), [r125_decomp.py](../scripts/reviewers/r125_decomp.py) (the five-term decomposition), [r125_nik.py](../scripts/reviewers/r125_nik.py), [r125_frame2.py](../scripts/reviewers/r125_frame2.py) and [r125_tmax.py](../scripts/reviewers/r125_tmax.py) (frame dependence).
