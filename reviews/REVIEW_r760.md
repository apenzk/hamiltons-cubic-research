# Review r760, Gate 2 on I12's closure: whether $\Sigma\le\theta^2(2-t_F/2)^2$ is subsumed by the recorded $\Sigma\le\theta^2$

**Cold brief, [BRIEF-g2-i12.md](BRIEF-g2-i12.md), read in full before the record.** No numerical work was done: every value below is exact rational or symbolic, and the one arithmetic step I performed, the $n=4$ rotated-frame overlap of [r353](REVIEW_r353.md), was carried out by hand in closed form and is reported as a re-derivation, not as a screen. Log at [agent_logs/g2-i12-r760.log](../agent_logs/g2-i12-r760.log).

| # | Claim | Verdict |
| --- | --- | --- |
| **C1** | The recorded $\Sigma\le\theta^2$ is available at **every** orthonormal frame | **REFUTED**, it is available exactly at the frames where $W$ is coordinate-diagonal, and the record says so in three separate places |
| **C2** | $t_F\le2$ in every frame, hence $(2-t_F/2)^2\ge1$ | **CONFIRMED**, [L94](../findings/bispectral.md) read per-frame, which is the reading the closure uses |
| **C3** | The two $\Sigma$'s are the same quantity, with no normalisation gap | **CONFIRMED**, same $M$, same convention, and a normalisation slip would move both sides alike |
| **C4** | The direction of the inequality in $\theta$ | **CONFIRMED**, both sides carry $\theta^2$; no sign hazard exists here |
| **C5** | The two statements are nested, differing only in strength | **REFUTED**, the recorded lemma carries the strictly stronger hypothesis $X\perp W$, i.e. $t_F=2$ |
| **C6** | **The subsumption** | **BROKEN**, the two statements coincide exactly on $t_F=2$ and the recorded one is unavailable everywhere else, so the overlap is the trivial case and the implication is never exercised |
| **C7** | [r353](REVIEW_r353.md)'s refuted L24 step can be applied the recorded lemma's way | **CONFIRMED, and it is the whole of the answer**, the way it can be applied *is* the eigenframe, which is $t_F=2$ |
| **C8** | Nothing is lost by the closure | **REFUTED**, the corrected certificate, its mass budget, and the open question of whether it bites at $n\ge12$ are all retired with the item |
| **C9** | The grade of $4$ was an over-estimate *for the stated reason* | **REFUTED as argued**, though a sound de-prioritisation on other grounds is already written into the item's own body |
| **C10** | "CLOSED as SUBSUMED, **not proved**" describes the item's status | **REFUTED in both halves**, the target is proved, as a corollary of [L125](../findings/second-order.md) with [L120](../findings/second-order.md)'s orthogonality, and it is not subsumed |

**Actionable summary.** Reopen I12 or re-close it as **PROVED but not informative**, replacing the subsumption paragraph in [plan.md:279](../plan.md) with the obstruction already stated four paragraphs below it, since the recorded $\Sigma\le\theta^2$ holds only at $t_F=2$ where I12's factor is $1$.

## 0. Conventions, fixed once

$W$ is a unit maximiser of $P$ on $\mathcal W_n$ with $\theta=P(W)>0$ and $e=W/\theta$. For an orthonormal frame $F$ of $\mathbb R^n$, $M_{ab}=\langle W\varphi_{ab},\varphi_{ab}\rangle$ is the frame-diagonal part and $R=W-\operatorname{diag}(M)$, so $R$ has zero diagonal in $F$. For a four-subset $S=\{i,j,k,l\}$, $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$ and $\Sigma=A^2+B^2+C^2-AB-BC-CA$. The frame's vertex-matrix budget is $t_F=\lVert K(F)\rVert_F^2=2\lVert\operatorname{diag}(M)\rVert^2$, the sum running over ordered pairs ([conventions.md](../findings/conventions.md)); the extremal reading is $\kappa^2=\max_Ft_F$ and is not used below. $\Gamma=\{\operatorname{diag}(\pm1)\}$ is the full sign group of $F$. Inner products on $\mathrm{Sym}^2(\Lambda^2)$ are the trace pairing in which the coordinate bivectors $b_{ab}$ are orthonormal.

**The one identity everything turns on.** $\lVert W\rVert^2=\lVert\operatorname{diag}(M)\rVert^2+\lVert R\rVert^2=1$, so $\lVert R\rVert^2=1-t_F/2$, and therefore

$$t_F=2\iff R=0\iff W\text{ is coordinate-diagonal in }F .$$

The right-hand equivalence is [L94](../findings/bispectral.md)'s equality clause; the left is the displayed identity. This is used four times below and is the reason the closure fails.

## Hypothesis inventory

| Statement | Hypotheses it actually carries |
| --- | --- |
| [L120](../findings/second-order.md), sign-character block decomposition | $M$ is $\Gamma$-fixed (diagonality); the **full** sign group; no criticality |
| [L121](../findings/second-order.md), the $4$-set block is $\tfrac12G$ with spectrum $\pm\tfrac12\sqrt\Sigma$ | **diagonality of $M$ alone**, no criticality, no row sum, no maximiser |
| [L121](../findings/second-order.md), the inequality $\Sigma\le\theta^2$ | the above, **plus** [L24](../findings/second-order.md): $W$ a maximiser, $X\perp W$, $X$ unit |
| [L123](../findings/second-order.md), $\langle X,R\circ X\rangle=0$ | $X$ in a single $\Gamma$-character space; $R$ of zero diagonal in $F$ |
| [L125](../findings/second-order.md), $\langle Y,L_eY\rangle\le\tfrac12\lVert Y\rVert^2+\tfrac12\langle W,Y\rangle^2$ | $W$ a unit maximiser, $\theta>0$; **no orthogonality** |
| [L94](../findings/bispectral.md), $t_F\le2$, equality iff coordinate-diagonal in $F$ | none beyond $W\in\mathcal W_n$ of unit norm |
| I12's target | $W$ a maximiser; $F$ arbitrary |

**The whole dispute is in row three.** The closure reads L121's scope note as covering the inequality; the record scopes it to the block and its spectrum.

## 1. C1, the hinge sentence, read at source

[second-order.md](../findings/second-order.md)'s L121 opens: *"Fix a **pair-diagonal** $M$ and a $4$-subset $\{i,j,k,l\}$, the block and its spectrum need diagonality alone, with no criticality and no row sum entering, which is what makes **them** applicable to $\operatorname{diag}(M)$ in a frame where $W$ is not diagonal. **The necessary condition below is the part that needs a maximiser**, through [Lemma L24](../findings/second-order.md)."*

The antecedent of *them* is *"the block and its spectrum"*. The next sentence removes the inequality from that scope by name and hands it to L24. The closure's paraphrase, *"stated for the frame-diagonal part $\operatorname{diag}(M)$ in a frame where $W$ need not be diagonal"* ([plan.md:279](../plan.md)), attaches *them* to the inequality as well, and that is the single false step.

**The record disambiguates it three times, in three files.**

1. [L123](../findings/second-order.md), *What it does not give*: *"it does not license reading [Lemma L121]'s inequality off a non-eigenframe: [Lemma L24] also requires $X\perp W$, which fails there, and the resulting projection defect is a separate correction."*
2. [conventions.md](../findings/conventions.md), the $t$ row's warning box: substituting the extremal $t$ into a bound decreasing in $t$ *"would assert the uncorrected four-index inequality that is false off the eigenframe."*
3. [DERIVE-mx1.md](DERIVE-mx1.md), *What this does not recover*: *"The clean statement $\Sigma\le\theta^2$ is false off the eigenframe and stays false."*

**Why the hypothesis genuinely fails, in one line.** For $X$ in the $4$-set Bianchi plane of $S$, $\langle X,\operatorname{diag}(M)\rangle=0$ because $X$ lies in the character $\chi_S\ne1$ and $\operatorname{diag}(M)$ spans the trivial character ([L120](../findings/second-order.md), [L123](../findings/second-order.md)). Hence $\langle X,W\rangle=\langle X,R\rangle$, which is zero for all such $X$ **iff** $R$ has no four-set component, and at $t_F=2$, where $R=0$ outright. In the eigenframe the whole Bianchi plane sits in $W^\perp$ and L24 applies to the top eigenvector; in any other frame it need not.

**Arguing the opposite, as the brief requires.** The strongest reading the words support is that the L121 block computation transports to $\operatorname{diag}(M)$ in a non-diagonal frame, and it does, [L123](../findings/second-order.md) kills $\langle X,L_RX\rangle$ exactly, so $\langle X,L_WX\rangle=\tfrac12\sqrt\Sigma$ at the top eigenvector in **every** frame. That much of the closure's reading is right. What does not transport is the *comparison* of that number with $\theta/2$, because L24 supplies it only on $W^\perp$. The identity is frame-free; the inequality is not.

**Verdict: REFUTED.** The recorded $\Sigma\le\theta^2$ is available exactly on $\{F:t_F=2\}$.

## 2. C7, [r353](REVIEW_r353.md), and the witness re-derived by hand

[r353](REVIEW_r353.md) returned `REFUTED as proved` on I12's own L24 step and states the positive half plainly: *"In the eigenframe this costs nothing: a diagonal $W$ has no $4$-set component, so the whole Bianchi plane sits inside $W^\perp$ and the top eigenvector is admissible, which is why [Lemma L121](../findings/second-order.md) is sound as stated."*

So the brief's question, *if L24 cannot be applied the way I12 applied it, can it be applied the way the recorded lemma applies it?*, has the answer **yes, and only in the eigenframe**. That is $t_F=2$, and there $(2-t_F/2)^2=1$. The closure leans on a step that is sound precisely on the locus where its conclusion is vacuous.

**I re-derived r353's witness independently rather than taking it.** Take $n=4$ and the coordinate-diagonal $W\in\mathcal D_4$ with $M_{12}=M_{34}=\alpha$, $M_{13}=M_{24}=\beta$, $M_{14}=M_{23}=\gamma$, $\alpha+\beta+\gamma=0$. Rotate to $f_1=(e_1+e_3)/\sqrt2$, $f_2=(e_2+e_4)/\sqrt2$, $f_3=(e_1-e_3)/\sqrt2$, $f_4=(e_2-e_4)/\sqrt2$. Expanding in the orthonormal coordinate bivectors,

$$f_1\wedge f_2=\tfrac12\big(b_{12}+b_{14}-b_{23}+b_{34}\big),\qquad f_3\wedge f_4=\tfrac12\big(b_{12}-b_{14}+b_{23}+b_{34}\big),$$

both of unit norm ($\tfrac14\cdot4=1$) and mutually orthogonal ($\tfrac14(1-1-1+1)=0$). Since $W$ is diagonal on the $b_{ab}$ with entries $M_{ab}$,

$$\langle W(f_1\wedge f_2),\,f_3\wedge f_4\rangle=\tfrac14\big[M_{12}-M_{14}-M_{23}+M_{34}\big]=\tfrac14\big[2\alpha-2\gamma\big]=\frac{\alpha-\gamma}2 ,$$

nonzero whenever $\alpha\ne\gamma$, at $(\alpha,\beta,\gamma)=(1,1,-2)$ it is $\tfrac32$ before normalisation. Every step is exact and every figure matches r353's. So a coordinate-diagonal Weyl operator acquires a genuine four-set component under a two-plane rotation, $t_F$ drops below $2$ in that frame, and $\langle X,W\rangle\ne0$ for the four-set directions there. **The failing hypothesis is not vacuous.**

## 3. C2, C4, the parts of the closure that are right

**$t_F\le2$, per frame.** [conventions.md](../findings/conventions.md) records it from [L94](../findings/bispectral.md), and [bispectral.md](../findings/bispectral.md) restates it in the load-bearing form: *"[Lemma L94] gives $t_F\le2$, with equality exactly when $W$ is coordinate-diagonal in that frame, the bound is per-frame, and $\kappa^2=\max_Ft_F$ is where the extremal reading belongs."* The closure uses the per-frame reading, which is the correct one, so the brief's swap hazard does **not** fire here. **CONFIRMED.**

**The arithmetic.** For $t_F\in[0,2]$, $2-t_F/2\in[1,2]$, so $(2-t_F/2)^2\in[1,4]$ and in particular $\ge1$; at $t_F=1$ it is $(3/2)^2=9/4=2.25$ exactly. Both figures in the closure are right. **CONFIRMED.**

**The sign of $\theta$.** Both statements carry $\theta^2$, so no sign question arises in the comparison. At a maximiser $\theta>0$ in any case (L24 forms $e=W/\theta$ and the record's maximisers sit at $\theta_0(n)$ and $\sqrt{3/2}$) and $\theta=P(W)$ is $O(n)$-invariant, so it is the same number in every frame ([r353](REVIEW_r353.md) checks this explicitly). **CONFIRMED, no defect.** *Reported because the brief requires an answer, not because anything was in doubt.*

**So the closure's logic is valid and its premise is false.** Were $\Sigma\le\theta^2$ available at every frame, $\Sigma\le\theta^2\le\theta^2(2-t_F/2)^2$ would follow at once. Nothing is wrong downstream of the premise.

## 4. C3, are the two $\Sigma$'s the same quantity?

**Yes.** In both, $M$ is the sectional/frame-diagonal matrix $M_{ab}=\langle W\varphi_{ab},\varphi_{ab}\rangle$ and $A,B,C$ are its three opposite-pair sums over $S$; L121 computes the block of $L_{\operatorname{diag}(M)}$ and [L123](../findings/second-order.md) identifies that block's quadratic form with $L_W$'s. In the eigenframe $\operatorname{diag}(M)=W$ and the two readings of $M$ collapse to one.

**The factor-of-two hazard the brief names does not bite the comparison.** [conventions.md](../findings/conventions.md) carries two live traps here, $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$ on $\mathfrak{so}(n)$, and the letter $M$ carrying both the sectional matrix and the $\Lambda^2$ operator with norms differing by $\sqrt2$. Both would rescale $\Sigma$ uniformly, and $\Sigma$ appears on the left of both statements, so a slip moves them together and cannot manufacture or destroy the implication. The convention in force is moreover forced rather than chosen: [DERIVE-mx1.md](DERIVE-mx1.md) records that the rival normalisation gives $\Sigma=40/9$ at $S^3\times S^3$ against $\theta^2=10/9$, violating L121 outright.

**Where a factor of two *could* have bitten is $t_F$**, which appears only on I12's right. The identity $t_F=2\lVert\operatorname{diag}(M)\rVert^2$ was the Gate 2 debt DERIVE-mx1 flagged, and [r367](REVIEW_r367.md) discharged it by an independent mass split at padded $\mathbb{CP}^2$: $\lVert\operatorname{diag}(M)\rVert^2=\lVert W|_{V_S}\rVert^2=\tfrac12(A^2+B^2+C^2)$, giving $t_F=1$ and $\lVert R\rVert^2=1-t_F/2=\tfrac12$, both matching the file. **CONFIRMED.**

## 5. C5, nested, or incomparable?

**Neither, as the closure has it.** Both statements require a maximiser, as the brief anticipated; what differs is one hypothesis the closure does not count. The recorded lemma additionally requires $X\perp W$, and by §1 that is equivalent, over four-set directions, to $R$ having no component in the $4$-set plane, implied by $t_F=2$ and generically false below it.

So the two are nested **on their domains of validity**, in the direction opposite to the closure's:

| | domain of validity | statement there |
| --- | --- | --- |
| recorded [L121](../findings/second-order.md) inequality | frames with $t_F=2$ | $\Sigma\le\theta^2$ |
| I12's target | **every** frame | $\Sigma\le\theta^2(2-t_F/2)^2$ |

On the common domain $t_F=2$ the factor is $1$ and the two statements are **identical**, not one stronger than the other. Off it the recorded one has nothing to say. **A statement true on a subset cannot subsume a statement made on a superset, however much weaker it looks pointwise on the subset.**

## 6. C6, the subsumption itself

Collecting §1–§5:

- the recorded $\Sigma\le\theta^2$ holds exactly where $t_F=2$;
- where $t_F=2$, I12's bound reads $\Sigma\le\theta^2$, the same statement;
- where $t_F<2$, the recorded bound is not on the record at all, so it implies nothing.

**The set on which the claimed implication does any work is empty.** The closure's own sharpest sentence (*"it is strictly stronger wherever $t_F<2$) that is, off the diagonal locus, which is precisely where this item claimed to be useful"*, is therefore an argument against itself: $t_F<2$ is exactly the region where the subsuming statement is unproved. **BROKEN.**

**A second, independent route to the same break.** Read line 643's *"at every maximiser"* literally. L24 bounds $\langle X,L_eX\rangle$ with $e=W/\theta$ for the maximiser $W$; L121's block is computed for the pair-diagonal object it is applied to. For the two to compose into $\Sigma\le\theta^2$ with L121's $A,B,C$ and L24's $\theta$, the pair-diagonal object and the maximiser must be the same tensor, which is to say $\operatorname{diag}(M)=W$, i.e. $W$ coordinate-diagonal. In a non-diagonal frame $\operatorname{diag}(M)$ is not a maximiser and is not even of unit norm ($\lVert\operatorname{diag}(M)\rVert^2=t_F/2<1$), so L24 does not speak about it; only [L123](../findings/second-order.md)'s transport of the quadratic form saves the left-hand side, and the right-hand side still needs $X\perp W$.

## 7. C8, what the closure retires

**The closure loses real, currently-recorded content, and the item's own body says what it is.**

1. **The corrected certificate.** $\Sigma\le\theta^2(1+c^2)^2$ with $c=\langle W,\hat X\rangle$ is on the record as a numbered result, [Lemma L125](../findings/second-order.md)'s *What the form is for*, and holds in **every** frame. The recorded $\Sigma\le\theta^2$ does not imply it anywhere the latter is unavailable, which is the same region as before.
2. **The mass budget.** $\sum_Sc_S^2\le\lVert R\rVert^2=1-t_F/2$ over the $\binom n4$ subsets, from [L120](../findings/second-order.md)'s orthogonality of the four-set planes at every $n\ge4$ ([r355](REVIEW_r355.md), [r356](REVIEW_r356.md)). This is a genuinely frame-independent exclusion instrument: it says at most $\lfloor1/t\rfloor$ subsets can carry defect above $t$, so a violation is certified whenever the frame-diagonal part exceeds $\theta^2(1+t)^2$ at more than $1/t$ subsets. Nothing in L121 carries this.
3. **The open question the item owned.** [plan.md:279](../plan.md)'s own *What this item still owns* names it: *"the open question of whether that ever bites at $n\ge12$"*. Closing the item as subsumed retires that question on a false premise rather than answering it.

**Is anything sharper in the recorded form?** At $t_F=1$ the record's screen at padded $\mathbb{CP}^2$ gives $\Sigma=\theta^2$ exactly, so the uncorrected bound would be **attained** there if it held. That is the strongest thing that can be said for the closure's direction, and it makes the point the other way: the closure treats a bound that is screened tight and explicitly unproved as though it were proved, at the one non-diagonal witness the record has. *[DERIVE-mx1.md](DERIVE-mx1.md) already downgrades that datum to a screen under the [analysis-only rule](../.claude/rules/analysis-only.md), and I cite it only as the record's own characterisation, not as evidence.*

## 8. C9, C10, the grade, and what the item's status actually is

**The grade critique falls with the subsumption.** The closure's stated reason, *"its grade of $4$ was an over-estimate for that reason"*, the reason being that the theorem is a weakening of an already-proved lemma, has no premise left. Grade $4$ decomposes as $2\times2\times1\times1$ in the plan's rubric ([I18](../plan.md) carries the same factorisation explicitly), and the multiplicands are value, attackability and two further factors, with `moves` recorded separately as **none** for all four items at the foot of section 2. **Nothing in the closure addresses any of those factors.**

**A sound de-prioritisation nevertheless exists, and it is already written four paragraphs below the closure**, in the item's own *The obstruction*: new content lives only in non-diagonal frames, which are exactly where $(2-t_F/2)^2$ weakens the bound, so *"new content and strength pull against each other"*; the certificate is slack by a factor of $25$ at the balanced product's $t_F=2$ and by $2.25$ at $t_F=1$, and the bound is loosest where it is formally strongest. **That is the honest closure**, and it does not require the subsumption at all.

**And "SUBSUMED, not proved" is wrong in its second half too.** The target is derivable from the record's own numbered results: [L125](../findings/second-order.md) gives $\sqrt\Sigma\le\theta(1+c^2)$ at the block's top unit direction in every frame; [L120](../findings/second-order.md)'s orthogonality plus $\lVert W\rVert^2=\lVert\operatorname{diag}(M)\rVert^2+\lVert R\rVert^2$ gives $c^2\le\lVert R\rVert^2=1-t_F/2$; substituting, $\sqrt\Sigma\le\theta(2-t_F/2)$, which is the target. The item's own body says as much under *Proved*. So the correct disposition is **closed as proved and not informative**, and the two halves of the recorded verdict are each wrong.

## 9. What would break the closure, and what would save it

**The reading under which I12's target is not implied, the correct one.** Scope L121's frame-freedom to *the block and its spectrum*, as the lemma's own sentence does and as [L123](../findings/second-order.md) insists, and read *"at every maximiser"* in line 643 as requiring the pair-diagonal $M$ to be the maximiser itself. Then $\Sigma\le\theta^2$ is a statement about $t_F=2$ frames, I12's target is a statement about all frames, and no implication runs from the first to the second off the diagonal locus.

**What would save the closure, stated so it can be attempted.** A proof that $\langle X,W\rangle=0$ for every four-set Bianchi-plane direction $X$ in every orthonormal frame at a maximiser, equivalently, that a maximiser's off-diagonal part $R$ carries no four-set component in any frame. That would restore L24's hypothesis and with it $\Sigma\le\theta^2$ everywhere. It is refuted for general Weyl tensors by the §2 witness, where a coordinate-diagonal $\mathcal D_4$ element acquires a four-set component of size $(\alpha-\gamma)/2$ under a two-plane rotation; whether a *maximiser* could nonetheless have the property is not settled by that witness and is the only door left open. **Absent such a proof, the closure is unsound.**

**Nothing else in the brief's attack list produced a finding.** C2, C3 and C4 clear; the per-frame/extremal swap the brief warned about did not occur; the maximiser hypothesis is shared by both statements; and no normalisation discrepancy affects the comparison. **Every attack item is answered above, including the three where I found nothing.**

## Overall verdict

**BROKEN.** The closure's premise (that the record carries $\Sigma\le\theta^2$ in every orthonormal frame), is contradicted by [second-order.md](../findings/second-order.md)'s own L121 and L123 blocks, by [conventions.md](../findings/conventions.md)'s $t$ warning, by [DERIVE-mx1.md](DERIVE-mx1.md), and by [r353](REVIEW_r353.md) and [r354](REVIEW_r354.md) agreeing at Gate 2. The recorded inequality holds exactly at $t_F=2$, where I12's factor is $1$ and the two statements are the same; below $t_F=2$ it is unproved and implies nothing. A live item was retired on a misread scope note. **The repair costs one paragraph**: re-close I12 as proved and not informative, on the obstruction its own entry already carries.
