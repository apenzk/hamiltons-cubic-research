# Review r643, Lemma L65, "the seed is a diagram, under admissibility"

**Verdict: CONFIRMED**, the construction is correct, the proof is two lines, and the hypothesis named in the heading is the one the proof consumes. **Nine statement-level defects, two of them assertions the record's own text contradicts**: the heading's *diagram* is false at $16$ of the $71$ blocks by [brauer-pairing.md:98](../findings/brauer-pairing.md#L98), and the provenance note points at the one section of the file that explicitly disclaims the argument.

Reviewer r643, independent audit of [Lemma L65](../findings/brauer-pairing.md#L112), with its glance entry at [results.md:212](../results.md#L212), its detail entry at [results.md:614](../results.md#L614), its index row at [INDEX-results.md:79](../findings/INDEX-results.md#L79) and its report form at [07-gradedness-split.tex:950](../report/sections/07-gradedness-split.tex#L950). Derived cold from the definitions. **Analysis-only footing honoured: no run of any kind was made**, and nothing below rests on one. The concurrent reviewer's report and log were not opened.

---

## 0. The readings I adopt, and where each is defined

[conventions.md](../findings/conventions.md) **defines none of the five symbols the brief names.** Its object table runs from $\mathcal W_n$ to $\Delta$ and contains no row for $V$, $V_\lambda$, $\lambda$, $\mathrm{cup}$ or admissibility, and neither do its normalisation, pairing or "words with more than one meaning" sections. So the file that exists to be quoted has nothing to quote here, and every reading below is reconstructed from [brauer-pairing.md](../findings/brauer-pairing.md) itself or supplied by me.

| symbol | reading I adopt | where it is defined |
|---|---|---|
| $V$ | the defining $n$-dimensional real orthogonal representation of $O(n)$, carrying the metric | **nowhere on the record**, used bare at [:47](../findings/brauer-pairing.md#L47), [:50](../findings/brauer-pairing.md#L50), [:90](../findings/brauer-pairing.md#L90), [:92](../findings/brauer-pairing.md#L92), [:116](../findings/brauer-pairing.md#L116) and at [results.md:212](../results.md#L212) and [:616](../results.md#L616). **This is itself a finding** (D1 below) |
| $\lambda$ | a partition labelling an $O(n)$-irreducible occurring in $V^{\otimes12}$; the blocks are the $71$ $O(12)$ labels, with $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ | the range is fixed at [:13](../findings/brauer-pairing.md#L13); the labelling itself is never stated |
| $V_\lambda$ | the irreducible $O(n)$-module with that label, the traceless part of the Schur-functor image inside $V^{\otimes\lvert\lambda\rvert}$ | used at [:47](../findings/brauer-pairing.md#L47) and [:58](../findings/brauer-pairing.md#L58); never defined |
| $\mathrm{cup}$ | the invariant element $\sum_a e_a\otimes e_a\in V\otimes V$ | [:90](../findings/brauer-pairing.md#L90), in the parent section only. **The numbered block calls it "the pairing", which is its dual** (D6) |
| admissibility | $\lambda'_1+\lambda'_2\le n$, the classical condition for the $O(n)$-label $\lambda$ to be nonzero | [:92](../findings/brauer-pairing.md#L92). Correct as stated, and I take it as the definition throughout |

Two further conventions I must fix myself, because the numbered block fixes neither: the $12$ in $k=(12-\lvert\lambda\rvert)/2$ is the **leg count** $f$, set at [:44](../findings/brauer-pairing.md#L44) (three Weyl tensors, four legs each) and **not** the dimension $n$ (D3); and I read a `##` section as running to the next `##` heading and containing every subordinate `###`/`####` block in that span (§5).

---

## 1. Admissibility: what it is, which step eats it, and why it is vacuous where the programme lives

**The hypothesis is named and is consumed, this is neither the [L77](../findings/isotropy-cap.md) shape (named, never used) nor the [L75](../findings/isotropy-cap.md) shape (used, never named).** Exactly one step needs it: the existence of $\iota_\lambda$. For $O(n)$ the label $\lambda$ carries a nonzero module precisely when $\lambda'_1+\lambda'_2\le n$; outside that range $V_\lambda=0$, there is no inclusion to take, and the lemma's conclusion has no subject. Nothing else in the derivation touches it, equivariance and non-vanishing are indifferent to $\lambda$.

The witnesses the block gives are correct: $\lambda=(2,2)$ has $\lambda'=(2,2)$, so $\lambda'_1+\lambda'_2=4>3\ge n$ at $n=2,3$; $\lambda=(2,1,1)$ has $\lambda'=(3,1)$ and $4>3$ at $n=3$.

**But the block's characterisation of its own hypothesis is wrong in the direction that matters.** [:94](../findings/brauer-pairing.md#L94) says *"At $n=12$ it holds for all $71$ blocks, and it is **tight**: $\lambda=(2,2,2,2,2,2)$ sits at $\lambda'_1+\lambda'_2=12=n$, zero slack."* The equality is real; the word **tight** is not. For every partition, $\lvert\lambda\rvert=\sum_i\lambda'_i\ge\lambda'_1+\lambda'_2$. Every label occurring here has $\lvert\lambda\rvert\le f=12$. Hence at every $n\ge12$,

$$\lambda'_1+\lambda'_2\;\le\;\lvert\lambda\rvert\;\le\;12\;\le\;n,$$

so **admissibility cannot fail anywhere in the programme's range**, and no choice of block, however extreme, brings it closer to failing than the identity $\lvert\lambda\rvert\le n$ already guarantees. "Zero slack" reads as fragility and there is none: the first $n$ at which the hypothesis bites is $n=11$, below the range every claim of this programme is stated for. Where it genuinely does work is the sub-threshold verification cells at $n=2,3$, which is a real service, and is what the block should say.

**Consequence for the heading.** *"Under admissibility"* is honest as a statement about all $n$ and **vacuous as a qualifier on the programme's claims**. A reader who takes the qualifier at face value will believe there is a block-by-block side condition to discharge at $n=12$; there is not, and the one-line reason is above.

---

## 2. The construction, derived

Fix $n$ and an admissible $\lambda$ with $\lvert\lambda\rvert\le12$ and $\lvert\lambda\rvert\equiv12\pmod2$. Put $k=(12-\lvert\lambda\rvert)/2\in\mathbb Z_{\ge0}$ and

$$c_0:\;V_\lambda\;\xrightarrow{\ \iota_\lambda\ }\;V^{\otimes\lvert\lambda\rvert}\;\xrightarrow{\ (-)\otimes\mathrm{cup}^{\otimes k}\ }\;V^{\otimes\lvert\lambda\rvert}\otimes V^{\otimes 2k}=V^{\otimes12}.$$

- **Well defined.** The target degrees match exactly, $\lvert\lambda\rvert+2k=12$, which is what the formula for $k$ is for. Nothing else is needed.
- **Equivariant.** $\iota_\lambda$ is $O(n)$-equivariant by construction, and $\mathrm{cup}$ is $O(n)$-**invariant**: $(g\otimes g)\sum_a e_a\otimes e_a=\sum_a ge_a\otimes ge_a=\sum_b e_b\otimes e_b$ for any $g$ with $g^{\mathsf T}g=I$, reflections included. The tensor product of an equivariant map with an invariant vector is equivariant. The block's appeal to "closure of the tensor product under equivariant maps" at [:96](../findings/brauer-pairing.md#L96) is this, and the emphasis on the **full** $O(n)$ is correct and load-bearing: the whole realisation theorem is false for $SO$ and true for $O$ ([:52](../findings/brauer-pairing.md#L52)).
- **Non-zero.** For $0\ne x\in V_\lambda$, $\iota_\lambda(x)\ne0$ and $\mathrm{cup}^{\otimes k}\ne0$, so $\iota_\lambda(x)\otimes\mathrm{cup}^{\otimes k}\ne0$ over a field. One line, and it is the block's own first argument. **The cap computation is redundant, not confirmatory**: $\mathrm{cap}^{\otimes k}$ applied to the padding returns $n^k\iota_\lambda$, nonzero because $n>0$, a second proof of the same thing, and [:96](../findings/brauer-pairing.md#L96)'s claim that it *"proves the map nonzero rather than merely some contraction"* mis-ranks the two: the tensor-product argument already proves the map nonzero, and it is the **contraction** route that would have needed the extra step had it vanished.

So the composite exists, is equivariant and is nonzero: a nonzero element of $M_\lambda=\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})$ in closed form, at every $n$ where $\lambda$ is admissible. **The mathematics is correct and complete.**

### The parity and range constraints

Both are hypotheses of the formula and **neither is stated in the numbered block**.

| constraint | why it is needed | is it a real restriction? | stated where |
|---|---|---|---|
| $\lvert\lambda\rvert$ even | else $k\notin\mathbb Z$ and the formula is meaningless | **no**, $\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes12})\ne0$ forces $\lvert\lambda\rvert\equiv12\pmod 2$, since every up–down tableau of length $12$ changes $\lvert\cdot\rvert$ by $\pm1$ per step | [:13](../findings/brauer-pairing.md#L13), *sixty-nine lines above the block* |
| $\lvert\lambda\rvert\le12$ | else $k<0$ | **no**, same reason: a length-$12$ up–down tableau cannot reach past $\lvert\lambda\rvert=12$ | [:13](../findings/brauer-pairing.md#L13) |

**So the file already settles both**, [:13](../findings/brauer-pairing.md#L13) fixes $\lvert\lambda\rvert\in\{0,2,\dots,12\}$ for this certificate, which is the checklist's "does the block's own file already settle it", answered yes for the sixteenth-and-more time. This is a presentational gap in the numbered block, not a defect of the lemma: both constraints hold automatically for every $\lambda$ that labels a nonempty block, so **a silent parity here cannot bite the way the neighbouring refutation's did**. The block should still carry them, because the block is the quotable unit and [results.md:616](../results.md#L616) reproduces the formula with no range at all.

### Where the $12$ comes from

**It is $f$, the leg count**, fixed at [:44](../findings/brauer-pairing.md#L44): three Weyl tensors of four legs each. It is **not** the dimension. This matters twice:

- **The statement generalises in $n$ with no change.** $k=(f-\lvert\lambda\rvert)/2$ is independent of $n$, and the derivation above used $n$ only through $\mathrm{cup}$'s invariance and admissibility. So L65 holds at every $n$ for which the blocks exist, which is the whole of $n\ge12$, and more.
- **The collision is live and unmarked.** $n=12$ is this programme's headline dimension and appears in this same block's own admissibility discussion at [:94](../findings/brauer-pairing.md#L94) as *"$\lambda'_1+\lambda'_2=12=n$"*. A reader of the numbered block alone, or of [results.md:616](../results.md#L616), which reproduces $k=(12-\lvert\lambda\rvert)/2$ with no gloss, has no way to tell which $12$ is meant, and the two readings differ in exactly the way the brief anticipates: as $f$ the result is dimension-free, as $n$ it would be a statement about one dimension only.

---

## 3. "It need not be searched for"

**The payoff is real, and it does not need uniqueness.** The realisation theorem at [:47](../findings/brauer-pairing.md#L47) says $M_\lambda$ is irreducible over the image $\nu(B_{12}(n))$ and so is generated by **any** nonzero vector. Exhibiting one therefore suffices; there is nothing owed on uniqueness, and none is claimed in the body.

**But the seed is emphatically not unique, and three of the four places the result is recorded say it is.** $\dim M_\lambda=m_\lambda(n)$, which exceeds $1$ at most blocks, so $M_\lambda$ has a whole space of seeds. Worse, **$\iota_\lambda$ itself is not unique**: $\dim\operatorname{Hom}_{O(n)}(V_\lambda,V^{\otimes\lvert\lambda\rvert})$ is the number of standard tableaux of shape $\lambda$, which is $2$ already at $\lambda=(2,1)$. So *"**the** inclusion"* and *"**the** seed is the composite"* both presuppose a uniqueness that fails. Any choice works, so **the mathematics is unharmed**, but the definite articles at [:116](../findings/brauer-pairing.md#L116), [results.md:212](../results.md#L212), [results.md:616](../results.md#L616) and [07-gradedness-split.tex:951](../report/sections/07-gradedness-split.tex#L951) are wrong, and [results.md:616](../results.md#L616)'s *"one seed per block"* compounds it: the theorem's content is that **one seed suffices**, not that there is one.

**What the replaced search was, and what it cost.** The record states the alternative qualitatively and never prices it: [:88](../findings/brauer-pairing.md#L88) says that without the construction, *"finding a nonzero element of $\operatorname{Hom}(V_\lambda,V^{\otimes12})$ is the same construction problem the item started with, once per block"*, so $71$ instances, cost unstated. [ATTEMPTS.md:2500](../ATTEMPTS.md#L2500) prices a **different** search, the per-covariant expansion ($184$ separate problems, $33{,}177{,}600$ terms in the widest pairing), which L65 does not remove. **So the payoff is unquantified**, and the block does not say so.

**The scope of the payoff is stated correctly downstream.** [:108](../findings/brauer-pairing.md#L108) is explicit, *"The lemma removes the search for a seed and leaves the search for an expansion"*, with obligation (ii) still open behind a spanning set of $23!!=316{,}234{,}143{,}225$ elements, and [results.md:616](../results.md#L616) hedges it as *"removes a search from the certificate pipeline and adds no certificate"*, as does [07-gradedness-split.tex:958](../report/sections/07-gradedness-split.tex#L958). **The numbered block itself carries no such hedge**: read alone, *"so it need not be searched for"* invites the reading that the construction problem is closed. That the surrounding section is the very section titled "What stays open" mitigates it in the file and not in the two places the block is quoted from.

---

## 4. Scope, blast radius, and the transfer question

**Nothing consumes L65.** A grep for citations of the number outside its own file finds it only in [results.md:212](../results.md#L212), [results.md:614](../results.md#L614), [INDEX-results.md:79](../findings/INDEX-results.md#L79), [INDEX.md:40](../findings/INDEX.md#L40) and the report, every one of them a restatement, none a use. **And the route is dormant**: [plan.md](../plan.md) contains no occurrence of *obligation*, *A2*, *sextic* or *Sym^3*, and no live item depends on the diagram-realisation chain. So any defect here is contained inside [brauer-pairing.md](../findings/brauer-pairing.md) and its three restatements.

**L65 does not inherit [L64](../findings/fence-posts.md#L227)'s GAP.** L64, the transfer mechanism, returned **GAP** at Gate 2 by [r599](REVIEW_r599.md) and [r600](REVIEW_r600.md), *true with no known satisfiable instance* because $k_B$ is only lower-bounded, is a statement about extending an $O(n_0)$-invariant along $\{B_n\}$ to larger $n$. L65 uses **no** transfer: it is a construction at a single fixed $n$, and the only invariant-theoretic input anywhere in its chain is the classical First Fundamental Theorem for $O(n)$, which holds at every $n$ with no threshold ([:50](../findings/brauer-pairing.md#L50), [:58](../findings/brauer-pairing.md#L58)) and is the one hypothesis of the realisation theorem the file names as load-bearing. The two share the letters FFT and nothing else. **No inheritance.**

---

## 5. Provenance, the numbering is clean, the pointer is not

I use the reading that a `##` section runs to the next `##` heading and contains every subordinate `###`/`####` block inside that span. **The finding below is independent of that choice**, and I say why.

| clause of the note at [:114](../findings/brauer-pairing.md#L114) | verdict |
|---|---|
| *"the result was numbered in [report/](../report/)"* | **TRUE**, [07-gradedness-split.tex:950](../report/sections/07-gradedness-split.tex#L950) carries `\begin{Lem}{65}`, and `86621751` is the commit that back-filled the $24$ report-only numbers into findings on 2026-08-31 |
| *"the mathematics has always been in this file"* | **TRUE**, `git log -S` on the distinctive `cup}^{\otimes k}` and on *"the seed is the composite"* returns `e0b9cb0c` (2026-08-30), whose diffstat touches exactly [brauer-pairing.md](../findings/brauer-pairing.md) and [run_seed_is_a_diagram.py](../scripts/runs/run_seed_is_a_diagram.py). No other findings file has ever carried it; the only other hits are reviews. **This is one of the clean copies** of the boilerplate the r606 audit found false elsewhere |
| *"it carried no block"* | **TRUE**, the `####` block dates from `86621751`, the mathematics from a day earlier |
| *"the argument is in this file under **The diagram-realisation theorem (one seed per block**"* | **FALSE**), see below |

**The pointer names the wrong section, and the named section disclaims the argument in its own opening sentence.** The file's headings sit at [:40](../findings/brauer-pairing.md#L40) `## The diagram-realisation theorem, one seed per block` and [:86](../findings/brauer-pairing.md#L86) `## The seed is itself a diagram`. L65's argument (the construction, the equivariance, the non-vanishing, the admissibility hypothesis), is [:88](../findings/brauer-pairing.md#L88)–[:98](../findings/brauer-pairing.md#L98), inside the **second**. The first spans [:40](../findings/brauer-pairing.md#L40)–[:84](../findings/brauer-pairing.md#L84) under my reading and [:40](../findings/brauer-pairing.md#L40)–[:53](../findings/brauer-pairing.md#L53) under the narrow one; **under both, it excludes the argument**. And the section the pointer names opens the sibling section's first line with the exact denial: *"The realisation theorem says one nonzero seed per block generates that block, and **says nothing about where a seed comes from**."*

So the pointer resolves to an existing heading and to the wrong mathematics, the theorem that consumes the seed rather than the lemma that builds it. It is the same family as [L64](../findings/fence-posts.md#L227)'s false pointer, introduced by the same commit `86621751`, and it is one heading away from correct.

---

## 6. The heading asserts what the file refutes

**"The seed is a diagram" is false at $16$ of the $71$ blocks, and the correction is nine lines above the block that carries the title.** [:98](../findings/brauer-pairing.md#L98) states it outright: *"It is a **padding** diagram only where $k>0$, at the $16$ blocks with $\lvert\lambda\rvert=12$ ($17$ of the $184$ multiplicities) $k=0$, there is no cup at all, and the content there is that an inclusion is nonzero."* [07-gradedness-split.tex:955](../report/sections/07-gradedness-split.tex#L955) repeats the correction, *"At $16$ of the $71$ blocks the seed is not a padding diagram, so that description is wrong there"*, and both were the r263/r264 repair, folded into the prose in `29b8dcc2` and `ef6ed9e0`.

**The heading was never repaired, and it is the part that propagates.** The title *"the seed is a diagram, under admissibility"* is carried verbatim at [:112](../findings/brauer-pairing.md#L112), [results.md:212](../results.md#L212), [results.md:614](../results.md#L614), [INDEX-results.md:79](../findings/INDEX-results.md#L79) and [07-gradedness-split.tex:950](../report/sections/07-gradedness-split.tex#L950), and [results.md:616](../results.md#L616) hardens it into the body as *"one seed per block, **given by a diagram**"*, the one restatement that puts the refuted description inside the statement rather than the title.

**The imprecision runs deeper than the $k=0$ blocks.** Even where $k>0$, $c_0$ is not a Brauer diagram: a diagram is a morphism between tensor powers of $V$, whereas $c_0$ has source $V_\lambda$, which is not an object of the Brauer category at all. The accurate description is the one the statement's own body gives (**an inclusion tensored with $k$ cups**), of which only the second factor is diagrammatic. What is true, and is what the route needs, is that $c_0$ is written in closed form with no search.

---

## 7. The defects, ordered

| # | defect | severity |
|---|---|---|
| D1 | **$V$ is defined nowhere on the record.** The whole statement is about maps into $V^{\otimes12}$, and [conventions.md](../findings/conventions.md) has no row for it; nor do $V_\lambda$, $\lambda$ or $\mathrm{cup}$, and $\mathrm{cup}$ and admissibility exist only in the parent section of one file | real, a symbol defined nowhere, per the brief |
| D2 | **The heading's "diagram" is false at $16$ of $71$ blocks**, by [:98](../findings/brauer-pairing.md#L98) and [07-gradedness-split.tex:955](../report/sections/07-gradedness-split.tex#L955); [results.md:616](../results.md#L616) promotes it into the statement body | real, a numbered title contradicted by its own file |
| D3 | **The $12$ in $k=(12-\lvert\lambda\rvert)/2$ is unmarked**, and $n=12$ appears nine lines away. It is $f$, and the result is dimension-free | real, collision of the record's two live $12$s |
| D4 | **The provenance pointer names the wrong `##` section**, under either containment reading, and the named section's first line disclaims the argument | real |
| D5 | **"Tight … zero slack" mischaracterises admissibility.** $\lambda'_1+\lambda'_2\le\lvert\lambda\rvert\le12\le n$ makes it unfailable at every $n\ge12$; it first binds at $n=11$ | real, overstates a hypothesis that is vacuous in range |
| D6 | **"let $\mathrm{cup}$ be the pairing"** at [:116](../findings/brauer-pairing.md#L116) and [results.md:616](../results.md#L616) names the dual object. $\mathrm{cup}\in V\otimes V$ is the co-pairing; the pairing is the cap, and using it would *lower* the degree instead of padding to $12$. [:90](../findings/brauer-pairing.md#L90) has it right, *"the invariant metric element"* | minor, but it is the definition the block supplies |
| D7 | **"The inclusion", "the seed", "one seed per block"** presuppose uniqueness that fails: $\dim M_\lambda=m_\lambda(n)>1$ generally, and $\iota_\lambda$ is already non-unique at $\lambda=(2,1)$ | minor, no step depends on it |
| D8 | **Parity and $\lvert\lambda\rvert\le12$ appear in neither the block nor [results.md:616](../results.md#L616)**, though [:13](../findings/brauer-pairing.md#L13) settles both and both are automatic | presentational |
| D9 | **The replaced search is unpriced** and the block does not say so; the numbered block also drops the *"leaves the search for an expansion"* hedge that [:108](../findings/brauer-pairing.md#L108) supplies | presentational |

**What is owed, and it is all reachable by editing.** D1 needs rows in [conventions.md](../findings/conventions.md) for $V$, $V_\lambda$, $\mathrm{cup}$ and admissibility. D2 needs the title changed to what the body proves (*the seed is an inclusion padded by cups*), in five places. D3 needs one word ($f=12$). D4 needs one heading swapped. D5 needs [:94](../findings/brauer-pairing.md#L94)'s last clause replaced by the one-line reason the hypothesis cannot fail at $n\ge12$. **None of it touches the mathematics**, which stands as derived in §2.

---

*No computation of any kind was performed for this review; the analysis-only footing was in force throughout and the screening allowance was not needed.*
