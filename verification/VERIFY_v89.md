# v89, the $a=0$ collapse to $\theta_0(n)$, the $\mathbb{CP}^2$ threshold witness, and the off-slice expansion, checked against Beitz, Jäger, Xu and Böhm–Wilking

**Standfirst.** Cold brief: [ROUND_L00r2.md](ROUND_L00r2.md), "The brief as dispatched", verified verbatim against [problem.md](../findings/problem.md):9–111 (`diff` clean but for one trailing blank line). **No numerical work of any kind was run; every value below is an exact hand evaluation**, and every source sentence quoted is read out of the transcription in [references/](../references/) rather than from memory. Log: [agent_logs/verify-L00r2-v89.log](../agent_logs/verify-L00r2-v89.log). I read no other verifier's report.

## Claim table

| # | claim | verdict |
|---|---|---|
| C1 | The dispatched text is the block the round-1 audit rewrote, and carries L00's statement | **BROKEN**, the L00 block is [problem.md](../findings/problem.md):470–500; lines 9–111 are the argument [Lemma L43](../findings/problem.md):497–500 names as its own |
| C2 | Jäger's Theorem A is quoted verbatim, at $n\ge16$ even, with $n\ge12$ open even diagonally | **CONFIRMED**, verbatim at [diss_jaeger_florian.txt:113–120](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) |
| C3 | Odd $n$ is left conjectural by the source, at the constant the record calls $\Theta_n$ | **CONFIRMED, AND UNDERSTATED**, Jäger names that constant $\tilde\theta_0(n)$ himself and proves *"most of the results"* for it |
| C4 | The $a=0$ criterion collapses with no residue to $\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2$, and $c(n-1)=\theta_0(n)$ | **CONFIRMED**, rebuilt line by line in §3, including the $\lVert\mathrm{ric}(I)\rVert^2$ cancellation |
| C5 | The collapse's hypothesis set is complete as printed | **BROKEN**, $\mathrm{scal}(R)>0$ is dropped from all three places the block prints the cone, and the positive root is then taken silently at [problem.md](../findings/problem.md):73 |
| C6 | *"So this is the Conjecture A **bound**, sharp at even $n$"*, and *"the target constant is right"* | **BROKEN at odd $n\ge13$**, Conjecture A's constant is $\Theta_n$, and $\theta_0(13)^2-\Theta_{13}^2=48/13013>0$ |
| C7 | The Beitz conjecture is quoted correctly | **GAP**, the quotation drops Remark 6.3.15's own *"for $n\ge12$"* |
| C8 | $n\ge12$ is necessary: $\Omega_0$ is non-invariant for $4\le n\le11$ | **CONFIRMED** as a statement about $\Omega_0$; the polynomial arithmetic is exact |
| C9 | Five of ten triples vanish off the slice, and the survivors match Xu (2.34) term for term | **CONFIRMED**, every vanishing follows from Xu Proposition 2.7 alone, and the leading coefficient cross-checks exactly |
| C10 | The parity argument is two-sided and correct | **CONFIRMED**, rebuilt in §6 |
| C11 | The convention accounting (Beitz $\mathrm{ric}=\tfrac12$ BW's $\mathrm{Ric}$; $F(I)=2/(n-1)$ against Xu's $1/(2(n-1))$; BW's $P=\tfrac13\langle R,Q(R)\rangle$) | **CONFIRMED**, all four read out of the sources, all four arithmetically consistent |
| C12 | The citation chain through Poljsak's 2022 thesis | **UNREAD SOURCE**, Poljsak is not in [references/](../references/) |

**One-line summary.** The mathematics of the dispatched section is correct where I could check it and its quotations are accurate, but the section is not L00's block, it is missing the cone's positivity clause in every place it prints the cone, and it still identifies the criterion's $\theta_0(n)$ with Conjecture A's constant, the identification the record refuted and repaired one screen further down the same file.

**Verdict: `GAP`.**

## 0. Conventions, fixed once

- $\mathcal A_n=S^2_B(\mathfrak{so}(n))$, with $\langle R,S\rangle=\mathop{\mathrm{tr}}(R\circ S)$, Beitz Remark 1.1.7, read at [diss_beitz.txt:442–450](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf). So $\lVert I\rVert^2=\dim\Lambda^2\mathbb R^n=\tfrac{n(n-1)}2$.
- $Q(X)=X^2+X^\#$, and $\Phi(A,B)=\tfrac12(AB+BA)+A\#B$ is its polar form, so that $Q(A+B)=Q(A)+2\Phi(A,B)+Q(B)$. The dispatched block writes $\Phi(X)$ for $Q(X)$ and $\Phi(A,B)$ for the polar form in the same paragraph; I keep them apart below.
- $R=R_I+R_{\mathrm{ric}_0}+R_W$; on the slice $R_{\mathrm{ric}_0}=0$ I write $R=cI+W$, and off it $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$.
- $F(R)=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$, $G(R)=dF_R(\Phi(R))$, $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, and $\Theta_n$ is the record's constant, $\theta_0(n)$ at even $n$, $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$.
- Ricci conventions: Beitz's $\mathrm{ric}$ is half BW08's $\mathrm{Ric}$ (Definition 1.1.10, which says so in the source), and Xu's $\mathrm{Ric}$ is BW08's. Everything below is in Beitz's.

## 1. Hypothesis inventory

**Hypotheses the block carries in its own voice.**

| # | hypothesis | where | used? |
|---|---|---|---|
| H1 | $R_{\mathrm{ric}_0}=0$ (the slice) | [problem.md](../findings/problem.md):61 | yes, throughout §§3–4 |
| H2 | $\lVert W\rVert=1$ | [problem.md](../findings/problem.md):73 | yes, to fix $c$ |
| H3 | $R\in\partial\Omega_0$, i.e. $\tfrac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$ | [problem.md](../findings/problem.md):67 | yes |
| H4 | $n\ge4$, so that the padded $W_{\mathbb{CP}^2}$ exists | never stated | yes, at [problem.md](../findings/problem.md):79, where the range $4\le n\le11$ is asserted |
| H5 | $\mathrm{scal}(R)>0$ | **never stated anywhere in lines 9–111** | **yes, silently, at [problem.md](../findings/problem.md):73** |
| H6 | $\mathrm{ric}(R)\ne0$, so $F$ is defined | never stated | yes; the block's own aside *"the Weyl tensor itself does not"* at line 79 is this fact without its reason |

**Hypotheses of every imported result, checked against the object.**

| source result | its hypotheses | met here? |
|---|---|---|
| [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Remark 6.3.10, p. 96 (the cone in decomposition form) | $n\ge3$, $a\in[0,\tfrac n4]$, **and $\mathrm{scal}(R)>0$ in the definition of $\Omega_a$ two lines above it** | the first two yes; **the third is dropped by the block** |
| [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Remark 6.3.15 (the conjecture) | **$n\ge12$** | dropped from the block's quotation of it, see §7 |
| [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 6.3.16 | $a\in[\tfrac n4-\varepsilon,\tfrac n4]$ | yes, and the block correctly says this is the degenerate end |
| [BW08](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.1 | $R\in S^2_B(\mathfrak{so}(n))$ | yes, Weyl operators are Bianchi |
| [BW08](../references/boehm-wilking-2008-space-forms/notes.md) eq. (6) | stated in an orthonormal **eigenbasis of $\mathrm{Ric}$** | vacuously met, since $\mathrm{Ric}(W)=0$ makes every basis an eigenbasis. *The transcription flags eq. (6) as sign-flipped against this record's index order; the block's use of it is sign-insensitive, so nothing is inherited.* |
| [BW08](../references/boehm-wilking-2008-space-forms/notes.md) Lemma 2.2 | $R$ **of Ricci type** | met: it is applied to $Y=R_{\mathrm{ric}_0}$ |
| [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Proposition 2.7 | none beyond the decomposition | yes |
| [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Lemma 2.8 / (2.34) | $R\in S^2(\mathfrak{so}(n))$ | yes |
| [Jäger](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) Theorem A | **$n\ge16$ even**, $W\in\langle W\rangle_d$, $\lVert W\rVert=1$, $W^2+W^\#=\theta W$, **and $\theta\ge\theta_0(n)$**; Assumption 1 ($m\ge8$) stands over all of Chapter 3 | the block states the first two prominently; the $\theta\ge\theta_0(n)$ hypothesis is inside the quotation but is not carried into the gloss at line 34 |
| Hamilton, $Q$ preserves the Bianchi subspace |, | yes; the block names it at line 83 as an input it had not named, correctly |

**One input the block uses without naming, and it is in the source.** Line 34 concludes from Theorem A that *"this **is** the diagonal-case maximization result"*. That step needs the maximiser of $P$ **restricted to $\langle W\rangle_d$** to satisfy the *unrestricted* Lagrange condition $Q(W)=\theta W$, which needs $Q$ to preserve $\langle W\rangle_d$. Jäger supplies it on the same page, *"if $W\in\langle W\rangle_d$, the same is also true for $W^2+W^\#$"* ([diss_jaeger_florian.txt:127](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf)). No debt; an unnamed input.

**Which hypotheses the written argument actually uses.** H1, H2, H3, H5, H6 and, for the $n\ge12$ paragraph only, H4. Of these H5 and H6 are unstated, and H5 is load-bearing (§4).

## 2. Finding 1, the round is dispatched against a section that is not L00's block, and is not the round-1 repair

**Locate it.** [ROUND_L00r2.md](ROUND_L00r2.md):3, *"**Id:** L00. **Source:** [findings/problem.md](../findings/problem.md):9–111"*, and :5, *"Round 1 closed `GAP` … and **rewrote the block**. *The rewrite has never been read.*"*

**Exhibit the failure.** Three checks, each at a named line.

1. [ROUND_L00.md](ROUND_L00.md), Phase 5, says what was rewritten: *"the wrong pointer is replaced by the statement with its three scope conditions and the compactness proof"*. That text exists, and it is at [problem.md](../findings/problem.md):470–500, under the heading `#### Lemma L0, problem p and conjecture a are the same statement`. It carries the biconditional, the three bulleted scope conditions verbatim as Phase 5 describes them, and the compactness-and-criticality proof. **None of it is in lines 9–111.**
2. Lines 9–111 are pointed at, by name, as a *different* result's argument. [problem.md](../findings/problem.md):499 reads: *"The argument is in this file under **"The diagonal case: located in the literature, and it covers less than assumed"**, the title, which once broke off mid-phrase here."* That title is [problem.md](../findings/problem.md):13, the head of the dispatched span.
3. The dispatched text contains no statement of Problem P, no statement of Conjecture A, no biconditional, no critical set, no compactness argument and no scope conditions. **Both pre-registered questions are about objects that do not occur in the material.**

**Argue the opposite.** The most charitable reading the words support: lines 9–111 *do* bear on "are the two statements the same", because [problem.md](../findings/problem.md):107, *"Scope, stated plainly"*, is exactly a comparison of two statements. That is true, but the pair it compares is *the cone conjecture* against *Conjecture A*, not *Problem P* against *Conjecture A*, and the round's own gloss (*"The record grants the diagonal case and derives the rest"*) is about the latter. A second charitable reading: perhaps the L00 repair touched both places. It did not, [git log](../findings/problem.md) shows the block-constant repair as `b3cd2c38 fix(L0): the constant was the even-n evaluation of the right one`, and §5 below shows the section at 9–111 still carries the pre-repair reading.

**Consequence for this round.** I cannot return a verdict on *"Problem P and Conjecture A are the same statement"* from the material dispatched, because the material does not contain it. What I can and do report is a verdict on the section that *was* dispatched. The round's framing is itself the failure mode round 1 recorded as F1 (a block named as the argument for a statement it does not argue), reproduced one level up, in the round file.

## 3. The collapse, rebuilt in full, CONFIRMED

I rebuild [problem.md](../findings/problem.md):61–75 from the sources rather than checking it against itself.

**The criterion.** With $N=\lVert R\rVert^2$, $D=\lVert\mathrm{ric}(R)\rVert^2>0$,
$$dF_R(S)=\frac{2\langle R,S\rangle D-2N\langle\mathrm{ric}(R),\mathrm{ric}(S)\rangle}{D^2},$$
so $G(R)=dF_R(\Phi(R))\le0\iff\langle R,\Phi(R)\rangle\le F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$. This is [problem.md](../findings/problem.md):115 and it is [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) (3.1)–(3.2) verbatim, with (3.3) quantified over $R\in\partial\Omega(a)$.

**The three inputs.** $I^2=I$ and $I\#I=(n-2)I$ give $Q(I)=(n-1)I$; BW08 Lemma 2.1 puts $\langle W\rangle$ in the kernel of $R\mapsto R+R\#I$, so $W\#I=-W$ and $\Phi(I,W)=W-W=0$; BW08 eq. (6) with $\mathrm{Ric}(W)=0$ gives $\mathrm{Ric}(Q(W))=0$, and $Q$ preserves Bianchi, so $Q(W)\in\langle W\rangle$.

**The cubic.** $Q(cI+W)=c^2(n-1)I+2c\,\Phi(I,W)+Q(W)=c^2(n-1)I+Q(W)$, hence
$$\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+c\underbrace{\langle I,Q(W)\rangle}_{=\mathop{\mathrm{tr}}Q(W)=0}+c^2(n-1)\underbrace{\langle W,I\rangle}_{=\mathop{\mathrm{tr}}W=0}+\langle W,Q(W)\rangle .$$

**The right-hand side.** $\mathrm{ric}(R)=c\,\mathrm{ric}(I)$ and $\mathrm{ric}(\Phi(R))=c^2(n-1)\mathrm{ric}(I)$, while $F(R)=(c^2\lVert I\rVert^2+\lVert W\rVert^2)/(c^2\lVert\mathrm{ric}(I)\rVert^2)$. So
$$F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle=\frac{c^2\lVert I\rVert^2+\lVert W\rVert^2}{c^2\lVert\mathrm{ric}(I)\rVert^2}\cdot c^3(n-1)\lVert\mathrm{ric}(I)\rVert^2=c^3(n-1)\lVert I\rVert^2+c(n-1)\lVert W\rVert^2 .$$
$\lVert\mathrm{ric}(I)\rVert^2$ cancels identically, so **no Ricci convention can enter**, and the $c^3(n-1)\lVert I\rVert^2$ term is common to both sides. The criterion is
$$\langle W,Q(W)\rangle\le c(n-1)\lVert W\rVert^2 ,$$
with no residue. **The block's claim is exactly right, and this is an identity on the whole slice rather than a vanishing at the boundary.**

**The constant.** Beitz's own $a=0$ row, read at [diss_beitz.txt:5464](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf), is $\tfrac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$. On the boundary with $\lVert W\rVert=1$ and $\lVert R_I\rVert^2=c^2\lVert I\rVert^2=c^2\tfrac{n(n-1)}2$:
$$c^2\frac{n(n-1)}2=\frac{n-2}n\ \Longrightarrow\ c^2=\frac{2(n-2)}{n^2(n-1)},\qquad c=\frac1n\sqrt{\frac{2(n-2)}{n-1}},$$
$$c(n-1)=\frac{n-1}n\sqrt{\frac{2(n-2)}{n-1}}=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).\qquad\checkmark$$

**And the cone display is right.** I re-derived Beitz's decomposition form rather than trusting it. $F(R)\le\tfrac4{n-2+4a}$ is $(n-2+4a)\lVert R\rVert^2\le4\lVert\mathrm{ric}(R)\rVert^2$; with the block's stated normalisation $\lVert\mathrm{ric}(R)\rVert^2=\tfrac{n-1}2\lVert R_I\rVert^2+\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$ the coefficients come out $4a-n$, $4a$ and $n-2+4a$ on $\lVert R_I\rVert^2$, $\lVert R_{\mathrm{ric}_0}\rVert^2$, $\lVert R_W\rVert^2$, one quarter of which is the block's display at line 49, and it is Beitz's Remark 6.3.10 verbatim. The normalisation itself follows from Beitz (1.3)–(1.4): $\mathrm{scal}^2=\tfrac{n(n-1)}2\lVert R_I\rVert^2$, $\lVert\mathrm{ric}_0\rVert^2=\tfrac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$, $\lVert\mathrm{ric}\rVert^2=\lVert\mathrm{ric}_0\rVert^2+\tfrac1n\mathrm{scal}^2$. **No finding.**

**And the convention checks.** $\lVert\mathrm{ric}(I)\rVert^2=n(\tfrac{n-1}2)^2=\tfrac{n(n-1)^2}4$, so $F(I)=\tfrac{n(n-1)/2}{n(n-1)^2/4}=\tfrac2{n-1}$, which is Beitz's $\Omega_{n/4}$ threshold $\tfrac4{n-2+n}$ exactly; Xu's $\tfrac1{2(n-1)}$ is one quarter of it, matching $\mathrm{Ric}=2\,\mathrm{ric}$. BW08's potential is $P(R)=\tfrac13\mathop{\mathrm{tr}}(R^3+RR^\#)$ in the transcription, so the factor $3$ the block records is right. **All four convention claims at lines 87 and 109–111 are correct. No finding.**

## 4. Finding 2, the cone's positivity clause is dropped in all three places the block prints the cone, and the block then takes the positive root silently

**Locate it.** Three lines, each printing the cone without $\mathrm{scal}(R)>0$:

- [problem.md](../findings/problem.md):49, the displayed decomposition inequality;
- [problem.md](../findings/problem.md):57, the table row *"$\to0$ | $\frac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$, with $R_{\mathrm{ric}_0}$ **unconstrained**"*;
- [problem.md](../findings/problem.md):109, *"states $\Omega_a=F^{-1}\big((-\infty,\tfrac4{n-2+4a}]\big)$"*.

**Exhibit the failure concretely.** The source carries the clause in the definition itself: [diss_beitz.txt:5444](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) reads $\Omega_a:=\{R\in\mathcal A_n\mid(\tfrac{n-2}4+a)\lVert R\rVert^2\le\lVert\mathrm{ric}(R)\rVert^2$ **and $\mathrm{scal}(R)>0\}$**, and the $a=0$ row four lines later carries *"and $\mathop{\mathrm{tr}}(R)>0$"* in the source and not in the block's table. The consequence is at line 73: *"the $\partial\Omega_0$ constraint … gives $c=\frac1n\sqrt{\frac{2(n-2)}{n-1}}$"*. The boundary equation $c^2\tfrac{n(n-1)}2=\tfrac{n-2}n$ is **quadratic in $c$** and has the second root $c=-\tfrac1n\sqrt{\tfrac{2(n-2)}{n-1}}$, which without the clause is a point of the set. At that root §3's collapse reads
$$\langle W,Q(W)\rangle\le-\theta_0(n)\lVert W\rVert^2 ,$$
which the balanced sphere product violates at every $n$, since its $\theta$ is $+\theta_0(n)$. So the printed $\Omega_0$ is a double cone, and the criterion on its lower nappe is a statement the block's own §"Sharpness" paragraph contradicts.

And the block's own check cannot see it: line 77, *"Verified as squares, $\frac{2(n-2)(n-1)}{n^2}$ on both sides"*. **Squaring discards the sign the defect lives in.**

**Argue the opposite.** The most charitable reading: $\Omega_a$ is introduced at line 47 as *"the cone family"*, and a cone in this literature is understood to be the positive-scalar-curvature one, so a reader supplies $c>0$. That is exactly the reading the record itself rejected: [problem.md](../findings/problem.md):510, inside the [Lemma L43](../findings/problem.md):497 block, says *"The cone also carries $\mathop{\mathrm{scal}}(R)>0$, **which the printed $F$-sublevel set omits**"*, and the printed $F$-sublevel set it names is line 109, which is inside the dispatched span and still omits it. The canonical form fixed it: [results.md](../results.md):276 writes $\Omega_a=\{\mathop{\mathrm{scal}}(R)>0\}\cap F^{-1}(\cdots)$. **The correction was made, and it landed beside the text it corrects.** This is the round's named trap, instantiated, and a consumer reading lines 47–77 alone inherits the defect.

## 5. Finding 3, the criterion's $\theta_0(n)$ is still called Conjecture A's constant, at odd $n$ where it is not

**Locate it.** Two sentences.

- [problem.md](../findings/problem.md):81: *"So this is the Conjecture A **bound**, sharp at even $n$."*
- [problem.md](../findings/problem.md):107: *"Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice. What is settled is that the target constant is right, not that the two statements coincide."*

**Exhibit the failure concretely, at $n=13$.** Conjecture A concludes at the value of the best sphere product, $\Theta_n$, this is the record's own repaired reading ([problem.md](../findings/problem.md):473–478, [results.md](../results.md):775), and it is also the source's: Jäger's own remark at [diss_jaeger_florian.txt:1687–1695](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) introduces $\tilde\theta_0(n)=\sqrt{2\tfrac{(n-1)(n-3)}{(n+1)(n-2)}}$ for $S^m\times S^{m+1}$ and records $\tilde\theta_0(n)\le\theta_0(n)$ for all $n\ge3$. Exactly, with $(n-2)^2(n+1)-n^2(n-3)=(n^3-3n^2+4)-(n^3-3n^2)=4$ identically,
$$\theta_0(n)^2-\Theta_n^2=2(n-1)\frac{(n-2)^2(n+1)-n^2(n-3)}{n^2(n-2)(n+1)}=\frac{8(n-1)}{n^2(n-2)(n+1)}>0 .$$
At $n=13$: $\theta_0^2=\tfrac{2\cdot12\cdot11}{169}=\tfrac{264}{169}$ and $\Theta_{13}^2=\tfrac{2\cdot12\cdot10}{14\cdot11}=\tfrac{120}{77}$, differing by $\tfrac{264\cdot77-120\cdot169}{13013}=\tfrac{20328-20280}{13013}=\tfrac{48}{13013}$. So at $n=13$ the $a=0$ criterion demands only $P(W)\le\theta_0(13)$ while Conjecture A concludes $P(W)\le\Theta_{13}<\theta_0(13)$. **The criterion is strictly weaker than Conjecture A at every odd $n\ge13$: implied by it, and not implying it.** Hence "this is the Conjecture A bound" is false at odd $n$, and "Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice" is false at odd $n$, the slice is a strictly weaker statement there, on top of the $R_{\mathrm{ric}_0}$ gap the sentence does name.

**Argue the opposite.** The most charitable reading the words support is real and I state it in full: line 81 is headed *"Sharpness at even $n$ only"*, it gives the odd-$n$ value $\tfrac{2(n-1)(n-3)}{(n-2)(n+1)}$ explicitly and says it is $<\theta_0(n)^2$, so an attentive reader of that paragraph has every number needed to draw the distinction. On that reading "the Conjecture A bound" means "a bound that is Conjecture A's at even $n$ and a valid weaker one at odd $n$".

**It does not survive, for two reasons.** First, the summary a consumer reads for scope is line 107, and it makes the identification without the parity caveat, *"the target constant is right"*, unqualified, three lines after the paragraph that shows it is not, at odd $n$. Second, the record states the opposite distinction in its own voice elsewhere and in almost these words: [problem.md](../findings/problem.md):200 (*"$\Theta_n$ is what the diagonal locus attains, never what the criterion demands"*) and [results.md](../results.md):775, *"**The constant is $\Theta_n$ and not $\theta_0(n)$** … so the $\theta_0$ form asserted Conjecture A's own negation there"*, recorded as refuted by two reviewers on identical briefs. **So the same identification was refuted, repaired at [problem.md](../findings/problem.md):470 and [results.md](../results.md):775, and left standing at [problem.md](../findings/problem.md):81 and :107.** Second instance of the named trap.

## 6. What is confirmed, in full

**The threshold witness, [problem.md](../findings/problem.md):79, CONFIRMED.** $\theta_0(n)^2<\tfrac32\iff4(n-1)(n-2)<3n^2\iff4n^2-12n+8<3n^2\iff n^2-12n+8<0$. The roots are $6\pm2\sqrt7$, and $2\sqrt7=5.2915\ldots$, so the inequality holds for $0.7085<n<11.2915$, i.e. at every integer $n$ with $4\le n\le11$ (and $n^2-12n+8=8-3\cdot4=-3$ already at $n=1$). Exact, no computation. The witness needs $n\ge4$ and $c>0$, both available. **The conclusion drawn is about $\Omega_0$**, and the block states it that way (*"$\Omega_0$ is **provably non-invariant** for $4\le n\le11$"*) which is correct and is a genuine strengthening over the sources, since neither Beitz nor Xu records necessity.

**The off-slice expansion, [problem.md](../findings/problem.md):89–93, CONFIRMED.** With $A=cI$, $B=Y$, $C=W$ the cubic has ten distinct triples, $T(A,A,A)+T(B,B,B)+T(C,C,C)+3[T(A,A,B)+T(A,A,C)+T(A,B,B)+T(A,C,C)+T(B,B,C)+T(B,C,C)]+6T(A,B,C)$. Five vanish, each by one item of [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Proposition 2.7 and orthogonality of the three blocks: $(A,A,B)$ and $(A,A,C)$ because $Q(I)=(n-1)I\perp Y,W$; $(A,B,C)$ because $Q(I,Y)\in\langle\mathrm{Ric}_0\rangle\perp W$ (item 2), equivalently from Lemma 2.1, $Y\#I=\tfrac{n-4}2Y$ so $\Phi(I,Y)=\tfrac{n-2}2Y$; $(A,C,C)$ and $(B,C,C)$ because $Q(W)\in\langle W\rangle$ (item 4). The five survivors are the block's display.

**The cross-check against Xu (2.34), which the block asserts and does not perform, I performed it on the leading term.** Xu writes $R_I=\tfrac{\bar\lambda}{n-1}I$, so $c=\tfrac{\bar\lambda}{n-1}$ and
$$c^3(n-1)\lVert I\rVert^2=\frac{\bar\lambda^3}{(n-1)^3}(n-1)\frac{n(n-1)}2=\frac{n\,\bar\lambda^3}{2(n-1)},$$
which is Xu's first term exactly. (2.34) is verbatim at [xu-2412.13633.txt:519–524](https://arxiv.org/abs/2412.13633), the block's ordering $(I,I,I),(I,Y,Y),(Y,Y,W),(Y,Y,Y),(W,W,W)$ matches the printed order term for term, and the $\tfrac3{n-2}$ coefficient is [BW08](https://arxiv.org/abs/math/0606187):246 (*"$(R^2+R^\#)_W=\tfrac1{n-2}(\mathrm{Ric}_0\wedge\mathrm{Ric}_0)_W$"*) so the block's remark that BW08 Lemma 2.2 supplies the $(\mathrm{Ric}_0,\mathrm{Ric}_0)$ block Xu's five-item list omits is **correct**: Xu's items cover $(I,I),(I,Y),(I,W),(W,W),(Y,W)$ and not $(Y,Y)$.

**The parity argument, [problem.md](../findings/problem.md):95–97, CONFIRMED.** Under $W\mapsto-W$ at fixed $c,Y$: the $\Omega_0$ constraint sees only $\lVert R_W\rVert$, so $\partial\Omega_0$ is preserved; $\mathrm{ric}(R)$ and $F(R)$ are $W$-even; and $\Phi(R)$'s $W$-dependence is $Q(W)+2\Phi(Y,W)$, of which $\mathrm{ric}(Q(W))=0$ and $\mathrm{ric}(\Phi(Y,W))$ is $W$-linear and lands in $\langle\mathrm{Ric}_0\rangle$ by Xu item 5. Adding the criterion at $+W$ and at $-W$ gives $\lvert\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\rvert\le\mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even}$, as printed.

**A consistency point the block states loosely and which is nonetheless sound.** Line 105 says setting $Y=0$ *"recovers the bridge exactly"*. It recovers the **two-sided** form $\lvert\langle W,Q(W)\rangle\rvert\le\theta_0(n)$, where line 71 prints the one-sided one. Since $\mathcal W_n$ is closed under $W\mapsto-W$, the one-sided statement quantified over all $W$ is equivalent to the two-sided one, so nothing is lost. **No finding.**

**Quantifiers and edges, no finding, and here is each.** The order at line 71 is: for every $R=cI+W\in\partial\Omega_0$, one inequality; each unit $W$ meets $\partial\Omega_0$ at one $c>0$, so each $W$ is tested against $\theta_0(n)$ and no other constant, and interior points give a weaker test. The smallest admissible dimension is $n\ge4$ (below it $\mathcal W_n=0$ and the collapse is vacuous); the block never states it and nothing turns on it. Odd $n$ is §5. Reducibility and non-compactness do not arise: the block is entirely algebraic, on $S^2_B(\mathfrak{so}(n))$, and appeals to no manifold. $\ker W\ne0$ is not excluded anywhere and must not be, the padded $W_{\mathbb{CP}^2}$ that carries line 79 has kernel of dimension $\binom n2-3$.

## 7. Finding 4, Beitz's own $n\ge12$ is dropped from the quotation of the conjecture, which is where pre-registered question 2 bites

**Locate it.** [problem.md](../findings/problem.md):45: *"It states the conjecture once, as Remark 6.3.15, in the cone-invariance formulation (**"the cones $\Omega_a$ are invariant under the ODE for $a\in[0,\tfrac n4]$"**)"*.

**Exhibit the failure.** The source, [diss_beitz.txt:5626–5627](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf), reads: *"An unpublished conjecture of Christoph Böhm and Burkhard Wilking is that **for $n\ge12$** the cones $\Omega_a$ are invariant under the ordinary differential equation (2.4) for $a\in[0,\tfrac n4]$."* [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md)'s Conjecture 1 carries the same hypothesis. The quoted fragment is inside quotation marks and is short by the hypothesis that the whole section is about.

**Argue the opposite.** Charitably, the omission is harmless because the section's own §1 quotes Jäger's *"all even integers $n\ge12$"* sentence, so the number is not hidden from the reader. But it is not harmless where it matters: it is the direct cause of the framing at line 79, *"The conjecture's dimension hypothesis is therefore forced by an explicit witness rather than assumed"*. A reader who has been given the conjecture without its dimension hypothesis cannot tell that "assumed" refers to the source's own standing assumption. **The claim is still true (necessity is genuinely absent from Beitz and Xu) but the citable sentence supporting it was printed with the hypothesis removed.**

**And this answers pre-registered question 2 directly: the threshold does not come from the same place, and there are four of them.**

| where | $n\ge12$ enters as | source |
|---|---|---|
| [Beitz](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf) Remark 6.3.15, [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Conjecture 1 | **hypothesis** of the cone conjecture | published |
| [problem.md](../findings/problem.md):79 | **conclusion**, necessity for $\Omega_0$-invariance, from $n^2-12n+8<0$ | this record |
| [problem.md](../findings/problem.md):480, [Lemma L0](../findings/problem.md):470 | **hypothesis**, *"Fix $n\ge12$"* | this record |
| [Jäger](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf) Theorem A / Assumption 1 | **hypothesis, and a different number**, $n\ge16$, $m\ge8$ | published |

The block's real content is that rows 1 and 2 turn on one polynomial, which [Crossover.lean](../lean/HamiltonsCubic/Results/Crossover.lean) confirms is shared with the symmetric-space theorem's case split. **What the block does not say, and what a consumer of line 79 would take, is that row 3 (L00's threshold), is a hypothesis that this necessity argument does not supply.** Nothing in lines 9–111 connects them, and the L00 block at line 470 cites no necessity result.

## 8. Item 3 of the brief, the three forms compared

| | findings form ([problem.md](../findings/problem.md):9–111) | canonical form ([results.md](../results.md)) | Lean form ([lean/INDEX.md](../lean/INDEX.md)) |
|---|---|---|---|
| the collapse | lines 61–75, derived in full | [L43](../results.md):274–276, one paragraph | [L43.lean](../lean/HamiltonsCubic/Results/L43.lean), **partial**, the row states outright *"Owed: the collapse itself, which needs Böhm–Wilking's $F$ and Beitz's cone, the base layer has no types for either"* |
| $\mathrm{scal}(R)>0$ | **absent at lines 49, 57 and 109** | **present**: *"$\Omega_a=\{\mathop{\mathrm{scal}}(R)>0\}\cap F^{-1}(\cdots)$"* | present, as the double-cone correction made quantitative |
| the slice's name | *"the slice $R_{\mathrm{ric}_0}=0$"*, unnamed | *"the **Einstein** slice"*, with the Ricci-flat reading refuted inline | present |
| the constant vs Conjecture A's | *"the Conjecture A bound"*, *"the target constant is right"* | *"$\Theta_n$ is what the diagonal locus attains, never what the criterion demands"* ([problem.md](../findings/problem.md):200) and *"The constant is $\Theta_n$ and not $\theta_0(n)$"* ([results.md](../results.md):775) | [L0.lean](../lean/HamiltonsCubic/Results/L0.lean), **proved**, the gap $8(n-1)/(n^2(n+1)(n-2))$ and $48/13013$ at $n=13$ |
| $n\ge12$ necessity | line 79, framed as forcing *"the conjecture's dimension hypothesis"* | [L44](../results.md):282, framed tightly, *"It says nothing about whether the cone is invariant at $n\ge12$, which is the conjecture itself"* | [L44.lean](../lean/HamiltonsCubic/Results/L44.lean), **partial**; owed: the padding map |
| off the slice | lines 89–105 | [L45](../results.md):290, with *"it … proves no case of the conjecture by itself"* | no row |
| L00 itself | **not in this span**, [problem.md](../findings/problem.md):470–500 | [results.md](../results.md):775 | [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) **proved** for the arithmetic; [SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean) closes compactness; *"the Lagrange condition stays imported"* |

**What each form carries that the others do not.** The findings form carries the only derivation; it is also the only one of the three missing the positivity clause and the only one identifying $\theta_0$ with Conjecture A's constant. The canonical form carries both corrections and the honest limitation sentences, and carries no derivation. The Lean layer carries neither the collapse nor the criterion (it has no type for $F$ or for the cone) so **it cannot hide a hypothesis here because it does not state the theorem**; what it does supply is the constant arithmetic of §5 as kernel-checked fact, and it supplies it against L0 rather than against this section.

## 9. Unread sources, stated as the brief requires

- **[Poljsak 2022](../references/) is not in [references/](../references/).** Line 28's provenance, *"Found by a citation chain through Kevin Poljsak's 2022 thesis, which cites it for the diagonal $\#$-formula"*, rests on an unread source. The formula itself is checkable and I checked it: with $w_{ii}=0$ and $\sum_kw_{ik}=0$, $(W\#I)_{ij}=\tfrac12\sum_k(w_{ik}+w_{jk})=\tfrac12(-w_{ij}-w_{ij})=-w_{ij}$, which is BW08 Lemma 2.1's $W\#I=-W$; and $(I^\#)_{ij}=\sum_{k\ne i,j}1=n-2$, which is $I\#I=(n-2)I$. **The formula is right; only the attribution is unread.**
- **Everything else is read.** Jäger, Beitz, Xu, BW08, Huisken, Fox, Nienhaus, Cao–Gursky–Tran and Li are all in [references/](../references/) with full text. I confirmed the block's own caution at line 119: `grep -ci "conjecture a"` over [li-2407.13847.txt](https://arxiv.org/abs/2407.13847) returns $0$, so the fabricated citation the block warns about is indeed absent from that paper. I confirmed Fox's two claims against [its transcription](../references/fox-2019-nonassociative-curvature-algebra/notes.md): simplicity of the Weyl algebra, and idempotents as critical points of $P$ on the unit sphere.

## 10. Answers to the two pre-registered questions

**Question 1, are the two statements the same, or does one grant what the other assumes?** On the material dispatched, the pair actually compared is *the $a=0$ cone criterion* against *Conjecture A*, not Problem P against Conjecture A. Two gaps separate them, and only one is stated where a reader would look.

- **The gap that is stated**, at line 107: $a=0$ leaves $R_{\mathrm{ric}_0}$ unconstrained, so the criterion is strictly more than Conjecture A off the slice, and the block quantifies the excess as one new triple $(Y,Y,W)$ and a two-sided odd-part bound.
- **The gap that is not stated**: on the slice, at odd $n\ge13$, the criterion demands $\theta_0(n)$ where Conjecture A concludes $\Theta_n<\theta_0(n)$. §5.
- **What the granted half covers in print**: Jäger's Theorem A, at **even $n\ge16$**, on **diagonal** operators only, under **Assumption 1 ($m\ge8$)**, and with **$\theta\ge\theta_0(n)$ as a hypothesis**. The block states the first three of those prominently at lines 36–39, which is to its credit and is the strongest part of the section.
- **What the conjecture needs**: $n\ge12$, both parities, all of $\langle W\rangle$, at the constant $\Theta_n$.

**Question 2, does the $n\ge12$ threshold come from the same place in both?** No, see §7's table. It is a hypothesis in Beitz, Xu and L00; a conclusion at line 79; and a different number, $n\ge16$, in the only published proof. Lines 1 and 2 of that table do turn on one polynomial and the block establishes that correctly. Line 3 is connected to neither, in this section or in L00's.

## 11. What would falsify this block, and what I did to look for it

**The object that would break it.** A curvature operator $R=cI+W$ with $\lVert W\rVert=1$, $c>0$, sitting on $\partial\Omega_0$, at which the invariance criterion reads something other than $\langle W,Q(W)\rangle\le\theta_0(n)$, that is, any residue surviving the collapse. Equivalently: a term in $\langle R,\Phi(R)\rangle-F(R)\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\rangle$ that does not cancel on the slice.

**What I did.** I rebuilt the collapse from the polar-form definition rather than checking the block's arithmetic, and every term is accounted for: two cross terms vanish by tracelessness ($\langle W,I\rangle$ and $\mathop{\mathrm{tr}}Q(W)$), one by $\Phi(I,W)=0$, the $\lVert\mathrm{ric}(I)\rVert^2$ factor cancels between $F$ and the pairing, and $c^3(n-1)\lVert I\rVert^2$ is common. **No residue exists**, and I re-derived Beitz's decomposition coefficients independently to confirm the constraint the boundary imposes. I then cross-checked the off-slice expansion's leading coefficient against Xu (2.34) and got exact agreement, which would have caught a normalisation error in $\lVert I\rVert^2$ or in $c$.

**The source that would break it.** A published statement of the cone conjecture with a constant other than the criterion's, or a version of Beitz Remark 6.3.15 without $n\ge12$. I read Remark 6.3.15, Remark 6.3.10, Lemma 6.3.16, Remark 1.1.7, Remark 1.1.16 and Definition 1.1.10 in the Beitz transcription; Theorem A, its following sentence, the $S^m\times S^{m+1}$ remark and Assumption 1 in Jäger's; Lemma 2.1, Lemma 2.2, eq. (5) and eq. (6) in Böhm–Wilking's; and Proposition 2.7, Lemma 2.8/(2.34) and (3.1)–(3.4) in Xu's. All four agree with the block's quotations, with the single exception recorded in §7.

**What I did not do.** No script, no numeric evaluation, no search. Every constant above is a hand evaluation of an exact rational or surd.

## Verdict

**`GAP`.**

The derivation the section exists to carry is correct and I rebuilt it in full; its quotations are accurate against the PDFs on file; and the necessity argument, the ten-triple expansion and the parity bound all check. But three things stand:

1. **The section is not L00's block**, and the round's two pre-registered questions concern objects that do not occur in it. The L00 repair is at [problem.md](../findings/problem.md):470–500 and remains unread by any round.
2. **$\mathrm{scal}(R)>0$ is missing from every printing of the cone in this section**, including the one the record's own [Lemma L43](../findings/problem.md):510 block names as omitting it, and the argument then takes the positive root of a quadratic without saying why.
3. **The section still calls $\theta_0(n)$ Conjecture A's constant**, at lines 81 and 107, after that identification was refuted and repaired both in the L00 block and in [results.md](../results.md).

Findings 2 and 3 are the same failure mode, and it is the one the round named: the correction landed **beside** the text it corrects, so a consumer citing lines 47–111 alone inherits both defects. What a reader may take from this block, as written: **that cone invariance at $a=0$ forces the constant $\theta_0(n)$ on the Einstein slice, that this is Conjecture A's constant at even $n$ only, and that $\Omega_0$ is non-invariant for $4\le n\le11$**, nothing about Problem P and Conjecture A being one statement, which is not argued here.
