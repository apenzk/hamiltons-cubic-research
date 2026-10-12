# Review r694, Lemma L108, the Cauchy–Schwarz bound $\theta\le\tfrac12\sqrt{(n-1)G_2}$

*Reviewer B of a Gate 2 pair on identical briefs; the twin took r693. Derived cold from [conventions.md](../findings/conventions.md) and the definitions, not from the block's reasoning. **Analysis only**, no computation was run, and none was needed: every number below is reproduced by hand.*

## Verdict: GAP

**The boxed inequality is CONFIRMED** and both pinned moments are re-derived below from (A), (B) and the cubic identity, **with no criticality**. **The equality clause inside the same box is REFUTED as an "iff"**, $-W$ at the balanced sphere product is a critical point at which $\lambda_k$ *is* constant on $\operatorname{supp}(g)$ and the displayed inequality is *strict*. **And "the first legal bound" is false as chronology**: the bound this file calls [L107](../findings/bounds.md) was on the record seven hours earlier, and the moment class L108 lives in collapses onto exactly L107, a result the same file states twice, below, without a back-link.

**Plainly, as the brief asks:** as an upper bound on $\theta$, L108 is *weaker than L107*, vacuous on its own, and closed only through an input that returns L107 exactly. It is live only in the other direction, as the lower edge $G_2\ge4\theta^2/(n-1)$ on the free invariant.

---

## 0. Readings adopted, and the two symbols the conventions file does not carry

| symbol | reading adopted | source |
| --- | --- | --- |
| $\theta$ | $P(W)/\lVert W\rVert^3$; **no positivity assumed**, since neither [conventions.md](../findings/conventions.md) nor the block assumes any | [conventions.md](../findings/conventions.md) |
| $\lVert W\rVert$ | $\sum_k\lambda_k^2=\operatorname{tr}(W^2)=1$, the $\Lambda^2$ half-trace pairing | [conventions.md](../findings/conventions.md), "Norms and pairings" |
| $T_{abc}$ | $c_{abc}^2$, totally symmetric, vanishing on repeated indices, **ordered slots** | [conventions.md](../findings/conventions.md), "Structure constants" |
| $g_k$ | $\lVert[\operatorname{ad}(v_k),W]\rVert_F^2=\sum_{\alpha\beta}(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$, ordered $(\alpha,\beta)$, at an orthonormal **eigenbasis** $\{v_k\}$ of $W$ on $\mathfrak{so}(n)\cong\Lambda^2$ | [bounds.md](../findings/bounds.md), L107's block, **not in conventions.md** |
| $G_2$ | $\sum_k\lambda_k^2g_k$, the second $\lambda$-moment of $\mu=\sum_kg_k\delta_{\lambda_k}$ | [bounds.md](../findings/bounds.md), "The first free invariant", **not in conventions.md** |

**Neither $g_k$ nor $G_2$ is tabled**, as the brief anticipated, and both carry real trouble.

- **$g_k$ has two definitions in this file and they are not interchangeable.** The block *above* L108 introduces it as $g_k=2R_k-4\lambda_k(\theta-\lambda_k)$ with $R_k=\sum\lambda_\alpha^2T_{k\alpha\beta}$, a form that has **already consumed (C)**, hence criticality. The basis-free form $g_k=\lVert[\operatorname{ad}(v_k),W]\rVert^2$ appears only in [L107](../findings/bounds.md)'s block, **eighty lines below L108**. The two agree at a critical point and only there, and the choice decides L108's scope (§5). *A reader who takes the definition nearest to L108 gets the wrong quantifier.*
- **$g_k$ needs $\{v_k\}$ to be an eigenbasis** and the block never says so. Contrast $S_{22}$ eleven lines above, whose display correctly advertises "for any orthonormal basis".
- **$G_2$ collides with the exceptional group and the real Grassmannian** $G_2(\mathbb R^k)$ used throughout [target.md](../findings/target.md) and [INDEX-values.md](../findings/INDEX-values.md). Same class as the $B$, $M$, $\mu$, $\Pi$ collisions this record already tables; this one is untabled.

## 1. The derivation, cold

Write $m_j=\sum_k\lambda_k^jg_k=\sum_{k\alpha\beta}\lambda_k^j(\lambda_\alpha-\lambda_\beta)^2T_{k\alpha\beta}$. **Positivity** is free: in the eigenbasis $[\operatorname{ad}(v_k),W]_{\alpha\beta}=c_{k\beta\alpha}(\lambda_\beta-\lambda_\alpha)$, so $g_k$ is a Frobenius norm-square and $g_k\ge0$ at every $W$, critical or not.

**$m_0=4(n-1)$.** Expand $(\lambda_\alpha-\lambda_\beta)^2$ and use total symmetry of $T$ to relabel:

$$m_0=2\sum_{k\alpha\beta}\lambda_k^2T_{k\alpha\beta}-2\sum_{k\alpha\beta}\lambda_\alpha\lambda_\beta T_{k\alpha\beta}.$$

Relation **(A)** $\sum_{\alpha\beta}T_{k\alpha\beta}=2(n-2)$ gives the first term $2\cdot2(n-2)\sum_k\lambda_k^2=4(n-2)$ at unit norm. Relation **(B)** $\sum_{\beta\gamma}\lambda_\beta T_{k\beta\gamma}=-2\lambda_k$, contracted against $\lambda_k$, gives $\sum\lambda_k\lambda_\beta T=-2\sum\lambda_k^2=-2$, and the second sum equals it after relabelling. So $m_0=4(n-2)+4=4(n-1)$. ✔

**$m_1=-4\theta$.**

$$m_1=2\sum_{k\alpha\beta}\lambda_k\lambda_\alpha^2T_{k\alpha\beta}-2\sum_{k\alpha\beta}\lambda_k\lambda_\alpha\lambda_\beta T_{k\alpha\beta}.$$

The first is (B) with weight $f=\lambda^2$ after relabelling: $-2\operatorname{tr}W^3$. The second is the $\{1,1,1\}$ contraction, and **it is supplied by the cubic identity** $\theta=\operatorname{tr}W^3+\tfrac12\sum_{abc}\lambda_a\lambda_b\lambda_cT_{abc}$, i.e. $\sum\lambda_a\lambda_b\lambda_cT=2\theta-2\operatorname{tr}W^3$, at unit norm. Hence $m_1=-4\operatorname{tr}W^3-2(2\theta-2\operatorname{tr}W^3)=-4\theta$. ✔

**Cauchy–Schwarz.** With weights $g_k\ge0$, $\big(\sum g_k\lambda_k\cdot1\big)^2\le\big(\sum g_k\lambda_k^2\big)\big(\sum g_k\big)$, i.e. $16\theta^2\le4(n-1)G_2$, so

$$\lvert\theta\rvert\le\tfrac12\sqrt{(n-1)G_2}. \qquad ✔$$

**Hypotheses consumed, exhaustively.** $W\in\mathcal W_n$, Ricci-flatness *and* first Bianchi, which is what (B) costs (the record's own [r331](REVIEW_r331.md) Q1: Ricci-flatness alone does not give it); the Killing normalisation behind (A); $\lVert W\rVert=1$, twice over, in $m_0$'s $4(n-1)\lVert W\rVert^2$ and in $\theta=P(W)$; and total symmetry of $T$, without which neither relabelling runs. **Trace-freeness enters only through Weyl membership** (L108 never needs $\lambda_{\min}<0<\lambda_{\max}$, which is where L107's derivation does need it). **Criticality is NOT consumed, and neither is relation (C).** This matches the companion audit the brief cites, and I reached it independently: (C) is the diagonal of $Q(W)=\theta W$, and the only place it could enter (the $\{1,1,1\}$ moment), is covered by the cubic identity, which is an identity on all of $\mathcal W_n$.

*Where (C) genuinely does enter is the neighbouring conversion $S_{22}=2\theta\operatorname{tr}W^3-2\operatorname{tr}W^4+\tfrac12G_2$: expanding $G_2$ gives $2\{2,2,0\}-2\{2,1,1\}$, and $\{2,1,1\}=2\theta\operatorname{tr}W^3-2\operatorname{tr}W^4$ is (C) with $f=\lambda^2$. **That display is CONFIRMED**, and its "at a critical point" hedge is correctly placed, it is the one line in the section that needs it.*

## 2. The constant and the direction, the $\tfrac12$ is convention-dependent, and it is tabled nowhere

**The $(n-1)$ is convention-free; the $\tfrac12$ is not.** Suppose the moments read $m_0=c(n-1)$ and $m_1=-c\theta$ for a common convention constant $c$. Cauchy–Schwarz then gives $c^2\theta^2\le G_2\cdot c(n-1)$, i.e.

$$\lvert\theta\rvert\le\sqrt{\tfrac{(n-1)G_2}{c}},\qquad\text{so the prefactor is exactly }c^{-1/2}.$$

The record's $c=4$ is $2\times2$: an outer $2$ from symmetrising the two squares in $(\lambda_\alpha-\lambda_\beta)^2$, which is combinatorial and fixed; and an inner $2$ carried identically by (A)'s $2(n-2)$ and (B)'s $-2\lambda_k$, which is **the ordered-slot reading together with Hamilton's $\tfrac12$ in $\#$**, the single $2$ that [L113](../findings/bounds.md)'s audit traced and found tabled in no file. Under the unordered reading (A) and (B) lose it, $c=2$, and the constant becomes $1/\sqrt2$.

**So the answer to the brief's question is yes, on both counts, and the block states neither.** What rescues it is that $g_k=\lVert[\operatorname{ad}(v_k),W]\rVert_F^2$ *forces* the ordered reading (a Frobenius norm sums over all ordered index pairs) so the displayed $\tfrac12$ is the right number for the record's own definition of $g$. The dependence is real but discharged; what is owed is one clause saying so, since the same $2$ has already cost this record a dispute.

**Direction.** The proof gives the two-sided $\lvert\theta\rvert\le\tfrac12\sqrt{(n-1)G_2}$ for free. The block states the one-sided form, which is weaker and (see §3), is what breaks its own equality clause. *The sign-free form is already on the record fourteen lines below, as "$m_2\ge m_1^2/m_0=4\theta^2/(n-1)$", where it is correct.*

## 3. The equality case, the "iff" is REFUTED in one direction

**Forward direction ✔.** Equality in the weighted Cauchy–Schwarz forces $(\sqrt{g_k}\lambda_k)\parallel(\sqrt{g_k})$, i.e. $\lambda_k$ constant on $\operatorname{supp}(g)$. The degenerate case is excluded because $m_0=4(n-1)>0$, so $\operatorname{supp}(g)\ne\emptyset$.

**Converse ✘.** Constancy gives equality in *Cauchy–Schwarz*, hence $\tfrac12\sqrt{(n-1)G_2}=\lvert\theta\rvert$, which equals $\theta$ only when $\theta\ge0$. **A counterexample, on the record's own extremal point and needing no computation:**

- $Q$ is a **homogeneous quadratic map** ([conventions.md](../findings/conventions.md) says so, and $X\#X$ is bilinear symmetric), so $Q(-W)=Q(W)$. Hence if $Q(W)=\theta W$ then $Q(-W)=(-\theta)(-W)$: **$-W$ is a critical point with parameter $-\theta$**, and $\mathcal W_n$ is a linear space so $-W$ lies in it.
- $g_k$ depends on $\lambda$ only through $(\lambda_\alpha-\lambda_\beta)^2$, so $g$, $\operatorname{supp}(g)$ and $G_2$ are **unchanged** under $W\mapsto-W$.
- Take $W$ the balanced sphere product at even $n$. There $\operatorname{supp}(g)=E_{\min}$ and $\lambda\equiv\lambda_{\min}$ on it (§5 proves this by hand). At $-W$: $\lambda\equiv\lvert\lambda_{\min}\rvert$ on the same support (**still constant**) while $\theta=-\theta_0(n)<0$ and the right-hand side is $+\theta_0(n)$. **Strict.**

So constancy on $\operatorname{supp}(g)$ does **not** imply equality in the boxed display. **Repair, one character wide:** box $\lvert\theta\rvert\le\tfrac12\sqrt{(n-1)G_2}$, or append "and $\theta\ge0$" to the clause. This is the brief's pattern exactly, an equality clause asserted from the tight step of one inequality without checking that the chain it sits in is tight in the same direction.

**Is it attained?** Yes, and by more points than the block claims. Let $W$ be $\operatorname{Ad}(SO(p)\times SO(q))$-invariant with $\mathfrak h=\Lambda^2V_p\oplus\Lambda^2V_q$ and the mixed block $\mathfrak m=V_p\otimes V_q$ a single eigenvalue, the shape of every $S^p\times S^q$. Since $(\mathfrak{so}(n),\mathfrak h)$ is a **symmetric pair**, $[\mathfrak h,\mathfrak h]\subseteq\mathfrak h$, $[\mathfrak m,\mathfrak m]\subseteq\mathfrak h$, $[\mathfrak h,\mathfrak m]\subseteq\mathfrak m$, and $[\Lambda^2V_p,\Lambda^2V_q]=0$. Then:

- for $k\in\mathfrak h$, every non-vanishing $T_{k\alpha\beta}$ has $\alpha,\beta$ **both** in $\mathfrak m$, or both in the same simple factor of $\mathfrak h$, in either case $\lambda_\alpha=\lambda_\beta$, so $g_k=0$;
- for $k\in\mathfrak m$, exactly one of $\alpha,\beta$ lies in $\mathfrak h$, and $\lambda_k=\lambda_{\mathfrak m}$.

**So $\operatorname{supp}(g)\subseteq\mathfrak m$, a single eigenlevel, and equality holds, at every sphere product, balanced or not, at both parities.** *Cross-check against the record's own numbers*: at the balanced split, $g_k=2(n-2)(\lambda_{\max}-\lambda_{\min})^2=4(2m-1)/m^2$ with $m=n/2$, which is exactly [L70](../findings/bounds.md)'s $g_v=16(n-1)/n^2$; and $\dim\mathfrak m\cdot g_k=m^2\cdot4(2m-1)/m^2=4(n-1)=m_0$ ✔.

**That is a substantive deflation of the block's own boast.** "*It is exact at the balanced product*" is true but understates its own problem: the bound is exact on the *whole* product family, where $\theta$ runs far below $\Theta_n$. **Its equality set does not single out the maximiser at all**, it is in the non-separating class the record already identified for the $\lambda$-weighted bound, and precisely the class [L70](../findings/bounds.md)'s equality case was celebrated for escaping. The block reaches "discriminates nothing there" by a different and weaker route (r332's pinning), and never says the equality family is this large.

**And the sentence after it is self-refuting.** "*The first bound on the record that is both sharp at the extremum and built from a quantity the spectrum does not determine*" contradicts the clause immediately preceding it: at the balanced product the spectrum has two eigenvalues, so $\{2,2,0\}$ collapses through the minimal polynomial and $G_2$ **is** spectrum-determined there. Sharp at the extremum and free at the extremum are mutually exclusive here, and the block asserts both in one line.

## 4. "The first legal bound", false as chronology, undefined as a term, and dominated by its own file

**"Legal" is never defined in the block.** Read through [post F42](../findings/fence-posts.md) it means "the lever's weight pattern is not pinned", and under that reading the claim is *sound*: $G_2=2\{2,2,0\}-2\{2,1,1\}$ carries a genuine $\{2,2,0\}$ part, which no combination of (A), (B), (C) with polynomial weights reaches. **But the gate itself has moved and the block does not say so.** F42's conclusion "*is WITHDRAWN in both directions*", and its **positive half ("use a $\{2,2,0\}$ moment or higher"), is withdrawn too**, precisely because the pattern is spectrum-determined at the balanced product. So "*it passes every gate the record now has*" is passing a gate that no longer stands where the block thinks it does. F42's *restated* rule is the live one: **name the lever's pattern *and* the constraint set**. L108's constraint set is $g\ge0$ plus (A) and (B) (nothing stronger) which is exactly the set §4's collapse is about.

**"First" is false as chronology.** `git log -S`, on 2026-09-01:

| time | commit | what |
| --- | --- | --- |
| 15:06 | [70bd6e16](../findings/fence-posts.md) | $\theta\le(n-1)\lvert\lambda_{\min}\rvert$ enters the record, the inequality now numbered [L107](../findings/bounds.md) |
| 19:27 | 14bd631b | [L70](../findings/bounds.md), the deficiency identity |
| **22:12** | **a60ced04** | **this block, claiming "the first legal bound"** |
| 22:14 | 71d6d76a | "the $g$-moment problem closes, **collapsing exactly to the $\Pi$-bound**" |

**The self-historical claim was two minutes ahead of its own refutation**, and seven hours behind the bound it is weaker than. *This is the brief's "stale within the hour" pattern, at two-minute resolution.*

**Is it still the weakest of the record's standing bounds? As a bound on $\theta$, yes, it is not a bound on $\theta$ at all.**

- L70 gives $\theta\le\lambda_{\min}+(n-2)\lambda_{\max}$; L107 gives $\theta\le(n-1)\lvert\lambda_{\min}\rvert$. Both are numbers once the spectrum is known.
- L108's right-hand side contains the free $G_2$, so **alone it bounds nothing.** Supplying the only upper bound on $G_2$ its own class offers, the support/chord inequality $m_2\le(\lambda_{\min}+\lambda_{\max})m_1-\lambda_{\min}\lambda_{\max}m_0$, returns, after the discriminant telescopes, exactly $\theta\le(n-1)\lvert\lambda_{\min}\rvert$. Even the crude $G_2\le\max_k\lambda_k^2\cdot m_0$ returns $\theta\le(n-1)\max_k\lvert\lambda_k\rvert$, which is L107 or weaker.
- [r667](REVIEW_r667.md)/[r668](REVIEW_r668.md)'s theorem, recorded under [L113](../findings/bounds.md) thirty lines below, makes this exhaustive rather than anecdotal: $\{g\ge0,\ m_0=4(n-1),\ m_1=-4\theta\}$ is feasible **iff** $\theta\le(n-1)\lvert\lambda_{\min}\rvert$, so **the complete consequence of L108's constraint class is L107.**

**Does the record say so? Twice, in this file, below L108, and never at L108.** The "IT COLLAPSES EXACTLY TO THE $\Pi$-BOUND, ALREADY CLOSED" blockquote sits fifteen lines down, and L113's carries the completeness theorem. **L108's own heading, first sentence and index row are untouched by either.** The honest one-line entry the record is owed: *as an upper bound on $\theta$ it is dominated by L107; as a lower bound on the free invariant, $G_2\ge4\theta^2/(n-1)$, it is new and is the sharp lower edge of the realizable $(\theta,G_2)$ region.* The block's closing sentence, "*the surviving question is ... what realizability forbids for the pair $(G_2,\theta)$ jointly*", is the right frame and is buried under a headline that contradicts it.

## 5. Scope, the block states none, and the true one is wider than its neighbours' filing

**The block carries no quantifier at all.** It never says "at a critical point", never says "at unit norm", and the definition of $g_k$ nearest above it is the criticality-laden $2R_k-4\lambda_k(\theta-\lambda_k)$.

**The truth, from §1: the bound holds at every $W\in\mathcal W_n$ with $\lVert W\rVert=1$**, critical or not, identical to the quantifier [L107](../findings/bounds.md)'s block states explicitly, in the same file, for the twin inequality, citing the same $g$-route and the same three ingredients. *One block spells out that the $g$-route needs no criticality; the block eighty lines above it, which is nothing but the $g$-route, says nothing.*

**Unit norm is load-bearing and unstated.** Off unit norm the moments read $m_0=4(n-1)\lVert W\rVert^2$ and $m_1=-4P(W)$, and the display becomes $\theta\le\tfrac12\sqrt{(n-1)G_2}/\lVert W\rVert^2$. This is exactly the omission [r323](REVIEW_r323.md)/[r324](REVIEW_r324.md) propagated on [L70](../findings/bounds.md) and that L70's block now carries a repair for; **L108 repeats it two headings away.**

**Parity, against $\Theta_n$.** $\theta_0(n)$ is now fixed as the closed form alone, equal to the balanced-product value **at even $n$ only**, and the block's "exact at the balanced product" carries no parity qualifier, so it is silently an even-$n$ statement. At even $n$ I confirm the arithmetic by hand: the balanced split has $\hat\lambda_{\min}=-\tfrac1m\sqrt{\tfrac{m-1}{2m-1}}$ with $m=n/2$, so $(n-1)\lvert\hat\lambda_{\min}\rvert=\sqrt{(m-1)(2m-1)}/m=\theta_0(n)$ ✔, $G_2=4\theta_0^2/(n-1)$, and L108 is an equality. **At odd $n$ the bound is untouched (its proof is parity-blind) but the balanced split is not a Weyl operator there, and $\Theta_n<\theta_0(n)$.** What replaces it is §3's family: the equality case is attained at $S^p\times S^q$ at both parities, at points with $\theta$ well below $\Theta_n$. **So L108 is exact at the maximiser at even $n$, exact at non-maximisers at every $n$, and discriminates neither.**

**A separate scope trap, on the naive reduction.** The blockquote's arithmetic is right and I reproduce it by hand: at padded $W_{\mathbb{CP}^2}$, $\varepsilon=1/\sqrt6$ from $6\varepsilon^2=1$, the $E_{\min}$ mass is $4\theta/\lvert\lambda_{\min}\rvert=4\sqrt{3/2}\sqrt6=12$, so $G_2=12/6=2$ ✔, the bound reads $\tfrac12\sqrt{22}=2.345$ ✔ against $\theta=\sqrt{3/2}$, and the target $4\theta_0^2/(n-1)=8(n-2)/n^2=0.5\overline5$ at $n=12$ ✔. **The kernel is what breaks equality there**, $g$ charges $\ker W$ at $\lambda=0$ as well as $E_{\min}$, so $\lambda$ is not constant on $\operatorname{supp}(g)$, and the block says so correctly.

## 6. Duplication, and pointers

**Duplication, the bound is on the record twice, in this file, fourteen lines apart.** The moment-problem block states it as "*Cauchy–Schwarz (below): $m_2\ge m_1^2/m_0=4\theta^2/(n-1)$, the bound above*". That copy is **unnumbered, sign-free and correct**, where the numbered one is one-sided and carries the broken equality clause. *This is the fourth kind the brief names: the numbered block and its own consumer disagreeing, with the unnumbered copy the better of the two.* It is also the same shape as [L142](../findings/bounds.md), withdrawn for being one inequality recorded twice.

**Pointers, four broken in-file anchors in [bounds.md](../findings/bounds.md), two of them L108's own:**

| where | anchor | state |
| --- | --- | --- |
| L142's block | `[Lemma L108](#)` | **empty**, and it is the **only** pointer to L108 anywhere in the record |
| L142's block | `...thetale-n-1lvertlambda_minrvert-derived-twice` | stale; L107's heading no longer says "derived twice" |
| the moment-problem block | same `-derived-twice` anchor | stale |
| L104's citation | `#lemma-l104--the-value-type-reduction` | no such heading |

**And the index row.** [INDEX-results.md](../findings/INDEX-results.md) row **108** carries a bare statement and **no verdict marker at all** (no "Gate 2", no "no verdict") where 105, 106, 107, 109, 110, 111, 112, 113 and 114 all carry one. That silence is what hid this block from the sweeps, and it should be filled in whatever form the sweeps read. **L108 also appears nowhere in [results.md](../results.md)**, though [L107](../findings/bounds.md) and [L70](../findings/bounds.md) do.

## 7. What I recommend the record change

1. **Box the two-sided form** $\lvert\theta\rvert\le\tfrac12\sqrt{(n-1)G_2}$, and keep "equality iff $\lambda_k$ constant on $\operatorname{supp}(g)$" against it, the clause is then correct in both directions.
2. **State the quantifier**: every $W\in\mathcal W_n$ at $\lVert W\rVert=1$, criticality unused, exactly as [L107](../findings/bounds.md)'s block already states for the twin, and move the basis-free $g_k=\lVert[\operatorname{ad}(v_k),W]\rVert^2$ **above** L108, since the definition currently nearest it presupposes criticality.
3. **Retire "the first legal bound"** from the heading and the first sentence. The defensible claim is *the first bound whose lever is a free $\{2,2,0\}$ moment*; the chronological claim is false against [L107](../findings/bounds.md) by seven hours, and F42's positive half (the gate being passed), is withdrawn.
4. **Add one sentence on domination**, with a link to L113: *as an upper bound on $\theta$ this is dominated by [L107](../findings/bounds.md), which is the complete consequence of its constraint class; its live content is the lower edge $G_2\ge4\theta^2/(n-1)$.*
5. **Record the true equality family** (every $S^p\times S^q$, both parities, by the symmetric-pair mechanism of §3) and drop "the first bound both sharp at the extremum and built from a quantity the spectrum does not determine", which its own preceding clause refutes.
6. **Table $g_k$ and $G_2$ in [conventions.md](../findings/conventions.md)**, with the ordered-slot dependence of the $\tfrac12$ and the $G_2$/$G_2(\mathbb R^k)$ collision.
7. **Fix the four anchors** and **fill index row 108.**

*No computation was run. Every numerical value quoted above, $\theta_0(n)$ at the balanced split, $g_v=16(n-1)/n^2$, $G_2=2$ and $\tfrac12\sqrt{22}=2.345$ at padded $W_{\mathbb{CP}^2}$, $8(n-2)/n^2$ at $n=12$, was reproduced by hand from the definitions and agrees with the record.*
