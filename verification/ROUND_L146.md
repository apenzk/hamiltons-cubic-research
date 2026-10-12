# ROUND L146, the operator norm on the margin summand

**Id** L146 · **File** [findings/second-order.md](../findings/second-order.md), lines **1125–1152** · **Opened** 2026-09-05

**Verifiers allocated:** v19, v20, v21. **Phase:** 1, dispatched.

**Why this id.** Tier C, the tube-radius chain. **Rounds 1 and 2 both leaned on this lemma for their operator-norm input** ($a_0n^{-1/2}=1/\sqrt{m-1}$) and neither audited it. Its own index row records a Gate 2 whose *derivation* was refuted while the order-level conclusion stood, which is exactly the shape this loop exists to re-examine.

**Canonical cross-check.** [results.md](../results.md) carries no L146 entry.

## The brief as dispatched

**Provenance stripped, mathematics verbatim**, per the independence rule: the derivation line, the Gate 2 clause and inline reviewer citations are removed; every mathematical sentence is unchanged and no paraphrase is introduced.

```
#### Lemma L146, the operator norm on the margin summand, and the direction-blind radius it corrects


**Setting.** At $W^*=S^m\times S^m$, [Lemma L27](nondegeneracy.md) puts the off-orbit margin maximum on the two $S^2_0(\mathbb R^m)$ summands, and $L_e$ acts there as the **scalar** $\lambda_m=(m-2)/(2(m-1))$. *So the margin is constant across the summand and only $\lVert H\rVert_{op}$ varies over it.* Both reviewers confirmed the margin is **exactly** [Lemma L145](ROUND_L145.md#lemma-l145-the-balanced-orbit-tube-radius-is-thetan-32-and-the-constant-chain-that-gives-it)'s $c_p$: $3\theta_0(\tfrac12-\lambda_m)=3\theta_0/(n-2)$.

> **THE EMBEDDING, CORRECTED.** $\mathrm{Ric}(h\owedge g_q)=m\,h\ne0$, so $h\owedge g_q$ is **not a Weyl tensor** and the projection term survives. Against the record's own projector ($\mathrm{KN}(h)=\tfrac12(h\owedge g)$, [nondegeneracy.md](nondegeneracy.md)), with $\alpha=\tfrac{m-2}{2(m-1)}$ and $\beta=\tfrac m{2(m-1)}$, the Weyl image is diagonal on coordinate $2$-planes with
> $$\alpha\,h_a\ \text{ on }e_a\wedge e_b,\ a\in B_1,\ b\in B_2;\qquad -\beta\,(h_a+h_{a'})\ \text{ on }e_a\wedge e_{a'},\ a,a'\in B_1;\qquad 0\ \text{ inside }B_2.$$
> *An earlier version of this lemma took the eigenvalues to be $h_a$ on the cross planes and **zero inside both blocks**, which is $h\owedge g_q$ before the projection. **The in-block planes it discarded are the ones that dominate the operator norm.***

**Diagonality does survive**, both Kulkarni–Nomizu factors being diagonal in the same frame, and that is the claim doing real work, since it gives $v=0$ and so identifies the summand with the $u=0$ branch that a prior review and a prior review each asserted and neither proved.

> **LEMMA L146.** *For $H$ the Weyl image of $h\in S^2_0(\mathbb R^m)$ with $\lVert H\rVert_F=1$ and $n=2m$,*
> $$\lVert H\rVert_F^2=\frac{m(m-2)}{2(m-1)}\lVert h\rVert^2,\qquad \lVert H\rVert_{op}=\frac m{2(m-1)}\max_{a\ne a'}\lvert h_a+h_{a'}\rvert,$$
> *the in-block branch always winning, with supremum $1/\sqrt{m-1}$ attained at the pair-concentrated $h$. **In order, $\lVert H\rVert_{op}$ ranges over $[\Theta(n^{-1}),\Theta(n^{-1/2})]$.***

*The first version solved the wrong extremal problem ($\max_a\lvert h_a\rvert$ rather than $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert$) and reported the supremum as $\sqrt{m-1}/m$, too small by $m/(m-1)$, with intervals disjoint from the truth at $m=3$. The reviewers differ on the exact lower bound, a prior review giving $1/(m-1)$ and a prior review $\approx\sqrt2/m$; both are $\Theta(n^{-1})$, and the claimed minimiser (the even split) is wrong in either reading.*

> **THE ORDER-LEVEL CONCLUSION SURVIVES THE CORRECTED EMBEDDING.** Every $H$ in the summand has $\lVert H\rVert_{op}=O(n^{-1/2})$, so the analyticity disc $g_n/\lVert H\rVert_{op}$ is $\Omega(n^{-1/2})$ throughout, **a factor $\sqrt n$ larger than the direction-blind $g_n=\Theta(n^{-1})$** that [Lemma L145](ROUND_L145.md#lemma-l145-the-balanced-orbit-tube-radius-is-thetan-32-and-the-constant-chain-that-gives-it) uses. *This holds for $m\ge5$, where $\lambda_m>\mu$ puts the margin on this summand; $n\ge12$ is inside that.*

> **AND IT BEARS ON THE a prior review/a prior review SPLIT WITHOUT SETTLING IT.** *An earlier version of this entry claimed it settled the split for r446. It meets only the weaker $o(1)$ wording of a prior review's test; the mechanism r446 names needs $\lVert H\rVert_{op}=O(g_n)$, which this does not give).*

> **AND a prior review AND a prior review CONTRADICT EACH OTHER HERE BY $\sqrt n$, WHICH THIS ENTRY ORIGINALLY HID.** r448 derives $M=O(\rho)$ and so $\lVert A''\rVert=O(n^{1/2})$; r449 holds $M=O(g_n)$ fixed and so gets $O(1)$. *The two coincide at $\rho=\Theta(g_n)$, which is why the difference was invisible.* **a prior review and a prior review both resolve it for r448**: a Cauchy supremum taken over a larger disc is larger, and $x\mapsto x_-$ is $1$-Lipschitz, so $M=O(\rho)$.

> **AND [LEMMA L148](../findings/second-order.md#lemma-l148-the-defect-vanishes-identically-on-the-margin-summand) DISPLACES THIS LEMMA ENTIRELY.** *The defect is identically zero on this summand, so the operator norm computed here prices a quantity that is not present.* **What it establishes about the ten-summand infimum is nothing; the question lives on the mixed directions.**

**A screening note worth keeping.** The first version closed with a screen reporting $\max\lVert H\rVert_{op}/g_n$ at five dimensions. It re-evaluated the lemma's own closed form, built no tensor, and **could not have caught the embedding error by any outcome**, a screen that cannot fail is not a screen. a prior review's, which constructed Kulkarni–Nomizu tensors and checked Bianchi and $\mathrm{Ric}$ before measuring, is what the word is for.

```

## Clustering

**Three verifiers, all `PROVEN, hypotheses corrected`.** The first unanimous non-`GAP` round of the chain: every mathematical assertion in L146 was re-derived and holds. **What is wrong is what the entry does not say.**

| # | finding | raised by |
|---|---|---|
| **F1** | **The two-copy citation.** L146 prices **one** $S^2_0(\mathbb R^m)$ copy; [L149](../findings/second-order.md) applies it to the **joint** $2s_m$-dimensional eigenspace, where a pair $(h,k)$ carries a **third, cross-plane branch** $\alpha(h_a+k_b)$ that no single $h$ produces. *The equality clause is refuted there by two independent closed-form witnesses, $h=k=(1,-\tfrac15,\dots)$ at $m=6$ giving $\tfrac45$ against the formula's $\tfrac{12}{25}$, and $h=k=(1,0,0,0,-1)$ at $m=5$ giving $\tfrac34$ against $\tfrac58$.* **The bound survives**, the cross branch capping at $\sqrt{m-2}/m<1/\sqrt{m-1}$, but no line of L146 says so | v19, v20, v21 |
| **F2** | **$m\ge3$ is missing.** At $m=2$ the Weyl image is identically zero, so $\lVert h\rVert=1$ is unsatisfiable and the supremum is taken over the empty set | v19, v20, v21 |
| **F3** | **"The in-block branch always wins" has no argument on file.** It needs $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ge\tfrac{m-2}{m-1}\max_a\lvert h_a\rvert$, not obvious, since $h=(3,-1,-1,-1)$ has pair-max $2$ against entry-max $3$ | v21 raised as a gap; **v19 and v20 independently derived the same proof from tracelessness** |
| **F4** | **The "even split is not the minimiser" clause overreaches.** *Settled inline by the round rather than adjudicated*: $m^2-8m+8<0$ holds to $m=6$ and fails at $m=7$, so **v21's $m\le6$ is right and v19's $m=5,6,7$ miscounts**; v20's $m=8$ uses a different witness and is not a contradiction | v19, v20, v21, disagreeing |
| **F5** | **The $n$-form does not transport off $n=2m$.** $a_0=\sqrt{2n/(n-2)}$ equals $1/\sqrt{m-1}$ only at the balanced product; the lemma states $n=2m$, so what is refuted is the transported constant, not the lemma | v20 |
| **F6** | **The r448/r449 "contradiction" the entry records is not one.** $1/(m-1)$ is a proven floor and $\approx\sqrt2/m$ an attained value; they bracket a single infimum | v20, v21 |

### The two downstream questions the brief asked

- **$\lVert H_s\rVert_{op}\le a_0n^{-1/2}$ with $a_0=\sqrt{2n/(n-2)}$**, **given exactly and sharply**, all three agreeing. $a_0n^{-1/2}=1/\sqrt{m-1}$, and the supremum is *attained*, so it cannot be improved. **The constant every later round leaned on is sound.**
- **The joint two-copy application**, **gives less**, all three agreeing. Conclusion safe, argument owed; that is F1.

### Confirmed, and recorded because a pass means what it enumerates

The eigenvalue list and $\alpha=\tfrac{m-2}{2(m-1)}$, $\beta=\tfrac m{2(m-1)}$, rebuilt from $\mathrm{Ric}(A\owedge B)$ and the Weyl projection; $\lVert H\rVert_F^2=\tfrac{m(m-2)}{2(m-1)}\lVert h\rVert^2$ exactly; the supremum $1/\sqrt{m-1}$ attained at $h^\star=(1,1,-\tfrac2{m-2},\dots)$; the range $[\Theta(n^{-1}),\Theta(n^{-1/2})]$ at both ends; and $\lambda_m>\mu\iff m\ge5$ with $m=4$ an exact tie. **Two verifiers pinned the Frobenius convention independently**, by the lemma's own identity and by recomputing [L145](../findings/second-order.md)'s $g_n$, *a factor $2$ there would have moved the supremum by $\sqrt2$ and broken $a_0$.*

## Adjudications

**None dispatched.** F1, F2, F3 and F6 are unanimous or carry closed-form witnesses the round reproduced; F4 was settled inline by derivation, which the skill permits; F5 concerns a transported constant rather than the lemma. *Phase 3 exists to stop a deletion resting on one reader, nothing here is deleted on one reader's word.*

## Outcome

**Verdict: `PROVEN, hypotheses corrected`.** Unanimous. **Nothing was deleted; four things were written in.**

| written in | why |
|---|---|
| **$m\ge3$ and "a *single* $h$"** in the statement | at $m=2$ the Weyl image vanishes and the supremum is over the empty set; without "single", the equality clause is false |
| **the in-block dominance argument** | asserted without proof since the lemma was written; tracelessness gives $\max_{a\ne a'}\lvert h_a+h_{a'}\rvert\ge\tfrac{m-2}{m-1}\max_a\lvert h_a\rvert$, and $\beta/\alpha=\tfrac m{m-2}$ covers it |
| **the two-copy clause** | the equality is false on the joint eigenspace, by two closed-form witnesses; the supremum is unchanged, and the line licensing [L149](../findings/second-order.md)'s use now lives here rather than being assumed |
| **the minimiser's true scope, and that r448/r449 never disagreed** | the even split is beaten only to $m=6$; the two "conflicting" lower bounds bracket one infimum |

**Impact: `CONTAINED`.** The supremum $1/\sqrt{m-1}$, the constant [L149](../findings/second-order.md), [L157](../findings/second-order.md) and [L158](../findings/second-order.md) all take from here as $a_0n^{-1/2}$, **is given exactly, sharply and attained**, so every downstream use survives untouched. *No dependent is `NARROWED` or `UNSUPPORTED`.*

**What this round says about the chain.** Two rounds found the proof failing to prove a true statement; this one found a true statement with a true proof whose **hypotheses and scope were unwritten**. *Both are the same defect seen from opposite sides (the entry says less than it means, or more) and neither is visible to a check that reads only the conclusion.*

**The corrected text is unaudited** and re-enters the queue, per the rule that a repair is a new result its author does not bless.
