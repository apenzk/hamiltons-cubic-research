# Verifier v405, adjudication of step K1 in round L66-r2

Cold brief ([ADJ_L66r2_K1.md](ADJ_L66r2_K1.md)) plus Nienhaus, Lemma 2.19 and Proposition 2.25 of [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404). No numerical work was done: no scripts, no runs, and every value below is exact and checked by hand. Log: [agent_logs/verify-L66-v405.log](../agent_logs/verify-L66-v405.log).

| # | Claim | Verdict |
|---|---|---|
| K1a | There exist critical unit $A,B\in\mathcal W_n$ for some $n\ge4$ with $\langle A,B\rangle=0$ and $A\circ B\ne0$ | TRUE (closed-form witness at $n=4$, Section 2) |
| K1b | Hence criticality together with Frobenius orthogonality does not imply $\circ$-orthogonality | TRUE (immediate from K1a) |
| K1c | The paragraph establishes this | FAILS (its only support is a numerical run, and it states that no closed-form witness is on file) |
| K1 | The step as written, K1a to K1c jointly | FAILS |

**Summary: the claim is true, as the explicit pair $A=\mathrm{diag}(2,-1,-1)$, $B=J-I$ in $W^+\subset\mathcal W_4$ shows by hand, but the paragraph rests it on an $n=8$ run with approximate values and says no closed-form witness is on file, so the step's clause that the paragraph establishes it fails.**

## 0. Conventions, fixed once

Quoted from the brief:

- "$\mathcal W_n=\mathrm{Weyl}_n$ is the space of algebraic Weyl tensors on $\mathbb R^n$, viewed as symmetric operators on $\Lambda^2\mathbb R^n$, with the Frobenius inner product. $Q(W)=W^2+W^\#$ and $P(W)=\langle W,Q(W)\rangle$."
- "**The $\circ$ product**: $X\circ Y=\tfrac12(Q(X+Y)-Q(X)-Q(Y))$, with $e=W/\theta$ and $L_e=e\circ(\cdot)$."
- "$(W^\#)_{ab}=\tfrac12\sum c_{acd}c_{bef}W_{ce}W_{df}$. Dropped, the formula returns $\mathrm{id}^\#=2(n-2)\mathrm{id}$ against the halved Böhm–Wilking product's $(n-2)\mathrm{id}$, which is what $Q(\mathrm{id})=(n-1)\mathrm{id}$ on the round sphere pins."
- Critical means "$Q(A)=\theta_AA$".
- "A claim supported only by a run is `HYPOTHESIS-DEBT`. Screening a claim by hand on an object you construct is allowed, and is reported as a screen, never as evidence for a positive claim."

## 1. Hypothesis inventory

1. **Dimension-4 block form.** For $n=4$, $\Lambda^2\mathbb R^4=\Lambda^+\oplus\Lambda^-$ with orthonormal bases, and an algebraic curvature operator is $R=\begin{pmatrix}A&B\\B^{\mathrm{tr}}&C\end{pmatrix}$ with $A,C$ symmetric $3\times3$. The first Bianchi identity is $\operatorname{tr}A=\operatorname{tr}C$, the traceless Ricci part is carried by $B$, and the scalar curvature is a positive multiple of $\operatorname{tr}A+\operatorname{tr}C$. So $R$ is Weyl exactly when $B=0$ and $\operatorname{tr}A=\operatorname{tr}C=0$, and $W^+=\{\mathrm{diag}(A,0):A=A^{\mathrm{tr}},\operatorname{tr}A=0\}$. Standard (Singer–Thorpe). Checked: holds.
2. **Frobenius inner product in these coordinates.** On block-diagonal operators with orthonormal bases of $\Lambda^\pm$, $\langle\mathrm{diag}(A,0),\mathrm{diag}(A',0)\rangle=\operatorname{tr}(AA')$. Any other orthonormalisation convention for $\Lambda^2$ rescales this by a fixed positive constant, which changes neither orthogonality nor criticality nor whether $A\circ B$ vanishes. Checked: holds.
3. **Hamilton's formula for $\#$ in dimension 4**, Nienhaus Lemma 2.19 (citing [Ham86]): $R^\#=\begin{pmatrix}A^\#&B^\#\\(B^\#)^{\mathrm{tr}}&C^\#\end{pmatrix}$ with $A^\#=2\operatorname{adj}(A)$. **Convention match with the record.** At $R=\mathrm{id}$ ($A=C=I_3$, $B=0$) this gives $\mathrm{id}^\#=2\,\mathrm{id}=(n-2)\mathrm{id}$ and $Q(\mathrm{id})=3\,\mathrm{id}=(n-1)\mathrm{id}$, which is the halved normalisation the conventions pin. Checked: holds, so Nienhaus's $\#$ and the record's $\#$ agree at $n=4$.
4. **Adjugate of a traceless symmetric $3\times3$ matrix.** Cayley–Hamilton gives $\operatorname{adj}(A)=A^2-(\operatorname{tr}A)A+\sigma_2(A)I$ with $\sigma_2=\tfrac12((\operatorname{tr}A)^2-\operatorname{tr}A^2)$. At $\operatorname{tr}A=0$ this is $\operatorname{adj}(A)=A^2-\tfrac12\operatorname{tr}(A^2)\,I$. Standard. Checked: holds.
5. **The step needs no criticality beyond $Q(A)=\theta_AA$, no normalisation of $\theta$, and no symmetry of $T$.** The $\circ$ product is read directly off its defining polarisation. Checked: nothing else is used.

## 2. The argument

### 2.1 $Q$ and $\circ$ on $W^+$

Let $W=\mathrm{diag}(A,0)$ with $A$ traceless symmetric. By items 3 and 4, $W^2=\mathrm{diag}(A^2,0)$ and $W^\#=\mathrm{diag}(2A^2-\operatorname{tr}(A^2)I,0)$, since $\operatorname{adj}(0)=0$ and $B^\#=0$ at $B=0$. Hence
$$Q(W)=\mathrm{diag}\big(3A^2-\operatorname{tr}(A^2)\,I,\quad 0\big).$$
The block is traceless, since $\operatorname{tr}(3A^2)=3\operatorname{tr}(A^2)$, so $Q(W)\in W^+$, consistent with $Q$ mapping $\mathcal W_4$ to itself. Polarising, for $V=\mathrm{diag}(A',0)$,
$$W\circ V=\tfrac12\big(Q(W+V)-Q(W)-Q(V)\big)=\mathrm{diag}\Big(\tfrac32(AA'+A'A)-\operatorname{tr}(AA')\,I,\quad 0\Big),$$
because $(A+A')^2-A^2-A'^2=AA'+A'A$ and $\operatorname{tr}((A+A')^2)-\operatorname{tr}A^2-\operatorname{tr}A'^2=2\operatorname{tr}(AA')$.

### 2.2 The witness

Take, with $J$ the $3\times3$ all-ones matrix,
$$A_0=\begin{pmatrix}2&0&0\\0&-1&0\\0&0&-1\end{pmatrix},\qquad B_0=J-I=\begin{pmatrix}0&1&1\\1&0&1\\1&1&0\end{pmatrix},$$
and set $A=\tfrac1{\sqrt6}\mathrm{diag}(A_0,0)$, $B=\tfrac1{\sqrt6}\mathrm{diag}(B_0,0)$.

- **In $\mathcal W_4$.** Both $A_0$ and $B_0$ are symmetric with trace $0$, so by item 1 both $A$ and $B$ are Weyl tensors (in $W^+$).
- **Unit.** $\operatorname{tr}(A_0^2)=4+1+1=6$ and $\operatorname{tr}(B_0^2)=6$ (six off-diagonal ones), so $\lVert A\rVert=\lVert B\rVert=1$.
- **Frobenius orthogonal.** $A_0$ is diagonal and $B_0$ has zero diagonal, so $\operatorname{tr}(A_0B_0)=\sum_i(A_0)_{ii}(B_0)_{ii}=0$, hence $\langle A,B\rangle=0$.
- **$A$ critical.** $A_0^2=\mathrm{diag}(4,1,1)$, so $3A_0^2-6I=\mathrm{diag}(6,-3,-3)=3A_0$. By 2.1, $Q(\mathrm{diag}(A_0,0))=3\,\mathrm{diag}(A_0,0)$, and by homogeneity $Q(A)=\tfrac16\cdot3\,\mathrm{diag}(A_0,0)=\tfrac{3}{\sqrt6}A=\tfrac{\sqrt6}2A$. So $\theta_A=\tfrac{\sqrt6}2$.
- **$B$ critical.** $J^2=3J$, so $B_0^2=J^2-2J+I=J+I$, and $3B_0^2-6I=3J-3I=3B_0$. Hence $Q(B)=\tfrac{\sqrt6}2B$ and $\theta_B=\tfrac{\sqrt6}2$.
- **$A\circ B\ne0$.** Since $\operatorname{tr}(A_0B_0)=0$, 2.1 gives $A\circ B=\tfrac16\,\mathrm{diag}\big(\tfrac32(A_0B_0+B_0A_0),0\big)$. With $A_0=\mathrm{diag}(a)$, $(A_0B_0+B_0A_0)_{ij}=(a_i+a_j)(B_0)_{ij}$, which is $0$ on the diagonal and $a_1+a_2=1$, $a_1+a_3=1$, $a_2+a_3=-2$ off it. So
$$A\circ B=\tfrac14\,\mathrm{diag}\left(\begin{pmatrix}0&1&1\\1&0&-2\\1&-2&0\end{pmatrix},\,0\right)\ne0,\qquad \lVert A\circ B\rVert=\tfrac14\sqrt{2(1+1+4)}=\tfrac{\sqrt3}2=\tfrac{\theta_A}{\sqrt2}.$$

So $A,B$ are critical unit elements of $\mathcal W_4$ with $\langle A,B\rangle=0$ and $A\circ B\ne0$, which is K1a at $n=4$, and K1b follows at once.

**Screen, by hand, of the convention (reported as a screen, not as evidence).** The equal-radius $S^2\times S^2$ is Kähler for both orientations, so its unit Weyl tensor is $\tfrac1{\sqrt2}(A+A^-)$ with $A^-$ the $\Lambda^-$ copy of $A$. Off-diagonal blocks of $Q$ vanish at $B=0$, so $P$ adds over the two blocks, giving $P=2\cdot(\tfrac1{\sqrt2})^3\cdot\tfrac{\sqrt6}2=\tfrac{\sqrt3}2$. Nienhaus Proposition 2.25 at $k=l=2$, $n=4$ gives $\theta_{2,2}=\sqrt2\sqrt{\tfrac12\cdot\tfrac12\cdot\tfrac32}=\tfrac{\sqrt3}2$. The two agree, so the block computation above carries the same normalisation as the proposition the record cites.

**Remark on the geometry.** $B_0=3vv^{\mathrm{tr}}-I$ with $v=\tfrac1{\sqrt3}(1,1,1)$ and $A_0=3e_1e_1^{\mathrm{tr}}-I$, so $B$ is the image of $A$ under a rotation in $SO(4)$ (acting through $SO(4)\to SO(3)$ on $\Lambda^+$). The pair consists of two rotated copies of $W_{\mathbb{CP}^2}$ at $n=4$, the analogue of the paragraph's "two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$". Orthogonality is $9(u\cdot v)^2-3=0$, that is $(e_1\cdot v)^2=\tfrac13$.

### 2.3 What the paragraph establishes

The paragraph's entire support is: "*A run at $n=8$ found two critical, Frobenius-orthogonal copies of padded $W_{\mathbb{CP}^2}$ with $\lVert A\circ B\rVert\approx0.664$, and a rotated $S^4\times S^4$ pair at $\approx0.273$. No closed-form witness is on file.*"

- **Location of the failure.** That sentence is the only evidence offered, and it is a numerical run reported with approximate values. No object is written down, so no reader can check criticality, orthogonality or $A\circ B\ne0$.
- **Concrete exhibit.** The paragraph itself says "No closed-form witness is on file". Under the brief's rule a claim supported only by a run is `HYPOTHESIS-DEBT`, and a screen is never evidence for a positive claim. An existence claim is a positive claim.
- **Strongest defence.** The bold sentence is correct as a statement, and the run points at the right kind of witness (rotated copies of $W_{\mathbb{CP}^2}$), which Section 2.2 confirms exists at $n=4$. The defence shows K1a and K1b are true. It does not show the paragraph proves them, because the paragraph contains no argument, only a report of floating-point output. Also, nothing in Passage A's theorem depends on the sentence, so its status is expository, and the defect does not touch Lemma L66.

**Repair.** Replace the run sentence with the closed-form witness of Section 2.2: at $n=4$, $A=\tfrac1{\sqrt6}\mathrm{diag}(2,-1,-1)$ and $B=\tfrac1{\sqrt6}(J-I)$ in $W^+$, both critical with $\theta=\tfrac{\sqrt6}2$, $\langle A,B\rangle=0$, and $\lVert A\circ B\rVert=\tfrac{\sqrt3}2$. That paragraph would establish the step, and the $n=8$ figures could stay as a labelled screen.

**Verdict: FAILS**
