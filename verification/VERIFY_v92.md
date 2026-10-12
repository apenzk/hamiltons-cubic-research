# VERIFY v92, Lemma L0: the $\Theta_n$ biconditional, its three scope conditions, and the witness that closes it

*Verifier v92, cold brief, on the rewritten block at [findings/problem.md](../findings/problem.md):470–500, dispatched as [ROUND_L00b.md](ROUND_L00b.md). **No numerical work was done**: every value below is an exact hand evaluation of a rational, and the two decimal figures quoted are quoted from sources, not computed. Log: [agent_logs/verify-L00b-v92.log](../agent_logs/verify-L00b-v92.log). Sources read rather than recalled: [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404) at extraction lines 212–226, 1483–1489 and 4688–4712, and [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) in full.*

## Claim table

| # | Claim, as a consumer would cite it | Verdict |
| --- | --- | --- |
| C1 | ($\Rightarrow$): $\sup=\Theta_n$ implies $P\le\Theta_n$ at every critical point | **PROVEN** |
| C2 | ($\Leftarrow$) as argued in the Proof paragraph | **GAP**, it yields $\sup\le\Theta_n$, the block says so, and $\square$ is printed anyway |
| C3 | The displayed biconditional as a mathematical statement, at both parities | **PROVEN**, closable in one sentence from a source in [references/](../references/) |
| C4 | The constant is $\Theta_n$ and not $\theta_0(n)$, with the gap $8(n-1)/(n^2(n+1)(n-2))$ | **PROVEN**, verified against the published statement and against a published decimal |
| C5 | Scope 1: the claim is about the maximum value, not the maximiser | **PROVEN**, the published conclusion carries no equality clause |
| C6 | Scope 2: "Conjecture A" means its $n\ge12$ clause alone, and the low clause is live | **PROVEN** |
| C7 | Scope 3: "products of spheres" means the balanced split, unbalanced ones sub-maximal | **PROVEN** |
| C8 | "each side is then the $n\ge12$ clause of Conjecture A at both parities" | **PROVEN**, on an import the block never names |
| C9 | "whose Lagrange condition is $Q(W)=\theta W$ with $\theta=P(W)$" | **HYPOTHESIS-DEBT**, two BW08 facts, unargued here; not load-bearing for the biconditional |
| C10 | "$\mathcal W_n$ is finite-dimensional, so … $P$ attains its maximum on it" | **HYPOTHESIS-DEBT**, attainment needs $\mathcal W_n\ne\{0\}$, never stated |
| C11 | "every quantitative obstruction survives intact on the smaller set" | **GAP**, flagged unsupported by the refuting review, carried into the rewrite unchanged |
| C12 | "Both directions checked in [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) and [L16.lean](../lean/HamiltonsCubic/Results/L16.lean)" | **GAP**, the Lean file contains no implication of the biconditional |
| C13 | [results.md](../results.md):46, L43's $\theta_0(n)$ cone bound, "so Conjecture A and the problem $P$ are one statement" | **BROKEN** at odd $n$ |
| C14 | [results.md](../results.md):11 "Proven at both parities" against [results.md](../results.md):775 "asserted and did not cite" | **GAP**, the two rows report different states |
| C15 | [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md):7 (the source note the refutation named as root cause | **HYPOTHESIS-DEBT**), still truncated before the conclusion |
| C16 | [findings/INDEX.md](../findings/INDEX.md):18, "$\theta\le\theta_0(n)$, equality exactly at $S^{n/2}\times S^{n/2}$" for all $n\ge12$ | **BROKEN**, outside this block, named by this block's refuting review, unrepaired |

**Verdict: `GAP`.** The rewrite fixes the constant completely and correctly, and the statement is true at both parities; the proof still stops one sentence short of the equivalence it displays, and three of the four repairs prescribed by the review that refuted the block have landed while the one that would close the proof has not.

---

## 0. Conventions, fixed once

Taken from [findings/conventions.md](../findings/conventions.md) and quoted, not restated in a new form.

- $\mathcal W_n$ is the space of algebraic Weyl curvature operators on $\mathbb R^n$, with $\dim\mathcal W_n=\frac{n(n-3)(n+1)(n+2)}{12}$, so $\dim\mathcal W_3=0$ and $\dim\mathcal W_n>0$ at every $n\ge4$.
- $Q(W)=W^2+W^\#$, sending $\mathcal W_n$ to itself; $P(W)=\langle W,Q(W)\rangle$; $\theta=P(W)/\lVert W\rVert^3$, and at a critical point $Q(W)=\theta W$.
- $\theta_0(n)$ is the closed form $\theta_0(n)^2=2(n-1)(n-2)/n^2$ **and nothing more**. $\Theta_n$ is the diagonal maximum, equal to $\theta_0(n)$ at even $n$ and to $\sqrt{2(n-1)(n-3)/((n+1)(n-2))}$ at odd $n$.
- Nienhaus's published $\theta_{k,l}$, quoted verbatim from extraction line 1483 of [nienhaus-2311.02404.txt](https://arxiv.org/abs/2311.02404): the Weyl curvature of $S_{k,l}$ satisfies $W^2+W^\#=\theta_{k,l}W$ with $\theta_{k,l}=\sqrt2\sqrt{\frac{k-1}{k}\cdot\frac{l-1}{l}\cdot\frac{n-1}{n-2}}$, and moreover $P(W_{S_{k,l}})=\theta_{k,l}$.

**One identity used throughout, and it is the block's own.** With $k+l=n$,

$$1-\frac{n-1}{kl}=\frac{kl-k-l+1}{kl}=\frac{(k-1)(l-1)}{kl},$$

so the block's $\theta_{k,l}^2=2\frac{n-1}{n-2}\left(1-\frac{n-1}{kl}\right)$, the record's $\theta(S^p\times S^q)^2=\frac{2(n-1)(p-1)(q-1)}{(n-2)pq}$ at [findings/problem.md](../findings/problem.md):552, and Nienhaus Proposition 2.25 are **one formula in three spellings**. That is the bridge on which C4, C7 and C8 all rest, and it is exact.

---

## 1. The hypothesis inventory

A pass without one is not a pass, so here is every hypothesis the block carries or imports, checked against the object it applies to, with the last column saying whether the written argument uses it.

| Hypothesis | Where it comes from | The object it applies to | Used by the written argument? |
| --- | --- | --- | --- |
| $n\ge12$ | the block's own "Fix $n\ge12$" | the dimension | **No.** The equivalence is proved at every $n$ for which $\mathcal W_n\ne\{0\}$; $n\ge12$ enters only at the identification with Conjecture A's clause (§5) |
| $\mathcal W_n\ne\{0\}$ | never stated; it is the `Nontrivial` binder of [SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean)'s `exists_max` | the unit sphere in $\mathcal W_n$ | **Yes, silently.** "$P$ attains its maximum on it" is false on an empty sphere |
| $\mathcal W_n$ finite-dimensional | stated | $\mathcal W_n$ | Yes, compactness of the unit sphere |
| $P$ continuous | "the polynomial $P$" | $P$ on $\mathcal W_n$ | Yes, attainment |
| $\{\lVert W\rVert=1\}$ a smooth submanifold | "a smooth constraint surface" | the unit sphere | Yes, maximum implies critical |
| Full symmetry of $T(A,B,C)=\langle A,\Phi(B,C)\rangle$ | [BW08](../references/boehm-wilking-2008-space-forms/) eq. (5), recorded at [findings/problem.md](../findings/problem.md):84 | the cubic form $P$ | **No.** Needed only to write $\nabla P=3Q(W)$, i.e. for the *form* of the Lagrange condition, which the biconditional does not consume |
| $Q$ preserves $\mathcal W_n$ | [BW08](../references/boehm-wilking-2008-space-forms/) eq. (6); tabled in [findings/conventions.md](../findings/conventions.md) | $Q$ | **No**, for the same reason. It is what turns the projected gradient condition into $Q(W)=\theta W$ |
| $P(W^{\mathrm{crit}}_{\mathrm{sym}})=\Theta_n$ | Nienhaus Proposition 2.25, extraction line 1483; the record's own [L57](../findings/problem.md) closed form | the balanced sphere product | **Yes, load-bearing**, for C4 and for both scope conditions 2 and 3, and cited nowhere in the block |
| $W^{\mathrm{crit}}_{\mathrm{sym}}\in\mathcal W_n$ with $\lVert W\rVert=1$ | Nienhaus, "its unit Weyl curvature operator" | the witness | **Yes**, for the $\sup\ge\Theta_n$ half, and only in the pull-quote, after $\square$ |
| $\theta_{k,l}^2$ strictly increasing in $kl$ | the block's own one-line argument | splits $k+l=n$ | Yes, scope condition 3 |
| Nienhaus's and this record's $P$ agree in normalisation | the record's own check at [findings/problem.md](../findings/problem.md):243 | the pairing on $\Lambda^2$ | **Yes, silently.** [findings/conventions.md](../findings/conventions.md) warns that placing the $\tfrac12$ at the operator level inflates every $\theta$ by $\sqrt2$; the block imports a published constant across that boundary without saying the check was made |

**No finding on the criticality hypothesis.** The brief's second carried-in trap is that Conjecture A hypothesises criticality while a criterion quantifying over every unit Weyl operator implies it without being implied by it. The block does not fall into it: its right-hand side is the criticality-hypothesised statement, its left-hand side is the unrestricted one, and its entire content is that compactness makes the reverse implication available here. The closing paragraph says exactly this ("the one thing it removes is the criticality hypothesis, for free, by compactness") and draws the right consequence about the localisation theorem. This is the trap handled, not the trap sprung.

---

## 2. Pre-registered question 1, is the biconditional a biconditional?

**Checked separately, and the answer is: the statement is, the proof is not.**

### 2.1 ($\Rightarrow$)

"If the supremum is $\Theta_n$ then $P\le\Theta_n$ everywhere, critical points included."

This is correct and needs nothing beyond the definition of a supremum. It does not need attainment, it does not need criticality, it does not need the constant to be $\Theta_n$ rather than anything else, and it holds at every $n$ and both parities. **PROVEN.**

### 2.2 ($\Leftarrow$)

"If $P\le\Theta_n$ at every critical point then $P(W_{\max})\le\Theta_n$, and $P(W_{\max})$ is the supremum, **so this direction gives $\sup\le\Theta_n$ and not the equality.** $\square$"

The step is correct as far as it goes, and it consumes the compactness paragraph: $W_{\max}$ exists, is critical for the restriction, and therefore falls under the hypothesis. What it delivers is $\sup\le\Theta_n$. The sentence in bold says so. Then the proof ends.

**So the Proof paragraph establishes ($\Rightarrow$) and the $\le$ half of ($\Leftarrow$), and prints $\square$ over an equivalence it has not shown.** This is pre-registered question 1's own phrase: an implication wearing an equivalence's clothes.

### 2.3 What actually closes it, and where it is

$\sup\ge\Theta_n$ is unconditional, and one line of a source in [references/](../references/) gives it. Nienhaus Proposition 2.25, read at extraction line 1483, states that the Weyl curvature of $S_{k,l}$ is a unit Weyl operator with $P(W_{S_{k,l}})=\theta_{k,l}$. Take $k=\lceil n/2\rceil$, $l=\lfloor n/2\rfloor$. Then $W^{\mathrm{crit}}_{\mathrm{sym}}$ is admissible in the constraint set and $P(W^{\mathrm{crit}}_{\mathrm{sym}})=\Theta_n$, so the supremum is at least $\Theta_n$. Combined with §2.2, $\sup=\Theta_n$.

**Given that, the biconditional is true at both parities and at every $n$ with $\mathcal W_n\ne\{0\}$**, and it is worth saying why it is robust: the two sides are true together and false together. At $n=10$, for instance, $W_{\mathbb{CP}^2}$ is a critical point with $P^2=3/2>36/25=\Theta_{10}^2$, so the right-hand side fails; and $\sup\ge\sqrt{3/2}>\Theta_{10}$, so the left-hand side fails; the equivalence stands. A counterexample to Conjecture A would not be a counterexample to L0.

### 2.4 Where the closing sentence sits in the block, and why that is the finding

It sits **after** the $\square$, inside a blockquote headed "THE LOWER HALF IS A SEPARATE CLAIM AND THE BLOCK ASSERTED IT", in the grammar of a defect report about the block: "Both reviewers found the witness cited nowhere in the block." A consumer reading the Lemma and its Proof (which is how a proof is cited), gets the implication and a printed QED. A consumer who reads on gets a paragraph telling them the block asserted the missing half, phrased so that it reads as a description of a defect rather than as the step that removes it. The witness's warrant is given as "the $\theta_{k,l}$ formula below", which does resolve inside [findings/problem.md](../findings/problem.md), line 552, in [L57](../findings/problem.md)'s block, but resolves to nothing at all in any excerpt of L0 alone, including the brief this round was dispatched on.

**This is the named trap in its exact shape**: the correction landing beside the statement it corrects, so a citation of the statement inherits the defect.

**Three-step record.**

- **Located.** [findings/problem.md](../findings/problem.md):490 (the Proof paragraph, ending "$\square$") against :492 (the pull-quote).
- **Exhibited concretely.** [REVIEW_r592.md](../reviews/REVIEW_r592.md), the review the record cites for this block, prescribes four repairs. Item 1 (state both sides at $\Theta_n$) has landed. Item 3 (write the Lagrange condition) has landed. Item 4 (fix the $\theta_0(n)$ gloss at [findings/conventions.md](../findings/conventions.md):18) has landed, the row now reads "the closed form … **and nothing more**" and names the withdrawn gloss as what regrew the defect. Item 2 reads, verbatim: *"Supply the missing inequality. **Add the sentence the proof lacks**"*. The proof still lacks it. Three of four, and the missing one is the one that closes the argument.
- **Argued the opposite.** The most charitable reading the words support: a blockquote is part of the block, the witness is named in it, the pointer resolves inside the file, and the block is being scrupulously honest that this half is a citation rather than an argument, which is more than most blocks on this record do. Under that reading the mathematics on the page is complete and only the placement of $\square$ is wrong. I accept that reading and still record the finding, because the brief's instruction is to read each citable claim alone, as a consumer would, and alone the Proof does not prove the Lemma.

**Verdict on question 1: the biconditional is a biconditional; the block's proof of it is not.**

---

## 3. Pre-registered question 2, do the three scope conditions cover what the record spends them on?

Each checked against a named object, and against the published statement read at extraction lines 212–226.

### 3.1 The published statement, quoted from the source

> "Conjecture A. Let $W\in\mathrm{Weyl}_n$ be a unit Weyl curvature operator that is a critical point of $P(R)=\langle R^2+R^\#,R\rangle$ among $\mathrm{Weyl}^1_n=\{W\in\mathrm{Weyl}_n\mid \lVert W\rVert=1\}$. If either $n\ge12$ or $8\le n\le11$ and $W\notin SO(n).W_{\mathbb{CP}^2}$, we have $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$."
>
> "Here, we denote by $R^{\mathrm{crit}}_{\mathrm{sym},n}=R^{\mathrm{crit}}_{\mathrm{sym}}$ the curvature operator of $S^{\lceil\frac n2\rceil}\times S^{\lfloor\frac n2\rfloor}$ endowed with its symmetric Einstein metric and by $W^{\mathrm{crit}}_{\mathrm{sym}}=(R^{\mathrm{crit}}_{\mathrm{sym}})_W$ its unit Weyl curvature operator."

### 3.2 Scope 1, value, not maximiser

The named object is the published conclusion itself: $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$. It is a non-strict inequality and it carries no equality clause and no uniqueness clause. So the block's reading is the source's. **PROVEN.**

The condition does real work, because [README.md](../README.md):16 states Problem P as "maximized **on** the Weyl tensor of products of spheres", which is a statement about where the maximum sits. The block's scope condition is what makes that harmless: "the maximum is attained at $W^{\mathrm{crit}}_{\mathrm{sym}}$" and "the maximum value is $\Theta_n$" are the same statement once $P(W^{\mathrm{crit}}_{\mathrm{sym}})=\Theta_n$ is known, whereas "attained **only** there" is strictly stronger and is not claimed. The block draws that line correctly.

### 3.3 Scope 2, the $n\ge12$ clause alone

The published dimension hypothesis is a disjunction, so the conjecture is equivalent to a conjunction of two implications, and an $n\ge12$ statement cannot imply the $8\le n\le11$ one. **PROVEN.**

The liveness witness checks by hand. $\theta_0(10)^2=\frac{2\cdot9\cdot8}{100}=\frac{144}{100}=\frac{36}{25}$, and $10$ being even, $\Theta_{10}=\theta_0(10)$. Nienhaus at extraction line 4690 records $\max\{P(W):W\in\mathrm{Weyl}_n,\lVert W\rVert=1\}=\sqrt{3/2}$ achieved only by $W_{\mathbb{CP}^2}$ in dimensions between $8$ and $12$, so $P(W_{\mathbb{CP}^2})^2=\frac32$. And $\frac{36}{25}<\frac32$, since $36\cdot2=72<75=3\cdot25$. So at $n=10$ the low clause has content the $n\ge12$ clause cannot supply. **The block's figure is exact and its reading of the source is exact.**

*One notational hazard, reported and not graded as a defect.* The bullet writes $\theta_{10}$ one line after introducing the two-index $\theta_{k,l}$, and $\theta_{10}$ is the single-index $\theta_0(10)$. The value $36/25$ disambiguates it, but a reader carrying the two-index convention forward has to stop.

### 3.4 Scope 3, the balanced split

$\theta_{k,l}^2=2\frac{n-1}{n-2}(1-\frac{n-1}{kl})$ is strictly increasing in $kl$ at every $n\ge3$, since $n-1>0$ and $\frac{n-1}{n-2}>0$; and $kl$ with $k+l=n$ fixed is maximised at the most balanced split. So the maximum over splits is at $k=\lceil n/2\rceil$. This matches the source's own naming of $W^{\mathrm{crit}}_{\mathrm{sym}}$ as the operator of $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$. **PROVEN.**

Both numerical claims in the bullet are exact and I evaluated them by hand. At $n=12$, $kl=35$ gives $\theta_{5,7}^2=2\cdot\frac{11}{10}\left(1-\frac{11}{35}\right)=\frac{11}5\cdot\frac{24}{35}=\frac{264}{175}$, and $kl=36$ gives $\theta_{6,6}^2=\frac{11}5\cdot\left(1-\frac{11}{36}\right)=\frac{11}5\cdot\frac{25}{36}=\frac{275}{180}=\frac{55}{36}$, which is also what the even closed form returns, $\theta_0(12)^2=\frac{2\cdot11\cdot10}{144}=\frac{220}{144}=\frac{55}{36}$, so the two spellings agree at the split the block uses. Then $\frac{264}{175}<\frac{55}{36}$ because $264\cdot36=9504$ and $55\cdot175=9625$. **Exact, and the unbalanced product is genuinely critical**, by Proposition 2.25's own eigen-equation $W^2+W^\#=\theta_{k,l}W$, which the block asserts ("critical but strictly sub-maximal") without citing.

### 3.5 What a consumer may cite from the three conditions

All three, in full, at both parities. Each is checkable against a line of the published statement that is in [references/](../references/) and that I read. They are the strongest part of the rewrite.

---

## 4. The constant, and the trap carried in

**The block's handling of $\Theta_n$ against $\theta_0(n)$ is correct throughout, and I verified every figure by hand.**

At odd $n$, $k=\frac{n+1}2$, $l=\frac{n-1}2$, so $kl=\frac{n^2-1}4$ and

$$\theta_{k,l}^2=2\frac{n-1}{n-2}\left(1-\frac{4(n-1)}{n^2-1}\right)=2\frac{n-1}{n-2}\cdot\frac{n^2-4n+3}{n^2-1}=\frac{2(n-1)(n-3)}{(n-2)(n+1)}=\Theta_n^2 .$$

At even $n$, $kl=\frac{n^2}4$ and $1-\frac{4(n-1)}{n^2}=\frac{(n-2)^2}{n^2}$, so $\theta_{k,l}^2=\frac{2(n-1)(n-2)}{n^2}=\theta_0(n)^2$.

The gap, at odd $n$:

$$\theta_0(n)^2-\Theta_n^2=2(n-1)\left[\frac{n-2}{n^2}-\frac{n-3}{(n+1)(n-2)}\right]=2(n-1)\cdot\frac{(n-2)^2(n+1)-n^2(n-3)}{n^2(n+1)(n-2)} .$$

Expanding, $(n-2)^2(n+1)=(n^2-4n+4)(n+1)=n^3-3n^2+4$ and $n^2(n-3)=n^3-3n^2$, so the numerator is $4$ identically and the gap is $\frac{8(n-1)}{n^2(n+1)(n-2)}$, positive at every $n\ge4$. **The block's identity and its $8$ are exact.**

At $n=13$: $\theta_0(13)^2=\frac{2\cdot12\cdot11}{169}=\frac{264}{169}$ and $\Theta_{13}^2=\frac{2\cdot12\cdot10}{14\cdot11}=\frac{240}{154}=\frac{120}{77}$. Their difference is $\frac{264\cdot77-120\cdot169}{13013}=\frac{20328-20280}{13013}=\frac{48}{13013}$, and the closed form gives $\frac{8\cdot12}{169\cdot14\cdot11}=\frac{96}{26026}=\frac{48}{13013}$. **They agree exactly.**

### 4.1 An independent confirmation the block does not use, and it is decisive

Nienhaus prints his own value at $n=11$, at extraction line 4708: $P(W^{\mathrm{crit}}_{\mathrm{sym},11})=\frac{2\sqrt{30}}9$. Squaring, $\frac{4\cdot30}{81}=\frac{120}{81}=\frac{40}{27}$. And the block's odd closed form at $n=11$ gives $\Theta_{11}^2=\frac{2\cdot10\cdot8}{12\cdot9}=\frac{160}{108}=\frac{40}{27}$. **They are the same rational.** Meanwhile $\theta_0(11)^2=\frac{2\cdot10\cdot9}{121}=\frac{180}{121}$, and $\frac{40}{27}\ne\frac{180}{121}$ since $40\cdot121=4840$ and $180\cdot27=4860$. So the source's own printed constant at an odd dimension is $\Theta_n$ and not $\theta_0(n)$, from a line neither the block nor either refuting review quotes. The line immediately below it, $P(W^{\mathrm{crit}}_{\mathrm{sym},10})=\frac65$, likewise squares to $\frac{36}{25}=\theta_0(10)^2$, as it must at an even dimension.

### 4.2 The withdrawn form really did assert the negation, and the two-case reading is right

The block claims "as written the biconditional implied Conjecture A is FALSE at odd $n$, with no hypothesis: either a critical point exceeds $\theta_0(n)>\Theta_n$, or the maximiser carries $P=\theta_0(n)>\Theta_n$." Checked, and it is exactly right. Write $A$ for "$\sup=\theta_0(n)$" and $B$ for "$P\le\theta_0(n)$ at every critical point". The withdrawn statement is $A\iff B$, which holds in two cases. If both are true, $\sup=\theta_0(n)>\Theta_n$ and the maximiser is critical, so a critical point carries $P>\Theta_n$. If both are false, $B$ false gives a critical point with $P>\theta_0(n)>\Theta_n$ directly. Either way Conjecture A fails at that odd $n$. **The block's disjunction is the two branches of that case split, in order, and it needs no hypothesis. Confirmed.**

---

## 5. "Each side is then the $n\ge12$ clause of Conjecture A at both parities"

**PROVEN, on an import the block does not name.**

The right-hand side is "$P(W)\le\Theta_n$ at every critical point of $P|_{\lVert W\rVert=1}$". The published clause is "for $W$ unit and critical among $\mathrm{Weyl}^1_n$ with $n\ge12$, $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$". The quantifier ranges and the criticality condition agree word for word; the only thing needing checking is $P(W^{\mathrm{crit}}_{\mathrm{sym}})=\Theta_n$, which is §0's three-spellings identity applied at the balanced split. That identity comes from Proposition 2.25, and **the block cites neither the proposition nor [L57](../findings/problem.md), which is where the record derives it**. It is a true import, fully backed, silently taken.

The left-hand side is Problem P in its value form, which is [README.md](../README.md):16 read through scope condition 1. Saying it "is" Conjecture A's clause is the lemma's conclusion restated, not a separate claim; it is loose but not wrong, and I withdraw it as a candidate defect.

**Where $n\ge12$ actually enters.** Nowhere in the proof. It enters here, in the identification, because at $8\le n\le11$ the published clause carries the $SO(n)\cdot W_{\mathbb{CP}^2}$ removal and the block's right-hand side does not. The block never says that its own equivalence is dimension-free, which is a small loss, since the dimension-free reading is the one that shows the equivalence cannot be what fails.

---

## 6. Quantifier order, scope, and every edge of the range

Answered in writing, including where I find nothing.

| Edge | Finding |
| --- | --- |
| **Quantifier order** | No finding. The block fixes $n$ first ("Fix $n\ge12$"), so the statement is $\forall n\ (A_n\iff B_n)$, and both sides quantify over $W$ inside. The published conjecture has the same shape. Nothing is swapped |
| **The smallest admissible dimension** | The written scope is $n\ge12$. The argument is valid from $n=4$. At $n=3$, $\dim\mathcal W_3=0$, the unit sphere is empty and "attains its maximum" fails, the unstated hypothesis of C10. Harmless in scope, unstated everywhere |
| **Odd $n$** | No finding. This is the rewrite's subject and it is handled correctly at every point I checked: the closed form, the gap identity, the balanced split's $kl=\frac{n^2-1}4$, the witness. The one thing to note is that the gap is positive at every odd $n\ge4$, not only from $n\ge13$; the block's "$\ge13$" is the true-but-weaker statement forced by its own scope |
| **Reducible cases** | No finding, and the answer is that the question does not reach the block. L0's objects are algebraic Weyl operators on $\mathbb R^n$; no manifold, no holonomy, no de Rham factor enters either direction. It is worth saying that the witness is a *reducible* symmetric space, $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$, and the block uses it only through the published value of $P$ on its Weyl operator, so reducibility is a property of the witness rather than a hypothesis on the statement |
| **Non-compact cases** | No finding, same reason. The only compactness used is that of the unit sphere of a finite-dimensional normed space, which is [SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean)'s content and is about the vector space, not about any manifold |
| **$\ker W\ne0$** | No finding. Neither direction distinguishes operators by kernel; the witness itself has large kernel and is admissible. The record's one kernel trap, that the gradedness slack screen is vacuous when $\ker W\ne0$, [findings/conventions.md](../findings/conventions.md)'s $S(W)$ row, belongs to a different family of arguments and is not consumed here. The one place a kernel could be thought to bite is the Lagrange form at $\theta=0$, where $Q(W)=0$; such a point is still a critical point and still satisfies $P(W)=0\le\Theta_n$, so it is covered |

---

## 7. Comparing the three forms

I checked [findings/problem.md](../findings/problem.md):470–500, [results.md](../results.md) at lines 11, 46 and 775, and the Lean layer at [lean/INDEX.md](../lean/INDEX.md) rows 216 ([L0.lean](../lean/HamiltonsCubic/Results/L0.lean)), 252 ([SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean)), 101 ([SphereProducts.lean](../lean/HamiltonsCubic/Results/SphereProducts.lean)), 103 ([Theta0.lean](../lean/HamiltonsCubic/Results/Theta0.lean)), 78 ([BalanceMax.lean](../lean/HamiltonsCubic/Results/BalanceMax.lean)) and 182 ([L16.lean](../lean/HamiltonsCubic/Results/L16.lean)), plus the theorem lists of the first two files.

| Form | What it carries that the others do not | What it lacks |
| --- | --- | --- |
| [findings/problem.md](../findings/problem.md):470–500 | the three scope conditions; the $\theta_{k,l}$ monotonicity argument; the Lagrange condition; the two-case reading of the withdrawn form; the witness, in a blockquote | a proof that closes; a citation for Proposition 2.25 or for [L57](../findings/problem.md) |
| [results.md](../results.md):775 | the same biconditional, the same constant, the gap formula, the provenance | **all three scope conditions**. A consumer citing this row gets no value-versus-maximiser line, no "$n\ge12$ clause alone", no balanced-split condition, and the balanced-split condition is the one whose absence broke the lemma in the first place |
| [results.md](../results.md):11 | the headline state, "Proven at both parities" | consistency with :775, which records the lower half as asserted and uncited |
| [results.md](../results.md):46 | the relation to Böhm–Wilking and to [L43](../findings/problem.md) | the correction. See §8 |
| [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) | machine-checked arithmetic: `margin_is_four`, `gap_closed_form`, `gap_positive` at $4\le n$, `values_at_thirteen`, `split_increasing`, `ten_clause_live` | **any implication of the biconditional.** Its two relevant theorems are `backward_gives_only_le` and `equality_needs_witness : ∃ s Θ : ℚ, s ≤ Θ ∧ s ≠ Θ`, the layer formalises the *hole*, not the closure. The row itself says so: "Owed, halved … the Lagrange condition stays imported" |
| [SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean) | the compactness half, as `exists_max` on any finite-dimensional real normed space | it carries a `[Nontrivial E]` binder, which is the hypothesis $\mathcal W_n\ne\{0\}$ that no prose form states |
| [SphereProducts.lean](../lean/HamiltonsCubic/Results/SphereProducts.lean), [Theta0.lean](../lean/HamiltonsCubic/Results/Theta0.lean), [BalanceMax.lean](../lean/HamiltonsCubic/Results/BalanceMax.lean) | the split values and the balance maximisation, kernel-checked | all three rows say **"Not claimed": the closed form itself**, and [BalanceMax.lean](../lean/HamiltonsCubic/Results/BalanceMax.lean) is finite, $4\le n\le24$. So the Lean layer nowhere holds $P(W^{\mathrm{crit}}_{\mathrm{sym}})=\Theta_n$ at general $n$, which is the one import L0 is load-bearing on. **The block's own hand argument for the monotonicity is strictly stronger than the Lean row**, being valid at every $n$ |

**A `partial` row owing exactly the step the block rests on.** [L16.lean](../lean/HamiltonsCubic/Results/L16.lean)'s row is `partial` and its owed list ends: *"and that $\Theta_n$ **is** the odd sphere-product maximum"*. That is the identification of §5, named as owed in the layer, and taken silently in the block. It is backed by Proposition 2.25 and by [L57](../findings/problem.md); it is not backed anywhere the block points.

### 7.1 The Lean cross-reference the block makes

**Three-step record for C12.**

- **Located.** [findings/problem.md](../findings/problem.md):484, "*Both directions checked in [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) and [L16.lean](../lean/HamiltonsCubic/Results/L16.lean).*"
- **Exhibited concretely.** [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) contains no theorem asserting either implication of the displayed biconditional. It contains `backward_gives_only_le`, which asserts that the backward direction yields at most $\le$, and `equality_needs_witness`, which exhibits a pair with $s\le\Theta$ and $s\ne\Theta$. A consumer reading "both directions checked in L0.lean" one paragraph above a displayed biconditional will take it as the two implications, and will be taking the opposite of what the file holds.
- **Argued the opposite.** The sentence sits at the end of the paragraph about the shared identity, "L16 reads it as a gap …, this block as the reason a substituted constant asserted the conjecture's own negation", so "both directions" most naturally means *the two readings of that one identity*, one per file, and under that reading it is accurate. I accept this reading is available and grade the item as an ambiguity beside a biconditional rather than as a false claim.

---

## 8. The correction that did not travel

Three sites carry the block's claim without the block's correction. Each gets the three-step record.

### 8.1 [results.md](../results.md):46, BROKEN

- **Located.** "the cone-bridge (Lemma L43) shows the $a=0$ criterion collapses to $\langle W,Q(W)\rangle\le\theta_0(n)\lVert W\rVert^3$ with $\theta_0(n)=c(n-1)$, **so Conjecture A and the problem $P$ are one statement** (Lemma L0, audit owed)."
- **Exhibited concretely, at $n=13$.** [L43](../findings/problem.md) delivers $P(W)\le\theta_0(13)$, i.e. $P^2\le\frac{264}{169}$. Conjecture A at $n=13$ demands $P^2\le\Theta_{13}^2=\frac{120}{77}$. The first is weaker than the second by exactly $\frac{48}{13013}$, computed in §4. So the cone criterion does not deliver Conjecture A at odd $n$, and the "so" in that sentence is the step the round refuted. [findings/problem.md](../findings/problem.md) says as much in its own words 400 lines earlier ("**Sharpness at even $n$ only** … So this is the Conjecture A **bound**, sharp at even $n$") and that sentence never reached this line. The trailing "audit owed" is also stale: the audit ran, as [r591](../reviews/REVIEW_r591.md) and [r592](../reviews/REVIEW_r592.md).
- **Argued the opposite.** The most charitable reading is that this is a literature-relation bullet rather than a derivation: L43 fixes a target constant, L0 supplies an equivalence, and the "so" chains loosely between two separately-true facts, with the conclusion "Conjecture A and the problem $P$ are one statement" true on its own. I grant that the conclusion is true. What the sentence gets wrong is the constant it names as the one at which they are one statement, and that is precisely the defect the round exists to remove.

### 8.2 [results.md](../results.md):11 against :775, GAP

- **Located.** Line 11 reads "**Proven at both parities** (Lemma L0)"; line 775 ends "**The $\Leftarrow$ direction gives $\sup\le\Theta_n$; the lower half needs the balanced product as witness, which the block asserted and did not cite.**"
- **Exhibited concretely.** [findings/INDEX-results.md](../findings/INDEX-results.md):15 sides with :775, "Also owed: the $\Leftarrow$ direction gives $\sup\le\Theta_n$ and the lower half's witness was asserted, not cited". So two of the three index-level forms record an open debt and the headline table records none, and a consumer reads the headline table first.
- **Argued the opposite.** "Proven" plausibly means the mathematics is settled on the record, which it is, via [L57](../findings/problem.md) and Proposition 2.25, while :775 records a *citation* debt inside one block. Both readings are honest. The finding stands as a state inconsistency rather than a mathematical one, and it is the weakest of the three here.

### 8.3 [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md):7 and [findings/INDEX.md](../findings/INDEX.md):18, the root cause and the exposure, both unrepaired

- **Located.** [r591](../reviews/REVIEW_r591.md) names the root cause in one sentence: "*[Notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) truncates the quotation exactly before the display, which is why the block could be written without the discrepancy showing.*" I read that file. Its Conjecture A section still ends at "*If either $n\ge12$, or $8\le n\le11$ and $W\notin\dots$*". The conclusion $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$, and the sentence naming $W^{\mathrm{crit}}_{\mathrm{sym}}$ as the operator of $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$, appear nowhere in the notes. Separately, [r592](../reviews/REVIEW_r592.md)'s exposure list names [findings/INDEX.md](../findings/INDEX.md):18, which still reads "**PROVED** for all $n\ge12$, $\theta\le\theta_0(n)$, equality exactly at $S^{n/2}\times S^{n/2}$".
- **Exhibited concretely.** A reader of the notes has, on that page, a criticality hypothesis and a dimension hypothesis and no constant at all; the constant is reachable only by turning to the Proposition 2.25 entry and knowing to identify the two. That is the exact epistemic position in which the withdrawn block was written. And at $n=13$, [findings/INDEX.md](../findings/INDEX.md):18's equality clause names a manifold that does not exist, $S^{6.5}\times S^{6.5}$, while its bound $\theta_0(13)=\sqrt{264/169}$ exceeds the sharp $\Theta_{13}=\sqrt{120/77}$ by the $\frac{48}{13013}$ of §4.
- **Argued the opposite.** For the notes: a notes file is an index card, the Proposition 2.25 entry two headings below carries the value, and a reader who needs the conclusion has the extraction line number to go to. For the index row: it belongs to Lemmas 46–48, a different result, and repairing it is that row's business rather than L0's. I accept both, and record them because the report the record cites for this block named them, and because the constant they carry is the constant this block exists to correct.

### 8.4 The sentence flagged and left standing, C11

- **Located.** [findings/problem.md](../findings/problem.md):494, "every quantitative obstruction survives intact on the smaller set."
- **Exhibited concretely.** [r592](../reviews/REVIEW_r592.md) §4.7 flagged this sentence by name: "*unsupported, and no argument is offered. Restricting the domain weakens, rather than preserves, a statement of the form 'no bound below $c$ can hold on $X$'*". The sentence is in the rewrite verbatim. Under the reading where an obstruction is an upper bound on $P$ valid on a set, the claim is trivially true by restriction; under the reading where it is a fence (a witness showing no bound below $c$ can hold), it is false, because the witness may be non-critical. The block does not say which it means.
- **Argued the opposite.** The paragraph's subject is what the equivalence buys, and in that context "obstruction" most naturally means an upper-bound argument, under which the sentence is true and unremarkable. Graded, as r592 graded it, as rhetoric rather than a load-bearing error, with the addition that a sentence a refuting review flagged by name and the rewrite carried through unchanged is worth one line in the ledger.

---

## 9. The gap between what is proven and what is used

**What a reader may take from this block, stated exactly.**

1. **For every $n$ with $\mathcal W_n\ne\{0\}$**, and in particular every $n\ge12$ at both parities: $P$ attains its maximum on the unit sphere of $\mathcal W_n$, at a point that is a critical point of the restriction. Fully argued in the block, and the compactness half is machine-checked in [SphereAttains.lean](../lean/HamiltonsCubic/Results/SphereAttains.lean).
2. **($\Rightarrow$) unconditionally**: if the supremum equals $\Theta_n$ then every critical point satisfies $P\le\Theta_n$. Fully argued.
3. **($\Leftarrow$) in its $\le$ half only, as the block prints it**: if every critical point satisfies $P\le\Theta_n$ then $\sup\le\Theta_n$. Fully argued, and this is the half every downstream use identified by [r592](../reviews/REVIEW_r592.md) actually consumes, three citations, all in [report/](../report/), all at $n\ge12$ with the sphere-product constant.
4. **The full equivalence**, and hence the identification of Problem P with Conjecture A's $n\ge12$ clause, requires in addition $\sup\ge\Theta_n$. That step is *true, unconditional, and published*, Nienhaus Proposition 2.25, but in this block it is a citation inside a defect notice placed after $\square$, with the source unnamed.
5. **The three scope conditions may be cited in full**, at both parities, and are the most reliable part of the block.
6. **The Lagrange form $Q(W)=\theta W$ may not be cited from this block.** It is stated without argument and rests on two Böhm–Wilking facts the block does not name. It is not load-bearing for anything in items 1–5, but it *is* load-bearing for any composition of L0 with Jäger's Theorem A, whose hypothesis is stated in exactly that form ("$W^2+W^\#=\theta W$"), so a consumer chaining L0 to the diagonal grant is consuming an unargued step.

**The gap, in one sentence.** Every other row of this record assumes Problem P and Conjecture A coincide; after this rewrite that assumption is *correct* and its constant is *right at both parities*, and the one sentence that turns the block's inequality into the coincidence is present on the page as a criticism rather than as a step.

---

## 10. What would break this block, and what I did to look for it

**The object that would falsify it.** Not a counterexample to Conjecture A, §2.3 shows the two sides fail together, so a critical point with $P>\Theta_n$ at some $n\ge12$ leaves the biconditional true. What would break it is a source or object showing $P(W^{\mathrm{crit}}_{\mathrm{sym}})\ne\Theta_n$: either a published $\theta_{k,l}$ differing from the record's closed form, or a normalisation mismatch between Nienhaus's $P$ and this record's that shifts the constant by a factor.

**What I did to look for it.** I read Proposition 2.25 verbatim in the extraction and derived the record's spelling from it by the algebra of §0, which is exact and needs no convention to be shared. I then looked for an independent pin that does not pass through that algebra, and found one: Nienhaus's own printed $P(W^{\mathrm{crit}}_{\mathrm{sym},11})=\frac{2\sqrt{30}}9$ at extraction line 4708, whose square is $\frac{40}{27}$, exactly the block's odd closed form at $n=11$ and not $\theta_0(11)^2=\frac{180}{121}$. A normalisation mismatch would have shifted that value; it did not. I also checked the neighbouring $P(W^{\mathrm{crit}}_{\mathrm{sym},10})=\frac65$ against the even form, and it agrees. **No falsifier found, and the constant is now pinned by three independent routes**, the split formula, the record's [L57](../findings/problem.md) closed form, and the source's own two printed values.

**The falsifier I did find is procedural, not mathematical**: the source note that made the original error possible, [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md):7, still stops before the conclusion, so the same substitution remains available to the next block written from it.

---

## Verdict

**`GAP`.**

The rewrite does what the refutation asked on the constant, and does it correctly and completely: every figure I evaluated by hand is exact, the three scope conditions are each backed by a line of the published statement I read, the two-case argument that the withdrawn form asserted Conjecture A's negation is right, and the brief's second carried-in trap is not merely avoided but answered head-on. The biconditional is a biconditional.

What is owed is one sentence, and the review the record cites for this block prescribed it as repair item 2: **the witness belongs inside the proof, before $\square$, cited to Nienhaus Proposition 2.25 or to [L57](../findings/problem.md)**, so that a consumer reading the Lemma and its Proof gets the equivalence rather than an implication and a defect notice. Two further items are owed outside the block and both were named by the same review: [results.md](../results.md):46 still composes [L43](../findings/problem.md)'s $\theta_0(n)$ into the identification, which is false at odd $n$, and [notes.md](../references/nienhaus-2023-second-best-einstein/notes.md):7 still truncates the published conjecture before its conclusion.
