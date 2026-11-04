# Review r1869: the Λ² loss of the E route bounded by the index concentration of W

Gate 2 reader r1869 on [BRIEF_I121_indexconc.md](BRIEF_I121_indexconc.md) at commit 5919f267, the block "The Λ² loss is the index concentration of W" in [the working note](2026-09-28d-I121-smallmass-direct.md) and [IndexConcentration.lean](../lean/HamiltonsCubic/Results/IndexConcentration.lean). Log: [agent_logs/r1869-i121-indexconc.log](../agent_logs/r1869-i121-indexconc.log). Written without reading r1868.

**Verdict: the chain breaks at item 4.** The coordinate formula for $(G^\#G)_{ij,ij}$ drops every cross term between two different third indices, and the bound it feeds, $\mathop{\mathrm{tr}}(G^\#G)\le\tfrac18\lVert N\rVert_F^2$, is false for general positive semidefinite $G$. At $G=W^2$ it is equivalent to the sign of one quartic invariant, which is proved at $n=4$ and holds at every point screened, and is unproved at $n\ge5$. Items 1, 2, 3 and the arithmetic of item 5 stand.

| item | claim | verdict |
|---|---|---|
| 1 | $\theta p_3=p_4+\tfrac12S$ from L198's rows | CONFIRMED |
| 2 | $p_4\le1/\theta^2$ | CONFIRMED, at $\theta>0$ |
| 3 | $\tfrac12S\le\mathop{\mathrm{tr}}(G^\#G)$ | CONFIRMED, and the slack is the record's $\tfrac14G_2$ exactly |
| 4 | coordinate formula and $\mathop{\mathrm{tr}}(G^\#G)\le\tfrac12\sum r_k^2\le\tfrac18\lVert N\rVert_F^2$ | REFUTED as written. The conclusion at $G=W^2$ is open, equivalent to $\Sigma_4\ge0$ |
| 5 | the combined display and its table | PLAUSIBLE: the algebra from 1 to 4 is right and the table is reproduced to every digit, conditional on item 4 |
| 6 | "from $n=30$ the band is empty for index-spread tensors" | PLAUSIBLE with corrections: conditional on item 4, and the argument gives a wider class than exact isotropy |
| 7 | classification | PARTLY ON RECORD: $\mathop{\mathrm{tr}}(G^\#G)=\tfrac12S_{22}$ and items 1 with 3 are the record's $S_{22}$ identity. The $\lVert N\rVert_F$ bound is new |

## Normalisation used

The record's bracket is fixed by $I^\#I=(n-2)I$ and by (A), $\sum_\gamma\lVert[\varphi_k,\varphi_\gamma]\rVert^2=2(n-2)$. In the unit basis $e_{ij}$ this makes $\lVert[e_{ij},e_{ik}]\rVert^2=1$, so every nonzero structure constant is $\pm1$ and the record's $c$ is $\sqrt2$ times the Frobenius one. With Hamilton's $(A^\#B)_{\alpha\beta}=\tfrac12\sum c_{\alpha\gamma\delta}c_{\beta\varepsilon\zeta}A_{\gamma\varepsilon}B_{\delta\zeta}$ this reproduces $I^\#I=(n-2)I$, the diagonal formula $(D^\#D)_{ij,ij}=\sum_ka_{ik}a_{jk}$ and $\langle W^\#,W\rangle=\tfrac12\sum\lambda_k\lambda_l\lambda_mc_{klm}^2$, the last checked numerically against the record's `sharp_pair` at random Weyl tensors, $n=4,5,6$ (agreement at scale $\sqrt2$, a factor $2$ off at the Frobenius scale).

## Item 1: the weighted rows, CONFIRMED

Row $k$ is (C) of [bounds.md](../findings/bounds.md), $\sum_{\alpha\gamma}T_{\alpha k\gamma}\lambda_\alpha\lambda_\gamma=2\lambda_k(\theta-\lambda_k)$ with $T=c^2$. Multiplying by $\tfrac12\lambda_k^2$ and summing over $k$ gives $\sum_k\lambda_k^3(\theta-\lambda_k)=\theta p_3-p_4$ on the left and $\tfrac12\sum c^2_{\alpha k\gamma}\lambda_k^2\lambda_\alpha\lambda_\gamma$ on the right. Since $c^2$ is totally symmetric, $c^2_{\alpha k\gamma}=c^2_{k\alpha\gamma}$ and the right side is $\tfrac12S$. The step uses criticality through (C) and nothing else.

## Item 2: $p_4\le1/\theta^2$, CONFIRMED at $\theta>0$

L198's first display with $\theta>0$ gives $\lambda_{\max}\le1/\theta$. The second gives $\theta\lvert\lambda_{\min}\rvert\le1-2\lambda_{\min}^2\le1$, so $\lvert\lambda_{\min}\rvert\le1/\theta$. Every $\lvert\lambda_k\rvert$ is at most the larger of the two, and $p_4\le\max_k\lambda_k^2\cdot p_2=\max_k\lambda_k^2$ at unit norm. The note's sentence "at every unit critical point" needs $\theta>0$ stated: item 5 multiplies $E\le C_nt_{\max}$ by $\theta$, and [theta_sq_le](../lean/HamiltonsCubic/Results/IndexConcentration.lean) carries `hθ : 0 < θ`. The table sits at $\theta\ge\theta_0>0$, so no stated number is affected.

## Item 3: the sign drop, CONFIRMED

With $w_k=\lambda_k^2\ge0$ and $c^2_{k\alpha\gamma}$ symmetric in $\alpha,\gamma$, the AM–GM step gives $\sum_{\alpha\gamma}c^2_{k\alpha\gamma}\lambda_\alpha\lambda_\gamma\le\sum_\alpha\lambda_\alpha^2\sum_\gamma c^2_{k\alpha\gamma}$, which is [weighted_sign_drop](../lean/HamiltonsCubic/Results/IndexConcentration.lean) exactly. So $\tfrac12S\le\tfrac12\sum_{k\alpha}\lambda_k^2\lambda_\alpha^2\lVert[\varphi_k,\varphi_\alpha]\rVert^2$. In the eigenbasis $G=W^2$ is diagonal with entries $\lambda_k^2$, and Hamilton's formula gives $\mathop{\mathrm{tr}}(G^\#G)=\tfrac12\sum_{\gamma\delta}g_\gamma g_\delta\lVert[\varphi_\gamma,\varphi_\delta]\rVert^2$, which is that right side. The equality holds in the record's normalisation.

The slack of this step is on the record: [bounds.md](../findings/bounds.md) (the $S_{22}$ subsection before L153) has $S_{22}=2\mathop{\mathrm{tr}}(W^2\#W^2)=2\theta\mathop{\mathrm{tr}}W^3-2\mathop{\mathrm{tr}}W^4+\tfrac12G_2$ at a critical point. With item 1 that reads $\mathop{\mathrm{tr}}(G^\#G)=\tfrac12S+\tfrac14G_2$, $G_2=\sum_k\lambda_k^2g_k\ge0$.

## Item 4: the coordinate formula and the index bound, REFUTED as written

**The formula drops the cross terms.** Fix $(ij)$. The nonzero $c_{(ij)\gamma\delta}$ have $\{\gamma,\delta\}=\{(ik),(jk)\}$, $k\ne i,j$, with a sign $s_k$ on the ordered pair $((ik),(jk))$. Expanding Hamilton's formula over two such indices $k,k'$ gives, for symmetric $G$,
$$(G^\#G)_{ij,ij}=\sum_{k,k'\ne i,j}s_ks_{k'}\big(G_{ik,ik'}G_{jk,jk'}-G_{ik,jk'}G_{jk,ik'}\big).$$
The note keeps only $k=k'$. The two agree at $I$ and at every diagonal $G$, which is why the brief's two anchors do not detect the gap. They differ at $G=uu^{\mathsf T}+ww^{\mathsf T}$, where $G^\#G=[u,w]\otimes[u,w]$: with $x_k=u_{ik}w_{jk}-u_{jk}w_{ik}$ the true entry is $(\sum_ks_kx_k)^2$ and the note's is $\sum_kx_k^2$ (Lagrange's identity). At $u=\sum_ke_{ik}/\sqrt{n-2}$, $w=\sum_ks_ke_{jk}/\sqrt{n-2}$ these are $1$ and $1/(n-2)$. The traces differ as well: at random unit Weyl tensors the true $\mathop{\mathrm{tr}}(G^\#G)$ is $0.334$, $0.337$, $0.272$ at $n=4,5,6$ against $0.278$, $0.271$, $0.244$ from the note's formula.

**The index bound is false for general positive semidefinite $G$.** Take $n=4$ and $G=P_+$, the projection onto $\Lambda^2_+$. Its three unit directions bracket at the pair cap, $\lVert[\varphi_a,\varphi_b]\rVert^2=2$, so $\mathop{\mathrm{tr}}(P_+^\#P_+)=\tfrac12\cdot6\cdot2=6$. Each $e_{ik}$ has half its mass in $\Lambda^2_+$, so $R_{ik}=\tfrac12$, $r_k=\tfrac32$ and $\tfrac12\sum_kr_k^2=\tfrac98\cdot4=4.5<6$. Checked numerically (6.0 against 4.5). Any proof of the index step therefore has to use that $G$ is the square of a Weyl operator.

**What is true: an exact identity.** Let $V_a$ be the column operators of $W$ as skew $n\times n$ matrices, $(V_{(pq)})_{ij}=W_{ijpq}$, $p<q$. Then $G=\sum_aV_a\otimes V_a$, $Q:=\sum_aV_a^{\mathsf T}V_a=\tfrac12N$ (so $r_k=Q_{kk}$, confirming $r_k=\tfrac12N_{kk}$), and $\mathop{\mathrm{tr}}(G^\#G)=\tfrac14\sum_{ab}\lVert[V_a,V_b]\rVert_{\mathrm{Fr}}^2$. Expanding $\lVert[A,B]\rVert^2_{\mathrm{Fr}}=2\mathop{\mathrm{tr}}(A^2B^2)-2\mathop{\mathrm{tr}}(ABAB)$ for skew $A,B$ and summing,
$$\mathop{\mathrm{tr}}\big((W^2)^\#W^2\big)=\tfrac18\lVert N\rVert_F^2-\tfrac12\Sigma_4,\qquad\Sigma_4=\sum_{a,b}\mathop{\mathrm{tr}}(V_aV_bV_aV_b)=\tfrac14\sum W_{ijpq}W_{jkrs}W_{klpq}W_{lirs},$$
the last sum over ordered indices. Checked to six digits at two random Weyl tensors each at $n=4,5,6,7$. So the note's conclusion $\mathop{\mathrm{tr}}(G^\#G)\le\tfrac18\lVert N\rVert_F^2$ is equivalent to $\Sigma_4\ge0$, and $P_+$ has $\Sigma_4<0$.

**At $n=4$ the conclusion holds.** $W=W_+\oplus W_-$ with each block traceless on a copy of $\mathfrak{so}(3)$, the blocks commuting. A traceless $3$-vector of square norm $s$ has $p_4=s^2/2$, so the block of mass $s$ contributes $\sum_{a\ne b}g_ag_b=s^2-s^2/2=s^2/2$, and $\mathop{\mathrm{tr}}(G^\#G)=\tfrac12(s^2+(1-s)^2)\le\tfrac12=\tfrac18\lVert I\rVert_F^2$, with equality at one-sided $W$. At $n\ge5$, $\Sigma_4\ge0$ is unproved. It is positive at every random Weyl tensor sampled here ($0.13$ to $0.48$, falling with $n$) and at $S^3\times S^3$, $S^4\times S^4$, $S^2\times S^4$, $\mathbb{CP}^3$, $\mathbb{CP}^4$.

**The intermediate $\tfrac12\sum_kr_k^2$ in any frame** is stronger than what the identity supports, since $\sum_kQ_{kk}^2\le\lVert Q\rVert_F^2$ with equality only in $Q$'s eigenframe. The display needs only $\tfrac18\lVert N\rVert_F^2$, so the frame-wise form can be dropped.

**The pair conventions are right where they are used.** $R_{ik}=\lVert Me_{ik}\rVert^2=\sum_{p<q}W_{ikpq}^2$ is symmetric in $i,k$, $\sum_iR_{ik}=\tfrac12N_{kk}$, and $\sum_{i<j}\sum_kR_{ik}R_{jk}=\tfrac12\sum_k\sum_{i\ne j}R_{ik}R_{jk}\le\tfrac12\sum_kr_k^2$, which is [rowsum_sq_le](../lean/HamiltonsCubic/Results/IndexConcentration.lean). The failure is upstream of this, in the formula it is applied to.

**The screen is at the wrong normalisation.** [screen_I121_index_concentration.py](../scripts/misc/screen_I121_index_concentration.py) builds the bracket in the Frobenius-unit basis and prints $B/2$ as $\mathop{\mathrm{tr}}(G^\#G)$. In the record's normalisation that is half of $\mathop{\mathrm{tr}}(G^\#G)$: the screen prints $0.1278$, $0.1394$, $0.0943$ at $S^3\times S^3$, $\mathbb{CP}^3$, $\mathbb{CP}^4$ where the record's $\mathop{\mathrm{tr}}(G^\#G)$ is $0.2556$, $0.2787$, $0.1886$. The corrected values still sit below $\tfrac18\lVert N\rVert_F^2=0.333$, $0.333$, $0.25$, so the screened conclusion survives at those points and the stated chain was screened at half its middle term.

## Item 5: the combined display and its table, PLAUSIBLE (conditional on item 4)

Multiplying L50's $\theta=\tfrac32p_3+E$ by $\theta>0$ gives $\theta^2=\tfrac32\theta p_3+\theta E$. Items 1 to 4 give $\theta p_3\le\theta^{-2}+\tfrac18\lVert N\rVert_F^2$, and $\theta E\le\theta C_nt_{\max}$ from `E_le_tmax_sharp`, so the display follows, and [theta_sq_le](../lean/HamiltonsCubic/Results/IndexConcentration.lean) types this combination with the index step as its hypothesis `hD`. The sharpening condition $\lVert N\rVert_F^2<8(1-\theta^{-2})$ is the rearrangement of $\tfrac3{2\theta^2}+\tfrac3{16}\lVert N\rVert_F^2<\tfrac32$. $\lVert N\rVert_F^2\ge(\mathop{\mathrm{tr}}N)^2/n=16/n$ is Cauchy–Schwarz, equality exactly at $N=\tfrac4nI$.

The table follows from $t_{\max}\ge\big(\theta_0-\tfrac3{2\theta_0^3}-\tfrac3{n\theta_0}\big)/C_n$ at $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, the bound being increasing in $\theta$. One line of Python reproduces every entry: $0.0286$, $0.0640$, $0.0972$, $0.1341$, $0.1497$, against $3/(n+2)=0.1875$, $0.1364$, $0.0938$, $0.0484$, $0.0294$, and the comparison values $0.00128$ and $0.0224$ from $\theta^2\le\tfrac32+\theta E$. The limit is $(5/12)^2=0.1736$. The crossover is at $n=30$ exactly ($0.0948<0.0968$ at $n=29$).

**Isotropy is CONFIRMED.** At $\mathbb{CP}^m$, $U(m)$ acts irreducibly on $\mathbb R^{2m}$ and $N$ is an invariant symmetric form, so $N$ is scalar by Schur. At $S^p\times S^p$, $O(p)\times O(p)$ makes $N=\mathop{\mathrm{diag}}(aI_p,bI_p)$ and the factor swap gives $a=b$. At $n=4$ it is the classical identity. Numerically $N=\tfrac4nI$ at $S^3\times S^3$, $S^4\times S^4$, $\mathbb{CP}^3$, $\mathbb{CP}^4$, and $S^2\times S^4$ has eigenvalues $0.25$ and $1.5$, so the unbalanced product is anisotropic.

## Item 6: scope, PLAUSIBLE with corrections

The sentence is conditional on item 4 and has to say so until $\Sigma_4\ge0$ is proved at $G=W^2$. Granting item 4, the argument gives more than exact isotropy. The band below $3/(n+2)$ is empty whenever $\lVert N\rVert_F^2\le\nu^\ast(n):=\tfrac{16}3\big(\theta_0^2-\tfrac3{2\theta_0^2}-\theta_0C_n\sqrt{3/(n+2)}\big)$, and $\nu^\ast(n)$ is $0.618$, $2.53$, $3.54$ at $n=30$, $60$, $100$ against $16/n=0.533$, $0.267$, $0.160$. So at $n=30$ the class is barely wider than isotropic, while at $n=100$ it covers every $N$ with $\lVert N\rVert_F^2\le3.54$, that is every $N$ spread at least as evenly as isotropic on $4.5$ directions. The italic reading "what remains is a critical point concentrated on few directions" is then accurate at large $n$ and loose near $n=30$. The honest statement of the split is the threshold $\nu^\ast(n)$ itself, and "spread tensors are cleared up to a threshold rising to about 0.17" should name the class it applies to, exactly isotropic $N$, since the threshold falls continuously as $\lVert N\rVert_F^2$ rises above $16/n$.

## Item 7: classification, PARTLY ON RECORD

Searched [findings/](../findings/), [results.md](../results.md) and reviews/*.md for $\theta p_3=p_4+\dots$, $W^2\#W^2$, $G^\#G$, $S_{22}$, $\lVert N\rVert_F$ and "index concentration".

- $\mathop{\mathrm{tr}}(G^\#G)=\tfrac12S_{22}$ is the record's "first free invariant" in [bounds.md](../findings/bounds.md), named, basis-free and with $S_{22}=2\theta\mathop{\mathrm{tr}}W^3-2\mathop{\mathrm{tr}}W^4+\tfrac12G_2$ at a critical point ([LIT-invariants](LIT-invariants.md)). Items 1 and 3 together are that identity with $G_2\ge0$ dropped, so the note should cite it and state the slack $\tfrac14G_2$.
- No upper bound on $S_{22}$ appears on the record, and no bound in terms of $N$. The occurrences of $\lVert N\rVert_F$ in [REVIEW_r379](REVIEW_r379.md), [REVIEW_r383](REVIEW_r383.md) and [plan-maximizer.md](plan-maximizer.md) are a different hollow matrix $N$.
- The identity $\mathop{\mathrm{tr}}((W^2)^\#W^2)=\tfrac18\lVert N\rVert_F^2-\tfrac12\Sigma_4$ and the quartic $\Sigma_4$ were found nowhere.

## Lean

The four declarations are correct scalar statements and match their descriptions. The file header's "Not typed" list names the coordinate formula, which is where the defect lies. `theta_sq_le` takes `hD : D ≤ ν / 8` as a hypothesis, so it is sound and the gap sits entirely in that hypothesis.

## Corrections for the author

1. Replace the coordinate formula by the exact identity $\mathop{\mathrm{tr}}((W^2)^\#W^2)=\tfrac18\lVert N\rVert_F^2-\tfrac12\Sigma_4$ and state the index step as conditional on $\Sigma_4\ge0$ at Weyl tensors, proved at $n=4$ (block argument above), false for general positive semidefinite $G$ ($P_+$ in $\mathfrak{so}(4)$: $6$ against $4.5$).
2. Drop the frame-wise intermediate $\tfrac12\sum_kr_k^2$, which the identity does not support and the display does not need.
3. Mark the display, the table and the $n\ge30$ sentence as conditional on step 1, and add $\theta>0$ to "at every unit critical point".
4. Restate the scope through $\nu^\ast(n)$: the band is empty at $n\ge30$ for $\lVert N\rVert_F^2\le\nu^\ast(n)$ ($0.618$, $2.53$, $3.54$ at $n=30$, $60$, $100$), wider than exact isotropy.
5. Cite [bounds.md](../findings/bounds.md)'s $S_{22}$ identity for items 1 and 3, giving $\mathop{\mathrm{tr}}(G^\#G)=\tfrac12S+\tfrac14G_2$.
6. Fix the screen's bracket normalisation (multiply its $B/2$ by $2$, or build $c$ at $\sqrt2$ times Frobenius) and re-state its line "$\tfrac12S\le\mathop{\mathrm{tr}}(G^\#G)$" with the corrected values.
7. Add $\Sigma_4\ge0$ at Weyl tensors, $n\ge5$, to the plan as the open step it now is.
