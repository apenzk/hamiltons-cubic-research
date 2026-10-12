# ROUND_L33, one eigenvalue of one sign forces the tensor to vanish

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `GAP`, repaired, impact `NARROWS`. **Verifiers:** v164, v165, v166.

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement, and two argument paragraphs with it | [results.md](../results.md) lines 471–478 |
| Landscape statement | [results.md](../results.md) line 152 |
| The block | [stratum-two-negative.md](../findings/stratum-two-negative.md) lines 119–160 |
| Brief | [BRIEF_L33.md](BRIEF_L33.md) |

## Two findings from phase 0

**1. The provenance note asserts and denies the same fact in one sentence.** It reads *"Moved here from [results.md](../results.md) on 2026-08-31, **the duplication resolved on 2026-09-06**"* and, four clauses later, *"**results.md still carries two argument paragraphs** rather than the statement alone"*. Checked: [results.md](../results.md) does carry them. *This is the third block in four rounds whose provenance note claims a duplication resolved that was not.*

**2. The load-bearing identity is cited to a book the record does not hold.** The Weitzenböck term is credited to Besse, *Einstein Manifolds* §1.143, and [references/](../references/) holds no Besse. **[Petersen–Wink](../references/petersen-wink-2019-bochner-technique/) is on file** and is credited only with the eigenbasis rewriting, *"and not the evaluation"*, so the step the proof runs on rests on the unheld source.

## What the verifiers are asked beyond the standing list

Whether the operator identity $\sum_\alpha\lambda_\alpha\,\mathrm{ad}(v_\alpha)^2=2W$ follows from first Bianchi and Ricci-flatness as claimed, and which of the two does which work, the block says Bianchi is load-bearing and Ricci-flatness only deletes a correction, with $\Lambda^4$ named as why Ricci-flatness alone fails. Whether $\langle u,N_vu\rangle=2\langle v,u\rangle^2+\lVert[v,u]\rVert^2$ and $\ker N_v=v^\perp\cap\mathfrak z(v)$ are right. Whether the [L32](../findings/isotropy-cap.md) step survives, given that L32 carries a hypothesis this block asserts is automatic here. And whether *"with multiplicity"* now travels to every site that quotes the statement, the reading under which the lemma is **false**, with witnesses in $\mathrm{Weyl}_4$ and at $m=8$, is the one a reader outside this file would take.

## Clustering, all three in; two `GAP` against one `PROVEN`, agreeing on every step

**`PROVEN`.** *The first clean `PROVEN` of the session, and it was earned by derivation rather than by trusting the citation.*

**The operator identity was rebuilt cold.** $\lVert[v,u]\rVert^2=\operatorname{tr}(u^2v^2)-\operatorname{tr}(uvuv)$, the first term being $-\operatorname{tr}(\mathrm{Ric}\,u^2)$ and the second $X=\sum W_{abcd}u_{ac}u_{bd}$. **First Bianchi enters exactly once**, closing $X+Y+Z=0$ with $Y=-4\langle u,Wu\rangle$ and $Z=X$, neither of which uses it, so $X=2\langle u,Wu\rangle$. *The block's account of which hypothesis does which work is right.*

**The $\Lambda^4$ witness is confirmed and is stronger than the block states**: total antisymmetry makes the Bianchi sum $3R$, so $\mathcal A(R)=-4R$ at **every** $m\ge4$ rather than at $m=4$ alone.

**The $N_v$ algebra and the kernel inclusion hold**, and the inclusion genuinely needs the one-sided rescaling, *which only a single minority term makes available*, so the hypothesis is doing exactly the work the proof needs. **$\mathfrak c=0\Rightarrow m\le3$ is confirmed** from $\dim\mathfrak z(x)=\sum_jm_j^2+\binom k2$. **Both witnesses rebuilt independently by both verifiers**, and *"with multiplicity"* reaches all three live copies, [results.md](../results.md) at its landscape bullet and its canonical block, and [report/sections/07-gradedness-split.tex](../report/sections/07-gradedness-split.tex). **No live copy of the false reading remains.**

| id | finding | support |
|---|---|---|
| **H1** | **The Besse citation is to the wrong section as well as to an unheld book, and it is not load-bearing.** §1.143 is the Lichnerowicz Laplacian on **symmetric $2$-tensors**, not on $2$-forms, and **the identity now has two independent derivations from this round alone**, by different routes: one closing $X+Y+Z=0$ with first Bianchi entering exactly once, the other by Schur's lemma on $\mathrm{Sym}^2(\Lambda^2)$, whose four summands have distinct highest weights, plus one hand evaluation at padded $W_{\mathbb{CP}^2}$. *The block credited [Petersen–Wink](../references/petersen-wink-2019-bochner-technique/notes.md) with "not the evaluation" while its own notes on file carry a derivation* | v164, v166 |
| **H2** | the quoted $\mathring R$ display runs in the $ikjl$ index order that [conventions.md](../findings/conventions.md) calls load-bearing and settles **against**; read in the record's own convention it is off by $4R$, giving $-2n$ against $-2n+4$ at $R=\mathrm{Id}$. *Downstream mathematics untouched* | v164 |
| **H3**, **THE ROUND'S SPLIT, AND IT IS ABOUT A WORD** | **Both verifiers found the same hole in the same place and disagree only on whose it is.** [L32](../findings/isotropy-cap.md)'s written proof reaches neither branch at **corank 1**: the literal degenerate clause invokes $\mathfrak{so}(\ker x)$, which is $0$ when $\dim\ker x=1$; and the charitable reading, re-running the roots with $a$ padded by zeros, breaks the other way, since at odd $m$ the algebra is $B_p$ and *"every root of $D_p$ has $p-2$ zero coordinates"* is false, the centraliser of $x=e_{12}\in\mathfrak{so}(5)$ having dimension $4$ where the containment allows $2$. **v164 books the debt against L32 and calls L33 `PROVEN`; v166 books it against L33, whose block advertises coverage of odd $m$, and the generic odd-$m$ case IS corank 1.** *Both checked the conclusion by hand across corank $0,1,2,\ge3$ at $m=4$ through $8$ and neither found a falsifier: the conclusion is true there and its proof is not written* | v164, v166 |
| **H6** | **the record's own prescribed repair is aimed at the empty branch.** [LEDGER.md](../findings/LEDGER.md) names the $\mathfrak{so}(\ker x)$ route as L32's fix, *the one branch that is vacuous at corank 1*, which is the case the repair is needed for | v166 |
| **H7** | one untabled live symbol collision: $N=\binom n2$ in [conventions.md](../findings/conventions.md) against the operator $N_v$ of this block, with [L34](../findings/stratum-two-negative.md) using the tabled sense fifty lines later in the same file | v164, v166 |
| **H4** | **L33 is vacuous at $m=4$**: a single positive eigenvalue forces one of $W^\pm=0$, and every nonzero element of $\Lambda^\pm$ squares to $-\tfrac12\lvert c\rvert^2I$, so $m=4$ is *always* the exception. **The *"in particular"* clause's $m\ge6$ is sharp**, false at $m=4$ with $W\vert_{\Lambda^2_+}=\operatorname{diag}(2,-1,-1)$, $W\vert_{\Lambda^2_-}=0$ | v164, v166 |
| **H5** | **L33 has no load-bearing consumer left.** The B0 route it was built for is refuted by [L34](../findings/stratum-two-negative.md), and its live use at L29's equality clause is a second route to something [L31](../findings/stratum-two-negative.md) already closes | v164 |

**The falsifier hunt returned nothing.** A nonzero $W\in\mathrm{Weyl}_m$ whose whole signed side is one simple eigenvalue with $x$ of rank $\ne4$, or rank $4$ with unequal singular values, attacked through the identity, the exception's completeness at every rank shape and every kernel dimension, the $m=4,5$ boundary, and the minority side's structure.

## Adjudication

**Verdict `GAP`, repaired. Impact `NARROWS`.** Two `GAP` against one `PROVEN`, and **the three agree on every piece of mathematics**, the split is over where a single debt is booked. All three re-derived the operator identity, all three rebuilt both witnesses, all three checked corank $0$, $1$, $2$ and $\ge3$ at $m=4$ through $8$ by hand, and **none found a falsifier**.

**`GAP` is the right word because the block advertises what it does not cover.** [L32](../findings/isotropy-cap.md)'s written proof reaches neither branch at corank $1$, and corank $1$ is the generic odd-$m$ case, which this block names among the *"three true clauses dropped in the move"* it restored. A result whose stated coverage exceeds its proof has a gap, wherever the missing argument is owed.

### What the round established, beyond checking

**The identity needs no outside source, and the record already held it.** Two independent derivations were built here, one closing $X+Y+Z=0$ with first Bianchi entering exactly once, one by Schur on $\mathrm{Sym}^2(\Lambda^2)$ with a single hand evaluation, and **[isotropy-cap.md](../findings/isotropy-cap.md)'s operator $T$, forty-five lines above L32, carries the same quadratic form with its tabled $-2$ on $\mathrm{Weyl}_n$**. *The block cited an unheld book for a fact sitting in the file it links to, at the wrong section of that book, for the wrong kind of tensor.*

**A third pinning arrived from the third verifier**: four closed-form objects, one per isotypic piece, $2m-4$ at the round sphere, $m-4$ at $h\owedge g$, $+4$ at $\star$ on $\Lambda^2\mathbb R^4$, and $-2$ at $W^+=\operatorname{diag}(2,-1,-1)$ in $\mathcal W_4$.

### The repairs, all applied

| finding | what changed |
|---|---|
| H1 | the Besse citation replaced by the two derivations and by the record's own $T$; what the citation was is recorded as what it is, unheld, wrong section, wrong tensor type, transferred from a manifold statement without comment |
| H3 | the corank-$1$ gap stated in the block, with both branches of L32's failure named and the $m=7$ instance $x=\varphi_{12}+2\varphi_{34}+3\varphi_{56}$ given; coverage now says what is proved and what is owed |
| H6 | [LEDGER.md](../findings/LEDGER.md)'s prescribed repair recorded as aimed at the branch that is empty at corank $1$ |
| the $\mathfrak c\ne0$ discharge | replaced by $\dim\mathfrak c\ge\lfloor m/2\rfloor-1$; *the sentence that stood gave $\dim\mathfrak z(x)\ge1$ at $x=\varphi_{12}\in\mathfrak{so}(6)$ where the argument wants $\lfloor m/2\rfloor$* |
| the closing step | *"Ricci-flatness forces $x=0$"* now names the trace, which is what does it |
| H4 | vacuity at $m=4$ and the sharpness of $m\ge6$ stated in both files |
| H5 | the absence of a load-bearing consumer recorded, the B0 route refuted by [L34](../findings/stratum-two-negative.md), the L29 use duplicating [L31](../findings/stratum-two-negative.md) |
| H7 | $N_v$ against the tabled $N$, $\mathring R$'s two senses a hundred and eighty-one lines apart, and $x$ as bivector against vector, all tabled in [conventions.md](../findings/conventions.md) |
| phase 0 | the provenance note no longer asserts and denies the same fact; [results.md](../results.md) states coverage where it carried a duplicated argument paragraph; and a dead anchor is repointed |

### Queued elsewhere

**Research loop.** [L32](../findings/isotropy-cap.md) at corank $1$, the conclusion is true, checked by three readers across five dimensions, and the argument must run off $\mathfrak c_V$ having trivial common kernel rather than off $\mathfrak{so}(\ker x)$. **This is the one piece of new mathematics the round identified and did not write.**

**Queue.** [L32](../findings/isotropy-cap.md)'s canonical statement still carries a refuted form while [results.md](../results.md) and [report/](../report/) carry a different repair; and L32 now has a named gap, so it enters the queue rather than waiting for its tier.
