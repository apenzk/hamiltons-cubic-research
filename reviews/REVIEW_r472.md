# Review r472, Lemma L80, [isotropy-cap.md](../findings/isotropy-cap.md)

**Claim.** $N_v\succeq0$, with $\ker N_v=v^\perp\cap\mathfrak z(v)$. Two assertions: (A) positive semidefiniteness, (B) the kernel identification, an equality needing both inclusions.

**Verdict, (A) CONFIRMED. (B) CONFIRMED.** Both hold for **every** $v\in\mathfrak{so}(m)$ and every $m\ge2$, $v=0$ and degenerate $v$ included. **The lemma needs no hypothesis at all**, and the $\mathfrak c\ne0$ / $p\ge2$ gap that was added to [Lemma L32](../findings/isotropy-cap.md) and [Lemma L81](../findings/isotropy-cap.md) at today's audit **does not propagate here**, see finding 4, which tests L80 against the very witness that refuted those two.

Four defects found, all of them expository or bookkeeping rather than mathematical: an unstated step in the harder inclusion (3), an intermediate expression in no stated normalisation (6), a verbatim duplication of the block in a second file (7), and no citation of L80 by number at its one real use (8).

## 1. $N_v$ is defined, the "defined nowhere" defect does not apply

[isotropy-cap.md:196](../findings/isotropy-cap.md), one heading above the lemma:

$$\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W,\qquad\text{equivalently}\qquad \sum_\alpha\lambda_\alpha N_{v_\alpha}=0,\quad N_v:=2\,v\otimes v-\mathrm{ad}(v)^2 .$$

So $v\in\mathfrak{so}(m)=\Lambda^2\mathbb R^m$ (a bivector *and* an element of $\mathfrak{so}(m)$, the two identified throughout the record) and $N_v$ is an operator on that same space, $v\otimes v$ being the rank-one map $u\mapsto\langle v,u\rangle v$ and $\mathrm{ad}(v)u=[v,u]$. The statement is well posed.

**One ambiguity, and it is harmless *here*.** The definition never says which of the record's two inner products ([conventions.md](../findings/conventions.md): the $\Lambda^2$ pairing $\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$ and the $n\times n$ Frobenius pairing, which "differ by a factor $2$") supplies $v\otimes v$ and $v^\perp$. For L80 the choice cannot matter: the two are positive multiples of each other, so $v^\perp$ is the same subspace, $\mathrm{ad}(v)$ is skew-adjoint for both (any multiple of the trace form is ad-invariant), and both assertions survive verbatim. It matters for the *identity* $N_v$ sits in, finding 6.

## 2. Assertion (A), confirmed, and it is one line, of which the block gives the honest version

$-\mathrm{ad}(v)^2\succeq0$ because $\mathrm{ad}(v)$ is skew-adjoint, and $2\,v\otimes v\succeq0$ because it is a nonnegative multiple of a rank-one projector. $N_v$ is the sum of two positive semidefinite self-adjoint operators. The block's route ($\langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2$), is the same fact and is correct.

**Is (A) vacuous?** No, but its content is thin, and the block says so: its own claim to novelty is "the splitting", not the semidefiniteness. $N_v=0$ only at $v=0$, so (A) is a real statement about a nonzero operator everywhere else; it is simply an easy one.

## 3. Assertion (B), the block establishes $\supseteq$ outright and $\subseteq$ only implicitly

The two inclusions are not symmetric in difficulty, and the block's single line conflates them.

- **$\supseteq$, direct from the definition.** If $\langle v,u\rangle=0$ and $[v,u]=0$ then $N_vu=2\langle v,u\rangle v-[v,[v,u]]=0$. No auxiliary fact needed.
- **$\subseteq$, where the work is.** The block computes the zero set of the *quadratic form*, $\{u:\langle u,N_vu\rangle=0\}=\{u:\langle v,u\rangle=0\ \text{and}\ [v,u]=0\}$, and then writes $\ker N_v$. Passing from the one to the other uses two unstated facts: that a self-adjoint $A\succeq0$ has $\langle u,Au\rangle=0\iff Au=0$, and that $\ker\mathrm{ad}(v)^2=\ker\mathrm{ad}(v)=\mathfrak z(v)$, the latter again from skew-adjointness. Both are true and standard, so the conclusion stands; the block should say which fact it is invoking, because the quadratic-form zero set and the kernel coincide only *because* (A) was established first.

**Recommended repair, one clause:** "…so $N_v\succeq0$, and being self-adjoint and positive semidefinite it has $\ker N_v=\{u:\langle u,N_vu\rangle=0\}=v^\perp\cap\mathfrak z(v)$."

## 4. The L32 / L81 gap does not propagate, tested against the same witness

This is the sharpest test available, because **L80's kernel is literally L32's $\mathfrak c$**: $\ker N_v=v^\perp\cap\mathfrak z(v)=\mathfrak z(v)\cap v^\perp=\mathfrak c$. The witness that refuted both neighbours therefore applies to L80 directly.

| configuration | $\mathfrak c=v^\perp\cap\mathfrak z(v)$ | L80 | L32 / L81 |
| --- | --- | --- | --- |
| $v=e_{12}\in\mathfrak{so}(3)$ | $0$ | **holds**, $N_v$ positive definite, $\ker=0$ | **fails** as stated |
| $v=0$ | all of $\mathfrak{so}(m)$ | **holds**, $N_0=0$, $\ker=\mathfrak{so}(m)$ | out of scope ($x\ne0$) |
| $v$ degenerate, unequal singular values | $\ge\lfloor m/2\rfloor-1$ | **holds** | holds |

**Why the difference is structural, not luck.** L32 and L81 assert that a centraliser *collapses to a line*, a claim that a dimension is exactly $1$, which the $\mathfrak c=0$ configuration falsifies from below. L80 asserts an *equality of two subspaces*, and an equality degenerates gracefully: when $\mathfrak c=0$ the lemma simply says $N_v\succ0$, which is true. There is no configuration in which one side of L80's equality is defined and the other is not.

**Screen** (seconds, on objects constructed for the purpose, reported as a screen and not as evidence): $N_v$ assembled in the orthonormal $\varphi_{ab}$ basis and compared against $\dim(v^\perp\cap\mathfrak z(v))$ computed as a rank defect. Eight configurations, random $\mathfrak{so}(6)$ and $\mathfrak{so}(7)$; $e_{12}$ in $\mathfrak{so}(6)$, $\mathfrak{so}(3)$, $\mathfrak{so}(2)$; a rank-$4$ complex structure padded into $\mathfrak{so}(8)$; $v=0$ in $\mathfrak{so}(5)$; a degenerate $v$ with unequal singular values in $\mathfrak{so}(6)$. Symmetry to $10^{-16}$, minimum eigenvalue $\ge-8\times10^{-16}$, and $\dim\ker$ matching the predicted dimension in all eight. At $e_{12}\in\mathfrak{so}(3)$ the minimum eigenvalue is $+1$ exactly and $\dim\ker=0$.

## 5. Vacuity, no, in either direction

$\dim\ker N_v=\dim\mathfrak c\ge\lfloor m/2\rfloor-1$, by the torus bound recorded at [stratum-two-negative.md](../findings/stratum-two-negative.md) (the argument added when L32 gained its hypothesis). So the kernel is a **proper, nonzero** subspace for every $m\ge4$ and $v\ne0$: dimension $2$ out of $15$ and $2$ out of $21$ at random $v$ in $\mathfrak{so}(6)$, $\mathfrak{so}(7)$; $6$ out of $15$ at $v=e_{12}\in\mathfrak{so}(6)$; $9$ out of $28$ at the padded rank-$4$ complex structure. The kernel is everything only at $v=0$, and zero only at $m\le3$.

## 6. DEFECT, the derivation given for the coefficient $2$ does not reproduce it, though the coefficient is right

The block introducing $N_v$ derives it from a pairing that "gives $\sum_\alpha\lambda_\alpha[\langle v_\alpha,u\rangle^2-2\operatorname{tr}((v_\alpha u)^2)]=0$", with $\operatorname{tr}(u^2v_\alpha^2)$ cleared by Ricci-flatness. Using $\lVert[v,u]\rVert^2=-\operatorname{tr}((vu)^2)+\operatorname{tr}(v^2u^2)$ in the record's $\Lambda^2$ pairing:

$$\langle v,u\rangle^2-2\operatorname{tr}((vu)^2)=\langle v,u\rangle^2+2\lVert[v,u]\rVert^2-2\operatorname{tr}(v^2u^2),$$

so the Ricci-cleared remainder carries relative weights $(1,2)$ on $(\langle v,u\rangle^2,\lVert[v,u]\rVert^2)$. Read instead in the full Frobenius pairing the same line clears to weights $(1,1)$. But $\langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2$ has weights $(2,1)$. **No stated normalisation of the record turns the displayed intermediate into the displayed $N_v$**, and it is the line a reader would use to check the coefficient.

**The coefficient itself is correct**, established here by a route that does not touch that line:

- [conventions.md](../findings/conventions.md)'s Killing marginal $\sum_\beta\lVert[v_\alpha,v_\beta]\rVert^2=2(n-2)$ says $\sum_g\mathrm{ad}(\varphi_g)^2=-2(m-2)\,\mathrm{Id}$ on $\mathfrak{so}(m)$ for a $\Lambda^2$-orthonormal basis, which is exactly [Lemma L79](../findings/isotropy-cap.md)'s eigenvalue on $\mathbb R\cdot\mathrm{Id}$, so L79's table and the conventions file are in the same normalisation.
- L79's $+2$ on $\mathrm{Weyl}_m$ then gives $\sum_\alpha\lambda_\alpha\mathrm{ad}(v_\alpha)^2=2W=2\sum_\alpha\lambda_\alpha\,v_\alpha\otimes v_\alpha$, i.e. $N_v=2\,v\otimes v-\mathrm{ad}(v)^2$ with $v\otimes v$ the $\Lambda^2$-orthonormal rank-one map. **Both the coefficient $2$ and the choice of inner product in $v\otimes v$ are forced by this.**

**Screen:** the Casimir constant reproduced at $m=4,5,6,7$ as $-4,-6,-8,-10$ with zero off-diagonal, and on the self-dual $W_4(q,r)$ of [stratum-two-negative.md](../findings/stratum-two-negative.md) at $\lambda=(-2,0.7,1.3)$ the fit $\sum\lambda_\alpha\mathrm{ad}(v_\alpha)^2=c\,W$ returns $c=2.000000$ with residual $4\times10^{-16}$.

**This is a defect of the block L80 sits in, not of L80.** Assertions (A) and (B) are invariant under the coefficient: $c\,v\otimes v-\mathrm{ad}(v)^2$ is positive semidefinite with kernel $v^\perp\cap\mathfrak z(v)$ for every $c>0$. Recording it because the coefficient is what makes L80 *useful*, and because the record's own conventions file names this family of factor-$2$ slips as where its builds disagree.

## 7. DEFECT, the record holds the lemma twice, verbatim, and the copy carries no number

[conventions.md](../findings/conventions.md) rules that "definitions and conventions are quoted, never restated". Against that:

| text | site |
| --- | --- |
| the definition of $N_v$ | [isotropy-cap.md:196](../findings/isotropy-cap.md), [stratum-two-negative.md:134](../findings/stratum-two-negative.md), [results.md:442](../results.md), three copies |
| the lemma and its one-line proof | [isotropy-cap.md:215–221](../findings/isotropy-cap.md) (as L80) and [stratum-two-negative.md:145–148](../findings/stratum-two-negative.md) (unnumbered, inside L33, under the same heading "What is new is the splitting") |

Both copies of the lemma read identically and both are correct, so nothing has drifted yet. The repair is for the [stratum-two-negative.md](../findings/stratum-two-negative.md) paragraph to cite L80 instead of restating it.

## 8. Citation audit, L80 is used, and correctly, but never by number

**By number: nowhere.** A grep of the whole record for `L80` returns the heading itself and the index row. [INDEX-results.md:95](../findings/INDEX-results.md) marks it "Gate 2: no verdict on the record", and [LEDGER.md:146](../findings/LEDGER.md) carries it on the Gate 2 debt ledger, both accurate as of this review.

**By content: one real use, downstream of everything L33 supports.** [Lemma L33](../findings/stratum-two-negative.md)'s proof runs "Rescale so the identity reads $N_x=\sum_iN_{y_i}$… All terms being positive semidefinite, $\ker N_x\subseteq\bigcap_i\ker N_{y_i}$: the space $\mathfrak c=\mathfrak z(x)\cap x^\perp$ commutes with every $y_i$ and is orthogonal to each." That is L80 applied once on the left and once per term on the right. It reaches [results.md](../results.md)'s L33 and [report/sections/07-gradedness-split.tex:1011](../report/sections/07-gradedness-split.tex).

**The use is inside L80's hypotheses, which is trivially satisfied, L80 having none.** Checked in full:

- The rescaling is legitimate: $N$ is quadratic, $N_{cv}=c^2N_v$, so $\lvert\lambda_x\rvert N_x=N_{\sqrt{\lvert\lambda_x\rvert}x}$ and likewise on the right. Zero eigenvalues drop from both sides, so the $y_i$ range over the strictly-positive eigenvalues only, which is what L33 needs.
- $\ker N_x\subseteq\bigcap_i\ker N_{y_i}$ is correct, and in fact an **equality**: for positive semidefinite $A_i$, $\ker(\sum_iA_i)=\bigcap_i\ker A_i$.
- The conclusion drawn, $\mathfrak c\subseteq y_i^\perp$ and $\mathfrak c\subseteq\mathfrak z(y_i)$, hence $y_i\in\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp$, is exactly L80's kernel equality read in both directions, and uses **both** inclusions. So finding 3's unstated $\subseteq$ step is load-bearing downstream, not decorative.

## 9. A free strengthening the block understates

The block closes: "kernel containment runs from the smaller side to the larger." Splitting the identity as $\sum_{\lambda_\alpha>0}\lambda_\alpha N_{v_\alpha}=\sum_{\lambda_\alpha<0}\lvert\lambda_\alpha\rvert N_{v_\alpha}$ makes both sides one and the same positive semidefinite operator, and $\ker(\sum A_i)=\bigcap\ker A_i$ applies to each side, giving

$$\bigcap_{\lambda_\alpha>0}\big(v_\alpha^\perp\cap\mathfrak z(v_\alpha)\big)\;=\;\bigcap_{\lambda_\alpha<0}\big(v_\alpha^\perp\cap\mathfrak z(v_\alpha)\big),$$

an **equality** of the two intersections, not a containment. It costs nothing beyond what the block already proves and is the two-sided form of the step L33 uses one-sidedly.

## Verdict, per assertion

| assertion | verdict | hypotheses it actually needs |
| --- | --- | --- |
| (A) $N_v\succeq0$ | **CONFIRMED** | none, any $v\in\mathfrak{so}(m)$, any $m\ge2$. Needs only ad-invariance of the inner product, which conventions.md supplies |
| (B) $\ker N_v=v^\perp\cap\mathfrak z(v)$ | **CONFIRMED** | none. $\supseteq$ is direct; $\subseteq$ needs (A) plus self-adjointness, which the block leaves unstated |

**No reference was needed.** Everything the audit turned on is in [findings/](../findings/), the definition at [isotropy-cap.md:196](../findings/isotropy-cap.md), the normalisations at [conventions.md](../findings/conventions.md), the $\mathcal A$ table at [Lemma L79](../findings/isotropy-cap.md), and the use at [stratum-two-negative.md](../findings/stratum-two-negative.md).
