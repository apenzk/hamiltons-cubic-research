# Reviewer r759, Gate 2 on I12's closure: whether $\Sigma\le\theta^2$ is available off the diagonal locus

**Cold brief, read in full before the record.** No numerical work was done and none is reported; every value below is exact rational or symbolic arithmetic performed by hand, and the two screens I cite are the record's own, quoted as screens. Log at [agent_logs/g2-i12-r759.log](../agent_logs/g2-i12-r759.log).

| # | claim | verdict |
| --- | --- | --- |
| **C0** | **the closure**: I12's target $\Sigma\le\theta^2(2-t_F/2)^2$ is subsumed by a recorded lemma, so a live grade-4 item retires | **BROKEN** |
| **A1** | the recorded $\Sigma\le\theta^2$ is available at every orthonormal frame | **REFUTED**, it is available only where $W$ is coordinate-diagonal in the frame, and the record says so in three places |
| **A2** | the two $\Sigma$'s are the same quantity, no normalisation differs | **CONFIRMED**, same object, no factor-of-two hazard; this is the one attack that clears |
| **A3** | $t_F\le2$, and the closure uses the per-frame reading | **CONFIRMED**, $t_F\le\kappa^2\le2$ per frame, and I12 says "the frame's own" explicitly; the swap the brief feared was avoided |
| **A4** | the direction in $\theta$: $(2-t_F/2)^2\ge1$ weakens the bound | **CONFIRMED**, $\Sigma\ge0$, $\theta^2\ge0$, $2-t_F/2\in[1,2]$ on $t_F\in[0,2]$ |
| **A5** | the recorded lemma and I12's target are nested as the closure claims | **REFUTED**, they are nested the **other way**: I12's target at $t_F=2$ *is* the recorded lemma |
| **A6** | L24 can be applied the way the recorded lemma applies it | **CONFIRMED, and it is the whole answer**, the $X\perp W$ hypothesis is free exactly on the diagonal locus, which is why L121 is sound and I12 is not |
| **A7** | nothing is lost by the closure | **REFUTED**, every frame with $t_F<2$ is lost, which is the item's entire content |
| **A8** | the grade of 4 was an over-estimate *for the reason the closure gives* | **REFUTED as argued**, the conclusion is defensible on the record's own obstruction, but not on subsumption |
| **A9** | a reading under which the closure fails exists | **NAMED**, it is the record's plain reading, not a strained one |
| **C1** | secondary: the plan entry is internally self-contradictory after the edit | **CONFIRMED**, the headline says "not proved" over a paragraph saying "**Proved.**" |

**Actionable summary.** Revert the I12 closure: restore the item to `[ ]` and strike the subsumption paragraph, because $\Sigma\le\theta^2$ is proved only at $t_F=2$ and I12's target is the statement that *generalises* it, and while there, repair [Lemma L121](../findings/second-order.md)'s consequence sentence, whose missing hypothesis is what the closure read off.

## 0. Conventions, fixed once

Throughout, $W$ is a maximiser of $P$ on the unit sphere of $\mathcal W_n$, $\theta$ its critical value with $Q(W)=\theta W$ and $e=W/\theta$. A frame $F$ is an orthonormal frame of $\mathbb R^n$; $M_{ab}=\langle W\varphi_{ab},\varphi_{ab}\rangle$ is the frame-diagonal (sectional) part and $R=W-\operatorname{diag}(M)$ the rest, so $R$ has zero diagonal in $F$. For a $4$-subset $S=\{i,j,k,l\}$, $A=M_{ij}+M_{kl}$, $B=M_{ik}+M_{jl}$, $C=M_{il}+M_{jk}$ and

$$\Sigma:=A^2+B^2+C^2-AB-BC-CA=\tfrac12\big[(A-B)^2+(B-C)^2+(C-A)^2\big]\ \ge\ 0 .$$

The frame budget is $t_F=\lVert K(F)\rVert_F^2=\sum_{a\ne b}K_{ab}^2$ over **ordered** pairs, $K=(W_{abab})$, and $\kappa^2=\max_Ft_F$ ([conventions.md](../findings/conventions.md), the $t,\kappa$ row). The norm on $\Lambda^2$ is $\lVert W\rVert=1$, in which $\lVert\operatorname{diag}(M)\rVert^2=t_F/2$ and $\lVert R\rVert^2=1-t_F/2$. Write $c=\langle X,W\rangle$ for a test direction $X$ in the $4$-set character space $V_{ijkl}$.

**The two nouns the audit turns on, kept apart.** *The block and its spectrum* is the closed form $L_{\operatorname{diag}(M)}\vert_{V_{ijkl}}=\tfrac12G$ with eigenvalues $\pm\tfrac12\sqrt\Sigma$. *The necessary condition* is the inequality $\Sigma\le\theta^2$ obtained by feeding that spectrum to [Lemma L24](../findings/second-order.md). They have different hypotheses, and [Lemma L121](../findings/second-order.md) says so in its own opening.

## Hypothesis inventory

| statement | hypotheses it actually carries |
| --- | --- |
| [L121](../findings/second-order.md), the block and its spectrum | $M$ pair-diagonal. **Diagonality alone**, no criticality, no row sum, no maximiser. Transfers to $\operatorname{diag}(M)$ in any frame |
| [L121](../findings/second-order.md), the necessary condition $\Sigma\le\theta^2$ | the above, **plus a maximiser, through [L24](../findings/second-order.md)**, and L24 supplies its bound on $W^\perp$, so the top eigenvector must satisfy $X\perp W$ |
| [L24](../findings/second-order.md) | $W$ a maximiser; $\lambda_{\max}(L_e\vert_{W^\perp})\le\tfrac12$. **The restriction to $W^\perp$ is not optional**, $L_ee=e$ makes the unrestricted claim vacuous ([L120](../findings/second-order.md)'s boxed note) |
| [L123](../findings/second-order.md) | $X$ in a single $\Gamma$-character space, $R$ zero-diagonal. Kills $\langle X,L_RX\rangle$ **and nothing else** |
| [L94](../findings/bispectral.md) | $\kappa^2\le2\lVert M\rVert_F^2$, hence $t_F\le2$ in every frame |
| **I12's target** | a maximiser, **every** orthonormal frame, $t_F$ the frame's own |

**The inventory is the finding.** Rows 1 and 2 differ, and the closure quotes row 1's scope clause as licence for row 2's inequality.

## 1. Attack 1, the hinge, and it does not hold

The closure's premise (1) is that [second-order.md](../findings/second-order.md) carries $\Sigma\le\theta^2$ "in a frame where $W$ need not be diagonal". **Located exactly**: the quoted sentence is [second-order.md](../findings/second-order.md) line 643, the last line of [Lemma L121](../findings/second-order.md), and it reads in full

> **Consequently [Lemma L24] gives, at every maximiser and every $4$-subset, $A^2+B^2+C^2-AB-BC-CA\le\theta^2$.**

**It carries no frame quantifier.** The closure supplies one, by borrowing it from the *preceding* sentence, L121's scope clause, which is about the block: *"the block and its spectrum need diagonality alone … which is what makes them applicable to $\operatorname{diag}(M)$ in a frame where $W$ is not diagonal."* That clause is immediately followed, in the same lemma, by its own disclaimer: *"**The necessary condition below is the part that needs a maximiser**, through Lemma L24."* The closure attached the scope of the first sentence to the claim of the second.

**Exhibited concretely.** L24 bounds $\lambda_{\max}(L_e\vert_{W^\perp})$. To read $\Sigma\le\theta^2$ one applies it to the top eigenvector $X_+\in V_{ijkl}$ of $\tfrac12G$, which requires $X_+\perp W$. Since $X_+$ has zero diagonal and $\operatorname{diag}(M)$ is the trivial character,

$$c=\langle X_+,W\rangle=\langle X_+,\operatorname{diag}(M)\rangle+\langle X_+,R\rangle=0+\langle X_+,R\rangle=\langle X_+,R\rangle .$$

At a coordinate-diagonal $W$, $R=0$ and $c=0$ identically, the hypothesis is free. **Off that locus $R\ne0$ and $c$ is the $4$-set component of $W$ itself**, so nothing makes it vanish. The correct conclusion, from [r353](REVIEW_r353.md)'s projection $X'=(X-cW)/\sqrt{1-c^2}$ with $L_eW=W$ and $L_e$ self-adjoint, is
$$\langle X',L_eX'\rangle=\frac{\langle X,L_eX\rangle-c^2}{1-c^2}\le\tfrac12\quad\Longrightarrow\quad\langle X,L_eX\rangle\le\tfrac{1+c^2}2\quad\Longrightarrow\quad\Sigma\le\theta^2(1+c^2)^2,$$
sharp at $X=W$ where both sides are $1$. The uncorrected form is the $c=0$ case.

**The record says this three times, in three files.**

1. [Lemma L123](../findings/second-order.md), "What it does not give": *"it does not license reading [Lemma L121]'s inequality off a non-eigenframe: [Lemma L24] also requires $X\perp W$, which fails there, and the resulting projection defect is a separate correction."*
2. [conventions.md](../findings/conventions.md), the boxed `$t$ IS PER-FRAME` note: substituting the extremal $t$ *"would assert the uncorrected four-index inequality that is false off the eigenframe."*
3. [DERIVE-mx1.md](DERIVE-mx1.md): **"THEOREM (I12), REFUTED AS STATED"**, and later *"The clean statement $\Sigma\le\theta^2$ is false off the eigenframe and stays false."*

**The opposite reading, argued at its strongest.** The closure could be read as: L121's block statement holds in every frame, and *if* one also had $X\perp W$ there, the inequality would follow, so the inequality is "carried" modulo a hypothesis nobody checked. That reading is exactly the error r353 and r354 both located: *"The final I12 proof then says only that the test direction lies in a single character space and applies L24 to the top eigenvector, without checking that eigenvector against the hypothesis its own theorem statement carries."* A statement carried modulo an unchecked hypothesis cannot subsume anything. **A second strongest reading**: perhaps $\Sigma\le\theta^2$ is nonetheless *true* off the eigenframe, unproved. Even granting that (and §5 below says the record's word "false" overreaches), a closure by subsumption needs the subsuming statement **proved**, and this one is not.

**Verdict A1: REFUTED.** The hinge fails, and with it C0.

## 2. Attack 2, the two $\Sigma$'s are the same, and the factor of two does not bite

Both $\Sigma$'s are $A^2+B^2+C^2-AB-BC-CA$ in the opposite-pair sums of the **sectional matrix of the frame**. [L121](../findings/second-order.md) fixes a pair-diagonal $M$; [DERIVE-mx1](DERIVE-mx1.md) applies it to $\operatorname{diag}(M)$ with $M_{ab}=\langle W\varphi_{ab},\varphi_{ab}\rangle$, which is pair-diagonal in $F$ whatever $W$ is. Same object.

**No normalisation differs, and here is why the live hazard cannot reach.** [conventions.md](../findings/conventions.md) records $\lVert Z\rVert_F^2=2\lVert Z\rVert^2$ and warns that "the letter $M$ carries two objects, and their norms differ by $\sqrt2$". **$\Sigma$ contains no norm.** It is a fixed quadratic polynomial in six entries $M_{ab}$, and both sides of $\Sigma\le\theta^2(\cdot)^2$ scale as (entry)$^2$: $\Sigma$ manifestly, and $\theta^2$ because $\theta$ is homogeneous of degree $1$ in $W$ at $\lVert W\rVert=1$ fixed. The record confirms the calibration independently, [DERIVE-mx1](DERIVE-mx1.md): *"at $S^3\times S^3$ the rival convention gives $\Sigma=40/9>\theta^2$ and would violate [Lemma L121](../findings/second-order.md)"*, so the normalisation is forced rather than chosen.

**Verdict A2: CONFIRMED**, and this is the one attack list item on which the closure is clean. It sharpens rather than softens the finding: the two statements are perfectly comparable, so the only question is availability, and availability is what fails.

## 3. Attack 3, $t_F\le2$ is right, and the closure used the per-frame reading

[conventions.md](../findings/conventions.md) row: *"$t=t_F=\lVert K(F)\rVert_F^2$ **per frame**, and $\kappa^2=\max_Ft_F$. [Lemma L94](../findings/bispectral.md) gives $\kappa^2\le2\lVert M\rVert_F^2$ … so $t_F\le2$ in every frame."* The per-frame bound follows from the extremal one for free, $t_F\le\max_{F'}t_{F'}=\kappa^2\le2$; no swap is needed to get it and none is committed.

**I12's own statement pins the reading**: *"$t_F$ the frame's own vertex-matrix budget"*. [DERIVE-mx1](DERIVE-mx1.md)'s Corollary 1′ pins it again, *"The corollary must be read with the frame's own $t_F$, and that is a soundness condition rather than a matter of sharpness"*, and [r355](REVIEW_r355.md) checked the monotonicity. So the trap the brief flags is not the one that was sprung.

**One imprecision, reported and small.** The closure writes *"$t_F\le2$ in every frame, with equality exactly at coordinate-diagonal $W$."* [L94](../findings/bispectral.md)'s header says "coordinate-diagonal **in some frame**" (the extremal reading) while its body says "in **that** frame" (the per-frame reading). The per-frame reading is the one needed and the one [bispectral.md](../findings/bispectral.md) states, so the closure's clause is correct under the reading it needs; the phrase is merely ambiguous. **Nothing in the closure's arithmetic depends on it.**

**And the irony is worth recording.** [conventions.md](../findings/conventions.md) fenced the $t$-swap precisely because *"at the extreme it asserts $\Sigma\le\theta^2$, which is exactly the uncorrected form this note refuted"*. The closure reached that same false endpoint **without** the swap, by miscitation instead of by substitution. The fence was built across the one road and the closure arrived by the other.

**Verdict A3: CONFIRMED.**

## 4. Attack 4, the direction in $\theta$ is right

$\Sigma\ge0$ as a sum of squares, displayed in §0. $\theta^2\ge0$ whatever the sign of $\theta$, and the record's maximisers carry $\theta>0$ automatically, $P$ being odd ([plan.md](../plan.md), the borrowed-quantity paragraph). On $t_F\in[0,2]$,
$$2-\tfrac{t_F}2\in[1,2],\qquad\big(2-\tfrac{t_F}2\big)^2\in[1,4],$$
strictly decreasing in $t_F$, with the exact endpoints $t_F=2\mapsto1$, $t_F=1\mapsto\tfrac94=2.25$, $t_F=0\mapsto4$. **All exact, computed by hand.** So multiplying a nonnegative right-hand side by a factor $\ge1$ genuinely weakens the inequality, and the closure's arithmetic ("$\Sigma\le\theta^2$ implies $\Sigma\le\theta^2(2-t_F/2)^2$"), is valid **as arithmetic**. Its premise is what fails.

**Verdict A4: CONFIRMED.**

## 5. Attack 5, the nesting runs the other way

The recorded inequality carries a hypothesis I12's target does not: **$W$ coordinate-diagonal in the frame**, equivalently $t_F=2$, equivalently $c=0$. Both claim a maximiser; that is common ground. The extra hypothesis is the difference, and it is not a technicality, it is the entire difference between the diagonal locus and everywhere else.

**So the implication the closure needs does not exist, and the reverse one does.** [DERIVE-mx1](DERIVE-mx1.md)'s Corollary 1′ states it as an identity of endpoints: *"At $t_F=2$ ($W$ coordinate-diagonal in $F$), the factor is $1$ and this **is** [Lemma L121](../findings/second-order.md), recovered rather than approximated."* **The plan entry says the same thing, in the paragraph immediately below the closure and untouched by it**, *"equal to $1$ at a coordinate-diagonal frame, where it *is* [Lemma L121](../findings/second-order.md)."*

$$\textbf{I12's target}\ \Longrightarrow\ \textbf{L121's inequality}\quad(\text{set }t_F=2),\qquad\textbf{L121's inequality}\ \not\Longrightarrow\ \textbf{I12's target}.$$

**I12 subsumes L121.** The closure has the arrow backwards.

**Verdict A5: REFUTED.** The two are not incomparable, they are nested, in the direction opposite to the one claimed.

## 6. Attack 6, L24 *can* be applied L121's way, and that is precisely the finding

[r353](REVIEW_r353.md) answers this in one sentence, and I re-derived it before reading it: *"In the eigenframe this costs nothing: a diagonal $W$ has no $4$-set component, so the whole Bianchi plane sits inside $W^\perp$ and the top eigenvector is admissible, **which is why [Lemma L121](../findings/second-order.md) is sound as stated**. In any other frame $W$ has a component in that same Bianchi plane."*

The mechanism is [L120](../findings/second-order.md)'s isotypic decomposition: at a coordinate-diagonal $W$, *"$M$ spans the trivial character and every other summand lies wholly inside $W^\perp$ by isotypic orthogonality."* So $V_{ijkl}\subseteq W^\perp$ for free, **on the diagonal locus only**.

**This is the failure mode the brief predicted, and it is present.** The step r353 refuted inside I12 is the *same* step the closure needs, applied to the *same* object; the closure's only difference is that it attributes the step to L121 rather than to I12. The attribution does not change whether $c=0$.

**Verdict A6: CONFIRMED**, in the sense that damns the closure: L24 applies L121's way exactly where I12 has nothing new to say.

## 7. Attack 7, what is lost

**Everything the item was for.** The closure's own sentence concedes it while inverting its meaning: *"strictly stronger wherever $t_F<2$, that is, off the diagonal locus, which is precisely where this item claimed to be useful."* Read correctly, $t_F<2$ is where the recorded lemma is **unavailable**, so the region where the closure claims a strict improvement is the region where its subsuming statement does not hold.

Three specific things go with it:

- **The certificate at every non-diagonal frame.** [DERIVE-mx1](DERIVE-mx1.md)'s Corollary 1′, and the reading of the defect factor in $t_F$, *"a bound on $t$ from any other part of the programme immediately sharpens the certificate."*
- **The item's own live question**, still stated in the plan entry: *"the open question of whether that ever bites at $n\ge12$."*
- **The sharp datum constraining any successor.** The record's screen at padded $W_{\mathbb{CP}^2}$ ($n=8,10,12$, $t_F=1$, $\theta^2=3/2$) gives $\Sigma/\theta^2=1$ exactly, *"so the factor cannot be brought below $1$ at that value and $(2-t_F/2)^2=2.25$ has room to fall to $1$."* Quoted as the screen [DERIVE-mx1](DERIVE-mx1.md) itself downgrades it to.

**And that screen is the closest thing to support the closure has**, $\Sigma\le\theta^2$ is *observed* to hold, with equality, at a $t_F=1$ critical point. It is not evidence for the closure: the same block says *"It is **not** a proof that $\Sigma\le\theta^2$ holds off the eigenframe"*, and the [analysis-only rule](../.claude/rules/analysis-only.md) forbids reading a screen as warrant for a positive claim. **A closure grounded in it would be grounded in the very reading that note was written to withdraw.**

**One honest correction against my own verdict.** [DERIVE-mx1](DERIVE-mx1.md) says the clean statement is *"false* off the eigenframe and stays false". **No violating witness is anywhere on the record**, r353's hand witness at $n=4$ exhibits $c\ne0$ and shows the $4$-set entries move, not $\Sigma>\theta^2$; the padded-$\mathbb{CP}^2$ screen saturates rather than violates. Strictly, the status is **unproved**, not refuted-by-example, and the record's "false" overreaches. *That does not rescue the closure* (subsumption requires proof) but a repair pass should soften that word while restoring the item.

**Verdict A7: REFUTED.** The closure loses the item's whole content.

## 8. Attack 8, the grade

The rubric ([plan.md](../plan.md) table: `moves | closes | attackable | margin | analytic | value`) had I12 at $4=2\times2\times1\times1$, with `moves` scored **none** on 2026-09-02, which is why it sits in section 2. The closure's ground for calling $4$ an over-estimate is the subsumption, and **that ground is void**.

**A defensible case for over-grading exists, and the closure does not make it.** The record already carries it, twice:

- *"THAT IS THE TENSION, AND IT IS QUADRATIC AGAINST LINEAR."* New content needs a non-diagonal frame; non-diagonality is $2-t_F$; the bound degrades like $(2-t_F/2)^2$ while $\Sigma_F$ has no reason to grow as fast, so `margin` is the column at risk, not `closes`.
- **Corollary 1 does not bite** (slack by a factor of $25$ at the balanced product at $n=12$) and the sub-step is closed by [post F46](../findings/INDEX-traps.md), the half-flat family carrying exactly one critical point.

So the *conclusion* "grade 4 was too high" may well be right; the *argument* offered for it is not. **The grade was about `closes` and `attackable` (whether a proved frame-independent certificate closes a node) and the closure addresses neither.**

**Verdict A8: REFUTED as argued.**

## 9. Attack 9, what breaks the closure, named

**The reading is the plain one.** *L121's inequality holds only where $W$ is coordinate-diagonal in the frame, because that is the only place its top eigenvector satisfies L24's $X\perp W$.* Under it, the closure's premise (1) is false, the implication chain has nothing to start from, and I12's target is the statement that extends the recorded lemma off its locus rather than a weakening of it.

**What would restore the closure**, stated positively so a successor can aim at it: *a proof that at a maximiser, in every orthonormal frame and at every $4$-subset, $\Sigma\le\theta^2$*, equivalently, a proof that the projection defect $c^2$ never costs anything in this inequality. That is an open problem strictly harder than I12, and the record's screen at padded $\mathbb{CP}^2$ says it would be sharp if true. **Until it exists, the subsumption does not.**

## 10. A second defect, found while checking: the plan entry now contradicts itself

**Located exactly.** Commit `caa05cca` rewrote one line, [plan.md](../plan.md)'s I12 headline, `[ ]` to `[x]`, adding "**CLOSED 2026-09-07 as SUBSUMED, not proved**", and left the body of the entry untouched. The next paragraph still opens **"Proved."** and derives the very factor the headline calls unreachable-and-not-worth-reaching; two paragraphs later, "**THE DEBT IS DISCHARGED**".

**So the entry now says the item was closed without proof, directly above the proof.** Whatever the correct disposition, this cannot stand as written: a reader lands on one of the two sentences and gets the opposite of the other.

**And the mechanism is on the record in the closure's own hand.** [ATTEMPTS.md](../ATTEMPTS.md)'s new entry says *"The check cost four greps"*. Four greps land on [second-order.md](../findings/second-order.md) line 643 and its preceding scope clause; the disclaimer that governs them is in [Lemma L123](../findings/second-order.md), roughly fifty lines further down the same file, and reaches the reader only if the file is read rather than searched. **The finding generalises: a scope clause and the claim it does not cover were adjacent, and their separation was not.**

## 11. The repair this audit owes

1. **Revert the closure.** Restore I12 to `[ ]` with its grade, and delete the subsumption sentence; the body of the entry already states the item's true position.
2. **Repair [Lemma L121](../findings/second-order.md)'s consequence sentence**, which is what the closure read. It should carry its hypothesis inline: *at every maximiser that is coordinate-diagonal in the frame, and every $4$-subset, $\Sigma\le\theta^2$*, with a pointer to [Lemma L123](../findings/second-order.md)'s disclaimer at the point of use. **This is the repair with leverage**: the record has now produced this misreading twice, once inside I12's own derivation and once in the closure that was meant to retire it.
3. **Soften [DERIVE-mx1](DERIVE-mx1.md)'s "false off the eigenframe" to "unproved off the eigenframe"** (§7), no witness being on file.
4. **If the item is to close, close it on the obstruction**, which is real and recorded: quadratic degradation against linear novelty, Corollary 1 slack by $25$, and [post F46](../findings/INDEX-traps.md). *That is a different closure with a different meaning (the target is reachable and reached, and not worth more work) and it should be written as that.*

## Overall verdict

**BROKEN.** The closure rests on a single premise (that the record carries $\Sigma\le\theta^2$ at every maximiser in every frame) and the record carries the opposite in [Lemma L123](../findings/second-order.md), in [conventions.md](../findings/conventions.md) and in [DERIVE-mx1.md](DERIVE-mx1.md), the last of which records the same claim as **REFUTED AS STATED** at Gate 2 by [r353](REVIEW_r353.md) and [r354](REVIEW_r354.md). Everything downstream of the premise (the arithmetic, the per-frame reading of $t_F$, the sign direction), is correct, which is what makes the closure persuasive on its face. **A live item was retired by a citation error, and the subsumption it asserts runs backwards: I12's target implies the recorded lemma, not the reverse.**
