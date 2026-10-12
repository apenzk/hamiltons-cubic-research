# REVIEW r580, Lemma L81, the sharp centraliser criterion

Reviewer r580, independent adversarial audit of *Lemma L81 (the sharp centraliser criterion, wider than Lemma L32), REQUIRES $p\ge2$* at [isotropy-cap.md:255](../findings/isotropy-cap.md), with its correction blockquote at [:257](../findings/isotropy-cap.md) and its body at [:259–261](../findings/isotropy-cap.md).

**Overall: the mathematics is CONFIRMED under the hypothesis $m\ge4$, and three things around it are REFUTED**, the heading's comparative, the hypothesis as installed, and the hedge attached to it. The block also carries no argument of its own, and the argument it borrows is incomplete at odd $m$.

Analysis-only footing observed. One screen was run (twenty-one skew matrices I constructed for the purpose, seconds of compute) and it is reported as a screen, never as evidence for a positive claim; every positive statement below is derived by hand.

## Verdicts, per defect

| # | defect | verdict |
| --- | --- | --- |
| D1 | *"wider than Lemma L32"* in the heading and in the [INDEX-results.md](../findings/INDEX-results.md) row 81 | **REFUTED**, L81 is subsumed by L32's canonical block, in the same file, forty lines above |
| D2 | the installed hypothesis $p\ge2$, with $p$ undefined | **REFUTED as sharp; REPAIRED by $m\ge4$**, it is a narrowing of [r463](REVIEW_r463.md)'s own verdict, which reads *"$p\ge2$ **or** $\dim\ker x\ge2$"* |
| D3 | the hedge *"At $n\ge12$ the hypothesis is free"* | **REFUTED under one reading of $p$**, and it writes $n$ for the lemma's $m$ |
| D4 | the criterion is stated unqualified in the body; only the heading and the blockquote carry the hypothesis | **defect, one clause to repair** |
| D5 | no argument in the block; the imported L32 proof quotes $D_p$ roots only | **INCOMPLETE at odd $m$**, the statement stands, the derivation does not reach it |
| D6 | *"cited 33 times"* | **REFUTED as a citation count**, nothing on the record consumes L81 |
| D7 | the criterion itself, under $m\ge4$ | **CONFIRMED**, by a commutant route sharing nothing with the block's |

## D7 first, what is actually true, derived from the definitions

Let $x\in\mathfrak{so}(m)$ be nonzero, $\mathfrak c=\mathfrak z(x)\cap x^\perp$, and put $x=\bigoplus_j b_j J_j\oplus 0$ in a normal frame: $b_1>\dots>b_r>0$ the **distinct** nonzero singular values, $U_j$ the $b_j$-isotypic subspace with complex structure $J_j$ and $\dim_{\mathbb C}U_j=m_j$, and $W_0=\ker x$ of dimension $q$.

**Step 1.** $\mathfrak z(x)=\bigoplus_j\mathfrak u(m_j)\oplus\mathfrak{so}(q)$, whose centre is $\mathfrak Z=\bigoplus_j\mathbb RJ_j$ plus $\mathfrak{so}(2)_{W_0}$ when $q=2$; write $k=\dim\mathfrak Z$ and $\mathfrak s$ for the semisimple part. Since $x\in\mathfrak Z$ and $\mathfrak Z\perp\mathfrak s$ by invariance of the pairing, $\mathfrak c=\mathfrak s\oplus\mathfrak d$ with $\mathfrak d=\mathfrak Z\ominus\mathbb Rx$ of dimension $k-1$.

**Step 2.** By isotypic decomposition, the commutant of $\mathfrak s$ is $\mathrm{End}(\mathcal T)\oplus\bigoplus_{m_j=2}\mathbb H\oplus\bigoplus_{m_j\ge3}\mathbb C\oplus\bigoplus\mathbb R$, where $\mathcal T$ collects the $\mathfrak s$-trivial summands, the $U_j$ with $m_j=1$, together with $W_0$ when $q\le2$. Its skew part is
$$A:=\mathfrak z(\mathfrak s)=\mathfrak{so}(\mathcal T)\oplus\bigoplus_{m_j=2}\mathfrak{sp}(1)^+_j\oplus\bigoplus_{m_j\ge3}\mathbb RJ_j .$$
The quaternionic entry is the whole content of the exception: $\mathbb C^2=\mathbb H$ has a $3$-dimensional skew commutant where $\mathbb C^k$, $k\ge3$, has only $\mathbb RJ$.

**Step 3.** $\mathfrak z(\mathfrak c)=A\cap\mathfrak z(\mathfrak d)=:B$ contains $\mathfrak d$, so $\dim(\mathfrak z(\mathfrak c)\cap\mathfrak c^\perp)=\dim B-(k-1)$ exactly, and $\mathbb Rx$ always sits inside. Hence **the dimension exceeds $1$ iff $\dim B>k$.**

**Step 4.** Reading $\dim B$ off Step 2 case by case gives the complete exceptional set:

- $m_j=2$ for the single $j$ present, i.e. $x$ a multiple of a **rank-$4$ complex structure**, padded or not, $\dim B-(k-1)=3$ at every $q\ge0$, so at every $m\ge4$;
- $(p,q)=(1,1)$, i.e. $m=3$, where $\mathfrak c=0$, $B=A=\mathfrak{so}(3)$ and the dimension is $3$;
- **and nothing else.** When some $m_j\ge2$ with $r\ge2$, $\mathfrak Z$ projects onto the full maximal torus of $\mathfrak{so}(\mathcal T)$ and $\dim B=k$. When all $m_j=1$, the question reduces to whether the hyperplane $x^\perp\cap\mathfrak Z_{\mathcal T}$ lies in a root hyperplane, i.e. whether $x$ is proportional to a root, impossible for $p\ge2$ with distinct singular values.

**So the sharp hypothesis is $m\ne3$**, and the criterion holds at $m=2$ as well ($\mathfrak c=0$, $\mathfrak z(0)=\mathfrak{so}(2)=\mathbb Rx$). Both the repair recorded on L32 and the one recorded on L81 are conservative by exactly that one case.

*Screen, offered as a screen.* Twenty-one constructed $x$ across $m=2,\dots,9$ and every multiplicity shape reachable there returned $\dim=3$ at $m=3$ and at the equal-pair rank-$4$ patterns $(1,1),(1,1,0),(1,1,0,0)$ for $m=4,\dots,9$, and $\dim=1$ everywhere else, including every rank-$2$ $x$ at $m=4,5,6,7$. It agrees with the derivation at every point and proves nothing on its own.

## D1, the comparative is false in both directions

L32's canonical block at [isotropy-cap.md:74](../findings/isotropy-cap.md) already contains all of L81:

- its **Statement** covers degenerate $x$ (it quantifies over nonzero $x\in\mathfrak{so}(m)$ and names the exception as a complex structure on a $4$-dimensional **subspace**, which is degenerate whenever $m>4$);
- its **Scope, stated** paragraph carries L81's sentence almost verbatim, the same root criterion, the same *"nondegeneracy is sufficient and not necessary"*, the same rank-$4$ $J$ *"padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ returns $3$ every time"*.

And L32 gives strictly **more**: the exceptional value ($3$-dimensional $\mathfrak{su}(2)$) and the generic value ($\mathbb Rx$), where L81 asserts only $>1$. On hypotheses, $\mathfrak c\ne0\iff m\ge4$ (because $\dim\mathfrak z(x)=\sum_jm_j^2+\binom q2$ equals $1$ exactly at $m\in\{2,3\}$) so L32's hypothesis is L81's under the generous reading of $p$ and weaker than it under the other.

**There is no direction in which L81 is wider than L32.** The true comparative is the body's own subheading, *"wider than nondegeneracy"*: the criterion is wider than the sufficient condition L32's **proof** runs on. Promoting that into *"wider than Lemma L32"* compares against the wrong object.

## D2, the hypothesis, and the reading of $p$ that makes it wrong

**$p$ is defined nowhere.** It is absent from [conventions.md](../findings/conventions.md), and absent from the L81 block; a reader must import it from L32's proof, which introduces $p=m/2$ *for nondegenerate $x$* and then says only that *"for degenerate $x$ the same argument runs inside the support"*. That leaves two readings, and they are not equivalent:

| reading | $p\ge2$ means | status |
| --- | --- | --- |
| $p=\lfloor m/2\rfloor$ (the ambient torus, zeros included) | $m\ge4$ | sufficient, sharp but for $m=2$ |
| $p=\operatorname{rank}(x)/2$ (blocks in the support) | $\operatorname{rank}x\ge4$ | sufficient, and **excludes true cases** |

Under the second reading the hypothesis throws away every rank-$2$ $x$ in $\mathfrak{so}(m)$, $m\ge4$, where the criterion holds, by Step 4 above and by the screen. The record's own source says so: [r463](REVIEW_r463.md)'s verdict reads *"the hypothesis it actually needs is $m\ge4$ (equivalently: $\mathfrak c\ne\{0\}$, equivalently $x$ has effective rank $p\ge2$ **or** $\dim\ker x\ge2$)"*. **The installed heading kept the first disjunct and dropped the second**, which is the disjunct that covers $e_{12}\in\mathfrak{so}(6)$.

**Repair:** state the hypothesis as $m\ge4$, the form r463 gave and the form L32 already carries.

## D3, the hedge, checked clause by clause

The block's hedges are three, and two fail.

1. *"At $n\ge12$ the hypothesis is free."*, true under $p=\lfloor m/2\rfloor$, **false** under $p=\operatorname{rank}(x)/2$: a simple bivector $e_{ab}\in\mathfrak{so}(12)$ has effective rank $p=1$ at any ambient dimension, and simple bivectors are exactly the eigenvectors a coordinate-diagonal Weyl operator supplies. So the ambiguity in D2 is load-bearing rather than cosmetic: one reading makes the hypothesis over-strong, the other makes this hedge false, and the record does not say which is meant. The clause also writes $n$ where the lemma quantifies over $\mathfrak{so}(m)$.
2. *"So nondegeneracy at $m\ge6$ is sufficient and not necessary"*, **correct**, and the $m\ge6$ is doing real work: at $m=4$ and $m=5$ a nondegenerate $x$ can have equal singular values and be the exception. *L32's version of the same sentence omits the $m\ge6$ and is false at $m=4,5$ for that reason*, adjacent to this audit, in the same file.
3. *"a rank-4 $J$ padded into $\mathbb R^6,\mathbb R^8,\mathbb R^{10}$ returns $3$ every time"*, **correct**, and Step 4 shows it returns $3$ at every $m\ge4$, odd $m$ included, so the three listed dimensions understate it.

## D4 and D5, is the claim stated where it is used, and is the argument reachable

**The body sentence carries no hypothesis.** [isotropy-cap.md:261](../findings/isotropy-cap.md) states the iff unqualified, and as written it is false at $m=3$; the correction lives only in the heading and in the blockquote above it. A consumer quoting the displayed criterion quotes the refuted form. The same sentence stands uncorrected at [ATTEMPTS.md:2100](../ATTEMPTS.md), and [results.md:430](../results.md)'s L32 entry is still the pre-repair statement while [results.md:150](../results.md) carries the repair, r463 asked for both.

**No argument is present in the block.** Its only internal support is numerical: *"Confirmed at all 26 multiplicity partitions for $m=4,\dots,12$ … by both reviewers independently."* The derivation must be taken from L32's proof, and **that proof's root step is incomplete at odd $m$**: it says *"Every root of $D_p$ is $\pm e_i\pm e_j$"*, while the object being computed is $\mathfrak z_{\mathfrak{so}(m)}(a^\perp)$, whose root system at odd $m$ is $B_p$ and includes the short roots $\pm e_i$. Those are proportional to $a$ for **every** rank-$2$ $x$, so the step "$\mathfrak z(\mathfrak c)\subseteq\mathfrak t$" is unjustified at, for instance, $x=e_{12}\in\mathfrak{so}(5)$, a configuration inside the corrected hypothesis under either reading. The conclusion is true there ($\mathfrak c\supseteq\mathfrak{so}(\ker x)$ with $\dim\ker x=m-2\ge3$, whose centraliser is already $\mathbb Rx$; or Step 4 above), but the recorded argument does not reach it. **This is the same omission that produced the $m=3$ counterexample** ($B_1$'s root $e_1$), one dimension up; adding $p\ge2$ made it harmless without closing it.

## D6, what cites it

The brief's *"cited 33 times"* is a raw-string count of `L81`. Of the 32 hits outside this report, most are markdown line anchors, [plan.md:81](../plan.md) cited as `#L81` from [r171](REVIEW_r171.md), [r174](REVIEW_r174.md), [r176](REVIEW_r176.md), or a page range, `L76–L81`, in [hashimoto-2023-hilbert-mumford-nilsolitons/notes.md](../references/hashimoto-2023-hilbert-mumford-nilsolitons/notes.md). Genuine references to the lemma outside review reports number four: its own heading, the L80 blockquote at [isotropy-cap.md:241](../findings/isotropy-cap.md), [LEDGER.md:252](../findings/LEDGER.md), and row 81 of [INDEX-results.md](../findings/INDEX-results.md).

**No result consumes L81.** The one substantive use of the mathematics, in L33's proof at [stratum-two-negative.md:158](../findings/stratum-two-negative.md), cites L32 and discharges $\mathfrak c\ne0$ explicitly. So the brief's worry that consumers predate the correction is unfounded, and [LEDGER.md:252](../findings/LEDGER.md)'s *"nothing cites L81"* is right. What propagates instead is the **statement**, uncorrected, at [ATTEMPTS.md:2100](../ATTEMPTS.md).

## What the block leans on that is undefined

- **$p$**, the hypothesis's own symbol, absent from [conventions.md](../findings/conventions.md) and from the block. This is the defect at D2.
- **"the singular-value vector"**, whether the zeros are included is the same ambiguity, and it decides whether *"a root of $D_p$"* names $D_{m/2}$ or $D_{\operatorname{rank}/2}$.
- **"$D_p$" at odd $m$**, the root system of $\mathfrak{so}(m)$ is $B_p$ there. The criterion survives the mis-citation; the proof does not. This is D5.
- **"nondegeneracy" at odd $m$**, the block's hedge 2 needs it to mean rank $m-1$; the record never says.
- $\mathfrak c$ and $\mathfrak z$ are defined only inside L32's block, not in [conventions.md](../findings/conventions.md).

**The norm is not a trap here.** Every object in the statement ($\mathfrak z$, $\mathbb Rx$, and both orthogonal complements), is invariant under replacing the pairing by any positive multiple, so [conventions.md](../findings/conventions.md)'s factor-$2$ split between the half-trace $\Lambda^2$ pairing and plain Frobenius rescales the form and leaves the criterion untouched. The block's $\perp$'s are well defined without the convention being named. The file's other live collisions ($\mathfrak m$'s three senses, $\Pi$'s four objects, "Theorem A"'s four), do not touch this block; the $n$ for $m$ slip in the hedge does.

## Repairs, smallest first

1. Move the hypothesis into the body sentence at [isotropy-cap.md:261](../findings/isotropy-cap.md) and state it as **$m\ge4$**, matching L32 and [r463](REVIEW_r463.md); drop $p\ge2$ or define $p$ where it is used.
2. Rewrite the heading and the [INDEX-results.md](../findings/INDEX-results.md) row 81: the criterion is **wider than nondegeneracy**, and it is **the mechanism behind L32's exception** rather than a widening of L32.
3. Record that the block has no proof, and either fold it into L32's block (which already states it) or give it the $B_p$ short-root case that L32's proof omits.
4. Repair the uncorrected copies at [ATTEMPTS.md:2100](../ATTEMPTS.md) and [results.md:430](../results.md).
5. Adjacent, outside this brief: L32's *"nondegeneracy is sufficient and not necessary"* wants L81's $m\ge6$ qualifier, being false at $m=4,5$.
