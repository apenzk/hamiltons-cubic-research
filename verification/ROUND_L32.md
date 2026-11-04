# ROUND_L32, a bivector's centraliser collapses to a line

**Date:** 2026-09-07. **Phase:** 6, closed. **Verdict:** `GAP`, repaired, impact `NARROWS`. **Verifiers:** v167, v168, v169.

**Entered at the head of tier 2 by [ROUND_L33](ROUND_L33.md)**, whose three verifiers each found the same hole here. *A dependency checked before its dependents.*

## Sources, verbatim

| what | where |
|---|---|
| Canonical statement | [results.md](../results.md) lines 465–469 |
| Landscape statement | [results.md](../results.md) line 150 |
| The block | [isotropy-cap.md](../findings/isotropy-cap.md) lines 74–110 |
| What [ROUND_L33](ROUND_L33.md) found | its clustering table, entries H3 and H6 |
| Brief | [BRIEF_L32.md](BRIEF_L32.md) |

## Findings from phase 0

**1. The statement has three different forms on the record.** [isotropy-cap.md](../findings/isotropy-cap.md)'s Statement paragraph reads *"Let $x\in\mathfrak{so}(m)$ be nonzero"* with **no restriction at all**, the refuted form, standing under a blockquote that declares it refuted. [results.md](../results.md) carries $m\ne3$. The blockquote itself says what is needed is $\mathfrak c\ne0$. *The block's own note records that a reviewer named the results.md line for repair and it was missed; the findings line was missed too, and it is the canonical one.*

**2. The proof's main branch is written for even $m$ and never says so.** It sets $p=m/2$, takes $\mathfrak t$ to be a maximal torus of $x$'s coordinate $2$-planes, and turns on *"every root of $D_p$ is $\pm e_i\pm e_j$ and so has $p-2$ zero coordinates"*. **At odd $m$ the algebra is $B_p$**, which has short roots $\pm e_i$, and that sentence is false.

**3. The degenerate branch is one sentence, and [ROUND_L33](ROUND_L33.md) showed it is empty where it is needed.** *"For degenerate $x$ the same argument runs inside the support, with $\mathfrak z(\mathfrak c)$ additionally centralising $\mathfrak{so}(\ker x)$"*, and $\mathfrak{so}(\ker x)=0$ when $\dim\ker x=1$. **Corank $1$ is the generic odd-$m$ case**, and [LEDGER.md](../findings/LEDGER.md) prescribes exactly this branch as the repair.

**4. The block says its own consumer is unchecked.** *"The one use on the record, in [stratum-two-negative.md](../findings/stratum-two-negative.md), is at $n\ge12$ where the hypothesis is expected to hold, expected, and not yet checked there."*

**5. The Gate 2 that passed it tested multiplicity partitions, not the corank-$1$ configuration.** *"At all $29$ multiplicity partitions to $m=12$ and at $m=14,16$ on the hard patterns"*, a sweep over patterns, which is evidence and not a proof, and which the round below is forbidden to repeat.

## Clustering, all three in; two `GAP` against one `PROVEN, hypotheses corrected`, unanimous on the mathematics

**`GAP`.** *The statement is true and sharp in the $m\ne3$ form, exception clause included; the proof on file reaches even $m$ with $\ker x=0$, $p\ge2$, and degenerate $x$ with $\dim\ker x\ge2$.*

### The three forms, settled

**$m\ne3$ is correct and sharp. $\mathfrak c\ne0$ is true and not sharp**, the two part at exactly $m=2$, where the conclusion holds while $\mathfrak c=0$, since $\mathfrak c=0\iff m\in\{2,3\}$. **The unrestricted form is false.** *So [results.md](../results.md) carries the right one and the canonical findings block carries the false one.*

| id | finding | support |
|---|---|---|
| **J1** | [isotropy-cap.md](../findings/isotropy-cap.md)'s own **Statement** line carries the refuted unrestricted form, under a blockquote declaring it refuted; [INDEX-results.md](../findings/INDEX-results.md) carries the true-but-not-sharp $\mathfrak c\ne0$ | v169 |
| **J2** | **the even-$m$ branch is a defect of exposition, not of mathematics.** $\ker x=0$ already forces $m$ even, so the branch is correctly delimited, *but the reader is never told that **every** odd $m$ falls to the one-sentence degenerate branch*, which is where the gap is | v169 |
| **J3** | **corank $1$ confirmed independently.** $\mathfrak{so}(1)=0$, so the branch's only stated ingredient is vacuous and nothing excludes the off-diagonal $V\otimes K$ summand | v169 |
| **J4**, **A REPAIR THIS SESSION MADE, REFUTED** | **the $B_p$ reason is wrong, and [ROUND_L33](ROUND_L33.md) wrote it into [stratum-two-negative.md](../findings/stratum-two-negative.md) hours ago.** *At corank $1$ there is no padding*: $m=2p+1$ with $\mathop{\mathrm{rank}}x=2p$, so $a$ fills $\mathbb R^p$ with **no zero coordinate**, and every $B_p$ root, long with $p-2$ zeros, short with $p-1$, is excluded at $p\ge3$. **The instance that round named, $x=\varphi_{12}+2\varphi_{34}+3\varphi_{56}$ at $m=7$, closes at $\mathbb Rx$ both ways.** And its $\mathfrak{so}(5)$ example has **corank $3$**, imported from [L81](../findings/isotropy-cap.md) where it is correctly deployed against the *padded* case. *The $\mathfrak{so}(\ker x)$ clause is genuinely vacuous at $\dim\ker x=1$, that half stands; the stated reason it cannot be rescued does not* | v168, v169 |
| **J9** | **what is actually missing at corank $1$**: that the mixed part $V\wedge K$ contributes nothing at $k=1$, together with the $D_p\to B_p$ substitution. *Neither is on file, and both verifiers named them without supplying them* | v168 |
| **J10** | **the $29$-partition Gate 2 sweep covers exactly the branch that already has a proof.** $29=\sum_{p\le6}P(p)$, the partitions of $p$ up to $6$, *a sweep over multiplicity patterns of the nondegenerate case, which is the half that closes* | v168 |
| **J11** | *"false at $m=4,5$"* in the scope paragraph is **vacuous at $m=5$** under the record's own reading, and **"nondegenerate" is defined nowhere**, its two readings differ exactly at odd $m$, which is the parity the gap lives at | v168 |
| **J12** | **$p=1$ is in neither branch**, *verbatim the defect [L81](../findings/isotropy-cap.md) was repaired for, sitting in the block L81 says supersedes it.* Harmless, being true at $m=2$ | v168, v169 |
| **J13** | at $m=3$ the answer **is** a $3$-dimensional $\mathfrak{su}(2)$, so the refuting witness disagrees with the exception's *trigger* and not its *value*, which is why it was easy to miss | v168 |
| **J5** | **the consumer banner is stale**, and its replacement is unargued too. *"Expected, and not yet checked there"*, the hypothesis holds at every $m\ge4$ unconditionally, since $\mathcal W_m=0$ for $m\le3$. **But $\dim\mathfrak c\ge\lfloor m/2\rfloor-1$, which [ROUND_L33](ROUND_L33.md) wrote in as the fix, is asserted with no reason given either** | v168, v169 |
| **J6** | **a non sequitur standing in two places.** [stratum-two-negative.md](../findings/stratum-two-negative.md) and [LEDGER.md](../findings/LEDGER.md) both derive $\dim\mathfrak z(x)\ge\lfloor n/2\rfloor$ from *"the torus of $x$'s own $2$-blocks"*, which gives only $\ge1$, it is exactly $1$ at $x=\varphi_{12}\in\mathfrak{so}(6)$. *The same file diagnoses this eight lines above and leaves the blockquote standing* | v169 |
| **J7** | at $p=2$ the value $\mathfrak{su}(2)$, dimension $3$, is **asserted rather than derived**, the block bounds it above and never derives the value or the algebra, its own chain stopping at dimension $4$. *It is correct: $\Lambda^2_+$, dimension $3$* | v168, v169 |
| **J8** | *"proportional to a root of $D_p$"* **silently drops the short-root family $\pm e_i$**, and that family is nonempty at $m=3$ alone, so the scope paragraph and the $m=3$ refutation are one fact stated twice | v169 |
| **J14** | $\mathfrak c$, $a$, $p$ and $\mathfrak t$ are tabled nowhere in [conventions.md](../findings/conventions.md), and $e$ is a bivector index and a weight-lattice vector four lines apart inside this block | v168 |

### The debt, named exactly and not filled

**(†)** *For $x\in\mathfrak{so}(2p+1)$ of rank $2p$ with all singular values nonzero and $p\ge2$: $\mathfrak z(a^\perp)=\mathfrak t$, no root of $B_p$ (long or short), being proportional to $a$.* **That is the corank-$1$ case**, and v169's exception verdict at corank $1$ is marked conditional on it. *The falsifier can live in three compartments; two are closed by arguments on file at every corank, and the third (off-diagonal, $k=1$), is exactly (†).*

## Adjudication

**Verdict `GAP`, repaired. Impact `NARROWS`.** Two `GAP` against one `PROVEN, hypotheses corrected`, and **all three agree on every piece of mathematics**: the statement is true, its exception clause is exact, the sharp hypothesis is $m\ne3$, and exactly one line of the proof is unwritten. They divide on whether one missing line makes a gap or a correction.

### The round's own predecessor was wrong, and this round found it

**[ROUND_L33](ROUND_L33.md) recorded (hours ago, in this session) that L32 fails at corank $1$ because $B_p$'s short roots survive. All three verifiers refute that reason.** At corank $1$ there is no padding: $m=2p+1$ with $\mathop{\mathrm{rank}}x=2p$, so $a$ fills $\mathbb R^p$ with **no zero coordinate**, and every root of $\mathfrak{so}(m)$ (long with $p-2$ zeros, short with $p-1$), is excluded by *the same hypothesis the block's own sentence states*, **"while $a$ has none"**. The instance that round named, $x=\varphi_{12}+2\varphi_{34}+3\varphi_{56}$ at $m=7$, **closes at $\mathbb Rx$ both ways**. And the $\mathfrak{so}(5)$ witness quoted beside it has **corank $3$**, where $\mathfrak{so}(\ker x)\ne0$ and the degenerate clause works, it belongs to [L81](../findings/isotropy-cap.md), against the padded case.

*What survives of that finding is its first half*: $\mathfrak{so}(1)=0$, so the degenerate clause is genuinely vacuous at corank $1$. **The inference drawn from it was wrong**, and the two branches in fact cover the two failure modes between them, $a$ with no zero coordinate to the root lines at either parity, $a$ with a zero coordinate to $\dim\ker x\ge2$ where the clause is nonvacuous.

### What is actually owed, in one sentence

**That the mixed summand $\mathop{\mathrm{Hom}}(\ker x,\mathop{\mathrm{im}}x)$ contributes nothing**, which needs the standard representation of $\mathfrak{so}(k)$ to have no invariant vector at $k\ge2$. *Three verifiers named it independently; none supplied it.*

### And the Gate 2 that passed this result tested the branch that was already proved

$29=\sum_{p\le6}P(p)$, the partitions of $p$ up to $6$. **A sweep over multiplicity patterns of the maximal-rank case**, which is the half the root lines close. *The half that owes a line was never in it.*

### The repairs, all applied

| finding | what changed |
|---|---|
| J1 | the block's **Statement** line carries $m\ne3$, with the sharpness derived from $\dim\mathfrak z(x)=\sum_jm_j^2+\binom k2$ and the $m=2$ parting recorded; [INDEX-results.md](../findings/INDEX-results.md) matches |
| J2, and repair 1 | $p=\lfloor m/2\rfloor$ replaces $p=m/2$, and *"nondegenerate"* is stated as **maximal rank**, which is what makes the branch cover corank $0$ at even $m$ and corank $1$ at odd $m$ together |
| repair 2 | *"every root of $D_p$ has $p-2$ zero coordinates"* becomes *"every root of $\mathfrak{so}(m)$ has **at least** $p-2$"*, with the short roots named and excluded by the same hypothesis |
| J12, repair 3 | $p=1$ is treated: it is $m\in\{2,3\}$, and that cell **is** the hypothesis |
| J4 | the refuted $B_p$ reason withdrawn from [stratum-two-negative.md](../findings/stratum-two-negative.md) with what replaces it, and the corank-$3$ witness returned to [L81](../findings/isotropy-cap.md) |
| J9 | the owed line stated by name in both blocks |
| J5, J6 | the stale banner replaced by the unconditional discharge at $m\ge4$; the torus non sequitur struck from the block and from [LEDGER.md](../findings/LEDGER.md), which carried it as a discharge |
| J7 | the $p=2$ value derived rather than asserted, $\Lambda^2_+$, dimension $3$ |
| J11 | the scope paragraph reads *maximal rank*, records that $m=5$ is vacuous under the invertible reading, and drops the $D_p$ ambiguity |
| J14 | $\mathfrak c$, $a$, $p$, $\mathfrak t$ and $D_p$'s two senses tabled in [conventions.md](../findings/conventions.md), with the two readings of $p$ and the false hedge each gives |

### What the round gained

**The exception clause is exact**, rank $4$ with equal singular values, at every $m\ge4$, every corank and every multiplicity pattern checked in closed form, including the near-misses a complex structure on a $6$-plane and $a=(1,1,2,2)$ at $m=8$, both correctly *not* excepted. **And the consumer hypothesis is discharged unconditionally** where the block had recorded it as expected and unchecked.

### Queued elsewhere

**Research loop.** The one owed line: no $\mathfrak{so}(k)$-invariant vector in the standard representation for $k\ge2$, which deletes $\mathop{\mathrm{Hom}}(\ker x,\mathop{\mathrm{im}}x)$. *It is one line and it closes [L32](../findings/isotropy-cap.md), [L33](../findings/stratum-two-negative.md) and everything downstream of them.*
