# r803, Gate 2 on L187 (the Pfaffian argument) and on the census collapse it is cited for

*Cold brief: I was given the two claims and the pointers, and read [findings/diagonal-half.md](../findings/diagonal-half.md) and [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean) from scratch. **No numerical work was done**; every value below is exact and every derivation is by hand. The one machine action was a screen, `lake build HamiltonsCubic.Results.L187Statement`, which completed successfully over 8709 jobs with no `sorry`, reported as a screen and not as evidence for any positive claim. Log: [agent_logs/g2-l187-r803.log](../agent_logs/g2-l187-r803.log).*

| Claim | Verdict |
|---|---|
| **A, L187**, two non-decomposable forms with opposite-signed weights and one decomposable have rank exactly four and $\dim V=4$ | **PLAUSIBLE**, undecided as a statement, and the proof is broken at one step |
| **A.1**, the identity $\sigma(\sigma(\omega))=\mathrm{Pf}(\omega)\cdot\omega$ on $\Lambda^2\mathbb R^6$, signs included | **CONFIRMED** |
| **A.2**, the independence step, $a\,\omega_1=b\,\omega_2\Rightarrow a=b=0$ | **CONFIRMED** |
| **A.3**, "everything sits inside $\dim V\le6$, since $\operatorname{supp}\omega_1=\operatorname{supp}\omega_2+P_3$ and a plane adds two" | **REFUTED** as an inference, it is a non sequitur, and it is the load-bearing step |
| **B, the census collapses to one case** ("two is empty", so three is all that remains) | **REFUTED** as a deduction, two survives at $\dim V\ge8$, untouched |
| **B.1**, at $\dim V=4$ all three image forms are non-decomposable, so exactly-two forces $\dim V>4$ | **CONFIRMED**, and not circular |
| **Inhabitation of Claim A's configuration** | **empty at $\dim V\in\{4,6\}$; UNDECIDED at $\dim V\ge8$** |

**One line.** *The Pfaffian argument is correct where it applies, but it applies only inside $\dim V\le6$, which is asserted from a sentence belonging to [L186](../findings/diagonal-half.md)'s configuration and false as an inference in L187's; what L187 and [L178](../findings/diagonal-half.md)'s step 1 actually establish together is the **opposite** of the recorded conclusion, the two-non-decomposable case survives, and survives only at $\dim V\ge8$.*

## 0. Conventions, fixed once

- $W=\sum_{i=1}^3\lambda_i\,\omega_i\otimes\omega_i$, the $\omega_i$ orthonormal in $\Lambda^2\mathbb R^n$, every $\lambda_i\ne0$, $W$ Ricci-flat and satisfying first Bianchi. $V$ is the span of the supports; by [L179](../findings/diagonal-half.md)(a), $W$ is supported on $\Lambda^2V$.
- A $2$-form's **support** is the image of the skew map it names; $\operatorname{rank}\omega=\dim\operatorname{supp}\omega=2k$. **Decomposable** $\iff\omega\wedge\omega=0\iff k\le1$; **non-decomposable** $\iff k\ge2\iff\operatorname{rank}\ge4$.
- $\omega^j\ne0\iff j\le k$. This is the only wedge-power fact used below.
- On an **oriented** $2m$-dimensional inner-product space, $\mathrm{Pf}(\omega)=s_1\cdots s_m$ for a positively-oriented adapted frame $\omega=\sum_j s_j\,e_{2j-1,2j}$, and $\omega^m=m!\,\mathrm{Pf}(\omega)\,\mathrm{vol}$.
- Signs of $\star$ on $\mathbb R^6$ with $\mathrm{vol}=e_{123456}$: $\star e_{1234}=e_{56}$, $\star e_{1256}=e_{34}$, $\star e_{3456}=e_{12}$, **all three $+$**. Independently on file as [L184](../findings/diagonal-half.md)'s discharged debt (iv).
- $\sigma(\omega)=\star(\omega\wedge\omega)/2$, defined by the metric and orientation of the ambient $6$-space alone.

## 1. Hypothesis inventory for Claim A

| Hypothesis | Used where | Status |
|---|---|---|
| Orthonormality of $\omega_1,\omega_2,\omega_3$ | independence step (§3) | used, and only through linear independence of the pair |
| $\lambda_i\ne0$, $\sum\lambda_i=0$ | [L180](../findings/diagonal-half.md)(2)–(3), sign split | used |
| Ricci-flatness | [L180](../findings/diagonal-half.md)(3), giving $V=\operatorname{supp}\omega_{\text{minority}}$ and the containments | used |
| First Bianchi | $\omega_1\wedge\omega_1=c\,\omega_2\wedge\omega_2$ | used |
| $\omega_1,\omega_2$ non-decomposable, $\omega_3$ decomposable | dropping $\omega_3$'s Bianchi term; the rank floor | used |
| Opposite signs on $\lambda_1,\lambda_2$ | asserted for $c>0$ | **used only decoratively**, see §3 |
| $\dim V\le6$ | *everything*, $\sigma$ does not exist otherwise | **unproved, and the proof's single point of failure** |

## 2. Claim A.1, the identity, checked including the $\star$ signs. CONFIRMED

In a positively-oriented adapted frame $\omega=s_1e_{12}+s_2e_{34}+s_3e_{56}$,
$$\omega\wedge\omega=2\big(s_1s_2\,e_{1234}+s_1s_3\,e_{1256}+s_2s_3\,e_{3456}\big),$$
so with the three $\star$ values of §0,
$$\sigma(\omega)=s_1s_2\,e_{56}+s_1s_3\,e_{34}+s_2s_3\,e_{12},$$
which is the block's $\sigma(\omega)=s_2s_3\,e_{12}+s_1s_3\,e_{34}+s_1s_2\,e_{56}$, the adjugate on pair spectra, $(s_1,s_2,s_3)\mapsto(s_2s_3,s_1s_3,s_1s_2)$. Iterating with $t=(s_2s_3,s_1s_3,s_1s_2)$,
$$(t_2t_3,\,t_1t_3,\,t_1t_2)=(s_1^2s_2s_3,\,s_1s_2^2s_3,\,s_1s_2s_3^2)=s_1s_2s_3\cdot(s_1,s_2,s_3),$$
so $\sigma\circ\sigma=\mathrm{Pf}\cdot\mathrm{id}$ with $\mathrm{Pf}=s_1s_2s_3$. **The signs survive**: I verified each star independently, $e_{1234}\wedge e_{56}=\mathrm{vol}$; $e_{1256}\wedge e_{34}=e_{125634}=\mathrm{vol}$, the block transposition of two $2$-blocks costing $(-1)^4$; $e_{3456}\wedge e_{12}=e_{345612}=\mathrm{vol}$, a $2$-block past a $4$-block costing $(-1)^8$. The three-sign computation agrees with [L184](../findings/diagonal-half.md)'s independently-derived debt (iv).

**Frame-independence, which the block does not address and which holds.** $\sigma$ is defined by $\star$, hence by the metric and orientation, not by any frame; the display above is a computation in one frame. Reversing orientation sends $\sigma\mapsto-\sigma$ and $\mathrm{Pf}\mapsto-\mathrm{Pf}$, and $\sigma\circ\sigma$ then picks up $(-1)$ once outside and $(-1)^2$ inside, so the identity is orientation-covariant and holds for either choice. **The block should say "positively oriented"**, with a negatively-oriented adapted frame the three stars are all $-$ and the displayed formula is off by a sign, but nothing downstream breaks.

**One real restriction, correctly located by the block and worth restating.** $\star$ carries $\Lambda^4\to\Lambda^2$ **only at dimension six**. This is the same trap [L184](../findings/diagonal-half.md) flags for $\star_V(J\wedge J)=2\epsilon_JJ$ ("the Hodge star here is $V$'s, not $\mathbb R^n$'s"). So $\sigma$ must be built on $V$ padded to exactly six dimensions, which is why §4 is fatal rather than cosmetic.

## 3. Claim A.2, the independence step. CONFIRMED, and it needs less than is claimed

$\sigma$ is quadratic, so $\sigma(\omega_1)=c\,\sigma(\omega_2)$ gives $\sigma(\sigma(\omega_1))=c^2\sigma(\sigma(\omega_2))$, i.e. $\mathrm{Pf}(\omega_1)\,\omega_1=c^2\,\mathrm{Pf}(\omega_2)\,\omega_2$. Orthonormal $\Rightarrow$ linearly independent $\Rightarrow$ $\mathrm{Pf}(\omega_1)=0$ and $c^2\mathrm{Pf}(\omega_2)=0$. **This is valid in the generality used**, it is the two-element case of linear independence, with no positivity or normalisation consumed.

**The opposite-sign hypothesis is not needed here.** The block deduces $\mathrm{Pf}(\omega_2)=0$ "since $c>0$", but $c=-\lambda_2/\lambda_1\ne0$ suffices, and $c\ne0$ is forced by $\omega_2$ non-decomposable. So the one place the recorded chain calls itself conditional (*"what remains owed is the sign hypothesis L186 assumes"*), is **not load-bearing for this lemma at all**. (It is separately a theorem in this branch, by [L186](../findings/diagonal-half.md)'s rank count: same signs on $\lambda_1,\lambda_2$ put a rank-$\ge4$ positive combination equal to a rank-$2$ projection.)

## 4. Claim A.3, $\dim V\le6$. REFUTED as an inference; this is the break

**Located exactly.** [findings/diagonal-half.md](../findings/diagonal-half.md), L187's proof, first sentence: *"Everything sits inside $\dim V\le6$, since $\operatorname{supp}\omega_1=\operatorname{supp}\omega_2+P_3$ and a plane adds two."* The same sentence is the third paragraph of [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean)'s module docstring.

**The failure, concretely.** Label so that $\omega_1$ carries the minority sign, which [L180](../findings/diagonal-half.md)(3) allows and which is what the cited containment presumes. Then that same lemma gives $V=\operatorname{supp}\omega_1$, so $\dim V=\operatorname{rank}\omega_1$ and $\operatorname{supp}\omega_2\subseteq V$. The cited relation therefore reads
$$\dim V\ \le\ \dim\operatorname{supp}\omega_2+2\ \le\ \dim V+2,$$
**which is vacuously true and bounds nothing.** "A plane adds two" adds two to $\dim\operatorname{supp}\omega_2$, and $\omega_2$ is non-decomposable by hypothesis, so its support is of even dimension $\ge4$ with **no upper bound anywhere in the record**.

**A consistent assignment the cited facts permit, in closed form.** $\dim V=8$, $\operatorname{rank}\omega_1=8$, $\operatorname{rank}\omega_2=8$, $P_3\subseteq V$. Every constraint on file is met: $\dim V$ even and $\ge4$ ([L180](../findings/diagonal-half.md)(3)); $\operatorname{supp}\omega_2+P_3=\operatorname{supp}\omega_1$; both non-decomposable; and the wedge-power consequence of first Bianchi, which at $\dim V=8$ reads $\omega_1^4=(\omega_1\wedge\omega_1)^2=c^2(\omega_2\wedge\omega_2)^2=c^2\omega_2^4$ and **forces** $\operatorname{rank}\omega_2=8$ rather than forbidding it. *This exhibits the failure of the inference. It is not a Weyl tensor and I claim no such tensor exists, see §6.*

**Arguing the opposite, the strongest reading the words support.** The sentence is exact and correct in a **different** configuration: [L186](../findings/diagonal-half.md)'s, where $\omega_2$ and $\omega_3$ are *both* decomposable, so $V=\operatorname{supp}\omega_1=P_2+P_3$ and "a plane adds two" twice gives $\dim V\le4$. That is precisely the route by which L186's first proof reached $\dim V=4$. **Read in L187's own configuration, where $\omega_2$ is non-decomposable, the sentence loses its content**, and no other reading recovers a bound.

**Why it is fatal rather than repairable in place.** $\sigma=\star(\omega\wedge\omega)/2$ is a $2$-form only in six dimensions; at $\dim V=8$ it is a $4$-form and $\sigma\circ\sigma$ does not typecheck. There is no generalisation on file, and the wedge-power identity that does generalise gives only $\lfloor k_1/2\rfloor=\lfloor k_2/2\rfloor$, which at $\dim V=8$ is satisfied by $k_1=k_2=4$.

**What the argument does establish, stated positively.** For $\dim V\le6$, $\mathrm{Pf}(\omega_1)=0$, hence $\operatorname{rank}\omega_1\le4$, hence $\dim V=4$. Since $\dim V$ is even and $\ge4$, the whole content is: **the two-non-decomposable configuration does not occur at $\dim V=6$.** At $\dim V=4$ the padded $\mathrm{Pf}$ vanishes identically and the $\sigma$ route returns nothing, so the recorded headline, "the survivor also has $\dim V=4$", is the *restatement* of a hypothesis on the branch where it is not already excluded, and the lemma's real content is the exclusion of six.

## 5. Claim B, the collapse to one case

**B.1, the import from [L178](../findings/diagonal-half.md)'s step 1, is sound and NOT circular. CONFIRMED.** Step 1 is a conditional: *given* support on a four-dimensional $V$ and $\Lambda^2$-rank $\le3$, one of $W^\pm$ vanishes, because each is self-adjoint and trace-free on a three-space and so has rank $0$, $2$ or $3$. Claim B invokes it **inside a case assumption** $\dim V=4$ and derives a contradiction with the configuration; the conclusion drawn is $\dim V\ne4$, not $\dim V=4$. That is ordinary case analysis. The remaining step is exact: a nonzero self-dual $\omega=s_1e_{12}+s_2e_{34}$ on $\mathbb R^4$ has $\star\omega=s_2e_{12}+s_1e_{34}$, so self-duality is $s_1=s_2\ne0$ and the rank is four; anti-self-duality is $s_1=-s_2\ne0$, likewise. So **at $\dim V=4$ all three image forms are non-decomposable**, and a configuration with exactly two forces $\dim V\ge6$. *One inherited debt, belonging to L178 and not to this line: step 1 asserts the splitting $W^+\oplus W^-$ without remarking that the mixed block is the trace-free Ricci and vanishes by Ricci-flatness.*

**B as stated ("two is empty", hence "three is the only case"), REFUTED as a deduction.** It is exactly the composition $\text{B.1}+\text{Claim A}$, so it inherits §4's break. Assembling what is actually proved:

| $\dim V$ | two-non-decomposable configuration | by |
|---|---|---|
| $4$ | **empty** | B.1 |
| $6$ | **empty** | the $\sigma$ argument, valid here |
| $\ge8$, even | **untouched** | $\sigma$ does not exist; nothing else reaches |

**So the two claims together do not empty the case, they push it to $\dim V\ge8$**, which is the reverse of the recorded reading. This is consistent with, and was flagged by, [L184](../findings/diagonal-half.md)'s own closing box: *"At $\dim V\ge8$ the case split does not even apply."* L187's block does not cite that box.

**The census, re-run. Is another configuration unmentioned?** Counting non-decomposable image forms over $\{0,1,2,3\}$ is exhaustive at rank three, and rank one is impossible ([L179](../findings/diagonal-half.md)(c)) while rank two returns $\theta=0$ ([L178](../findings/diagonal-half.md) step 4), so no *count* is missing. **What is missing is a dimension stratum, not a count**: the two-case at $\dim V\ge8$. So the corrected census is *zero empty, one empty, two empty only below eight, three open*, and [L186](../findings/diagonal-half.md)'s "**SO THE CENSUS COLLAPSES TO ONE CASE**" box, [findings/INDEX-results.md](../findings/INDEX-results.md) row 187, and [plan.md](../plan.md)'s I38 row (*"the case analysis is now SPENT"*) all overstate.

## 6. Is Claim A's configuration inhabited?, the question that mattered twice

**Empty at $\dim V=4$** (§5, B.1) and **empty at $\dim V=6$** (§4). *The $\dim V=6$ exclusion is a genuine positive result and is what should be recorded; it needs neither the opposite-sign hypothesis nor $c>0$, only $\omega_3$ decomposable, $\omega_1,\omega_2$ non-decomposable and linearly independent, first Bianchi, and [L180](../findings/diagonal-half.md)(3).*

**Undecided at $\dim V\ge8$.** I did not exhibit a Weyl tensor there and I do not assert one exists; producing or excluding one is the open question, and settling it by search is computation this brief does not authorise. What can be said without any: at $\dim V=2m$ with $m$ even, first Bianchi's $\omega_1^{2p}=c^p\omega_2^{2p}$ forces $\operatorname{supp}\omega_2=\operatorname{supp}\omega_1=V$, so $P_3\subseteq V$ and Ricci-flatness reads $|\lambda_1|A_1=|\lambda_2|A_2+|\lambda_3|\Pi_3$ with $A_1,A_2$ positive definite on $V$, a system with no evident obstruction. **So this lemma is not the third consecutive vacuous one; it is a lemma whose branch is open in the range its proof cannot reach.**

*One reformulation, recorded as an observation and not adopted, since a reviewer checks the written proof rather than building another: with $\omega_2'=\sqrt c\,\omega_2$, first Bianchi is $\omega_1\wedge\omega_1=\omega_2'\wedge\omega_2'$, and $2$-forms commuting under $\wedge$ turns that into $(\omega_1-\omega_2')\wedge(\omega_1+\omega_2')=0$, a single vanishing wedge of two $2$-forms, in any dimension. Unaudited.*

## 7. Defects in the record, beyond the mathematics

1. **L187's own closing box contradicts its statement.** *"And the TWO-non-decomposable case, where $\operatorname{supp}\omega_1=\operatorname{supp}\omega_2+P_3$ can have dimension six and nothing here rules it out"*, but the two-non-decomposable case **is** the lemma, and its proof does rule out dimension six. Stale text from a prior version, sitting under the heading it contradicts.
2. **Three places disagree on the sign hypothesis.** L187's block calls it *"the one place the chain is conditional"*; [L186](../findings/diagonal-half.md)'s block calls it *"a theorem, twice over"*; [L187Statement.lean](../lean/HamiltonsCubic/Results/L187Statement.lean) carries a principal-angle derivation headed *"The sign hypothesis is DERIVABLE, so the chain is unconditional"*. Per §3 the question is moot for this lemma, and the Lean section is about L186's one-non-decomposable branch, which [L186](../findings/diagonal-half.md) has since emptied by Bianchi alone, so it is dead weight.
3. **Two dead anchors.** L187's proof links `#lemma-l186--one-non-decomposable-image-form-puts-dim-v-at-exactly-four` twice; L186's heading is now *"no rank-three Weyl tensor has exactly one non-decomposable image form"*.
4. **The Lean layer carries none of the gap, and says so.** The screen built cleanly (8709 jobs, no `sorry`), but `dim_V_eq_four_survivor` takes `r₁ ≤ 4` as a *hypothesis*, the very conclusion the Pfaffian route exists to supply, and the one that needs $\dim V\le6$. `sigma`, `pf`, `sigma_sigma` and `sigma_smul` are pair-spectra arithmetic over $\mathbb R^3$ with no $2$-form, no $\star$ and no orientation in sight, so **the layer neither confirms nor could have caught the defect**, and [lean/INDEX.md](../lean/INDEX.md) row 187 should not read as corroboration.

## 8. What would falsify each claim, and what I did to look for it

| Claim | Falsifier | What I did |
|---|---|---|
| **A.1** ($\sigma\circ\sigma=\mathrm{Pf}\cdot\mathrm{id}$) | a wrong $\star$ sign making $\sigma$ the *signed* adjugate, so that $\sigma\circ\sigma=-\mathrm{Pf}\cdot\mathrm{id}$ on some component and the identity fails componentwise | recomputed all three stars from $\mathrm{vol}=e_{123456}$ by counting block transpositions; cross-checked against [L184](../findings/diagonal-half.md)(iv), derived independently and by a different route; checked orientation-covariance of both sides. **No falsifier.** |
| **A.2** (independence) | a degeneracy making $\omega_1,\omega_2$ dependent, or a hidden use of $c>0$ | orthonormality gives independence outright; traced $c$ and found only $c\ne0$ is used, which non-decomposability of $\omega_2$ supplies. **No falsifier; the hypothesis is weaker than claimed.** |
| **A.3** ($\dim V\le6$) | a bound on $\dim\operatorname{supp}\omega_2$ somewhere in the record | read [L179](../findings/diagonal-half.md), [L180](../findings/diagonal-half.md), [L181](../findings/diagonal-half.md), [L183](../findings/diagonal-half.md), [L184](../findings/diagonal-half.md) for any rank cap on an eigenform; found none, and found [L180](../findings/diagonal-half.md)'s own box posing $\dim V\ge6$ as the open question and [L184](../findings/diagonal-half.md)'s box conceding $\dim V\ge8$ is untouched. Traced the sentence to L186's configuration, where it is correct. **Falsifier found: the inference is empty.** |
| **A** (the statement) | a rank-three Weyl tensor in this configuration with $\dim V\ne4$ | ruled the configuration out at $\dim V=4$ and $\dim V=6$ analytically; at $\dim V\ge8$ derived the wedge-power constraints and found them consistent, so no contradiction is available on file. Searching for a tensor is computation and was not run. **Undecided.** |
| **B.1** (all three non-decomposable at $\dim V=4$) | a nonzero decomposable (anti-)self-dual $2$-form on $\mathbb R^4$; or circularity in the L178 import | computed $\star$ on $s_1e_{12}+s_2e_{34}$ and found self-duality forces $s_1=\pm s_2\ne0$, hence rank four; checked that L178's step 1 is applied under, not to establish, $\dim V=4$. **No falsifier.** |
| **B** (the collapse) | a stratum the census does not reach | re-ran the count $\{0,1,2,3\}$ and found it exhaustive, then checked the $\dim V$ strata within case two and found $\ge8$ unreached. **Falsifier found: the collapse holds only below eight.** |

## Overall verdict, GAP

*Claim A's machinery is right and its scope is not: the identity, its signs, its frame-independence and the independence step all survive audit, and the single premise $\dim V\le6$ does not. Claim B is that premise composed with a correct import, so it falls with it. **What should be recorded is the exclusion of $\dim V=6$**, which is what the Pfaffian route actually buys, together with B.1's exclusion of $\dim V=4$, and the surviving question is then the two-non-decomposable case at $\dim V\ge8$ alongside the three-non-decomposable case, so [I38](../plan.md)'s row and [findings/INDEX-results.md](../findings/INDEX-results.md)'s row 187 both need correcting before anything is built on them.*
