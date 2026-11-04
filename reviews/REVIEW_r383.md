# Reviewer r383, Gate 2 on "The ordering argument post F47 asked for"

*Adversarial review of the last section of [ATTEMPTS.md](../ATTEMPTS.md), lines 3231–3247. Every step re-derived from the definitions before the section was read. Analysis only; the two screens below are hand arithmetic on objects built for the purpose, reported as screens.*

## Verdict in one line

**The argument is correct. Every one of the five steps stands, and no counterexample exists inside the stated hypotheses.** Three defects are in the *statement* rather than the proof, and the most important one is that the conclusion as written is **too weak to serve [I18](../plan.md)**, while the proof it is drawn from delivers the stronger statement I18 actually needs.

| step | verdict |
| --- | --- |
| 1, $\widetilde No=To$ | **Confirmed**, re-derived from criticality alone, no appeal to [r378](REVIEW_r378.md) needed |
| 2, $\mathbf1\perp o$ | **Confirmed** |
| 3, Frobenius identity and the eigenvalue sum | **Confirmed**, both halves; two wording slips |
| 4, [Lemma L68](../findings/diagonal-half.md), the algebra, the minimisation | **Confirmed**, all four sub-claims; the threshold is improvable |
| 5, $\lvert\lambda\rvert\le T\Rightarrow\lambda_{\max}=T$ | **Confirmed**, and $T>0$ is a **redundant hypothesis** |
| 6, the scope claim | **Reduction correct; the conclusion it reduces to is misstated**, and the leftover's description has a hole |
| 7, screen | **Passes** at $S^6\times S^6$ and $S^5\times S^7$, with $T$ simple at both |

## Step 1, $\widetilde No=To$, derived independently

Write the off-diagonal criticality at $(i,j)$ and $(i,k)$ for $i\in I$. Since $M_{jj}=M_{kk}=0$,

$$(M^2)_{ij}=\sum_{l\in I}M_{il}u_l+v_iM_{jk},\qquad (M^2)_{ik}=\sum_{l\in I}M_{il}v_l+u_iM_{jk},$$

so criticality reads $u_i^2+(Nu)_i+v_iM_{jk}=\theta u_i$ and $v_i^2+(Nv)_i+u_iM_{jk}=\theta v_i$. Subtracting,

$$(No)_i+(v_i^2-u_i^2)=\theta o_i+M_{jk}o_i=To_i,$$

and $v_i^2-u_i^2=(u_i+v_i)o_i$ is exactly the diagonal correction. Hence $\widetilde No=To$. **Confirmed, and it is cleaner than the record's route**: no division, no case split, and it needs only the $2(n-2)$ criticality equations in rows $j$ and $k$, hollowness, but not $M\mathbf1=0$. [r378](REVIEW_r378.md)'s $B(u-v)=0$ is the same content and is not required as an input.

$\widetilde N\mathbf1=0$ also checks: $(N\mathbf1)_i=-u_i-v_i$ by the row sums and hollowness, cancelling $\mathop{\mathrm{diag}}(u+v)$ exactly. **Here $M\mathbf1=0$ is load-bearing.**

## Step 2, $\mathbf1\perp o$

$\sum_{i\in I}M_{ki}=-M_{kj}-M_{kk}=-M_{jk}$ and $\sum_{i\in I}M_{ji}=-M_{jk}-M_{jj}=-M_{jk}$, both using $M\mathbf1=0$ **and** hollowness to drop the diagonal term. The difference is $0$. **Confirmed.** The record's one-line version is right, including the term it excludes from each sum.

*Edge note.* $\mathbf1\perp o$ with $o\ne0$ forces $\lvert I\rvert\ge2$, hence $n\ge4$. Below that the hypothesis $o\ne0$ is already empty, so nothing is lost.

## Step 3, the Frobenius identity, and the eigenvalue-sum step

**The identity is exact and I re-derived it rather than inheriting it.** $N$ is hollow and $\mathop{\mathrm{diag}}(u+v)$ is diagonal, so their supports are disjoint and $\lVert\widetilde N\rVert_F^2=\lVert N\rVert_F^2+\lVert u+v\rVert^2$. Splitting $\lVert M\rVert_F^2=2$ by index type gives $\lVert N\rVert_F^2=2-2\lVert u\rVert^2-2\lVert v\rVert^2-2M_{jk}^2$, and

$$\lVert\widetilde N\rVert_F^2=2-\lVert u\rVert^2-\lVert v\rVert^2+2\langle u,v\rangle-2M_{jk}^2=2-\lVert o\rVert^2-2M_{jk}^2 .$$

**Confirmed**, in agreement with [r379](REVIEW_r379.md)/[r380](REVIEW_r380.md), and reproduced numerically in the screen below at two points.

**The eigenvalue-sum step is legitimate, and the three worries in the brief all resolve.** $\widetilde N$ is real symmetric, so it has an orthonormal eigenbasis and $\sum\lambda_i^2=\lVert\widetilde N\rVert_F^2$. Because $\mathbf1\perp o$ and both are nonzero, $\mathbf1/\lVert\mathbf1\rVert$ and $o/\lVert o\rVert$ extend to such a basis, contributing $0^2+T^2$; every remaining basis vector is orthogonal to both, so $\lambda^2+T^2\le\lVert\widetilde N\rVert_F^2$ for each. Orthonormality is supplied by step 2 and is what the argument needs. Multiplicity of $T$ does not break it, see below, where the argument in fact **excludes** multiplicity. And the case $\lambda=T$ is not a hole: it is the case the strict inequality of step 4 rules out.

**Two wording slips.** The section writes "$0$ and $T$ are eigenvalues on **independent** eigenvectors"; independence alone would not license the Frobenius split, and the correct word is *orthogonal*, which the preceding clause proves. And "for any **third** eigenvalue $\lambda$" should read "for any eigenvalue on an eigenvector orthogonal to both $\mathbf1$ and $o$", as written it invites a reading in which a repeated $T$ escapes the bound. Both are repairs to the prose, not to the mathematics.

## Step 4, Lemma L68, the algebra, and the minimisation

**L68 restated for this pair, and re-derived.** [diagonal-half.md](../findings/diagonal-half.md) records $g_{ab}=2\lVert M_a-M_b\rVert^2-4M_{ab}^2=2(s_a+s_b)-4\theta M_{ab}$ at a critical point, with $s_a=\lVert M_a\rVert^2$. Since $o_i=M_{ki}-M_{ji}$ runs over $i\notin\{j,k\}$, $\lVert o\rVert^2=\tfrac12 g_{jk}=s_j+s_k-2\theta M_{jk}$. **The normalisation and the definition of $o$ match exactly.** Direct check, independent of L68's route: $\langle u,v\rangle=(M^2)_{jk}=\theta M_{jk}-M_{jk}^2$ by criticality at $(j,k)$, and $s_j=\lVert u\rVert^2+M_{jk}^2$, $s_k=\lVert v\rVert^2+M_{jk}^2$, so $\lVert o\rVert^2=s_j+s_k-2M_{jk}^2-2(\theta M_{jk}-M_{jk}^2)=s_j+s_k-2\theta M_{jk}$. **Confirmed.**

**The algebra.** $2T^2=2\theta^2+4\theta M_{jk}+2M_{jk}^2$; adding $\lVert o\rVert^2$ and $2M_{jk}^2$ gives $2\theta^2+2\theta M_{jk}+4M_{jk}^2+s_j+s_k$. **Confirmed exactly.**

**The minimisation.** $f(x)=2\theta^2+2\theta x+4x^2$ has $f'(x)=2\theta+8x$, so $x=-\theta/4$ is the minimiser and $f(-\theta/4)=2\theta^2-\tfrac12\theta^2+\tfrac14\theta^2=\tfrac74\theta^2$. **Confirmed**, and dropping $s_j+s_k\ge0$ is legitimate, they are sums of squares. At $\theta^2\ge\tfrac32$ this is $\ge\tfrac{21}8>2$.

**Where the chain gains, and it matters for step 5.** The conclusion is $2T^2>\lVert M\rVert_F^2\ge\lVert\widetilde N\rVert_F^2+\lVert o\rVert^2+2M_{jk}^2$, hence $\lambda^2<T^2$ **strictly**. The section's own final line writes $\lambda^2\le\dots\le T^2$ and throws the strictness away.

**The threshold is improvable, and the section's own parenthetical understates it.** The stated sufficient condition is $\theta^2>8/7$. Keeping $s_j+s_k\ge2M_{jk}^2$ (which holds because $M_{jk}^2$ is one term of each row mass), gives $2\theta^2+2\theta x+6x^2$, minimised at $x=-\theta/6$ with value $\tfrac{11}6\theta^2$, so **$\theta^2>12/11$ suffices**, i.e. $\theta>1.044466$ against the written $1.069045$. The band $\theta\ge\sqrt{3/2}=1.224745$ clears it by $37.5\%$ in the budget.

## Step 5, the conclusion, and the redundant hypothesis

$\lvert\lambda\rvert<T$ gives $\lambda<T$ only when $T>0$, and $\lambda_{\max}=\max(0,T,\dots)$ needs $T>0$ as well. So the hypothesis is genuinely used.

**But it is not an extra hypothesis, it is free.** $\lVert M\rVert_F^2=2$ contains the two entries $M_{jk}$ and $M_{kj}$, so $2M_{jk}^2\le2$ and $\lvert M_{jk}\rvert\le1$. With $\theta\ge\sqrt{3/2}>1$,

$$T=\theta+M_{jk}\ \ge\ \sqrt{3/2}-1\ =\ 0.224745\ >\ 0 .$$

**The section's "Hypotheses, stated" paragraph lists $T>0$ as a hypothesis and offers [r378](REVIEW_r378.md)'s $u\cdot v>-2\theta^2$ as a sufficient condition for it. Both should be struck**: the band plus the normalisation give it in one line. ([r382](REVIEW_r382.md)'s companion lemma sharpens this to $T\ge0.7604$, but nothing here needs the sharper form.)

**The one hypothesis the paragraph does not name is $\lVert M\rVert_F^2=2$**, which enters step 3 and again as the right-hand side of step 4. It is folded into "the Frobenius identity", but it deserves its own line because it is the only place the ambient normalisation is spent. *The argument is robust to weakening it*: if $\lVert M\rVert_F^2\le2$ the identity becomes an upper bound in the right direction and step 4's target only drops, so the conclusion survives.

## Step 6, the scope claim, and the defect that matters

**The reduction is logically correct.** The theorem covers every pair with $o\ne0$; the complement is every pair with $o=0$, i.e. $u=v$, i.e. orbit-free. That is an exact dichotomy and needs no genericity. The $664/664$ statistic from [post F47](../findings/INDEX-traps.md) is a statement about the $S^p\times S^q$ family only, so "settles the generic case" is weaker language than the theorem earns, the honest phrasing is *settles every non-orbit-free pair, unconditionally*.

**THE DEFECT: the stated conclusion is not [I18](../plan.md)'s pair clause.** [plan.md](../plan.md) states the clause as $\ker B\cap\mathbf1^\perp=\mathbb Ro$ for $B=\Delta^{(jk)}+T\,\mathrm{Id}$, and [Lemma L128](../findings/second-order.md)'s criterion **excludes the value $\tfrac12$** rather than bounding the spectrum. Since $\Delta^{(jk)}=-\widetilde N$ and [Lemma L122](../findings/second-order.md) makes the pair block $\tfrac12\widetilde N-\tfrac12M_{jk}\mathrm{Id}$, an $L_e$-eigenvalue of $\tfrac12$ is exactly an $\widetilde N$-eigenvalue of $T$. **So I18 needs $T$ to be a SIMPLE eigenvalue of $\widetilde N|_{\mathbf1^\perp}$, and $\lambda_{\max}(\widetilde N)=T$ does not imply that**, a repeated top would put a non-orbit direction at $\tfrac12$ and I18 would fail with the clause as stated satisfied.

**The proof already gives the simple version, and the section discards it in its last line.** Step 4 delivers $2T^2>\lVert\widetilde N\rVert_F^2$ strictly, so every eigenvalue on an eigenvector orthogonal to $\mathbf1$ and $o$ obeys $\lambda^2<T^2$. Hence:

> **At every pure critical point with $\theta>\sqrt{12/11}$, and every pair $\{j,k\}$ with $o\ne0$, $T$ is a SIMPLE eigenvalue of $\widetilde N$ and $\lambda_{\max}(\widetilde N)=T$, attained only on the orbit direction $o$. Equivalently, the pair block of $L_e$ satisfies $L_e\le\tfrac12$ on $\mathbf1^\perp$ with the value $\tfrac12$ attained only on the orbit.**

That is [I18](../plan.md)'s pair clause outright, on every non-orbit-free pair, **at a critical point rather than a maximiser**, which is exactly the gap [Lemma L24](../findings/second-order.md) could not cross. **The section should be restated in this form.** As written, a reader citing "$\lambda_{\max}=T$" would be citing something I18 cannot consume.

**A second, smaller hole in the leftover's description.** The section says the residue is "the orbit-free blocks, where $u=v$, $M_{jk}>0$". From [r378](REVIEW_r378.md)'s identity $\theta M_{jk}=M_{jk}^2+\lVert u\rVert^2$ the correct statement is $M_{jk}\ge0$, **with equality iff $u=v=0$ and $M_{jk}=0$, i.e. iff rows $j$ and $k$ of $M$ both vanish**, a padded pair, which criticality permits ($0+0=0$) and which the band and the normalisation do not exclude. At such a pair $\widetilde N=M^{(jk)}$ and the clause reads $\lambda_{\max}(M^{(jk)}|_{\mathbf1^\perp})<\theta$, a case the quoted Frobenius budget $\theta^2+5M_{jk}^2+2\lVert u\rVert^2\ge2$ degenerates to $\theta^2\ge2$ and fails outright. **The residue is "$o=0$", and its sub-case with a zero row needs naming.** *A pair with exactly one zero row has $o=v\ne0$ and is covered by the theorem.*

**One agreement worth recording.** The orbit-free budget $\theta^2+5M_{jk}^2+2\lVert u\rVert^2\ge2$ is the *same* computation as this argument with $\lVert o\rVert=0$: the requirement $2T^2>\lVert M\rVert_F^2-2M_{jk}^2$ becomes $\theta^2+2\theta M_{jk}+3M_{jk}^2>2$, and substituting $2\theta M_{jk}=2M_{jk}^2+2\lVert u\rVert^2$ returns it verbatim. So the two halves are one method read at $o\ne0$ and $o=0$, and the whole gain comes from the $T^2$ that $o\ne0$ puts into the budget twice.

## Step 7, the screen

*Hand arithmetic on two points constructed for this check. Reported as a screen.*

**$S^6\times S^6$, $n=12$, cross pair.** $\gamma=-g$, $\alpha=6g/5$, $\theta=11g$, $\lVert M\rVert_F^2=158.4g^2=2$ so $\theta=1.236034$, in band. On $I$, $u+v=(\alpha+\gamma)\mathbf1$, so $\widetilde N=N+(\alpha+\gamma)\mathrm{Id}$ with $N$ equitable on two blocks of $5$. Spectrum of $\widetilde N$:

$$\{\,5\alpha+6\gamma=0\ \ (\text{on }\mathbf1),\quad 5\alpha-4\gamma=10g=T\ \ (\text{on }o),\quad \gamma=-g\ \ (\text{multiplicity }8)\,\}$$

**$\lambda_{\max}(\widetilde N)=T$, and $T$ is simple.** Frobenius check: $0+100+8=108$, against $2-\lVert o\rVert^2-2M_{jk}^2=(158.4-48.4-2)g^2=108g^2$, **the identity reproduces exactly**.

**$S^5\times S^7$, $n=12$, cross pair.** $\gamma=-g$, $\alpha_1=7g/4$, $\alpha_2=5g/6$, $\lVert M\rVert_F^2=160.41\overline{6}g^2=2$, $\theta=11g=1.228239$, in band, and the record's own fence-post point. The quotient on $(\mathbf1_A,\mathbf1_B)$ is $g\begin{pmatrix}6&-6\\-4&4\end{pmatrix}$, determinant $0$, trace $10g$; the within-block directions give $-\alpha_1+(\alpha_1+\gamma)=\gamma$ and $-\alpha_2+(\alpha_2+\gamma)=\gamma$. Spectrum $\{0,\ 10g=T,\ (-g)^8\}$. **$\lambda_{\max}(\widetilde N)=T$, simple.** Frobenius: $0+100+8=108$, against $(160.41\overline{6}-50.41\overline{6}-2)g^2=108g^2$, **exact again**.

**Cross-check against [Lemma L127](../findings/second-order.md).** Mapping through $L_e=(\lambda-M_{jk})/(2\theta)$: $T\mapsto\tfrac12$ and $\gamma\mapsto0$ with multiplicity $8=n-4$ at both points, which is L127's recorded cross-factor spectrum $\{\tfrac12\text{ simple},0^{n-4}\}$ **verbatim**. That is an independent confirmation of L122's affine map and of the whole setup.

**Slack.** At $S^6\times S^6$ the chain reads $2T^2+\lVert o\rVert^2+2M_{jk}^2=250.4g^2$ against $2=158.4g^2$, a factor $1.581$, so the argument is **far from tight** at the family it was designed to reach; at $S^5\times S^7$ the factor is $1.573$. The eigenvalue bound is looser still: $\lambda^2=1$ against $T^2=100$. **The band is barely spent**, consistent with the improved threshold $\theta^2>12/11$.

## No counterexample exists

I looked for one in the three places it could hide. **A pair with $o$ parallel to $\mathbf1$**, impossible, step 2 is unconditional. **A repeated $T$**, excluded by the strict inequality, and it is the interesting case, since a repeated $T$ would break I18 rather than the ordering. **A pure critical point in the band violating step 4's inequality**, impossible, since $\tfrac74\theta^2\ge\tfrac{21}8>2\ge\lVert M\rVert_F^2$ holds with the free variables $M_{jk}$ and $s_j+s_k$ already minimised over their whole ranges. **Inside the hypotheses the argument admits no falsifier.** The only route to one is a pure critical point with $\lVert M\rVert_F^2>2$, which the normalisation forbids.

## What should change in the section

1. **Restate the conclusion with the simplicity**, which the proof gives and the write-up discards. Without it the section does not close [I18](../plan.md)'s pair clause; with it, it does.
2. **Strike $T>0$ from the hypotheses.** $\lvert M_{jk}\rvert\le1$ from $\lVert M\rVert_F^2=2$ makes $T\ge\sqrt{3/2}-1>0$ automatic, and [r378](REVIEW_r378.md)'s sufficient condition is not needed.
3. **Add $\lVert M\rVert_F^2=2$ to the hypothesis list**, noting the argument survives $\le2$.
4. **Improve $\theta^2>8/7$ to $\theta^2>12/11$**, using $s_j+s_k\ge2M_{jk}^2$ instead of $s_j+s_k\ge0$.
5. **Fix the leftover's description**: $M_{jk}\ge0$, with the zero-row sub-case named, and the residue identified as $o=0$ rather than as $M_{jk}>0$.
6. **Repair "independent" to "orthogonal"** and "third eigenvalue" to "eigenvalue orthogonal to both", and write the final inequality as strict.
7. **Drop "generic"** from the scope paragraph, the theorem is unconditional on $o\ne0$ and does not lean on the $664/664$ count.
