# ROUND L43-arg, misdispatched as L00-r2, and audited L43's argument instead

> **THIS ROUND WAS BRIEFED AGAINST THE WRONG SECTION, AND THE FIRST READER SAID SO.** *[Lemma L0](../findings/problem.md)'s block is at [problem.md](../findings/problem.md):470–500; lines 9–111 are the diagonal-case section, which [problem.md](../findings/problem.md):499 names as **[Lemma L43](../findings/problem.md)'s** argument.* **The dispatched text contains no Problem P, no Conjecture A, no biconditional and no critical set, so both pre-registered questions are about objects that do not occur in it.**
>
> **This is round 1's own finding reproduced one level up.** *That round closed `GAP` because the block named the wrong section as its argument, five readers of five agreeing, and the round convened to audit the repair named the wrong section as the block.* **The round is void as an L00 audit and is kept as what it is: a first reading of L43's argument, which no round had covered.** *L00 returns to the queue, correctly targeted.*

# ROUND L00-r2, the repair, and the first round to compare three forms

**Id:** L00. **Source:** [findings/problem.md](../findings/problem.md):9–111. **Date:** 2026-09-06. **Verifiers allocated:** v89, v90, v91. **Phase:** 1, dispatched.

**Why this id.** Round 1 closed `GAP`, *the block named the wrong section as its argument, five readers of five agreeing, and three scope conditions were missing*, and **rewrote the block**. *The rewrite has never been read.* **Tier 0 is what the whole record is about: whether Problem P and Conjecture A are the same statement**, and every other row assumes they are.

**A repair is a new result.** *Which passages are the rewrite is deliberately not marked.*

**This is the first round to compare three forms.** [lean/INDEX.md](../lean/INDEX.md) carries rows bearing on this block (*the symmetric-space theorem assembled, and the tube closure's inputs*), **and no round has read a Lean statement against the prose it formalises.** The verifiers are asked to.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Are the two statements the same, or does one grant what the other assumes?** *The record grants the diagonal case and derives the rest.* **Say exactly what the granted half covers in print, what the conjecture needs, and whether the gap between them is stated where a reader would look.**
2. **Does the $n\ge12$ threshold come from the same place in both?** *A threshold that enters one statement as a hypothesis and the other as a conclusion is two thresholds.*

**One trap named from outside the block.** *Fifteen rounds on another block found its signature failure to be a correction landing **beside** the statement it corrects, so a citation inherits the defect, and the repair under review here was written by the loop that found the defect.* **Read each citable claim alone, as a consumer would.**

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

## Identity of the conjecture

No single paper states this exact result end-to-end, but it is not folklore either, it traces to a specific unpublished source. It is **Böhm–Wilking's "Conjecture A"** (also referred to as "Conjecture L1" in the surrounding literature), attributed to a PhD thesis by Beitz (Münster, Böhm–Wilking's group), and it sits inside the broader Böhm–Wilking curvature-operator program from [Manifolds with positive curvature operators are space forms](https://arxiv.org/abs/math/0606187) (Annals of Math. 167, 2008). It is referenced in passing in a 2023 paper, [Towards Finding the Second Best Einstein Metric in Low Dimensions](https://arxiv.org/pdf/2311.02404), and partial progress toward it appears in [Yiyan Xu, *On Some New Ricci Flow Invariant Curvature Conditions*](https://arxiv.org/abs/2412.13633) (2024/2025).

### The diagonal case: located in the literature, and it covers less than assumed

**The assumed "known" diagonal case is Florian Jäger's 2016 Münster PhD thesis**, *An algebraic characterization of the Weyl curvature of $S^m\times S^m$* (advisor Christoph Böhm, second referee Wilking; 99 pages, [full text](https://repositorium.uni-muenster.de/document/miami/820840d1-0252-4bf3-8fc7-853730eee3f5/diss_jaeger_florian.pdf), not on arXiv). Found by a citation chain through Kevin Poljsak's 2022 thesis, which cites it for the diagonal $\#$-formula $(R\#S)_{ij}=\tfrac12\sum_k(r_{ik}s_{jk}+r_{jk}s_{ik})$, matching this repo's own independently derived diagonal formula exactly.

**Its Theorem A, quoted verbatim from the source** (extracted and checked directly, not paraphrased from a search summary):

> "Theorem A. Let $n\ge16$ be an even integer, and let $W\in\langle W\rangle_d$ with $\|W\|=1$ be given such that $W^2+W^\#=\theta W$ for a $\theta\ge\theta_0(n)$. Then $\theta=\theta_0(n)$, and $W$ is the normalized Weyl curvature of $S^{\frac n2}\times S^{\frac n2}$."

with $\theta_0(n)=\sqrt{2(n-1)(n-2)}/n$, the identical closed form this repo derived independently three ways. Since $P(W)=\theta$ at a critical point and every maximizer is critical, this *is* the diagonal-case maximization result.

**Three ways it covers less than the problem statement assumes**, all consequential:
1. **The threshold is $n\ge16$, not $n\ge12$.** The sentence immediately following Theorem A reads: "The conjecture is that this is also true for all even integers $n\ge12$ and all operators $W\in\langle W\rangle$." So $n=12$ and $n=14$ are open **even in the diagonal case**, precisely the dimensions where the conjecture first bites.
2. **Even $n$ only.** Odd $n$ is not addressed; the analogous $S^m\times S^{m+1}$ statement is explicitly left conjectural.
3. **The proof is long, not short**, roughly 50 pages (§3.1–3.6), by contradiction, via a scalar-curvature "gap phenomenon", chained $\mathop{\mathrm{tr}}\mathrm{Ric}^3/\mathop{\mathrm{tr}}\mathrm{Ric}^4$ estimates, and a final appeal to the classification of compact symmetric spaces.

**Reconciling this with the problem statement's "short, elegant" framing.** The person posing the problem describes the diagonal case as solved "kurz und elegant" by an AI, while noting a colleague's doctoral thesis "could only show it in high dimensions". Jäger's $n\ge16$ is plainly that thesis; the short proof is therefore an AI-produced argument that is **not in the literature** and that this repo does not have. So the assumption granted in the problem statement is stronger than anything published, and the gap it papers over ($n=12,14$, and all odd $n$) sits exactly at the threshold under study.

**Jäger's own setup is this repo's vertex matrix.** Quoted: "Those operators $W\in\langle W\rangle_d$ can be expressed as symmetric $n\times n$-matrices $(w_{ij})$ with $0$ on the diagonal via $W(e_i\wedge e_j)=w_{ij}e_i\wedge e_j$ ... The condition that $W$ is Weyl then reduces to $\sum_i w_{ij}=0$ for all $j$." That is exactly the hollow symmetric $\Lambda$ with vanishing row sums used in the $\langle W^\#,W\rangle$ bound work recorded in [ATTEMPTS.md](../ATTEMPTS.md), independently rediscovered here, and his starting point too.

**The Beitz thesis was also located, and is not the proof source.** Stine Franziska Beitz, PhD 2018 Münster (advisor Wilking), *Bianchi-convexity and applications to Ricci flow* ([full text](https://repositorium.uni-muenster.de/document/miami/02bdc0a3-53ed-4ee3-a643-7d595df046a2/diss_beitz.pdf); chapters 1–4 as [arXiv:1902.09088](https://arxiv.org/abs/1902.09088)). It states the conjecture once, as Remark 6.3.15, in the *cone-invariance* formulation ("the cones $\Omega_a$ are invariant under the ODE for $a\in[0,\tfrac n4]$"), not the $P(W)$-maximization formulation, and never mentions sphere products, $\mathbb{CP}^2$, or diagonal Weyl operators. Its own contribution is a local Hessian computation near one boundary point, and *which* boundary point is the thing that matters, recorded here after the thesis was finally transcribed ([notes.md](../references/beitz-2018-bianchi-convexity/notes.md)).

**The cone family in decomposition form, and which end is hard.** The thesis (p. 96) shows $R\in\Omega_a$ is equivalent to

$$\frac{4a-n}4\lVert R_I\rVert^2+a\lVert R_{\mathrm{ric}_0}\rVert^2+\Big(\frac{n-2}4+a\Big)\lVert R_W\rVert^2\le0,$$

which pins the normalisation to $\lVert\mathrm{ric}(R)\rVert^2=\frac{n-1}2\lVert R_I\rVert^2+\frac{n-2}4\lVert R_{\mathrm{ric}_0}\rVert^2$. The two ends are utterly different:

| $a$ | $\Omega_a$ | |
|---|---|---|
| $>\frac n4$ | empty | |
| $=\frac n4$ | $\mathbb R_{>0}\cdot I$, **a single ray** | invariance is trivial, since $\Phi(I)=(n-1)I$ |
| $\to0$ | $\frac{n-2}n\lVert R_W\rVert^2\le\lVert R_I\rVert^2$, with $R_{\mathrm{ric}_0}$ **unconstrained** | the whole content |

**So Beitz's Lemma 6.3.16 covers the degenerate end.** It proves invariance for $a\in[\frac n4-\varepsilon,\frac n4]$, a neighbourhood of the ray, by showing $I$ is a local maximum of $G(R)=dF_R(\Phi(R))$. The open region is $a\to0$, where the cone is at its largest and the constraint is purely a bound on the Weyl part against the scalar part.

**$\theta_0(n)$ IS DERIVED, NOT POSITED, the criterion at $a=0$ produces the target constant exactly.** Take the slice $R_{\mathrm{ric}_0}=0$, so $R=cI+W$. Three literature facts do all the work:

| | |
|---|---|
| [BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.1 | $R+R\#I=(n-1)R_I+\frac{n-2}2R_{\mathrm{Ric}_0}$, with $\langle W\rangle$ in the **kernel**, so $W\#I=-W$ and $\Phi(I,W)=\tfrac12(IW+WI)+W\#I=W-W=0$ |
| [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6) | $\mathrm{Ric}(\Phi(R))_{ij}=\sum_k\mathrm{Ric}_{kk}R_{kijk}$, so $\mathrm{Ric}(W)=0\Rightarrow\mathrm{Ric}(\Phi(W))=0$: **$\Phi$ preserves Weyl** |
| [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) p. 96 | $\partial\Omega_0:\ \frac{n-2}n\lVert R_W\rVert^2=\lVert R_I\rVert^2$ |

Hence $\Phi(cI+W)=c^2(n-1)I+\Phi(W)$, and **every cross term in the cubic vanishes**, $\langle W,\Phi(I)\rangle=(n-1)\langle W,I\rangle=0$ and $\langle I,\Phi(W)\rangle=0$ because $\Phi(W)$ is again Weyl. So $\langle R,\Phi(R)\rangle=c^3(n-1)\lVert I\rVert^2+\langle W,Q(W)\rangle$. On the right, $\lVert\mathrm{ric}(I)\rVert^2$ cancels between $F$ and the pairing, and the criterion collapses with **no residue at all** to

$$\langle W,Q(W)\rangle\ \le\ c\,(n-1)\lVert W\rVert^2 .$$

Normalising $\lVert W\rVert=1$, the $\partial\Omega_0$ constraint with $\lVert I\rVert^2=\dim\Lambda^2=\frac{n(n-1)}2$ gives $c=\frac1n\sqrt{\frac{2(n-2)}{n-1}}$, so the bound demanded is

$$c(n-1)=\frac{\sqrt{2(n-1)(n-2)}}n=\theta_0(n).$$

> **The constant is not a guess read off the sphere products, it is what cone invariance at $a=0$ requires.** Verified as squares, $\frac{2(n-2)(n-1)}{n^2}$ on both sides ([b_cone_bridge.py](../scripts/route-b/b_cone_bridge.py)).

**$n\ge12$ IS NECESSARY, NOT MERELY SUFFICIENT, and it is the same polynomial a fifth time.** *Reviewer 90.* The zero-padded $W_{\mathbb{CP}^2}$ keeps $\theta=\sqrt{3/2}$ at every $n$, and the operator $cI+W$ it defines sits on $\partial\Omega_0$, the Weyl tensor itself does not, so the criterion $\theta\le\theta_0(n)$ **fails** there exactly when $\theta_0(n)<\sqrt{3/2}$, i.e. when $n^2-12n+8<0$, i.e. $n\le11$. So $\Omega_0$ is **provably non-invariant** for $4\le n\le11$, Reviewer 92 confirmed the wider range, and notes the witness is Nienhaus's rather than new here. The conjecture's dimension hypothesis is therefore forced by an explicit witness rather than assumed, and the bridge is **sharp at $a=0$**.

**Sharpness at even $n$ only.** *Reviewer 89.* The criterion gives $P(W)\le\theta_0(n)$ at every $n$, but $\theta_0$ is attained by $S^{n/2}\times S^{n/2}$ only when $n$ is even. At odd $n$ the best sphere product gives $\frac{2(n-1)(n-3)}{(n-2)(n+1)}<\theta_0(n)^2$, independently reproducing the partition argument's values, $\tfrac{40}{27}$, $\tfrac{120}{77}$, $\tfrac{21}{13}$ at $n=11,13,15$. So this is the Conjecture A **bound**, sharp at even $n$.

**Two inputs the derivation uses and did not name.** *Reviewer 90.* $\Phi$ preserves the first Bianchi identity, without it $\Phi(W)$ could carry a $\Lambda^4$ component and "$\Phi(W)$ is Weyl" would not follow (standard Hamilton fact). And the bridge needs invariance $\Rightarrow G\le0$, where [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) Lemma 2.3.4 supplies only the converse; it holds via $\tfrac d{dt}\mathrm{scal}=2\lVert\mathrm{ric}\rVert^2>0$.

**The symmetry of $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ is a theorem**, [BW08](../references/boehm-wilking-2008-space-forms/) eq. (5), and both reviewers re-derived it. It is also **not load-bearing** here: the collapse needs only bilinearity, $\Phi(I,W)=0$ and $\mathrm{scal}(Q(W))=0$.

**The real convention hazard, correctly identified.** *Both reviewers, refuting an earlier warning in this file.* Beitz and this project use the **same** norm, $\lVert I\rVert^2=\dim\Lambda^2=\frac{n(n-1)}2$, forced by her Remark 1.1.7, $\langle R,S\rangle=\mathrm{tr}(R\circ S)$, and independently by $F(I)=\frac2{n-1}$ at the $\Omega_{n/4}$ endpoint. An earlier version of this section claimed a factor-2 discrepancy; that reading came from a `pdftotext` artefact which drops fraction denominators onto the following line, and it would have invited a reader to "correct" a correct number. **The genuine gap is elsewhere:** Beitz's $\mathrm{ric}$ carries a factor $\tfrac12$ against [BW08](../references/boehm-wilking-2008-space-forms/) (her Definition 1.1.10). It cancels here, since $F\langle\mathrm{ric},\mathrm{ric}\,\Phi\rangle$ is invariant under rescaling $\mathrm{ric}$, but it is load-bearing for any figure quoting $\lVert\mathrm{ric}\rVert$ or $\mathrm{scal}$ across the two sources.

**OFF THE SLICE: exactly one new coupling, explicitly identified.** Take the general $R=cI+Y+W$ with $Y=R_{\mathrm{ric}_0}$. [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) Prop 2.7 plus [BW08](../references/boehm-wilking-2008-space-forms/) Lemma 2.2 (which supplies the block Xu's list omits, $(\Phi(Y))_W=\frac1{n-2}(\mathrm{Ric}_0\wedge\mathrm{Ric}_0)_W$) determine every one of the ten distinct triples. **Five vanish, five survive:**

$$\langle R,\Phi(R)\rangle=\underbrace{c^3(n-1)\lVert I\rVert^2+3c\langle I,\Phi(Y)\rangle+\langle Y,\Phi(Y)\rangle}_{W\text{-even}}+\underbrace{3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle}_{W\text{-odd}} .$$

Against the slice, **one** genuinely new coupling appears, the triple $(Y,Y,W)$, equal to $\frac3{n-2}\langle W,\mathrm{Ric}_0\wedge\mathrm{Ric}_0\rangle$. The five that vanish include every $I$–$W$ pairing, by Xu (3).

**The parity argument, and it is two-sided.** The constraint $\frac{n-2}n\lVert W\rVert^2\le\lVert R_I\rVert^2$ depends only on $\lVert W\rVert$, so $cI+Y-W\in\Omega_0$ whenever $cI+Y+W$ is. On the right, $\mathrm{ric}(R)$ is $W$-independent and $F(R)$ is $W$-even, while the only $W$-dependent piece of $\mathrm{ric}(\Phi(R))$ is $2\Phi(Y,W)$, which lands in $\langle\mathrm{Ric}_0\rangle$ by Xu (5) and is $W$-odd. Demanding the criterion at both signs therefore gives

$$\big\lvert\,\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}\,\big\rvert\ \le\ \mathrm{RHS}_{\rm even}-\mathrm{LHS}_{\rm even},\qquad\mathrm{LHS}_{\rm odd}=3\langle W,\Phi(Y)\rangle+\langle W,Q(W)\rangle .$$

**CLASSIFICATION: this expansion is AGREEMENT, not new.** [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) **Lemma 2.8, eq. (2.34)** is the same identity, term for term:

$$\langle Q(R),R\rangle=\frac n{2(n-1)}\bar\lambda^3+\frac3{2(n-1)}\bar\lambda\lvert\mathrm{Ric}_0\rvert^2+\frac3{n-2}\langle\mathrm{Ric}_0\wedge\mathrm{Ric}_0,W\rangle-\frac2{(n-2)^2}\langle(\mathrm{Ric}_0^2)_0,\mathrm{Ric}_0\rangle+\langle Q(W),W\rangle,$$

matching $(I,I,I)$, $(I,Y,Y)$, $(Y,Y,W)$, $(Y,Y,Y)$, $(W,W,W)$ in that order, **including the coefficient $\frac3{n-2}$**, which was reached here from BW08 Lemma 2.2 rather than copied. Xu attributes it to Huisken's proof of his Theorem 3.3, where it is not stated as an independent lemma. So the block-vanishing derivation is corroboration of a published identity by a second route; the parity argument on top of it is not in Xu.

> **So off the slice the $a=0$ criterion is not Conjecture A alone.** $\langle W,Q(W)\rangle$ enters only as one of three pieces of an odd part that must be bounded on both sides. Setting $Y=0$ kills the new coupling and $\mathrm{RHS}_{\rm odd}$ together and recovers the bridge exactly, the consistency check. What a general-$R_{\mathrm{ric}_0}$ proof still owes is a bound on $\mathrm{LHS}_{\rm odd}-\mathrm{RHS}_{\rm odd}$ ([b_cone_offslice.py](../scripts/route-b/b_cone_offslice.py)).

**Scope, stated plainly.** $a=0$ leaves $R_{\mathrm{ric}_0}$ **unconstrained**, so the full cone conjecture is strictly more than Conjecture A; Conjecture A is its $R_{\mathrm{ric}_0}=0$ slice. What is settled is that the target constant is right, not that the two statements coincide.

**ATTRIBUTION, corrected by Reviewer 91: the bridge below is PUBLISHED, twice, in sources this project already held.** [Beitz](../references/beitz-2018-bianchi-convexity/notes.md) defines $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ at (6.24), gives $dF_R(S)$ at (6.25), states $\Omega_a=F^{-1}\big((-\infty,\tfrac4{n-2+4a}]\big)$, and opens Lemma 6.3.16 with *"we consider the function $G:R\mapsto dF_R(\Phi(R))$"*. [Xu](../references/xu-2024-ricci-flow-invariant-conditions/notes.md) (3.1)–(3.4) displays the same expansion and calls it "the main task". **An earlier version of this section called the bridge a derivation the project had never made; that was wrong, and the Beitz sentence had been read and quoted in the same session.** It is the third item in this file recorded as new and later found published. The material below is therefore **corroboration**, kept for the explicit block-by-block accounting rather than for priority, and Reviewer 92 adds that it is not even a *second* route: the expansion traces to Huisken 1985 and reaches it the same way. A further convention note from Reviewer 92: [BW08](../references/boehm-wilking-2008-space-forms/) defines $P=\tfrac13\langle R,Q(R)\rangle$, a factor $3$ against this project's $P$.

**A convention check the two sources settle between them.** Xu records $F(I)=\frac1{2(n-1)}$ while Beitz's $\Omega_{n/4}$ threshold is $\frac2{n-1}$, a factor $4$, because Xu's $\mathrm{Ric}$ is twice Beitz's $\mathrm{ric}$. This is the hazard Reviewers 89 and 90 identified. The $\theta_0$ derivation is unaffected **only because $\lVert\mathrm{ric}(I)\rVert^2$ cancels** between $F$ and the pairing; any argument that does not cancel it must fix a convention first.

**Why this project's $P$ is that conjecture rather than a relative of it.** Invariance is $G\le0$, and expanding the quotient rule on $F=\lVert R\rVert^2/\lVert\mathrm{ric}(R)\rVert^2$ gives

$$G(R)\le0\iff\underbrace{\langle R,\Phi(R)\rangle}_{P(R)}\le F(R)\,\big\langle\mathrm{ric}(R),\mathrm{ric}(\Phi(R))\big\rangle .$$

$P$ **is** the left-hand side of Böhm–Wilking's criterion. At $a=0$ the constraint lets $\lVert R_W\rVert^2$ run up to $\frac n{n-2}\lVert R_I\rVert^2$, and the pure-Weyl term of $P$ ($\langle W,Q(W)\rangle$, this project's object), is what the criterion needs bounded there. That is the bridge, and it had not been derived: the earlier note that the thesis gives the conjecture "not [in] the $P(W)$-maximization formulation" is right about the wording and wrong about the content. This closes the previously-recorded "Beitz thesis was not locatable" gap with a negative: it is not where the diagonal proof lives.

**Confidence.** High for every quoted claim about Jäger's Theorem A and the $n\ge12$ remark, the PDF was downloaded and text-extracted locally, and the two load-bearing sentences were read directly from that extraction rather than trusted from a search summary. High for the Beitz identification. Moderate for "no independent treatment of the equivalent extremal matrix problem exists in the combinatorics/matrix-analysis literature", several targeted searches found nothing, but no MathSciNet or zbMATH sweep was performed. One caution recorded during this search: a WebSearch summarization layer fabricated a "Conjecture A" reference in [arXiv:2407.13847](https://arxiv.org/abs/2407.13847); grepping that paper's full text shows the phrase does not occur. Search-tool prose was therefore treated as a lead to verify, never as a citation.

The algebraic object $\langle W, Q(W)\rangle$ itself (the cubic "Frobenius form" attached to the polarization of Hamilton's $Q = X^2 + X^\#$), is treated in generality (though without this specific maximization conjecture) in [Daniel Fox, *The commutative nonassociative algebra of metric curvature tensors*](https://arxiv.org/abs/1901.04012), which shows the Weyl (Ricci-flat) tensors form a **simple nonassociative subalgebra**, and identifies its idempotents (i.e. the critical points of $P$ on the unit sphere) with points fixed by orthogonal complex/hyper-Kähler-type structures.

A closely analogous, actively-worked sibling program exists for the *curvature operator of the second kind* $\mathring R$ (acting on $\mathrm{Sym}^2(\Lambda^2)$), where products of spheres again serve as extremal/boundary models with explicit dimension thresholds, see [Cao–Gursky–Tran on Nishikawa's conjecture](https://arxiv.org/pdf/2112.08465) and [Xiaolong Li, New Sphere Theorems under Curvature Operator of the Second Kind](https://arxiv.org/abs/2407.13847).

## Phase 1, returns, and the round's verdict

**All three `GAP`, and all three rebuilt the derivation exactly.** *The collapse $\Phi(cI+W)=c^2(n-1)I+Q(W)$, both cross terms dying, $\lVert\mathrm{ric}(I)\rVert^2$ cancelling with no residue, $c(n-1)=\theta_0(n)$, $n^2-12n+8<0\iff n\le11$, the ten-triple expansion, the parity bound, **no reader found the mathematics wrong**, and every citation of Beitz, Jäger, Böhm–Wilking and Xu was read at its own text and verified verbatim.*

**Unanimous: $\mathop{\mathrm{tr}}(R)>0$ is in Beitz's own cone and was deleted from the block's printing.** *$F$ is even in $R$, so the printed set is a **double cone**, and its lower nappe demands $\langle W,Q(W)\rangle\le-\theta_0(n)$, false at every sphere product, with $R=-c_0I+W_{S^6\times S^6}$ on its boundary at $n=12$.* **The correction already stood at three places in the record, all of them beside the block rather than in it.** *Repaired.*

**Unanimous: the two statements are not the same, and the block says so in one place and denies it in another.** *Conjecture A is Nienhaus's statement and hypothesises **criticality**, while the slice criterion quantifies over every unit Weyl operator (so it implies the conjecture and not conversely) and at odd $n$ the constants differ, $\Theta_{13}^2=\tfrac{120}{77}<\tfrac{264}{169}=\theta_0(13)^2$.* **One reader found the block's closing heading asserting the identity that its own line 94 denies, and another found "that is the bridge, and it had not been derived" standing eight lines below the paragraph saying that claim was wrong.**

### The three-form rule paid on its first use

**Two readers went to the Lean layer and found nothing formal behind the headline.** *[L43.lean](../lean/HamiltonsCubic/Results/L43.lean) is `partial` with **the collapse itself owed** (Lean checks the two side-corrections, not the bridge) and [L0.lean](../lean/HamiltonsCubic/Results/L0.lean)'s binders are all $\mathbb Q$ with the Lagrange condition imported.* **A consumer inferring that the bridge is machine-checked would be wrong**, and no round before this one would have looked.

**Verdict: `GAP`, partly repaired. Impact: `NARROWS`.** *Owed: the quotation of Beitz Remark 6.3.15 restoring its own "for $n\ge12$"; the closing heading; and the criticality-quantifier gap, which is stated only in the canonical file.*
