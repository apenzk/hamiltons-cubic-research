# I13, step 3, the Jacobi enumeration, run under approval

**The run.** [run_jacobi_closure_d3.py](../scripts/runs/run_jacobi_closure_d3.py), seconds, approved by the user for this task under the analysis-only rule. For each of the $\binom{10}4=210$ candidate vanishing sets $Z$ it builds the bracket table $B(i,j)=\{k:\{i,j,k\}\notin Z\}$ and tests the Jacobi index inclusion
$$\bigcup_{m\in B(i,j)}B(m,k)\ \subseteq\ \Big(\bigcup_{m\in B(j,k)}B(i,m)\Big)\cup\Big(\bigcup_{m\in B(i,k)}B(j,m)\Big)\quad\text{for all }i,j,k,$$
whose failure forces a bracket outside $Z$ to vanish and so contradicts $Z$ being the *exact* vanishing set.

**Controls, and the first set of them was worthless.** The run refuses to report unless the symmetric-pair support passes and a hand-checked bad support fails. *The first negative control chosen was $\{111,112,113,122\}$, described as "$E_1$ nearly an ideal", and it **passed**, correctly, because $E_1$ is an ideal only if the five types $112,113,122,123,133$ vanish, which no four-subset can do. That control tested nothing.* The replacement is verified by hand: at $Z=\{111,112,122,123\}$ the table gives $B(1,2)=\varnothing$, so $[E_1,E_2]=0$ and Jacobi forces $[[E_1,E_1],E_2]\subseteq[E_1,[E_1,E_2]]=0$; but $B(1,1)=\{3\}$ and $B(2,3)=\{2,3\}$ make that bracket nonzero. Contradiction, and the run rejects it.

## RESULT, as it stands after Gate 2, the Jacobi filter is a heuristic, not a bound

*[r347](REVIEW_r347.md) and [r348](REVIEW_r348.md) on identical briefs. Both **REFUTED** the justification below; the session reproduced every count independently and settled the one place the two reviewers differed.*

> **THE INDEX INCLUSION IS STRICTLY STRONGER THAN JACOBI, SO $121$ IS A FILTER'S OUTPUT AND NOT AN UPPER BOUND ON ADMISSIBLE SUPPORTS.** Jacobi gives a **subspace** inclusion; the index test compares the two sides' **support upper bounds**, and passing between them needs the left side to attain its bound. [r348](REVIEW_r348.md)'s counterexample: in $\mathfrak{so}(4)=\mathfrak{su}(2)_A\oplus\mathfrak{su}(2)_C$ take $E_1=\langle A_1,A_2\rangle$, $E_2=\langle A_3,C_1,C_2\rangle$, $E_3=\langle C_3\rangle$, a genuine orthogonal decomposition with an ad-invariant form, on which Jacobi holds identically and the index test **fails**. The mechanism: $[E_1,E_1]$ is the *proper* subspace $\langle A_3\rangle$ of $E_2$, so its bracket with $E_2$ misses $E_3$ although $[E_2,E_2]$ hits it. **The test assumes bracket supports compose exactly, and they do not.**

> **AND "EXACT VANISHING SET" EXCLUDES THE DEGENERATE VERTICES.** A vertex has *at least* four active constraints, so its vanishing set may have five or more members, and [Lemma L105](../findings/bounds-relaxations.md)'s own optimum at $d=2$ sits at exactly such a degenerate vertex. An enumeration that builds the bracket table from a four-subset and calls it exact cannot see them.

**What survives, and it is the part that never used realisability.** The nine row identities are pure statements about the linear system, so they bound $\theta^\ast(\lambda)$ with no grading, no bracket reading and no Jacobi. **They are the only cut here that narrows the bound.**

| filter | status | count |
|---|---|---|
| the six identities whose right-hand side is *proved* nonzero ($\nu_i[(n-1)\nu_j+\theta]$) | **proved** | $210\to204$ |
| $+$ the pair cut of §G3 | **proved** | $\to\mathbf{179}$ |
| $+$ the three identities with **quadratic** right-hand sides | *conditional, their nonvanishing is not shown* | $\to177$ |
| the Jacobi index test | **refuted as a deduction**; a heuristic filter | $210\to121$, not a bound |

**The sharpest correction, and it inverts the note's own emphasis.** Of the nine identity four-subsets, exactly **three** pass the Jacobi filter, and they are precisely the three with **quadratic** right-hand sides. *The six with the clean $\Pi$-bound reading, the only six this note proved nonzero, cut nothing beyond Jacobi.* So the $121\to118$ step rested entirely on three conditions never shown to be nonzero, and at the $n=12$ witness one of them degenerates at $\theta=0.6335$, well inside the $\Pi$-bound $1.4078$, **so "the $\Pi$-bound strict" does not license that cut.**

**Two errors of fact in the previous text, both corrected here.** *(i)* "Three of the nine were already excluded by Jacobi" should read **six**; the number $118$ was right and the sentence was not, $3$ is the count that are Jacobi-*consistent*, hence the count that cut anything. *(ii)* "Vanishing exactly at $\Pi$-saturation" is false when $\nu_2<0$, where the degeneracy sits at $\theta=(n-1)\lvert\nu_2\rvert$, strictly inside the bound.

**Where the two reviewers differed and how it was settled.** [r347](REVIEW_r347.md) kept $110$; [r348](REVIEW_r348.md) withdrew it to $112$. Recomputing from scratch: six of the nine are Jacobi-rejected, three are Jacobi-consistent, and those three are exactly the quadratic ones, so **r348 is right** and the heuristic chain's honest endpoint is $112$. *The number that matters is neither: it is $179$, the proved bound.*

## Superseded, the original result paragraph


> **$121$ of the $210$ four-subsets are Jacobi-consistent.** The cut is real (it removes $89$, or $42\%$) and it is **not** a collapse. The two-family hypothesis of [DERIVE-sp3b](DERIVE-sp3b.md) is refuted twice over: by the count, and by the retraction of its $\mathbb Z_3$ half.

**Of the 121, none is a full grading** (none has every $B(i,j)$ a singleton) and $21$ have some $[E_i,E_j]$ vanishing entirely. *It was this line that exposed the retraction*: a $\mathbb Z_3$-grading, had it been a four-zero vertex as claimed, would have appeared here.

**What the number is and is not.** The index inclusion is a **necessary** condition, so $121$ is an *upper bound* on the admissible supports; the true count is at most that. And LP feasibility at each support is a **separate** filter, not applied here, [r343](REVIEW_r343.md)'s correction, that the unfiltered maximum over supports exceeds $\theta^\ast$, applies to this list unchanged. **So $121$ is the size of a candidate list, not of an answer.**

## What this settles for the plan

**The outcome is the second of the two [plan.md](../plan.md) recorded.** $d=3$ does **not** collapse to named algebras under Jacobi alone, so the regime is not settled by arithmetic on a finite short list. The enumeration remains finite and each member is a named algebraic configuration, which is what [DERIVE-sp3](DERIVE-sp3.md) claimed for it; what fails is the hope that Jacobi would cut it to two.

**The next cut is feasibility, and it is the one with teeth.** [r343](REVIEW_r343.md) reports that the sign pattern of the spectrum removes $84$ of the $210$ twice over through (B) and a further $28$ through (C); those cuts and this one have not been intersected. **That intersection is the next step and it needs no new approval**, it is set arithmetic on lists already computed.

**Gate 2 owed on this note and on the retraction.**

## Addendum, the sign cut, derived rather than borrowed, and r343's numbers left unvalidated

**[r343](REVIEW_r343.md)'s (B) and (C) cuts could not be reproduced, so they are not applied.** Its report states that $t_{133}>0$ whenever $\nu_2>0$ and $\nu_2+\nu_3>0$, removing $84$ of the $210$, with a companion condition on $t_{113}$ and a further $28$ from (C). Working row $1$ against the multiplier $\varphi(x)=(x-\nu_1)(x-\nu_2)$ (the natural choice, since it annihilates the $t_{111}$ and $t_{122}$ coefficients), gives

$$-\mu_1\mu_2(\nu_1-\nu_2)^2t_{112}-\mu_1\mu_3(\nu_1-\nu_2)(\nu_1-\nu_3)t_{113}+\mu_2\mu_3(\nu_1-\nu_2)(\nu_2-\nu_3)t_{123}+\mu_3(\mu_3-1)(\nu_1-\nu_3)(\nu_2-\nu_3)t_{133}=2\nu_1\big[(n-1)\nu_2+\theta\big],$$

whose surviving coefficients have **mixed** signs under $\nu_1>\nu_2>\nu_3$, so it yields no one-sided bound on $t_{133}$ alone. *r343 may have used a route this note has not found; until that route is in hand its counts are unvalidated and none of them is folded in.*

**What the same identity does give, and it is weaker but proved.** Move the two negative terms across: with $\nu_1>\nu_2>\nu_3$ every bracket factor is positive, so
$$\mu_2\mu_3(\nu_1-\nu_2)(\nu_2-\nu_3)\,t_{123}+\mu_3(\mu_3-1)(\nu_1-\nu_3)(\nu_2-\nu_3)\,t_{133}\;=\;2\nu_1\big[(n-1)\nu_2+\theta\big]+(\text{nonnegative terms in }t_{112},t_{113}).$$

> **CUT.** *At a three-eigenvalue critical point with $\nu_1>\nu_2>0>\nu_3$ and $\theta>0$, the right-hand side is strictly positive, so $t_{123}$ and $t_{133}$ cannot both vanish.* Hence **no vertex support contains both $\{123\}$ and $\{133\}$.**

**Intersecting the two filters.** Of the $210$ four-subsets, $28$ contain both types; $9$ of those are Jacobi-consistent; so the list drops from $121$ to **$112$**. *The split symmetric pair survives, as it must, and is carried as the control.*

**The cut is small, and saying so is the point.** Nine supports removed against $89$ from Jacobi. Whatever r343's stronger cuts turn out to be, this note has not earned them, and the honest list at $\nu_2>0$, $\theta>0$ is $112$, still a candidate list, since LP feasibility remains unapplied.

## The nine row identities, and the cut they give

**The right criterion is not the sign pattern, it is whether the identity's right-hand side can vanish.** Each row $i$ against the multiplier $\varphi(x)=(x-\nu_a)(x-\nu_b)$ annihilates the coefficients of the two types $\{i,a,a\}$ and $\{i,b,b\}$, leaving **exactly four** surviving types. If all four of those vanish the left side is zero, so the identity forces its right side to vanish too. **Hence a nonzero right-hand side forbids that four-subset outright, whatever the coefficient signs**, the earlier attempt to read a cut off the signs was looking for the wrong thing.

| forbidden four-subset | unless the right-hand side vanishes |
|---|---|
| $\{112,113,123,133\}$ | $\nu_1\big[(n-1)\nu_2+\theta\big]=0$ |
| $\{112,113,122,123\}$ | $\nu_1\big[(n-1)\nu_3+\theta\big]=0$ |
| $\{122,123,223,233\}$ | $\nu_2\big[(n-1)\nu_1+\theta\big]=0$ |
| $\{112,122,123,223\}$ | $\nu_2\big[(n-1)\nu_3+\theta\big]=0$ |
| $\{123,133,223,233\}$ | $\nu_3\big[(n-1)\nu_1+\theta\big]=0$ |
| $\{113,123,133,233\}$ | $\nu_3\big[(n-1)\nu_2+\theta\big]=0$ |
| $\{111,112,113,123\}$ | $(n-2)\nu_2\nu_3-\nu_1^2+\nu_1(\nu_2+\nu_3+\theta)=0$ |
| $\{122,123,222,223\}$ | $(n-2)\nu_1\nu_3-\nu_2^2+\nu_2(\nu_1+\nu_3+\theta)=0$ |
| $\{123,133,233,333\}$ | $(n-2)\nu_1\nu_2-\nu_3^2+\nu_3(\nu_1+\nu_2+\theta)=0$ |

**The six simple conditions degenerate exactly at $\Pi$-saturation.** $\nu_i[(n-1)\nu_j+\theta]=0$ needs $\nu_i=0$ (excluded on a kernel-free spectrum) or $\theta=-(n-1)\nu_j$, which for $\nu_j<0$ is $\theta=(n-1)\lvert\nu_j\rvert$: **the $\Pi$-bound attained at $\nu_j$.** *So each identity is informative except precisely where the recorded bound it descends from is tight, which is where one would expect an identity to go degenerate.* Every one of the nine types listed contains $\{123\}$, since $123$ is the one type appearing in all three rows.

> **RESULT.** *At a kernel-free three-eigenvalue critical point with $\theta>0$ and the $\Pi$-bound strict, the nine four-subsets above are not vertex supports.* Intersecting with the Jacobi list: $3$ of the nine were already excluded by Jacobi, so the count falls from $121$ to $118$; with the earlier $\{123\},\{133\}$ cut, **to $110$.** The split symmetric pair survives, as the control requires.

**Honest accounting of the cut so far**: $210\to121$ by Jacobi, $\to110$ by these derived identities. **The list is still a candidate list**, LP feasibility per support is unapplied, and [r343](REVIEW_r343.md)'s stronger cuts remain unreproduced.
