# ROUND L148-r2, the corrected text, read cold

**Id:** L148-r2. **Source:** [findings/second-order.md](../findings/second-order.md):1189–1202. **Date:** 2026-09-05. **Verifiers allocated:** v51, v52, v53. **Phase:** 1, dispatched.

**Why this id.** L148's original text was audited and repaired. **The repair itself has never been read**, and [ROUND_L145](ROUND_L145.md) established that the corrected texts of L146–L149 are where the block's surviving lower bound actually rests, *not the polish they were queued as.*

**A repair is a new result.** It was written by the loop that found the defect, under the pressure of a finding, and it entered the record without a fresh set of cold readers. **This round supplies them, and the verifiers are not told which passages are new.**

**Pre-registered questions.** *(Questions, not verdicts. No adjudication has run on either.)*

1. **Does the entry's scope match what its neighbours take from it?** The block's entries have carried three different dimension floors (none, $m\ge3$, $m\ge6$) and one of them was propagated from an entry that stated none at all. **Check what floor this entry states, what its proof needs, and what its consumers assume.**
2. **Is the vanishing identical, or identical on a subspace?** The heading says *"vanishes identically on the margin summand"*. **A claim of exact vanishing is either an algebraic identity or it is a bound; say which this is, and on precisely which subspace it holds.**

## The brief as dispatched

*Provenance stripped, mathematics verbatim. The text carries repairs, and which passages those are is deliberately not marked.*

#### Lemma L148, the defect vanishes identically on the margin summand

> **HYPOTHESES AND SCOPE, WRITTEN IN AFTER a prior round.** *Base point $W^*=S^m\times S^m$, $n=2m$, $m\ge3$, and $m\ge5$ for the word "margin" in the title, since $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}$ ties at $m=4$ and at $m=3$ the margin sits on $\Lambda^2\!\otimes\!\Lambda^2$ instead.* **The frame is chosen after $H$**: "$W^*$ and $H$ simultaneously diagonal on coordinate $2$-planes" is **false in a fixed frame**, $h_{12}=1$ gives $H_{1424}=\alpha h_{12}\ne0$ at every $m\ge3$, and true per direction, by $W^*$'s $O(m)\times O(m)$-invariance together with $O(n)$-equivariance of $\mathrm{Alt}$ and $x\mapsto x_-$. *That sentence was absent.* **And the vanishing holds on both $S^2_0(\mathbb R^m)$ copies**, $h$ on $V_1$ and $k$ on $V_2$ diagonalising in one frame, *written singular, used plural by every citation, which is the slip that cost [L149](../findings/second-order.md#lemma-l149-no-direction-is-both-low-margin-and-high-operator-norm-so-the-bound-is-uniform) a factor of $n$.*
>
> **WHAT IS ABSENT AT $w=0$ IS THE TWO DEFECT *TERMS*, NOT TWO BRANCHES.** Branch 1 is present there and equals $c_p/S\le3/(n-2)$, *it is the branch that proves the route's $\Theta(n^{-1})$ ceiling.* Only branch 2 goes unbounded.
>
> **The conclusion is wider than the entry claims**: $\mathrm{Alt}(W(t)_-)=0$ for **every real $t$**, past every eigenvalue crossing, using no spectral gap, no analyticity, no $\ker W^*=0$ and no $n\ge12$, *so this is the one link in the tube chain that survives a kernel, and it asserts nothing at $W_{\mathbb{CP}^2}$, whose $\delta^2=\tfrac19\ne0$ shows contrapositively that it is coordinate-diagonal in no frame.*

*Found by a prior review while attacking [Lemma L147](../findings/second-order.md#lemma-l147-the-tube-radius-tracks-suplvert-prvert-on-betain0tfrac12-and-the-route-ends-at-thetan-1). *

> **LEMMA L148.** *For $H$ in $S^2_0(\mathbb R^m)$ at $W^*$, the tensors $W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes, hence so is $W(t)=W^*+tH$ and so is $W(t)_-$. Therefore $\mathrm{Alt}(W(t)_-)=0$ for every $t$: **the defect is identically zero along the whole segment**, and both defect branches are absent there.*

> **THIS IS STRONGER THAN [LEMMA L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) AND IT DISPLACES IT.** *A bound on $\lVert A''\rVert$ over a summand where $A\equiv0$ prices a quantity that is not there.* **The question lives on the mixed directions**, which neither L146 nor L147 prices, and which is where a successor must work.

## Phase 1, returns

- **v53** · `PROVEN, hypotheses corrected` · [VERIFY_v53.md](VERIFY_v53.md). *"The vanishing is a correct exact algebraic identity and is stronger than the title suggests, but the repair was written into the scope box and applied nowhere else."*

**Question 2 answered: an exact algebraic identity, on a subspace.** $\mathrm{Alt}(W(t)_-)=0$ is zero rather than an estimate ($W(t)_-$ has no four-distinct-index component at all) and the subspace is the joint $\lambda_m$-eigenspace, **both** $S^2_0(\mathbb R^m)$ copies, of dimension $(m+2)(m-1)=\Theta(n^2)$; in $t$ it is the whole real line.

**Question 1 answered: the floors nest correctly and this entry propagated none.** *It states $m\ge3$ for the setting and $m\ge5$ for the word "margin"; its proof needs no floor beyond $H\ne0$; its consumers assume strictly more.* **The real mismatch is the summand count rather than the dimension.**

### The repair that stopped inside its own entry

**F1.** *The boxed LEMMA at [line 1199](../findings/second-order.md) says "both defect branches are absent there". The scope box at [line 1193](../findings/second-order.md) (six lines above), says **in capitals** that this is wrong and branch 1 is present.* **At $n=12$ with $S=\theta_0=\sqrt{55}/6$, branch 1 at $w=0$ is exactly $\tfrac3{10}$, finite and positive.** *The refuted clause is carried unmarked at [plan.md](../plan.md):114, its only downstream copy.*

**F2.** *The boxed statement quantifies over **one** $S^2_0$ copy, while [L149](../findings/second-order.md), [L157](../findings/second-order.md) and [L158](../findings/second-order.md) all read $w=0$ as the joint two-copy eigenspace.* **The two-copy version is correct (v53 verified it independently) and it lives only in the scope box.**

*This is the pattern the block has shown five times, at its smallest scale yet: **a correction written in one passage and not in the passage it corrects, six lines apart, inside a single entry.***

**Also.** The fixed-frame witness carries a coefficient right only at $m=3$, at $m\ge4$ index 4 sits in $B_1$ and the component is $-\beta h_{12}$, *the non-vanishing it supports surviving either way*. At $m=3$ the base point is [L27](../findings/nondegeneracy.md)'s **excluded degenerate** $(3,3)$, where the margin collapses rather than relocates. **And [results.md](../results.md) has no canonical L148 while [L157](../results.md)'s canon text already asserts L148's content, uncited and with no hypotheses a reader can check.**

**Held for v51 and v52.**

- **v51** · `GAP` · [VERIFY_v51.md](VERIFY_v51.md). *"The repairs were written into boxes and never folded into the canonical LEMMA line, which still carries a clause the entry itself refutes and a singular quantifier the entry itself widens."* **F1 and F2 independently confirmed**, and v51 quantifies F2's cost: *the consumer at [L149](../findings/second-order.md):1224 still cites "the named copy" while L149:1211 and :1253 both need the plural*, **which is the factor of $n$ the scope box itself blames.** It also reproduces the identity's reason in the same terms: $\mathrm{Alt}$ lands in $\Lambda^4$, whose components need four distinct indices, and a coordinate-diagonal operator has none.

### F4, a real-to-complex gap neither other reader raised

**L148 proves the vanishing for *real* $t$ and explicitly disclaims analyticity. [L147](../findings/second-order.md):1181 converts it into $\lVert A''\rVert=0$, which is a Cauchy estimate over a *complex* disc.** *v51 notes two one-line closures exist and that neither is on the record.* **This is `HYPOTHESIS-DEBT`, and it is the kind of gap a per-lemma round cannot see**, each entry is right about its own domain and the join between them is where the claim changes character.

**On the index.** [INDEX-results.md](../findings/INDEX-results.md) row 148 reproduces all three box corrections faithfully **and records neither the $m\ge3$ floor nor the $m\ge5$ caveat**, *the exact propagation route [second-order.md](../findings/second-order.md):1106 records for this block's previous floor error.*

- **v52** · `PROVEN, hypotheses corrected`, two clauses refuted · [VERIFY_v52.md](VERIFY_v52.md). Third independent agreement on the identity and on F1 and F2, and it sharpens the subspace: **$\Sigma$ equals the full $\lambda_m$-eigenspace only for $m\ge5$**, at $m=4$ the eigenspace strictly contains it, picking up $\Lambda^2\otimes\Lambda^2$, and at $m=3$ the margin is exactly zero, $\mu=\tfrac12$ tying the orbit at [L27](../findings/nondegeneracy.md)'s degenerate $S^3\times S^3$. *It also finds three files in two states on whether this entry's Gate 2 was discharged.*

## Phase 5, the round's verdict

**`PROVEN, hypotheses corrected`. Impact: `CONTAINED`.** Applied in [079222af](../findings/second-order.md).

**The mathematics was never in doubt and all three readers strengthened it.** The vanishing is an exact algebraic identity on $W^*+\Sigma$, using no gap, no analyticity, no $\ker W^*=0$ and no smallness of $t$, *wider than the entry claimed.*

### What the round was queued to test, and the answer

**A repair is a new result, and this one entered the record beside the sentence it repaired rather than inside it.** *Three corrections (both copies, the frame chosen after $H$, the $m\ge3$ floor), were written into the boxes around the boxed LEMMA and never into it.* **So every citation of the statement inherited a singular copy, a fixed frame, no floor, and a "both branches are absent" clause that the scope box four lines above denied in capitals.** *One consumer still cites "the named copy" while two other lines of the same consumer need the plural, which is the factor of $n$ the scope box itself blames.*

**That is this block's recurring failure at its smallest scale**: a correction written four lines from the text it corrects, inside one entry, surviving a full audit of that entry because the audit read the boxes it had just written.

### Owed, and not applied here

- **The real-to-complex debt.** One reader alone: the identity is proved for real $t$ and [L147](../findings/second-order.md) consumes it over a complex disc. **Recorded in the entry as `HYPOTHESIS-DEBT`**, conservative, since recording a debt cannot overstate a bound.
- **"It displaces L146"**, which one reader refutes on the ground that L149 consumes L146's envelope and $a_0$ at every $w$, not only at $w=0$. **The round could not locate that sentence in the current text** and does not act on an unlocated quotation.
- **[plan.md](../plan.md):114 carries the refuted "both branches absent" clause**, its only downstream copy. *This loop does not write there.*
