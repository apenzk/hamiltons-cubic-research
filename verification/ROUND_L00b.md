# ROUND L00, the block itself, correctly targeted

**Id:** L00. **Source:** [findings/problem.md](../findings/problem.md):470–500 (*the block headed "Lemma L0), problem p and conjecture a are the same statement", **not** the diagonal-case section, which is a different lemma's argument.* **Date:** 2026-09-06. **Verifiers allocated:** v92, v93, v94. **Phase:** 1, dispatched.

**Why this id, and why a second attempt.** Round 1 closed `GAP`, *five readers of five agreeing the block named the wrong section as its argument, and three scope conditions missing*, and **rewrote the block. The rewrite has never been read.** *A first attempt to read it was itself briefed against the wrong section and is recorded separately.*

**This is what the whole record rests on.** *Every other row assumes Problem P and Conjecture A are the same statement.* **A defect here is a defect everywhere.**

**A repair is a new result**, and which passages are the rewrite is deliberately not marked.

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Is the biconditional a biconditional?** *The block claims two statements are the same.* **Check each direction separately, name the hypothesis each needs, and say whether one direction is an implication wearing an equivalence's clothes.** *A neighbouring section was found asserting an identity that its own text denies nine lines away.*
2. **Do the three scope conditions cover what the record spends them on?** *Round 1 found them missing and they were written in.* **Check each against a named object, and say what a consumer may cite.**

**Two traps named from outside the block, both found in the last day.** *A published constant here is $\Theta_n$ and not $\theta_0(n)$, and they differ at odd $n$, $\Theta_{13}^2=\tfrac{120}{77}$ against $\tfrac{264}{169}$.* And **Conjecture A as published hypothesises criticality**, while a criterion quantifying over every unit Weyl operator implies it without being implied by it.

**A source is read, never cited from memory.** *If a source is not in [references/](../references/), say the claim rests on an unread source.*

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

#### Lemma L0, problem p and conjecture a are the same statement

*an audit, a prior review and a prior review on identical briefs, **both REFUTED as stated and both repaired it the same way**. Restated below with $\Theta_n$; the withdrawn form is recorded beneath.*

> **THE CONSTANT WAS THE EVEN-$n$ EVALUATION OF THE RIGHT ONE.** Conjecture A concludes at $P(W^{\mathrm{crit}}_{\mathrm{sym}})$, the value at $S^{\lceil n/2\rceil}\times S^{\lfloor n/2\rfloor}$, the record's $\Theta_n$. Writing $\theta_0(n)$ for it is correct at even $n$ and **false at every odd $n\ge13$**, where
> $$\theta_0(n)^2-\Theta_n^2=\frac{8(n-1)}{n^2(n+1)(n-2)}>0,\qquad\text{since }(n-2)^2(n+1)-n^2(n-3)=4\ \text{identically}.$$
>
> **That $4$ is [Conjecture L16](../findings/problem.md#conjecture-l16-the-defect-penalty-inequality-canonical-statement-and-proof)'s constant margin, so the two blocks turn on one identity**, L16 reads it as a gap between $\Theta_n$ and $\theta_0(n)$ that never closes as $n$ grows, this block as the reason a substituted constant asserted the conjecture's own negation. *Both directions checked in [L0.lean](../lean/HamiltonsCubic/Results/L0.lean) and [L16.lean](../lean/HamiltonsCubic/Results/L16.lean).*
> **As written the biconditional implied Conjecture A is FALSE at odd $n$**, with no hypothesis: either a critical point exceeds $\theta_0(n)>\Theta_n$, or the maximiser carries $P=\theta_0(n)>\Theta_n$. Witness $n=13$, $\theta_0^2=\tfrac{264}{169}$ against $\Theta_{13}^2=\tfrac{120}{77}$.

Fix $n\ge12$. Then:

$$\sup\{P(W):W\in\mathcal W_n,\ \lVert W\rVert=1\}\;=\;\Theta_n\quad\Longleftrightarrow\quad P(W)\le\Theta_n\ \text{at every critical point of }P|_{\lVert W\rVert=1},$$

with $\Theta_n=\theta_0(n)=\frac{\sqrt{2(n-1)(n-2)}}n$ at even $n$ and $\Theta_n=\sqrt{\frac{2(n-1)(n-3)}{(n+1)(n-2)}}$ at odd $n$, and each side is then the $n\ge12$ clause of Conjecture A **at both parities**. **Three scope conditions are part of the statement**, each supplied by the round rather than by the original:

- **The claim is about the maximum VALUE, not about the maximiser.** Conjecture A is a non-strict inequality carrying no equality clause, so it is equivalent to attainment of $\Theta_n$ and not to uniqueness of the point attaining it. Rigidity is a separate statement with a separate proof.
- **"Conjecture A" means its $n\ge12$ clause alone.** The published conjecture is a conjunction, its second clause covering $8\le n\le11$ with $SO(n)\cdot W_{\mathbb{CP}^2}$ removed; an $n\ge12$ statement cannot imply it, and that clause carries live content, at $n=10$, $\theta_{10}^2=36/25<3/2=P(W_{\mathbb{CP}^2})^2$.
- **"Products of spheres" means the balanced split.** $\theta_{k,l}^2=2\frac{n-1}{n-2}\left(1-\frac{n-1}{kl}\right)$ is strictly increasing in $kl$, so the maximum over splits is at $k=\lceil n/2\rceil$, **and this is the condition that broke the lemma**, since at odd $n$ that split's value is $\Theta_n$ and not $\theta_0(n)$, and the unbalanced products are critical but strictly sub-maximal, $\theta_{5,7}^2=264/175<55/36=\theta_{6,6}^2$.

**Proof.** $\mathcal W_n$ is finite-dimensional, so $\{\lVert W\rVert=1\}$ is compact and the polynomial $P$ attains its maximum on it, at some $W_{\max}$. A maximum of a smooth function on a smooth constraint surface is a critical point of the restriction, so $W_{\max}$ is critical, for $P|_{\lVert W\rVert=1}$, whose Lagrange condition is $Q(W)=\theta W$ with $\theta=P(W)$, and never for $P$ on $\mathcal W_n$. **($\Rightarrow$)** If the supremum is $\Theta_n$ then $P\le\Theta_n$ everywhere, critical points included. **($\Leftarrow$)** If $P\le\Theta_n$ at every critical point then $P(W_{\max})\le\Theta_n$, and $P(W_{\max})$ is the supremum, **so this direction gives $\sup\le\Theta_n$ and not the equality.** $\square$

> **THE LOWER HALF IS A SEPARATE CLAIM AND THE BLOCK ASSERTED IT.** $\sup\ge\Theta_n$ needs a witness: the balanced product itself, admissible in $\mathcal W_n$ and carrying $\theta=\Theta_n$ by the $\theta_{k,l}$ formula below. **Both reviewers found the witness cited nowhere in the block.** It is one citation rather than an argument, and writing the Lagrange condition explicitly is what makes the omission visible, that condition is verbatim the published form of Conjecture A, and its absence is what let a substituted constant pass unread.

**What the equivalence does and does not buy.** It is a definitional reduction: it moves the quantifier from all of $\mathcal W_n$ to the critical set, and every quantitative obstruction survives intact on the smaller set. The one thing it removes is the criticality hypothesis, for free, by compactness, which is why a localisation theorem that removes the same hypothesis at a cost buys nothing here.


#### Lemma L43, the criterion at $a=0$ demands exactly $\theta_0(n)$

*Numbered here on 2026-08-31: the result was numbered in [report/](../report/) and the mathematics has always been in this file, but it carried no block. The argument is in this file under **"The diagonal case: located in the literature, and it covers less than assumed"**, the title, which once broke off mid-phrase here.*

## Phase 1, returns, and the round's verdict

**All three `GAP`, unanimous on every material point.**

**The biconditional is not one, and the block says so on the step.** *$(\Rightarrow)$ is complete and consumes no hypothesis; $(\Leftarrow)$ yields $\sup\le\Theta_n$ only.* **The closing half appeared after the $\square$, inside a box headed as a defect report, with its source unnamed**, *a refuting review had prescribed four repairs, and this was the one that did not land.*

**The lower half is one citation, and two readers found it at source.** [Nienhaus Proposition 2.25](https://arxiv.org/abs/2311.02404) gives a unit $W_{S_{k,l}}\in\mathcal W_n$ with $W^2+W^\#=\theta_{k,l}W$ and $P=\theta_{k,l}$ at every split. *Supplied inside the proof.*

**The split on the supremum is settled 2–1 by the source itself.** *One reader had $\sup=\sqrt{3/2}$ at $n=13$, attained at padded $\mathbb{CP}^2$; Nienhaus prints his own $P(W^{\mathrm{crit}}_{\mathrm{sym},11})=\tfrac{2\sqrt{30}}9$, whose square is $\tfrac{40}{27}=\Theta_{11}^2$ and not $\theta_0(11)^2$.* **The witness exists, so the supremum reaches $\Theta_n$ and the outlier value is wrong.**

**And the root cause was one level below the record.** *[notes.md](../references/nienhaus-2023-second-best-einstein/notes.md) quoted Conjecture A and **stopped before its conclusion**, omitting both the $\mathbb{CP}^2$ exclusion and $P(W)\le P(W^{\mathrm{crit}}_{\mathrm{sym}})$.* **With the conclusion missing from the record's own note, neither $\Theta_n$ nor the criticality hypothesis was visible, which is exactly what left both substitutions available**, across four files. *The block was audited twice and neither round went back to the note.*

**Verdict: `GAP`, repaired. Impact: `NARROWS`.**

**What a consumer may now cite:** the constant $\Theta_n$; the gap $\tfrac{8(n-1)}{n^2(n+1)(n-2)}$; attainment at a critical point; the identification at $\Theta_n$ with its $(\Leftarrow)$ half closed by a named witness; and **the block's real deliverable, "bounded at critical points $\Rightarrow$ bounded everywhere", the free removal of criticality, which no finding touched.**

**Owed:** the two uncited Böhm–Wilking facts behind the Lagrange form, and a Lean layer that reaches the biconditional rather than its shortfall. *The second is a row for the [lean-loop](../.claude/skills/lean-loop/SKILL.md) under the rule added this session.*
