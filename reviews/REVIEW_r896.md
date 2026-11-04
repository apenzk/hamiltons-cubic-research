# Review r896, the Fox product is closed on the Weyl module, and the cycle's claim is a false alarm

**This round checked an argument, not a lemma.** The argument under audit is the one recorded in [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) and in commit `20849418`, that closure of $\circ$ on $\mathcal W_n$ is unestablished and that [Lemma L206](../findings/bounds.md)'s $L_e$ may therefore not be an operator on $\mathcal W_n$ at all. **It is refuted on both halves: $\circ$ IS closed, and the record states so in five places, one of them a verbatim transcription of the primary source.** I read [WeylReal.lean](../lean/HamiltonsCubic/Base/WeylReal.lean), [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean), [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean), [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean), [conventions.md](../findings/conventions.md), [bounds.md](../findings/bounds.md)'s L206, [problem.md](../findings/problem.md), the two reference note files below, and five $L_e$ implementations in [scripts/lib/](../scripts/lib/). I computed in exact rational arithmetic, transcribing WeylReal's own `inner2`, `phi`, `Ric`, `bianchi`, `sharpQF`, `sharpBil`, `sharpOp`, `compOp` and `Qop` line by line: the normalisation anchor $\mathrm{id}^\#=(n-2)\mathrm{id}$ at $n=4,5,6$; $Q$ at the Weyl tensor of $S^2\times S^2$; $Q$ at generic rational Weyl tensors at $n=4$ and $n=5$; closure of $\circ$ over **all 55 pairs of a basis of $\mathcal W_4$**, which is a proof on all of $\mathcal W_4$ by bilinearity; the Ricci obstruction identity on Bianchi tensors that are not Ricci-flat at $n=4,5$; and $L_e$ at $S^2\times S^2$ over three candidate carriers. Log: [agent_logs/review-r896-closure.log](../agent_logs/review-r896-closure.log).

## Claims

| # | Item | Verdict | Reason |
|---|------|---------|--------|
| 1 | the four `IsWeyl` clauses on $Q(X)$, one at a time | **ALL FOUR HOLD**, so the cycle's claim is REFUTED | skew-to-skew is free because `sharpOp` returns a combination of $\varphi$'s and `compOp` iterates a skew-preserving map, self-adjointness is free because `sharpBil` is a symmetric polarisation and $\langle R(RX),Y\rangle=\langle RX,RY\rangle$, first Bianchi holds on the sum by Hamilton's lemma, Ricci-flatness holds because the obstruction is linear in $\mathrm{Ric}(X)$ |
| 2 | Ricci-flatness of $Q(X)$, the two halves separately | **FORCED TO VANISH, and neither half vanishes alone** | $\mathrm{Ric}(X^2)_{bd}=\tfrac12\sum_{c,k,l}X_{bc,kl}X_{dc,kl}$ is positive definite on the diagonal, and first Bianchi forces $\mathrm{Ric}(X^\#)=-\mathrm{Ric}(X^2)$ exactly, verified exact at three Weyl tensors and pinned by $\mathrm{Ric}(Q(R))_{ab}=\sum_{cd}R_{acbd}\mathrm{Ric}(R)_{cd}$ with coefficient $1$ on Bianchi tensors with $\mathrm{Ric}\ne0$ at $n=4,5$ |
| 3 | first Bianchi for $Q(X)$, the two halves separately | **PRESERVED BY THE SUM, and by neither half** | $b(X^\#)=-b(X^2)$ exactly, both sides nonzero at generic Weyl tensors at $n=4$ and $n=5$ and on the whole Bianchi subspace with no Ricci-flatness, which is the record's own reference note and is reproduced here |
| 4 | the deciding object, $Q$ at the Weyl tensor of $S^2\times S^2$ | **NO WITNESS EXISTS AT $n=4$**, closure is a theorem there | $Q(W)=W$ on the nose at $S^2\times S^2$, and $\circ$ carries all 55 pairs of a basis of the ten-dimensional $\mathcal W_4$ back into $\mathcal W_4$ with zero residual, so by bilinearity $\mathcal W_4$ is a subalgebra outright |
| 5 | the projection reading, and which one the record uses | **THE PROSE READING IS THE RIGHT ONE, and every implementation computes the compression** | [conventions.md](../findings/conventions.md) and [bounds.md](../findings/bounds.md) use the unprojected $L_e=e\circ(\cdot)$, while [g1_le_machinery.py](../scripts/lib/g1_le_machinery.py), [review_r28_core.py](../scripts/lib/review_r28_core.py), [review_r34_core.py](../scripts/lib/review_r34_core.py), [review_r52_core.py](../scripts/lib/review_r52_core.py) and [review_r42_spec.py](../scripts/lib/review_r42_spec.py) all expand $e\circ B_k$ against an orthonormal Weyl basis, which is the compression, and the two coincide because closure holds |
| 6 | what $\mathop{\mathrm{tr}}L_e$ would mean if closure failed | **ONLY THE $\mathcal W_n$ READING REPRODUCES $\kappa(n)$** | at $S^2\times S^2$, $\mathop{\mathrm{tr}}(L_e^2)=7=\kappa(4)/\theta^2$ over $\mathcal W_4$ and $8$ over both $S^2_B$ (dimension $20$) and $S^2(\Lambda^2)$ (dimension $21$), the excess being $(\tfrac23)^2+4(\tfrac13)^2+4(\tfrac16)^2=1$, so the ambient reading would falsify L206's arithmetic rather than rescue it |

**One line the cycle can act on: revert the closure alarm, keep `FoxClosed` only as a Lean scaffold, cite [Fox's Lemma 5.7](../references/fox-2019-nonassociative-curvature-algebra/notes.md) and [BW08 eq. (6)](../references/boehm-wilking-2008-space-forms/notes.md) at the `sorry`, and fix `FoxClosed`'s binder order, which as written says something strictly weaker than closure.**

## 1. The equivalence, settled before it is used

$Q$ is quadratic and $\circ$ is its polarisation, $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, so $X\circ X=Q(X)$ and one direction is immediate at $Y=X$. For the other, $\mathcal W_n$ is a linear subspace, because each of `IsWeyl`'s four clauses is linear in $R$: skew-to-skew is the linear condition $(RX)^{\mathsf T}=-RX$ on each $X$, the symmetry clause equates two expressions each linear in $R$, and `bianchi` and `Ric` are linear functionals of $R$. [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean) makes exactly that observation to build `weylModule` as a `Submodule`. So $X,Y\in\mathcal W_n$ gives $X+Y\in\mathcal W_n$, all three of $Q(X+Y)$, $Q(X)$, $Q(Y)$ lie in $\mathcal W_n$ by the $Q$-statement, and their combination lies there too. **The two statements are equivalent, and what follows proves the $Q$ form.**

One hypothesis is needed and is present in the Lean layer rather than in `IsWeyl`: $R$ linear. `sharpQF R η` is quadratic in $\eta$ only for linear $R$, and without that `sharpBil R X` is not bilinear, so $Q$ is not even quadratic and the polarisation is not the product. [FoxProduct.lean](../lean/HamiltonsCubic/Base/FoxProduct.lean) records the same point and takes `IsLinOp` as a hypothesis, and `CurvLin` in [WeylModule.lean](../lean/HamiltonsCubic/Base/WeylModule.lean) bundles linearity into the arrow. **`FoxClosed` quantifies over `CurvLin`, so the statement under audit carries the hypothesis it needs.** *Everything below assumes linear $R$, and says so here once.*

## 2. Clause by clause

### 2.1 Skew to skew, NO FINDING

`sharpOp R X` is $\tfrac12\sum_{i,j}(\text{scalar})\cdot\varphi_{ij}$, a linear combination of the basis bivectors, each skew by `phi_isSkew`. So the $\#$ half lands in the skew matrices for every $R$ and every $X$, with no hypothesis at all. `compOp R X = R (R X)` is skew whenever $X$ is, by applying $R$'s own first clause twice. **The sum of two skew matrices is skew, so $Q(X)$ satisfies clause 1.** *This is the one clause that needs nothing about Bianchi, Ricci or even linearity, and it is why my computation, which works in $\varphi$-basis coordinates, enforces clause 1 by construction.*

### 2.2 Self-adjointness, NO FINDING

For the $R^2$ half, $\langle R(RX),Y\rangle=\langle RX,RY\rangle=\langle X,R(RY)\rangle$, using $R$'s symmetry clause twice, legitimately, because $RX$ and $RY$ are skew by clause 1. For the $\#$ half, `sharpBil R X Y` $=\tfrac12(\mathrm{sharpQF}(X+Y)-\mathrm{sharpQF}(X)-\mathrm{sharpQF}(Y))$ is symmetric in $(X,Y)$ on its face, and for linear $R$ it is bilinear, so `skew_expand` gives $\langle \mathrm{sharpOp}\,R\,X,Y\rangle=\mathrm{sharpBil}\,R\,X\,Y$ for skew $Y$, symmetric in the two slots. **So $Q(X)$ satisfies clause 2.** Verified as well: $Q(W)$ came out symmetric to zero residual at every tensor tested.

### 2.3 Ricci-flatness, the interesting clause

**The $R^2$ half alone breaks it, and by a definite amount.** With $R$ self-adjoint,
$$\mathrm{Ric}(R^2)_{bd}=\sum_c\langle R^2\varphi_{bc},\varphi_{dc}\rangle=\sum_c\langle R\varphi_{bc},R\varphi_{dc}\rangle=\tfrac12\sum_{c,k,l}R_{bc,kl}R_{dc,kl},$$
whose diagonal is a sum of squares and vanishes only at $R=0$. At $W_{S^2\times S^2}$ it is $\mathrm{Ric}(W^2)=\tfrac23 I$, which is $\tfrac12\lVert W\rVert^2I$, and at a generic rational $W\in\mathcal W_4$ it is $82\,I$ against $\lVert W\rVert^2=164$. **So a reader who stops at the $R^2$ half concludes the opposite of the truth, which is exactly the trap [r121](REVIEW_r121.md) flagged and the trap the cycle fell into.**

**First Bianchi forces the $\#$ half to cancel it exactly.** Write $Q$ in four-index form, $Q(R)_{abcd}=B_{abcd}-B_{abdc}+B_{acbd}-B_{adbc}$ with $B_{abcd}=R_{aebf}R_{cedf}$, and contract $a$ with $c$:
$$\mathrm{Ric}(Q)_{bd}=\underbrace{\textstyle\sum_a B_{abad}}_{T_{bd}}-\underbrace{\textstyle\sum_a B_{abda}}_{C_{bd}}+\underbrace{\textstyle\sum_a B_{aabd}}_{\mathrm{Ric}\text{-linear}}-\underbrace{\textstyle\sum_a B_{adba}}_{=C_{bd}} .$$
The fourth term equals the second: $\sum_aB_{adba}=\sum R_{beaf}R_{aedf}=\sum R_{afbe}R_{aedf}$ by pair symmetry, and renaming $e\leftrightarrow f$ gives $\sum R_{aebf}R_{deaf}=C_{bd}$. The third term is $\sum_{e,f}\mathrm{Ric}_{ef}R_{bedf}$ and carries an explicit factor of $\mathrm{Ric}(R)$. For the first two, write $T_{bd}=\sum_{pqr}R_{brpq}R_{drpq}$ and apply first Bianchi to the second factor, $R_{drpq}=-R_{dpqr}-R_{dqrp}$: the two resulting sums are equal after $p\leftrightarrow q$ and two sign flips, so $T_{bd}=-2D_{bd}$ with $D_{bd}=\sum_{pqr}R_{brpq}R_{dpqr}$. The same relabelling in $C_{bd}=\sum_{pqr}R_{brpq}R_{dqpr}$ gives $C_{bd}=-D_{bd}$. **Hence $T-2C=0$ and the whole of $\mathrm{Ric}(Q(R))$ is the $\mathrm{Ric}$-linear third term.** The closed form is
$$\boxed{\ \mathrm{Ric}(Q(R))_{ab}=\sum_{c,d}R_{acbd}\,\mathrm{Ric}(R)_{cd}\ }$$
which I verified exactly, coefficient $1$ and all entries, on random Bianchi operators with $\mathrm{Ric}\ne0$ at $n=4$ and $n=5$, in WeylReal's own normalisation, and whose coefficient is pinned independently by $R=\mathrm{id}$, where $Q(\mathrm{id})=(n-1)\mathrm{id}$ and both sides read $(n-1)^2\delta_{ab}$ (also checked exact). **The obstruction is an explicit tensor, it is real, and it is annihilated by $\mathrm{Ric}(X)=0$.** *The trace half of the same statement is on the record from a second source: $\mathop{\mathrm{tr}}Q(R)=\tfrac12\lVert\mathrm{Ric}(R)\rVert^2$, Beitz's $\mathop{\mathrm{scal}}(R^2+R^\#)=2\lVert\mathrm{ric}R\rVert^2$, which I reproduced exactly at $n=4$ ($60=60$) and $n=5$ ($182=182$).*

**A second, fully hand-checkable proof on the diagonal locus, which covers the deciding object.** For $W=\mathop{\mathrm{diag}}(K_{ab})$ in the pair basis, $W^\#$ is pair-diagonal with $(W^\#)_{ab}=(K^2)_{ab}$, and Ricci-flatness is $K\mathbf1=0$. Then
$$\mathrm{Ric}(Q(W))_{aa}=\sum_{c\ne a}\big(K_{ac}^2+(K^2)_{ac}\big)=\sum_{c}K_{ac}^2+\big(K^2\mathbf1\big)_a-(K^2)_{aa}=\sum_cK_{ac}^2-\sum_cK_{ac}^2=0 .$$
At $S^2\times S^2$, $K_{12}=K_{34}=\tfrac23$ and the four mixed entries are $-\tfrac13$: row sums are zero, $(K^2)_{12}=\tfrac29$ and $(K^2)_{13}=-\tfrac49$, so $Q(W)_{12}=\tfrac49+\tfrac29=\tfrac23$ and $Q(W)_{13}=\tfrac19-\tfrac49=-\tfrac13$. **$Q(W)=W$ entry by entry, in two lines of arithmetic a reader can do by hand.**

### 2.4 First Bianchi, preserved by the sum and by neither half

$b$ is the $\Lambda^4$ component, linear in the operator, and my computation confirms it is totally antisymmetric in its four indices on any symmetric operator and vanishes on every repeated-index quadruple, so the condition is $\binom n4$ numbers and the check over $4$-subsets is the whole of it. On that condition:

- $b(W^2)\ne0$ and $b(W^\#)\ne0$ at a generic $W\in\mathcal W_4$ (first entry $-42$ and $+42$) and at a generic $W\in\mathcal W_5$ ($85,-180,-113$ against $-85,180,113$).
- $b(W^\#)=-b(W^2)$ exactly, entry by entry, at every tensor tested, and on the whole Bianchi subspace with no Ricci-flatness assumed.
- $b(Q(W))=0$ exactly, including at Bianchi operators whose Ricci tensor is nonzero, so Bianchi preservation is independent of clause 4 rather than parasitic on it.

**So the cycle's phrase "neither Ricci-flatness nor the first Bianchi identity survives a product for free" is TRUE of each half read alone, and that is precisely what makes the cancellation the content rather than a triviality.** The general-$n$ statement is Hamilton's lemma, that $R\mapsto R^2+R^\#$ carries $S^2_B$ into itself, which the record holds at [the Böhm-Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) together with this exact cancellation, and which also follows from Fox's product being defined on $\mathrm{MC}(V^*)$ in the first place. *I did not re-derive Hamilton's lemma by hand, and I say so: my independent contribution on clause 3 is the exact verification at $n=4,5$ and the identification of the cancellation, and the general statement rests on the two sources.*

## 3. The deciding object, and a proof at $n=4$

$W=W_{S^2\times S^2}$ is $R_{S^2\times S^2}-\tfrac13\mathrm{id}$, which in the basis $(12,13,14,23,24,34)$ is $\mathop{\mathrm{diag}}(\tfrac23,-\tfrac13,-\tfrac13,-\tfrac13,-\tfrac13,\tfrac23)$. It is in $\mathcal W_4$: symmetric, $\mathrm{Ric}(W)=0$, $b(W)=0$. Then, exactly:

| quantity | value |
|---|---|
| $\lVert W\rVert^2$, $P(W)$, $\theta$ | $\tfrac43$, $\tfrac43$, $\sqrt3/2$, so $\theta^2=\tfrac34=\theta_0(4)^2$ |
| $\mathop{\mathrm{tr}}W^2$, $\mathop{\mathrm{tr}}W^\#$, $\mathop{\mathrm{tr}}Q(W)$ | $\tfrac43$, $-\tfrac43$, $0$ |
| $\mathrm{Ric}(W^2)$, $\mathrm{Ric}(W^\#)$, $\mathrm{Ric}(Q(W))$ | $\tfrac23I$, $-\tfrac23I$, $0$ |
| $b(W^2)$, $b(W^\#)$, $b(Q(W))$ | $0$, $0$, $0$ |
| $Q(W)$ | equal to $W$, so the four clauses hold and $W$ is an idempotent-direction critical point with $Q(W/\lVert W\rVert)=\theta\,W/\lVert W\rVert$ |

**And the search for a witness is finished at $n=4$, not merely unsuccessful.** $\dim\mathcal W_4=10$, matching $n(n+1)(n+2)(n-3)/12$. I took a rational basis of $\mathcal W_4$ as the exact nullspace of the Bianchi and Ricci conditions on $S^2(\Lambda^2)$, formed $B_i\circ B_j$ for **all 55 unordered pairs**, and tested the four clauses on each: **zero pairs leave $\mathcal W_4$.** Since $\circ$ is bilinear and $\mathcal W_4$ is a linear subspace, that is closure on the whole of $\mathcal W_4$, a theorem rather than a screen. At $n=5$ and $n=6$ I tested single generic tensors rather than a basis, and those are screens, which is why the general-$n$ claim rests on section 2.3's derivation and on the two sources rather than on them.

## 4. The record already says this, in five places

**The cycle's sentence "the record states that nowhere" is false.** What is on disk:

| where | what it says |
|---|---|
| [conventions.md](../findings/conventions.md), the $\Phi$ row, sense (ii) | "Hamilton's map $Q$ itself, in Böhm-Wilking's notation, where $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(\Phi(W))=0$ is what makes $Q$ preserve $\mathcal W_n$" |
| [problem.md](../findings/problem.md), the literature table | "BW08 eq. (6): $\mathrm{Ric}(\Phi(R))_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$, so $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(\Phi(W))=0$: $\Phi$ preserves Weyl", and separately that Fox "shows the Weyl (Ricci-flat) tensors form a simple nonassociative subalgebra" |
| [the Fox notes](../references/fox-2019-nonassociative-curvature-algebra/notes.md) | a section headed "Lemma 5.7, page 14, which is the source for $Q(\mathcal W_n)\subseteq\mathcal W_n$", quoting the lemma verbatim with its conclusion that $\mathrm{MC}_W(V^*)=\ker\rho$ is a **subalgebra**, transcribed 2026-09-10 to close exactly this debt |
| [the Böhm-Wilking notes](../references/boehm-wilking-2008-space-forms/notes.md) | "the ODE is stated on $S^2_B$, so $R\mapsto R^2+R^\#$ carries $S^2_B$ into itself: the sum preserves the Bianchi identity", with the record's own $b(R^\#)=-b(R^2)$ |
| [problem.md](../findings/problem.md), the two-unnamed-inputs paragraph | "$\Phi$ preserves the first Bianchi identity, without it $\Phi(W)$ could carry a $\Lambda^4$ component" |

Fox's Lemma 5.7 is the cleanest of these and gives the whole statement at once: $\rho(X*Y)=\tfrac12(X\hat\cdot\rho(Y)+Y\hat\cdot\rho(X))$ and $s(X*Y)=\langle\rho(X),\rho(Y)\rangle$, so $\ker\rho$ is a subalgebra. **That is `FoxClosed`, in the primary literature, transcribed on this record two days before the cycle declared it unstated.** Fox's Lemma 5.8(1) adds the converse, $s(X*X)\ge0$ with equality iff $X$ is Weyl, so the containment is sharp.

**What the cycle got right, and it is worth keeping.** No NUMBERED result carries closure, the Lean layer has no proof of it, and every one of the record's numerical confirmations is a screen. So the honest debt is "stated by citation, proved nowhere in the record's own normalisation", which is a much smaller debt than "not well-posed", and section 2.3 above now discharges the Ricci half of it in the record's own normalisation.

## 5. The projection reading, and what the implementations do

**The prose uses the unprojected operator.** [conventions.md](../findings/conventions.md) reads "$X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$", with no projection, and the record's criticality equation is the bare $Q(W)=\theta W$ as an operator identity, which [r488](REVIEW_r488.md) checked and kept for that reason.

**Every implementation computes the compression, and therefore tests nothing.** [g1_le_machinery.py](../scripts/lib/g1_le_machinery.py)'s `Le_matrix` ends in `einsum('imn,kmn->ik', B, prod)`, the coordinates of $e\circ B_k$ against an orthonormal Weyl basis. [review_r28_core.py](../scripts/lib/review_r28_core.py)'s `L_matrix`, [review_r34_core.py](../scripts/lib/review_r34_core.py)'s, [review_r52_core.py](../scripts/lib/review_r52_core.py)'s and [review_r42_spec.py](../scripts/lib/review_r42_spec.py)'s do the same. That expansion is $\Pi_{\mathcal W}(e\circ\cdot)|_{\mathcal W}$ whether or not the product closes, so **no recorded spectrum, eigenvalue or trace is evidence either way**. It also means the record's numbers are safe under either reading, which is the practical half of the answer.

**One implementation does test it, as a by-product.** [review_r42_spec.py](../scripts/lib/review_r42_spec.py)'s `Le_matrix` returns `leak`, the relative residual $\lVert v-BB^{\mathsf T}v\rVert/\lVert v\rVert$ of each image against the Weyl basis, alongside the matrix. That is the closure check, built into the loop that would otherwise hide it, and it is the shape the other four should have.

**So the intent question is settled by the prose and the citations, not by the code: the record means the unprojected operator, and it is entitled to.** The residual $\lVert e\circ X-\Pi_{\mathcal W}(e\circ X)\rVert$ is exactly $0$ over a basis of $\mathcal W_4$ here, and the record's screens put it at $\le8\times10^{-16}$ relative at $n=6,8,10$ ([r286](REVIEW_r286.md)), with an independent reimplementation carrying "Q preserves Weyl" as a gate at $1.4\times10^{-15}$ ([r113](REVIEW_r113.md)).

## 6. What $\mathop{\mathrm{tr}}L_e$ would mean if closure failed, and which carrier gives $\kappa(n)$

Had closure failed, L206's two hypotheses would have had to be read on the compression $\Pi_{\mathcal W}(e\circ\cdot)|_{\mathcal W}$. That object is still self-adjoint, since $T(X,Y,Z)=\langle X\circ Y,Z\rangle$ is totally symmetric and $\Pi_{\mathcal W}$ is an orthogonal projection, so L206's Cauchy-Schwarz step would survive, as [r488](REVIEW_r488.md) already observed. **The question is only whether the constant still matches, and the answer is that the ambient readings do not match.** At $W=W_{S^2\times S^2}$, where $Q(W)=W$ makes $e=W$ exactly and the whole computation rational:

| carrier | dimension | $\mathop{\mathrm{tr}}L_e$ | $\mathop{\mathrm{tr}}(L_e^2)$ | spectrum |
|---|---|---|---|---|
| $\mathcal W_4$ | $10$ | $0$ | $\mathbf7$ | $\{1^2,\ \tfrac12^{\,4},\ (-1)^4\}$ |
| $S^2_B$, the Bianchi subspace | $20$ | $0$ | $8$ | the above plus $\{\tfrac23,\ (-\tfrac13)^4,\ \tfrac16^{\,4},\ 0\}$ |
| $S^2(\Lambda^2)$, the ambient symmetric operators | $21$ | $0$ | $8$ | the above plus a second $0$ |

$\kappa(4)/\theta^2=(21/4)/(3/4)=7$. **So the $\mathcal W_n$ trace reproduces the record's $\kappa(n)=(2n-1)(n-1)/4$ exactly and the ambient trace exceeds it by $1$**, the excess being $(\tfrac23)^2+4(\tfrac13)^2+4(\tfrac16)^2=1$ from the $\Lambda^4$ line and the Ricci directions. Two further consequences worth recording: $\mathop{\mathrm{tr}}L_e=0$ holds on all three carriers, so the first identity discriminates nothing, and the $\mathcal W_4$ spectrum $\{1^2,\tfrac12^4,(-1)^4\}$ reproduces L206's own recorded spectrum at the balanced product independently, together with $p=2$, $m=4$, $k=4$ and the attained $\theta^2=\tfrac34$. **L206's hypotheses are statements about the operator on $\mathcal W_n$, they are well-posed, and its constant is the one the $\mathcal W_n$ reading gives.**

## 7. A defect in the Lean statement, found on the way

`FoxClosed` in [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) reads

```
∀ X Y : CurvLin ι, X ∈ weylModule ι → Y ∈ weylModule ι →
  ∀ Z : Matrix ι ι ℝ, ∃ W : CurvLin ι, W ∈ weylModule ι ∧ foxProd .. Z = W Z
```

**The binders are in the wrong order.** With `∀ Z, ∃ W` the proposition says only that at each bivector separately some member of $\mathcal W_n$ agrees with the product there, which is far weaker than the product being a member, and no single operator is produced. Closure needs `∃ W, W ∈ weylModule ∧ ∀ Z, foxProd .. Z = W Z`. The file's own note says `leftMul_exists` needs the witness "canonical in `Y`, which `FoxClosed` as stated does not give": that understates the gap, since as stated `FoxClosed` does not give a witness at all. *This matters for the repair, not for the mathematics: the true statement is the `∃ W, ∀ Z` one and it is a theorem.*

## 8. What would overturn this verdict, and what I did to look

- **An explicit $X\in\mathcal W_n$ with $Q(X)\notin\mathcal W_n$ at some $n\ge6$.** My $n=4$ result is exhaustive over a basis, so any witness lives at $n\ge5$, and there it would have to defeat section 2.3's identity, which carries no dimension. I looked at generic rational Weyl tensors at $n=5$ and $n=6$ and at generic Bianchi tensors with $\mathrm{Ric}\ne0$ at $n=4$ and $n=5$, all exact, all clean. I did not sweep, and a sweep would not have settled it either way.
- **A normalisation mismatch between the record's $\#$ and the standard one.** This is the live hazard, since the whole question is about a specific $\#$, and the record has been bitten by it twice. I anchored WeylReal's `sharpOp` three times: $\mathrm{id}^\#=(n-2)\mathrm{id}$ exactly at $n=4,5,6$, $Q(\mathrm{id})=(n-1)\mathrm{id}$, and $\mathop{\mathrm{tr}}W^\#=-\lVert W\rVert^2$. All three agree with the record's own anchors, so the object I tested is the record's object.
- **An error in my four-index dictionary for $Q$.** Section 2.3's hand derivation reads $Q$ through Hamilton's $B$ tensor, a convention I supplied rather than read off disk. That is why the boxed identity is also verified directly against WeylReal's definitions with a nonzero right-hand side, and why its coefficient is pinned by $R=\mathrm{id}$: if my dictionary were wrong, the identity would fail at coefficient $1$ and it does not.
- **A reading of the record where $L_e$ is something else.** I grepped [findings/](../findings/), [reviews/](../reviews/) and [scripts/](../scripts/) for how $L_e$ is built. Every implementation agrees, every prose site agrees, and the only divergence is the projection question of section 5, which is inert because closure holds.

## Verdict

**REFUTED. The Fox product is closed on $\mathcal W_n$, the record's $L_e$ is an operator on $\mathcal W_n$, and L206's two hypotheses are well-posed statements about it.** Clause 1 and clause 2 hold for free, clause 3 holds on the sum by Hamilton's lemma with the exact cancellation $b(X^\#)=-b(X^2)$, and clause 4 holds because $\mathrm{Ric}(Q(R))_{ab}=\sum_{cd}R_{acbd}\mathrm{Ric}(R)_{cd}$ is linear in $\mathrm{Ric}(R)$, a cancellation forced by first Bianchi and verified exactly in the record's own normalisation. At $n=4$ closure is a theorem proved here over a basis of $\mathcal W_4$. **The cycle's claim is an over-correction on the mathematics and factually wrong on the record, which states closure in five places including a verbatim transcription of Fox's Lemma 5.7 made two days earlier.** What survives of it is the narrow and fair point that closure has no numbered result and no proof inside the record, plus one real find of its own: the two trace identities are indeed unproved here. **Owed: revert the "not well-posed" prose in [WeylTraceStatement.lean](../lean/HamiltonsCubic/Base/WeylTraceStatement.lean) and in whatever index entry echoed it, fix `FoxClosed`'s binder order, and either cite Fox 5.7 at the `sorry` or promote section 2.3 to a numbered result.**
