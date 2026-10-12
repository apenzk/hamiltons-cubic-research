# ROUND L146-r2, the last row of the block

**Id:** L146-r2. **Source:** [findings/second-order.md](../findings/second-order.md):1131–1162. **Date:** 2026-09-06. **Verifiers allocated:** v86, v87, v88. **Phase:** 1, dispatched.

**Why this id.** L146 closed `PROVEN, hypotheses corrected`, unanimously, and **the corrected text has never been read.** *It is the last unaudited row of the tube-radius block.*

**A repair is a new result**, written under the pressure of a finding and entered without cold readers. **Which passages are repairs is deliberately not marked.**

**What this entry supplies to the block, so its scope matters more than most.** *Its operator-norm envelope is consumed by two later entries at every $w$, and its $a_0n^{-1/2}=1/\sqrt{m-1}$ supremum sets the kink location the whole chain minimises at.* **A hypothesis missing here is a hypothesis missing in three entries.**

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Does the entry's envelope hold where its consumers use it?** *One consumer takes it at every $w\in[0,1]$; another at the kink; a third inside a Cauchy estimate over a complex disc.* **Say for each whether the entry's own statement reaches that far, and on what hypothesis.**
2. **Is the supremum attained, and is the attaining direction inside the domain the consumers quantify over?** *A supremum attained outside the admissible set is a bound the chain cannot use, and the block has already carried one claim that was false at an orbit-tangent direction.*

**One trap named from outside the entry.** *An earlier round found this block's repairs landing beside the statements they correct rather than inside them, so that a citation inherits the defect.* **Read the citable statement alone, as a consumer would, and say what it carries without the surrounding boxes.**

## The brief as dispatched

*Provenance stripped, mathematics verbatim, quoted from the current source.*

#### Lemma L146, the operator norm on the margin summand, and the direction-blind radius it corrects

*Derived 2026-09-03 to decide the a prior review/a prior review disagreement recorded in [Lemma L145](../findings/second-order.md#lemma-l145-the-constant-chain-for-the-balanced-orbit-tube-radius-and-the-lower-bound-r_nomegan-32-it-supports).  Every structural statement below was wrong in the first version; the two errors moved numerator and denominator of $\lVert H\rVert_{op}/\lVert H\rVert_F$ by the same order, so the headline survived them.*

**Setting.** At $W^*=S^m\times S^m$, [Lemma L27](nondegeneracy.md) puts the off-orbit margin maximum on the two $S^2_0(\mathbb R^m)$ summands, and $L_e$ acts there as the **scalar** $\lambda_m=(m-2)/(2(m-1))$. *So the margin is constant across the summand and only $\lVert H\rVert_{op}$ varies over it.* Both reviewers confirmed the margin is **exactly** [Lemma L145](../findings/second-order.md#lemma-l145-the-constant-chain-for-the-balanced-orbit-tube-radius-and-the-lower-bound-r_nomegan-32-it-supports)'s $c_p$: $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$.

> **THE EMBEDDING, CORRECTED.** $\mathrm{Ric}(h\owedge g_q)=m\,h\ne0$, so $h\owedge g_q$ is **not a Weyl tensor** and the projection term survives. Against the record's own projector ($\mathrm{KN}(h)=\tfrac12(h\owedge g)$, [nondegeneracy.md](nondegeneracy.md)), with $\alpha=\tfrac{m-2}{2(m-1)}$ and $\beta=\tfrac m{2(m-1)}$, the Weyl image is diagonal on coordinate $2$-planes with
> $$\alpha\,h_a\ \text{ on }e_a\wedge e_b,\ a\in B_1,\ b\in B_2;\qquad -\beta\,(h_a+h_{a'})\ \text{ on }e_a\wedge e_{a'},\ a,a'\in B_1;\qquad 0\ \text{ inside }B_2.$$
> *An earlier version of this lemma took the eigenvalues to be $h_a$ on the cross planes and **zero inside both blocks**, which is $h\owedge g_q$ before the projection. **The in-block planes it discarded are the ones that dominate the operator norm.***

> **THE IN-BLOCK BRANCH DOMINATES, AND THE ARGUMENT IS THIS.** Tracelessness forces $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ge\tfrac{m-2}{m-1}\max_a\lvert h_a\rvert$, *sharp at the spike, and not obvious: $h=(3,-1,-1,-1)$ has pair-maximum $2$ against entry-maximum $3$*, while $\beta/\alpha=\tfrac m{m-2}$ covers that ratio with room. **The clause was asserted without argument until a prior round; two verifiers derived this proof independently.**

> **THIS PRICES ONE COPY. ON THE JOINT TWO-COPY EIGENSPACE THE EQUALITY CLAUSE IS FALSE.** A pair $(h,k)$ carries a **third, cross-plane branch** $\alpha(h_a+k_b)$ that no single $h$ produces: at $m=5$, $h=k=(1,0,0,0,-1)$ gives $\tfrac34$ against the formula's $\tfrac58$, and at $m=6$, $h=k=(1,-\tfrac15,\dots)$ gives $\tfrac45$ against $\tfrac{12}{25}$. **The supremum is unchanged** (the cross branch caps at $\sqrt{m-2}/m<1/\sqrt{m-1}$, since $(m-1)(m-2)<m^2$), *so [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform)'s use of this bound on the joint eigenspace is safe, and the line licensing it lives here rather than being assumed.*

**Diagonality does survive**, both Kulkarni–Nomizu factors being diagonal in the same frame, and that is the claim doing real work, since it gives $v=0$ and so identifies the summand with the $u=0$ branch that a prior review and a prior review each asserted and neither proved.

> **LEMMA L146.** *For $H$ the Weyl image of a **single** $h\in S^2_0(\mathbb R^m)$ with $\lVert H\rVert_F=1$, $n=2m$ and $m\ge3$,*
> $$\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2,\qquad \lVert H\rVert_{op}=\frac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert,$$
> *the in-block branch always winning, with supremum $1/\sqrt{m-1}$ attained at the pair-concentrated $h$. **In order, $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$.***

*The first version solved the wrong extremal problem ($\max_a\lvert h_a\rvert$ rather than $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$) and reported the supremum as $\sqrt{m-1}/m$, too small by $m/(m-1)$, with intervals disjoint from the truth at $m=3$. **The two lower bounds on file are not in conflict**: $1/(m-1)$ is a proven floor and $\approx\sqrt2/m$ an attained value, so they bracket one infimum rather than contradict, *recorded as a disagreement until a prior round, where two verifiers resolved it independently.* **And the even split is beaten only up to $m=6$**, the spike witness winning exactly when $m^2-8m+8<0$; at $m\ge7$ that witness loses and the clause has no proof, though a different family reaches $m=8$. *Both bounds are $\Theta(n^{-1})$, so the order is untouched either way.*

> **THE ORDER-LEVEL CONCLUSION SURVIVES THE CORRECTED EMBEDDING.** Every $H$ in the summand has $\lVert H\rVert_{op}=O(n^{-1/2})$, so the analyticity disc $g_n/\lVert H\rVert_{op}$ is $\Omega(n^{-1/2})$ throughout, **a factor $\sqrt n$ larger than the direction-blind $g_n=\Theta(n^{-1})$** that [Lemma L145](../findings/second-order.md#lemma-l145-the-constant-chain-for-the-balanced-orbit-tube-radius-and-the-lower-bound-r_nomegan-32-it-supports) uses. *This holds for $m\ge5$, where $\lambda_m>\mu$ puts the margin on this summand; $n\ge12$ is inside that.*

> **AND IT BEARS ON THE a prior review/a prior review SPLIT WITHOUT SETTLING IT.** *An earlier version of this entry claimed it settled the split for a prior review. It meets only the weaker $o(1)$ wording of a prior review's test; the mechanism a prior review names needs $\lVert H\rVert_{op}=O(g_n)$, which this does not give).*

> **AND a prior review AND a prior review CONTRADICT EACH OTHER HERE BY $\sqrt n$, WHICH THIS ENTRY ORIGINALLY HID.** a prior review derives $M=O(\rho)$ and so $\lVert A''\rVert=O(n^{1/2})$; a prior review holds $M=O(g_n)$ fixed and so gets $O(1)$. *The two coincide at $\rho=\Theta(g_n)$, which is why the difference was invisible.* **a prior review and a prior review both resolve it for a prior review**: a Cauchy supremum taken over a larger disc is larger, and $x\mapsto x_-$ is $1$-Lipschitz, so $M=O(\rho)$.

> **AND [LEMMA L148](../findings/second-order.md#lemma-l148-the-defect-vanishes-identically-on-the-margin-summand) DISPLACES THIS LEMMA ENTIRELY.** *The defect is identically zero on this summand, so the operator norm computed here prices a quantity that is not present.* **What it establishes about the ten-summand infimum is nothing; the question lives on the mixed directions.**

**A screening note worth keeping.** The first version closed with a screen reporting $\max\lVert H\rVert_{op}/g_n$ at five dimensions. It re-evaluated the lemma's own closed form, built no tensor, and **could not have caught the embedding error by any outcome**, a screen that cannot fail is not a screen. a prior review's, which constructed Kulkarni–Nomizu tensors and checked Bianchi and $\mathrm{Ric}$ before measuring, is what the word is for.

## Phase 1, returns

- **v86** · `PROVEN, hypotheses corrected` · [VERIFY_v86.md](VERIFY_v86.md). **Every numeral reproduced**, plus two checks the entry does not run, $\mathrm{Ric}(W)=0$ and the branch count $m^2+2\binom m2=\binom n2$. **Q2 clean: the supremum $1/\sqrt{m-1}$ is attained** at $h^*\propto(m-2,m-2,-2,\dots,-2)$, *which satisfies all four of L147's hypotheses.* **No asymptotic slip**: $a_0n^{-1/2}=\sqrt{2/(n-2)}=1/\sqrt{m-1}$ exactly, and freezing $a_0^2=2$ would have given $\tfrac{n-2}{n+2}$, which the record did not do. **Four amendments**, each with an argument on file: $h_a$ never defined, *at $m=6$ the fixed-frame reading makes the box's own two displays contradict each other*, **the exact repair [L148](../findings/second-order.md)'s statement received and this one did not**; "the pair-concentrated $h$" read literally is not traceless; single copy against three consumers' joint two-copy use; and the floor should be $m\ge5$, [L27](../findings/nondegeneracy.md) being the excluded $(3,3)$ case at $m=3$.

- **v87** · `PROVEN, hypotheses corrected` · [VERIFY_v87.md](VERIFY_v87.md). Agrees on the conclusion and on the citable-box gap, **and adds two the others did not have.** *"Off-orbit margin **maximum**" is the **minimum***, $\tfrac12-\lambda_m=\tfrac1{2(m-1)}$ against $\tfrac12-\mu=\tfrac{m-3}{2(m-1)}$, with L145 and L149 both saying minimum and **[plan.md](../plan.md) repeating the wrong word**. And *"[L148](../findings/second-order.md) displaces this lemma entirely … establishes nothing"* is false: **L146's $a_0$ fixes the binding minimiser $w_0=\tfrac{n-4}n$ and its slope $\tfrac n{2(n-2)}$**, and L149 uses the envelope at every $w$.

**Q2 answered more completely than by v86**: the attaining direction is admissible because $L_e=\tfrac12$ exactly on $T_{W^*}\mathcal O$ while $\lambda_m<\tfrac12$, *so the whole summand is orthogonal to the orbit*, **and that argument sits in L149, not in L146.** *One inversion worth recording: [INDEX-results.md](../findings/INDEX-results.md):165 carries the joint-two-copy correction the lemma box lacks, so **the index row is stronger than the statement**, the opposite of this block's usual drift.*

### A split the round cannot settle by reading, and will not settle by preference

**v86 confirms $\mathrm{Ric}=mh$; v87 says it is $(m-2)h$ and exhibits the entry contradicting itself two lines later**, at $m=4$, $\lVert H\rVert_F^2=2\lVert h\rVert^2$ against the box's $\tfrac43\lVert h\rVert^2$. *Both readers re-derived the embedding cold and reached different values for the same object.* **Adjudicators v89 and v90**, on the Ricci contraction alone.

- **v88** · `GAP` · [VERIFY_v88.md](VERIFY_v88.md). **It settles the Ricci split.** *$\alpha=\tfrac{m-2}{2(m-1)}$ and $\beta=\tfrac m{2(m-1)}$ are rederived from the record's **own** projector at [nondegeneracy.md](../findings/nondegeneracy.md):375 rather than a textbook one, and they give $\mathrm{Ric}(h\owedge g_q)=mh$.* **Two independent derivations against one, and the decisive one used the record's projector**, which is the failure the competing claim would exhibit. *v87's D1 is `withdrawn`; the $(m-2)h$ reading swaps $\alpha$ and $\beta$.*

**Q2 answered a third way and clean**: the maximiser sits in $E_{L_e}(\lambda_m)$, orthogonal to $\langle W^*\rangle=E(1)$ and to $T_{W^*}\mathcal O=E(\tfrac12)$, *so the block's orbit-tangent trap cannot fire here.*

**And two prose clauses are false inside the box's own $m\ge3$.** *At $m=3$, "$\approx\sqrt2/m$ an attained value" is $0.471405$, **below** the proven floor $\tfrac12$, they invert rather than bracket, the true minimum being $\sqrt6/4$ at $h\propto(1,0,-1)$. At $m=7$, "the even split is beaten only up to $m=6$" fails, and "even split" is undefined at odd $m$.* **Neither is load-bearing.**

## Phase 5, the round's verdict

**`PROVEN, hypotheses corrected`. Impact: `CONTAINED`.**

**All three readers reproduced the mathematics in full and none found the conclusion wrong.** *The supremum $1/\sqrt{m-1}$ is attained, its direction is admissible, the floor is exactly Cauchy–Schwarz over the $\binom m2$ in-block planes, the cross cap $\sqrt{m-2}/m$ is exact, and $a_0n^{-1/2}=1/\sqrt{m-1}$ carries no asymptotic slip.*

**What was wrong was the citable statement, and it was the trap the round was told to look for.** *It said "a single $h$" at unit norm while all three consumers use the joint two-copy eigenspace at every norm; the extension was true and argued **beside** the box, in a neighbour's set-up, and in a review, never inside it.* **[L148](../findings/second-order.md) received exactly this repair and this lemma did not**, which is the block's signature failure appearing in its last unaudited row.

### The block is now fully audited

*Fifteen rounds. **Every one found defects**, and the two that mattered most were found in text this session had itself repaired hours earlier.* **The distinctive finding is not any single defect but a ratio**: claims quoted from the audit survived, and claims added on top of it did not.
