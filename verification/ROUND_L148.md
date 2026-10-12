# ROUND L148, the defect vanishing identically on the margin summand

**Id** L148 · **File** [findings/second-order.md](../findings/second-order.md), lines **1183–1190** · **Opened** 2026-09-05

**Verifiers allocated:** v25, v26, v27. **Phase:** 1, dispatched.

**Why this id.** Tier C. **It has never had a Gate 2 at all**, the debt is recorded against it in both [findings/INDEX-results.md](../findings/INDEX-results.md) and [findings/LEDGER.md](../findings/LEDGER.md), *and two rounds have already leaned on it*: [ROUND_L147](ROUND_L147.md) used it to falsify L147's reason (b), and to withdraw [ROUND_L149](ROUND_L149.md)'s F12 on the ground that it forces $a=0$ on both $S^2_0$ copies. **Both of those now rest on an unaudited lemma.**

**Canonical cross-check.** [results.md](../results.md) carries no L148 entry.

**Two pre-registered questions, carried in as questions and not verdicts.** Does the lemma give $a=0$ on **both** $S^2_0(\mathbb R^m)$ copies, or one? And does *"identically"* mean for every $t$, or for every direction in the summand?

## The brief as dispatched

**Provenance stripped, mathematics verbatim**, per the independence rule.

```
#### Lemma L148, the defect vanishes identically on the margin summand

*Found by a prior review while attacking [Lemma L147](../findings/second-order.md#lemma-l147-the-tube-radius-tracks-suplvert-prvert-on-betain0tfrac12-and-the-route-ends-at-thetan-1). *

> **LEMMA L148.** *For $H$ in $S^2_0(\mathbb R^m)$ at $W^*$, the tensors $W^*$ and $H$ are simultaneously diagonal on coordinate $2$-planes, hence so is $W(t)=W^*+tH$ and so is $W(t)_-$. Therefore $\mathrm{Alt}(W(t)_-)=0$ for every $t$: **the defect is identically zero along the whole segment**, and both defect branches are absent there.*

> **THIS IS STRONGER THAN [LEMMA L146](../findings/second-order.md#lemma-l146-the-operator-norm-on-the-margin-summand-and-the-direction-blind-radius-it-corrects) AND IT DISPLACES IT.** *A bound on $\lVert A''\rVert$ over a summand where $A\equiv0$ prices a quantity that is not there.* **The question lives on the mixed directions**, which neither L146 nor L147 prices, and which is where a successor must work.

```

## Clustering and outcome

**v25 and v26 `PROVEN, hypotheses corrected`, v27 `GAP`.** *The split is over whether an absent one-sentence repair counts as a gap; all three confirm the mathematics.* **Reconciled verdict: `PROVEN, hypotheses corrected`, the premise repair recorded as owed.**

| # | finding | support |
|---|---|---|
| **F1** | **The premise is false in a fixed frame.** $h_{12}=1$ gives $H_{1424}=\alpha h_{12}\ne0$ at every $m\ge3$. True per direction, by $W^*$'s $O(m)\times O(m)$-invariance and $O(n)$-equivariance of $\mathrm{Alt}$ and $x\mapsto x_-$, **that sentence was nowhere on file** | v25, v26, v27 |
| **F2** | **One copy written, both needed.** All three downstream uses quantify over a $\Theta(n^2)$-dimensional joint space. *The same singular/plural slip that cost [L149](../findings/second-order.md) a factor of $n$* | v25, v26, v27 |
| **F3** | **"Both defect branches are absent there" is false of branch 1**, which is present at $w=0$, equals $c_p/S$, and is the branch proving the $\Theta(n^{-1})$ ceiling. Repair is one word: *terms*, not *branches* | v25, v26, v27 |
| **F4** | **Four hypotheses omitted**, one load-bearing for the title: $m\ge5$, since $\lambda_m-\mu=\tfrac{m-4}{2(m-1)}$ ties at $m=4$ | v25, v26, v27 |
| **F5** | **The conclusion is wider than claimed**, every real $t$, past every crossing, with no gap, no analyticity, no $\ker W^*=0$, no $n\ge12$ | v25, v26, v27 |

### The finding that reaches back into a closed round

**Downstream use (a) is half-supported, and [ROUND_L147](ROUND_L147.md) drew the wrong conclusion from it.** L148 pins the **variable** $u$ to zero on the named copy; it does **not** set the **coefficient** $a$ to zero. At $u=0$ with $a>0$, $f'(0)<0$, so $w=0$ is where branch 1 is **largest**, not smallest. *[ROUND_L147](ROUND_L147.md) withdrew [ROUND_L149](ROUND_L149.md)'s F12 on the contrary reading; **that withdrawal is retracted and F12 stands.*** **All three verifiers reach this independently.**

**No adjudicators dispatched:** every finding is unanimous and carries a closed-form witness the round reproduced.

**Impact: `CONTAINED`.** The vanishing is real and stronger than stated; what was wrong was a premise, a scope and a word. *Downstream use (b) survives given F2; use (a) survives only at $w=0$, not as L149's comparison across $w$.*

**$W_{\mathbb{CP}^2}$, the kernel witness:** L148 asserts nothing there, and its $\delta^2=\tfrac19\ne0$ shows contrapositively that it is coordinate-diagonal in no frame, *so the hypothesis is not vacuous, and this is the one link in the chain a kernel cannot reach.*
