# ROUND_L26, the dangerous eigenvalue of the two-block spectrum, in closed form

**Date:** 2026-09-07. **Phase:** 1, dispatched. **Verifiers:** v197, v198, v199.

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md) lines 429–435 |
| Landscape statement | [results.md](../results.md) line 138 |
| The block | [nondegeneracy.md](../findings/nondegeneracy.md) lines 78–96 |
| Brief | [BRIEF_L26.md](BRIEF_L26.md) |

## The finding from phase 0, and this audit made it

**[ROUND_L11](ROUND_L11.md) traced L11's inversion to one loose word in this lemma's prose, *"the family **reaches** $\tfrac12$ exactly at $p=2$"*, loose for the displayed threshold $\mu\ge\tfrac12$, and repaired it in the findings block, which now separates the two binding cases and says why they must never be collapsed.**

**[results.md](../results.md) line 433 still carries the original sentence.** *The repair reached the source and not its copy*, which is the defect this audit has recorded at L05, L24, L11, L47 and L48, committed here by the audit itself, hours after documenting it.

**So the round has both readings on the record right now**: the findings block distinguishing *exceeds* at $p=2$ from *equals* at $(3,3)$, and the canonical entry saying *reaches* for both.

## The brief went out truncated, and one verifier caught it

The first dispatch's section C stopped at *"as free symbols, the same"* and cut the four lines that finish the argument, the three-block form $\lambda=\tfrac12(\varepsilon_{PP}+\varepsilon_{QQ})-\varepsilon_{PQ}$, the sentence saying criticality enters through $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$, and the whole *What it does not reach* paragraph. **Those four lines carry three of the six claims the round was convened to test**: whether criticality is unused, whether the computation covers any three-block diagonal operator, and the direction of the bound. The round file recorded the source as lines 78-96; the block runs to 106.

[v198](VERIFY_v198.md) logged the truncation at its second tool round. The brief was completed to lines 78-106, the Sources paragraph held back so no prior verdict reaches a verifier, and all three were told to re-check those three claims against the restored passage and to record that they read an incomplete text first.

**This is [ROUND_L44](ROUND_L44.md)'s defect repeated**, a brief whose extract stops short of the passage the round exists to test, cutting the paragraph under audit while looking complete.

## What the verifiers are asked beyond the standing list

Whether $X=\phi_\pi\odot\phi_\rho$ with its $\Lambda^4$ component removed is in $\mathrm{Weyl}_n$ and whether **its Ricci part vanishes because its support is disjoint index pairs**; whether $e\circ X=\mu X$ with $\mu=\tfrac{n-2}{2(p-1)(q-1)}$, and $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$; whether the coefficients $\tfrac23,\tfrac13,-\tfrac13$ and $\lVert X\rVert^2=\tfrac43$ are right; **whether criticality really is unused and the result holds for any three-block diagonal operator**; and whether the gap clause's exception is exactly $(3,4)$, *the comparison $\lambda_{\max}<\mu$ clearing to $(p-2)(q-3)<2$, which over $q\ge p\ge3$ admits only $(3,3)$ and $(3,4)$.*

**And the standing question**: the lemma bounds $\lambda_{\max}$ **from below only**, and [L11](../findings/nondegeneracy.md) and [L133](../results.md) both consume it, say what each may cite.

## Adjudication

**Verdicts: [v197](VERIFY_v197.md) `HYPOTHESIS-DEBT`, [v198](VERIFY_v198.md) `PROVEN, hypotheses corrected`, [v199](VERIFY_v199.md) `PROVEN, hypotheses corrected`. Round verdict: `PROVEN, hypotheses corrected`, impact `CONTAINED`.** The split is over one cluster, C4, and it closes: v197 withheld the verdict because the gap clause was cited to nothing, and the citation is now written in.

**The mathematics is unanimous and was rebuilt three times from the definitions.** Each verifier derived Weyl membership, the coefficients, $e\circ X=\lambda X$ for a free three-block diagonal operator, the collapse to $\mu$, the threshold, the excess, the factorisation and the lattice count independently, and none used a script. Two of the three replaced the block's finite enumeration with a closed-form support argument reaching $n=4$; **that argument stays in their reports and out of the record**, since a verifier's own derivation entering under a check's letterhead is unaudited proof.

| id | step attacked | mechanism | support | outcome |
|---|---|---|---|---|
| **C1** | the whole algebra of the lemma | independent re-derivation | 3/3 | `CONFIRMED`, no defect |
| **C2** | *"reaches $\tfrac12$ exactly at $p=2$"* | one word covering a strict excess and an equality | 3/3 | `CONFIRMED`, repaired at both canonical sites |
| **C3** | *"criticality is unused"* | true of the eigenvector and of $\lambda$, false of the displayed $\mu$ | 3/3 | `CONFIRMED`, repaired |
| **C4** | the gap clause | a whole-spectrum upper bound inside a lemma whose next paragraph says it gives lower bounds only | 3/3 | `CONFIRMED`, cited to L27 at both sites |
| **C4b** | L27's range against Nienhaus's | $(3,3)$, $(3,4)$, $(3,5)$, $(4,4)$ said to fall outside $p,q\ge5$ | 1/3 | **`REFUTED` at source** |
| **C5** | $\lambda_{\max}$ | three senses in one file, one of them defined nowhere in it | 2/3 | `CONFIRMED`, named at the site, tabled in conventions |
| **C6** | $Q(W_{p,q})=\frac{n-1}{pq}W_{p,q}$ | a raw-representative relation read as a unit-sphere $\theta$ | 3/3 | `CONFIRMED`, tabled |
| **C7** | the factored criterion | order-dependent, and quoted without its ordering it misreads a tie as an exception | 3/3 | `CONFIRMED`, clause added |
| **C8** | *"a single lattice point in the region the inequality closes off"* | the stated reason the five splits missed $(3,4)$ | 2/3 | **`REFUTED`, the record's own explanation is false** |

### C4b, refuted at source

v197 held that the gap clause's range exceeds its citation's, $(3,3)$, $(3,4)$, $(3,5)$ and $(4,4)$ falling outside Nienhaus's $p,q\ge5$. **Read at source, the thesis carries two decompositions with different ranges.** Proposition 4.6 decomposes $S^2(\mathfrak{so}(n))$ under *"$k,l\ge5$, $k,l\ne6$"*; the ten-summand $\mathrm{Weyl}_n$ display summarising it closes with *"orthogonal and irreducible under the $SO(k)\times SO(l)$-action for any $k,l\ge5$. Furthermore, it is irreducible under the action of $O(k)\times O(l)$ for any $k,l\ge3$."* **The wider clause is the one L27 uses, and it covers every split the gap clause names.**

**v198's version of the same cluster survives and is the useful one**: the record cited *"Proposition 4.6"* for a statement belonging to the display, and reproduced its range as $p,q\ge5$ while dropping $k,l\ne6$, attaching a restriction the statement in use does not carry, and hiding which of the two was being claimed. **Both citation sites are rewritten and the two ranges are now quoted side by side in the [reference notes](../references/nienhaus-2023-second-best-einstein/notes.md), which held only Proposition 4.6.**

**This discharges a debt standing against [ROUND_L27](ROUND_L27.md)** (*"the orbit dimension at $\min(p,q)\in\{3,4\}$, whose only source carries $k,l\ge5$"*) which was the same misquote read from the other side.

### C8, and what the five splits actually missed

The block explained the earlier scans' failure to find $(3,4)$ by the exception being *a single lattice point in a thin region*. **Both halves are wrong, by two independent mechanisms the verifiers found separately.** Every one of the five splits $(3,5)$, $(4,4)$, $(3,7)$, $(5,5)$, $(4,6)$ has $n\ge8$ and $(3,4)$ has $n=7$: it lay below the range scanned, not inside it. And two of the five sit on the exact equality locus $(p-2)(q-3)=2$, at $(3,5)$ and $(4,4)$ the second-largest eigenvalue is attained twice, $\mu=\lambda_{\max(p,q)}$ at $\tfrac38$ and $\tfrac13$, so they did not miss a point at distance; they landed on the boundary and read a tie as a non-event. **A false explanation of a past miss is worse than none, because it says the region was searched.**

### The phase 0 finding, repaired

[results.md](../results.md)'s canonical statement now separates the two binding cases, says $\min(p,q)=2$ rather than $p=2$, names $\lambda_m=\frac{m-2}{2(m-1)}$ where it had written $\lambda_{\max(p,q)}$, and attributes the gap clause to L27. The landscape line carries the same separation and the qualified criticality claim.

### What the round did not touch

**The direction of the bound is used correctly by both consumers.** [L11](../findings/nondegeneracy.md) takes only the closed form and attributes the upper bound to L27 by name; [L133](../results.md) takes $X$ as a witness and carries its own supremum argument. *The one place the direction was violated was inside L26 itself, by its own gap clause*, which is C4, now cited.

