# ROUND L147-r2, the corrected text, rebuilt after the radius was refuted

**Id:** L147-r2. **Source:** [findings/second-order.md](../findings/second-order.md):1163–1188. **Date:** 2026-09-06. **Verifiers allocated:** v54, v55, v56. **Phase:** 1, dispatched.

**Why the brief was rebuilt.** *This round was opened against yesterday's text and its verifiers were never dispatched. The entry changed materially in between*, **its `HYPOTHESIS-DEBT` on the radius closed by refutation rather than by payment**, the joint minimisation having been done and having failed to reach the claimed exponent. **A brief quoting text that no longer exists sends three readers to audit a passage the record does not carry**, so it is rebuilt from the current source.

**Why this id.** L147's text was audited and repaired, and **the repair has never been read.** [ROUND_L145](ROUND_L145.md) established that the corrected texts of L146–L149 carry the block's surviving lower bound rather than resting on it.

**A repair is a new result.** Each was written by the loop that found the defect, under the pressure of a finding, and entered the record without cold readers. **The verifiers are not told which passages are new.**

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Does the entry state one thing about its radius?** *A debt closed by refutation leaves two kinds of sentence behind, the claim, and the note recording that it was owed.* **Check whether any passage still asserts what the refutation removed**, and whether the ceiling and the floor are stated as the different objects they are.
2. **Is the $\Theta(n^{-1})$ ceiling a bound on the radius or on the method?** *A ceiling on what a route can prove is not a bound on the quantity.* **Say which this is, where the distinction is drawn, and whether every use of it respects the distinction.**

**One trap named, because it was found from outside this entry and is not visible from within it.** The entry justifies $M=O(\rho)$ somewhere in its chain. **Check what that justification rests on, and whether it survives the domain the consumer integrates over.**

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

#### Lemma L147, the tube radius tracks $\sup\lvert P\rvert$ on $\beta\in[0,\tfrac12]$, and the route ends at $\Theta(n^{-1})$

*Derived 2026-09-03 by re-running a prior review's chain.  Every reason the first version gave was wrong; the two values survive.*

> **LEMMA L147.** *With $\sup\lvert P\rvert=\Theta(n^\beta)$,*
> $$r_n\;\gtrsim\;n^{-3/2}\qquad\text{on }\beta\in[0,\tfrac12],$$
> *and the route is capped at $\Theta(n^{-1})$. **$\beta=\tfrac12$ gives $n^{-3/2}$ and is confirmed, pinned by the $P$-side branch alone. $\beta=0$ gives $n^{-1}$ and is plausible with an unpinned constant.***

**The admissible range is a closed interval, and that is what makes the ceiling question empty.** $\sup\lvert P\rvert\ge P(W^*)=\theta_0(n)\uparrow\sqrt2$ forces $\beta\ge0$; [Lemma L143](bounds.md) forces $\beta\le\tfrac12$. *So the radius lives in $[n^{-3/2},n^{-1}]$ and there is no region in which a ceiling above $n^{-1}$ could bind.* **The first version claimed "no ceiling", which is false four separate ways**, the $P$-side branch caps itself at $c_p/\theta_0\le3/(n-2)$; the corrected quartic branch is $\Theta(n^{-1})$; the validity cap $r_n\le\rho/2$ is $O(g_n)$ on the directions where $\rho=\Theta(g_n)$; and $\beta\ge0$ empties the region regardless.

> **THE SUBSTITUTION $\lVert A''\rVert=O(1)$ IS WRONG BY $\sqrt n$, AND BOTH REVIEWERS DERIVED THE SAME REPLACEMENT.** $M=\sup_{\lvert z\rvert=\rho}\lVert A\rVert$ is a supremum **over the disc**, so it grows with it: $x\mapsto x_-$ is $1$-Lipschitz in Frobenius norm and $\lVert\mathrm{Alt}\rVert\le1$, giving $M=O(\rho)$ and hence
> $$\lVert A''\rVert=O(M/\rho^2)=O(1/\rho)=O(n^{1/2})\quad\text{on the margin summand},$$
> *which returns the record's own $O(n)$ at $\rho=\Theta(g_n)$, as it must.* **$O(1)$ would need $\lVert H\rVert_{op}=O(g_n)$, which is a prior review's actual mechanism; [Lemma L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) meets only the weaker $o(1)$ wording of that test.*

> **AND IT WAS A QUANTIFIER ERROR.** [Lemma L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) bounds one summand; the chain's $\lVert A''\rVert$ ranges over **eight** of [Lemma L27](nondegeneracy.md)'s ten, $\langle W\rangle$ and the orbit summand are removed exactly by $H\perp W^*$ and $H\perp T_{W^*}\mathcal O$, *which is not bookkeeping: at ten the margin floor would be $-\tfrac32\theta_0$.* *A single mixed direction with $u\asymp n^{-1/2}$, margin $\Theta(1/n)$ and $\lVert A''\rVert=\Theta(n)$ restores $n^{-3/2}$ at every $\beta$.* **Both reviewers closed the sweep the lemma owed**: $\lVert H\rVert_{op}\le\Theta(n^{-1/2})+w$ by the triangle inequality and $c(H)\gtrsim c_p+w^2$ since $L_e$ is scalar on each summand, uniformly in $w\in[0,1]$. It returns these values and the $\Theta(n^{-1})$ ceiling.

> **HYPOTHESES, AND THE DEBT.** *Base point $W^*=S^m\times S^m$; $n=2m$ even; $n\ge12$, which the imports force through $n^2-12n+8>0$; and $\ker W^*=0$, **all four used and none stated until a prior round.*** The kernel one has a named witness: $W_{\mathbb{CP}^2}$ is Morse–Bott nondegenerate with $\dim\ker W=3$, so $g_n$, $\rho$, $M$ and branches 2–3 **do not exist there**.
>
> **The $\Theta(n^{-1})$ ceiling is proved**, by $c_p/S\le c_p/\theta_0=3/(n-2)$ alone, exact and unconditional in $\beta$. *Its reason (b) is unproven and false where read: it needs a **lower** bound on $\lVert A''\rVert$, and [L148](../findings/second-order.md#lemma-l148-the-defect-vanishes-identically-on-the-margin-summand) sets that to zero on the very summand.*
>
> **THE RADIUS $r_n\gtrsim n^{-1-\beta}$ IS REFUTED, AND THE DEBT AGAINST IT IS CLOSED BY REFUTATION RATHER THAN PAID.** *It was recorded here as asserted and derived nowhere, with the joint minimisation over $w$ owed. **The minimisation has now been done and it does not reach $n^{-1-\beta}$**: branch 1 is $(c_p+u^2)/(S+au)$ with $f'(0)=-ac_p/S^2<0$, so its infimum is $2u^*/a=\Theta(n^{-3/2})$ at $w=\Theta(1)$, **too large on all of $\beta\in[0,\tfrac12)$**.* **What survives is $r_n\gtrsim n^{-3/2}$**, which is [L145](../findings/second-order.md#lemma-l145-the-constant-chain-for-the-balanced-orbit-tube-radius-and-the-lower-bound-r_nomegan-32-it-supports)'s own order and is untouched. *Two adjudicators on identical briefs, [a prior round-F](../verification/a prior round.md) F12.*

**The chain has two branches, not three.** $f(u)=(c_p+u^2)/(S+au)$ has $f'(0)=-ac_p/S^2<0$, so $u=0$ is **never** its minimum; the minimum is interior at $u^*=(\sqrt{S^2+a^2c_p}-S)/a$ with $f(u^*)=2u^*/a=\Theta(\min(c_p/S,\sqrt{c_p}/a))$, at every $\beta$ and every $a$. *The first version argued the cubic branch collapses to $u=0$ because the denominator is $S+u$, a reason that never uses $a$, and which would erase a prior review's confirmed $n^{-3/2}$ cap.* **So the cubic branch always shadows the quartic, and "both defect branches moved out of the way" is impossible in principle.**

**$\gtrsim$, not $\Theta$.** The chain is an inequality, [Lemma L145](../findings/second-order.md#lemma-l145-the-constant-chain-for-the-balanced-orbit-tube-radius-and-the-lower-bound-r_nomegan-32-it-supports) withdrew its own equality reading, and $\sup\lvert P\rvert$ is bracketed rather than known, so $\beta$ is not an exponent. *The first version wrote $\Theta$, the exact error L145 step 4 had been corrected for two entries earlier.*

## Phase 1, returns

- **v55** · `BROKEN` · [VERIFY_v55.md](VERIFY_v55.md).

**Question 1: three passages still assert what the refutation removed.** *The **LEMMA box itself** carries "$\beta=0$ gives $n^{-1}$ and is plausible" (which is $n^{-1-\beta}$ at $\beta=0$) while the refutation box **fourteen lines below** says that form is too large on all of $\beta\in[0,\tfrac12)$.* **The entry's own $f(u^*)=2u^*/a$ gives $\Theta(n^{-3/2})$ there, off by $n^{1/2}$.** And the **title** asserts the $\beta$-dependence the refutation removed, the surviving bound being $\beta$-free except at the endpoint. *The refutation note itself is accurate and reproduces in full, it simply never reached the statement.*

**Question 2: the ceiling bounds the method, and the entry does not respect the distinction.** *It is never drawn in L147.* **"So the radius lives in $[n^{-3/2},n^{-1}]$" writes it as a bound on the quantity**, against [L145](../findings/second-order.md)'s explicit *"caps what the route can prove rather than the radius"*. Two further sites do the same. *The ceiling itself is proven, by $c_p/S\le c_p/\theta_0=3/(n-2)$, exact and unconditional in $\beta$.*

**D5 is the one that reaches the surviving claim, and it is the gap this round was told to look for.** *$M=O(\rho)$ quotes a prior review with **"on Hermitian operators" deleted**, under a supremum over a complex circle.* **Filed as [ROUND_L147](ROUND_L147.md)'s F6, never adjudicated, and the text is verbatim unchanged in this revision.** *Without it, $\lVert A''\rVert=O(1/\rho^2)=O(n^2)$ and $f(u^*)=\Theta(n^{-5/2})$, the headline falls.*

**D6 and D7.** *The statement box carries **no hypothesis at all**, so it is false at an orbit-tangent $H$ where $c(H)=0$*, **the identical defect [L148](../findings/second-order.md) was repaired for in [ROUND_L148-r2](ROUND_L148r2.md)**, unrepaired here. And $c(H)\gtrsim c_p+w^2$ is the un-repaired twin of a sentence L149 marks unsafe at $n\in\{12,14\}$.

### D8 lands on this round's own repair, made an hour before it was dispatched

**[results.md](../results.md):363 now states the minimiser "at $u=\Theta(1)$", and $u^*\le\sqrt{c_p}=\Theta(n^{-1/2})$ always.** *That clause was written today, repairing the $u$-for-$w$ substitution F12 was adjudicated about, and it introduced a new error into the canonical file while removing the old one.* **Held for v54 and v56 like every other finding**, but recorded here because the round is the author.

- **v56** · `BROKEN` · [VERIFY_v56.md](VERIFY_v56.md). Reaches v55's findings independently, the $\beta=0$ clause, the ceiling written as a bound on the quantity, the excluded mixed direction, the missing hypotheses, and traces the $\beta=0$ clause's provenance to a review verdict **written before the minimisation existed**.

### And it overturns the status of the refutation this session applied

**"Every branch is a lower bound, so a small value of the $\min$ refutes nothing about $r_n$."** *[L145](../findings/second-order.md) says the chain cannot yield an upper bound at all, so exhibiting a smaller lower bound does not falsify a larger one.* **The correct status is `withdrawn for want of proof`, which leaves $r_n\gtrsim n^{-1-\beta}$ open rather than false.** *And the $\Theta(n^{-3/2})$ that replaced it reads branch 1's numerator at $c_p$, the $w\approx0$ floor, while reading its denominator at $w=\Theta(1)$, two different points of the same branch.*

**This lands on [ROUND_L149-F](ROUND_L149F.md)'s F12, upheld by two adjudicators, and on the repair this session made from it.** *The finding that $u=0$ is not branch 1's minimum stands; what does not is the inference from it that the boxed bound is **refuted**.* **A lower bound is not refuted by a smaller lower bound**, and the entry, the plan and the canonical file were all edited today on the stronger reading.

**On the trap.** v56 confirms v55's D5 and adds where the surviving route costs: the Hermitian qualifier is deleted, and *the Riesz/resolvent derivation that does survive costs [L156](../findings/second-order.md)'s contour constant, unbounded as $\gamma\uparrow d$*. **Conclusion stands, written reason does not.**

- **v54** · `GAP` · [VERIFY_v54.md](VERIFY_v54.md). Third agreement, and it states the reversal most sharply: *"the paragraph that closes the radius debt 'by refutation' is **itself refuted by the two inequalities the entry states one paragraph above it**"*. **It also names what may pay the debt** (a prior review's A1, cited by the entry and never read against it) and gives the genuine joint minimisation of $(c_p+w^2)/(S+n\max(n^{-1/2},w)w)$ as $\Theta(n^{-1-\beta})$ attained at $w=0$, *which would pay the claim rather than refute it*. **On the trap it is firmest of the three: not a debt at all**, the same review carrying a complex-valid resolvent derivation, *"the entry cited the wrong one of its two"*.

## Phase 2, the clustering

| id | finding | support |
|---|---|---|
| **K1** | The refutation of $r_n\gtrsim n^{-1-\beta}$ is invalid (a lower bound is not falsified by a smaller one), **and its arithmetic read one branch at two points** | v54, v55, v56 |
| **K2** | The box's $\beta=0$ clause and the refutation box fourteen lines below **contradicted each other on the page** | v54, v55, v56 |
| **K3** | $M=O(\rho)$ drops *"on Hermitian operators"* under a complex supremum, and the entry **cited the wrong one of its source's two routes** | v54, v55, v56 |
| **K4** | The ceiling is written as a bound on the radius in three places, where the source says *"for this method"* | v54, v55, v56 |
| **K5** | The statement box carried **no hypothesis**, and is false at an orbit-tangent $H$, the defect [L148](../findings/second-order.md) was repaired for | v55, v56 |
| **K6** | The mixed-direction witness is excluded by the entry's own next two sentences | v54, v55, v56 |
| **K7** | [results.md](../results.md)'s *"at $u=\Theta(1)$"* is false with no charitable reading, **written by this round an hour before dispatch** | v54, v55 |

## Phase 5, the round's verdict

**`BROKEN`, repaired. Impact: `NARROWS`.**

**The round reversed its own author.** *Six entries were repaired by this session today; this is the first cold read of one of them, and it overturned the session's central change and found a fresh error introduced into the canonical file while another was being fixed.* **K1 and K7 are both against text written hours earlier, and K7 replaced one error with another.**

**What stands after it.** [L145](../findings/second-order.md)'s $r_n=\Omega(n^{-3/2})$, on its own proof. The ceiling, by $c_p/S\le c_p/\theta_0=3/(n-2)$, exact and $\beta$-free. The eight-of-ten reduction, the $-\tfrac32\theta_0$ floor, $\beta\in[0,\tfrac12]$, and $n\ge12$ from $n^2-12n+8>0$.

**What is owed.** The joint minimisation that would pay $r_n\gtrsim n^{-1-\beta}$ (*one reader reports it as $\Theta(n^{-1-\beta})$ at $w=0$ and it is unadjudicated*) and the complex-valid route for $M=O(\rho)$, whose cost is [L156](../findings/second-order.md)'s contour constant, unbounded as $\gamma\uparrow d$.

**The queue's remaining two `-r2` rounds should not be run from these hands.** *This round's own findings are the argument.*
