# VERIFY v130, L50: the bi-spectral identity $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$, its $n\le5$ collapse, and Li's $iklj$ order

**Verifier v130, cold brief, on [ROUND_L50.md](ROUND_L50.md)'s quoted block, [findings/bispectral.md](../findings/bispectral.md):127–149 with the canonical form at [results.md](../results.md):707 and the landscape line at :244.** No numerical work was done: no script was run, and every value below is an exact hand evaluation on objects constructed by hand. Log: [agent_logs/verify-L50-v130.log](../agent_logs/verify-L50-v130.log).

## Verdicts

| # | claim, as a consumer would cite it | verdict |
| --- | --- | --- |
| 1 | $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$, with $\sum\mu=\sum\omega=0$, $\sum\mu^2=1$, $\sum\omega^2=3$ | **PROVEN, hypotheses corrected** (the pairing hypothesis is unstated in the block; the identity is exact at every object checked) |
| 1a | the dictionary half $\alpha=8\operatorname{tr}(M^3)$ | **PROVEN**, three lines, reproduced in full in §2 |
| 1b | the dictionary half $\beta=2\langle M^\#,M\rangle$ | **HYPOTHESIS-DEBT**, asserted, no expansion on file; verified here on the coordinate-diagonal locus only |
| 1c | $\operatorname{tr}(\mathring W^3)=\tfrac18\alpha-\beta$ and $\operatorname{tr}(\mathring W^2)=\tfrac34\lvert W\rvert^2$ at $s=0$ | **PROVEN** for the import; Dai–Fu Lemma 3.3 read from the stored PDF, and both identities re-derived exactly at two objects |
| 1d | $\sum\omega^2=3$ rather than $1$ | **PROVEN**, it is $\tfrac34\lvert W\rvert^2$ at $\lvert W\rvert^2=4$; confirmed exactly at $n=4$ and $n=6$ |
| 2 | $\beta=\tfrac12\alpha$ at $n=4$ and $n=5$ | **HYPOTHESIS-DEBT**, the Lovelock display's proportionality and its constant $-\tfrac1{64}$ are asserted and script-fitted; verified here on one exact diagonal family per dimension |
| 2a | $\beta=\tfrac12\alpha$ fails at $n=6$ | **PROVEN**, exact witness in §4, the balanced $S^3\times S^3$ vertex matrix, $\beta-\tfrac\alpha2=\tfrac{140}3x^3$ |
| 2b | "For $n\le5$ (and only there), $\beta=\tfrac12\alpha$" as written | **GAP**, the quantifier "identically on $\mathcal W_n$" is missing and the sentence is false read pointwise; padded $W_{\mathbb{CP}^2}$ collapses at every $n$ |
| 2c | the generalised-Kronecker display covers $n=4$ and $n=5$ by one mechanism | **PROVEN**, conditional on 2, the delta vanishes for all $n\le5$ uniformly |
| 3 | $ikjl$ negates $\mathring W$ and the second coefficient | **PROVEN**, one line of pair antisymmetry, §5 |
| 3a | the record uses one order consistently | **BROKEN**, two orders are live; [stratum-two-negative.md](../findings/stratum-two-negative.md) and [isotropy-cap.md](../findings/isotropy-cap.md) run in $ikjl$ |
| 4 | the corollary $\mathrm{pr}(W^\#)=\tfrac12\mathrm{pr}(\iota_1^*(M^2))-\tfrac12\mathrm{pr}(\iota^*(\mathring W^2))$ | **PROVEN**, derived in full in §6, and $W^\#\notin\mathcal W_n$ exhibited exactly |
| 5 | [bispectral.md](../findings/bispectral.md):33's companion claim $Q(W)=\tfrac13\nabla\theta$ | **BROKEN**, true of $\nabla P$, false of $\nabla\theta$ off the critical set |
| 6 | "the syzygy is Lovelock's" | **unread source**, [references/](../references/) holds no Lovelock entry |
| 7 | a Lean row for L50 | **none exists**; [L62](../lean/INDEX.md) already imports the collapse as owed |

**One line.** The identity is right, the coefficients are right, and I reproduced both exactly at two hand-built objects, but one link of its dictionary and the whole $n\le5$ half of the collapse rest on assertion plus scripts, and the collapse sentence as written is false read pointwise.

## 0. Conventions, fixed once

Everything below runs in the record's own conventions, quoted from [conventions.md](../findings/conventions.md) rather than restated:

- **The $\Lambda^2$ pairing is the half-trace one**, $\langle X,Y\rangle=\tfrac12\operatorname{tr}(X^{\mathsf T}Y)$, under which $\{\varphi_{ab}=E_{ab}-E_{ba}\}_{a<b}$ is **orthonormal**. Plain Frobenius on the same vectors gives $\lVert\varphi_{ab}\rVert^2=2$, and [conventions.md](../findings/conventions.md) carries a boxed warning that the record once printed both numbers under one symbol.
- **$M$ is the pair matrix**, $M_{(ab),(cd)}=W_{abcd}$ for $a<b$, $c<d$, with $\lVert M\rVert_F=\lVert W\rVert$ and $\lvert W\rvert^2=\sum_{ijkl}W_{ijkl}^2=4\lVert M\rVert_F^2$.
- **$\#$ is the halved Böhm–Wilking product**, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$, and $Q(W)=W^2+W^\#$, $P(W)=\langle W,Q(W)\rangle$, $\theta=P(W)/\lVert W\rVert^3$.
- **The second-kind operator is Li's**, $(\mathring Wh)_{ij}=\sum_{k,l}W_{iklj}h_{kl}$ on $S^2_0$, read here from the stored PDF: [li-2112.08465.txt](https://arxiv.org/abs/2112.08465):309 prints eq. (2.2) as $\mathring R(e_i\odot e_j)=R_{iklj}\,e_k\odot e_l$.
- **$\mathcal D_n$** is the coordinate-diagonal locus: $W_{ijkl}=0$ unless $\{i,j\}=\{k,l\}$, determined by the sectional matrix $K_{ab}=W_{abab}$, symmetric, hollow, $K\mathbf1=0$.

Two closed-form consequences of $\mathcal D_n$ are used repeatedly below and derived once here, since the block leans on the diagonal locus without writing them down.

**(D1) The two cubics on $\mathcal D_n$.** $\alpha=8\sum_{a<b}K_{ab}^3$ and $\beta=6\sum_{i<j<k}K_{ij}K_{ik}K_{jk}$.

*Proof of the $\beta$ half.* In $\beta=W_{tspq}W_{tjpl}W_{sjql}$ the first factor forces $\{p,q\}=\{t,s\}$. If $p=t,q=s$: the second factor $W_{tjtl}$ forces $l=j$ and equals $K_{tj}$, the third is $W_{sjsj}=K_{sj}$, the first is $K_{ts}$, and $t,s,j$ must be distinct, giving $\sum_{t,s,j\ \mathrm{distinct}}K_{ts}K_{tj}K_{sj}=6\sum_{i<j<k}K_{ij}K_{ik}K_{jk}$. If $p=s,q=t$: $\{t,j\}=\{s,l\}$ with $t\ne s$ forces $j=s$, which kills the third factor. $\square$

**(D2) The second-kind operator on $\mathcal D_n$.** $\mathring W$ is diagonal on the off-diagonal entries with $(\mathring Wh)_{ij}=K_{ij}h_{ij}$ for $i\ne j$, and acts on the diagonal as $(\mathring Wh)_{ii}=-\sum_kK_{ik}h_{kk}$, i.e. as $-K$ on $\mathbf1^\perp$. So $\omega=\{K_{ab}\}_{a<b}\ \cup\ \{-\text{eigenvalues of }K\text{ on }\mathbf1^\perp\}$.

*Proof.* $W_{iklj}\ne0$ needs $\{i,k\}=\{l,j\}$. Either $l=i,j=k$, giving $W_{ikik}h_{ki}=K_{ij}h_{ij}$ when $j=k$; or $l=k,j=i$, giving $W_{ikki}h_{kk}=-K_{ik}h_{kk}$. $\square$

**(D2) reproduces Li Example 2.4 exactly**: on the round sphere $K_{ij}\equiv1$, so $K=J-I$, the off-diagonal block gives $+1$ and the diagonal block gives $-(J-I)\vert_{\mathbf1^\perp}=+\mathrm{Id}$, Li's $\mathring R=+\mathrm{Id}$ on $S^2_0$. That is the anchor [conventions.md](../findings/conventions.md) names, recovered here from the definition rather than quoted.

## 1. The hypothesis inventory

**Hypotheses the block states.** $W\in\mathrm{Weyl}_n$; $M$ is $W$ acting on $\Lambda^2\mathbb R^n$; $\lVert M\rVert_F=1$; $\mathring W$ is the second-kind operator on trace-free symmetric $2$-tensors in the index order $iklj$.

**Hypotheses the block uses and does not state.**

| unstated hypothesis | where it bites | is it on the record? |
| --- | --- | --- |
| the **half-trace** $\Lambda^2$ pairing, under which $\varphi_{ab}=E_{ab}-E_{ba}$ is orthonormal | $\#$ is built from structure constants in an orthonormal frame; under plain Frobenius the frame is $\varphi/\sqrt2$, $T_{ABC}$ halves, and the dictionary reads $\beta=4\langle M^\#,M\rangle$, breaking the identity | yes, [conventions.md](../findings/conventions.md), with a boxed warning that the two readings already collided once |
| $M_{(ab),(cd)}=W_{abcd}$ with **no** factor $\tfrac12$ | this is exactly what makes $\alpha=8\operatorname{tr}(M^3)$ rather than $\operatorname{tr}(M^3)$ | yes, [conventions.md](../findings/conventions.md), "the $\tfrac12$ goes at the $\Lambda^2$ level, not the operator level" |
| $n\ge4$ | $\mathrm{Weyl}_n=0$ below; [L52](../findings/bispectral.md) states $n\ge4$, L50 does not | in the sibling lemma only |
| $\mathring W$ is taken on $S^2_0$, **not** $S^2$ | Dai–Fu's trace subtracts the $g/\sqrt n$ direction, legitimate only because $g$ is an eigenvector | stated in the block |

**Hypotheses of the imported results, checked against the object they are applied to.**

- **Dai–Fu Lemma 3.3** ([dai-fu-2311.18235.txt](https://arxiv.org/abs/2311.18235):381–390, read here, not cited from memory) is stated for an $n$-dimensional **Einstein manifold**. The block applies it "at $s=0$ and used as the pointwise algebraic identity it is". **That is legitimate, and the reason is specific**: the only place their proof consumes the Einstein condition is in passing from $\operatorname{tr}_{S^2}$ to $\operatorname{tr}_{S^2_0}$ by subtracting the $g/\sqrt n$ direction, which requires $g/\sqrt n$ to be an eigenvector of $\tilde R$. On an algebraic Weyl tensor $\sum_kW_{ikkj}=0$, so $\tilde W(g)=0$ and $g$ is in the kernel. The remaining steps are pure index algebra. Their Lemma also assumes $n\ge3$, satisfied.
- **Li 2021 eq. (2.2)** is a definition, so it carries no hypothesis beyond $R$ having the pair symmetries. Read from the stored PDF text at line 309.
- **Lovelock's dimensionally-dependent identity** carries the hypothesis that the ambient dimension is $n$. [references/](../references/) holds **no Lovelock entry**, so this attribution rests on an unread source. The mathematical content actually used, that $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}$ antisymmetrises over six indices and so vanishes identically when $n\le5$, is elementary and correct without the citation.
- **Böhm–Wilking**, that $Q$ preserves $\mathcal W_n$, is used implicitly in §6 and is on the record.

**Which of these the written proof uses.** All four unstated hypotheses in the table are load-bearing. The pairing hypothesis is the one a consumer is most likely to get wrong, because the block's own words ("Hamilton's sharp with respect to the **unnormalised** $\phi_{ij}=E_{ij}-E_{ji}$"), name the vectors but not the pairing, and the word "unnormalised" points a reader towards the plain-Frobenius reading in which $\lVert\phi_{ij}\rVert^2=2$ and the dictionary constant is $4$, not $2$.

## 2. Question 1, does the identity hold, with those coefficients?

### 2.1 The chain, step by step

**Step 1, $\alpha=8\operatorname{tr}(M^3)$. Correct, and immediate.** $\alpha=W_{tpsq}W_{tpkl}W_{sqkl}$; pair symmetry rewrites it as $\sum W_{(tp)(sq)}W_{(sq)(kl)}W_{(kl)(tp)}$ over all six free indices, and each pair sum over ordered indices is twice the sum over $a<b$, so $\alpha=2^3\operatorname{tr}(M^3)=8\operatorname{tr}(M^3)$. **This step also pins the normalisation**: it is true only for $M_{(ab),(cd)}=W_{abcd}$ with no factor $\tfrac12$.

**Step 2, $\beta=2\langle M^\#,M\rangle$. Asserted; no expansion on file.** The block's whole argument is "Expanding each in the coordinate pair basis and using only the pair symmetries gives …", and [bispectral.md](../findings/bispectral.md):29 replaces the expansion with a script citation, "exactly at every $n\ge4$ ([run_bispectral_dictionary.py](../scripts/runs/run_bispectral_dictionary.py))". I read [ATTEMPTS.md](../ATTEMPTS.md):2288–2302, which the record cites for this cycle; it repeats the dictionary as a display and points at [target.md](../findings/target.md), where no expansion appears either. **There is no derivation of this step anywhere on the record.** See §3 for what I could check.

**Step 3, Dai–Fu at $s=0$.** $\operatorname{tr}(\mathring W^3)=\tfrac18\alpha-\beta$ and $\operatorname{tr}(\mathring W^2)=\tfrac34\lvert W\rvert^2$. Both are Lemma 3.3's second and third identities with $s=0$; the transcription in the block matches the PDF exactly. Applied legitimately (§1).

**Step 4, the substitution.** With steps 1–3, $p_3(\omega)=\operatorname{tr}(\mathring W^3)=\operatorname{tr}(M^3)-2\langle M^\#,M\rangle=p_3(\mu)-2\langle M^\#,M\rangle$, so $\langle M^\#,M\rangle=\tfrac12\big(p_3(\mu)-p_3(\omega)\big)$, and
$$\theta=\operatorname{tr}(M^3)+\langle M^\#,M\rangle=p_3(\mu)+\tfrac12p_3(\mu)-\tfrac12p_3(\omega)=\tfrac32p_3(\mu)-\tfrac12p_3(\omega).$$
**The arithmetic is right, and the two coefficients are forced by it**: $\tfrac32=1+\tfrac12$ comes from $\operatorname{tr}(M^3)$ plus half of it, and $-\tfrac12$ is the coefficient with which $p_3(\omega)$ enters $\langle M^\#,M\rangle$. Neither is a fitted constant.

### 2.2 Why $\sum\omega^2=3$ and not $1$

$\sum\omega^2=\operatorname{tr}(\mathring W^2)=\tfrac34\lvert W\rvert^2$, and $\lvert W\rvert^2=4\lVert M\rVert_F^2=4$ at the stated normalisation, so $\sum\omega^2=3$. **The pair $(\tfrac32,-\tfrac12)$ does not depend on this.** Both spectra scale together under $W\mapsto cW$ and $\theta$ is the ratio $P/\lVert W\rVert^3$, so the relative coefficients are scale-invariant; what the normalisation fixes is the two constants $1$ and $3$. Concretely:

| normalisation | $\sum\mu^2$ | $\sum\omega^2$ | the coefficient pair |
| --- | --- | --- | --- |
| the record's, $\lVert M\rVert_F=1$ | $1$ | $3$ | $(\tfrac32,-\tfrac12)$ |
| $\lvert W\rvert_4=1$, the reading [post F33](../findings/fence-posts.md) works in | $\tfrac14$ | $\tfrac34$ | $(\tfrac32,-\tfrac12)$, with $\theta$ itself scaled by $\tfrac18$ |
| $\mathring W$ separately unit-normalised, $\hat\omega=\omega/\sqrt3$ | $1$ | $1$ | $(\tfrac32,-\tfrac{3\sqrt3}2)$ |
| Bourguignon–Karcher's $ikjl$ order | $1$ | $3$ | $(\tfrac32,+\tfrac12)$ |

The third row is the one worth flagging: **the "why not $1$" question has a real answer**, normalising both spectra to unit second moment, the natural-looking choice, replaces $-\tfrac12$ by the irrational $-\tfrac{3\sqrt3}2$. [conventions.md](../findings/conventions.md) already carries the cross-file trap for row two.

### 2.3 Two exact anchors, computed by hand

**Anchor A, $n=4$, the self-dual diagonal Weyl tensor.** Take $K_{12}=K_{34}=2s$, $K_{13}=K_{24}=K_{14}=K_{23}=-s$, which is symmetric, hollow, and has row sums $2s-s-s=0$. Then $\lVert M\rVert_F^2=2(4s^2)+4s^2=12s^2$, so $s^2=\tfrac1{12}$ and $s^3=\tfrac1{24\sqrt3}$.

- $\mu=(2s,2s,-s,-s,-s,-s)$, so $p_3(\mu)=16s^3-4s^3=12s^3$ and $\alpha=96s^3$.
- By (D1), $\sum_{i<j<k}K_{ij}K_{ik}K_{jk}=4\cdot 2s^3=8s^3$ (each of the four triangles carries one entry $2s$ and two entries $-s$), so $\beta=48s^3$.
- $K$ has eigenvalues $0$ (on $\mathbf1$), $4s$ (on $(1,1,-1,-1)$), $-2s$ twice. By (D2), $\omega=(2s,2s,-s,-s,-s,-s\ ;\ -4s,2s,2s)$, nine values as $\dim S^2_0(\mathbb R^4)=9$ requires.
- $\sum\omega=4s-4s+(-4s+2s+2s)=0$. $\sum\omega^2=8s^2+4s^2+16s^2+8s^2=36s^2=3$. **Exactly $3$.**
- $p_3(\omega)=16s^3-4s^3-64s^3+16s^3=-36s^3$. Dai–Fu predicts $\tfrac18\alpha-\beta=12s^3-48s^3=-36s^3$. **Exact agreement**, so Lemma 3.3's cubic identity is confirmed at a nontrivial object, independently of the paper.
- $\theta=p_3(\mu)+\tfrac12\beta=12s^3+24s^3=36s^3=\tfrac{36}{24\sqrt3}=\tfrac{\sqrt3}2$, which is [conventions.md](../findings/conventions.md)'s $\Theta_4=0.866$.
- **The identity:** $\tfrac32(12s^3)-\tfrac12(-36s^3)=18s^3+18s^3=36s^3=\theta$. **Exact.**

**Anchor B, $n=6$, the balanced product.** Split $\{1,\dots,6\}$ into two triples; $K_{ij}=x$ inside a triple and $y=-\tfrac23x$ across. Row sums $2x+3y=0$. Then $\lVert M\rVert_F^2=6x^2+9\cdot\tfrac49x^2=10x^2$, so $x^2=\tfrac1{10}$.

- $p_3(\mu)=6x^3+9y^3=6x^3-\tfrac83x^3=\tfrac{10}3x^3$, so $\alpha=\tfrac{80}3x^3$.
- Triangles: $2$ monochromatic ($x^3$ each) and $18$ mixed ($xy^2=\tfrac49x^3$ each), total $2x^3+8x^3=10x^3$; $\beta=60x^3$.
- $K$ has eigenvalues $0$, $4x$ (on $(\mathbf1_3,-\mathbf1_3)$) and $-x$ with multiplicity $4$. By (D2), $\omega$ is $x$ six times, $-\tfrac23x$ nine times, $-4x$ once and $x$ four times, twenty values, as $\dim S^2_0(\mathbb R^6)=20$.
- $\sum\omega^2=6x^2+4x^2+16x^2+4x^2=30x^2=3$. **Exactly $3$ again.**
- $p_3(\omega)=6x^3-\tfrac83x^3-64x^3+4x^3=-\tfrac{170}3x^3$; Dai–Fu predicts $\tfrac18\alpha-\beta=\tfrac{10}3x^3-60x^3=-\tfrac{170}3x^3$. **Exact.**
- $\theta=\tfrac{10}3x^3+30x^3=\tfrac{100}3x^3=\tfrac{100}{3\cdot10\sqrt{10}}=\tfrac{\sqrt{10}}3$, which is $\theta_0(6)=\sqrt{40}/6=1.054093$, so this object **is** the balanced $S^3\times S^3$ vertex matrix.
- **The identity:** $\tfrac32\cdot\tfrac{10}3x^3-\tfrac12\big(-\tfrac{170}3x^3\big)=5x^3+\tfrac{85}3x^3=\tfrac{100}3x^3=\theta$. **Exact.**

**Three independent corroborations fall out of anchor B, each recomputed here and each matching the record.** $p_3(\mu)=\tfrac1{3\sqrt{10}}=0.105409$ against [bispectral.md](../findings/bispectral.md):416's closed form $2\sqrt2/(n\sqrt{(n-1)(n-2)})$; $\operatorname{tr}(W^3)/\theta=\tfrac1{10}=2/((n-1)(n-2))$, the boxed ratio at [nondegeneracy.md](../findings/nondegeneracy.md); and $\omega$ takes the three values $3A,-2A,-12A$ with multiplicities $10,9,1$ at $A=x/3$, which is [Lemma L67](../findings/bispectral.md)'s $\big(mA^{(m-1)(m+2)},-(m-1)A^{m^2},-2m(m-1)A^{1}\big)$ at $m=3$.

**And the record's own $C$ reproduces.** [nondegeneracy.md](../findings/nondegeneracy.md) states $C=-40\operatorname{tr}(W^3)+8\langle W^\#,W\rangle$ with $\theta=6\operatorname{tr}(W^3)+\tfrac18C$; substituting gives $\theta=\operatorname{tr}(W^3)+\langle W^\#,W\rangle$, L50's own starting point, and at $S^6\times S^6$ where $\operatorname{tr}(W^3)=\theta_0(12)/55=0.0224733$ and $\langle W^\#,W\rangle=1.2135597$ it gives $C=8.809545$, the figure that file records to six places.

### 2.4 Verdict on question 1

**The identity holds, with those coefficients, and the coefficients are derived rather than fitted.** The chain is sound at every link I can check, and it lands exactly at two hand-built objects in two dimensions, one of them the conjectured maximiser at $n=6$. **The one link with no argument on file is $\beta=2\langle M^\#,M\rangle$**, taken up next.

## 3. The one link with no argument on file, $\beta=2\langle M^\#,M\rangle$

**Locate it.** [bispectral.md](../findings/bispectral.md):135 and :29, and [results.md](../results.md):707's proof paragraph, all in the same words: "Expanding each in the coordinate pair basis and using only the pair symmetries gives $\alpha=8\operatorname{tr}(M^3)$ and $\beta=2\langle M^\#,M\rangle$, where $M^\#$ is Hamilton's sharp with respect to the unnormalised $\phi_{ij}=E_{ij}-E_{ji}$."

**What I checked, and what came out.** From [conventions.md](../findings/conventions.md)'s $\#$, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$, one gets $\langle R^\#,R\rangle=\tfrac12\sum_{A,B,C}T_{ABC}\lambda_A\lambda_B\lambda_C$ in a spectral frame with $T_{ABC}=\langle[\varphi_A,\varphi_B],\varphi_C\rangle^2$. On $\mathcal D_n$ the pair basis **is** the spectral frame, $T_{ABC}=1$ exactly on the six orderings of a triangle's three edges and $0$ otherwise, so
$$\langle M^\#,M\rangle=\tfrac12\cdot 6\sum_{i<j<k}K_{ij}K_{ik}K_{jk}=3\sum_{i<j<k}K_{ij}K_{ik}K_{jk},$$
against (D1)'s $\beta=6\sum_{i<j<k}K_{ij}K_{ik}K_{jk}$. **So $\beta=2\langle M^\#,M\rangle$ holds identically on the coordinate-diagonal locus**, at every $n$, by an argument I can write out. A second route agrees: on $\mathcal D_n$, $M^\#$ is diagonal with entries $(K^2)_{ab}$ and $\langle M^\#,M\rangle=\tfrac12\operatorname{tr}(K^3)$.

**What remains unchecked.** $\mathcal D_n$ and its $O(n)$-orbit are a proper subvariety of $\mathcal W_n$ for $n\ge6$ ($\dim\mathcal D_6+\dim O(6)=9+15=24$ against $\dim\mathcal W_6=84$) so agreement there is **not** agreement on $\mathcal W_n$. Both sides are $O(n)$-invariant cubics, and there is a classical route that would close the gap: if the space of $O(n)$-invariant cubics on $\mathcal W_n$ is two-dimensional, spanned by $\alpha$ and $\beta$, then agreement on any set where $\alpha,\beta$ are independent forces equality. **That invariant-theory input is nowhere on this record, and supplying it is not a verifier's job.**

**Verdict: HYPOTHESIS-DEBT.** What would have to be shown, exactly: either (i) the expansion of $W_{tspq}W_{tjpl}W_{sjql}$ in the pair basis against $\tfrac12\sum T_{ABC}$ carried out for general $W\in\mathcal W_n$, the block claims it "uses only the pair symmetries", so first Bianchi should not be needed and the claim is checkable as stated; or (ii) the dimension count $\dim\big(\mathrm{Sym}^3(\mathcal W_n)^*\big)^{O(n)}=2$ together with the diagonal-locus evaluation above.

**Falsifier.** What would break the dictionary is a $W\in\mathcal W_n$, necessarily off the $O(n)$-orbit of $\mathcal D_n$ and necessarily at $n\ge6$, with $\beta\ne2\langle M^\#,M\rangle$. I looked for one in the only way this footing allows, by asking whether either side can carry a piece the other cannot. Neither can: both are $O(n)$-invariant, both are cubic, and both vanish on the $\mathrm{Ric}$-part by construction. **I found no obstruction and no witness**, and the block's chain reproduces exactly at both anchors, which is why the verdict is a debt rather than a break.

## 4. Question 2, is the collapse range exactly $n\le5$?

On $\mathcal D_n$, (D1) makes the collapse condition $\beta=\tfrac12\alpha$ read $3\sum_{i<j<k}K_{ij}K_{ik}K_{jk}=2\sum_{a<b}K_{ab}^3$, which is checkable by hand in any dimension.

### 4.1 $n=4$, holds

Anchor A gives $\alpha=96s^3$ and $\beta=48s^3$, so $\beta=\tfrac12\alpha$ **exactly**. The consequences the block draws follow: $\langle W^\#,W\rangle=\tfrac12\beta=24s^3=2\operatorname{tr}(W^3)$ and $\theta=36s^3=3\operatorname{tr}(W^3)$.

### 4.2 $n=5$, holds on an exact family

Take $K_{ij}=a$ for $i,j\in\{1,2,3\}$, $K_{45}=3a$, and $K_{i4}=K_{i5}=-a$ for $i\in\{1,2,3\}$. Row sums: $2a+2(-a)=0$ for $i\le3$, and $3(-a)+3a=0$ for $i\in\{4,5\}$, so this is a genuine element of $\mathcal D_5$ and it is not a padded $n=4$ tensor.

- $\sum_{a<b}K_{ab}^3=3a^3+27a^3+6(-a^3)=24a^3$.
- Triangles: $\{1,2,3\}$ gives $a^3$; the six with two vertices in $\{1,2,3\}$ give $a(-a)(-a)=a^3$ each; the three with both of $4,5$ give $(-a)(-a)(3a)=3a^3$ each. Total $a^3+6a^3+9a^3=16a^3$.
- $3\cdot16a^3=48a^3=2\cdot24a^3$. **$\beta=\tfrac12\alpha$ exactly.**

### 4.3 $n=6$, fails, at a named object

Anchor B is the witness. $\alpha=\tfrac{80}3x^3$ and $\beta=60x^3$, so
$$\beta-\tfrac\alpha2=60x^3-\tfrac{40}3x^3=\tfrac{140}3x^3\ \ne\ 0\quad\text{for }x\ne0 .$$
At $x=1/\sqrt{10}$ this is $\tfrac{140}{30\sqrt{10}}=\tfrac{14}{3\sqrt{10}}=1.4757\ldots$. **The failure at $n=6$ is therefore proved, not measured**, and the witness is the conjectured maximiser rather than a random tensor. Equivalently $\theta=\tfrac{\sqrt{10}}3$ while $3\operatorname{tr}(W^3)=3\cdot\tfrac1{3\sqrt{10}}=\tfrac1{\sqrt{10}}$, a ratio of $\tfrac{10}3$, the collapse misses by a factor $3.33$, not by a rounding error.

### 4.4 What the generalised-Kronecker display establishes, and what it does not

$$\beta-\tfrac{\alpha}{2}=-\tfrac1{64}\,\delta^{a_1\cdots a_6}_{b_1\cdots b_6}\,W_{a_1a_2}{}^{b_1b_2}W_{a_3a_4}{}^{b_3b_4}W_{a_5a_6}{}^{b_5b_6}$$

- **The delta half is correct and elementary.** $\delta^{a_1\cdots a_6}_{b_1\cdots b_6}=\det(\delta^{a_i}_{b_j})$ antisymmetrises over six indices ranging in $\{1,\dots,n\}$, so it vanishes identically exactly when $n<6$. Since this holds uniformly for all $n\le5$, **the display does cover $n=4$ and $n=5$ by one mechanism**, as claimed, and the block's correction of [fence post F2g](../findings/fence-posts.md), that $O(4)$-reducibility is not the separating fact, since $\mathcal W_5$ is $O(5)$-irreducible and collapses anyway, is sound.
- **The display establishes one direction only.** From it, $n\le5\Rightarrow\beta=\tfrac12\alpha$. The converse (that the collapse fails at $n\ge6$), needs the contraction to be non-zero somewhere at $n=6$, which the display alone does not supply. [bispectral.md](../findings/bispectral.md) supplies it as "It fails at $n=6,7$" from [run_n5_syzygy.py](../scripts/runs/run_n5_syzygy.py); §4.3 above supplies it as a theorem.
- **The proportionality and the constant are asserted.** [bispectral.md](../findings/bispectral.md) says in as many words: "The constant $-64$ is verified at $n=6,7,8$ ([run_lovelock_syzygy.py](../scripts/runs/run_lovelock_syzygy.py))." No expansion of the six-index delta against three Weyl tensors appears anywhere on the record, in the block, in [ATTEMPTS.md](../ATTEMPTS.md):2288–2302, or in [target.md](../findings/target.md). **So the whole $n\le5$ half of the collapse rests on a display whose only support is a numerical fit of its constant.**

**Verdict on question 2: HYPOTHESIS-DEBT on the $n\le5$ direction, PROVEN on the $n\ge6$ direction.** What would have to be shown: that the six-index contraction equals $-64(\beta-\tfrac\alpha2)$ identically on $\mathcal W_n$. The natural route is that expanding the delta gives a dimension-free combination of the degree-three invariants (no free index is contracted inside the delta, so no factor of $n$ can appear), leaving $\lambda\alpha+\nu\beta$ with $(\lambda,\nu)$ to be computed. **That computation is what is missing**; the record has its answer without its working.

### 4.5 The quantifier, a discrepancy, and it survives the protocol

**Locate it.** [bispectral.md](../findings/bispectral.md):139 and the same words at [results.md](../results.md):707's block: "**For $n\le5$ (and only there), $\beta=\tfrac12\alpha$**, so $\langle W^\#,W\rangle=2\operatorname{tr}(W^3)$ and $\theta=3\operatorname{tr}(W^3)$ is a function of $\mu$ alone." And in the canon at [results.md](../results.md):244: "Collapses to one spectrum exactly for $n\le5$."

**Exhibit the failure concretely.** Read pointwise, the reading the words support, since $\beta$ and $\alpha$ are functions of a tensor and not of a dimension, "and only there" is false at every $n\ge6$. Padding $W_{\mathbb{CP}^2}\in\mathcal W_4$ into $\mathcal W_n$ leaves every index of $\alpha$ and $\beta$ inside the original four coordinates, so both are unchanged and $\beta=\tfrac12\alpha$ continues to hold at that point of $\mathcal W_{12}$. **The record confirms this against itself**: [nondegeneracy.md](../findings/nondegeneracy.md) records $\operatorname{tr}(W^3)/\theta=0.3333$ at padded $W_{\mathbb{CP}^2}$, which is $\theta=3\operatorname{tr}(W^3)$ (the collapsed form), at $n\ge6$.

**Argue the opposite.** The most charitable reading is "$\beta=\tfrac12\alpha$ **identically on** $\mathcal W_n$, and identically only for $n\le5$", which is true and is what the Lovelock display proves. That reading is the one [ATTEMPTS.md](../ATTEMPTS.md):2296 writes down ("For $n\le5$, $\beta=\tfrac12\alpha$ **as trilinear forms**") and it is the only place on the record where the quantifier appears.

**Verdict: GAP, a statement defect.** The theorem is true under the intended reading; the sentence as written is not, and the three words that fix it live in [ATTEMPTS.md](../ATTEMPTS.md), in another file, where no consumer of [results.md](../results.md):244 will meet them. **This is precisely the record's named trap** (a correction standing beside the statement it corrects) and the canon line at :244 inherits the defect in its shortest possible form.

## 5. Question 3, is the index order load-bearing as stated?

**The claim is correct, and its proof is one line.** Write $(\mathring W'h)_{ij}=\sum_{k,l}W_{ikjl}h_{kl}$ for the other order. Antisymmetry of $W$ in its last pair gives $W_{ikjl}=-W_{iklj}$, so $\mathring W'=-\mathring W$ identically, hence $\omega'=-\omega$, $p_3(\omega')=-p_3(\omega)$, and the identity reads $\theta=\tfrac32p_3(\mu)+\tfrac12p_3(\omega')$. **Both halves of the block's sentence are therefore right**: $ikjl$ negates the operator, and it flips the sign of the second coefficient. Note that $\sum\omega^2=3$ is **unchanged** by the flip, so the norm relation is no test of the order, the anchors that do test it are Li Example 2.4 and 2.5, and (D2) reproduces the first of them from the definition in §0.

**Whether the record uses one order consistently, it does not.**

| file | order | status |
| --- | --- | --- |
| [bispectral.md](../findings/bispectral.md), [results.md](../results.md), [target.md](../findings/target.md), [conventions.md](../findings/conventions.md) | Li's $iklj$ | the record's declared standard |
| [stratum-two-negative.md](../findings/stratum-two-negative.md):323 | Bourguignon–Karcher's $ikjl$, $(\mathring Rh)_{ij}=\sum_{k,l}e_{ikjl}h_{kl}$ | written consistently in the other order; [conventions.md](../findings/conventions.md) says so and that "that conversion changes result statements and is queued for a verification round" |
| [isotropy-cap.md](../findings/isotropy-cap.md):293 | $\sum_{k,l}R_{ikjl}\omega^{kl}$, the $ikjl$ contraction | unflagged |

**Verdict: the load-bearing claim is PROVEN; the consistency claim is BROKEN.** Two orders are live on the record, one of them under an explicit unpaid conversion debt. **This does not touch L50's own correctness**, [bispectral.md](../findings/bispectral.md) and [results.md](../results.md) are both in Li's order, and my anchors were computed in Li's order and came out right. It touches any consumer who reads a second-kind eigenvalue out of [stratum-two-negative.md](../findings/stratum-two-negative.md) and substitutes it into L50's $p_3(\omega)$: that substitution flips the sign of the whole second term. [conventions.md](../findings/conventions.md) names this as "the trap", which is the correct classification.

## 6. The corollary said to be correct only with $\mathrm{pr}$ on both sides

**It is correct, and I derived it in full.** $P$ is a cubic form on $\mathcal W_n$, so its gradient within $\mathcal W_n$ is $\nabla P=3\,\mathrm{pr}\big(W^2+W^\#\big)=3Q(W)$, the projection being redundant because Böhm–Wilking's theorem puts $Q(W)$ in $\mathcal W_n$ already. Differentiating the right side of the identity, with $\iota_1:\mathcal W_n\to\mathrm{Sym}(\Lambda^2)$ and $\iota:W\mapsto\mathring W$,
$$\nabla\big(\tfrac32p_3(\mu)\big)=\tfrac92\,\iota_1^*(M^2),\qquad \nabla\big(-\tfrac12p_3(\omega)\big)=-\tfrac32\,\iota^*(\mathring W^2),$$
since $\delta\operatorname{tr}(M^3)=3\langle M^2,\delta M\rangle$ and likewise for $\mathring W$. Equating and dividing by $3$,
$$W^2+W^\#=\tfrac32\,\iota_1^*(M^2)-\tfrac12\,\iota^*(\mathring W^2).$$
Applying $\mathrm{pr}$ and using $\mathrm{pr}(W^2)=\mathrm{pr}(M^2)=\iota_1^*(M^2)$ gives $\mathrm{pr}(W^\#)=\tfrac12\mathrm{pr}(\iota_1^*(M^2))-\tfrac12\mathrm{pr}(\iota^*(\mathring W^2))$, **the display, exactly.**

**What fails without the projection, and at what object.** The un-projected equation would assert $W^\#=\tfrac32\iota_1^*(M^2)-\tfrac12\iota^*(\mathring W^2)-M^2$, an equation between an object outside $\mathcal W_n$ and objects already inside it. **$W^\#$ genuinely lies outside, and this is exhibitable exactly on $\mathcal D_n$**: there $M^\#$ is diagonal in the pair basis with entries $(K^2)_{ab}$, and the row sums of that vertex matrix are $\sum_{b\ne a}(K^2)_{ab}=(K^2\mathbf1)_a-(K^2)_{aa}=-\lVert K_a\rVert^2$, which is non-zero whenever $K\ne0$. **A diagonal operator whose vertex matrix has non-zero row sums is not Ricci-flat, hence not a Weyl tensor.** At anchor B, every row sum of $M^\#$'s vertex matrix is $-\lVert K_a\rVert^2=-(2x^2+3\cdot\tfrac49x^2)=-\tfrac{10}3x^2=-\tfrac13$.

The same computation shows why $Q$ nonetheless preserves $\mathcal W_n$: $M^2$ is diagonal with entries $K_{ab}^2$ and row sums $+\lVert K_a\rVert^2$, so the two defects cancel in $M^2+M^\#$. **Neither summand alone is a Weyl tensor, and $\mathrm{pr}$ on the left is what repairs that.** The block's "about $60\%$ of its norm lying outside" is a measured figure I did not check and do not need: the qualitative claim is a theorem.

**One companion claim in the same block is wrong.** [bispectral.md](../findings/bispectral.md):33 displays the corollary alongside "$Q(W)=\tfrac13\nabla\theta$", and the reviewers' bullet reads "$Q=\nabla\theta/3$, not $\nabla\theta$, ratio $3.000000$ exactly in every component."

- **Locate it.** The trailing clause of the corollary display in [bispectral.md](../findings/bispectral.md), "The gradient form, correct with $\mathrm{pr}$ on both sides, and inert".
- **Exhibit the failure.** [conventions.md](../findings/conventions.md) defines $\theta=P(W)/\lVert W\rVert^3$. At $\lVert W\rVert=1$, $\nabla\theta=\nabla P-3PW=3Q(W)-3\theta W$, so $Q(W)=\tfrac13\nabla\theta$ requires $\theta W=0$. At anchor B, $\theta=\tfrac{\sqrt{10}}3\ne0$ and $W\ne0$, so $\tfrac13\nabla\theta=Q(W)-\theta W\ne Q(W)$. The claimed "ratio $3.000000$ exactly in every component" can only have been measured against $\nabla P$.
- **Argue the opposite.** The charitable reading is that $\theta$ there denotes the **cubic form** $P$, which the Lemma statement itself invites by writing "$\theta=\langle W,Q(W)\rangle$", true at unit norm as a number. Under that reading the sentence is correct.
- **Verdict: BROKEN as a standalone claim, harmless to the corollary.** The corollary is unaffected either way, because $P$ and $\theta$ differ by a factor $\lVert W\rVert^{-3}$ applied to both sides of an identity between functions. But the symbol $\theta$ carries a norm and $P$ does not, and a consumer who takes the sentence at face value gets a false gradient at every non-critical point.

## 7. Quantifiers, scope, and the edges of every range

- **$n=4$.** Holds; anchor A is exact. $\mathcal W_4$ is $O(4)$-reducible, which the block correctly declines to use as the mechanism.
- **$n=5$.** Holds on the exact family of §4.2, and $\mathcal W_5$ is $O(5)$-irreducible, so the block's correction of [fence post F2g](../findings/fence-posts.md) stands.
- **$n=6$.** Collapse fails, proved in §4.3. The identity itself holds; anchor B verifies it exactly.
- **Odd $n$.** **No finding.** Nothing in L50 is parity-sensitive: the derivation runs through $\alpha$, $\beta$ and Dai–Fu's traces, none of which sees the parity of $n$, and $\dim S^2_0=(n-1)(n+2)/2$ is an integer at every $n$. The record's parity trouble is confined to $\theta_0(n)$ versus $\Theta_n$ ([conventions.md](../findings/conventions.md)), which L50 does not mention and does not use. The one place parity could have entered is §4.2's $n=5$ family, and it is exact.
- **$\ker W\ne0$.** **No hypothesis is needed and none is missing.** The identity is an equality of cubic polynomials on $\mathcal W_n$; degenerate spectra are ordinary points. Anchor A has $\det M\ne0$; padded tensors, which have $\ker M\ne0$ and $\ker\mathring W\ne0$, satisfy it too, since padding leaves $\alpha$, $\beta$ and $\lVert M\rVert_F$ unchanged and appends zeros to both spectra, under which $\sum\omega^2=3$ is preserved. Contrast [W4](../findings/INDEX-traps.md), where $\ker W\ne0$ voids a screen; nothing of that kind arises here.
- **Homogeneity.** The stated form fixes $\lVert M\rVert_F=1$. The homogeneous form a consumer needs at other norms is $P(W)=\tfrac32\operatorname{tr}(M^3)-\tfrac12\operatorname{tr}(\mathring W^3)$, all three terms of degree three. **Neither the block nor [results.md](../results.md):707 states it**, and [results.md](../results.md):244 states neither the normalisation nor the homogeneous form, it says only "$\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$", where $\mu$ and $\omega$ are undefined without the norm. A reader arriving from [post F33](../findings/fence-posts.md)'s $\lvert W\rvert_4=1$ gets $\sum\mu^2=\tfrac14$ and $\sum\omega^2=\tfrac34$; [conventions.md](../findings/conventions.md) flags exactly this as "a cross-file normalisation trap, live".
- **Quantifier order.** The statement is $\forall n\ \forall W\in\mathrm{Weyl}_n$, with $\mu$ and $\omega$ functions of $W$. Correct as written. The collapse sentence is the one whose quantifier is wrong (§4.5), and the record's own history, [fence post F2g](../findings/fence-posts.md), refuted for a quantifier inversion, makes that the failure mode this block should have been most careful about.

## 8. Comparing the forms

| site | what it says | agrees? |
| --- | --- | --- |
| [bispectral.md](../findings/bispectral.md):15–21 | the identity, the four moment constraints, Li's order named with the arXiv link, the $ikjl$ flip | yes, and it is the fullest form |
| [bispectral.md](../findings/bispectral.md):133–137 | the canonical statement, quoted in the brief | identical to :15–21 |
| [results.md](../results.md):707 | the same statement, with the proof pointer to [bispectral.md](../findings/bispectral.md) | yes |
| [results.md](../results.md):244 | "$\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ on $\mathrm{Weyl}_n$ … Collapses to one spectrum exactly for $n\le5$" | **the normalisation is dropped, the index order is dropped, and the collapse quantifier is the defective one** |
| [dai-fu-2023-einstein-second-kind/README.md](../references/dai-fu-2023-einstein-second-kind/README.md) | "$P(W)=\tfrac32\operatorname{tr}_{\Lambda^2}W^3+\tfrac12\operatorname{tr}_{S^2_0}\mathring W^3$" | **NO, the sign of the second term is wrong** |
| [dai-fu-2023-einstein-second-kind/notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md) | "the record's bi-spectral identity $\theta=\tfrac32\operatorname{tr}_{\Lambda^2}M^3+\tfrac12\operatorname{tr}_{S^2_0}\mathring W^3$" | **NO, same wrong sign** |
| [lean/INDEX.md](../lean/INDEX.md) | **no row for L50** |, |

**The reference-note discrepancy, through the protocol.**

- **Locate it.** [references/dai-fu-2023-einstein-second-kind/README.md](../references/dai-fu-2023-einstein-second-kind/README.md), verdict line, and [notes.md](../references/dai-fu-2023-einstein-second-kind/notes.md), "What this gives on $\mathrm{Weyl}_n$". Both print $+\tfrac12$.
- **Exhibit the failure.** At anchor A, $p_3(\mu)=12s^3$ and $p_3(\omega)=-36s^3$, so the notes' form gives $18s^3-18s^3=0$ against $\theta=36s^3=\tfrac{\sqrt3}2$. It is not merely wrong; it evaluates to zero on the whole $n\le5$ range, where $p_3(\omega)=-3p_3(\mu)$ identically.
- **Argue the opposite.** No reading rescues it. The notes name the same operator, the same index order, and the same normalisation ("the constants there are in the record's normalisation $\lVert M\rVert_F=1$"), and cite the same script. The one charitable escape (that $\operatorname{tr}_{S^2_0}\mathring W^3$ there means the $ikjl$ operator), is closed by the same file's opening line, which fixes $\mathring R(e_i\odot e_j)=R_{iklj}e_k\odot e_l$.
- **Verdict: BROKEN, in the reference notes, not in L50.** L50 is right and its literature note is wrong, which is the more dangerous arrangement: a consumer checking the lemma against its own cited source finds a contradiction and has no way to tell which side moved.

**The missing Lean row.** [lean/INDEX.md](../lean/INDEX.md) has no row for L50, and the only mention of it is in [L62](../lean/INDEX.md)'s "Owed" list: "that $P=3\operatorname{tr}(W^3)$ on $\mathcal W_5$ ([L50](../results.md)'s collapse) … imported." **So a formalised result already depends on the half of L50 that has no proof on file.** A row for L50 would have to split the claim the way this report does: **provable now**, the identity given the dictionary, i.e. $P(W)=\tfrac32\operatorname{tr}(M^3)-\tfrac12\operatorname{tr}(\mathring W^3)$ from $\alpha=8\operatorname{tr}(M^3)$, $\beta=2\langle M^\#,M\rangle$ and $\operatorname{tr}(\mathring W^3)=\tfrac18\alpha-\beta$ as hypotheses, plus $\sum\omega^2=3$ from $\operatorname{tr}(\mathring W^2)=\tfrac34\lvert W\rvert^2$; **stated, not proved**, the two dictionary halves themselves, and the Lovelock display; **provable now on $\mathcal D_n$**, (D1), (D2), the collapse at $n=4,5$ on the families of §4, and its failure at $n=6$ by anchor B.

## 9. The gap between what is proven and what is used, and what L52 consumes

**[Lemma L52](../findings/bispectral.md) consumes exactly what this block establishes, and nothing more.** Its display

$$\theta\ \le\ \tfrac32\big[p_3(K)+3M_+(1-p_2(K))\big]-\tfrac12\big[p_3(K')+3m(p_2(K')-3)\big]$$

uses (i) the coefficient pair $(\tfrac32,-\tfrac12)$, (ii) $\sum\mu^2=1$ (the "$1$" inside the first bracket) and (iii) $\sum\omega^2=3$, the "$3$" inside the second. All three are L50's, at L50's normalisation, and L52 restates the normalisation ($\lVert M\rVert_F=1$) in its own conventions line, so it does not inherit the :244 ambiguity. It also needs the identity **pointwise at every $W\in\mathcal W_n$, $n\ge4$**, not merely on a dense set, and that is the quantifier L50 states. **So the answer is yes: what L52 uses is what this block establishes.** L52 inherits L50's debt on $\beta=2\langle M^\#,M\rangle$ and nothing else; it does not touch the collapse.

**What a consumer may cite from this block today.**

| may be cited as proved | may be cited only as verified-not-proved | may not be cited |
| --- | --- | --- |
| $\theta=\tfrac32p_3(\mu)-\tfrac12p_3(\omega)$ **given** the dictionary, at $\lVert M\rVert_F=1$ in Li's $iklj$ order | the dictionary half $\beta=2\langle M^\#,M\rangle$, hence, transitively, the identity itself | "for $n\le5$ and only there, $\beta=\tfrac12\alpha$" read pointwise |
| $\sum\mu=\sum\omega=0$, $\sum\mu^2=1$, $\sum\omega^2=3$ | $\beta=\tfrac12\alpha$ identically on $\mathcal W_4$ and $\mathcal W_5$, and $\theta=3\operatorname{tr}(W^3)$ there | the display's constant $-\tfrac1{64}$ as a derived quantity |
| $ikjl$ negates $\mathring W$ and the second coefficient | the Lovelock display as an identity | "$Q(W)=\tfrac13\nabla\theta$" |
| $\beta\ne\tfrac12\alpha$ at $n\ge6$, witnessed at the balanced product | | the Dai–Fu reference notes' $+\tfrac12$ form |
| $\mathrm{pr}(W^\#)=\tfrac12\mathrm{pr}(\iota_1^*(M^2))-\tfrac12\mathrm{pr}(\iota^*(\mathring W^2))$, and $W^\#\notin\mathcal W_n$ | | |
| $\mathcal W_5$ is $O(5)$-irreducible and collapses, so reducibility is not the separating fact | | |

## 10. The named trap, each citable claim read alone

The record's signature failure is a correction landing beside the statement it corrects. Reading each claim as a consumer would, with no neighbouring paragraph:

| claim read alone | what a consumer inherits |
| --- | --- |
| [results.md](../results.md):244, the landscape line | **the defective collapse quantifier**, no normalisation, no index order. Three separate qualifications live elsewhere: the quantifier in [ATTEMPTS.md](../ATTEMPTS.md), the norm in the block, the order in [conventions.md](../findings/conventions.md). |
| [results.md](../results.md):707, the canonical statement | clean on the identity, it carries $\lVert M\rVert_F=1$ and the index order. **It does not carry $n\ge4$, the pairing, or the homogeneous form**, and its "Proof: [bispectral.md](../findings/bispectral.md)" points at a proof with an unproved step. |
| the block's collapse paragraph | the same defective quantifier, plus a Lovelock display whose only support is a script named two paragraphs away in the source file and named nowhere in the block. |
| the block's corollary paragraph | correct, self-contained, and honestly withdrawn, **the best-behaved claim in the block**. |
| [dai-fu-2023-einstein-second-kind/README.md](../references/dai-fu-2023-einstein-second-kind/README.md) | **a sign-flipped identity, presented as what the source supplies.** A consumer who follows the lemma's own attribution reaches a contradictory statement of it. |
| "the syzygy is Lovelock's" | an attribution to a source [references/](../references/) does not hold. |

## 11. Verdict

### **HYPOTHESIS-DEBT**

The identity is right, I reproduced it exactly at two hand-built objects, in two dimensions, one of them the conjectured maximiser at $n=6$, and the coefficients $\tfrac32$ and $-\tfrac12$ are forced by the contraction they come from rather than fitted. Three of the block's four named claims survive intact: the index order is load-bearing exactly as stated, the corollary is correct and its projection is not cosmetic, and the correction of [fence post F2g](../findings/fence-posts.md) stands.

**What is owed, and it is exactly two things.**

1. **$\beta=2\langle M^\#,M\rangle$ off the coordinate-diagonal locus.** It is asserted with a script citation, holds on $\mathcal D_n$ by the argument in §3, and has no expansion anywhere on the record. Everything downstream, the identity, [L52](../findings/bispectral.md), the corollary, rests on it.
2. **The Lovelock display $\beta-\tfrac\alpha2=-\tfrac1{64}\delta^{a_1\cdots a_6}_{b_1\cdots b_6}W\,W\,W$.** Its proportionality is asserted and its constant is script-fitted at $n=6,7,8$. Without it the $n\le5$ half of the collapse has no proof, and a Lean file already imports that half as owed.

**And three defects that are repairs rather than debts:** the collapse sentence's missing quantifier, which [ATTEMPTS.md](../ATTEMPTS.md) already has right and the canon does not; the $+\tfrac12$ in the Dai–Fu reference README and notes, which contradicts the lemma they are cited for and evaluates to $0$ across the whole $n\le5$ range; and "$Q(W)=\tfrac13\nabla\theta$", which is true of $\nabla P$ only.

**What would falsify the statement, and what I did to look for it.** A $W\in\mathcal W_n$ at $n\ge6$, off the $O(n)$-orbit of $\mathcal D_n$, with $\beta\ne2\langle M^\#,M\rangle$, that single object would break the identity and everything built on it. I looked for it structurally rather than numerically, this programme being on an analysis-only footing: both sides are $O(n)$-invariant cubics vanishing on the Ricci part, so neither can carry a piece the other cannot, and I found no candidate mechanism and no witness. For the collapse, the falsifying object would be a genuinely $6$-dimensional $W$ with $\beta=\tfrac12\alpha$ **and** the claim read as an identity of forms; padded $W_{\mathbb{CP}^2}$ is such a point read pointwise, which is what makes §4.5 a statement defect rather than a refutation.
