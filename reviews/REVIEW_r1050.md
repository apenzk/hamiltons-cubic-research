# Review r1050 on W7, "the clause above $\sqrt{3/2}$ is load-bearing"

Sole reviewer on the scope, cold brief, attacking [W7](../findings/INDEX-traps.md) and its supporting block at [diagonal-half.md:1423](../findings/diagonal-half.md). Log: [agent_logs/r1050-threshold-warning.log](../agent_logs/r1050-threshold-warning.log). Analysis only, no run longer than seconds, and the one arithmetic check below is a screen of my own claim.

| # | claim | verdict |
|---|---|---|
| 1 | the two catalogued points are genuine critical points of $\mathcal W_6$ with $s=10,15$ and $\theta=0.054718,0.091388$ | **CONFIRMED**, with a provenance correction: they are OFF-catalogue generic points |
| 2 | both $\theta$ far below $\sqrt{3/2}$, so neither [I68](../plan.md) nor [I75](../plan.md) is refuted as stated | **CONFIRMED** |
| 3 | I75's obligation is $8$ and $13$ rows there, against $0$ at $s=2$ | **CONFIRMED**, wording note on "obligation" |
| 4 | the clause cannot be dropped, and no route may prove either conclusion over the critical set at large, and whether W7 duplicates the record | **REFUTED as argued**: the conclusion is true, the two witnesses do not carry it, and a stronger witness is already on the record |
| 5 | $s\le2$ is false over the critical set, with the disclaimer on the intermediate condition | **REFUTED**: the main clause holds, the disclaimer is false against [ungraded-slack.md](../findings/ungraded-slack.md) |
| 6 | W7 belongs in the warning class and its `where` pointer resolves | **PLAUSIBLE**, the pointer resolves and its attribution does not |
| 7 | overreach sweep | **REFUTED**: a third overreach, a misattribution and a falsified absence claim |
| 8 | the `where` pointers newly added to W5 and W6 | **CONFIRMED**, both resolve to [conventions.md](../findings/conventions.md) rows that hold the subject |

## Claim 1, the two points: CONFIRMED, with a provenance correction

The numbers reproduce off the record. [r335](REVIEW_r335.md) re-solved the first point with its own Newton, its own basis and its own LP and reports $\theta=0.054718$, $10$ distinct eigenvalues, LP $\max=0.284314$, gap $0.229596$. [r336](REVIEW_r336.md) produced $20$ distinct critical points of $\mathcal W_6$ "with $10$ to $15$ distinct eigenvalues" at residuals $\le5\times10^{-15}$, three orders better than the $10^{-9}$ the block quotes. So the phenomenon is corroborated on a far wider base than two points, and the block cites the weaker source.

Two corrections.

- **They are not catalogue points, and the source sentence says the opposite.** [bounds.md:613](../findings/bounds.md) opens "BUT IT IS A CATALOGUE PROPERTY, NOT A PROPERTY OF CRITICAL POINTS" and then produces these two as **generic** points at which the catalogue property fails. [LEDGER.md](../findings/LEDGER.md)'s biased-sample rule draws exactly this line: the LP is "lossless at **all 17 catalogued** critical points ... and lossy at **every** generic Newton-solved critical point of $\mathcal W_6$". The block's "the record's own catalogue holds two Newton-solved critical points" and W7's `where` cell "from [bounds.md](../findings/bounds.md)'s catalogue" invert that. Fix: *off-catalogue generic Newton points*, which is also the stronger provenance, since a catalogue witness would be open to the biased-sample objection.
- **The existence claim is a screen, not a theorem.** A Newton solution at residual $10^{-9}$ (or $5\times10^{-15}$) is an approximate critical point, and the record carries no Newton–Kantorovich certificate placing an exact critical point near it. W7 states "$s$ ... REACHES $10$ AND $15$ over the unrestricted critical set" flatly. The row does say "screened", which is enough, and the block should keep that word attached to the existence claim rather than only to the residual.
- The second point, $\theta=0.091388$ with $15$ distinct eigenvalues, is **single-sourced**: r335 reproduced the first point only, and r336's sample covers the range without naming this value.

## Claim 2, both witnesses below the threshold: CONFIRMED

$0.054718$ and $0.091388$ against $\sqrt{3/2}=1.224745$, and below even $\Theta_6=1.0541$. Nothing rescales them, since $\theta=P(W)/\lVert W\rVert^3$ is scale-invariant, so a witness cannot be lifted over the threshold by renormalising. Neither item is refuted as stated, and the block and the row both say so plainly.

## Claim 3, the $8$ and $13$ rows: CONFIRMED

$\max(10-2,0)=8$, $\max(15-2,0)=13$, $\max(2-2,0)=0$, and that is the rule the same block derives four paragraphs above, on the consecutive block $k=2,\dots,s-1$. The arithmetic and the source agree.

One wording note. At those two points [I75](../plan.md) as stated imposes **no** obligation at all, its hypothesis being "above $\sqrt{3/2}$", so "this item's obligation is $8$ and $13$ rows at those two points" is a counterfactual about the clause-free item. The heading signals that, and a reader taking the sentence alone would take it for a live obligation.

## Claim 4, the reach claim: REFUTED AS ARGUED

The conclusion is true. The inference from these two witnesses is not, and the record already holds the witness that does carry it.

**The I75 half is a non sequitur.** A long list of conditions is not a failed condition. The witnesses give $s=10$ and $s=15$, hence $8$ and $13$ rows, and say nothing about whether those rows hold. A derivation settles that the count carries no weight at all: write $\mathrm{comp}(A)_{ijkl}=\langle A\varphi_{ij},\varphi_{kl}\rangle$ with $\varphi_{ij}=e_i\wedge e_j$, which is the block's own normalisation, since $A=\mathrm{Id}$ returns $\delta_{ik}\delta_{jl}-\delta_{il}\delta_{jk}$ exactly as it records. If $W$ is coordinate-diagonal then $\mathrm{comp}(W^k)_{ijkl}=0$ whenever $\{i,j\}\ne\{k,l\}$, and $\mathrm{Alt}$ reads only components with four distinct indices, so $\mathrm{Alt}(W^k)=0$ **at every coordinate-diagonal $W$, at every $k$, with no criticality hypothesis and no bound on $s$**. A coordinate-diagonal tensor at $n=6$ may carry up to $\binom62=15$ distinct eigenvalues, so a point with $s=15$ can satisfy all $13$ of its rows. The count is an upper bound on the work, never evidence that the conclusion fails.

**The I68 half needs a fact the record does not carry.** I68's conclusion is quantified over **non-diagonal** critical points. The witnesses refute a rank bound only if they are non-diagonal, and the record establishes only that they are "generic" and Newton-solved. Distinct eigenvalue counts cannot supply it, by the previous paragraph. What the counts do give, granting non-diagonality: $15$ distinct eigenvalues on the $15$-dimensional $\Lambda^2$ forces $\operatorname{rank}\ge14$, and $10$ distinct forces $\operatorname{rank}\ge9$, so any $r$ below $9$ would indeed fail there.

**And it is close to a duplicate.** Padded $W_{\mathbb{CP}^2}$ is a critical point (residual $\sim10^{-15}$, [diagonality.md:65](../findings/diagonality.md), a local maximum at $n=8$ and $n=12$) sitting at $\theta=\sqrt{3/2}$ **exactly** ([W5](../findings/INDEX-traps.md): $M(4)=M(6)=\sqrt{3/2}$, attained there), with $\mathrm{Alt}(W^3)=c^3\star\ne0$, which the same I75 block states two paragraphs above. That single point refutes I75's conclusion at the threshold itself, hence over the critical set at large, and [plan.md](../plan.md)'s I75 row already cites it in those words: "which fails at $W_{\mathbb{CP}^2}$ at the threshold itself". It is the better witness on every axis: exact rather than screened, at the boundary rather than a tenth of the way to it, and refuting the conclusion rather than lengthening a list.

**What the two witnesses do add**, and W7 should be restated around it: the failure is not confined to the boundary point, and $s$ runs to $10$ and $15$ rather than $W_{\mathbb{CP}^2}$'s $3$, so a spectral count route to I75 faces a long list off the threshold. That is worth a row. "No route may prove either item's conclusion over the critical set at large" should cite $W_{\mathbb{CP}^2}$ for I75 and leave the rank statement to I68 with the non-diagonality gap named.

## Claim 5, $s\le2$ over the critical set, and the disclaimer: REFUTED

The main clause is true, and it is true on better witnesses than the two offered. [fence-posts.md:172](../findings/fence-posts.md) already records a zero-defect critical point at $n=6$ with three distinct eigenvalues of multiplicities $5,6,4$, and [ungraded-slack.md](../findings/ungraded-slack.md) tabulates three exact critical points with three or more distinct eigenvalues.

The disclaimer is false, and this is the material finding of the review. [ungraded-slack.md](../findings/ungraded-slack.md) carries $S^5\times S^7$ at $n=12$ as a pair-graded **critical** point at $\theta=1.2282390$, above $\sqrt{3/2}=1.2247449$, with **three distinct eigenvalues**. I rederived the spectrum from the record's own closed form for Einstein $S^p\times S^q$: in units of $\mu$ the blocks are $\tfrac{n-p}{(p-1)(n-1)}=\tfrac7{44}$ on $\Lambda^2V_5$, $\tfrac{n-q}{(q-1)(n-1)}=\tfrac5{66}$ on $\Lambda^2V_7$ and $-\tfrac1{n-1}=-\tfrac1{11}$ on the mixed block, three distinct values, none zero, and $\theta^2=264/175$ gives $1.2282392$ against $\sqrt{3/2}=1.2247449$.

So **"critical AND above $\sqrt{3/2}$ $\Rightarrow s\le2$" is FALSE**, and the block's "the intermediate condition ... is untouched by them and may well be enough" is wrong for the $s\le2$ conclusion the preceding sentence attaches it to. The consequence is worse than a stray clause, because the block then names that condition as "the cheapest thing to try next": the programme is pointed at a hypothesis the record already kills for the bound [I73](../plan.md) needs. [ungraded-slack.md](../findings/ungraded-slack.md) even states the general shape in terms, "$S^5\times S^7$ sits **above** $\sqrt{3/2}$, so restricting the claim to $\theta>\sqrt{3/2}$ leaves it false", there about the Casimir classification.

Two riders that survive.

- The insufficiency is for $s\le2$. I75's own conclusion still holds at $S^5\times S^7$, which is coordinate-diagonal and therefore has $\mathrm{Alt}(W^k)=0$ for every $k$ by the derivation under claim 4. So the threshold condition remains open for I75 and is settled negatively for I73's spectral bound.
- "Full maximality is not shown to be necessary" stands. What is now shown is that the named intermediate condition is insufficient, which leaves room for a weaker strengthening than global maximality, local maximality or a threshold at $\theta_0(n)$ being the obvious candidates. $S^5\times S^7$ does not sit above $\theta_0(12)=1.2360331$.

## Claim 6, the class and the pointer: PLAUSIBLE

The warning class fits the framing, a clause that reads as cosmetic and is not, and the row is cited by id from the block, as the class requires. Two things pull the other way.

- The row's operative sentence, "What they forbid is dropping the clause, or proving either conclusion over the critical set at large", is a **route closure with a successor condition**, which is fence-post shape. Filing it as a post would have forced the witness to be named precisely, and that is the step that would have surfaced $W_{\mathbb{CP}^2}$ and the duplication under claim 4.
- The `where` cell resolves as a path, both [diagonal-half.md](../findings/diagonal-half.md) and [bounds.md](../findings/bounds.md) existing and holding the subject, but its attribution "from [bounds.md](../findings/bounds.md)'s catalogue" is wrong, per claim 1.

Separately, [INDEX-traps.md](../findings/INDEX-traps.md)'s own preamble still reads "**The warnings**, `W1`…`W5`", while the table now runs to W7. The staleness predates this change, which added W6's and W7's neighbours without touching it.

## Claim 7, overreach sweep

- **The third overreach is the "may well be enough" / "cheapest thing to try next" pair**, refuted under claim 5 by a witness already on the record. It is of the same species as the two the author caught, an absence claim about the record that a search by the object falsifies.
- **The catalogue misattribution**, claim 1, which inverts the source sentence and loses the provenance that makes the witnesses immune to the biased-sample rule.
- **The commit's `Searched:` trailer carries a falsified absence claim**: "nothing on the record connects the catalogue's high-s critical points to I73, I75 or I68". [ungraded-slack.md](../findings/ungraded-slack.md) connects three-eigenvalue critical points to the two-eigenvalue question at every threshold, including one above $\sqrt{3/2}$, and [plan.md](../plan.md)'s I75 row connects $W_{\mathbb{CP}^2}$ to the failure of the link at the threshold.
- **Heading against body.** "THE LIST IS NOT SHORT WITHOUT IT" is supported for the row count and is not an obstruction claim, while the body's "no route may prove either item's conclusion over the critical set at large" is an obstruction claim resting on that count. The body's own concession, "they REFUTE NEITHER I75 NOR I68 as stated", sits in the same paragraph.
- **Understatement worth fixing while the block is edited**: "two witnesses" against [r336](REVIEW_r336.md)'s $20$ critical points spanning $s=10$ to $15$ at residual $\le5\times10^{-15}$, and [r335](REVIEW_r335.md)'s further sample. The caution "two witnesses bound nothing from above" is right and the evidence base is wider than two.

## Claim 8, the W5 and W6 pointers: CONFIRMED

- W5 $\to$ [conventions.md](../findings/conventions.md), whose $M(n)$ row states the global maximum, its distinctness from $\Theta_n$, and the $M(4)=M(6)=\sqrt{3/2}$ values the row uses.
- W6 $\to$ [conventions.md](../findings/conventions.md), whose $K$ and $t$ paragraph states $t=\lVert K\rVert_F^2=\sum_{a\ne b}K_{ab}^2$ "the sum over **ordered** pairs" at the definition, exactly as the cell promises.

## What I would change in the record

1. Strike "may well be enough" and "the cheapest thing to try next", and replace them with $S^5\times S^7$ as the witness that **critical AND above $\sqrt{3/2}$ does not give $s\le2$**, at $n=12$, with the three block eigenvalues. That is the single most useful sentence available here for [I73](../plan.md).
2. Re-anchor the reach claim on padded $W_{\mathbb{CP}^2}$ for I75, and keep the two generic points as what they do establish, that $s$ runs to $10$ and $15$ off the threshold.
3. Say "generic, off-catalogue" rather than "the record's own catalogue", in both the block and W7's `where` cell.
4. Name the non-diagonality gap in the I68 half, or drop I68 from the reach sentence.
5. Fix [INDEX-traps.md](../findings/INDEX-traps.md)'s preamble to `W1`…`W7`.
