# ROUND_L11, which two-block sphere products are Morse–Bott nondegenerate

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `BROKEN`, repaired, impact `PROPAGATES`. **Verifiers:** v170, v171, v172.

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md) lines 393–395 |
| Landscape statement | [results.md](../results.md) line 130 |
| Index row | [INDEX-results.md](../findings/INDEX-results.md) line 26 |
| The block | [nondegeneracy.md](../findings/nondegeneracy.md) lines 434–452 |
| Brief | [BRIEF_L11.md](BRIEF_L11.md) |

## The finding from phase 0: the block contradicts itself in consecutive paragraphs

**Its first blockquote**, stamped *corrected 2026-09-04* and carrying a Gate 2 attribution, says: *"**The single degenerate case is $(3,3)$.** A correction recorded here on 2026-09-04 named $\min(p,q)=2$ as a second degenerate family, and that is wrong: at $p=2$, $\mu=\tfrac12+\tfrac1{2(n-3)}$ is **strictly above** $\tfrac12$, which costs the point its **maximality** and not its nondegeneracy."*

**Its second blockquote, immediately below**, says: *"**THE OLD STATEMENT NAMED ONLY $S^3\times S^3$ AND WAS FALSE AT $p=2$**, [Lemma L26](../findings/nondegeneracy.md) records that the dangerous eigenvalue **reaches** $\tfrac12$ at $p=2$ with excess $\tfrac1{2(n-3)}>0$, a direction outside the orbit carrying the orbit's own eigenvalue, which is degeneracy."*

**These are contradictory, they cite the same closed form, and one of them reads an excess above $\tfrac12$ as attaining $\tfrac12$.** The block's own proof paragraph agrees with the first: *"the two failures are different failures … at $\min(p,q)=2$, $\mu>\tfrac12$ and the point is nondegenerate but not a maximiser."*

**And the refuted reading is what reached the rest of the record.** [results.md](../results.md)'s heading says *"degenerate at $\min(p,q)=2$ and at $(3,3)$"*; its landscape bullet says *"TWO exceptional families, not one"*; [INDEX-results.md](../findings/INDEX-results.md) says *"two exceptional families, not one"*. **The correction reached one blockquote and nothing else, and left its own contradiction standing beneath it.**

## What the verifiers are asked beyond the standing list

Which of the two readings is right, decided from [L26](../findings/nondegeneracy.md)'s closed form $\mu=\frac{n-2}{2(p-1)(q-1)}$ and the definition of Morse–Bott nondegeneracy, *not* from either blockquote. Whether $(p-2)(q-2)>1$ is the right criterion and what it gives at $p=2$, at $(3,3)$, and at $p=1$. Whether the $(3,3)$ exception's representation-theoretic explanation is a mechanism or a coincidence of dimension. And what the trailing prose's *"36 splits up to $n=14$"* and *"exact arithmetic at eight"* establish, given that $S^7\times S^7$ *"rests on floating point"*.

## Clustering, all three in, all `BROKEN`, unanimous

**`BROKEN`.** *The mathematics of the theorem is sound; the statement the rest of the record cites is not.*

### The contradiction, settled from the arithmetic

**The corrected paragraph wins, and the losing one is self-refuting inside its own sentence.** At $p=2$, $\mu=\frac{n-2}{2(n-3)}=\tfrac12+\frac1{2(n-3)}$, **strictly above $\tfrac12$ at every $n\ge5$**, and *"an excess $\frac1{2(n-3)}>0$" is precisely the statement $\mu\ne\tfrac12$*, so that direction cannot be carrying the orbit's own eigenvalue. **The word doing the damage is "reaches"**, inherited from [L26](../findings/nondegeneracy.md), where it means *reaches the threshold* $\mu\ge\tfrac12$, the quantity L26's criterion characterises. *Read as "attains the value", it inverts the finding.* And since $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$, an eigenvalue **above** $\tfrac12$ off the orbit is a strictly positive Hessian direction: **it costs maximality and contributes nothing to the kernel.**

| id | finding | support |
|---|---|---|
| **K1** | the refuted clause stands in **three of four** places, [results.md](../results.md) at both its heading and its landscape bullet, and [INDEX-results.md](../findings/INDEX-results.md). *The correction reached one bordered box* | v170 |
| **K2** | **the correction's own replacement is unproven.** Its $S^2\times S^4$ witness reads [L27](../findings/nondegeneracy.md)'s ten values off a decomposition whose genuine dimensions sum to **$86$ against $\dim\mathcal W_6=84$**, the failure [L27](../findings/nondegeneracy.md) and [L128](../findings/second-order.md) both record. *The trace check $\mathop{\mathrm{tr}}L_e=0$ passes anyway, because the fictitious $\mathrm{Weyl}_2$ summand carries $L_e=0$.* **The multiplicity-$8$ claim is a lower bound presented as an equality**, the error [L26](../findings/nondegeneracy.md) itself warns against | v170 |
| **K3** | **the $(3,3)$ mechanism: the box is right and the trailing prose is stale.** Under $O(3)$, $\Lambda^2(\mathbb R^3)\cong\mathbb R^3\otimes\det\not\cong\mathbb R^3$ (*by character, $+3$ at $-I$ against $\mathbb R^3$'s $-3$*) so the summands are non-isomorphic in the group [L27](../findings/nondegeneracy.md)'s multiplicity-freeness lives in, **and isomorphic summands would not force equal scalars regardless**. **And the dimension coincidence occurs elsewhere without degeneracy**: $\binom k2\binom l2=kl\iff(k-1)(l-1)=4$, giving $(3,3)$ **and $(2,5)$**, and $(2,5)$ is nondegenerate at $\mu=\tfrac58$. *The refuted mechanism stands a **third** time outside the block* | v170, v172 |
| **K4**, **AND THE DISPUTE IS A SCOPE COLLAPSE** | **the ambient dimension is a gap, and it is why the two paragraphs disagree.** No form of L11 names $n$, and the proof covers only $n=p+q$. **[L126](../findings/second-order.md) gives a padded four-set at $\frac1{2(p-1)}=\tfrac12$ exactly at $p=2$**, *so the refuted paragraph is **right about padded $S^2\times S^q$** and wrong about the native one.* **The repair is therefore stronger than deletion**: each paragraph is true of a different object, and the block names no dimension anywhere. *Padded $(3,q)$ with $q\ge4$ is untested* | v170, v172 |
| **K7** | **the seed is upstream, in [L26](../findings/nondegeneracy.md)'s own prose**: *"the family reaches $\tfrac12$ exactly at $p=2$"*, used loosely for its **displayed** $\mu\ge\tfrac12$. **That word propagated into all three canonical sites, stripped of the display that fixed its meaning** | v172 |
| **K8** | **a closed-form counterexample at $(2,2)$.** [L26](../findings/nondegeneracy.md)'s own recorded spectrum $(-1)^4,(\tfrac12)^4,1^2$ sums to $10=\dim\mathcal W_4$, with $\dim E(\tfrac12)=4=\dim\mathcal O$ and $\mu_{2,2}=1$ supplying the non-simple $1$: **nondegenerate, and a saddle.** *One member refutes the universal clause* | v172 |
| **K9** | **the replacement claim is circular as well as unproven.** Its cited corroboration [L128](../findings/second-order.md) **cites L11 back for the same fact**. The single missing statement is that the $L_e$-spectrum of $\mathcal D_n\cap W^\perp$ at $S^2\times S^q$ omits $\tfrac12$, *which [L127](../findings/second-order.md) already flags as unrepaired* | v172 |
| **K5** | *"exact arithmetic at eight"* **names seven**, and the omitted one is $(2,6)$, *the only exact-arithmetic evidence bearing on the disputed family.* *"Over $\mathbb Q$ at $n=6$"* has no split attached; *"all $36$ splits"* includes $(3,3)$, which the next paragraph calls the exception; and $S^7\times S^7$ *"rests on floating point"* is stale, $\tfrac12-\mu=\tfrac13$ there being proved symbolically five lines below | v170 |
| **K6** | $\mu$ is a **fourth** untabled meaning of a letter [conventions.md](../findings/conventions.md) already flags as carrying three, and the Morse–Bott definition itself is absent from that file | v170 |

**Cleared:** $p=1$, outside every hypothesis; odd $n$; the $(3,4)$ and $(3,5)$ gap formulas; the orbit dimension $pq$ at every $p,q\ge1$; [L24](../findings/second-order.md)'s maximiser hypothesis, which is not imported; and the $SO$-versus-$O$ mismatch, handled by [L27](../findings/nondegeneracy.md).

## Adjudication

**Verdict `BROKEN`, repaired. Impact `PROPAGATES`.** Three verifiers, one verdict, and they agree on every step: **the theorem is sound and the statement the record cites is not.**

### The contradiction was a scope collapse, and both paragraphs were partly right

**At $n=p+q$ the corrected reading holds**: $\mu=\tfrac12+\frac1{2(n-3)}$ at $p=2$ is strictly above $\tfrac12$, and since $\mathrm{Hess}_SP=6\theta(L_e-\tfrac12\mathrm{Id})$ that is an ascent direction, it costs maximality and contributes nothing to a kernel that lives **at** $\tfrac12$. **At a padded dimension the refuted reading holds**: [L126](../findings/second-order.md)'s padded four-set carries $\frac1{2(p-1)}$, exactly $\tfrac12$ at $p=2$, and counting those orbit-free blocks gives $q(n-n_0)$, $4(n-4)$ at $S^2\times S^2$, **reproducing the recorded excesses exactly**. *Neither paragraph named a dimension, and the block names none anywhere.*

### The seed is one loose word, and it is upstream

[L26](../findings/nondegeneracy.md)'s prose read *"the family reaches $\tfrac12$ exactly at $p=2$"*, loose for its own displayed criterion $\mu\ge\tfrac12\iff(p-2)(q-2)\le1$. **Quoted away from the display, "reaches" reads as "attains"**, and a threshold failing became a value holding. *The paragraph that drew that inference refuted itself in its own sentence: an excess $\frac1{2(n-3)}>0$ is precisely the statement $\mu\ne\tfrac12$.*

### The correction was unproven, and circular

**Nondegeneracy at $\min(p,q)=2$ has no argument on file.** [L27](../findings/nondegeneracy.md) excludes $q\le2$ by name (*"the decomposition itself is false"*), [L126](../findings/second-order.md) and [L127](../findings/second-order.md) both say the summand route does not reach it, and **[L128](../findings/second-order.md) cites L11 for $S^2\times S^4$ while this block cited L128**. The missing statement is named: *the $L_e$-spectrum of $\mathcal D_n\cap W^\perp$ at $S^2\times S^q$ omits $\tfrac12$*, which [L127](../findings/second-order.md) already flags as unrepaired.

**And its witness is right by a route its own source disclaims.** The $S^2\times S^4$ decomposition sums to $86$ against $\dim\mathcal W_6=84$; **the over-count is exactly one summand, $S^2_0(\mathbb R^2)$ of dimension $2$ at value $0$.** Deleting it gives $84$, $\mathop{\mathrm{tr}}L_e=0$, and $\tfrac12$ at multiplicity $8=pq$, and the same repair at $(2,2)$ reproduces that spectrum verbatim. *The trace check passed on the uncorrected decomposition because the fictitious summand carries $L_e=0$, it could not have caught this.*

### The repairs, all applied

| finding | what changed |
|---|---|
| K1 | the refuted clause struck from [results.md](../results.md)'s heading, its landscape bullet and [INDEX-results.md](../findings/INDEX-results.md); **all four sites now carry $n=p+q$ and the padded case** |
| K7 | [L26](../findings/nondegeneracy.md)'s *"reaches"* replaced by the two cases stated apart, with the reason they must never be collapsed |
| K2, K9 | the debt stated with the circle named, and the $86$-against-$84$ over-count given with its exact one-summand repair |
| K3 | the $(3,3)$ mechanism refuted **in both places it stood**, by character under $O(3)\times O(3)$, and by $(2,5)$ carrying the same dimension coincidence without degeneracy; the closed form is named as what decides it |
| K4 | the dimension is in the statement in all four sites |
| K5 | the eighth exact-arithmetic split named (**$(2,6)$, the only $\min(p,q)=2$ entry and the one bearing on the dispute**) and $S^7\times S^7$'s *"rests on floating point"* replaced by $\tfrac12-\mu=\tfrac13$ |
| K6 | Morse–Bott nondegeneracy and $\mu$ tabled in [conventions.md](../findings/conventions.md), the definition having been absent while the block carried two readings of it |
| K8 | the $(2,2)$ witness recorded, non-maximal and nondegenerate at once |

### Queued elsewhere

**Research loop.** That the $L_e$-spectrum of $\mathcal D_n\cap W^\perp$ at $S^2\times S^q$ omits $\tfrac12$, the one statement that would close nondegeneracy at $\min(p,q)=2$ and break the circle. And padded $(3,q)$ with $q\ge4$, untested at every padding.
