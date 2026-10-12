# VERIFY_v189, Lemma L44, $n\ge12$ is necessary, not merely sufficient

Cold read of [BRIEF_L44.md](BRIEF_L44.md), against [results.md](../results.md) lines 280–284 and 102 and the block at [problem.md](../findings/problem.md) lines 207–219. **No numerical work was done**, every constant below is exact algebra by hand, and the only arithmetic performed is the eight-value integer screen in §9, on integers I constructed for that purpose. Log: [agent_logs/verify-L44-v189.log](../agent_logs/verify-L44-v189.log).

## Claim table

| # | claim | verdict |
| --- | --- | --- |
| 1 | Padded $W_{\mathbb{CP}^2}$ lies in $\mathcal W_n$, is critical, and has $\theta=\sqrt{3/2}$ at every $n\ge4$ | **PROVEN**, rebuilt from the $\mathfrak{so}(4)$ structure constants; $Q(W)=\sqrt{3/2}\,W$ exactly |
| 2 | $cI+W$ at $c=\tfrac1n\sqrt{2(n-2)/(n-1)}$ lies on $\partial\Omega_0$ | **PROVEN**, $c$ is forced, $F(cI+W)=\tfrac4{n-2}$ recomputed independently |
| 3 | The Weyl tensor itself does not lie on $\partial\Omega_0$ | **PROVEN**, and stronger than stated: $W\notin\overline{\Omega_0}$, not merely off the boundary |
| 4 | [L43](../results.md)'s collapse of $dF_R(\Phi(R))\le0$ to $\langle W,Q(W)\rangle\le c(n-1)$ | **PROVEN**, rebuilt cold; exact, no residue, $\lVert\mathrm{ric}(I)\rVert^2$ cancels |
| 5 | $c(n-1)=\theta_0(n)$ | **PROVEN** |
| 6 | That collapse is "the block's only step" | **BROKEN**, false as written; the block itself names another used input one paragraph later, and claim 1 is a separate input |
| 7 | The criterion demands $\theta_0(n)$ at **both** parities; $\Theta_n$ is what the diagonal locus attains | **PROVEN**, the repair is correct and load-bearing |
| 8 | "$c(n-1)$ … is a rational function of $n$" | **BROKEN** as a descriptor, $\theta_0(11)=6\sqrt5/11\notin\mathbb Q$; $\theta_0^2$ is rational, $\theta_0$ is not. Nothing downstream uses it |
| 9 | Elementary route: $n^2-13n+18<0$ at odd $n$, root $\tfrac{13+\sqrt{97}}2$ | **PROVEN** |
| 10 | Elementary route: $n^2-12n+8<0$ at even $n$, root $6+2\sqrt7$ | **PROVEN** |
| 11 | No integer between the two roots, same integer threshold $12$ | **PROVEN**, both roots lie in $(11,12)$, which is the load-bearing fact |
| 12 | The elementary route needs no cone theory | **PROVEN**, it needs neither criticality nor $\Omega_0$, only $\lVert W\rVert=1$ and $P(W)=\sqrt{3/2}$ |
| 13 | *Invariance $\Rightarrow G\le0$* "holds in two lines" | **HYPOTHESIS-DEBT**, the two lines are on the record in three `reviews/` files and in Xu's stored full text, and in **neither canonical block** |
| 14 | [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 2.3.4's direction | **PROVEN as reported**, the notes give sufficiency only, exactly as the block says |
| 15 | Xu (3.1)–(3.4) verify against the stored full text; the notes carry none of them | **PROVEN**, both halves confirmed at source |
| 16 | [L43](../findings/problem.md#L70)'s reason for the same direction, *"it holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$"* | **BROKEN**, inherited defect, refuted by [r92](../reviews/REVIEW_r92.md) and still standing |
| 17 | The stated hypothesis "is a critical point" | **Stated and never used**, L44 uses only the value of the cubic |

**Verdict: PROVEN, hypotheses corrected.** The mathematics of L44 is right at every step and at both parities; the witness, the pinned $c$, the collapse, the two polynomials and their roots all rebuild cold. What fails is the block's account of itself in four places, the "only step" claim, the "rational function" descriptor, the missing normalisation $\lVert W\rVert=1$, and the unwritten necessity direction, plus one refuted justification inherited from L43's section that has not been repaired.

## 0. Conventions, fixed once

Quoted from [conventions.md](../findings/conventions.md), not restated.

- $Q(W)$: *"Hamilton's quadratic map $W^2+W^\#$, sending $\mathcal W_n$ to itself"*.
- $P(W)$: *"the cubic form $\langle W,Q(W)\rangle$"*. $\theta$: *"$P(W)/\lVert W\rVert^3$; at a critical point, $Q(W)=\theta W$"*.
- $\theta_0(n)$: *"the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$, and nothing more."*
- $\Theta_n$: *"the diagonal maximum; equals $\theta_0(n)$ at even $n$, and $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$"*.
- $\Omega_0$: *"[Beitz](../references/beitz-2018-bianchi-convexity/notes.md)'s invariant cone, whose boundary is $\tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$. **A Weyl tensor never lies on it** ($\mathrm{ric}=0$ is where the defining function blows up and $\Omega_0$ is undefined) so the boundary point a $W$ furnishes is $cI+W$ at the pinned $c=\tfrac1n\sqrt{2(n-2)/(n-1)}$, and placing $W$ itself there is the error [L44](../findings/problem.md)'s audit found in three sites."*
- $R_I,R_{\mathrm{ric}_0},R_W$: *"the three $O(n)$-irreducible pieces of an algebraic curvature operator, scalar, trace-free Ricci, and Weyl."*
- $\#$: *"the halved Böhm–Wilking product, $vv^{\mathsf T}\#ww^{\mathsf T}=\tfrac12[v,w][v,w]^{\mathsf T}$"*.

**Symbol collisions live in this block, and all four resolve.** $c$, [conventions.md](../findings/conventions.md) records two: *"$c$ collides with [L44](../findings/problem.md)'s pinned $\partial\Omega_0$ constant twenty lines up"*, against [L47](../findings/problem.md)'s working symbol. In this block $c$ is unambiguously the pinned constant. $F$, three unrelated objects on the record ($\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ here; [L17](../findings/route-a.md)'s $d^+\delta^2=-2aF$; [L61](../results.md)'s sextic $F_5$); the block defines its $F$ inline, so no hazard. $\Pi$, *"the letter carries four unrelated objects"*; **$\Pi$ does not appear in this block at all**, so the collision is not live here. $R_I$, used in exactly the tabled sense, the scalar part; and $\Omega_0$ in exactly Beitz's sense.

## 1. Hypothesis inventory

A pass with no inventory is not a pass. Every input L44 consumes, where it is stated, and whether it is proved.

| # | input | used? | stated in the block? | supported where |
| --- | --- | --- | --- | --- |
| H1 | Padded $W_{\mathbb{CP}^2}\in\mathcal W_n$, $\lVert W\rVert=1$ | **essential** | implicitly, in the word "zero-padded" | [problem.md:264](../findings/problem.md#L264), *"Being Ricci-flat in dimension 4 it is Ricci-flat in dimension $n$, so the padding lands inside $\mathrm{Weyl}_n$ untouched"* |
| H2 | $P(W)=\sqrt{3/2}$ at every $n\ge4$ | **essential** | yes | [problem.md:168](../findings/problem.md#L168) (L2's proof) and [L38](../results.md) at $m=2$ |
| H3 | $W$ is a **critical point**, $Q(W)=\theta W$ | **never used** | yes, in the canonical statement | true (§2), but decoration for this lemma |
| H4 | $\partial\Omega_0:\ \tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$ on $\mathrm{scal}>0$ | **essential** | yes | [conventions.md:50](../findings/conventions.md), Beitz p. 96, Xu (1.2) |
| H5 | $\lVert I\rVert^2=\binom n2$ | **essential** | yes | stated in the block; Beitz Remark 1.1.7 |
| H6 | $\mathrm{scal}(cI+W)>0$, selecting the positive root of $c$ | **essential** | **no** | [problem.md:62](../findings/problem.md), *"the positive root, and $\operatorname{tr}(R)>0$ is what selects it"* |
| H7 | $\lVert W\rVert=1$ normalisation, for "$\langle W,Q(W)\rangle\le c(n-1)$" to typecheck | **essential** | **no**, dropped | [results.md:276](../results.md#L276), L43's own statement, carries $\lVert W\rVert^2$ and $\lVert W\rVert^3$ correctly |
| H8 | [L43](../results.md)'s collapse | **essential** | yes, cited | [problem.md:528](../findings/problem.md#L528) and §56–70 of the same file |
| H9 | $Q(\mathcal W_n)\subseteq\mathcal W_n$ (i.e. $\Phi$ preserves Weyl and first Bianchi) | **essential**, inside H8 | named in the L43 section, not in the L44 block | BW08 eq. (6); Xu Prop 2.7(4), which **is** in [the Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) |
| H10 | $\Phi(I,W)=0$ | **essential**, inside H8 | as above | BW08 Lemma 2.1; Xu Prop 2.7(3), also in the notes |
| H11 | **Invariance $\Rightarrow G\le0$ at a boundary point** | **essential** | named as owed, with a prose sketch and no lines | §7, the lines exist in `reviews/` and in Xu Prop 2.2's stored text, in **no** canonical block |
| H12 | Full symmetry of $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ | **not used** by the collapse | L43 says so explicitly | BW08 eq. (5); needed only to read criticality as $Q(W)=\theta W$, i.e. for H3 |
| H13 | $\Theta_n$ is the sphere-product / diagonal maximum | used **only** by the elementary route | yes | [L57](../results.md), [L2](../results.md) |

**H3 is a hypothesis stated but never used**, and **H6 and H7 are steps that use hypotheses never stated** in this block. Neither breaks anything: H6 and H7 are both discharged one file-section away, in L43.

## 2. The witness, rebuilt from the $\mathfrak{so}(4)$ structure constants

The record's own presentation is [problem.md:264](../findings/problem.md#L264): $W_{\mathbb{CP}^2}=\operatorname{diag}(0,0,0,-1,-1,2)/\sqrt6$ on $\Lambda^2(\mathbb R^4)$. I rebuilt it rather than reading it off.

**The bracket, and the one normalisation that fixes everything.** Take $e_{12},\dots,e_{34}$ orthonormal in $\Lambda^2\mathbb R^4$ and the self-dual triple
$$f_1=\tfrac1{\sqrt2}(e_{12}+e_{34}),\quad f_2=\tfrac1{\sqrt2}(e_{13}-e_{24}),\quad f_3=\tfrac1{\sqrt2}(e_{14}+e_{23}),$$
orthonormal, spanning $\Lambda^+\cong\mathfrak{su}(2)_+$. Identify $e_i\wedge e_j\mapsto s\,(E_{ij}-E_{ji})=:sA_{ij}$. From $[A_{12},A_{13}]=-A_{23}$, $[A_{12},A_{24}]=A_{14}$, $[A_{34},A_{13}]=-A_{14}$, $[A_{34},A_{24}]=A_{23}$ one gets
$$[f_1,f_2]=\kappa f_3,\qquad \kappa=\sqrt2\,s\ \text{(up to the orientation of $f_2$)},$$
and cyclically, $[f_a,f_b]=\kappa\,\varepsilon_{abc}f_c$.

**$s$ is not a free choice.** $\mathrm{ad}$ is skew for the $\Lambda^2$ inner product, so summing the $\#$ formula over any orthonormal basis gives $vv^{\mathsf T}\#I=-\tfrac12\mathrm{ad}_v^2$. For $W=\sum_a w_af_af_a^{\mathsf T}$ with $\sum_aw_a=0$ this yields $W\#I=-\tfrac{\kappa^2}2W$, and BW08 Lemma 2.1's $W\#I=-W$ forces $\boxed{\kappa^2=2}$, i.e. $s=1$. Every constant below is downstream of that.

**$Q$ on the triple.** $f_af_a^{\mathsf T}\#f_bf_b^{\mathsf T}=\tfrac{\kappa^2}2f_cf_c^{\mathsf T}=f_cf_c^{\mathsf T}$ for $a\ne b$, so summing the two orderings,
$$Q(W)\big|_{f_c}=w_c^2+2w_aw_b,\qquad \{a,b,c\}=\{1,2,3\}.$$

**The $\mathbb{CP}^2$ point.** $\mathbb{CP}^2$ is self-dual Einstein with $W^-=0$ and $W^+\propto(2,-1,-1)$; normalising, $w=(2,-1,-1)/\sqrt6$, and $\lVert W\rVert^2=(4+1+1)/6=1$. Then
$$Q(W)\big|_{f_1}=\tfrac{4+2}{6}=1,\qquad Q(W)\big|_{f_2}=Q(W)\big|_{f_3}=\tfrac{1-4}{6}=-\tfrac12,$$
and $Q(W)=(1,-\tfrac12,-\tfrac12)$ against $W=(2,-1,-1)/\sqrt6$. These are proportional with
$$\theta=\frac{1}{2/\sqrt6}=\frac{\sqrt6}2=\sqrt{\tfrac32}.$$
Cross-check on the cubic: $\langle W,Q(W)\rangle=\tfrac2{\sqrt6}\cdot1+2\cdot(-\tfrac1{\sqrt6})(-\tfrac12)=\tfrac3{\sqrt6}=\sqrt{3/2}$. **Both agree, so $Q(W)=\sqrt{3/2}\,W$ and $\theta=\sqrt{3/2}$ at $n=4$.** $\mathrm{tr}\,Q(W)=1-\tfrac12-\tfrac12=0$, so $Q(W)$ is again Weyl.

## 3. $\ker W\ne0$, what every step does at the padding

The witness is padded by construction, so this is the trap that matters. Split $\Lambda^2\mathbb R^n=\mathfrak{so}(4)\oplus V\oplus U$ with $V=\mathrm{span}\{e_i\wedge e_j: i\le4<j\}\cong\mathbb R^4\otimes\mathbb R^{n-4}$ and $U=\Lambda^2\mathbb R^{n-4}$. $W$ vanishes on $V\oplus U$.

| step | what happens on $\ker W$ |
| --- | --- |
| $W\in\mathcal W_n$ | $\mathrm{ric}(W)_{ij}=\sum_kW_{ikjk}$ has every index inside $\mathbb R^4$ or vanishes, so $\mathrm{ric}_n(W)=\mathrm{ric}_4(W)=0$; $\mathrm{Alt}(W)$ likewise. **Padding lands inside $\mathcal W_n$ untouched** |
| $\lVert W\rVert$, $P(W)$ | both are sums over $\mathfrak{so}(4)$ components alone, **unchanged, hence $n$-independent** |
| $W^2$ | supported on $\mathfrak{so}(4)$; zero on $V\oplus U$ |
| $W\#W$ | $f_af_a^{\mathsf T}\#f_bf_b^{\mathsf T}$ is rank one with range $\mathrm{span}[f_a,f_b]\subseteq\mathfrak{su}(2)_+$, because $\mathfrak{su}(2)_+$ is a **subalgebra**. **This is where padding could have broken criticality and does not**, the brackets never leave $\mathfrak{so}(4)$, so $Q_n(W)=Q_4(W)$ and $\theta$ is the same at every $n\ge4$ |
| $W\#I_n$ (H10, the step that sees the *whole* of $\Lambda^2\mathbb R^n$) | $W\#I_n=-\tfrac12\sum_aw_a\mathrm{ad}_{f_a}^2$. On $U$: $\mathrm{ad}_{f_a}=0$, giving $0=-W|_U$ ✓. On $V$: $\mathrm{ad}_{f_a}^2$ acts as $\rho(f_a)^2\otimes1$ with $\rho$ the standard $\mathfrak{so}(4)$ representation, and each $\rho(f_a)^2=-\tfrac12I_4$, so the total is $-\tfrac12(\sum_aw_a)(-\tfrac12I_4)\otimes1=0=-W|_V$ ✓. **The tracelessness of $W^+$ is exactly what saves this block** |
| $\Omega_0$ boundary | $c$ carries the whole $n$-dependence, through $\lVert I_n\rVert^2=\binom n2$ against a fixed $\lVert W\rVert=1$. **That asymmetry is the mechanism of the threshold** |

So $Q_n(W)=\sqrt{3/2}\,W$ at every $n\ge4$ and $W\#I_n=-W$ at every $n\ge4$. **Claim 1 holds, and the record's own version of the same argument is at [problem.md:149](../findings/problem.md#L149) and [:168](../findings/problem.md#L168)**, the block does not cite either.

## 4. The boundary placement, both halves

**Half one, $cI+W$ lies on $\partial\Omega_0$.** With $R=cI+W$ on the Einstein slice, $R_I=cI$ and $R_W=W$. The boundary equation $\tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$ with $\lVert I\rVert^2=\tfrac{n(n-1)}2$ and $\lVert W\rVert=1$ gives
$$c^2\cdot\tfrac{n(n-1)}2=\tfrac{n-2}n\quad\Longrightarrow\quad c^2=\frac{2(n-2)}{n^2(n-1)},\qquad c=\frac1n\sqrt{\frac{2(n-2)}{n-1}},$$
**the pinned constant exactly.** The positive root is selected by $\mathrm{scal}(R)>0$: $\mathrm{tr}(cI+W)=c\binom n2+0>0$ iff $c>0$ (H6). An independent cross-check that this really is $\partial\Omega_0$ and not merely the quadric: with $\lVert\mathrm{ric}(R)\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2$ on the slice,
$$F(R)=\frac{c^2\lVert I\rVert^2+1}{\tfrac{n-1}2c^2\lVert I\rVert^2}=\frac{1+\tfrac{n-2}n}{\tfrac{n-1}2\cdot\tfrac{n-2}n}=\frac{\tfrac{2n-2}n}{\tfrac{(n-1)(n-2)}{2n}}=\frac4{n-2},$$
which is Beitz's threshold $\tfrac4{n-2+4a}$ at $a=0$ on the nose. **PROVEN.**

**Half two, the Weyl tensor itself does not.** The block's reason is that $\mathrm{ric}(W)=0$ is where $F$ blows up. That reason is right, and the conclusion is in fact stronger than "not on the boundary": $W\notin\overline{\Omega_0}$. Suppose $R_k\in\Omega_0$ with $R_k\to W$. Every $R_k$ satisfies $\lVert\mathrm{ric}(R_k)\rVert^2\ge\tfrac{n-2}4\lVert R_k\rVert^2$; $\mathrm{ric}$ is continuous and $\lVert R_k\rVert\to\lVert W\rVert=1$, so the limit gives $0=\lVert\mathrm{ric}(W)\rVert^2\ge\tfrac{n-2}4>0$, a contradiction. Concretely on the ray: $F(tI+W)=(t^2\lVert I\rVert^2+1)/(t^2\kappa)\to\infty$ as $t\to0^+$, so the ray leaves $\Omega_0$ before reaching $W$. **PROVEN, and the repair that moved the witness off this boundary was correct.** [conventions.md](../findings/conventions.md) records the pre-repair error at three sites; the placement now on file is the right one.

## 5. L43's collapse, rebuilt cold

Not read from the block, rederived, then compared.

$\Phi(I,I)$: BW08 Lemma 2.1 at $R=I$ gives $I+I\#I=(n-1)I$, so $I\#I=(n-2)I$ and $Q(I)=(n-1)I$. Hence with H10,
$$Q(cI+W)=c^2(n-1)I+2c\,\Phi(I,W)+Q(W)=c^2(n-1)I+Q(W).$$
Pairing, and using $\langle W,I\rangle=\mathrm{tr}\,W=0$ and $\langle I,Q(W)\rangle=\mathrm{tr}\,Q(W)=0$ (H9),
$$\langle R,Q(R)\rangle=c^3(n-1)\lVert I\rVert^2+\langle W,Q(W)\rangle.$$
On the right of the criterion, $\mathrm{ric}(R)=c\,\mathrm{ric}(I)$ and $\mathrm{ric}(Q(R))=c^2(n-1)\mathrm{ric}(I)$, so with $\kappa:=\lVert\mathrm{ric}(I)\rVert^2$,
$$F(R)\big\langle\mathrm{ric}(R),\mathrm{ric}(Q(R))\big\rangle=\frac{c^2\lVert I\rVert^2+\lVert W\rVert^2}{c^2\kappa}\cdot c^3(n-1)\kappa=c(n-1)\big(c^2\lVert I\rVert^2+\lVert W\rVert^2\big).$$
Subtracting, the $c^3(n-1)\lVert I\rVert^2$ term is common and $\kappa$ has cancelled identically:
$$G(R)\le0\iff\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2.$$
**Exact, no residue.** Note this used $F(R)$ at its actual value, not the boundary constant, so, as L43 claims, *"the collapse is an identity on the whole slice, not merely a vanishing at the boundary"*. Imposing the boundary then substitutes $c=\lVert W\rVert\cdot\tfrac1n\sqrt{2(n-2)/(n-1)}$:
$$c(n-1)\lVert W\rVert^2=\frac{n-1}{n}\sqrt{\frac{2(n-2)}{n-1}}\,\lVert W\rVert^3=\frac{\sqrt{2(n-1)(n-2)}}{n}\lVert W\rVert^3=\theta_0(n)\lVert W\rVert^3.$$
**Claims 4 and 5 PROVEN.** Failure at the witness is strict: $\sqrt{3/2}>\theta_0(n)$ for $n\le11$ gives $G(R)>0$, so $F$ strictly increases and the solution leaves $\Omega_0$ immediately, non-invariance, not a boundary-tangency ambiguity.

**Is the collapse the block's only step? No, claim 6 is BROKEN.** Discrepancy protocol. *(i) Located:* [problem.md:213](../findings/problem.md#L213), *"whose collapse … is the block's only step"*. *(ii) Exhibited concretely:* the very next paragraph, [problem.md:215](../findings/problem.md#L215), opens *"Two things the argument uses and did not say"* and names **invariance $\Rightarrow G\le0$**, which is not part of L43's collapse and which L43 does not supply. Independently, H1 and H2 (that padded $W_{\mathbb{CP}^2}$ is in $\mathcal W_n$ with $P(W)=\sqrt{3/2}$), are inputs L43 says nothing about; they are proved at [problem.md:168](../findings/problem.md#L168) and [:264](../findings/problem.md#L264), elsewhere in the same file. *(iii) The opposite argued:* could "only step" mean "only cited lemma"? That reading is available, and under it the sentence is true. But the sentence as printed makes a completeness claim about the argument, and the block refutes it itself two lines later. **Confirmed, as a defect of the block's self-description, not of its mathematics.**

**A claim proven on a subfamily, used in general, checked, and clean.** L43's collapse is proved only on the Einstein slice $R_{\mathrm{ric}_0}=0$. L44's witness $cI+W$ has $R_{\mathrm{ric}_0}=0$, so it sits inside the subfamily. This is legitimate precisely because L44 runs the *negative* direction: refuting invariance needs one boundary point, and that point may be chosen on the slice. **No violation.**

## 6. The parity claim, the block's own repair, tested

The block asserts: *"The criterion demands $\theta_0(n)$ at both parities, the constant is $c(n-1)$, forced by $\lVert I\rVert^2=\binom n2$ and the boundary equation … $\Theta_n$ is what the diagonal locus attains, never what the criterion demands."*

**Both halves hold.** The derivation in §4–§5 produced $c$ from $\lVert I\rVert^2=\tfrac{n(n-1)}2$ and $\tfrac{n-2}n\lVert W\rVert^2=c^2\lVert I\rVert^2$, and $c(n-1)=\sqrt{2(n-1)(n-2)}/n$. **Nothing in that chain distinguishes odd from even $n$**, no split $p+q=n$ appears, no floor or ceiling, no sphere product. $\Theta_n$ enters the record only through [L57](../results.md)/[L2](../results.md) as the maximum over the diagonal locus, and it never appears in the criterion. **PROVEN, and the repair is load-bearing**: [conventions.md](../findings/conventions.md) records that *"the gloss 'the value at the balanced sphere product' stood here until 2026-09-04 and is what regrew [L0](../findings/problem.md)'s refuted constant"*, so conflating the two is a live failure mode in this record and the block now blocks it.

A consequence worth stating, since it cuts the other way and the block does not say it: at **odd** $n$, $\theta_0(n)>\Theta_n$, so the cone criterion on the slice is *strictly weaker* than Conjecture A's assertion. That costs L44 nothing (L44 uses only the failure direction) but it means the cone route is not a route to Conjecture A at odd $n$.

**Claim 8, "a rational function of $n$", is BROKEN as written.** *(i) Located:* [problem.md:213](../findings/problem.md#L213). *(ii) Exhibited:* $c(n-1)=\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$; at $n=11$ this is $\sqrt{180}/11=6\sqrt5/11$, irrational, whereas a rational function of $n$ takes rational values at every integer in its domain. *(iii) The opposite argued:* $\theta_0(n)^2=2(n-1)(n-2)/n^2$ **is** rational in $n$, and $c^2$ likewise, so the intended content survives; and the load-bearing clause, *"with no parity in it"*, is true of both. **Confirmed as a wording defect with no downstream consumer**, the fix is "an algebraic function of $n$", or "$\theta_0^2$ is rational in $n$".

## 7. The direction supplied in prose, are the two lines on the record?

**Beitz, read at source.** [notes.md:17](../references/beitz-2018-bianchi-convexity/notes.md) reads: *"Invariance is proved through Lemma 2.3.4: a sublevel set of a function $F$ is invariant **when** $dF_R(\Phi(R))\le0$ on the relevant region."* That is sufficiency, $G\le0\Rightarrow$ invariance. **The block's characterisation of the source is exactly right**, claim 14 PROVEN. (One earlier review, [REVIEW_r89](../reviews/REVIEW_r89.md):38, asserts Lemma 2.3.4 *"gives both directions"*; the notes do not say so, and I did not find a transcription that does.)

**Where the two lines actually are.** I searched the whole record for them.

| location | status |
| --- | --- |
| [results.md](../results.md) L44, L43 | **absent** |
| [problem.md](../findings/problem.md) L44 block (:215) | the *sentence* only, *"the direction holds in two lines, by evaluating the flow's normal component at the boundary point"*, **and not the two lines** |
| [problem.md:70](../findings/problem.md#L70), L43's section | present but **with a refuted reason**; see below |
| [REVIEW_r90.md:31](../reviews/REVIEW_r90.md) | the lines, correctly: *"if $R_0\in\partial\Omega_a$ had $G(R_0)>0$ then $\tfrac{d}{dt}F(R(t))|_0>0$"* |
| [REVIEW_r523.md:94](../reviews/REVIEW_r523.md) | the same argument, independently |
| [REVIEW_r92.md:185](../reviews/REVIEW_r92.md) | the same, plus the refutation of L43's stated reason |
| Xu, stored full text, Proposition 2.2 (line 435) | the **iff**: *"A closed convex $O(n)$-invariant subset $C$ … is invariant under the Hamilton ODE (2.28) **if and only if** for all $R\in\partial C$ we have $Q(R)\in T_RC$"* |

**So: the two lines are on the record (in three `reviews/` files and, as a citable published theorem, in Xu's stored text) and in neither canonical block.** A reader following [results.md](../results.md) to [problem.md](../findings/problem.md) reaches an assertion that a proof exists and never reaches the proof. **HYPOTHESIS-DEBT, recoverable in one sentence**: cite Xu Prop 2.2, or write r90's two lines into the block. I do not supply them here as a repair; I record where they are and where they are not.

One hypothesis of Xu Prop 2.2 that no file on the record checks: it requires $C$ **closed and convex**. Xu asserts this of $\Omega(a)$ only for $a$ near $n/4$ (his Theorem 1.2 list). Whether $\Omega_0$ is convex is not stated anywhere in this record. **This does not endanger L44**, the elementary argument (r90's two lines) needs no convexity, only smoothness of $F$ at $R$, which holds since $\mathrm{ric}(cI+W)=c\,\mathrm{ric}(I)\ne0$, but any block that discharges H11 *by citing Prop 2.2* would owe the convexity check.

**Claim 16, an inherited defect still standing.** *(i) Located:* [problem.md:70](../findings/problem.md#L70), inside L43's argument section, which L44 depends on: *"the bridge needs invariance $\Rightarrow G\le0$, where Beitz Lemma 2.3.4 supplies only the converse; **it holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$**."* *(ii) Exhibited concretely:* the scalar-curvature identity governs the $\{\mathrm{scal}>0\}$ face of $\Omega_0$. At the witness $R=cI+W$ with $c>0$, $\mathrm{scal}(R)=2c\binom n2>0$ **strictly**, so $R$ is interior to that face and the only active constraint is $F=\tfrac4{n-2}$. Take any $R_0\in\partial\Omega_0$ with $G(R_0)>0$: then $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$ still holds along the flow, and yet $F(R(t))>\tfrac4{n-2}$, so $R(t)\notin\Omega_0$. **The cited fact is consistent with non-invariance, so it cannot imply the direction.** *(iii) The opposite argued:* the identity does real work elsewhere, it keeps the solution in $\mathrm{scal}^+$ and keeps $\lVert\mathrm{ric}\rVert\ne0$ so $F$ stays smooth. But those are side conditions, not the implication; the sentence says "it holds via", and it does not. **Confirmed.** [REVIEW_r92](../reviews/REVIEW_r92.md):185 reached the same conclusion and the sentence has not been repaired. Note also that the L44 block and the L43 section give **two different** justifications for the same owed direction ("the flow's normal component" against "$\tfrac d{dt}\mathrm{scal}$"), only the first of which is on the right face.

## 8. The elementary route

The block claims this route needs no cone theory. **Checked: it needs only H1, H2 and H13**, that $W$ is a unit Weyl operator in $\mathcal W_n$ with $P(W)=\sqrt{3/2}$, and that the diagonal maximum is $\Theta_n$. Not criticality, not $\Omega_0$, not $c$, not L43. **Claim 12 PROVEN.**

**Odd $n$.** $\Theta_n^2=\dfrac{2(n-1)(n-3)}{(n+1)(n-2)}$, so $\Theta_n^2<\tfrac32$ reads $4(n-1)(n-3)<3(n+1)(n-2)$, i.e.
$$4n^2-16n+12<3n^2-3n-6\iff n^2-13n+18<0,$$
matching the block's displayed comparison term for term. Roots $\tfrac{13\pm\sqrt{169-72}}2=\tfrac{13\pm\sqrt{97}}2$; $\sqrt{97}=9.8488\ldots$, so the upper root is $11.4244\ldots$ **The block's $\approx11.42$ is right.** Sign check at the ends of the odd range: $n=5$ gives $-22$, $n=11$ gives $121-143+18=-4<0$, $n=13$ gives $169-169+18=+18>0$. **Claim 9 PROVEN.**

**Even $n$.** $\Theta_n=\theta_0(n)$, so $\Theta_n^2<\tfrac32$ reads $4(n-1)(n-2)<3n^2$, i.e. $n^2-12n+8<0$, roots $6\pm2\sqrt7$; $2\sqrt7=5.2915\ldots$, upper root $11.2915\ldots$ **The block's $\approx11.29$ is right.** $n=10$ gives $-12$, $n=12$ gives $+8$. **Claim 10 PROVEN**, and this is the same polynomial that governs the cone route, since $\theta_0(n)^2\ge\tfrac32\iff n^2-12n+8\ge0$ at both parities.

**Claim 11.** $11<11.2915<11.4244<12$, so both roots lie in the open interval $(11,12)$ and the integer threshold is $12$ from each polynomial. The block's phrasing, *"no integer lies between the two roots"*, is true but weaker than what the conclusion needs: what makes the threshold agree is that **both** roots lie between the same consecutive integers. [L2](../results.md)'s canonical statement carries both roots, as the block says. **PROVEN.**

**Boundary dimensions, named.** $n=4$ (smallest admissible, $\dim\mathcal W_4=10$, the unpadded witness): $\theta_0(4)^2=\tfrac{2\cdot3\cdot2}{16}=\tfrac34<\tfrac32$, fails. $n=11$ (odd, the last failing dimension): $\theta_0(11)^2=\tfrac{180}{121}=1.4876\ldots<\tfrac32$, fails; $\Theta_{11}^2=\tfrac{160}{108}=\tfrac{40}{27}=1.4815\ldots<\tfrac32$, fails. $n=12$ (the first holding dimension): $\theta_0(12)^2=\tfrac{220}{144}=\tfrac{55}{36}=1.5277\ldots>\tfrac32$, **holds**, so the witness says nothing at $n=12$, exactly as the lemma's last sentence claims. **$n=11$ against $n=12$ is clean at both routes.**

## 9. Sources, and the one the notes cannot check

**Xu (3.1)–(3.4).** Read at source in [xu-2412.13633.txt](https://arxiv.org/abs/2412.13633), lines 817–834. All four are present verbatim: (3.1) the differential $dF_R(S)=\tfrac2{|\mathrm{Ric}(R)|^2}(\langle R,S\rangle-F(R)\langle\mathrm{Ric}(R),\mathrm{Ric}(S)\rangle)$, (3.2) the same at $S=Q(R)$, (3.3) $dF_R(Q(R))\le0\ \forall R\in\partial\Omega(a)$, (3.4) the expanded form, and the sentence *"Hence, the main task is…"* that [REVIEW_r558](../reviews/REVIEW_r558.md) reports. **The block's provenance claim is true.**

**What a consumer can check from [the Xu notes](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) alone.** The notes carry: Conjecture 1 and the cone in both forms; the endpoint facts ($\Omega(a)=\emptyset$ for $a>n/4$, $\Omega(n/4)=\mathbb R^+I$); Theorem 1.1's $\epsilon_n=1/n$ and the proved-fraction table; and **Proposition 2.7's five block rules**, quoted in full. The notes carry **none** of (3.1)–(3.4), **not** Lemma 2.8's eq. (2.34), and **not** Proposition 2.2. So:

- **H9 and H10 are checkable from the notes**, they are Prop 2.7(4) and 2.7(3), quoted there, and the notes say so.
- **H11's citable source is not**, Prop 2.2 is the one theorem that would discharge the owed direction, and a reader of the notes never learns it exists.
- **The block's own Attribution paragraph flags the (3.1)–(3.4) gap** and tells the reader to open the source. That is honest, and it is also an admission that the reference folder's summary is behind the argument that leans on it.

**A note on the brief.** [BRIEF_L44.md](BRIEF_L44.md) gives the block as [problem.md](../findings/problem.md) lines 207–217. The block runs to **line 219**, and line 219 is the Attribution paragraph carrying precisely the Xu claim this round was asked to test. Anyone auditing from the brief alone would not have seen it.

**Search-tool prose.** None was used. Every source claim above was read in a stored file: the Beitz notes, the Xu notes, and Xu's stored full text.

## 10. The remaining traps, answered by name, including where I found nothing

| trap | finding |
| --- | --- |
| $\ker W\ne0$ | §3. Every step survives; $W\#I_n=-W$ on the padded blocks only because $\mathrm{tr}\,W^+=0$ |
| Boundary of every stated range | §8. $n=4$, $n=11$, $n=12$ all checked, both routes, both polynomials |
| Smallest admissible dimension | $n=4$; the witness is unpadded there and the criterion fails, so the range's lower end is genuine |
| Odd $n$ | §6 and §8. The cone criterion has no parity; the elementary route has two polynomials; both give $12$ |
| $n=11$ against $n=12$ | §8, four exact fractions |
| A claim proven on a subfamily, used in general | **Nothing found.** L43 is proved on the Einstein slice and the witness lies on that slice; the negative direction needs one point |
| A hypothesis stated but never used | **Found.** H3, criticality. L44 uses only $P(W)=\sqrt{3/2}$ and $\lVert W\rVert=1$. The hypothesis is true and harmless |
| A step using a hypothesis never stated | **Found, twice.** H6 ($\mathrm{scal}>0$ selecting the positive root) and H7 ($\lVert W\rVert=1$, without which "$\langle W,Q(W)\rangle\le c(n-1)$" is not homogeneous). Both discharged in L43's own statement |
| A universal claim with no witness | **Not applicable**, L44 *is* a witness claim, and §2 rebuilds the witness in closed form |
| An imported theorem whose hypotheses were never checked | **Found, one.** Xu Prop 2.2 needs $C$ closed **convex** $O(n)$-invariant; no file checks convexity of $\Omega_0$. Latent rather than live, since the record does not currently cite Prop 2.2 at all and the elementary argument needs no convexity. *The unital-algebra failure mode has no analogue here: no algebra theorem is imported* |
| Symbol collisions ($\Omega_0$, $c$, $F$, $R_I$, $\Pi$) | §0. All four live symbols read in the tabled sense; $\Pi$ does not occur in this block |
| Numerical work | **None.** The only arithmetic is the eight-value integer screen $n^2-12n+8$ at $n=4,\dots,11$ (all negative: $-24,-27,-28,-27,-24,-19,-12,-3$), on integers constructed for that purpose, reported as a screen |

## 11. What would falsify it, and what I did to look

**The object that would break L44 is a dimension $n\in\{4,\dots,11\}$ at which the criterion does *not* fail**, equivalently, any of:

1. **A $\theta$ for padded $W_{\mathbb{CP}^2}$ other than $\sqrt{3/2}$ at some $n$.** This would come from $Q_n(W)$ acquiring a component outside $\mathfrak{so}(4)$. *Looked for it* by computing $W\#W$ and $W\#I_n$ blockwise on $\mathfrak{so}(4)\oplus V\oplus U$ (§3). The $V$-block is the dangerous one and it vanishes, by $\sum_aw_a=0$ together with $\rho(f_a)^2=-\tfrac12I_4$. Not found.
2. **A different pinned $c$**, from a different $\lVert I\rVert^2$ or a different boundary equation. *Looked for it* by deriving $c$ from the boundary equation and then independently recomputing $F(cI+W)=\tfrac4{n-2}$, Beitz's own $a=0$ threshold, from the unrelated identity $\lVert\mathrm{ric}(R)\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2$ (§4). Two routes, same constant. Not found.
3. **A residue in the collapse**, a surviving cross term that would make the criterion something other than $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$. *Looked for it* by rebuilding the expansion from $Q(I)=(n-1)I$, $\Phi(I,W)=0$ and $\mathrm{tr}\,Q(W)=0$ (§5). $\kappa=\lVert\mathrm{ric}(I)\rVert^2$ cancels identically and the $c^3$ term is common. Not found.
4. **An integer $n$ with $4\le n\le11$ and $\theta_0(n)\ge\sqrt{3/2}$.** *Screened all eight* (§10): every value of $n^2-12n+8$ is strictly negative, with the smallest margin $-3$ at $n=11$. Not found.
5. **An integer strictly between $6+2\sqrt7$ and $\tfrac{13+\sqrt{97}}2$**, which would split the two parities' thresholds. *Bounded both roots* to $11.2915\ldots$ and $11.4244\ldots$ (§8). Not found.
6. **A failure of invariance $\Rightarrow G\le0$** at the witness, which would sever the criterion from non-invariance. *Looked for it* in [Beitz's notes](../references/beitz-2018-bianchi-convexity/notes.md) (which give only the converse) and in [Xu's stored full text](https://arxiv.org/abs/2412.13633), where Proposition 2.2 states the iff. **This is the one place where the record itself, rather than the mathematics, is short**, §7.

## Verdict

**PROVEN, hypotheses corrected.**

L44's mathematics stands at every step. The witness rebuilds from the $\mathfrak{so}(4)$ structure constants with $Q(W)=\sqrt{3/2}\,W$ exactly; padding preserves it because $\mathfrak{su}(2)_+$ is a subalgebra and $\mathrm{tr}\,W^+=0$; the pinned $c$ is forced and puts $cI+W$ on $\partial\Omega_0$ with $F=\tfrac4{n-2}$; the Weyl tensor itself is not merely off that boundary but outside the closure; L43's collapse is exact with no residue; $c(n-1)=\theta_0(n)$ carries no parity, so the criterion demands the same constant at odd and even $n$ while $\Theta_n$ is only what the diagonal locus attains; and the two elementary polynomials have upper roots $11.2915\ldots$ and $11.4244\ldots$, both in $(11,12)$.

The corrections are to the block's account of itself, and they are four:

1. **"the block's only step" is false**, the block names a second used input one paragraph later, and takes $P(W)=\sqrt{3/2}$ from elsewhere in the same file without citing it.
2. **"a rational function of $n$"** describes $\theta_0(n)^2$, not $\theta_0(n)$.
3. **The normalisation $\lVert W\rVert=1$ is dropped**, which is what makes "$\langle W,Q(W)\rangle\le c(n-1)$" typecheck; L43's own statement carries it correctly.
4. **The owed direction, invariance $\Rightarrow G\le0$, has no lines in either canonical block**, HYPOTHESIS-DEBT, discharged in [REVIEW_r90](../reviews/REVIEW_r90.md), [REVIEW_r523](../reviews/REVIEW_r523.md) and [REVIEW_r92](../reviews/REVIEW_r92.md), and available as Xu Proposition 2.2 in the stored full text but absent from the Xu notes.

And one **inherited defect, unrepaired**: [problem.md:70](../findings/problem.md#L70) still justifies that direction by $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$, which governs the wrong face of the cone and cannot supply it. [REVIEW_r92](../reviews/REVIEW_r92.md):185 found this and it is still on file.

None of the five touches the range $4\le n\le11$, the threshold $n\ge12$, or the witness.
